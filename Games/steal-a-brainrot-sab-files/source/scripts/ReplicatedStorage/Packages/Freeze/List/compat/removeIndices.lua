

local remove = require(script.Parent.Parent:FindFirstChild("remove"))
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning)

local function removeIndices(t1: {[any]: any}, ...)
	deprecationWarning("List." .. script.Name, "List.remove")

	return remove(t1, ...)
end

return removeIndices
