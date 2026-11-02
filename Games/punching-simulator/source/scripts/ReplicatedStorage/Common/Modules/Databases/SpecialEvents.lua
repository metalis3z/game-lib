--> Variables
local _L = _G._L

local Network
local Services
local NumberUtility

--> Constants

---------->
local SpecialEvents

SpecialEvents = {
	{
		id = "deathmatch",
		icon = "rbxassetid://14262761173", 
		
		start_description = [[<stroke color= "rgb(0, 0, 0)" joins="round" thickness="2" transparency="0"><font color= "rgb(255, 255, 255)"><font color= "rgb(0, 255, 0)">Deathmatch!</font>: Killing people gives you some of their gems for 5 minutes.</font></stroke>]],
		end_description = [[<stroke color= "rgb(0, 0, 0)" joins="round" thickness="2" transparency="0"><font color= "rgb(255, 255, 255)"><font color= "rgb(0, 255, 0)">Deathmatch!</font>: Time's up for the event, the next one will start soon! </font></stroke>]],
		
		duration = 5 * 60,
		
		callback = function()
			return function()
			end
		end,
	},
	
	_init = function()
		NumberUtility = _L.Get {"Common", "Library", "Utilities", "NumberUtility"}
	end,
}

return SpecialEvents