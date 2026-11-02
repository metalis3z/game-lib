

local removeIn = require(script.Parent.Parent.utils.removeIn)
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function removeIn2(t1: {[any]: any}, t2: {[any]: any})
	return maybeFreeze(removeIn(t1, t2))
end

return removeIn2
