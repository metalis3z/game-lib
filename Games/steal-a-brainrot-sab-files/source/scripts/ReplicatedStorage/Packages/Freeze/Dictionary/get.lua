

local function get(t1: {[any]: any}, p1, p2)
	return t1[p1] or p2
end

return get
