

local slice = require(script.Parent.slice)

local function takeLast(t1: {[any]: any}, n1: number)
	return slice(t1, -math.max(1, n1))
end

return takeLast
