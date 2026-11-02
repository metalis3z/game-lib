--> Variables
local _L = _G._L

local Services
local Constants

--> Constants

---------->
local WheelRewards

WheelRewards = {
	{
		id = 1,
		
		reward_name = "Pet",
		name = "Magma Beast",
		value = 1,
		
		chance = 1
	},
	
	{
		id = 2,

		reward_name = "Stat",
		name = "Gems",
		value = 250*10,

		chance = 16
	},
	
	{
		id = 3,

		reward_name = "Stat",
		name = "Gems",
		value = 250*10,

		chance = 16
	},
	
	{
		id = 4,

		reward_name = "Boost",
		name = "x2_Strength",
		value = 1,

		chance = 10
	},
	
	{
		id = 5,

		reward_name = "Stat",
		name = "Gems",
		value = 250*10,

		chance = 16
	},
	
	{
		id = 6,

		reward_name = "Boost",
		name = "x2_Damage",
		value = 3,

		chance = 9
	},
	
	{
		id = 7,

		reward_name = "Stat",
		name = "Gems",
		value = 250*10,

		chance = 16
	},
	
	{
		id = 8,

		reward_name = "Stat",
		name = "Gems",
		value = 250*10,

		chance = 16
	},
}

return WheelRewards