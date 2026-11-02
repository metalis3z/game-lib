local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")

	local AnimalService = require(game.ServerScriptService.Services.AnimalService)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local MutationsData = require(ReplicatedStorage.Datas.Mutations)
	local TraitsData = require(ReplicatedStorage.Datas.Traits)

	Conch.register("addbrainrot", {
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
				name = "Mutation"
			},
			{
				kind = "argument",
				type = "number",
				name = "Amount",
				optional = true
			},
			{
				kind = "argument",
				type = "Traits",
				name = "Traits",
				typeHint = "{ Trait? }",
				optional = true
			}
		end,

		callback = function(targetPlayer, brainrotName, mutation, amount, traits)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local spawnAmount = tonumber(amount)
			if not spawnAmount then
				traits = amount
				spawnAmount = 1
			end

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

			local traitTable = nil
			if traits ~= nil then
				if type(traits) ~= "table" then
					return false, 'Traits must be a table like { "Fire", "Taco" }'
				end

				traitTable = {}
				local seen = {}

				for _, trait in ipairs(traits) do
					if seen[trait] then
						return false, "Duplicate trait: " .. trait
					end
					seen[trait] = true

					if not TraitsData[trait] then
						return false, "Invalid trait: " .. trait
					end

					table.insert(traitTable, trait)
				end
			end

			local success, err = pcall(function()
				for i = 1, spawnAmount do
					AnimalService.spawnAnimalInBase(
						targetPlayer,
						brainrotName,
						cleanMutation,
						traitTable
					)
				end
			end)

			if not success then
				return false, "Failed to spawn brainrot: " .. tostring(err)
			end

			return "added"
		end
	})
end

return module