local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local MSG_TYPE = "GlobalFuseReveal"

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
				"Admin Kaizou skipped your <font color='#FFD13B'>fuse timer</font>!",
				5,
				"Sounds.Sfx.Success"
			)
		end)
	end
end

-- Enregistrer le handler via MessagingHub
local function registerHandler()
	if not _G.MessagingHub then return end
	
	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if not data then return end
		if data.FromServer == game.JobId then return end

		if data.Reveal then
			skipFuseForAllPlayers()
		end
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
	Conch.register("globalfusereveal", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return nil
		end,

		callback = function(context)
			skipFuseForAllPlayers()

			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					FromServer = game.JobId,
					Reveal = true
				})
			end

			return "revealed"
		end,
	})
end

return module