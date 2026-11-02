--THIS SCRIPT WAS MADE BY WILLY GIVE CREDIT IF YOU LEAK

module = function(Conch, Config)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Animals = require(ReplicatedStorage.Datas.Animals)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local Traits = require(ReplicatedStorage.Datas.Traits)

	local AnimalService = require(game.ServerScriptService.Services.AnimalService)

	local TOPIC = "GLOBAL_BRAINROT_SPAWN"

	--THIS SCRIPT WAS MADE BY WILLY GIVE CREDIT IF YOU LEAK
	_G.MessagingHub.Register(TOPIC, function(message)

		local data = message.Data
		local brainrot = data.brainrot
		local mutation = data.mutation
		local amount = tonumber(data.amount) or 1

		local AnimalData
		for _, v in pairs(Animals) do
			if v.DisplayName == brainrot or v.Name == brainrot then
				AnimalData = v
				break
			end
		end

		if not AnimalData then
			return
		end

		local mutParam
		if mutation and mutation ~= "Normal" then
			if Mutations[mutation] then
				mutParam = mutation
			end
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

	end)

	--THIS SCRIPT WAS MADE BY WILLY GIVE CREDIT IF YOU LEAK
	Conch.register("spawnbrainrotglobalalltraits", {

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

			_G.MessagingHub.Publish(TOPIC, {
				brainrot = brainrot,
				mutation = mutation,
				amount = amount
			})

			return "Global spawn sent to all servers"

		end,
	})

end

return module