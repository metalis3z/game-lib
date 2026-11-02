

local every = require(script.Parent.Parent.utils.every)

local function every2(t1: {[any]: any}, p1: ((...any) -> ...any))
	return every(t1, p1)
end

return every2
