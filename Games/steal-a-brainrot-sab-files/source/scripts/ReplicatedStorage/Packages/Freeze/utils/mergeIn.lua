

local updateIn = require(script.Parent.updateIn)
local merge = require(script.Parent.merge)

return function(t1: {[any]: any}, p1, ...)
	local t2 = { ... }

	return updateIn(t1, p1, function(p2)
		return merge(p2, table.unpack(t2))
	end, {})
end
