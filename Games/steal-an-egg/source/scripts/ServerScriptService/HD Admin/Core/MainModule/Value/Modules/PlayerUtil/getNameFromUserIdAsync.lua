local Players = game:GetService("Players")
local nameCache: {[number]: string} = {}

return function(userId: number | string): (boolean, string)
	local id = tonumber(userId)
	if not id then
		return false, "Invalid UserId"
	end
	for _, player in Players:GetPlayers() do
		if player.UserId == id then
			nameCache[id] = player.Name
			return true, player.Name
		end
	end
	local cached = nameCache[id]
	if cached then
		return true, cached
	end
	local success, result = pcall(function()
		return Players:GetNameFromUserIdAsync(id)
	end)
	if success and typeof(result) == "string" then
		nameCache[id] = result
		return true, result
	end
	return false, tostring(result)
end
