

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function removeValue(t1: {[any]: any}, p1)
	local t2 = {}
	local v6 = false

	for v7, v8 in t1 do
		if v8 == p1 then
			v6 = true
		else
			t2[v7] = v8
		end
	end

	if v6 then
		return (maybeFreeze(t2))
	end

	return t1
end

return removeValue
