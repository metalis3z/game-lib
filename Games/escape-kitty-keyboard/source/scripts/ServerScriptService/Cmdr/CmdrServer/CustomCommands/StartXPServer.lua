local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local XPMultiplierManager = require(ServerScriptService:WaitForChild("XPMultiplierManager"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AdminAnnounce = Remotes:WaitForChild("AdminAnnounce")

return function(context, multiplier, duration)
	if multiplier <= 0 then
		return "Le multiplicateur doit etre superieur a 0."
	end

	local executor = context.Executor
	local announceData = {
		text = string.format("Un admin a active le XP x%s", tostring(multiplier)),
		senderName = executor and executor.Name or "Admin",
		senderUserId = executor and executor.UserId or 0,
		isOwner = false,
	}

	XPMultiplierManager.Set(multiplier, (duration and duration > 0) and duration or nil, announceData)

	local msg = string.format("[EVENT] Multiplicateur d'XP defini sur x%s! (Tous les serveurs)", multiplier)
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