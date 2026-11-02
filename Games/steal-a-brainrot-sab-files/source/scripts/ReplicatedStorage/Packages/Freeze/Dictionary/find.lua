

local findPair = require(script.Parent.Parent.utils.findPair)

local function find(t1: {[any]: any}, p1: ((...any) -> ...any), p2)
	local _, v7 = findPair(t1, p1)

	if v7 == nil then
		return p2
	end

	return v7
end

return find
