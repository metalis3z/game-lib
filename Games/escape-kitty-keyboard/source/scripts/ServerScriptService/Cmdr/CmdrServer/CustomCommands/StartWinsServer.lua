local ServerScriptService = game:GetService("ServerScriptService")
local WinsMultiplierManager = require(ServerScriptService:WaitForChild("WinsMultiplierManager"))

return function(context, multiplier, duration)
	if multiplier <= 0 then
		return "Le multiplicateur doit etre superieur a 0."
	end

	local executor = context.Executor
	local announceData = {
		text = string.format("Un admin a active le Wins x%s", tostring(multiplier)),
		senderName = executor and executor.Name or "Admin",
		senderUserId = executor and executor.UserId or 0,
		isOwner = false,
	}

	WinsMultiplierManager.Set(multiplier, (duration and duration > 0) and duration or nil, announceData)

	local msg = string.format("[EVENT] Multiplicateur de Wins defini sur x%s! (Tous les serveurs)", multiplier)
	if duration and duration > 0 then
		local hours = math.floor(duration / 3600)
		local mins = math.floor((duration % 3600) / 60)
		local secs = duration % 60
		local timeStr = ""
		if hours > 0 then timeStr = timeStr .. hours .. "h " end
		if mins > 0 then timeStr = timeStr .. mins .. "m " end
		if secs > 0 then timeStr = timeStr .. secs .. "s" end
		msg = msg .. string.format(" Duree: %s. Reset auto a la fin.", timeStr)
	end
	return msg
end