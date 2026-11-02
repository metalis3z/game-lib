--!strict

local function deepEquals(valueA: any, valueB: any): boolean
	if valueA == valueB then
		return true
	end
	if typeof(valueA) ~= "table" or typeof(valueB) ~= "table" then
		return false
	end
	for key, subValueA in valueA :: {[any]: any} do
		if not deepEquals(subValueA, (valueB :: {[any]: any})[key]) then
			return false
		end
	end
	for key in valueB :: {[any]: any} do
		if (valueA :: {[any]: any})[key] == nil then
			return false
		end
	end
	return true
end

return deepEquals
