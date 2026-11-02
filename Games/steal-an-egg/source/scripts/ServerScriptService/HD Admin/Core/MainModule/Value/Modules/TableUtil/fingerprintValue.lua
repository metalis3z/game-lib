--!strict

-- Dictionary keys are sorted so two tables with equal contents always
-- produce the same string
local function fingerprintValue(value: any): string
	local valueType = typeof(value)
	if valueType == "table" then
		local keys: {any} = {}
		for key in value :: {[any]: any} do
			table.insert(keys, key)
		end
		table.sort(keys, function(keyA, keyB)
			return tostring(keyA) < tostring(keyB)
		end)
		local parts: {string} = {}
		for _, key in keys do
			table.insert(parts, tostring(key) .. "=" .. fingerprintValue((value :: {[any]: any})[key]))
		end
		return "{" .. table.concat(parts, ",") .. "}"
	end
	if valueType == "Color3" then
		return (value :: Color3):ToHex()
	end
	return tostring(value)
end

return fingerprintValue
