

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function flatten(t1: {[any]: any}, n1: number?)
	local t2 = {}
	local n2 = 1

	for _, v8 in t1 do
		if type(v8) == "table" and (not n1 or n1 > 0) then
			local v9 = flatten(v8, n1 and n1 - 1)

			for i = 1, #v9 do
				t2[n2] = v9[i]
				n2 += 1
			end
		else
			t2[n2] = v8
			n2 += 1
		end
	end

	return maybeFreeze(t2)
end

return flatten
