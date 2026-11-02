

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function keys(t1: {[any]: any})
	local t2 = {}

	for v5, _ in t1 do
		table.insert(t2, v5)
	end

	return maybeFreeze(t2)
end

return keys
