local module = function(Conch, Config)
	Conch.register("startfakeevent", {
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
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local ServerScriptService = game:GetService("ServerScriptService")

			-- Set the fake event flag - this tells the game not to actually give brainrots
			ReplicatedStorage:SetAttribute("FakeEventActive", true)
			ReplicatedStorage:SetAttribute("FakeEventName", eventName)

			local svc = require(ServerScriptService.Services.EventService)
			if not svc then
				ReplicatedStorage:SetAttribute("FakeEventActive", nil)
				ReplicatedStorage:SetAttribute("FakeEventName", nil)
				return false, "EventService not initialised"
			end

			local ok = svc:ExecuteEvent(eventName, duration)
			return "Fake event '" .. eventName .. "' started - traits/mutations will NOT be applied to brainrots!"
		end,
	})
end

return module