local EventService = require(game.ServerScriptService.Services.EventService)

return function(context, eventName, duration)
	duration = duration or 300
	local MainEvent = game.ReplicatedStorage.Controllers.EventController.Events:FindFirstChild(eventName)
	if not MainEvent then
		return "❌ This event does not exist."
	end

	local success, err = pcall(function()
		EventService:ExecuteEvent(eventName, duration)
	end)
	if not success then
		return "❌ Failed to start event: " .. tostring(err)
	end

	return "✅ Event '" .. eventName .. "' started for " .. tostring(duration) .. " seconds!"
end
