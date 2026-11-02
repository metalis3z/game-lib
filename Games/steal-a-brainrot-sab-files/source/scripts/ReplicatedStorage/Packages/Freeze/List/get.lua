

local function get(t1: {[any]: any}, n1: number, p1)
	if type(n1) == "number" and n1 < 0 then
		n1 = #t1 + (n1 + 1)
	end

	return t1[n1] or p1
end

return get
