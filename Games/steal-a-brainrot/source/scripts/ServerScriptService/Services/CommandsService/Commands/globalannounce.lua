local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local MSG_TYPE = "GlobalAnnounce"

-- Enregistrer le handler via MessagingHub
local function registerHandler()
	if not _G.MessagingHub then return end
	
	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if not data or not data.Text then
			return
		end

		for _, player in ipairs(Players:GetPlayers()) do
			NotificationEvent:FireClient(player, data.Text, 5, nil, "Top")
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

local module = function(_, Config)
	Conch.register("globalannounce", {
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

			-- Envoyer via MessagingHub
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, { Text = text })
			end
			
			require(ReplicatedStorage.Controllers.SoundController):PlaySound(ReplicatedStorage.Sounds.Sfx.Blop)
			return "announced"
		end,
	})
end

return module