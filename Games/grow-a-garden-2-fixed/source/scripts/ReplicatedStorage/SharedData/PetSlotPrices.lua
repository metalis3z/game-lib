--credit to leon games studio
local t = {
	Prices = { 200000, 1000000, 5000000 },
	BaseMax = 3
}

t.AbsoluteMax = t.BaseMax + #t.Prices
function t.GetNextPrice(p1) --[[ GetNextPrice | Line: 31 | Upvalues: t (copy) ]]
	return t.Prices[math.max(0, (math.floor(p1 - t.BaseMax))) + 1]
end
function t.GetPurchasedCount(p1) --[[ GetPurchasedCount | Line: 39 | Upvalues: t (copy) ]]
	return math.max(0, (math.floor(p1 - t.BaseMax)))
end
function t.AbbreviatePrice(p1) --[[ AbbreviatePrice | Line: 45 ]]
	if p1 < 1000 then
		return tostring((math.floor(p1 + 0.5)))
	end

	local v2, v3

	if p1 >= 1000000000 then
		v2 = 1000000000
		v3 = "B"
	elseif p1 >= 1000000 then
		v2 = 1000000
		v3 = "M"
	else
		v2 = 1000
		v3 = "K"
	end

	local v4 = math.floor(p1 / v2 * 10 + 0.5) / 10

	if v4 == math.floor(v4) then
		return string.format("%d%s", v4, v3)
	end

	return string.format("%g%s", v4, v3)
end

return t