

local remove = require(script.Parent.Parent:FindFirstChild("remove"))
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning)

local function removeIndex(t1: {[any]: any}, n1: number)
	deprecationWarning("List." .. script.Name, "List.remove")

	return remove(t1, n1)
end

return removeIndex
