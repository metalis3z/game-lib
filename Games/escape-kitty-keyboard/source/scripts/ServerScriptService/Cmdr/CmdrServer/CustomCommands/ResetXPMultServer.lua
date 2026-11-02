local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local XPMultiplierManager = require(ServerScriptService:WaitForChild("XPMultiplierManager"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AdminAnnounce = Remotes:WaitForChild("AdminAnnounce")

return function(context)
	local executor = context.Executor
	local announceData = {
		text = "Le bonus XP est maintenant d\u{e9}sactiv\u{e9}",
		senderName = executor and executor.Name or "Admin",
		senderUserId = executor and executor.UserId or 0,
		isOwner = false,
	}

	-- Reset + broadcast to all servers via MessagingService
	XPMultiplierManager.Reset(announceData)

	return "Global XP multiplier reset to 1x. (All servers)"
end