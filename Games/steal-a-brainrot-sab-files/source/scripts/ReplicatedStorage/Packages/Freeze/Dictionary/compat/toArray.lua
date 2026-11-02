

local values = require(script.Parent.Parent.values)
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning)

local function toArray(t1: {[any]: any})
	deprecationWarning("Dictionary." .. script.Name, "Dictionary.values")

	return values(t1)
end

return toArray
