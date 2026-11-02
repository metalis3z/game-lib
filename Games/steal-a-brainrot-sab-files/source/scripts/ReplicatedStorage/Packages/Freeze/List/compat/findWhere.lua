

local find = require(script.Parent.Parent.find)
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning)

local function findWhere(t1: {[any]: any}, p1: ((...any) -> ...any), p2)
	assert(p2 == nil, "[Freeze] findWhere's `from` argument is not supported.")
	deprecationWarning("List." .. script.Name, "List.find")

	return find(t1, p1)
end

return findWhere
