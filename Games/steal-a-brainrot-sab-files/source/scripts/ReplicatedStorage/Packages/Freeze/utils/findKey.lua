

local findPair = require(script.Parent.findPair)

return function(t1: {[any]: any}, p1)
	local v4, _ = findPair(t1, p1)

	return v4
end
