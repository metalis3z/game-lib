local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local XPMultiplierManager = require(ServerScriptService:WaitForChild("XPMultiplierManager"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AdminAnnounce = Remotes:WaitForChild("AdminAnnounce")

return function(context)
	local executor = context.Executor
	local announceData = {
		text = "Le bonus XP est maintenant desactive",
		senderName = executor and executor.Name or "Admin",
		senderUserId = executor and executor.UserId or 0,
		isOwner = false,
	}

	XPMultiplierManager.Reset(announceData)

	return "Multiplicateur d'XP desactive (x1). (Tous les serveurs)"
end