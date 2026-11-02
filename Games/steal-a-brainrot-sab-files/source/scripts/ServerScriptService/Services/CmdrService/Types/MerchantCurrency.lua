return function(registry)
	local VALID = { "elf", "brotinho" }

	local merchantCurrencyType = {
		Transform = function(text)
			local lowerText = text:lower()
			local matches = {}
			for _, currency in ipairs(VALID) do
				if currency:find(lowerText, 1, true) then
					table.insert(matches, currency)
				end
			end
			table.sort(matches, function(a, b)
				local aExact = a == lowerText
				local bExact = b == lowerText
				if aExact and not bExact then return true end
				if bExact and not aExact then return false end
				return a < b
			end)
			return matches
		end,

		Validate = function(matches)
			return #matches > 0, "Currency must be 'elf' or 'brotinho'."
		end,

		Autocomplete = function(matches)
			return matches
		end,

		Parse = function(matches)
			return matches[1]
		end,
	}

	registry:RegisterType("merchantCurrency", merchantCurrencyType)
end
