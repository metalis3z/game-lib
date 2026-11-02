-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Food, time of decompilation: Sun May  3 10:12:42 2026 ]]
local t1 = {
	apple = {
		name = "Apple",
		icon = "rbxassetid://112699557887535",
		xp = 75,
		weight = 1000
	},
	carrot = {
		name = "Carrot",
		icon = "rbxassetid://134696857657707",
		xp = 100,
		weight = 850
	},
	cherries = {
		name = "Cherries",
		icon = "rbxassetid://106679637897733",
		xp = 125,
		weight = 722.4999999999999
	},
	grapes = {
		name = "Grapes",
		icon = "rbxassetid://93890107403882",
		xp = 150,
		weight = 614.1249999999999
	},
	banana = {
		name = "Banana",
		icon = "rbxassetid://122787775415651",
		xp = 175,
		weight = 522.0062499999999
	},
	watermelon = {
		name = "Watermelon",
		icon = "rbxassetid://98959521935651",
		xp = 200,
		weight = 443.70531249999993
	},
	pizza = {
		name = "Pizza",
		icon = "rbxassetid://116306393207375",
		xp = 225,
		weight = 377.14951562499994
	},
	chicken = {
		name = "Chicken",
		icon = "rbxassetid://108578662930655",
		xp = 250,
		weight = 320.5770882812499
	},
	drumstick = {
		name = "Drumstick",
		icon = "rbxassetid://103284786335739",
		xp = 275,
		weight = 272.49052503906245
	}
}
local t2 = {}
local n1 = 0

for v4, v5 in t1 do
	v5.id = v4

	local weight = v5.weight

	n1 += weight
	table.insert(t2, v5)
end

table.sort(t2, function(p1, p2) -- line: 99
	return p1.xp < p2.xp
end)

return {
	getFood = function(s1: string) --[[ getFood ]] -- line: 105
		-- upvalues: t1 (copy)
		return t1[s1]
	end,
	getDescription = function(s2: string) --[[ getDescription ]] -- line: 109
		-- upvalues: t1 (copy)
		local v11 = t1[s2]

		if not v11 then
			return ""
		end

		return string.format("Gives %d XP to a slime.", v11.xp)
	end,
	getSortedFoods = function() --[[ getSortedFoods ]] -- line: 118
		-- upvalues: t2 (copy)
		return table.clone(t2)
	end,
	rollFood = function(n2: number?) --[[ rollFood ]] -- line: 122
		-- upvalues: n1 (ref), t2 (copy)
		if n1 <= 0 then
			return nil
		end

		local v13 = (n2 or math.random()) * n1

		for _, v15 in t2 do
			v13 -= v15.weight

			if v13 <= 0 then
				return v15
			end
		end

		return t2[#t2]
	end
}
