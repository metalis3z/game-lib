
local t1 = {
	[0] = 2,
	[1] = 4,
	[2] = 7,
	[3] = 9,
	[4] = 11,
	[5] = 14,
	[6] = 16,
	[7] = 19,
	[8] = 21,
	[9] = 24,
	[10] = 26,
	[11] = 29,
	[12] = 31,
	[13] = 34,
	[14] = 36,
	[15] = 39,
	[16] = 41,
	[17] = 44
}
local v2 = t1[17]

return {
	highestKnownRebirth = 17,
	exponentialUpgradeFactor = 1.75,
	initialUpgradeCost = 5000,
	maxTier = v2,
	upgrades = {
		1,
		5,
		10
	},
	maxUpgradesByRebirth = t1,
	getExtraSpeed = function(n1: number)
		return n1
	end,
	getTotalSpeed = function(n2: number)
		return n2
	end,
	getUpgradeCost = function(n3: number, n4: number)
		return (math.max(math.floor(1.75 ^ (n3 + n4) * 5000), 1))
	end,
	getMaxUpgradesForRebirth = function(n5: number)
		if n5 >= 17 then
			return v2
		end

		if n5 < 0 then
			n5 = 0
		end

		return t1[n5] or v2
	end,
	getRequiredRebirthForAmount = function(n6: number)
		for i = 0, 17 do
			if n6 <= t1[i] then
				return i
			end
		end

		return 17
	end,
	canBuy = function(n7: number, n8: number, n9: number)
		local v13 = n7 + n8
		local v14

		if n9 >= 17 then
			v14 = v2
		else
			if n9 < 0 then
				n9 = 0
			end

			v14 = t1[n9] or v2
		end

		return v13 <= v14
	end
}
