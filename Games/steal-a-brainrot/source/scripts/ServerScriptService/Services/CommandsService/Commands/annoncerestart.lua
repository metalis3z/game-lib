local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")

local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local CHANNEL = "GlobalServerRestart_01"
local subscribed = _G._sub_annoncerestart or false

local module = function(_, Config)

	Conch.register("globalrestart", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Duration",
			}
		end,

		callback = function(duration)
			duration = tonumber(duration)

			if not duration then
				return false, "Invalid duration"
			end

			local success, err = pcall(function()
				MessagingService:PublishAsync(CHANNEL, {
					Duration = duration,
				})
			end)

			if not success then
				return false, "Failed to publish global restart: " .. tostring(err)
			end

			return "Global restart started for " .. duration .. " seconds"
		end,
	})

	if not _G._sub_annoncerestart then
		_G._sub_annoncerestart = true
		subscribed = true

		MessagingService:SubscribeAsync(CHANNEL, function(message)
			local data = message.Data

			if typeof(data) ~= "table" or not data.Duration then
				return
			end

			local text = "?? ALL SERVERS ARE RESTARTING IN "
				.. tostring(data.Duration)
				.. " SECONDS...PLEASE BE PATIENT! (HSK)"

			for _, player in ipairs(Players:GetPlayers()) do
				NotificationEvent:FireClient(
					player,
					text,
					data.Duration,
					"Sounds.Sfx.Blop",
					"Top"
				)
			end
		end)
	end
end

return module
