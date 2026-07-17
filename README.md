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