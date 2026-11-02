--> Variables
local _L = _G._L

local Services
local Tracker
local TableUtility
local ArrayUtility
local Ranks
local AttributeUtility
local Constants

--> Constants

---------->
local AuraUtility

AuraUtility = {
	getInfo = function(auraName)
		local _, auraInfo = TableUtility.match(Auras, function(i, v)
			return typeof(v) == "table" and v.name == auraName
		end)

		return auraInfo
	end,
	
	_init = function()
		Auras = _L.Get {"Common", "Modules", "Databases", "Auras"}
		TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
		ArrayUtility = _L.Get {"Common", "Library", "Utilities", "ArrayUtility"}
		AttributeUtility = _L.Get {"Common", "Library", "Utilities", "AttributeUtility"}
		Constants = _L.Get {"Common", "Modules", "Constants"}
	end
}

return AuraUtility