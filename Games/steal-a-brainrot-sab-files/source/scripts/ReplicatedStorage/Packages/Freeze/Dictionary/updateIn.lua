

local updateIn = require(script.Parent.Parent.utils.updateIn)
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function updateIn2(t1: {[any]: any}, t2: {[any]: any}, p1: ((...any) -> ...any), p2)
	return maybeFreeze(updateIn(t1, t2, p1, p2))
end

return updateIn2
