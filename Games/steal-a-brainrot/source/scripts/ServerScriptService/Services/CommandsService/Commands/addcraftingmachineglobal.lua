local module = function(Conch, Config)
	local RS = game:GetService("ReplicatedStorage")
	local SStorage = game:GetService("ServerStorage")
	local SS = game:GetService("ServerScriptService")
	local CraftingMachineService = require(SS.Services.CraftingMachineService)
	local CraftingData = require(SStorage.Modules.CraftingData)
	local AnimalsDB = require(RS.Datas.Animals)
	local CRAFT_TIMES = {Common=120,Rare=240,Epic=420,Legendary=900,Mythic=1800,["Brainrot God"]=2700,Secret=5400,OG=10800,Cosmic=14400}

	Conch.register("addcraftingmachineglobal", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{ kind="argument", type="Brainrot", name="Result Brainrot" },
				{ kind="argument", type="Brainrot", name="Ingredient 1" },
				{ kind="argument", type="Brainrot", name="Ingredient 2", optional=true },
				{ kind="argument", type="Brainrot", name="Ingredient 3", optional=true },
				{ kind="argument", type="Brainrot", name="Ingredient 4", optional=true }
		end,
		callback = function(result, ing1, ing2, ing3, ing4)
			if not AnimalsDB[result] then return "Error: invalid brainrot '"..tostring(result).."'" end
			if not ing1 or ing1=="" then return "Error: Ingredient 1 required!" end
			local ingredients = {ing1}
			for _, ing in ipairs({ing2,ing3,ing4}) do
				if ing and ing~="" then
					if not AnimalsDB[ing] then return "Error: invalid ingredient '"..ing.."'" end
					table.insert(ingredients, ing)
				end
			end
			local rarity = AnimalsDB[result].Rarity
			if not rarity then return "Error: no rarity for '"..result.."'" end
			if not CraftingData.Rarities[rarity] then
				CraftingData.Rarities[rarity] = {CraftTime=900, Brainrots={}}
			end
			local craftTime = CRAFT_TIMES[rarity] or CraftingData.Rarities[rarity].CraftTime or 900
			CraftingMachineService.addCustomRecipe(rarity, {
				Name=result, Recipe=ingredients, Cost=1000000, CraftTime=craftTime,
			})
			return "✅ Added '"..result.."' ("..rarity..") | "..table.concat(ingredients,", ").." | Unlimited"
		end,
	})
end
return module