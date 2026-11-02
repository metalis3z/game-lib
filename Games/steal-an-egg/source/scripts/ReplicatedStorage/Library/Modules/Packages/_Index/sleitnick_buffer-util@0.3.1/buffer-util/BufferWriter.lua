-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local DataTypeBuffer = require(script.Parent.DataTypeBuffer)

require(script.Parent.Types)

local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 20 | Upvalues: t (copy) ]]
	return setmetatable({
		_cursor = 0,
		_size = 0,
		_buffer = buffer.create(if typeof(p1) == "number" then math.clamp(p1, 0, 1073741824) else 0)
	}, t)
end
function t._resizeUpTo(p1, p2) --[[ _resizeUpTo | Line: 32 ]]
	if p2 > 1073741824 then
		error(("cannot resize buffer to %* bytes (max size: %* bytes)"):format(p2, 1073741824), 3)
	end

	p1._size = math.max(p1._size, p2)

	if p2 < buffer.len(p1._buffer) then
		return
	end

	local v1 = math.log(p2, 2)
	local v3 = buffer.create(if math.floor(v1) == v1 then p2 else 2 ^ (math.floor(v1) + 1))

	buffer.copy(v3, 0, p1._buffer, 0)
	p1._buffer = v3
end
function t.WriteInt8(p1, p2) --[[ WriteInt8 | Line: 61 ]]
	p1:_resizeUpTo(p1._cursor + 1)
	buffer.writei8(p1._buffer, p1._cursor, p2)
	p1._cursor = p1._cursor + 1
end
function t.WriteUInt8(p1, p2) --[[ WriteUInt8 | Line: 70 ]]
	p1:_resizeUpTo(p1._cursor + 1)
	buffer.writeu8(p1._buffer, p1._cursor, p2)
	p1._cursor = p1._cursor + 1
end
function t.WriteInt16(p1, p2) --[[ WriteInt16 | Line: 79 ]]
	p1:_resizeUpTo(p1._cursor + 2)
	buffer.writei16(p1._buffer, p1._cursor, p2)
	p1._cursor = p1._cursor + 2
end
function t.WriteUInt16(p1, p2) --[[ WriteUInt16 | Line: 88 ]]
	p1:_resizeUpTo(p1._cursor + 2)
	buffer.writeu16(p1._buffer, p1._cursor, p2)
	p1._cursor = p1._cursor + 2
end
function t.WriteInt32(p1, p2) --[[ WriteInt32 | Line: 97 ]]
	p1:_resizeUpTo(p1._cursor + 4)
	buffer.writei32(p1._buffer, p1._cursor, p2)
	p1._cursor = p1._cursor + 4
end
function t.WriteUInt32(p1, p2) --[[ WriteUInt32 | Line: 106 ]]
	p1:_resizeUpTo(p1._cursor + 4)
	buffer.writeu32(p1._buffer, p1._cursor, p2)
	p1._cursor = p1._cursor + 4
end
function t.WriteFloat32(p1, p2) --[[ WriteFloat32 | Line: 115 ]]
	p1:_resizeUpTo(p1._cursor + 4)
	buffer.writef32(p1._buffer, p1._cursor, p2)
	p1._cursor = p1._cursor + 4
end
function t.WriteFloat64(p1, p2) --[[ WriteFloat64 | Line: 124 ]]
	p1:_resizeUpTo(p1._cursor + 8)
	buffer.writef64(p1._buffer, p1._cursor, p2)
	p1._cursor = p1._cursor + 8
end
function t.WriteBool(p1, p2) --[[ WriteBool | Line: 133 ]]
	p1:WriteUInt8(if p2 then 1 else 0)
end
function t.WriteString(p1, p2, p3) --[[ WriteString | Line: 146 ]]
	local v1 = if p3 then math.min(#p2, p3) else #p2
	local v2 = v1 + 4

	p1:_resizeUpTo(p1._cursor + v2)
	buffer.writeu32(p1._buffer, p1._cursor, v1)
	buffer.writestring(p1._buffer, p1._cursor + 4, p2, p3)
	p1._cursor = p1._cursor + v2
end
function t.WriteStringRaw(p1, p2, p3) --[[ WriteStringRaw | Line: 165 ]]
	local v1 = if p3 then math.min(#p2, p3) else #p2

	p1:_resizeUpTo(p1._cursor + v1)
	buffer.writestring(p1._buffer, p1._cursor, p2, p3)
	p1._cursor = p1._cursor + v1
end
function t.WriteDataType(p1, p2) --[[ WriteDataType | Line: 179 | Upvalues: DataTypeBuffer (copy) ]]
	local v1 = typeof(p2)
	local v2 = DataTypeBuffer.ReadWrite[v1]

	if v2 then
		v2.write(p1, p2)

		return
	end

	error(("unsupported data type \"%*\""):format(v1), 2)
end
function t.Shrink(p1) --[[ Shrink | Line: 191 ]]
	if p1._size ~= buffer.len(p1._buffer) then
		local v1 = buffer.create(p1._size)

		buffer.copy(v1, 0, p1._buffer, 0, p1._size)
		p1._buffer = v1
	end
end
function t.GetSize(p1) --[[ GetSize | Line: 208 ]]
	return p1._size
end
function t.GetCapacity(p1) --[[ GetCapacity | Line: 219 ]]
	return buffer.len(p1._buffer)
end
function t.SetCursor(p1, p2) --[[ SetCursor | Line: 226 ]]
	local v1 = math.floor(p2)

	if v1 < 0 or p1._size < v1 then
		local v2

		v2 = v1
		error(("cursor position %* out of range [0, %*]"):format(v1, p1._size), 3)
	end

	p1._cursor = v1
end
function t.GetCursor(p1) --[[ GetCursor | Line: 238 ]]
	return p1._cursor
end
function t.ResetCursor(p1) --[[ ResetCursor | Line: 245 ]]
	p1._cursor = 0
end
function t.GetBuffer(p1) --[[ GetBuffer | Line: 252 ]]
	return p1._buffer
end
function t.ToString(p1) --[[ ToString | Line: 259 ]]
	return buffer.tostring(p1._buffer)
end
function t.__tostring(p1) --[[ __tostring | Line: 263 ]]
	return "BufferWriter"
end

return t