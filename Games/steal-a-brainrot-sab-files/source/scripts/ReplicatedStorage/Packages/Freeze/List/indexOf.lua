

local keyOf = require(script.Parent.Parent.utils.keyOf)

local function indexOf(t1: {[any]: any}, p1)
	local v5 = keyOf(t1, p1)

	if v5 == nil then
		return nil
	end

	return v5
end

return indexOf
