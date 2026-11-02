local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local MessagingService = game:GetService("MessagingService")
	local Players = game:GetService("Players")
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local Net = require(ReplicatedStorage.Packages.Net)
	local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

	local function skipMachineForAllPlayers()
		for _, player in ipairs(Players:GetPlayers()) do
			pcall(function()
				local Data = Synchronizer:Get(player)
				if not Data then return end
				Data:Set("JungleMachineCooldown", os.time() - 3600)
				NotificationEvent:FireClient(
					player,
					"badr & Zynna a skip le temps de la crafting Machine !",
					5,
					"Sounds.Sfx.Success"
				)
			end)
		end
	end

	MessagingService:SubscribeAsync("GlobalSkipMachine", function(message)
		local data = message.Data
		if not data then return end
		if data.FromServer == game.JobId then return end
		if data.Skip then
			skipMachineForAllPlayers()
		end
	end)

	Conch.register("skipmachine", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return nil
		end,
		callback = function(context)
			skipMachineForAllPlayers()
			pcall(function()
				MessagingService:PublishAsync("GlobalSkipMachine", {
					FromServer = game.JobId,
					Skip = true
				})
			end)
			return "skipmachine done"
		end,
	})
end
return module