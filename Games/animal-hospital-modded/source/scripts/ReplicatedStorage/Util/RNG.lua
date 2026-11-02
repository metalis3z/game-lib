local t = {
	new = function(p1, p2, p3, p4) --[[ new | Line: 3 ]]
		local t = {}
		local sum = 0
		local v1 = nil
		local v2 = nil

		for v3, v4 in p3 do
			if (p4 or not (v4.Condition or v4.Condition2) or (v4.Condition == "None" or (table.find(p1, v4.Condition) or v4.Condition2 and table.find(p1, v4.Condition2)))) and (v4.Chance ~= 0 and v4.Chance) then
				table.insert(t, v4)
				sum = sum + v4.Chance * 100
			end
		end

		if not p2 then
			p2 = 1
		end

		local v5 = p2 * 100
		local v6 = v5 % 100
		local t2 = {}

		for i = 1, (v5 - v6) / 100 do
			table.insert(t2, math.random())
		end

		if v6 ~= 0 then
			table.insert(t2, math.random() * (v6 / 100) + 0)
		end

		local v8 = 0

		for v9, v10 in t2 do
			if v8 < v10 then
				v8 = v10
			end
		end

		local sum2 = v8 * sum
		local v11 = nil

		for v12, v13 in t do
			local v14 = v13.Chance * 100

			if v14 < sum2 then
				sum2 = sum2 - v14
			else
				v1 = v13.Name
				v2 = v13.Rarity
				v11 = v13

				break
			end
		end

		if not v11 then
			return
		end

		local v16 = math.round(1 / v11.Chance)

		return v1, v2, v11, v16 * (if v11.Condition then 20 else 1)
	end,
	GetRarity = function(p1, p2) --[[ GetRarity | Line: 70 ]]
		for v1, v2 in p2 do
			if v2.Title == p1 then
				return math.round(1 / v2.Chance)
			end
		end

		return -1
	end
}
local v1 = Random.new()

function t.DummyNew(p1, p2, p3) --[[ DummyNew | Line: 81 | Upvalues: v1 (copy), t (copy) ]]
	if not p2 then
		p2 = 1
	end

	if v1:NextInteger(1, 2) == 1 then
		p2 = p2 + v1:NextInteger(10, 1000)
	end

	return t.new(p1, p2, p3)
end

return t