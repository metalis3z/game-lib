local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Animals = require(ReplicatedStorage.Datas.Animals)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local Traits = require(ReplicatedStorage.Datas.Traits)
	local AnimalService = require(game.ServerScriptService.Services.AnimalService)
	Conch.register("spawnbrainrotalltraits", {
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
			},
			{
				kind = "argument",
				type = "number",
				name = "Amount",
				optional = true
			}
		end,
		callback = function(brainrot, mutation, amount)
			amount = tonumber(amount) or 1
			local AnimalData
			for _, data in pairs(Animals) do
				if data.DisplayName == brainrot or data.Name == brainrot then
					AnimalData = data
					break
				end
			end
			if not AnimalData then
				return false, "Brainrot not found"
			end
			local mutParam
			if mutation and mutation ~= "Normal" then
				if not Mutations[mutation] then
					return false, "Mutation not found"
				end
				mutParam = mutation
			end
			local allTraits = {}

			for traitName,_ in pairs(Traits) do
				table.insert(allTraits, traitName)
			end

			for i = 1, amount do

				AnimalService.spawnAnimalCustom(
					AnimalData,
					mutParam,
					allTraits,
					nil,
					nil,
					nil
				)

				task.wait(0.05)

			end

			return "Spawned with ALL traits"

		end,
	})

end

return module