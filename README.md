 # NDS_LCU_BUS_PR Message Validator

Validates recorded UDP bus traffic (pcap captures) against the ICD,
using the ICD tool's own generated Wireshark Lua dissector as the
single source of truth for message structure -- instead of hand-
mapping field offsets in Python.

## Why this approach

Field names in an ICD (`attitude_10hz`, `navData_10hz`, etc.) tell you
*what* the data represents, but not the exact byte layout: sizes
(float32 vs scaled int16 vs 24-bit int), order, endianness, bitfield
packing, or checksum placement. Guessing that from names alone doesn't
work reliably. The ICD-generated `.lua` file already encodes the real
layout (it's what Wireshark uses to dissect these messages), so this
tool runs that Lua code directly, through a real Lua interpreter, to
discover the field map -- and reuses it for validation instead of
re-deriving it by hand.

## Requirements

- **Lua 5.x** interpreter (developed against 5.4/5.5; no version-
  specific features used)
  - Linux: `apt-get install lua5.4`
  - Windows: install a prebuilt binary (e.g. from lua.org's Windows
    distributions), then either add its folder to `PATH` or set the
    full path in `lua_bridge.py` (see below)
- **Python 3** with `scapy` installed (`pip install scapy`)

## Setup

1. Put every ICD-generated bus `.lua` file (one per bus) in a folder,
   e.g. `bus_defs/`. Do **not** include the Wireshark glue file
   (e.g. `NDS_LCU_BUS_PR_ex.lua`) -- that file only registers the
   dissector with Wireshark's `udp.port` table; it's not a bus
   definition, and the loader skips it automatically if present
   (matches `*.ex.lua` or files containing `.ex.`).

2. In `lua_bridge.py`, confirm `LUA_BIN` points at your actual Lua
   interpreter:
```python
   LUA_BIN = "lua5.4"                                  # if on PATH
   # or, more reliably (especially on Windows):
   LUA_BIN = r"C:\lua-5.5.0_Win64_bin\lua55.exe"
```

## Usage
python session_validate.py <bus_folder> <session.pcap> [--log faults.log] [--ports 33334,33335]

Example:
python session_validate.py bus_defs bus_defs\10hz.pcap --log faults.log

- `--ports` (optional): restrict validation to specific UDP ports.
  Default: every UDP payload in the pcap is checked.
- `--log` (optional, default `faults.log`): where results are written.

### Output

**Console**: total messages examined, how many were valid, and a list
of distinct fault types found (if any).

**Log file**: one block per run, always written (pass or fail),
appended so you keep a history across runs. Format:

2026-07-17T13:32:38    STATUS=FAIL    total=1    valid=0    faulty=1    distinct_fault_types=1
MESSAGE: NAV_10HZ_MESSAGE
occurrences: 1
first_seen: 1766507630.592512
last_seen:  1766507630.592512
faults:
- NUMDATA_10HZ: [const_mismatch] e.g. "expected constant 72, got 50"

A fault that recurs across many packets in the same run collapses into
**one entry with an occurrence count**, not one line per packet --
grouped by message type + which fields failed + why (e.g. two
`ROLL_10HZ: above_max` faults with different exact values still
collapse into one entry).

The log retains the **last 20 runs** (FIFO -- oldest dropped first as
new runs are added). Change `MAX_LOG_RUNS` in `session_validate.py` to
adjust.

## What gets validated, per message

- **Length**: payload must match the ICD's declared message length
  exactly.
- **Dispatch**: message type identified by the single byte at payload
  offset 0, matched against each message's ICD-defined id.
- **Every field**: decoded per its ICD type/scale, then checked
  against the ICD's min/max (or exact-match, for fixed/constant
  fields like sync bytes).
- **Bitfields**: extracted with widths inferred from adjacent bit
  offsets within the same byte.
- **Checksum** (currently `NAV_10HZ_MESSAGE`-specific): reverse-
  engineered as `sum(bytes[2:76]) mod 256`, confirmed against a known-
  good captured message. Hardcoded in `decode.py`
  (`CHECKSUM_FIELD_NAME`, `CHECKSUM_RANGE_START/END`) -- not yet
  generalized to other message types; see Limitations.

## Files

| File | Purpose |
|---|---|
| `AWF.lua` | Stub of the ICD tool's Lua runtime. Intercepts every field/struct/message declaration and records its real offset/size/scale instead of building a Wireshark dissector tree. |
| `harness.lua` | Loads one bus `.lua` file, finds every message in it, and extracts its field map by executing the message's own generated `:read()` logic. |
| `lua_bridge.py` | Runs the harness per bus file (as a subprocess) and parses its output into a `BusRegistry`. |
| `decode.py` | Decodes and validates one UDP payload against a message's field map, including checksum. |
| `session_validate.py` | CLI entry point: iterates a pcap, validates every message, aggregates faults, writes the FIFO log. |

