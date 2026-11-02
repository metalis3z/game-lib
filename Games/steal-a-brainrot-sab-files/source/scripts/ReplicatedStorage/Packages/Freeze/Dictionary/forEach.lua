

local forEach = require(script.Parent.Parent.utils.forEach)

local function forEach2(t1: {[any]: any}, p1: ((...any) -> ...any))
	return forEach(t1, p1)
end

return forEach2
