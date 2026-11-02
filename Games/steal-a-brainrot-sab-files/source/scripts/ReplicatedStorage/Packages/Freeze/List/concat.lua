

local None = require(script.Parent.Parent.None)
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function concat(...)
	local t1 = {}
	local n1 = 1

	for i = 1, select("#", ...) do
		local v7 = select(i, ...)

		if v7 ~= nil and type(v7) == "table" and #v7 > 0 then
			for _, v in ipairs(v7) do
				if v ~= None then
					t1[n1] = v
					n1 += 1
				end
			end
		end
	end

	return maybeFreeze(t1)
end

return concat
