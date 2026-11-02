local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Animals = require(ReplicatedStorage.Datas.Animals)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local AnimalService = require(game.ServerScriptService.Services.AnimalService)

	Conch.register("spawnfakebrainrot", {
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
			local AnimalData
			for _, data in pairs(Animals) do
				if data.DisplayName == brainrot or data.Name == brainrot then
					AnimalData = data
					break
				end
			end
			if not AnimalData then
				return false, ("Brainrot '%s' not found."):format(tostring(brainrot))
			end

			local mutParam
			if mutation ~= nil and mutation ~= "" and mutation ~= "Normal" then
				if not Mutations[mutation] then
					return false, ("Mutation '%s' not found."):format(tostring(mutation))
				end
				mutParam = mutation
			end

			AnimalService.spawnFakeAnimal(AnimalData, mutParam)

			return "fake brainrot spawned !"
		end,
	})
end

return module