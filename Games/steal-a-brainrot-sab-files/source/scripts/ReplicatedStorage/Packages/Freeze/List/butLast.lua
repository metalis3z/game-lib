

local slice = require(script.Parent.slice)

local function butLast(t1: {[any]: any})
	return slice(t1, 1, -1)
end

return butLast
