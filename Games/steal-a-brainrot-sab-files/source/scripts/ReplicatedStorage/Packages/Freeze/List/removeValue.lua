

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)
local toSet = require(script.Parent.toSet)

local function removeValues(t1: {[any]: any}, ...)
	local v6 = toSet({ ... })
	local t2 = {}
	local n1 = 1
	local v9 = false

	for _, v in ipairs(t1) do
		if not v6[v] then
			t2[n1] = v
			n1 += 1
		else
			v9 = true
		end
	end

	if v9 then
		return (maybeFreeze(t2))
	end

	return t1
end
local function removeValue(t3: {[any]: any}, ...)
	local t4 = { ... }

	if #t4 == 1 then
		local v14 = t4[1]
		local t5 = table.create(#t3)
		local v16 = false

		for _, v18 in t3 do
			if v18 == v14 then
				v16 = true
			else
				table.insert(t5, v18)
			end
		end

		if v16 then
			return (maybeFreeze(t5))
		end

		return t3
	end

	return removeValues(t3, ...)
end

return removeValue
