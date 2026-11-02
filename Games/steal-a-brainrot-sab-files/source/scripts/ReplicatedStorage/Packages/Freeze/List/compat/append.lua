

local push = require(script.Parent.Parent.push)
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning)

local function append(t1: {[any]: any}, ...)
	deprecationWarning("List." .. script.Name, "List.push")

	return push(t1, ...)
end

return append
