"""
Runs each ICD-generated Lua bus file through harness.lua (via a real Lua
interpreter) and parses the flattened field map it prints out.

This deliberately does NOT re-derive field offsets/scales by hand -- it
reuses the ICD tool's own generated :read() logic (in the "static",
dynamic=false branch) so the field map is only ever as wrong as the
vendor's own Lua file.
"""
import os
import subprocess
import glob

HARNESS_DIR = os.path.dirname(os.path.abspath(__file__))
HARNESS_PATH = os.path.join(HARNESS_DIR, "harness.lua")
LUA_BIN = r"C:\lua-5.5.0_Win64_bin\lua55.exe"


class Field:
    __slots__ = ("name", "offset", "size", "is_bitfield", "bit_offset",
                 "conv_kind", "raw_type", "min", "max", "scale", "conv_offset")

    def __init__(self, name, offset, size, is_bitfield, bit_offset,
                 conv_kind, raw_type, minv, maxv, scale, conv_offset):
        self.name = name
        self.offset = offset
        self.size = size
        self.is_bitfield = is_bitfield
        self.bit_offset = bit_offset
        self.conv_kind = conv_kind
        self.raw_type = raw_type
        self.min = minv
        self.max = maxv
        self.scale = scale
        self.conv_offset = conv_offset

    def __repr__(self):
        return f"Field({self.name!r}, off={self.offset}, sz={self.size}, bit={self.bit_offset})"


class Message:
    def __init__(self, name, msg_id, length, bus_name):
        self.name = name
        self.msg_id = msg_id
        self.length = length
        self.bus_name = bus_name
        self.fields = []          # non-bitfield Field objects
        self.bitfield_groups = {} # byte_offset -> list[Field] (sorted by bit_offset), width filled in later

    def finalize_bitfields(self):
        for byte_offset, flds in self.bitfield_groups.items():
            flds.sort(key=lambda f: f.bit_offset)
            for i, fld in enumerate(flds):
                if i + 1 < len(flds):
                    width = flds[i + 1].bit_offset - fld.bit_offset
                else:
                    width = 8 - fld.bit_offset
                fld.size = width  # repurpose size field as bit-width for bitfields


class BusRegistry:
    def __init__(self):
        self.buses = {}       # bus_name -> {msg_id: Message}
        self.messages_by_name = {}
        self.warnings = []
        self.errors = []

    def all_messages(self):
        for bus in self.buses.values():
            for msg in bus.values():
                yield msg

    def lookup(self, msg_id):
        """Find a message definition by its dispatch id byte, across all
        loaded buses. Returns list of (bus_name, Message) matches (should
        normally be exactly one, but flag if more than one bus defines the
        same id -- that's a real ambiguity worth surfacing)."""
        hits = []
        for bus_name, msgs in self.buses.items():
            if msg_id in msgs:
                hits.append((bus_name, msgs[msg_id]))
        return hits


def _to_number(s):
    if s == "":
        return None
    try:
        if "." in s or "e" in s or "E" in s:
            return float(s)
        return int(s)
    except ValueError:
        try:
            return float(s)
        except ValueError:
            return s


def load_bus_file(lua_path, registry: BusRegistry):
    folder = os.path.dirname(os.path.abspath(lua_path))
    module_name = os.path.basename(lua_path)[:-4] if lua_path.endswith(".lua") else os.path.basename(lua_path)

    proc = subprocess.run(
        [LUA_BIN, HARNESS_PATH, folder, module_name],
        capture_output=True, text=True
    )
    if proc.returncode != 0:
        registry.errors.append(f"{lua_path}: harness crashed: {proc.stderr.strip()}")
        return

    current_bus = None
    current_msg = None

    for line in proc.stdout.splitlines():
        parts = line.split("\t")
        tag = parts[0]

        if tag == "PROTO":
            current_bus = parts[1]
            registry.buses.setdefault(current_bus, {})

        elif tag == "MSG":
            _, name, msg_id, length = parts
            msg_id = int(msg_id)
            length = int(length)
            current_msg = Message(name, msg_id, length, current_bus)
            registry.buses[current_bus][msg_id] = current_msg
            registry.messages_by_name[name] = current_msg

        elif tag == "MSGERROR":
            name, msg_id, err = parts[1], parts[2], parts[3]
            registry.errors.append(
                f"{lua_path}: message '{name}' (bus {current_bus}) failed static-branch "
                f"extraction: {err}"
            )
            current_msg = None  # don't attach fields to a broken message

        elif tag in ("FIELD", "BITFIELD"):
            (_, msg_name, fname, offset, size, bitoff,
             conv_kind, raw_type, minv, maxv, scale, conv_offset) = parts
            fld = Field(
                name=fname,
                offset=int(offset),
                size=int(size) if size else 0,
                is_bitfield=(tag == "BITFIELD"),
                bit_offset=int(bitoff) if bitoff != "" else 0,
                conv_kind=conv_kind or None,
                raw_type=raw_type or None,
                minv=_to_number(minv),
                maxv=_to_number(maxv),
                scale=_to_number(scale) if scale != "" else 1,
                conv_offset=_to_number(conv_offset) if conv_offset != "" else 0,
            )
            if current_msg is None:
                continue
            if fld.is_bitfield:
                current_msg.bitfield_groups.setdefault(fld.offset, []).append(fld)
            else:
                current_msg.fields.append(fld)

        elif tag == "WARN":
            registry.warnings.append(f"{lua_path}: " + "\t".join(parts[1:]))

    for msg in registry.messages_by_name.values():
        msg.finalize_bitfields()


def load_bus_folder(folder, registry: BusRegistry = None) -> BusRegistry:
    """Load every .lua file in `folder` (except harness/AWF support files)
    as a bus definition."""
    if registry is None:
        registry = BusRegistry()
    for path in sorted(glob.glob(os.path.join(folder, "*.lua"))):
        base = os.path.basename(path)
        if base in ("AWF.lua", "harness.lua"):
            continue
        if base.endswith(".ex.lua") or ".ex." in base:
            continue  # these are Wireshark glue files (port registration), not bus defs
        load_bus_file(path, registry)
    return registry