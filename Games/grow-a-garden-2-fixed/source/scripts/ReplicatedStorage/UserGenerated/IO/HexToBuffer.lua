--credit to quartz games studio
local t = {
	[48] = 0,
	[49] = 1,
	[50] = 2,
	[51] = 3,
	[52] = 4,
	[53] = 5,
	[54] = 6,
	[55] = 7,
	[56] = 8,
	[57] = 9,
	[65] = 10,
	[66] = 11,
	[67] = 12,
	[68] = 13,
	[69] = 14,
	[70] = 15,
	[97] = 10,
	[98] = 11,
	[99] = 12,
	[100] = 13,
	[101] = 14,
	[102] = 15
}

return function(p1) --[[ HexToBuffer | Line: 45 | Upvalues: t (copy) ]]
	local v1 = #p1

	assert(v1 % 2 == 0, "hex length must be even")

	local v3 = buffer.create(v1 // 2)
	local count = 0

	for i = 1, v1, 2 do
		local v4, v5 = string.byte(p1, i, i + 1)
		local v6 = t[v4]

		if not v6 then
			error((("invalid hex at %*"):format(i)))
		end

		local v7 = t[v5]

		if not v7 then
			error((("invalid hex at %*"):format(i + 1)))
		end

		buffer.writeu8(v3, count, v6 * 16 + v7)
		count = count + 1
	end

	return v3
end