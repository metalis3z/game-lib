-- Made by @spyderzynna On Spideruncopylocked-- 
local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")

	local Net = require(ReplicatedStorage.Packages.Net)
	local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
	local CraftingMachineService = require(ServerScriptService.Services.CraftingMachineService)
	local AnimalsDB = require(ReplicatedStorage.Datas.Animals)
	local RaritiesDB = require(ReplicatedStorage.Datas.Rarities)

	local function getRarityColorHex(rarity)
		local rarityData = RaritiesDB[rarity]
		if rarityData and rarityData.Color then
			local color = rarityData.Color
			return string.format("#%02X%02X%02X", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
		end
		return "#00FF00"
	end

	Conch.register("addcraftingcyber", {
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
				},
			{
					kind = "argument",
					type = "number",
					name = "Limited (Optional - nombre max de crafts)",
					optional = true,
				}
		end,

		callback = function(resultBrainrot, ingredient1, ingredient2, ingredient3, ingredient4, limited)
			local resultData = AnimalsDB[resultBrainrot]
			if not resultData then
				return "Error: '" .. resultBrainrot .. "' is not a valid brainrot!"
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
				Limit = limited and tonumber(limited) or nil,
				CraftedCount = 0
			}

			CraftingMachineService.addCustomRecipe(rarity, recipe)

			local colorHex = getRarityColorHex(rarity)
			NotificationEvent:FireAllClients(
				"<font color='" .. colorHex .. "'>" .. resultBrainrot .. "</font> has been added to the craft machine!",
				5,
				"Sounds.Sfx.Success"
			)

			local limitText = limited and tonumber(limited) and tonumber(limited) > 0 and " | Limited: " .. tostring(limited) .. " crafts" or ""
			return "[GLOBAL] Added recipe for '" .. resultBrainrot .. "' (" .. rarity .. ") with ingredients: " .. table.concat(ingredients, ", ") .. limitText .. " - Broadcasted to all servers! (Will be lost on server restart)"
		end,
	})
end

return module