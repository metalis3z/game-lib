--credit to leon games studio
local t = {}

for i = 0, 255 do
	local v1 = i

	for j = 1, 8 do
		if bit32.band(v1, 1) == 0 then
			v1 = bit32.rshift(v1, 1)

			continue
		end

		v1 = bit32.bxor(bit32.rshift(v1, 1), 3988292384)
	end

	t[i + 1] = v1
end

local t2 = {
	Init = function() --[[ Init | Line: 45 ]]
		return 4294967295
	end,
	Update = function(p1, p2, p3, p4) --[[ Update | Line: 49 | Upvalues: t (copy) ]]
		local v1 = p3 or 1

		for i = v1, v1 + (if p4 then p4 else string.len(p2)) - 1 do
			local v3 = string.byte(p2, i)

			p1 = bit32.bxor(bit32.rshift(p1, 8), t[bit32.band(bit32.bxor(p1, v3), 255) + 1])
		end

		return p1
	end,
	UpdateBuffer = function(p1, p2, p3, p4) --[[ UpdateBuffer | Line: 65 | Upvalues: t (copy) ]]
		local v1 = p3 or 0

		for i = v1, v1 + (if p4 then p4 else buffer.len(p2)) - 1 do
			local v3 = buffer.readu8(p2, i)

			p1 = bit32.bxor(bit32.rshift(p1, 8), t[bit32.band(bit32.bxor(p1, v3), 255) + 1])
		end

		return p1
	end,
	Finish = function(p1) --[[ Finish | Line: 81 ]]
		return bit32.bnot(p1)
	end
}

function t2.Digest(p1, p2, p3) --[[ Digest | Line: 87 | Upvalues: t2 (copy) ]]
	return t2.Finish((t2.Update(t2.Init(), p1, p2, p3)))
end
function t2.DigestBuffer(p1, p2, p3) --[[ DigestBuffer | Line: 97 | Upvalues: t2 (copy) ]]
	return t2.Finish((t2.UpdateBuffer(t2.Init(), p1, p2, p3)))
end

return table.freeze(t2)