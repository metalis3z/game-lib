

local setIn = require(script.Parent.Parent.utils.setIn)
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function setIn2(t1: {[any]: any}, t2: {[any]: any}, p1)
	return maybeFreeze(setIn(t1, t2, p1))
end

return setIn2
