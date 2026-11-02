

local None = require(script.Parent.Parent.None)

return function(...)
	local t1 = {}

	for i = 1, select("#", ...) do
		local v4 = select(i, ...)

		if v4 ~= nil then
			assert(type(v4) == "table", "Expected table")

			for v5, v6 in v4 do
				if v6 == None then
					t1[v5] = nil
				else
					t1[v5] = v6
				end
			end
		end
	end

	return t1
end
