local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local MessagingService = game:GetService("MessagingService")
	local Players = game:GetService("Players")

	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local Net = require(ReplicatedStorage.Packages.Net)
	local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

	local function skipFuseForAllPlayers()
		for _, player in ipairs(Players:GetPlayers()) do
			pcall(function()
				local Data = Synchronizer:Get(player)
				if not Data then return end

				local FuseMachine = Data:Get("FuseMachine")
				if not FuseMachine then return end
				if not FuseMachine.StartTime or FuseMachine.StartTime == 0 then return end

				Data:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow())

				NotificationEvent:FireClient(
					player,
					"ADMIN HARDER skipped your <font color='#CE4D4C'>fuse timer</font>!",
					5,
					"Sounds.Sfx.Success"
				)
			end)
		end
	end

	MessagingService:SubscribeAsync("GlobalFuseReveal", function(message)
		local data = message.Data
		if not data then return end
		if data.FromServer == game.JobId then return end

		if data.Reveal then
			skipFuseForAllPlayers()
		end
	end)

	Conch.register("globalfusereveal", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return nil
		end,

		callback = function(context)
			skipFuseForAllPlayers()

			pcall(function()
				MessagingService:PublishAsync("GlobalFuseReveal", {
					FromServer = game.JobId,
					Reveal = true
				})
			end)

			return "revealed"
		end,
	})
end

return module