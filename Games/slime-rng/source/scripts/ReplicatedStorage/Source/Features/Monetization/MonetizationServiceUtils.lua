-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: MonetizationServiceUtils, time of decompilation: Sun May  3 10:12:03 2026 ]]
return {
	getRollColumns = function(p1: ((...any) -> ...any)?) --[[ getRollColumns ]] -- line: 56
		if p1 ~= nil and p1("doubleRoll") == true then
			return 2
		end

		return 1
	end,
	getRollStatModifiers = function(p2: ((...any) -> ...any)?) --[[ getRollStatModifiers ]] -- line: 64
		local t1 = {}

		if p2 ~= nil and p2("fastRoll") == true then
			table.insert(t1, {
				id = "passes.fastRoll",
				stat = "rollSpeed",
				mode = "multiply",
				value = 2
			})
		end

		if p2 ~= nil and p2("luckyRolls") == true then
			table.insert(t1, {
				id = "passes.luckyRolls",
				stat = "luck",
				mode = "add",
				value = 1
			})
		end

		if p2 ~= nil and p2("vip") == true then
			table.insert(t1, {
				id = "passes.vip",
				stat = "luck",
				mode = "add",
				value = 0.5
			})
		end

		return t1
	end,
	getCoinRewardMultiplier = function(p3: ((...any) -> ...any)?) --[[ getCoinRewardMultiplier ]] -- line: 97
		if p3 ~= nil and p3("vip") == true then
			return 1.1
		end

		return 1
	end,
	getExtraEquipSlots = function(p4: ((...any) -> ...any)?) --[[ getExtraEquipSlots ]] -- line: 105
		if p4 ~= nil and p4("extraEquip") == true then
			return 1
		end

		return 0
	end,
	getLootDropChance = function(n1: number, p5: ((...any) -> ...any)?) --[[ getLootDropChance ]] -- line: 113
		if p5 ~= nil and p5("moreDrops") == true then
			return (math.clamp(n1 * 1.33, 0, 1))
		end

		return (math.clamp(n1, 0, 1))
	end,
	getLootMinDropDelay = function(n2: number, p6: ((...any) -> ...any)?) --[[ getLootMinDropDelay ]] -- line: 121
		if p6 ~= nil and p6("moreDrops") == true then
			return n2 * 0.67
		end

		return n2
	end,
	hasAutoCollect = function(p7: ((...any) -> ...any)?) --[[ hasAutoCollect ]] -- line: 129
		if p7 == nil then
			return false
		end

		return p7("autoCollect") == true
	end
}
