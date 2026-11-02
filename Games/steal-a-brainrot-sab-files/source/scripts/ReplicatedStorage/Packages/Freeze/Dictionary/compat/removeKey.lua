

local remove = require(script.Parent.Parent:FindFirstChild("remove"))
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning)

local function removeKey(t1: {[any]: any}, p1)
	deprecationWarning("Dictionary." .. script.Name, "Dictionary.remove")

	return remove(t1, p1)
end

return removeKey
