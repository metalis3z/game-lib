local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventsFolder = ReplicatedStorage:WaitForChild("Controllers").EventController.Events

return function(registry)
	local eventNameType = {
		Transform = function(text)
			local eventNames = {}
			local matchingEvents = {}

			for _, eventObject in ipairs(EventsFolder:GetChildren()) do
				table.insert(eventNames, eventObject.Name)
			end

			local lowerText = text:lower()
			for _, eventName in ipairs(eventNames) do
				if eventName:lower():find(lowerText, 1, true) then
					table.insert(matchingEvents, eventName)
				end
			end

			table.sort(matchingEvents, function(a, b)
				local aExact = a:lower() == lowerText
				local bExact = b:lower() == lowerText
				if aExact and not bExact then return true end
				if bExact and not aExact then return false end
				return a < b
			end)

			return matchingEvents
		end,
		Validate = function(events)
			return #events > 0, "No event with that name could be found."
		end,
		Autocomplete = function(events)
			return events
		end,
		Parse = function(events)
			return events[1]
		end,
	}
	registry:RegisterType("eventName", eventNameType)
end