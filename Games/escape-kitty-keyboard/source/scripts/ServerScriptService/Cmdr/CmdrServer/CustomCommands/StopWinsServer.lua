local ServerScriptService = game:GetService("ServerScriptService")
local WinsMultiplierManager = require(ServerScriptService:WaitForChild("WinsMultiplierManager"))

return function(context)
	local executor = context.Executor
	local announceData = {
		text = "Le bonus Wins est maintenant desactive",
		senderName = executor and executor.Name or "Admin",
		senderUserId = executor and executor.UserId or 0,
		isOwner = false,
	}

	WinsMultiplierManager.Reset(announceData)

	return "Multiplicateur de Wins desactive (x1). (Tous les serveurs)"
end