local MessagingService = game:GetService("MessagingService")

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

	local function listeventsformatted()
		local svc = require(game:GetService("ServerScriptService").Services.EventService)
		if not svc then
			return false, "EventService not initialized"
		end
		if not game:GetService("ReplicatedStorage"):GetAttribute("EventsLoaded") then
			return false, "EventService not fully loaded"
		end
		local events = {}
		for eventName, config in pairs(svc.EventConfigs) do
			table.insert(events, string.format("%s (Duration: %s)", eventName, tostring(config.Duration)))
		end
		if #events == 0 then
			return false, "No events available"
		end
		return true, events
	end

	Conch.register("executeglobalevent", {
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
					optional = true,
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
				MessagingService:PublishAsync("4a6b4703-251a-4564-8840-0169367d6827", {
					Event = eventName,
					Duration = duration,
				})
			end)
			return success, success and "Global event published" or ("Failed to publish global event: " .. (err or "Unknown error"))
		end,
	})

	Conch.register("listevents", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			local success, result = listeventsformatted()
			if success then
				return true, "Available events:\n" .. table.concat(result, "\n")
			end
			return false, result
		end,
	})

	task.spawn(function()
		MessagingService:SubscribeAsync("4a6b4703-251a-4564-8840-0169367d6827", function(message)
			local data = message.Data
			if typeof(data) == "table" and data.Event then
				local svc = require(game:GetService("ServerScriptService").Services.EventService)
				if svc and game:GetService("ReplicatedStorage"):GetAttribute("EventsLoaded") and svc.EventConfigs[data.Event] then
					local success, err = pcall(function()
						svc:ExecuteEvent(data.Event, data.Duration)
					end)
					if success then
						print("[GlobalEvent] Started event:", data.Event, "Duration:", data.Duration or "Default")
					else
						warn("[GlobalEvent] Failed to start event:", data.Event, "Error:", tostring(err))
					end
				else
					warn("[GlobalEvent] EventService not initialized, not loaded, or event not found:", data.Event)
				end
			end
		end)
	end)
end

return module