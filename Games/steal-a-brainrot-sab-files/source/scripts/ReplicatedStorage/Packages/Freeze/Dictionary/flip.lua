

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function flip(t1: {[any]: any})
	local t2 = {}

	for v5, v6 in t1 do
		t2[v6] = v5
	end

	return maybeFreeze(t2)
end

return flip
