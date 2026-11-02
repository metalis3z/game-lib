

local updateIn = require(script.Parent.updateIn)

return function(t1: {[any]: any}, p1, p2: ((...any) -> ...any), p3)
	return updateIn(t1, { p1 }, p2, p3)
end
