local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local function setLuck(luck: number?, executioner)
	if not luck then
		luck = 1
		return false, "Invalid luck value, setting to 1"
	end

	game.ReplicatedStorage:SetAttribute("FuseMachineLuck", luck)
	local ServerScriptService = game:GetService("ServerScriptService")
	local EventService = require(ServerScriptService.Services.EventService)
	EventService:ExecuteEvent("Fuse Machine Luck", 900)

	for _, player in pairs(game:GetService("Players"):GetPlayers()) do
		
	end

	return true, "success!"
end

MessagingService:SubscribeAsync("GlobalLuck", function(message)
	local data = message.Data
	if data.FromServer == game.JobId then return end

	local ok, result = setLuck(data.Luck, data.Executor.Name)
	if not ok then
		warn("couldn't set,", result)
	end
end)

return function(context, luck)
	local ok, result = setLuck(luck, context.Executor.Name)
	if not ok then
		return "❌ " .. result
	end

	local publishOk, publishErr = pcall(function()
		MessagingService:PublishAsync("GlobalLuck", {
			Luck = luck,
			FromServer = game.JobId,
			Executor = context.Executor.Name
		})
	end)

	if not publishOk then
		warn(publishErr)
		return "set locally but failed to set globally: " .. tostring(publishErr)
	end

	return "Set luck to ".. luck .. "! (globally btw no local command yet)"
end
