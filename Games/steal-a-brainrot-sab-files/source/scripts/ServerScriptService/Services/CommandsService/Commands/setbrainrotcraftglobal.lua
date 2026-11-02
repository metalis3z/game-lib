local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local ServerStorage = game:GetService("ServerStorage")
	local Players = game:GetService("Players")

	local NotificationService = require(ServerScriptService.Services.NotificationService)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local CraftingData = require(ServerStorage.Modules.CraftingData)
	local CraftingMachineService = require(ServerScriptService.Services.CraftingMachineService)

	-- Helper function to find a brainrot in CraftingData and return its location
	local function findBrainrotInCraftingData(brainrotName)
		for rarity, rarityData in pairs(CraftingData.Rarities) do
			for index, recipe in ipairs(rarityData.Brainrots) do
				if recipe.Name == brainrotName then
					return rarity, index, recipe
				end
			end
		end
		return nil, nil, nil
	end

	Conch.register("replacecraft", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "OldBrainrot",
				},
				{
					kind = "argument",
					type = "Brainrot",
					name = "NewBrainrot",
				},
				{
					kind = "argument",
					type = "Brainrot",
					name = "Ingredient1",
				},
				{
					kind = "argument",
					type = "Brainrot",
					name = "Ingredient2",
				},
				{
					kind = "argument",
					type = "Brainrot",
					name = "Ingredient3",
					optional = true
				}
		end,

		callback = function(oldBrainrot, newBrainrot, ingredient1, ingredient2, ingredient3)
			-- Find the old brainrot in CraftingData
			local rarity, index, oldRecipe = findBrainrotInCraftingData(oldBrainrot)
			if not rarity then
				return false, string.format("'%s' not found in CraftingData.", oldBrainrot)
			end

			-- Validate new brainrot exists
			local newData = AnimalsData[newBrainrot]
			if not newData then
				return false, string.format("'%s' not found in AnimalsData.", newBrainrot)
			end

			-- Validate ingredients exist
			local ing1Data = AnimalsData[ingredient1]
			if not ing1Data then
				return false, string.format("Ingredient 1 '%s' not found in AnimalsData.", ingredient1)
			end

			local ing2Data = AnimalsData[ingredient2]
			if not ing2Data then
				return false, string.format("Ingredient 2 '%s' not found in AnimalsData.", ingredient2)
			end

			-- Validate ingredient 3 (optional)
			local ing3Data = nil
			if ingredient3 and ingredient3 ~= "" then
				ing3Data = AnimalsData[ingredient3]
				if not ing3Data then
					return false, string.format("Ingredient 3 '%s' not found in AnimalsData.", ingredient3)
				end
			end

			-- Build the recipe ingredients list
			local recipeIngredients = { ingredient1, ingredient2 }
			if ing3Data then
				table.insert(recipeIngredients, ingredient3)
			end

			-- Create the new recipe (keeping the same cost)
			local newRecipe = {
				Name = newBrainrot,
				Recipe = recipeIngredients,
				Cost = oldRecipe.Cost
			}

			-- Replace in CraftingData (in memory)
			CraftingData.Rarities[rarity].Brainrots[index] = newRecipe

			-- Force regenerate the crafting list and update all players
			CraftingMachineService.forceRegenerate()

			-- Build ingredients display string
			local ingredientsDisplay = table.concat(recipeIngredients, " + ")

			-- Notify all players
			for _, targetPlayer in ipairs(Players:GetPlayers()) do
				NotificationService.Notify(
					targetPlayer,
					string.format("Crafting recipe updated: %s replaced with %s!", oldBrainrot, newBrainrot),
					5,
					"Sounds.Sfx.Success"
				)
			end

			return string.format(
				"Successfully replaced: %s -> %s (Ingredients: %s, Rarity: %s, Cost: %d)\nNote: Changes are in-memory. For permanent changes, modify CraftingData manually.",
				oldBrainrot,
				newBrainrot,
				ingredientsDisplay,
				rarity,
				newRecipe.Cost
			)
		end,
	})
end

return module