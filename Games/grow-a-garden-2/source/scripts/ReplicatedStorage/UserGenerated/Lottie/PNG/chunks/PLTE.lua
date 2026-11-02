--credit to prince games studio
require(script.Parent.Parent.Types)

return function(p1, p2, p3) --[[ read | Line: 3 ]]
	assert(if p2.length % 3 == 0 then true else false, "malformed PLTE chunk")

	local v2 = p2.length / 3

	assert(if v2 > 0 then true else false, "no entries in PLTE")
	assert(if v2 <= 256 then true else false, "too many entries in PLTE")
	assert(if v2 <= 2 ^ p3.bitDepth then true else false, "too many entries in PLTE for bit depth")

	local v6 = table.create(v2)
	local offset = p2.offset

	for i = 1, v2 do
		v6[i] = {
			a = 255,
			r = buffer.readu8(p1, offset),
			g = buffer.readu8(p1, offset + 1),
			b = buffer.readu8(p1, offset + 2)
		}
		offset = offset + 3
	end

	return {
		colors = v6
	}
end