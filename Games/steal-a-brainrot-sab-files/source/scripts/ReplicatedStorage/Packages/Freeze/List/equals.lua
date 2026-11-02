

local equals = require(script.Parent.Parent.utils.equals)

local function equals2(t1: {[any]: any}, p1)
	return equals(t1, p1)
end

return equals2
