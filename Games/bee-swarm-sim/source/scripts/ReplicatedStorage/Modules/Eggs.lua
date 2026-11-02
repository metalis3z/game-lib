local module = {}

local X = 1000

module.Eggs = {
	["Bear Bee Egg"] = {
		["Bear"] = {Name = "Bear", Rarity = 100 * X},
	},

	["Sandy Bee Egg"] = {
		["Sandy"] = {Name = "Sandy", Rarity = 100 * X},
	},

	["Midas Bee Egg"] = {
		["Midas"] = {Name = "Midas", Rarity = 100 * X},
	},

	["Basic Egg"] = {
		["Worker"] = {Name = "Worker", Rarity = 100 * X},
	},

	["Silver Egg"] = {
		["Cute"] = {Name = "Cute", Rarity = 80 * X},
		["Happy"] = {Name = "Happy", Rarity = 80 * X},
		["Quick"] = {Name = "Quick", Rarity = 80 * X},
		["Corn"] = {Name = "Corn", Rarity = 80 * X},

		["Freezy"] = {Name = "Freezy", Rarity = 17 * X},
		["Bored"] = {Name = "Bored", Rarity = 17 * X},
		["Fire"] = {Name = "Fire", Rarity = 17 * X},
		
		["Barbel"] = {Name = "Barbel", Rarity = 3 * X},
		["Wasp"] = {Name = "Wasp", Rarity = 3 * X},
	},
	
	["Golden Egg"] = {
		["Freezy"] = {Name = "Freezy", Rarity = 90 * X},
		["Bored"] = {Name = "Bored", Rarity = 90 * X},
		["Fire"] = {Name = "Fire", Rarity = 90 * X},
		
		["Barbel"] = {Name = "Barbel", Rarity = 10 * X},
		["Wasp"] = {Name = "Wasp", Rarity = 10 * X},
	},
	
	["Diamond Egg"] = {
		["Barbel"] = {Name = "Barbel", Rarity = 33 * X},
		["Wasp"] = {Name = "Wasp", Rarity = 33 * X},
		
		--["Silky"] = {Name = "Silky", Rarity = 2000},
		--["Sharp"] = {Name = "Sharp", Rarity = 2000},
		--["Aquatic"] = {Name = "Aquatic", Rarity = 2000},
	},

	--["Mythic Egg"] = {
	--	["Silky"] = {Name = "Silky", Rarity = 9500},
	--	["Sharp"] = {Name = "Sharp", Rarity = 9500},
	--	["Aquatic"] = {Name = "Aquatic", Rarity = 9500},
	--},
	
	-- 500 = 0.5
	-- 750 = 0.75 and 75 = 0.075%
	["Bee Jar"] = {
		["Cute"] = {Name = "Cute", Rarity = 70 * X},
		["Happy"] = {Name = "Happy", Rarity = 70 * X},
		["Corn"] = {Name = "Corn", Rarity = 70 * X},
		["Quick"] = {Name = "Quick", Rarity = 70 * X},

		["Freezy"] = {Name = "Freezy", Rarity = 27 * X},
		["Bored"] = {Name = "Bored", Rarity = 27 * X},
		["Fire"] = {Name = "Fire", Rarity = 27 * X},

		["Wasp"] = {Name = "Wasp", Rarity = 3 * X},
		["Barbel"] = {Name = "Barbel", Rarity = 3 * X},
		--["Staggy"] = {Name = "Staggy", Rarity = 3 * X},
	},
}

return module