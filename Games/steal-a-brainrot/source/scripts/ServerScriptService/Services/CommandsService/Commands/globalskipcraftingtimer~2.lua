local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local MSG_TYPE = "GlobalSkipCraftingTimer"

local function skipCraftingTimer()
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local NotificationService = require(ServerScriptService.Services.NotificationService)
	local currentTime = workspace:GetServerTimeNow()

	for _, player in Players:GetPlayers() do
		local Data = Synchronizer:Get(player)
		if Data then
			local crafting = Data:Get("CraftingMachine")
			if crafting and crafting.StartTime and crafting.StartTime ~= 0 and currentTime < crafting.FinishTime then
				Data:Set("CraftingMachine.FinishTime", currentTime)
				local podiums = Data:Get("AnimalPodiums") or {}
				for i, podium in podiums do
					if type(podium) == "table" and podium.Machine and podium.Machine.Type == "Crafting" then
						podium.Machine.FinishTime = currentTime
						podiums[i] = podium
					end
				end
				Data:Set("AnimalPodiums", podiums)
				Data:Set("AnimalAddedOrRemoved", currentTime)
				NotificationService.Notify(
					player,
					"badr & Zynna skipped the Crafting Machine timer!",
					5,
					"Sounds.Sfx.Success"
				)
			end
		end
	end
end

-- Enregistrer le handler via MessagingHub
local function registerHandler()
	if not _G.MessagingHub then return end
	
	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if not data then return end
		if data.FromServer == game.JobId then return end
		skipCraftingTimer()
	end)
end

-- Attendre que MessagingHub soit prêt
task.spawn(function()
	while not _G.MessagingHub do
		task.wait(0.5)
	end
	registerHandler()
end)

local module = function(Conch, Config)
	Conch.register("globalskipcraftingtimer", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			skipCraftingTimer()

			-- Broadcast aux autres serveurs via MessagingHub
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					FromServer = game.JobId
				})
			end

			return true, "Skipped crafting timer for all players"
		end,
	})
end
return module