

local count = require(script.Parent.Parent.utils.count)

local function count2(t1: {[any]: any}, p1: ((...any) -> ...any)?)
	return count(t1, p1)
end

return count2
