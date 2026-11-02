local EventService = require(game.ServerScriptService.Services.EventService)

return function(context, duration)
	duration = duration or 300

	local success, err = pcall(function()
		for i, v in pairs(game.ServerScriptService.Services.EventService.Events:GetChildren()) do
			if v:IsA("ModuleScript") then
				EventService:CancelEvent(v.Name, duration)
			end
		end
	end)
	
	if not success then
		return "❌ Failed to stop event: " .. tostring(err)
	end

	return "✅ Events stopped"
end
