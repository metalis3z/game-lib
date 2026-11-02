
local t1 = {
	Balloon = table.freeze({
		"Orange Balloon",
		"Green Balloon",
		"Blue Balloon",
		"Red Balloon",
		"Pink Balloon",
		"Rainbow Balloon"
	}),
	Egg = table.freeze({
		"Orange Egg",
		"Green Egg",
		"Blue Egg",
		"Pink Egg"
	})
}
local t2 = {}

for _, v in pairs(t1) do
	for _, v2 in ipairs(v) do
		t2[v2] = v
	end
end

local t9 = {
	GetExclusiveGroup = function(s1: string)
		return t2[s1]
	end,
	HasTraitFromGroup = function(t3: {[any]: any}, s2: string)
		local v11 = t1[s2]

		if not v11 then
			return false
		end

		for _, v in ipairs(t3) do
			if table.find(v11, v) then
				return true
			end
		end

		return false
	end,
	CanAddTrait = function(t4: {[any]: any}, s3: string)
		local v16 = t2[s3]

		if not v16 then
			return true
		end

		for _, v in ipairs(t4) do
			if table.find(v16, v) then
				return false
			end
		end

		return true
	end,
	PoolExclusiveChances = function(t5: {[any]: any})
		for _, v in pairs(t1) do
			local t6 = {}
			local n1 = 0

			for _, v3 in ipairs(v) do
				local v26 = t5[v3]

				if v26 then
					table.insert(t6, v3)

					if n1 < v26 then
						n1 = v26
					end
				end
			end

			if not (#t6 <= 1) then
				local v27 = n1 / #t6

				for _, v4 in ipairs(t6) do
					t5[v4] = v27
				end
			end
		end

		return t5
	end,
	DeduplicateExclusiveTraits = function(t7: {[any]: any}, p1)
		local v32 = p1 or Random.new()

		for _, v in pairs(t1) do
			local t8 = {}

			for i, v5 in ipairs(t7) do
				if table.find(v, v5) then
					table.insert(t8, i)
				end
			end

			if not (#t8 <= 1) then
				local v38 = t8[v32:NextInteger(1, #t8)]

				for i = #t8, 1, -1 do
					if v38 ~= t8[i] then
						table.remove(t7, t8[i])
					end
				end
			end
		end

		return t7
	end
}

return table.freeze(t9)
