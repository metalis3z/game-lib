

local update = require(script.Parent.Parent.utils.update)
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function update2(t1: {[any]: any}, p1, p2: ((...any) -> ...any), p3)
	return maybeFreeze(update(t1, p1, p2, p3))
end

return update2
