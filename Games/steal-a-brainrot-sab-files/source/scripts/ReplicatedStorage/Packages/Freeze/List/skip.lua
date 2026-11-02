

local slice = require(script.Parent.slice)

local function skip(t1: {[any]: any}, n1: number)
	return slice(t1, (math.max(1, n1 + 1)))
end

return skip
