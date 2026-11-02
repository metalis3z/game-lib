

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function unshift(t1: {[any]: any}, ...)
	local v4 = select("#", ...)
	local v5 = table.clone(t1)

	for i = v4, 1, -1 do
		table.insert(v5, 1, (select(i, ...)))
	end

	return maybeFreeze(v5)
end

return unshift
