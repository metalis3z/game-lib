--> Variables
local _L = _G._L

local PlayerRewardUtility
local StatUtility
local PetUtility
local BoostUtility
local EggUtility
local _Stats
local PowerUtility

--> Constants

---------->
local c

PlayerRewards = {
	{
		name = "Stat",

		callback = function(client, statProps)
			return StatUtility.give(client, statProps)
		end,
		
		getInfo = function(statName)
			return StatUtility.getInfo(statName)
		end,
	},
	
	{
		name = "Title",

		callback = function(client, titleProps)
			return TitleUtility.give(client, titleProps)
		end,

		getInfo = function(titleName)
			return TitleUtility.getInfo(titleName)
		end,
	},
	
	{
		name = "Power",

		callback = function(client, powerProps)
			return PowerUtility.give(client, powerProps)
		end,

		getInfo = function(powerName)
			return PowerUtility.getInfo(powerName)
		end,
	},
	
	{
		name = "Pet",

		callback = function(client, petProps)
			return PetUtility.give(client, petProps)
		end,

		getInfo = function(petName)
			return PetUtility.getInfo(petName)
		end,
	},
	
	{
		name = "Boost",

		callback = function(client, boostProps)
			return BoostUtility.give(client, boostProps)
		end,

		getInfo = function(boostName)
			return BoostUtility.getInfo(boostName)
		end,
	},
	
	{
		name = "Egg",

		callback = function(client, eggProps, i)
			return EggUtility.give(client, eggProps, i)
		end,

		getInfo = function(eggName)
			return EggUtility.getInfo(eggName)
		end,
	},

	_init = function()
		PlayerRewardUtility = _L.Get {"Common", "Modules", "Utilities", "PlayerRewardUtility"}
		StatUtility = _L.Get {"Common", "Modules", "Utilities", "StatUtility"}
		PetUtility = _L.Get {"Common", "Modules", "Utilities", "PetUtility"}
		BoostUtility = _L.Get {"Common", "Modules", "Utilities", "BoostUtility"}
		EggUtility = _L.Get {"Common", "Modules", "Utilities", "EggUtility"}
		PowerUtility = _L.Get {"Common", "Modules", "Utilities", "PowerUtility"}
		TitleUtility = _L.Get {"Common", "Modules", "Utilities", "TitleUtility"}
	end
}

return PlayerRewards