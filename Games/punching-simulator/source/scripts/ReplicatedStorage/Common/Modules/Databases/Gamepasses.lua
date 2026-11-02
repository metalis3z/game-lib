--> Variables
local _L = _G._L

local Network

--> Constants

---------->
return {
	{
		id = 884545801,
		name = "x2_Damage",
		price = 195,
		icon = "rbxassetid://14264358173",
		display_name = "x2 Damage",
		
		callback = function(user)
			return true
		end,
	},
	
	{
		id = 884764607,
		name = "Triple_Eggs",
		price = 245,
		icon = "rbxassetid://14264416790",
		display_name = "Triple Eggs",
		
		callback = function(user)
			return true
		end,
	},
	
	{
		id = 884531770,
		name = "x2_Strength",
		price = 245,
		icon = "rbxassetid://14266433233",
		display_name = "x2 Strength",
		
		callback = function(user)
			return true
		end,
	},
	
	{
		id = 884792010,
		name = "VIP",
		price = 395,
		icon = "rbxassetid://14213384121",
		
		callback = function(user)
			return true
		end,
	},	
	
	{
		id = 885389035,
		name = "x2_Rebirths",
		price = 795,
		icon = "rbxassetid://14264589961",
		display_name = "x2 Rebirths",
		
		callback = function(user)
			return true
		end,
	},
	
	{
		id = 884768440,
		name = "Fast_Hatch",
		price = 125,
		icon = "rbxassetid://14264495336",
		display_name = "Fast Hatch",
		
		callback = function(user)
			return true
		end,
	},
	
	{
		id = 884460871,
		name = "5_Pets_Equipped",
		price = 445,
		icon = "rbxassetid://14267218656",
		display_name = "5 Pets Equipped",
		
		callback = function(user)
			--user._data:Set({"stats", "Pet_Equip_Space"}, 5)
			return true
		end,
	},
	
	{
		id = 884978728,
		name = "8_Pets_Equipped",
		price = 945,
		icon = "rbxassetid://14267217308",
		display_name = "8 Pets Equipped",
		
		callback = function(user)
			--user._data:Set({"stats", "Pet_Equip_Space"}, 8)
			return true
		end,
	},
	
	{
		id = 884772444,
		name = "Auto_Rebirth",
		price = 595,
		icon = "rbxassetid://14268649258",
		display_name = "Auto Rebirth",

		callback = function(user)
			return true
		end,
	},
	
	{
		id = 794481220,
		name = "Rainbow_Eggs",
		price = 1295,
		icon = "",
		display_name = "Rainbow Eggs",

		callback = function(user)
			return true
		end,
	},
	
	_init = function()
		Network = _L.Get {"Common", "Library", "Network"}
	end,
}