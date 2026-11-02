

local reverse = require(script.Parent.Parent.reverse)
local find = require(script.Parent.Parent.find)
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning)

local function findWhereLast(t1: {[any]: any}, p1: ((...any) -> ...any), p2)
	assert(p2 == nil, "[Freeze] findWhereLast's `from` argument is not supported.")
	deprecationWarning("List." .. script.Name, "List.reverse and then List.find")

	local v8 = reverse(t1)

	return find(v8, p1)
end

return findWhereLast
