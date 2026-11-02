local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Animals = require(ReplicatedStorage.Datas.Animals)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local AnimalService = require(game.ServerScriptService.Services.AnimalService)

	local GLOBAL_TOPIC = "GlobalSpawnFakeBrainrot_V1"

	local function runLocalSpawn(brainrotName, mutationName)
		local AnimalData
		for _, data in pairs(Animals) do
			if data.DisplayName == brainrotName or data.Name == brainrotName then
				AnimalData = data
				break
			end
		end

		if AnimalData then
			local mutParam
			if mutationName ~= nil and mutationName ~= "" and mutationName ~= "Normal" then
				if Mutations[mutationName] then
					mutParam = mutationName
				end
			end
			AnimalService.spawnFakeAnimal(AnimalData, mutParam)
		end
	end

	_G.MessagingHub.Register(GLOBAL_TOPIC, function(message)
		local data = message.Data
		if data and data.brainrot then
			runLocalSpawn(data.brainrot, data.mutation)
		end
	end)

	Conch.register("globalfakebrainrot", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
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
			}
		end,
		callback = function(brainrot, mutation)
			local found = false
			for _, data in pairs(Animals) do
				if data.DisplayName == brainrot or data.Name == brainrot then
					found = true
					break
				end
			end

			if not found then
				return false
			end

			pcall(function()
				_G.MessagingHub.Publish(GLOBAL_TOPIC, {
					brainrot = brainrot,
					mutation = mutation
				})
			end)

			return true
		end,
	})
end

return module