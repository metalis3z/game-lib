

local getIn = require(script.Parent.Parent.utils.getIn)

local function getIn2(t1: {[any]: any}, t2: {[any]: any}, p1)
	return getIn(t1, t2, p1)
end

return getIn2
