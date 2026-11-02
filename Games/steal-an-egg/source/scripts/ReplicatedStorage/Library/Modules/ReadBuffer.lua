-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 4 | Upvalues: t (copy) ]]
	return setmetatable({
		offset = 0,
		buf = p1
	}, t)
end
function t.ResetReadPos(p1) --[[ ResetReadPos | Line: 12 ]]
	p1.offset = 0
end
function t.ReadU8(p1) --[[ ReadU8 | Line: 16 ]]
	local v1 = buffer.readu8(p1.buf, p1.offset)

	p1.offset = p1.offset + 1

	return v1
end
function t.ReadI16(p1) --[[ ReadI16 | Line: 22 ]]
	local v1 = buffer.readu16(p1.buf, p1.offset)

	p1.offset = p1.offset + 2

	return v1
end
function t.ReadVector3(p1) --[[ ReadVector3 | Line: 28 ]]
	local v1 = buffer.readf32(p1.buf, p1.offset)

	p1.offset = p1.offset + 4

	local v2 = buffer.readf32(p1.buf, p1.offset)

	p1.offset = p1.offset + 4

	local v3 = buffer.readf32(p1.buf, p1.offset)

	p1.offset = p1.offset + 4

	return Vector3.new(v1, v2, v3)
end
function t.ReadFloat16(p1) --[[ ReadFloat16 | Line: 39 ]]
	local v1 = buffer.readu8(p1.buf, p1.offset)

	p1.offset = p1.offset + 1

	local v2 = buffer.readu8(p1.buf, p1.offset)

	p1.offset = p1.offset + 1

	local v3 = bit32.btest(v1, 128)
	local v5 = bit32.rshift(bit32.band(v1, 127), 2)
	local v7 = bit32.lshift(bit32.band(v1, 3), 8) + v2

	if v5 == 31 then
		if v7 ~= 0 then
			return (0 / 0)
		end

		if v3 then
			return (-1 / 0)
		end

		return (1 / 0)
	end

	if v5 == 0 then
		if v7 == 0 then
			return 0
		end

		return v3 and -math.ldexp(v7 / 1024, -14) or math.ldexp(v7 / 1024, -14)
	end

	local v9 = v7 / 1024 + 1

	return v3 and -math.ldexp(v9, v5 - 15) or math.ldexp(v9, v5 - 15)
end

return t