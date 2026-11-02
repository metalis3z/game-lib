local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")

local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local CHANNEL = "b82db150-528f-4042-a0b5-ad6aaf1a5c3333"

MessagingService:SubscribeAsync(CHANNEL, function(message)
	local data = message.Data
	if not data or not data.Text then
		return
	end

	local gradientText = string.format("<zebra>%s</zebra>", data.Text)

	for _, player in ipairs(Players:GetPlayers()) do
		NotificationEvent:FireClient(player, gradientText, 5, nil, "Top")
	end
end)

local module = function(_, Config)
	Conch.register("zebraannounce", {
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

			MessagingService:PublishAsync(CHANNEL, { Text = text })
			require(ReplicatedStorage.Controllers.SoundController):PlaySound(
				ReplicatedStorage.Sounds.Sfx.Blop
			)

			return "announced"
		end,
	})
end

return module