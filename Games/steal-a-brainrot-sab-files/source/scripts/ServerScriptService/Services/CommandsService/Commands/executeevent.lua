local module = function(Conch, Config)
	Conch.register("executeevent", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "Event",
					name = "Event",
				},
			{
				kind = "argument",
				type = "number",
				name = "Duration",
				optional = true,
			}
		end,
		callback = function(eventName, duration)
			local svc = require(game:GetService("ServerScriptService").Services.EventService)
			if not svc then
				return false, "EventService not initialised"
			end
			local ok = svc:ExecuteEvent(eventName, duration)
			return "executed"
		end,
	})
end

return module