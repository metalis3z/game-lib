local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local HttpService = game:GetService("HttpService")

	local Animals = require(ReplicatedStorage.Datas.Animals)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local Traits = require(ReplicatedStorage.Datas.Traits)

	local AnimalService = require(game.ServerScriptService.Services.AnimalService)

	Conch.register("spawnbrainrot", {
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

		callback = function(brainrot, mutation, amount, traits)
			amount = tonumber(amount) or 1
			if amount < 1 then
				return false, "Amount must be at least 1"
			end

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

			local validTraits = {}
			if traits ~= nil then
				if type(traits) ~= "table" then
					return false, "Traits must be a table: { \"Fireworks\" }"
				end

				for _, trait in ipairs(traits) do
					if Traits[trait] then
						table.insert(validTraits, trait)
					end
				end
			end

			for i = 1, amount do
				AnimalService.spawnAnimalCustom(
					AnimalData,
					mutParam,
					validTraits,
					nil,
					nil,
					nil
				)

				task.wait(0.05)
			end

			return "spawned"
		end,
	})
end

return module