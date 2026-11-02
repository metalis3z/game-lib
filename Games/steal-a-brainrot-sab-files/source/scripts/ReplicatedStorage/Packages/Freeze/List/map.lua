

local map = require(script.Parent.Parent.utils.map)
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function map2(t1: {[any]: any}, p1: ((...any) -> ...any))
	return maybeFreeze(map(t1, p1))
end

return map2
