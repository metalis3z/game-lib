

local findKey = require(script.Parent.findKey)
local is = require(script.Parent.is)

return function(p1, p2)
	return findKey(p1, function(p3)
		return is(p3, p2)
	end)
end
