local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local Animals = require(ReplicatedStorage.Datas.Animals)
	local IndexData = require(ReplicatedStorage.Datas.Index)

	Conch.register("unlockindex", {
		permissions = { Config.RequiredRole or "limited-commands" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "string",
				name = "Mutation (optional)",
				optional = true,
			}
		end,

		callback = function(player, mutationId)
			if not player then
				return false, "Player not found"
			end

			local channel
			for i = 1, 20 do
				channel = Synchronizer:Get(player)
				if channel then break end
				task.wait(0.1)
			end

			if not channel then
				return false, "Player data not ready"
			end

			local index = channel:Get("Index") or {}
			mutationId = mutationId or "Default"

			local mutationData = IndexData[mutationId]
			local structuredIndex = mutationData and mutationData.Index

			if structuredIndex then
				for animalId in pairs(structuredIndex) do
					index[animalId] = index[animalId] or {}

					if mutationData and mutationData.CustomIndex then
						index[animalId][mutationData.CustomIndex.Name] = true
					elseif mutationData and not mutationData.IsMutation then
						index[animalId]["Default"] = true
					else
						index[animalId][mutationId] = true
					end
				end
			else
				for animalId in pairs(Animals) do
					index[animalId] = index[animalId] or {}
					index[animalId][mutationId] = true
				end
			end

			channel:Set("Index", index)

			return "Index unlocked for " .. mutationId
		end
	})
end

return module