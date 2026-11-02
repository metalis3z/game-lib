--> Variables
local _L = _G._L

local PlayerRewardUtility

--> Constants

---------->
return {
	{
		value = "newgamerelease",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Stat", props = {
				name = "Strength",
				value = 500
			}}}, true)
		end,
	},

	{
		value = "newgamedev",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Stat", props = {
				name = "Gems",
				value = 10000000000000000
			}}}, true)
		end,
	},


	{
		value = "3dbrennan",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Stat", props = {
				name = "Gems",
				value = 100
			}}}, true)
		end,
	},

	{
		value = "overpowered",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Pet", props = {
				name = "Toxic Hydra",
				value = 1
			}}}, true)
		end,
	},

	{
		value = "secret",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Boost", props = {
				name = "x2_Strength",
				value = 1
			}}}, true)
		end,
	},

	{
		value = "protection",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Boost", props = {
				name = "Protection_Potion",
				value = 1
			}}}, true)
		end,
	},


	{
		value = "lucky",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Boost", props = {
				name = "Lucky_Potion",
				value = 1
			}}}, true)
		end,
	},

	{
		value = "visits?",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Stat", props = {
				name = "Gems",
				value = 10000
			}},{name = "Boost", props = {
				name = "x2_Damage",
				value = 1
			}},{name = "Boost", props = {
				name = "Protection_Potion",
				value = 1
			}},{name = "Boost", props = {
				name = "x2_Strength",
				value = 1
			}},{name = "Boost", props = {
				name = "Lucky_Potion",
				value = 1
			}}}, true)
		end,
	},

	{
		value = "pro",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Boost", props = {
				name = "x2_Damage",
				value = 1
			}}}, true)
		end,
	},

	{
		value = "plsss",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Stat", props = {
				name = "Gems",
				value = 20000
			}},{name = "Boost", props = {
				name = "x2_Damage",
				value = 1
			}},{name = "Boost", props = {
				name = "Protection_Potion",
				value = 1
			}},{name = "Boost", props = {
				name = "x2_Strength",
				value = 2
			}},{name = "Boost", props = {
				name = "Lucky_Potion",
				value = 2
			}}}, true)
		end,
	},

	{
		value = "likespls",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Stat", props = {
				name = "Gems",
				value = 30000
			}},{name = "Boost", props = {
				name = "x2_Strength",
				value = 3
			}}}, true)
		end,
	},
	
	{
		value = "pleaselikes",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Stat", props = {
				name = "Gems",
				value = 40000
			}},{name = "Boost", props = {
				name = "x2_Strength",
				value = 1
			}},{name = "Boost", props = {
				name = "Lucky_Potion",
				value = 1
			}}}, true)
		end,
	},
	
	{
		value = "uwu",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Stat", props = {
				name = "Gems",
				value = 50000
			}},{name = "Boost", props = {
				name = "x2_Strength",
				value = 1
			}},{name = "Boost", props = {
				name = "Lucky_Potion",
				value = 1
			}}}, true)
		end,
	},
	
	{
		value = "biguwu",

		callback = function(client)
			return PlayerRewardUtility.give(client, {{name = "Stat", props = {
				name = "Gems",
				value = 60000
			}},{name = "Boost", props = {
				name = "x2_Strength",
				value = 1
			}},{name = "Boost", props = {
				name = "Lucky_Potion",
				value = 1
			}}}, true)
		end,
	},
	
	_init = function()
		PlayerRewardUtility = _L.Get {"Common", "Modules", "Utilities", "PlayerRewardUtility"}
	end
}



