local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local MessagingService = game:GetService("MessagingService")
	local Players = game:GetService("Players")
	local ServerScriptService = game:GetService("ServerScriptService")

	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local Net = require(ReplicatedStorage.Packages.Net)
	local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

	local function skipCupidForAllPlayers()
		for _, player in ipairs(Players:GetPlayers()) do
			pcall(function()
				local Data = Synchronizer:Get(player)
				if not Data then return end

				local cupids = Data:Get("CupidsMachine")
				if not cupids then return end
				if not cupids.StartTime or cupids.StartTime == 0 then return end

				local currentTime = workspace:GetServerTimeNow()
				if currentTime >= cupids.FinishTime then return end

				cupids.FinishTime = currentTime
				Data:Set("CupidsMachine", cupids)

				NotificationEvent:FireClient(
					player,
					"Nova skipped your <font color='#d943ff'>Cupid's Machine</font> timer!",
					5,
					"Sounds.Sfx.Success"
				)
			end)
		end
	end

	MessagingService:SubscribeAsync("GlobalCupidSkip", function(message)
		local data = message.Data
		if not data then return end
		if data.FromServer == game.JobId then return end

		if data.Skip then
			skipCupidForAllPlayers()
		end
	end)

	Conch.register("globalskipcupid", {
		permissions = { Config.RequiredRole or "super-user" },

		description = "Skip Cupid's Machine timer for ALL players on ALL servers",

		arguments = function()
			return nil
		end,

		callback = function()
			skipCupidForAllPlayers()

			pcall(function()
				MessagingService:PublishAsync("GlobalCupidSkip", {
					FromServer = game.JobId,
					Skip = true
				})
			end)

			return "[GLOBAL] Skipped all Cupid's Machine timers on all servers!"
		end,
	})

	Conch.register("skipcupidglobal", {
		alias = "globalskipcupid"
	})
end
return module