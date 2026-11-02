

local set = require(script.Parent.Parent.utils.set)
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function set2(t1: {[any]: any}, p1, p2)
	if p1 == nil then
		return t1
	end

	return maybeFreeze(set(t1, p1, p2))
end

return set2
