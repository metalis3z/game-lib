

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function pop(t1: {[any]: any}, n1: number?)
	local v5 = math.max(1, n1 or 1)
	local v6 = #t1
	local t2 = table.create(v6)

	for i = 1, v6 - v5 do
		t2[i] = t1[i]
	end

	return maybeFreeze(t2)
end

return pop
