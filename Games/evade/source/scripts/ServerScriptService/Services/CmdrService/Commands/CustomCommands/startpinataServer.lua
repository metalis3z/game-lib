local ServerScriptService = game:GetService("ServerScriptService")
local TurkeyService = require(ServerScriptService.Services.PinataService)

return function(context, duration)
	duration = duration or 300

	local success, result, turkeyId = pcall(function()
		return TurkeyService:PinataSpawn(duration)
	end)

	if not success then
		return "❌ Failed to start turkey event: " .. tostring(result)
	end

	return result
end