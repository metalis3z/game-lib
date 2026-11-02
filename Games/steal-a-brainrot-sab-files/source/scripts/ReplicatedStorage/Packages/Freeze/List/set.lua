

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function set(t1: {[any]: any}, n1: number, p1)
	if p1 == t1[n1] then
		return t1
	end

	local v6 = table.clone(t1)

	v6[n1] = p1

	return maybeFreeze(v6)
end

return set
