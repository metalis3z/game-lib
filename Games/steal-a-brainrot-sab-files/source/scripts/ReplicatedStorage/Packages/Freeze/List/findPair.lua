

local findPair = require(script.Parent.Parent.utils.findPair)

local function findPair2(t1: {[any]: any}, p1: ((...any) -> ...any))
	return findPair(t1, p1)
end

return findPair2
