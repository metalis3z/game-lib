

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function removeSingle(t1: {[any]: any}, n1: number)
	local v6 = #t1
	local t2 = table.create(v6 - 1)

	if n1 < 1 then
		n1 += v6 + 1
	end

	if n1 <= 0 or v6 < n1 then
		return t1
	end

	local n2 = 1

	for v9, v10 in t1 do
		if v9 ~= n1 then
			t2[n2] = v10
			n2 += 1
		end
	end

	return t2
end
local function remove(t3: {[any]: any}, ...)
	local t4 = { ... }

	if #t4 == 1 then
		return (removeSingle(t3, t4[1]))
	end

	local n3 = 0
	local v14 = #t3
	local t5 = {}

	for _, v17 in t4 do
		local v18 = v17

		if v18 < 1 then
			v18 += v14 + 1
		end

		if not (v18 <= 0) and not (v14 < v18) then
			t5[v18] = true
			n3 += 1
		end
	end

	if n3 == 0 then
		return t3
	end

	local t6 = table.create((math.max(1, v14 - n3)))
	local n4 = 1

	for v21, v22 in t3 do
		if not t5[v21] then
			t6[n4] = v22
			n4 += 1
		end
	end

	return maybeFreeze(t6)
end

return remove
