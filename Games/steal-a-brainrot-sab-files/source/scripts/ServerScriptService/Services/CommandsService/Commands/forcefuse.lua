local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local HttpService = game:GetService("HttpService")

	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local Animals = require(ReplicatedStorage.Datas.Animals)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local Traits = require(ReplicatedStorage.Datas.Traits)

	Conch.register("forcefuse", {
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
				optional = true
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
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

		callback = function(player, brainrot, mutation, traits)
			if not Animals[brainrot] then
				return false, ("Brainrot '%s' not found"):format(tostring(brainrot))
			end

			if mutation ~= nil and mutation ~= "" and mutation ~= "Normal" then
				if not Mutations[mutation] then
					return false, ("Mutation '%s' not found"):format(tostring(mutation))
				end
			else
				mutation = nil
			end

			local validTraits = nil
			if traits ~= nil then
				if type(traits) ~= "table" then
					return false, 'Traits must be a table like { "Fire", "Fast" }'
				end

				validTraits = {}
				for _, trait in ipairs(traits) do
					if not Traits[trait] then
						return false, ("Trait '%s' not found"):format(trait)
					end
					table.insert(validTraits, trait)
				end
			end

			local channel = Synchronizer:Get(player)
			if not channel then
				return false, "Player channel not found"
			end

			channel:Set("FuseMachine.ForcedBrainrot", {
				Animal = brainrot,
				Mutation = mutation,
				Traits = validTraits
			})

			return "forced"
		end,
	})
end

return module