"""
Validate every message in a session pcap against a folder of ICD-generated
Lua bus definitions.

Usage:
    python3 session_validate.py <lua_folder> <session.pcap> [--log out.log]

Faulty messages are aggregated by a "fault signature" (message name + the
set of fields that failed + why) rather than logged one line per packet:
if the same fault recurs across many packets, the log shows one entry
with an occurrence count, first/last-seen timestamps, and one example.
"""
import argparse
from collections import OrderedDict
import datetime

from decode import validate_payload
from lua_bridge import load_bus_folder
MAX_LOG_RUNS = 20

class FaultBucket:
    def __init__(self, signature, message, example_result, timestamp):
        self.signature = signature
        self.message = message
        self.count = 1
        self.first_seen = timestamp
        self.last_seen = timestamp
        self.example = example_result

    def bump(self, timestamp):
        self.count += 1
        self.last_seen = timestamp

    # note: __init__ already counts the first occurrence (count=1);
    # bump() is only called for the 2nd and later occurrences of the
    # same fault signature.


def fault_signature(result):
    """Group faults by *which fields failed and what kind of failure*,
    ignoring the exact value each time -- so the same recurring problem
    collapses into one log entry instead of one per packet."""
    msg = result["message"] or "UNKNOWN"
    field_sigs = []
    for field_name, reason in result["errors"]:
        # classify reason into a stable category so slightly different
        # values of the same kind of failure still collapse together
        if reason is None:
            category = "error"
        elif reason.startswith("expected constant"):
            category = "const_mismatch"
        elif reason.startswith("value") and "below min" in reason:
            category = "below_min"
        elif reason.startswith("value") and "above max" in reason:
            category = "above_max"
        elif reason.startswith("length mismatch"):
            category = "length_mismatch"
        elif reason.startswith("unrecognized message id"):
            category = "unrecognized_id"
        elif reason.startswith("ambiguous message id"):
            category = "ambiguous_id"
        elif reason.startswith("decode error"):
            category = "decode_error"
        elif reason.startswith("checksum mismatch"):
            category = "checksum_mismatch"
        else:
            category = "other"
        field_sigs.append((field_name, category))
    field_sigs.sort(key=lambda x: (x[0] or "", x[1]))
    return (msg, tuple(field_sigs))


def run_session(lua_folder, pcap_path, udp_ports=None):
    from scapy.all import rdpcap

    registry = load_bus_folder(lua_folder)
    if registry.errors:
        print("Bus load errors (these messages will not be validated):")
        for e in registry.errors:
            print("  -", e)
    if registry.warnings:
        print("Bus load warnings:")
        for w in registry.warnings:
            print("  -", w)

    known_ids = {mid for bus in registry.buses.values() for mid in bus}
    print(f"Loaded {len(registry.messages_by_name)} message type(s) "
          f"across {len(registry.buses)} bus(es): "
          f"{sorted(m.name for m in registry.all_messages())}")

    pkts = rdpcap(pcap_path)
    total = 0
    ok_count = 0
    faults = OrderedDict()  # signature -> FaultBucket

    for p in pkts:
        if "UDP" not in p:
            continue
        if udp_ports and p["UDP"].dport not in udp_ports and p["UDP"].sport not in udp_ports:
            continue
        raw = bytes(p["UDP"].payload)
        ts = float(p.time) if hasattr(p, "time") else None

        total += 1
        result = validate_payload(registry, raw)

        if not result["errors"]:
            ok_count += 1
            continue

        sig = fault_signature(result)
        if sig not in faults:
            faults[sig] = FaultBucket(sig, result["message"], result, ts)
        else:
            faults[sig].bump(ts)

    return registry, total, ok_count, faults


def _format_run_block(total, ok_count, faults):
    """Build the text for one run's block (no leading/trailing blank lines)."""
    now = datetime.datetime.now().isoformat(timespec="seconds")
    lines = []

    if not faults:
        lines.append(f"{now}\tSTATUS=PASS\ttotal={total}\tvalid={ok_count}\tfaulty=0")
        return "\n".join(lines)

    fault_total = sum(b.count for b in faults.values())
    lines.append(f"{now}\tSTATUS=FAIL\ttotal={total}\tvalid={ok_count}\tfaulty={fault_total}\t"
                 f"distinct_fault_types={len(faults)}")
    for sig, bucket in faults.items():
        msg_name, field_sigs = sig
        lines.append(f"MESSAGE: {msg_name}")
        lines.append(f"  occurrences: {bucket.count}")
        lines.append(f"  first_seen: {bucket.first_seen}")
        lines.append(f"  last_seen:  {bucket.last_seen}")
        lines.append(f"  faults:")
        for field_name, category in field_sigs:
            example_reason = next(
                (r for fn, r in bucket.example["errors"] if fn == field_name),
                category
            )
            fname = field_name if field_name else "(message-level)"
            lines.append(f"    - {fname}: [{category}] e.g. \"{example_reason}\"")
    return "\n".join(lines)


def write_log(total, ok_count, faults, log_path, max_runs=MAX_LOG_RUNS):
    """Append this run's block to the log, then trim to the most recent
    `max_runs` blocks (oldest dropped first -- FIFO)."""
    new_block = _format_run_block(total, ok_count, faults)

    existing_blocks = []
    try:
        with open(log_path, "r") as f:
            content = f.read()
        # blocks are separated by a blank line
        existing_blocks = [b for b in content.split("\n\n") if b.strip()]
    except FileNotFoundError:
        pass

    all_blocks = existing_blocks + [new_block]
    if len(all_blocks) > max_runs:
        all_blocks = all_blocks[-max_runs:]  # keep only the most recent N

    with open(log_path, "w") as f:
        f.write("\n\n".join(all_blocks) + "\n")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("lua_folder")
    ap.add_argument("pcap")
    ap.add_argument("--log", default="faults.log")
    ap.add_argument("--ports", default=None, help="comma-separated UDP ports to restrict to")
    args = ap.parse_args()

    udp_ports = None
    if args.ports:
        udp_ports = {int(x) for x in args.ports.split(",")}

    registry, total, ok_count, faults = run_session(args.lua_folder, args.pcap, udp_ports)

    print(f"\nTotal UDP messages examined: {total}")
    print(f"Valid: {ok_count}")
    print(f"Fault signatures found: {len(faults)}")

    write_log(total, ok_count, faults, args.log)

    if faults:
        print(f"\nSome messages failed validation. Details written to {args.log}:")
        for sig, bucket in faults.items():
            msg_name, field_sigs = sig
            field_desc = ", ".join(f"{fn or '(msg-level)'}:{cat}" for fn, cat in field_sigs)
            print(f"  - {msg_name}: {field_desc}  (x{bucket.count}, "
                  f"first={bucket.first_seen}, last={bucket.last_seen})")
    else:
        print(f"\nAll messages passed validation. Status written to {args.log}.")


if __name__ == "__main__":
    main()