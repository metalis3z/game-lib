

local findPair = require(script.Parent.Parent.utils.findPair)

local function findKey(t1: {[any]: any}, p1: ((...any) -> ...any), p2)
	local v6, _ = findPair(t1, p1)

	if v6 == nil then
		return p2
	end

	return v6
end

return findKey
