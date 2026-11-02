

local get = require(script.Parent.get)

local function last(t1: {[any]: any}, p1)
	return get(t1, -1, p1)
end

return last
