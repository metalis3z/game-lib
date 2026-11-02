local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")

	local AnimalService = require(game.ServerScriptService.Services.AnimalService)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local MutationsData = require(ReplicatedStorage.Datas.Mutations)
	local TraitsData = require(ReplicatedStorage.Datas.Traits)

	-- Traits to exclude
	local EXCLUDED_TRAITS = {
		["Sleepy"] = true,
		["Sammy"] = true,
	}

	Conch.register("addbrainrotalltraits", {
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
				name = "Brainrot",
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

		callback = function(targetPlayer, brainrotName, mutation, amount)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local spawnAmount = tonumber(amount) or 1

			if spawnAmount < 1 then
				return false, "Amount must be at least 1."
			end

			local animalData = AnimalsData[brainrotName]
			if not animalData then
				return false, "Brainrot '" .. tostring(brainrotName) .. "' not found."
			end

			local cleanMutation = nil
			if mutation and mutation ~= "" and mutation ~= "Default" and mutation ~= "Normal" then
				if not MutationsData[mutation] then
					return false, "Mutation '" .. tostring(mutation) .. "' not found."
				end
				cleanMutation = mutation
			end

			-- Get all traits EXCEPT Sleepy and Sammy
			local allTraits = {}
			for traitName, _ in pairs(TraitsData) do
				if not EXCLUDED_TRAITS[traitName] then
					table.insert(allTraits, traitName)
				end
			end

			local success, err = pcall(function()
				for i = 1, spawnAmount do
					AnimalService.spawnAnimalInBase(
						targetPlayer,
						brainrotName,
						cleanMutation,
						allTraits
					)
					task.wait(0.05)
				end
			end)

			if not success then
				return false, "Failed to spawn brainrot: " .. tostring(err)
			end

			return "Added " .. brainrotName .. " with ALL traits (except Sleepy/Sammy) to " .. targetPlayer.Name
		end
	})
end

return module
