local Players = game:GetService("Players")

local Cache = {}

return function(userId: number): string?
	local cached = Cache[userId]
	if cached then
		return cached
	end

	local name
	local success = pcall(function()
		name = Players:GetNameFromUserIdAsync(userId)
	end)

	if success and name then
		Cache[userId] = name
		return name
	end

	return nil
end