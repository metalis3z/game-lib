local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")
	local Net = require(ReplicatedStorage.Packages.Net)
	local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local AnimalService = require(game.ServerScriptService.Services.AnimalService)

	local MUTATION_NAMES = {}
	for name, _ in pairs(Mutations) do
		table.insert(MUTATION_NAMES, name)
	end

	local function getRandomMutation()
		return MUTATION_NAMES[math.random(1, #MUTATION_NAMES)]
	end

	local function sendScreenMessage(amount)
		local msg = "Admin activated <font color='#ff00ff'><b>Mutation Rain</b></font> for the next <font color='#ffff00'><b>" .. tostring(amount) .. "</b></font> Brainrots!"
		for _, p in ipairs(Players:GetPlayers()) do
			NotificationEvent:FireClient(p, msg, 6, nil, nil)
		end
	end

	local function executeMutationRain(amount)
		task.spawn(function()
			for i = 1, amount do
				local animal = AnimalService.randomAnimal()
				if animal then
					AnimalService.spawnAnimalCustom(
						animal,
						getRandomMutation(),
						{}, nil, nil, nil
					)
				end
				task.wait(0.1)
			end
		end)
	end

	-- Cross-serveur via MessagingHub
	if not _G._sub_mutationrain then
		_G._sub_mutationrain = true
		if _G.MessagingHub then
			_G.MessagingHub.Register("MutationRainGlobal", function(data)
				if not data or not data.Amount then return end
				sendScreenMessage(data.Amount)
				executeMutationRain(data.Amount)
			end)
		end
	end

	Conch.register("mutationrain", {
		permissions = { Config.RequiredRole or "super-user" },
		description = "Lance une pluie de mutations aleatoires sur ce serveur",
		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Amount",
			}
		end,
		callback = function(amount)
			amount = math.clamp(math.floor(tonumber(amount) or 50), 1, 500)
			sendScreenMessage(amount)
			executeMutationRain(amount)
			return "ok"
		end,
	})

	Conch.register("mutationrainglobal", {
		permissions = { Config.RequiredRole or "super-user" },
		description = "Lance une pluie de mutations aleatoires sur TOUS les serveurs",
		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Amount",
			}
		end,
		callback = function(amount)
			amount = math.clamp(math.floor(tonumber(amount) or 50), 1, 500)
			if _G.MessagingHub then
				_G.MessagingHub.Publish("MutationRainGlobal", { Amount = amount })
			end
			return "ok"
		end,
	})
end

return module