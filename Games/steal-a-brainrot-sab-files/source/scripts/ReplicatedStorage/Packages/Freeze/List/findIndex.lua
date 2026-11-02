

local findPair = require(script.Parent.Parent.utils.findPair)

local function findIndex(t1: {[any]: any}, p1: ((...any) -> ...any))
	local v5, _ = findPair(t1, p1)

	return v5
end

return findIndex
