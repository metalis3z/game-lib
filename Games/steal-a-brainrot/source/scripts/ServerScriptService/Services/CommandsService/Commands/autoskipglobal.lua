local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local MSG_TYPE = "GlobalFuseReveal"

-- Variables pour l'auto-skip
local autoSkipEnabled = false
local autoSkipInterval = 60

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
				"<font color='#FFD13B'>badr & Zynna Skiped Fuse timer skipped</font>!",
				5,
				"Sounds.Sfx.Success"
			)
		end)
	end
end

local function broadcastGlobalSkip()
	skipFuseForAllPlayers()

	if _G.MessagingHub then
		_G.MessagingHub.Publish(MSG_TYPE, {
			FromServer = game.JobId,
			Reveal = true
		})
	end
end

local function startAutoSkip()
	if autoSkipEnabled and autoSkipInterval > 0 then
		task.spawn(function()
			while autoSkipEnabled do
				task.wait(autoSkipInterval)
				if autoSkipEnabled then
					broadcastGlobalSkip()
				end
			end
		end)
	end
end

local function stopAutoSkip()
	autoSkipEnabled = false
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

		if data.AutoSkipEnable then
			if data.Enabled then
				autoSkipEnabled = true
				autoSkipInterval = data.Interval or 60
				startAutoSkip()
			else
				stopAutoSkip()
			end
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
	-- Commande pour activer l'auto-skip
	Conch.register("autoskipglobal", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "boolean",
					name = "Enable",
				},
			{
					kind = "argument",
					type = "number",
					name = "Interval",
					optional = true,
				}
		end,

		callback = function(enable, interval)
			if enable then
				if interval and interval > 0 then
					autoSkipInterval = interval
				end

				autoSkipEnabled = true
				startAutoSkip()

				-- Broadcast aux autres serveurs via MessagingHub
				if _G.MessagingHub then
					_G.MessagingHub.Publish(MSG_TYPE, {
						FromServer = game.JobId,
						AutoSkipEnable = true,
						Enabled = true,
						Interval = autoSkipInterval
					})
				end

				return string.format("Auto-skip enabled! Skipping fuse every %d seconds.", autoSkipInterval)
			else
				stopAutoSkip()

				-- Broadcast aux autres serveurs via MessagingHub
				if _G.MessagingHub then
					_G.MessagingHub.Publish(MSG_TYPE, {
						FromServer = game.JobId,
						AutoSkipEnable = true,
						Enabled = false
					})
				end

				return "Auto-skip disabled."
			end
		end,
	})

	-- Commande pour skipper manuellement une fois
	Conch.register("skipfuse", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return nil
		end,

		callback = function()
			broadcastGlobalSkip()
			return "Fuse skipped for all players!"
		end,
	})

	-- Commande pour voir le statut de l'auto-skip
	Conch.register("autoskipstatus", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return nil
		end,

		callback = function()
			if autoSkipEnabled then
				return string.format("Auto-skip is ENABLED - Interval: %d seconds", autoSkipInterval)
			else
				return "Auto-skip is DISABLED"
			end
		end,
	})
end

return module