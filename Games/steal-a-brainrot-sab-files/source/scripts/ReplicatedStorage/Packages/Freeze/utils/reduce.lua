

local function reduce(t1: {[any]: any}, p1: ((...any) -> ...any), p2, b1: boolean)
	local v6 = #t1 + 1

	for v7, v8 in t1 do
		local v9 = v8

		if b1 then
			v9 = t1[v6 - v7]
		end

		p2 = p1(p2, v9, v7)
	end

	return p2
end

return reduce
