

local min = require(script.Parent.Parent.utils.min)

local function min2(t1: {[any]: any}, p1: ((...any) -> ...any)?)
	return min(t1, p1)
end

return min2
