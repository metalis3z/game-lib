--THIS SCRIPT WAS MADE BY WILLY SO GIVE ME CREDIT WHEN U LEAK ENJOY!!
local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
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
					"k2miil skipped your <font color='#008CFF'>fuse timer</font>!",
					5,
					"Sounds.Sfx.Success"
				)
			end)
		end
	end

	Conch.register("serverfusereveal", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return nil
		end,

		callback = function(context)
			skipFuseForAllPlayers()
			return "revealed"
		end,
	})
end

return module