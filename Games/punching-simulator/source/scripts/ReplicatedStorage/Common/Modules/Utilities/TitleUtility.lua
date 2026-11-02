--> Variables
local _L = _G._L

local Services
local Tracker
local TableUtility
local ArrayUtility
local Titles
local AttributeUtility
local Constants

--> Constants

---------->
local TitleUtility

TitleUtility = {
	getInfo = function(titleId)
		local _, rebirthTierInfo = TableUtility.match(Titles, function(i, v)
			return typeof(v) == "table" and v.id == titleId
		end)

		return rebirthTierInfo
	end,
	
	give = function(client, props)
		local titleId = props.id

		local clientData = client.data
		
		if clientData and titleId then
			local new = client.data:Get("titles")
			
			local i, v = TableUtility.match(new, function(i, v)
				return v.id == titleId
			end)
			
			if not v then
				table.insert(new, {
					id = titleId,
					equipped = false
				})
			end
			
			client.data:Set("titles", new)
			
			return true
		end

		return false
	end,

	_init = function()
		Titles = _L.Get {"Common", "Modules", "Databases", "Titles"}
		TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
		ArrayUtility = _L.Get {"Common", "Library", "Utilities", "ArrayUtility"}
		AttributeUtility = _L.Get {"Common", "Library", "Utilities", "AttributeUtility"}
		Constants = _L.Get {"Common", "Modules", "Constants"}
	end
}

return TitleUtility