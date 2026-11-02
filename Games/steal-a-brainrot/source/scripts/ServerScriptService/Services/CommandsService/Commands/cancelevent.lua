local module = function(Conch, Config)
	Conch.register("cancelevent", {
		permissions = { Config.RequiredRole or "limited-commands" },
		arguments = function()
			return {
				kind = "argument",
				type = "Event",
				name = "Event",
			}
		end,
		callback = function(eventName, duration)
			local svc = require(game:GetService("ServerScriptService").Services.EventService)
			if not svc then
				return "EventService not initialized"
			end
			if not game:GetService("ReplicatedStorage"):GetAttribute("EventsLoaded") then
				return "EventService not fully loaded"
			end
			if not svc.EventConfigs[eventName] then
				return "Event not found"
			end
			local success, err = pcall(function()
				svc:CancelEvent(eventName, duration)
			end)
			return success and "canceled" or "failed to stop event"
		end,
	})
end

return module