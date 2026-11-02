local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Net = require(ReplicatedStorage.Packages.Net)
local AnnouncementService = require(ServerScriptService.Services.AnnouncementService)

local announcefunction = Net:RemoteFunction("AnnounceServer")
local globalfunction = Net:RemoteFunction("AnnounceGlobal")

announcefunction.OnServerInvoke = function(player, message, customName)
	return AnnouncementService.AnnounceToServer(player, message, customName)
end

globalfunction.OnServerInvoke = function(player, message, gradient)
	return AnnouncementService.PromptGlobalPurchase(player, message, gradient)
end

return function(context, text, jobid)
	AnnouncementService.BroadcastGlobal(context.Executor, text, nil, jobid)
	return string.format("Sent global announcement as %s", context.Executor.DisplayName)
end