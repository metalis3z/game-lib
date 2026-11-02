local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")

	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local MutationsData = require(ReplicatedStorage.Datas.Mutations)
	local AnimalService = require(ServerScriptService.Services.AnimalService)

	Conch.register("addchancebrainrot", {
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
			},
			{
				kind = "argument",
				type = "number",
				name = "Chance",
			}
		end,

		callback = function(targetPlayer, brainrotName, mutation, chance)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local rollPercentage = tonumber(chance)
			if not rollPercentage or rollPercentage < 1 or rollPercentage > 100 then
				return false, "Chance must be 1-100"
			end

			if not AnimalsData[brainrotName] then
				return false, ("Brainrot '%s' not found."):format(tostring(brainrotName))
			end

			local cleanMutation = nil
			if mutation and mutation ~= "" and mutation ~= "Default" and mutation ~= "Normal" then
				if not MutationsData[mutation] then
					return false, ("Mutation '%s' not found."):format(tostring(mutation))
				end
				cleanMutation = mutation
			end

			local roll = math.random(1, 100)

			if roll <= rollPercentage then
				local success, err = pcall(function()
					AnimalService.spawnAnimalInBase(
						targetPlayer,
						brainrotName,
						cleanMutation,
						{}
					)
				end)

				if success then
					return ("Lucky! Rolled %d/%d. Added %s to %s's base."):format(roll, rollPercentage, brainrotName, targetPlayer.Name)
				else
					return false, "Error adding to base: " .. tostring(err)
				end
			else
				return ("Unlucky! Rolled %d (Needed %d or lower)."):format(roll, rollPercentage)
			end
		end
	})
end

return module