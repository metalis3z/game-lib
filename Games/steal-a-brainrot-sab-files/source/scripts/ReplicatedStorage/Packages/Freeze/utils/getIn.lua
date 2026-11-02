

local None = require(script.Parent.Parent.None)
local get = require(script.Parent.get)

return function(t1: {[any]: any}, t2: {[any]: any}, p1)
	local n1 = 0

	repeat
		if n1 == #t2 then
			return t1
		end

		n1 += 1
		t1 = get(t1, t2[n1], None)
	until t1 == None

	return p1
end
