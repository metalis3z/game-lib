--Hi! , This Code Was Made by FaypleStudios , by owner @fayple1
--pls do not steal my code , good luck with using it
--pushserverluck script was obsusfucated bc this script is so op
--dm me to buy this command script [200-250 robux , if im in a good mood 100-150]


local module = function(Conch, Config)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local HttpService = game:GetService("HttpService")

	local Animals = require(ReplicatedStorage.Datas.Animals)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local Traits = require(ReplicatedStorage.Datas.Traits)

	local AnimalService = require(game.ServerScriptService.Services.AnimalService)

	local WEBHOOK_URL = "https://discord.com/api/webhooks/REDACTED"

	local SECRETS = {}
	for name, data in pairs(Animals) do
		if data.Rarity == "Secret" then
			table.insert(SECRETS, name)
		end
	end

	local function pickRandom()
		if #SECRETS == 0 then return nil end
		return SECRETS[math.random(#SECRETS)]
	end

	Conch.register("randomsecret", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {}
		end,

		callback = function()

			local animalName = pickRandom()
			if not animalName then
				return false, "No secret brainrots found."
			end

			local animalData = Animals[animalName]

			pcall(function()
				AnimalService.spawnAnimalCustom(animalData, nil, nil, nil)
			end)

			return "Spawned secret brainrot: " .. animalName
		end
	})

end

return module
