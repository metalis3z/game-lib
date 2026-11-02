-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local BufferWriter = require(script.Parent.BufferWriter)
local DataTypeBuffer = require(script.Parent.DataTypeBuffer)

require(script.Parent.Types)

local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 16 | Upvalues: t (copy), BufferWriter (copy) ]]
	if typeof(p1) == "string" then
		return t.fromString(p1)
	end

	if typeof(p1) == "buffer" then
		return t.fromBuffer(p1)
	end

	if typeof(p1) == "table" and getmetatable(p1) == BufferWriter then
		return t.fromBuffer(p1:GetBuffer())
	end

	error((("expected string or buffer; got %*"):format((typeof(p1)))))
end
function t.fromBuffer(p1) --[[ fromBuffer | Line: 28 | Upvalues: t (copy) ]]
	return setmetatable({
		_cursor = 0,
		_buffer = p1,
		_size = buffer.len(p1)
	}, t)
end
function t.fromString(p1) --[[ fromString | Line: 38 | Upvalues: t (copy) ]]
	return t.fromBuffer(buffer.fromstring(p1))
end
function t._assertSize(p1, p2) --[[ _assertSize | Line: 42 ]]
	if not (p1._size < p2) then
		return
	end

	error("cursor out of bounds", 3)
end
function t.ReadInt8(p1) --[[ ReadInt8 | Line: 51 ]]
	p1:_assertSize(p1._cursor + 1)

	local v1 = buffer.readi8(p1._buffer, p1._cursor)

	p1._cursor = p1._cursor + 1

	return v1
end
function t.ReadUInt8(p1) --[[ ReadUInt8 | Line: 61 ]]
	p1:_assertSize(p1._cursor + 1)

	local v1 = buffer.readu8(p1._buffer, p1._cursor)

	p1._cursor = p1._cursor + 1

	return v1
end
function t.ReadInt16(p1) --[[ ReadInt16 | Line: 71 ]]
	p1:_assertSize(p1._cursor + 2)

	local v1 = buffer.readi16(p1._buffer, p1._cursor)

	p1._cursor = p1._cursor + 2

	return v1
end
function t.ReadUInt16(p1) --[[ ReadUInt16 | Line: 81 ]]
	p1:_assertSize(p1._cursor + 2)

	local v1 = buffer.readu16(p1._buffer, p1._cursor)

	p1._cursor = p1._cursor + 2

	return v1
end
function t.ReadInt32(p1) --[[ ReadInt32 | Line: 91 ]]
	p1:_assertSize(p1._cursor + 4)

	local v1 = buffer.readi32(p1._buffer, p1._cursor)

	p1._cursor = p1._cursor + 4

	return v1
end
function t.ReadUInt32(p1) --[[ ReadUInt32 | Line: 101 ]]
	p1:_assertSize(p1._cursor + 4)

	local v1 = buffer.readu32(p1._buffer, p1._cursor)

	p1._cursor = p1._cursor + 4

	return v1
end
function t.ReadFloat32(p1) --[[ ReadFloat32 | Line: 111 ]]
	p1:_assertSize(p1._cursor + 4)

	local v1 = buffer.readf32(p1._buffer, p1._cursor)

	p1._cursor = p1._cursor + 4

	return v1
end
function t.ReadFloat64(p1) --[[ ReadFloat64 | Line: 121 ]]
	p1:_assertSize(p1._cursor + 8)

	local v1 = buffer.readf64(p1._buffer, p1._cursor)

	p1._cursor = p1._cursor + 8

	return v1
end
function t.ReadBool(p1) --[[ ReadBool | Line: 131 ]]
	return p1:ReadUInt8() == 1
end
function t.ReadString(p1) --[[ ReadString | Line: 143 ]]
	local v1 = p1:ReadUInt32()

	p1:_assertSize(p1._cursor + v1)

	local v2 = buffer.readstring(p1._buffer, p1._cursor, v1)

	p1._cursor = p1._cursor + v1

	return v2
end
function t.ReadStringRaw(p1, p2) --[[ ReadStringRaw | Line: 157 ]]
	local v2 = math.max(0, (math.floor(p2)))

	p1:_assertSize(p1._cursor + v2)

	local v3 = buffer.readstring(p1._buffer, p1._cursor, v2)

	p1._cursor = p1._cursor + v2

	return v3
end
function t.ReadDataType(p1, p2) --[[ ReadDataType | Line: 172 | Upvalues: DataTypeBuffer (copy) ]]
	local v1 = DataTypeBuffer.DataTypesToString[p2]

	if v1 then
		return DataTypeBuffer.ReadWrite[v1].read(p1)
	end

	error("unsupported data type", 2)
end
function t.SetCursor(p1, p2) --[[ SetCursor | Line: 185 ]]
	local v1 = math.floor(p2)

	if v1 < 0 or p1._size < v1 then
		local v2

		v2 = v1
		error(("cursor position %* out of range [0, %*]"):format(v1, p1._size), 3)
	end

	p1._cursor = v1
end
function t.GetCursor(p1) --[[ GetCursor | Line: 197 ]]
	return p1._cursor
end
function t.ResetCursor(p1) --[[ ResetCursor | Line: 204 ]]
	p1._cursor = 0
end
function t.GetSize(p1) --[[ GetSize | Line: 211 ]]
	return p1._size
end
function t.GetBuffer(p1) --[[ GetBuffer | Line: 218 ]]
	return p1._buffer
end
function t.__tostring(p1) --[[ __tostring | Line: 222 ]]
	return "BufferReader"
end

return t