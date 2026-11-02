

local max = require(script.Parent.Parent.utils.max)

local function max2(t1: {[any]: any}, p1: ((...any) -> ...any)?)
	return max(t1, p1)
end

return max2
