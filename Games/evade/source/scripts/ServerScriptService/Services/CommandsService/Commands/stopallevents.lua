local module = function(Conch, Config)
	Conch.register("stopallevents", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				{
					kind = "argument",
					type = "number",
					name = "Duration",
					optional = true,
				}
			}
		end,
		callback = function(duration)
			local svc = require(game:GetService("ServerScriptService").Services.EventService)
			if not svc then
				return false, "EventService not initialized"
			end

			if not game:GetService("ReplicatedStorage"):GetAttribute("EventsLoaded") then
				return false, "EventService not fully loaded"
			end

			local events = {}
			for eventName, _ in pairs(svc.EventConfigs) do
				table.insert(events, eventName)
			end

			if #events == 0 then
				return false, "No events available to start"
			end

			local results = {}
			for _, eventName in ipairs(events) do
				if not string.find(eventName, "Phase") then
					local success, err = pcall(function()
						svc:CancelEvent(eventName)
					end)
				end
			end

			return true, table.concat(results, "\n")
		end,
	})
end

return module