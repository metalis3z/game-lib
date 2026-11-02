local ServerScriptService = game:GetService("ServerScriptService")
local LocalWinsMultiplierManager = require(ServerScriptService:WaitForChild("LocalWinsMultiplierManager"))

return function(context, target)
	local success = LocalWinsMultiplierManager.Reset(target)
	if not success then
		return "Player data not loaded."
	end

	return string.format("[EVENT] Local Wins multiplier reset to 1x for %s.", target.Name)
end