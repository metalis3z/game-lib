local Players = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

return function(context, reason)
	local executor = context.Executor

	if not executor then
		return "❌ This command must be run by a player with permissions."
	end

	if not reason or reason == "" then
		return "❌ You must provide a shutdown reason."
	end	

	local notifyText = string.format("<font color='#ff5555'>Server Shutdown:</font> %s", reason)

	-- Send notification
	for _, player in ipairs(Players:GetPlayers()) do
		NotificationEvent:FireClient(player, notifyText, 10, "Sounds.Sfx.Unlock", "Bottom")
	end

	-- Send shutdown message globally
	MessagingService:PublishAsync("GlobalShutdownEvent", reason)

	-- Kick everyone after 2.5s
	task.delay(2.5, function()
		for _, player in ipairs(Players:GetPlayers()) do
			player:Kick("Server Shutdown: " .. reason)
		end
	end)

	return "✅ Initiated global shutdown."
end
