

local mergeIn = require(script.Parent.Parent.utils.mergeIn)
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function mergeIn2(t1: {[any]: any}, t2: {[any]: any}, ...)
	return maybeFreeze(mergeIn(t1, t2, ...))
end

return mergeIn2
