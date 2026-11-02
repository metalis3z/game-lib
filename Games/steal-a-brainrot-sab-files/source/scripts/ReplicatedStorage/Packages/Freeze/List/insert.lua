

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function insert(t1: {[any]: any}, n1: number, ...)
	local v5 = #t1

	if n1 < 1 then
		n1 = v5 + n1
	end

	local v6 = math.clamp(n1, 1, v5 + 1)
	local t2 = {}
	local n2 = 1

	for i = 1, v5 + 1 do
		if i == v6 then
			for j = 1, select("#", ...) do
				t2[n2] = select(j, ...)
				n2 += 1
			end
		end

		t2[n2] = t1[i]
		n2 += 1
	end

	return maybeFreeze(t2)
end

return insert
