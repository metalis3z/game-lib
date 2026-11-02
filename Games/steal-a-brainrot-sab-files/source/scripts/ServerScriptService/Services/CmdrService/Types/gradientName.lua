	local ReplicatedStorage = game:GetService("ReplicatedStorage")

return function(registry)
	local gradientTags = {
		"rainbow",
		"og",
		"yellowred",
		"zebra",
		"default",
		"festive",
		"radioactive"
	}

	local gradientType = {
		Transform = function(text)
			local matches = {}
			local lowerText = text:lower()

			for _, tag in ipairs(gradientTags) do
				if tag:lower():find(lowerText, 1, true) then
					table.insert(matches, tag)
				end
			end

			table.sort(matches, function(a, b)
				local aExact = a:lower() == lowerText
				local bExact = b:lower() == lowerText
				if aExact and not bExact then return true end
				if bExact and not aExact then return false end
				return a < b
			end)

			return matches
		end,

		Validate = function(matches)
			return #matches > 0, "No matching gradient tag found."
		end,

		Autocomplete = function(matches)
			return matches
		end,

		Parse = function(matches)
			return matches[1]
		end,
	}

	registry:RegisterType("gradientTag", gradientType)
end
