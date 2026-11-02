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

	Conch.register("cancelevent", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				{
					kind = "argument",
					type = "Event",
					name = "Event",
				},
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

		callback = function(eventName)
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

			-- 🔥 Cancelar o evento
			local success, err = pcall(function()
				if svc.CancelEvent then
					svc:CancelEvent(eventName)
				else
					-- caso o EventService use outro nome
					if svc.StopEvent then
						svc:StopEvent(eventName)
					else
						error("EventService has no CancelEvent or StopEvent function")
					end
				end
			end)

			return success, success and ("Event '" .. eventName .. "' cancelled") or ("Failed: " .. (err or "Unknown error"))
		end,
	})
end

return module
