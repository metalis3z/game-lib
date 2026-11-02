

local function count(t1: {[any]: any}, p1: ((...any) -> ...any)?)
	local n1 = 0

	for v5, v6 in t1 do
		if p1 == nil or p1(v6, v5) then
			n1 += 1
		end
	end

	return n1
end

return count
