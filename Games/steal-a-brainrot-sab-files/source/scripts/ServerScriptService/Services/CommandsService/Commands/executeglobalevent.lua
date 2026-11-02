local MessagingService = game:GetService("MessagingService")

local TOPIC = "4a6b4703-251a-4564-8840-0169367d6827"
local subscribed = false

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
			local success, err = pcall(function()
				MessagingService:PublishAsync(TOPIC, {
					Event = eventName,
					Duration = tonumber(duration),
				})
			end)

			if not success then
				return false, "Failed to publish global event: " .. tostring(err)
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
			local success, err = pcall(function()
				MessagingService:PublishAsync(TOPIC, {
					Cancel = true,
					Event = eventName,
				})
			end)

			if not success then
				return false, "Failed to cancel global event: " .. tostring(err)
			end

			return "cancelled"
		end,
	})

	if not subscribed then
		subscribed = true

		MessagingService:SubscribeAsync(TOPIC, function(message)
			local data = message.Data
			if typeof(data) ~= "table" then return end

			local svc = require(game:GetService("ServerScriptService").Services.EventService)
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
end

return module