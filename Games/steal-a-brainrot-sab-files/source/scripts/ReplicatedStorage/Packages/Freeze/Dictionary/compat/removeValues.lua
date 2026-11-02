

local removeValue = require(script.Parent.Parent.removeValue)
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning)

local function removeValues(t1: {[any]: any}, ...)
	deprecationWarning("Dictionary." .. script.Name, "Dictionary.removeValue")

	return removeValue(t1, ...)
end

return removeValues
