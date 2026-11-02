--credit to prince games studio
require(script.Parent.Parent.Types)

local function readU16(p1, p2, p3) --[[ readU16 | Line: 3 ]]
	return bit32.extract(bit32.bor(bit32.lshift(buffer.readu8(p1, p2), 8), (buffer.readu8(p1, p2 + 1))), 0, p3)
end

return function(p1, p2, p3, p4) --[[ read | Line: 11 ]]
	local v1 = -1
	local v2 = -1
	local v3 = -1
	local v4 = -1

	if p3.colorType == 0 then
		assert(p2.length == 2, "invalid tRNS length for color type")

		local offset = p2.offset

		v1 = bit32.extract(bit32.bor(bit32.lshift(buffer.readu8(p1, offset), 8), (buffer.readu8(p1, offset + 1))), 0, p3.bitDepth)
	elseif p3.colorType == 2 then
		assert(p2.length == 6, "invalid tRNS length for color type")

		local offset = p2.offset
		local v14 = bit32.extract(bit32.bor(bit32.lshift(buffer.readu8(p1, offset), 8), (buffer.readu8(p1, offset + 1))), 0, p3.bitDepth)
		local v15 = p2.offset + 2
		local v20 = bit32.extract(bit32.bor(bit32.lshift(buffer.readu8(p1, v15), 8), (buffer.readu8(p1, v15 + 1))), 0, p3.bitDepth)
		local v21 = p2.offset + 4

		v2, v3, v4 = v14, v20, bit32.extract(bit32.bor(bit32.lshift(buffer.readu8(p1, v21), 8), (buffer.readu8(p1, v21 + 1))), 0, p3.bitDepth)
	else
		local length = p2.length

		assert(p4, "tRNS requires PLTE for color type")
		assert(if length <= #p4.colors then true else false, "tRNS specified too many PLTE alphas")

		for i = 1, length do
			p4.colors[i].a = buffer.readu8(p1, p2.offset + i - 1)
		end
	end

	return {
		gray = v1,
		red = v2,
		green = v3,
		blue = v4
	}
end