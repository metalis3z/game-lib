

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function sort(t1: {[any]: any}, p1: ((...any) -> ...any)?)
	local v5 = table.clone(t1)

	table.sort(v5, p1)

	return maybeFreeze(v5)
end

return sort
