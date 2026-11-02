-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ReplicatedStorage/Source/Utils/NameCache.lua  (22 lines)
-- What it does: Tiny function that caches GetNameFromUserIdAsync results so boards and UIs do not call the web API repeatedly.

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
