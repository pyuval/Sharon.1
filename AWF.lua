-- Stub AWF module: intercepts ICD-generated protocol definitions and
-- records true field offsets by actually executing the generated
-- :read(dynamic=true) logic, instead of re-deriving offsets by hand.

AWF = {}

-- global sink for discovered leaf fields, per currently-active message
local RECORDER = { entries = {} }

function AWF.emit(kind, tbl)
  tbl.kind = kind
  RECORDER.entries[#RECORDER.entries + 1] = tbl
end

function AWF.resetRecorder()
  RECORDER.entries = {}
end

function AWF.getRecorded()
  return RECORDER.entries
end

-- ftypes: just symbolic tags, we only need their names as strings
ftypes = setmetatable({}, { __index = function(t, k) return k end })

ENC_LITTLE_ENDIAN = "LITTLE_ENDIAN"
ENC_BIG_ENDIAN = "BIG_ENDIAN"

-- Converters: capture raw storage type + scale/offset
AWF.CastConverter = {}
function AWF.CastConverter.new(ftype, rawMin, rawMax, extra)
  return { kind = "cast", rawType = ftype, rawMin = rawMin, rawMax = rawMax, scale = 1, offset = 0 }
end

AWF.LinearConverter = {}
function AWF.LinearConverter.new(ftype, rawMin, rawMax, scale, offset, extra)
  return { kind = "linear", rawType = ftype, rawMin = rawMin, rawMax = rawMax, scale = scale, offset = offset or 0 }
end

-- Namespace / Protocol: plain containers, tag for traversal
AWF.Namespace = {}
function AWF.Namespace.new(name, parent)
  return { __awf_kind = "namespace", __awf_name = name }
end

AWF.Protocol = {}
function AWF.Protocol.new(name, label, id)
  return { __awf_kind = "protocol", __awf_name = name, __awf_id = id }
end

-- Struct: plain container the user code attaches :read to. We just tag it.
AWF.Struct = {}
function AWF.Struct.new(name, label, parent)
  return { __awf_kind = "struct", __awf_name = name }
end
function AWF.Struct.read(self, buf, pkt, tree, offset, len, byteOrder, dynamic, instance)
  return len, {}
end

-- Message: same idea, tag with its dispatch id (3rd ctor arg)
AWF.Message = {}
function AWF.Message.new(name, label, id, byteOrder, someFlag, parent)
  return { __awf_kind = "message", __awf_name = name, __awf_id = id }
end
function AWF.Message.read(self, buf, pkt, tree, offset, len, byteOrder, dynamic, instance)
  return len, {}
end

-- readValue: used only to fetch a raw byte/word before bitfield unpacking.
-- We don't need the real value to discover structure, so return 0.
function AWF.readValue(ftype, buf, offset, size, byteOrder)
  return 0
end

-- Leaf: NumericElement
AWF.NumericElement = {}
local function make_leaf(ctorKind, name, label, ftype, minV, maxV, default, converter, parent)
  local obj = {
    __awf_kind = "leaf",
    __awf_leaf_kind = ctorKind,
    name = name,
    ftype = ftype,
    min = minV,
    max = maxV,
    default = default,
    converter = converter,
  }
  function obj:read(buf, pkt, tree, offset, size, byteOrder, dynamic, instance)
    AWF.emit("field", {
      name = self.name, ftype = self.ftype, min = self.min, max = self.max,
      converter = self.converter, offset = offset, size = size,
    })
    return size
  end
  function obj:readBits(buf, pkt, tree, offset, size, byteOrder, dynamic, instance, value, bitOffset)
    AWF.emit("bitfield", {
      name = self.name, ftype = self.ftype, min = self.min, max = self.max,
      converter = self.converter, byteOffset = offset, byteSize = size, bitOffset = bitOffset,
    })
  end
  return obj
end

function AWF.NumericElement.new(name, label, ftype, minV, maxV, default, converter, parent)
  return make_leaf("numeric", name, label, ftype, minV, maxV, default, converter, parent)
end

AWF.EnumElement = {}
function AWF.EnumElement.new(name, label, ftype, minV, maxV, default, enumTable, converter, parent)
  local obj = make_leaf("enum", name, label, ftype, minV, maxV, default, converter, parent)
  obj.enum = enumTable
  return obj
end

-- ComplexElement: a named instance of a Struct nested inside a Message/Struct.
-- Its :read must delegate to the underlying struct's :read so nested
-- fields get flattened with correct absolute offsets.
AWF.ComplexElement = {}
function AWF.ComplexElement.new(name, label, structRef, parent)
  local obj = { __awf_kind = "complex", name = name, structRef = structRef }
  function obj:read(buf, pkt, tree, offset, size, byteOrder, dynamic, instance)
    local len = self.structRef:read(buf, pkt, tree, offset, size, byteOrder, dynamic, instance)
    return len
  end
  return obj
end

-- ArrayElement: not used by current files' active (non-commented) code path,
-- but stub it so files that reference it don't error on load.
AWF.ArrayElement = {}
function AWF.ArrayElement.new(name, label, elemStruct, parent)
  local obj = { __awf_kind = "array", name = name }
  function obj:read(buf, pkt, tree, offset, size, byteOrder, dynamic, instance)
    return size
  end
  return obj
end

AWF.Array = {}
function AWF.Array.new(name, label, elemStruct, parent)
  return { __awf_kind = "arraytype", name = name }
end