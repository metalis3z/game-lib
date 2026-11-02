local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FFlags = require(ReplicatedStorage.Packages.FFlags)

local function parseValue(valueStr)
	if valueStr == "nil" or valueStr == "null" then
		return nil
	end

	if valueStr == "true" then
		return true
	elseif valueStr == "false" then
		return false
	end

	local asNumber = tonumber(valueStr)
	if asNumber then
		return asNumber
	end

	return valueStr
end

return function(context, key, valueStr)
	local value = parseValue(valueStr)



	local success, err = pcall(function()
		FFlags:Set(key, value)
	end)

	if not success then
		return `Failed to set FFlag: {err}`
	end

	local valueType = typeof(value)
	local valueDisplay = if value == nil then "nil" else tostring(value)

	return `Set FFlag '{key}' = {valueDisplay} ({valueType})'`
end