## Known limitations

- **Checksum logic is message-specific** (hardcoded for
  `NAV_10HZ_MESSAGE`). Deliberately not generalized yet -- revisit
  once a second message type with a checksum is available, so the
  right per-message configuration shape can be designed against real
  requirements instead of guessed in advance.
- **Two bugs exist in the vendor's `NDS_LCU_BUS_PR.lua`** (not fixed
  here, just avoided): the "dynamic" read branch references an
  undefined `.terminator` element, and separately skips a 6-byte
  spare region that the "static" branch accounts for correctly. This
  tool always uses the static (`dynamic=false`) branch, which is
  correct and matches real captured messages byte-for-byte. Worth
  reporting upstream to whoever generates these ICD files.
- **Only tested against one bus, one message type so far**
  (`NDS_LCU_BUS_PR.lua` / `NAV_10HZ_MESSAGE`). Multi-bus loading and
  multi-message dispatch (by payload byte 0) are implemented but not
  yet exercised against real multi-type traffic.
- No automated test suite yet -- verification so far has been manual,
  against the real capture plus hand-constructed corrupted/mock-session
  pcaps.
 
A fault that recurs across many packets in the same run collapses into
**one entry with an occurrence count**, not one line per packet --
grouped by message type + which fields failed + why (e.g. two
`ROLL_10HZ: above_max` faults with different exact values still
collapse into one entry).

The log retains the **last 20 runs** (FIFO -- oldest dropped first as
new runs are added). Change `MAX_LOG_RUNS` in `session_validate.py` to
adjust.

## What gets validated, per message

- **Length**: payload must match the ICD's declared message length
  exactly.
- **Dispatch**: message type identified by the single byte at payload
  offset 0, matched against each message's ICD-defined id.
- **Every field**: decoded per its ICD type/scale, then checked
  against the ICD's min/max (or exact-match, for fixed/constant
  fields like sync bytes).
- **Bitfields**: extracted with widths inferred from adjacent bit
  offsets within the same byte.
- **Checksum** (currently `NAV_10HZ_MESSAGE`-specific): reverse-
  engineered as `sum(bytes[2:76]) mod 256`, confirmed against a known-
  good captured message. Hardcoded in `decode.py`
  (`CHECKSUM_FIELD_NAME`, `CHECKSUM_RANGE_START/END`) -- not yet
  generalized to other message types; see Limitations.

## Files

| File | Purpose |
|---|---|
| `AWF.lua` | Stub of the ICD tool's Lua runtime. Intercepts every field/struct/message declaration and records its real offset/size/scale instead of building a Wireshark dissector tree. |
| `harness.lua` | Loads one bus `.lua` file, finds every message in it, and extracts its field map by executing the message's own generated `:read()` logic. |
| `lua_bridge.py` | Runs the harness per bus file (as a subprocess) and parses its output into a `BusRegistry`. |
| `decode.py` | Decodes and validates one UDP payload against a message's field map, including checksum. |
| `session_validate.py` | CLI entry point: iterates a pcap, validates every message, aggregates faults, writes the FIFO log. |

## Known limitations

- **Checksum logic is message-specific** (hardcoded for
  `NAV_10HZ_MESSAGE`). Deliberately not generalized yet -- revisit
  once a second message type with a checksum is available, so the
  right per-message configuration shape can be designed against real
  requirements instead of guessed in advance.
- **Two bugs exist in the vendor's `NDS_LCU_BUS_PR.lua`** (not fixed
  here, just avoided): the "dynamic" read branch references an
  undefined `.terminator` element, and separately skips a 6-byte
  spare region that the "static" branch accounts for correctly. This
  tool always uses the static (`dynamic=false`) branch, which is
  correct and matches real captured messages byte-for-byte. Worth
  reporting upstream to whoever generates these ICD files.
- **Only tested against one bus, one message type so far**
  (`NDS_LCU_BUS_PR.lua` / `NAV_10HZ_MESSAGE`). Multi-bus loading and
  multi-message dispatch (by payload byte 0) are implemented but not
  yet exercised against real multi-type traffic.
- No automated test suite yet -- verification so far has been manual,
  against the real capture plus hand-constructed corrupted/mock-session
  pcaps.