--credit to prince games studio
require(script.Parent.Parent.Types)

local t = {
	[0] = { 1, 2, 4, 8, 16 },
	[2] = { 8, 16 },
	[3] = { 1, 2, 4, 8 },
	[4] = { 8, 16 },
	[6] = { 8, 16 }
}

return function(p1, p2) --[[ read | Line: 11 | Upvalues: t (copy) ]]
	assert(if p2.length == 13 then true else false, "IHDR data must be 13 bytes")

	local offset = p2.offset
	local v3 = bit32.byteswap((buffer.readu32(p1, offset)))
	local v5 = bit32.byteswap((buffer.readu32(p1, offset + 4)))
	local v6 = buffer.readu8(p1, offset + 8)
	local v7 = buffer.readu8(p1, offset + 9)
	local v8 = buffer.readu8(p1, offset + 10)
	local v9 = buffer.readu8(p1, offset + 11)
	local v10 = buffer.readu8(p1, offset + 12)

	assert(if v3 > 0 and (v3 <= 2147483648 and v5 > 0) then if v5 <= 2147483648 then true else false else false, "invalid dimensions")
	assert(if v8 == 0 then true else false, "invalid compression method")
	assert(if v9 == 0 then true else false, "invalid filter method")
	assert(if v10 == 0 then true elseif v10 == 1 then true else false, "invalid interlace method")

	local v15 = t[v7]

	assert(if v15 == nil then false else true, "invalid color type")
	assert(if table.find(v15, v6) == nil then false else true, "invalid bit depth")

	local t2 = {
		width = v3,
		height = v5,
		bitDepth = v6,
		colorType = v7
	}

	t2.interlaced = v10 == 1

	return t2
end