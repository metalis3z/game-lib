

local includes = require(script.Parent.Parent.utils.includes)

local function includes2(t1: {[any]: any}, p1)
	return includes(t1, p1)
end

return includes2
