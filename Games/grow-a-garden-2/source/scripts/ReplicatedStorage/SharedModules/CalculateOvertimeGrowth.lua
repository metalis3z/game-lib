--credit to quartz games studio
local t = {
	{ 0, 1 },
	{ 3, 1.5 },
	{ 12, 2 },
	{ 24, 2.5 },
	{ 74, 3 },
	{ 200, 3.5 },
	{ 500, 4 },
	{ 1000, 4.5 },
	{ 2000, 5 }
}

return function(p1) --[[ Line: 7 | Upvalues: t (copy) ]]
	if p1 <= 0 then
		return 1
	end

	local v1 = p1 / 3600

	if v1 >= 2000 then
		return math.log(v1 / 2000) * 0.5 / 0.6931471805599453 + 5
	end

	for i = 2, #t do
		if v1 <= t[i][1] then
			local v2 = t[i - 1][1]
			local v3 = t[i - 1][2]

			return v3 + (t[i][2] - v3) * (v1 - v2) / (t[i][1] - v2)
		end
	end

	return 5
end