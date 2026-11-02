

local set = require(script.Parent.Parent.utils.set)
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function remove(t1: {[any]: any}, ...)
	local v5 = table.clone(t1)

	for _, v7 in { ... } do
		v5 = set(v5, v7, nil)
	end

	return maybeFreeze(v5)
end

return remove
