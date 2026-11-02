

local slice = require(script.Parent.Parent.utils.slice)
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function slice2(t1: {[any]: any}, n1: number?, n2: number?)
	return maybeFreeze(slice(t1, n1, n2))
end

return slice2
