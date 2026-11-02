-- Reference copy for study. Game: Aura Ascension (UPD 3) (aura-ascension)
-- Original: ServerScriptService/GameServer/Core/RateLimiter.lua  (39 lines)
-- What it does: Allow(player, key, cooldown) returns false (and the time left) until the cooldown for that key has passed; Forget(player) on leave.

local RateLimiter = {}
RateLimiter.__index = RateLimiter

function RateLimiter.new()
	return setmetatable({
		records = {},
	}, RateLimiter)
end

function RateLimiter:Allow(player, key, cooldown)
	if typeof(player) ~= "Instance" then
		return false
	end

	cooldown = tonumber(cooldown) or 0
	local now = os.clock()
	local userId = player.UserId
	local userRecord = self.records[userId]
	if not userRecord then
		userRecord = {}
		self.records[userId] = userRecord
	end

	local nextAllowed = userRecord[key] or 0
	if nextAllowed > now then
		return false, nextAllowed - now
	end

	userRecord[key] = now + cooldown
	return true, 0
end

function RateLimiter:Forget(player)
	if typeof(player) == "Instance" then
		self.records[player.UserId] = nil
	end
end

return RateLimiter
