local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local CraftingMachineService = require(ServerScriptService.Services.CraftingMachineService)
local AnimalsDB = require(ReplicatedStorage.Datas.Animals)
local RaritiesDB = require(ReplicatedStorage.Datas.Rarities)

Conch.register("addlimitedcraft", {
	permissions = { Config.RequiredRole or "super-user" },

	arguments = function()
		return
			{
				kind = "argument",
				type = "Brainrot",
				name = "Result Brainrot",
			},
			{
				kind = "argument",
				type = "number",
				name = "Stock (Global Limit)",
			},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Ingredient 1 (Required)",
			},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Ingredient 2 (Optional)",
				optional = true,
			},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Ingredient 3 (Optional)",
				optional = true,
			},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Ingredient 4 (Optional)",
				optional = true,
			}
	end,

	callback = function(resultBrainrot, stock, ingredient1, ingredient2, ingredient3, ingredient4)
		local resultData = AnimalsDB[resultBrainrot]
		if not resultData then
			return "Error: '" .. resultBrainrot .. "' is not a valid brainrot!"
		end

		if not stock or stock < 1 then
			return "Error: Stock must be at least 1!"
		end

		if not ingredient1 or ingredient1 == "" then
			return "Error: Ingredient 1 is required!"
		end

		local ingredients = {}
		table.insert(ingredients, ingredient1)

		for i, ingredient in ipairs({ingredient2, ingredient3, ingredient4}) do
			if ingredient and ingredient ~= "" then
				table.insert(ingredients, ingredient)
			end
		end

		for i, ingredient in ipairs(ingredients) do
			local ingredientData = AnimalsDB[ingredient]
			if not ingredientData then
				return "Error: '" .. ingredient .. "' (ingredient " .. i .. ") is not a valid brainrot!"
			end
		end

		local rarity = resultData.Rarity
		if not rarity then
			return "Error: '" .. resultBrainrot .. "' has no rarity defined!"
		end

		local recipe = {
			Name = resultBrainrot,
			Recipe = ingredients,
			Cost = 1000000,
			IsCustom = true,
			IsLimited = true,
			Limit = stock,
			CraftedCount = 0
		}

		CraftingMachineService.addLimitedRecipe(rarity, recipe)

		-- Rainbow notification: Nova added limited [brainrot] - Stock: X!
		NotificationEvent:FireAllClients(
			"<rainbow>Nova added limited " .. resultBrainrot .. " - Stock: " .. stock .. "!</rainbow>",
			7,
			"Sounds.Sfx.Success"
		)

		return "[GLOBAL] Added LIMITED recipe for '" .. resultBrainrot .. "' (" .. rarity .. ") Stock: " .. stock .. " with ingredients: " .. table.concat(ingredients, ", ")
	end,
})
end

return module