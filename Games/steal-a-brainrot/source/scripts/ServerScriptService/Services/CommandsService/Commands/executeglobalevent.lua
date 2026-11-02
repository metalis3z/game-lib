local ServerScriptService = game:GetService("ServerScriptService")

local MSG_TYPE = "GlobalEvent"

-- Enregistrer le handler via MessagingHub
local function registerHandler()
	if not _G.MessagingHub then return end
	
	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if typeof(data) ~= "table" then return end

		local svc = require(ServerScriptService.Services.EventService)
		if not svc then
			warn("[GlobalEvent] EventService not initialised")
			return
		end

		if data.Cancel then
			if data.Event then
				svc:CancelEvent(data.Event)
			else
				svc:CancelAllEvents()
			end
			return
		end

		if data.Event then
			svc:ExecuteEvent(data.Event, data.Duration)
		end
	end)
end

-- Attendre que MessagingHub soit prêt
task.spawn(function()
	while not _G.MessagingHub do
		task.wait(0.5)
	end
	registerHandler()
end)

local module = function(Conch, Config)

	Conch.register("executeglobalevent", {
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
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					Event = eventName,
					Duration = tonumber(duration),
				})
			end
			return "executed"
		end,
	})

	Conch.register("cancelglobalevent", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "Event",
				name = "Event",
				optional = true,
			}
		end,
		callback = function(eventName)
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					Cancel = true,
					Event = eventName,
				})
			end
			return "cancelled"
		end,
	})
end

return module

