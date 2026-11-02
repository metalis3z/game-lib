local module = function(Conch, Config)
	local function listevents()
		local svc = require(game:GetService("ServerScriptService").Services.EventService)
		if not svc or not game:GetService("ReplicatedStorage"):GetAttribute("EventsLoaded") then
			return {}
		end
		local events = {}
		for eventName, _ in pairs(svc.EventConfigs) do
			table.insert(events, eventName)
		end
		return events
	end

	Conch.register("executeevent", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				{
					kind = "argument",
					type = "Event",
					name = "Event",
				},
				{
					kind = "argument",
					type = "number",
					name = "Duration",
				}
			}
		end,
		argumentChoices = function()
			return {
				{
					name = "Event",
					choices = listevents(),
				}
			}
		end,
		callback = function(eventName, duration)
			local svc = require(game:GetService("ServerScriptService").Services.EventService)
			if not svc then
				return false, "EventService not initialized"
			end
			if not game:GetService("ReplicatedStorage"):GetAttribute("EventsLoaded") then
				return false, "EventService not fully loaded"
			end
			if not svc.EventConfigs[eventName] then
				return false, "Event not found"
			end
			local success, err = pcall(function()
				svc:ExecuteEvent(eventName, duration)
			end)
			return success, success and "executed" or ("Failed to execute event: " .. (err or "Unknown error"))
		end,
	})
end

return module