--credit to leon games studio
return function(p1) --[[ BinaryToHex | Line: 20 ]]
	local v1 = string.len(p1)
	local v2 = buffer.create(v1 * 2)

	for i = 0, v1 - 1 do
		local v3 = string.byte(p1, i + 1)
		local v4 = bit32.rshift(v3, 4)
		local v5 = bit32.band(v3, 15)

		buffer.writeu8(v2, i * 2 + 0, if v4 < 10 then v4 + 48 else v4 + 87)
		buffer.writeu8(v2, i * 2 + 1, if v5 < 10 then v5 + 48 else v5 + 87)
	end

	return buffer.tostring(v2)
end