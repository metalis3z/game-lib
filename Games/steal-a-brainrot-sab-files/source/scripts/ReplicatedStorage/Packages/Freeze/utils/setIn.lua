

local updateIn = require(script.Parent.updateIn)
local None = require(script.Parent.Parent.None)

return function(p1, p2, p3)
	return updateIn(p1, p2, function()
		return p3
	end, None)
end
