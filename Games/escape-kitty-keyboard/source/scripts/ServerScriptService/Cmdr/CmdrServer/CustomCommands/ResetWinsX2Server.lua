local ServerScriptService = game:GetService("ServerScriptService")
local WinsMultiplierManager = require(ServerScriptService:WaitForChild("WinsMultiplierManager"))

return function(context)
	local executor = context.Executor
	local announceData = {
		text = "Le Wins x2 event a \u{e9}t\u{e9} arr\u{ea}t\u{e9}",
		senderName = executor and executor.Name or "Admin",
		senderUserId = executor and executor.UserId or 0,
		isOwner = false,
	}

	WinsMultiplierManager.Reset(announceData)
	return "[EVENT] Global Wins multiplier reset to 1x. x2 Wins event ended. (All servers)"
end