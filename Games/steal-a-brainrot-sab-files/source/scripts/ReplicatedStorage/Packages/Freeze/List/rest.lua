

local slice = require(script.Parent.slice)

local function rest(t1: {[any]: any})
	return slice(t1, 2)
end

return rest
