-- Usage: lua5.4 harness.lua <folder-with-lua-files> <bus_module_name>
-- Prints a flat, tab-separated field map for every AWF.Message found in
-- the loaded bus file, to stdout, e.g.:
--   PROTO   NDS_LCU_BUS_PR
--   MSG     NAV_10HZ_MESSAGE       90      78
--   FIELD   NAV_10HZ_MESSAGE  HEADER_1        0       1       cast    UINT8   90      90      1       0
--   FIELD   NAV_10HZ_MESSAGE  HEADING         14      2       linear  UINT16  0       360     0.0054931640625 0
--   BITFIELD NAV_10HZ_MESSAGE EQUIP_STATUS    4       0       cast    UINT8   0       4       1       0

local folder = arg[1]
local moduleName = arg[2]

package.path = folder .. "/?.lua;" .. package.path

-- AWF.lua lives alongside this harness
local harnessDir = arg[0]:match("(.*/)") or "./"
package.path = harnessDir .. "?.lua;" .. package.path

require("AWF")

-- snapshot globals before require, so we can find whatever new global
-- table(s) the bus file creates (its Protocol object), without needing
-- to know the variable name in advance.
local before = {}
for k, _ in pairs(_G) do before[k] = true end

require(moduleName)

local protocols = {}
for k, v in pairs(_G) do
  if not before[k] and type(v) == "table" and v.__awf_kind == "protocol" then
    protocols[#protocols + 1] = { name = k, tbl = v }
  end
end

local function fmt(v)
  if v == nil then return "" end
  return tostring(v)
end

local function emit_field_line(tag, msgName, e)
  local conv = e.converter or {}
  print(table.concat({
    tag, msgName, e.name,
    fmt(e.offset or e.byteOffset), fmt(e.size or e.byteSize), fmt(e.bitOffset),
    fmt(conv.kind), fmt(conv.rawType), fmt(e.min), fmt(e.max), fmt(conv.scale), fmt(conv.offset)
  }, "\t"))
end

-- recursively find all AWF.Message objects inside a protocol/namespace tree
local function find_messages(tbl, visited, out)
  visited = visited or {}
  out = out or {}
  local id = tostring(tbl)
  if visited[id] then return out end
  visited[id] = true
  if type(tbl) ~= "table" then return out end

  if tbl.__awf_kind == "message" then
    out[#out + 1] = tbl
    return out -- don't descend further into a message's own sub-tables here
  end

  for k, v in pairs(tbl) do
    if type(v) == "table" and v ~= tbl then
      find_messages(v, visited, out)
    end
  end
  return out
end

for _, p in ipairs(protocols) do
  print("PROTO\t" .. p.name)
  local messages = find_messages(p.tbl)
  for _, msg in ipairs(messages) do
    if msg.read then
      -- Primary extraction: dynamic=false ("static") branch. This uses
      -- literal, hardcoded offsets in the generated code, so it isn't
      -- affected by accumulation bugs in the dynamic branch (missing
      -- spare-field advances, etc.) -- it's the more trustworthy source.
      AWF.resetRecorder()
      local okStatic, lenStatic = pcall(function()
        return msg:read(nil, nil, nil, 0, 4096, ENC_LITTLE_ENDIAN, false, nil)
      end)
      local staticFields = AWF.getRecorded()

      -- Cross-check: dynamic=true branch, for comparison/diagnostics only.
      AWF.resetRecorder()
      local okDyn, lenDyn = pcall(function()
        return msg:read(nil, nil, nil, 0, 4096, ENC_LITTLE_ENDIAN, true, nil)
      end)
      local dynFields = AWF.getRecorded()

      if okStatic then
        print(table.concat({ "MSG", msg.__awf_name, fmt(msg.__awf_id), fmt(lenStatic) }, "\t"))
        for _, e in ipairs(staticFields) do
          if e.kind == "field" then
            emit_field_line("FIELD", msg.__awf_name, e)
          elseif e.kind == "bitfield" then
            emit_field_line("BITFIELD", msg.__awf_name, e)
          end
        end
      else
        print(table.concat({ "MSGERROR", msg.__awf_name, fmt(msg.__awf_id), "static:" .. tostring(lenStatic) }, "\t"))
      end

      if not okDyn then
        print(table.concat({ "WARN", msg.__awf_name, "dynamic-branch extraction failed: " .. tostring(lenDyn) }, "\t"))
      elseif okStatic and lenDyn ~= lenStatic then
        print(table.concat({ "WARN", msg.__awf_name,
          "dynamic-branch length (" .. tostring(lenDyn) .. ") disagrees with static-branch length (" .. tostring(lenStatic) .. ") -- likely a bug in the generated Lua's dynamic branch" }, "\t"))
      end
    end
  end
end