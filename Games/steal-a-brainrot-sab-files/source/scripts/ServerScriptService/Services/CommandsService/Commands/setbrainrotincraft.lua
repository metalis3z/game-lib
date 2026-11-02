local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")

	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local PlotService = require(ServerScriptService.Services.PlotService)
	local NotificationService = require(ServerScriptService.Services.NotificationService)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local Rarities = require(ReplicatedStorage.Datas.Rarities)

	Conch.register("setbrainrotincraft", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
				{
					kind = "argument",
					type = "Brainrot",
					name = "MainBrainrot",
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
					optional = true
				}
		end,

		callback = function(targetPlayer, mainBrainrot, ingredient1, ingredient2)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			-- Validate main brainrot
			local mainData = AnimalsData[mainBrainrot]
			if not mainData then
				return false, "Main brainrot '" .. tostring(mainBrainrot) .. "' not found."
			end

			-- Validate ingredient 1
			local ing1Data = AnimalsData[ingredient1]
			if not ing1Data then
				return false, "Ingredient 1 '" .. tostring(ingredient1) .. "' not found."
			end

			-- Validate ingredient 2 (optional)
			local ing2Data = nil
			if ingredient2 and ingredient2 ~= "" then
				ing2Data = AnimalsData[ingredient2]
				if not ing2Data then
					return false, "Ingredient 2 '" .. tostring(ingredient2) .. "' not found."
				end
			end

			-- Get player data
			local data = Synchronizer:Get(targetPlayer)
			if not data then
				return false, "Could not get player data."
			end

			local podiums = data:Get("AnimalPodiums") or {}
			local addedIngredients = {}

			-- Add ingredient 1 to crafting machine
			local freePodium1 = PlotService.getFreePodium(targetPlayer)
			if freePodium1 then
				local podiumIndex1 = tonumber(freePodium1.Name)
				podiums[podiumIndex1] = {
					Index = ingredient1,
					LastCollect = workspace:GetServerTimeNow(),
					Mutation = nil,
					Traits = nil,
					Machine = {
						Type = "Crafting",
						Active = false
					}
				}
				table.insert(addedIngredients, ingredient1)
			else
				return false, "No free podium available for ingredient 1."
			end

			-- Add ingredient 2 to crafting machine (if provided)
			if ing2Data then
				local freePodium2 = PlotService.getFreePodium(targetPlayer)
				if freePodium2 then
					local podiumIndex2 = tonumber(freePodium2.Name)
					podiums[podiumIndex2] = {
						Index = ingredient2,
						LastCollect = workspace:GetServerTimeNow(),
						Mutation = nil,
						Traits = nil,
						Machine = {
							Type = "Crafting",
							Active = false
						}
					}
					table.insert(addedIngredients, ingredient2)
				end
			end

			data:Set("AnimalPodiums", podiums)
			data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

			local ingredientsText = table.concat(addedIngredients, ", ")
			NotificationService.Notify(
				targetPlayer,
				string.format("Added %s to your Crafting Machine for %s!", ingredientsText, mainBrainrot),
				5,
				"Sounds.Sfx.Success"
			)

			return string.format("Added ingredients [%s] for %s to %s's crafting machine!", ingredientsText, mainBrainrot, targetPlayer.Name)
		end,
	})
end

return modulereturn {
	Name = "setbrainrotincraft";
	Aliases = {"sbic"};
	Description = "Adds ingredients to a player's crafting machine for a specific brainrot.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "player";
			Name = "player";
			Description = "The player to add ingredients to.";
		},
		{
			Type = "animalName";
			Name = "MainBrainrot";
			Description = "The brainrot to craft (for display purposes).";
		},
		{
			Type = "animalName";
			Name = "Ingredient1";
			Description = "First ingredient brainrot.";
		},
		{
			Type = "animalName";
			Name = "Ingredient2";
			Description = "Second ingredient brainrot.";
			Optional = true;
		}
	};
}