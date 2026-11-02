local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local MSG_TYPE = "Announce_v2"

local function broadcastLocally(text, executorUserId)
	for _, player in ipairs(Players:GetPlayers()) do
		NotificationEvent:FireClient(player, text, 5, nil, "Top", nil, nil, nil, executorUserId)
	end

	require(ReplicatedStorage.Controllers.SoundController):PlaySound(
		ReplicatedStorage.Sounds.Sfx.Blop
	)
end

-- Recevoir l'annonce sur TOUS les serveurs (y compris celui qui l'a envoyée)
if not _G._AnnounceSub then
	_G._AnnounceSub = true
	task.spawn(function()
		while not _G.MessagingHub do
			task.wait(0.5)
		end
		_G.MessagingHub.Register(MSG_TYPE, function(data)
			if type(data) ~= "table" or not data.Text then
				return
			end
			broadcastLocally(data.Text, data.ExecutorUserId)
		end)
	end)
end

local module = function(_, Config)
	Conch.register("announce", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "text",
			}
		end,

		callback = function(text)
			if not text or text == "" then
				return "You must provide announcement text"
			end

			local ctx = Conch.get_command_context()
			local executor = ctx and ctx.executor and ctx.executor.player
			local executorUserId = executor and executor.UserId

			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, { Text = text, ExecutorUserId = executorUserId })
			else
				-- MessagingHub pas encore prêt : on annonce au moins sur ce serveur
				broadcastLocally(text, executorUserId)
			end

			return "announced"
		end,
	})
end

return module