local module = function(Conch, Config)
	local RS = game:GetService("ReplicatedStorage")
	local SStorage = game:GetService("ServerStorage")
	local SS = game:GetService("ServerScriptService")
	local CraftingMachineService = require(SS.Services.CraftingMachineService)
	local CraftingData = require(SStorage.Modules.CraftingData)
	local AnimalsDB = require(RS.Datas.Animals)

	Conch.register("addcraftingmachinelimited", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{ kind="argument", type="number",   name="Nb Ingredients (1-4)" },
				{ kind="argument", type="Brainrot", name="Result Brainrot" },
				{ kind="argument", type="number",   name="Limit (Stock)" },
				{ kind="argument", type="Brainrot", name="Ingredient 1" },
				{ kind="argument", type="Brainrot", name="Ingredient 2", optional=true },
				{ kind="argument", type="Brainrot", name="Ingredient 3", optional=true },
				{ kind="argument", type="Brainrot", name="Ingredient 4", optional=true }
		end,
		callback = function(nbIngredients, resultBrainrot, limit, ingredient1, ingredient2, ingredient3, ingredient4)
			-- Validation result
			local resultData = AnimalsDB[resultBrainrot]
			if not resultData then return "Error: '"..tostring(resultBrainrot).."' is not a valid brainrot!" end

			-- Validation nb ingredients
			local nb = tonumber(nbIngredients)
			if not nb or nb < 1 or nb > 4 then
				return "Error: Number of ingredients must be between 1 and 4!"
			end
			nb = math.floor(nb)

			-- Validation ingredient 1
			if not ingredient1 or ingredient1 == "" then return "Error: Ingredient 1 is required!" end
			if not AnimalsDB[ingredient1] then return "Error: '"..ingredient1.."' is not a valid brainrot!" end

			-- Validation limit
			if not limit or tonumber(limit) == nil or tonumber(limit) <= 0 then
				return "Error: A valid limit > 0 is required!"
			end

			-- Construire la liste d'ingrédients selon nb choisi
			local allIngredients = {ingredient1, ingredient2, ingredient3, ingredient4}
			local ingredients = {}
			for i = 1, nb do
				local ing = allIngredients[i]
				if not ing or ing == "" then
					return ("Error: You specified %d ingredients but Ingredient %d is missing!"):format(nb, i)
				end
				if not AnimalsDB[ing] then
					return ("Error: '%s' is not a valid brainrot!"):format(ing)
				end
				table.insert(ingredients, ing)
			end

			local rarity = resultData.Rarity
			if not rarity then return "Error: '"..resultBrainrot.."' has no rarity defined!" end

			local limitedStock = math.floor(tonumber(limit))
			local craftTime = (CraftingData.Rarities[rarity] and CraftingData.Rarities[rarity].CraftTime) or 900

			CraftingMachineService.setCustomRecipe(rarity, {
				Name=resultBrainrot, Recipe=ingredients, Cost=1000000, CraftTime=craftTime,
			}, limitedStock)

			return "Added '"..resultBrainrot.."' ("..rarity..") | Ingredients ("..nb.."): "
				..table.concat(ingredients, ", ").." | LIMITED: "..limitedStock.." uses"
		end,
	})
end
return module
