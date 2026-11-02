

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function filter(t1: {[any]: any}, p1: ((...any) -> ...any))
	local t2 = {}

	for v6, v7 in t1 do
		if p1(v7, v6) == true then
			t2[v6] = v7
		end
	end

	return maybeFreeze(t2)
end

return filter
