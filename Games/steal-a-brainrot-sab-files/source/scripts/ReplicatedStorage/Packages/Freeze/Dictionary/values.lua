

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function values(t1: {[any]: any})
	local t2 = {}

	for _, v6 in t1 do
		table.insert(t2, v6)
	end

	return maybeFreeze(t2)
end

return values
