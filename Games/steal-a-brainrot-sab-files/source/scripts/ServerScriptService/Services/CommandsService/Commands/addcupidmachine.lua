local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")

	local Net = require(ReplicatedStorage.Packages.Net)
	local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
	local CupidsMachineService = require(ServerScriptService.Services.CupidsMachineService)
	local AnimalsDB = require(ReplicatedStorage.Datas.Animals)
	local RaritiesDB = require(ReplicatedStorage.Datas.Rarities)

	local function getRarityColorHex(rarity)
		local rarityData = RaritiesDB[rarity]
		if rarityData and rarityData.Color then
			local color = rarityData.Color
			return string.format("#%02X%02X%02X", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
		end
		return "#d943ff"
	end

	Conch.register("addcupidmachine", {
		permissions = { Config.RequiredRole or "super-user" },

		description = "Add a custom recipe to Cupid's Machine (result + 2 ingredients)",

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
					name = "Ingredient 1",
				},
				{
					kind = "argument",
					type = "Brainrot",
					name = "Ingredient 2",
				}
		end,

		callback = function(resultBrainrot, ingredient1, ingredient2)
			local resultData = AnimalsDB[resultBrainrot]
			if not resultData then
				return "Error: '" .. resultBrainrot .. "' is not a valid brainrot!"
			end

			if not ingredient1 or ingredient1 == "" then
				return "Error: Ingredient 1 is required!"
			end

			if not ingredient2 or ingredient2 == "" then
				return "Error: Ingredient 2 is required!"
				end

			for i, ingredient in ipairs({ingredient1, ingredient2}) do
				local ingredientData = AnimalsDB[ingredient]
				if not ingredientData then
					return "Error: '" .. ingredient .. "' (ingredient " .. i .. ") is not a valid brainrot!"
				end
			end

			local rarity = resultData.Rarity
			if not rarity then
				return "Error: '" .. resultBrainrot .. "' has no rarity defined!"
			end

			local ingredients = {ingredient1, ingredient2}
			local cost = 12500

			CupidsMachineService:SetCustomRecipe(resultBrainrot, ingredients, cost)

			local colorHex = getRarityColorHex(rarity)
			NotificationEvent:FireAllClients(
				"<font color='" .. colorHex .. "'>" .. resultBrainrot .. "</font> has been added to Incubator's Machine!",
				5,
				"Sounds.Sfx.Success"
			)

			return "[GLOBAL] Added Cupid's recipe for '" .. resultBrainrot .. "' (" .. rarity .. ") with ingredients: " .. ingredient1 .. ", " .. ingredient2
		end,
	})

	Conch.register("addcupid", {
		alias = "addcupidmachine"
	})
end
return module