local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FFlags = require(ReplicatedStorage.Packages.FFlags)

local function parseValue(valueStr)
	if valueStr == "nil" or valueStr == "null" then
		return nil
	end
	if valueStr == "true" then return true end
	if valueStr == "false" then return false end
	local asNumber = tonumber(valueStr)
	if asNumber then return asNumber end
	return valueStr
end

return function(context, key, defaultStr)
	local defaultValue = parseValue(defaultStr)
	local value = FFlags:GetInstant(key, defaultValue)

	local valueType = typeof(value)
	local valueDisplay = if value == nil then "nil" else tostring(value)

	return `FFlag '{key}' = {valueDisplay} ({valueType})`
end