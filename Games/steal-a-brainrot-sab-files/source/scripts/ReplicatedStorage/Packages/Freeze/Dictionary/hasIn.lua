

local getIn = require(script.Parent.Parent.utils.getIn)
local None = require(script.Parent.Parent.None)

local function hasIn(t1: {[any]: any}, t2: {[any]: any})
	return getIn(t1, t2, None) ~= None
end

return hasIn
