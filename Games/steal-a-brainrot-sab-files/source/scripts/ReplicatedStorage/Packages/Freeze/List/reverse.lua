

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function reverse(t1: {[any]: any})
	local v4 = #t1
	local t2 = table.create(v4)
	local v6 = v4 + 1

	for v7, _ in t1 do
		t2[v7] = t1[v6 - v7]
	end

	return maybeFreeze(t2)
end

return reverse
