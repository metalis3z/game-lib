local ServerScriptService = game:GetService("ServerScriptService")
local XPMultiplierManager = require(ServerScriptService:WaitForChild("XPMultiplierManager"))
local WinsMultiplierManager = require(ServerScriptService:WaitForChild("WinsMultiplierManager"))

return function(context)
	local executor = context.Executor
	local announceData = {
		text = "Les events (XP et Wins) ont ete desactives sur ce serveur",
		senderName = executor and executor.Name or "Admin",
		senderUserId = executor and executor.UserId or 0,
		isOwner = false,
	}

	XPMultiplierManager.ResetLocal(announceData)
	WinsMultiplierManager.ResetLocal(announceData)

	return "Reset local effectue: XP et Wins remis a x1 sur ce serveur uniquement."
end