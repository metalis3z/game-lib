

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function zip(...)
	local v3 = select(1, ...)
	local t1 = {}
	local v5 = select("#", ...)

	if v5 <= 0 then
		return t1
	end

	local v6 = #v3

	for i = 2, v5 do
		local v8 = #select(i, ...)

		if v8 < v6 then
			v6 = v8
		end
	end

	for i = 1, v6 do
		t1[i] = {}

		for j = 1, v5 do
			local v11 = select(j, ...)

			t1[i][j] = v11[i]
		end
	end

	return maybeFreeze(t1)
end

return zip
