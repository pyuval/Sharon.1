"""
Decode and validate one UDP payload against a Message field map produced
by lua_bridge.py.
"""
import struct

EPS = 1e-6

_INT_UNPACK = {
    "UINT8": (1, False), "INT8": (1, True),
    "UINT16": (2, False), "INT16": (2, True),
    "UINT24": (3, False), "INT24": (3, True),
    "UINT32": (4, False), "INT32": (4, True),
}

CHECKSUM_FIELD_NAME = "CHECKSUM_10HZ"
CHECKSUM_RANGE_START = 2
CHECKSUM_RANGE_END = 76  # exclusive


def compute_checksum(raw: bytes) -> int:
    return sum(raw[CHECKSUM_RANGE_START:CHECKSUM_RANGE_END]) % 256


def _read_int(raw, offset, raw_type):
    size, signed = _INT_UNPACK.get(raw_type, (None, None))
    if size is None:
        raise ValueError(f"unsupported raw_type {raw_type!r}")
    if size == 3:
        b = raw[offset:offset + 3]
        val = b[0] | (b[1] << 8) | (b[2] << 16)
        if signed and val & 0x800000:
            val -= 0x1000000
        return val
    return int.from_bytes(raw[offset:offset + size], "little", signed=signed)


def _read_bits(raw, byte_offset, bit_offset, width):
    byte_val = raw[byte_offset]
    mask = (1 << width) - 1
    return (byte_val >> bit_offset) & mask


class FieldResult:
    __slots__ = ("name", "raw", "value", "ok", "reason")

    def __init__(self, name, raw, value, ok, reason=None):
        self.name = name
        self.raw = raw
        self.value = value
        self.ok = ok
        self.reason = reason


def decode_and_validate(msg, raw: bytes):
    """Returns (decoded: dict[name->value], field_errors: list[(field_name, reason)])"""
    decoded = {}
    field_errors = []

    def check_range(fld, raw_val, value):
        # constant field: min == max
        if fld.min is not None and fld.max is not None and fld.min == fld.max:
            if raw_val != fld.min and value != fld.min:
                return f"expected constant {fld.min}, got {value}"
            return None
        if fld.min is not None and value < fld.min - EPS:
            return f"value {value} below min {fld.min}"
        if fld.max is not None and value > fld.max + EPS:
            return f"value {value} above max {fld.max}"
        return None

    for fld in msg.fields:
        try:
            raw_val = _read_int(raw, fld.offset, fld.raw_type)
        except Exception as e:
            field_errors.append((fld.name, f"decode error: {e}"))
            continue
        scale = fld.scale if fld.scale not in (None, "") else 1
        value = raw_val * scale + (fld.conv_offset or 0)
        decoded[fld.name] = value
        err = check_range(fld, raw_val, value)
        if err:
            field_errors.append((fld.name, err))

    for byte_offset, flds in msg.bitfield_groups.items():
        byte_val = raw[byte_offset]
        for fld in flds:
            raw_val = (byte_val >> fld.bit_offset) & ((1 << fld.size) - 1)
            scale = fld.scale if fld.scale not in (None, "") else 1
            value = raw_val * scale + (fld.conv_offset or 0)
            decoded[fld.name] = value
            err = check_range(fld, raw_val, value)
            if err:
                field_errors.append((fld.name, err))

    return decoded, field_errors


def validate_payload(registry, raw: bytes):
    """
    Full validation of one UDP payload against the loaded bus registry.
    Returns a dict: {
        'message': msg_name or None,
        'bus': bus_name or None,
        'decoded': {...} or {},
        'errors': [(field_name_or_None, reason), ...],
    }
    """
    if len(raw) == 0:
        return {"message": None, "bus": None, "decoded": {},
                "errors": [(None, "empty payload")]}

    msg_id = raw[0]
    hits = registry.lookup(msg_id)

    if not hits:
        return {"message": None, "bus": None, "decoded": {},
                "errors": [(None, f"unrecognized message id {msg_id}")]}

    if len(hits) > 1:
        bus_names = ", ".join(b for b, _ in hits)
        return {"message": None, "bus": None, "decoded": {},
                "errors": [(None, f"ambiguous message id {msg_id}: defined in multiple buses ({bus_names})")]}

    bus_name, msg = hits[0]

    if len(raw) != msg.length:
        return {"message": msg.name, "bus": bus_name, "decoded": {},
                "errors": [(None, f"length mismatch: got {len(raw)} bytes, expected {msg.length}")]}

    decoded, field_errors = decode_and_validate(msg, raw)
    if any(f.name == CHECKSUM_FIELD_NAME for f in msg.fields):
        expected = compute_checksum(raw)
        actual = decoded.get(CHECKSUM_FIELD_NAME)
        if actual is not None and int(actual) != expected:
            field_errors.append(
                (CHECKSUM_FIELD_NAME, f"checksum mismatch: computed {expected}, message has {int(actual)}")
            )

    return {"message": msg.name, "bus": bus_name, "decoded": decoded, "errors": field_errors}
