

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function flattenImpl(t1: {[any]: any}, n1: number?)
	local t2 = {}

	for v7, v8 in t1 do
		if type(v8) == "table" and (not n1 or n1 > 0) then
			local v9 = flattenImpl(v8, n1 and n1 - 1)

			for k, v in pairs(t2) do
				v9[k] = v
			end

			t2 = v9
		else
			t2[v7] = v8
		end
	end

	return t2
end
local function flatten(t3: {[any]: any}, n2: number?)
	return maybeFreeze((flattenImpl(t3, n2)))
end

return flatten
