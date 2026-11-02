

local some = require(script.Parent.Parent.utils.some)

local function some2(t1: {[any]: any}, p1: ((...any) -> ...any))
	return some(t1, p1)
end

return some2
