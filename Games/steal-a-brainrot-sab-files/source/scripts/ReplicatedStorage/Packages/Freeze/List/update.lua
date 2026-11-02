

local updateIn = require(script.Parent.updateIn)

local function update(t1: {[any]: any}, n1: number, p1: ((...any) -> ...any), p2)
	return updateIn(t1, { n1 }, p1, p2)
end

return update
