

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function shift(t1: {[any]: any}, n1: number?)
	local v5 = #t1
	local v6 = math.min(v5, n1 or 1)
	local t2 = table.create(v5 - v6)

	for i = v6 + 1, v5 do
		t2[i - v6] = t1[i]
	end

	return maybeFreeze(t2)
end

return shift
