local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local AnimalService = require(game.ServerScriptService.Services.AnimalService)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local MutationsData = require(ReplicatedStorage.Datas.Mutations)
	local TraitsData = require(ReplicatedStorage.Datas.Traits)

	Conch.register("addluckyblockwithalltraits", {
		permissions = { Config.AdminRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "LuckyBlock",
				name = "Lucky Block",
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
				optional = true
			},
			{
				kind = "argument",
				type = "number",
				name = "Amount",
				optional = true
			}
		end,

		callback = function(targetPlayer, luckyBlockName, mutation, amount)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then return false, "Invalid player." end

			local spawnAmount = tonumber(amount) or 1
			if spawnAmount < 1 then return false, "Amount must be at least 1." end

			local animalData = AnimalsData[luckyBlockName]
			if not animalData then return false, "Lucky Block '" .. tostring(luckyBlockName) .. "' not found." end

			local cleanMutation = nil
			if mutation and mutation ~= "" and mutation ~= "Default" and mutation ~= "Normal" then
				if not MutationsData[mutation] then return false, "Mutation '" .. tostring(mutation) .. "' not found." end
				cleanMutation = mutation
			end


			local allTraits = {}
			for traitName, _ in pairs(TraitsData) do
				if traitName ~= "Sleepy" then
					table.insert(allTraits, traitName)
				end
			end

			local success, err = pcall(function()
				for i = 1, spawnAmount do
					AnimalService.spawnAnimalInBase(targetPlayer, luckyBlockName, cleanMutation, allTraits)
				end
			end)

			if not success then return false, "Failed to add: " .. tostring(err) end
			return "Successfully added " .. spawnAmount .. " " .. luckyBlockName .. " with ALL traits for " .. targetPlayer.Name
		end
	})
end

return module