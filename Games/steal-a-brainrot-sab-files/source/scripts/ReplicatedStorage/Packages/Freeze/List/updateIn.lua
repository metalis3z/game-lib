

local utils = script.Parent.Parent.utils
local updateIn = require(utils.updateIn)
local maybeFreeze = require(utils.maybeFreeze)

return function(t1: {[any]: any}, t2: {[any]: any}, p1: ((...any) -> ...any), p2)
	return maybeFreeze(updateIn(t1, t2, p1, p2))
end
