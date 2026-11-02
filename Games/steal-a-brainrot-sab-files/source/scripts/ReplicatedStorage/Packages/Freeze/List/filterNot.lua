

local filter = require(script.Parent.filter)

local function filterNot(t1: {[any]: any}, p1: ((...any) -> ...any))
	return filter(t1, function(p2, p3)
		return not p1(p2, p3)
	end)
end

return filterNot
