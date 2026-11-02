local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalWinsMultiplierManager = require(ServerScriptService:WaitForChild("LocalWinsMultiplierManager"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AdminAnnounce = Remotes:WaitForChild("AdminAnnounce")

return function(context, target, multiplier, duration)
	if multiplier <= 0 then
		return "Multiplier must be greater than 0."
	end

	if not duration or duration <= 0 then
		return "Duration is required and must be greater than 0."
	end

	local success = LocalWinsMultiplierManager.Set(target, multiplier, duration)
	if not success then
		return "Player data not loaded."
	end

	-- Announce to all players
	local executor = context.Executor
	AdminAnnounce:FireAllClients({
		text = string.format("Un admin a activ\u{e9} le Wins x%s pour %s", tostring(multiplier), target.Name),
		senderName = executor and executor.Name or "Admin",
		senderUserId = executor and executor.UserId or 0,
		isOwner = false,
	})

	local msg = string.format("[EVENT] Local Wins multiplier set to %sx for %s!", multiplier, target.Name)
	local hours = math.floor(duration / 3600)
	local mins = math.floor((duration % 3600) / 60)
	local secs = duration % 60
	local timeStr = ""
	if hours > 0 then timeStr = timeStr .. hours .. "h " end
	if mins > 0 then timeStr = timeStr .. mins .. "m " end
	if secs > 0 then timeStr = timeStr .. secs .. "s" end
	msg = msg .. string.format(" Duration: %s. Auto-resets when timer expires.", timeStr)
	return msg
end