local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)

return function(registry)
	local nonEmptySlotType = {
		Transform = function(text, player)
			if not player then
				return {}
			end

			local slots = {}

			local _, result = pcall(function()
				return Net:RemoteFunction("NonEmptySlots/Get"):InvokeServer()
			end)

			if result and typeof(result) == "table" then
				slots = result
			end

			local stringSlots = {}
			for _, slot in ipairs(slots) do
				table.insert(stringSlots, tostring(slot))
			end

			table.sort(stringSlots, function(a, b)
				local aNum = tonumber(a)
				local bNum = tonumber(b)
				return aNum < bNum
			end)

			if not text or text == "" then
				return stringSlots
			end

			local lowerText = text:lower()
			local matchingSlots = {}

			for _, slot in ipairs(stringSlots) do
				if slot:lower():find(lowerText, 1, true) then
					table.insert(matchingSlots, slot)
				end
			end

			return matchingSlots
		end,

		Validate = function(slots)
			return #slots > 0, "No non-empty slots found."
		end,

		Autocomplete = function(slots)
			return slots
		end,

		Parse = function(slots)
			return tonumber(slots[1])
		end,
	}

	registry:RegisterType("nonEmptySlot", nonEmptySlotType)
end
