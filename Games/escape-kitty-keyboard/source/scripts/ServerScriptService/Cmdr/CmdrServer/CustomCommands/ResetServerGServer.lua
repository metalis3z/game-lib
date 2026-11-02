local ServerScriptService = game:GetService("ServerScriptService")
local XPMultiplierManager = require(ServerScriptService:WaitForChild("XPMultiplierManager"))
local WinsMultiplierManager = require(ServerScriptService:WaitForChild("WinsMultiplierManager"))

return function(context)
	local executor = context.Executor
	local announceData = {
		text = "Tous les events (XP et Wins) ont ete desactives sur tous les serveurs",
		senderName = executor and executor.Name or "Admin",
		senderUserId = executor and executor.UserId or 0,
		isOwner = false,
	}

	XPMultiplierManager.Reset(announceData)
	WinsMultiplierManager.Reset(announceData)

	return "Reset global effectue: XP et Wins remis a x1 sur tous les serveurs."
end