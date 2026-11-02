

local equalObjects = require(script.Parent.equalObjects)

local function compareDeep(p1, p2)
	if type(p1) ~= "table" or type(p2) ~= "table" then
		return p1 == p2
	end

	for k, v in pairs(p1) do
		if not compareDeep(p2[k], v) then
			return false
		end
	end

	for k, v in pairs(p2) do
		if not compareDeep(p1[k], v) then
			return false
		end
	end

	return true
end
local function equalsDeep(...)
	if equalObjects(...) then
		return true
	end

	local v10 = select("#", ...)
	local v11 = select(1, ...)

	for i = 2, v10 do
		local v13 = select(i, ...)

		if not compareDeep(v11, v13) then
			return false
		end
	end

	return true
end

return equalsDeep
