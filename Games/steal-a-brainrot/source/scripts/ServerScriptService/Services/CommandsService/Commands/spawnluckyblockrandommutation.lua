local MUTATION_WEIGHTS = {
	{ name = nil,           weight = 400 },
	{ name = "Gold",        weight = 200 },
	{ name = "Diamond",     weight = 100 },
	{ name = "Rainbow",     weight = 60  },
	{ name = "Candy",       weight = 45  },
	{ name = "Lava",        weight = 35  },
	{ name = "Galaxy",      weight = 25  },
	{ name = "YinYang",     weight = 20  },
	{ name = "Radioactive", weight = 15  },
	{ name = "Bloodrot",    weight = 10  },
	{ name = "Cursed",      weight = 6   },
	{ name = "Divine",      weight = 2   },
}

local TOTAL_WEIGHT = 0
for _, e in ipairs(MUTATION_WEIGHTS) do TOTAL_WEIGHT += e.weight end

local function rollMutation()
	local roll = math.random(1, TOTAL_WEIGHT)
	local cumul = 0
	for _, e in ipairs(MUTATION_WEIGHTS) do
		cumul += e.weight
		if roll <= cumul then return e.name end
	end
	return nil
end

local Module = function(Conch, Config)
	local RS = game:GetService("ReplicatedStorage")
	local Animals = require(RS.Datas.Animals)

	Conch.register("spawnluckyblockrandommutation", {
		description = "Spawn un Lucky Block avec mutation aléatoire. Hiérarchie: Normal > Gold > Diamond > Rainbow > Candy > Lava > Galaxy > YinYang > Radioactive > Bloodrot > Cursed > Divine.",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument", type = "LuckyBlock", name = "Lucky Block",
			},
			{
				kind = "argument", type = "number", name = "Amount", optional = true,
			}
		end,
		callback = function(luckyBlockKey, amount)
			local AnimalService = require(game.ServerScriptService.Services.AnimalService)
			amount = math.clamp(tonumber(amount) or 1, 1, 50)

			local AnimalData = Animals[luckyBlockKey]
			if not AnimalData then
				return false, ("Lucky Block '%s' introuvable."):format(tostring(luckyBlockKey))
			end

			local mutCounts = {}
			for i = 1, amount do
				local mut = rollMutation()
				local key = mut or "Normal"
				mutCounts[key] = (mutCounts[key] or 0) + 1
				AnimalService.spawnAnimalCustom(AnimalData, mut, {}, nil, nil, nil)
				if amount > 1 then task.wait(0.05) end
			end

			local parts = {}
			for mutName, count in pairs(mutCounts) do
				table.insert(parts, count.."x "..mutName)
			end
			table.sort(parts)

			return string.format("✅ %dx %s spawné(s): %s", amount, AnimalData.DisplayName or luckyBlockKey, table.concat(parts, " | "))
		end,
	})
end
return Module