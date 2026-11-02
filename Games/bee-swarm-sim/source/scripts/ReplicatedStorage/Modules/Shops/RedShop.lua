local Collectors = require(game.ReplicatedStorage.Modules.Equipment.Collectors)

local module = {
	ShopName = "Red Shop",
	RealName = "RedShop",
	Items = {
		[1] = {
			Item = "Flaming Scythe",
			Description = "Rumors are that every time you collect with this scythe, it becoms stronger...",
			Type = "Tool",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 12500000, -- 15.500.000
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Strawberry Juice",
					Amount = 20,
				},
				[2] = {
					Name = "Caramel Bottle",
					Amount = 5,
				},
			}
		},
		[2] = {
			Item = "Port-O-Furnace",
			Description = "A furnace that you can carry on your back. Neat! \n\n [Stats] \n +425% Convert Rate \n +15% Pollen \n +10% Red Pollen",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 15000000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Strawberry Juice",
					Amount = 25,
				},
				[2] = {
					Name = "Caramel Bottle",
					Amount = 10,
				},
			}
		},
		[3] = {
			Item = "Burning Hot Mask",
			Description = "You are a menace to everyone and everything if you wear this. Pretty cool, huh? \n\n [Stats] \n +25% Red Pollen \n +15% Red Pollen \n +50% Convert Rate",
			Type = "Hat",
			Category = "Equipment",

			CraftNum = 2,
			Cost = 75000000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Strawberry Juice",
					Amount = 40,
				},
				[2] = {
					Name = "Caramel Bottle",
					Amount = 25,
				}
			}
		},
		[4] = {
			Item = "Fire Belt",
			Description = "A basic belt that has everything needed to start a fire... a MASSIVE fire. \n\n [Stats] \n +25% Red Pollen \n +15% Pollen",
			Type = "Belt",
			Category = "Equipment",

			CraftNum = 2,
			Cost = 30000000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Strawberry Juice",
					Amount = 20,
				},
			}
		},
		[5] = {
			Item = "Ever-burning Gauntlets",
			Description = "Everytime you punch a tree with these there is a chance that the tree may catch on fire... \n\n [Stats] \n +5% Pollen \n +15% Pollen From Tools \n +20% Red Pollen",
			Type = "Glove",
			Category = "Equipment",

			CraftNum = 3,
			Cost = 50000000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Strawberry Juice",
					Amount = 20,
				},
				[2] = {
					Name = "Caramel Bottle",
					Amount = 10,
				},
			}
		},
		[6] = {
			Item = "Burning Boots",
			Description = "You leave a burning path when you walk with these. \n\n [Stats] \n 3 Movement Collection \n 35 Player Movespeed \n 15%+ Jump Power",
			Type = "Boot",
			Category = "Equipment",

			CraftNum = 3,
			Cost = 50000000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Strawberry Juice",
					Amount = 40,
				},
			}
		},

		--[1] = {
		--	Item = "Pouch",
		--	Description = "\n+200 Capacity \n\nloses 20 pollen per minute.",
		--	Type = "Bag",
		--	Category = "Equipment",

		--	CraftNum = 2,
		--	Cost = 0,
		--	Craft = {
		--		["Diamond Egg"] = 1,
		--		["Basic Egg"] = 9999,
		--	}
		--},
		--[2] = {
		--	Item = "Electric",
		--	Description = "\n+800 Capacity \n\nloses 15 pollen per 40 seconds.",
		--	Type = "Bag",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 650,
		--	Craft = {}
		--},
		--[3] = {
		--	Item = "Soft Bag",
		--	Description = "\n+3,000 Capacity \n\nloses 25 pollen per 2 minutes.",
		--	Type = "Bag",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 5800,
		--	Craft = {}
		--},
		--[4] = {
		--	Item = "Medium Bag",
		--	Description = "DON'T BUY THIS ITEM\n\n\n+10,000 Capacity \n\nloses 100 pollen per 5 minutes.",
		--	Type = "Bag",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 22000,
		--	Craft = {}
		--},
		----// Shovels \\--
		--[5] = {
		--	Item = "Scooper",
		--	Description = "Collects 1 Pollen from 2 patches in 0.75 seconds.",
		--	Type = "Tool",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 0,
		--	Craft = {}
		--},
		--[6] = {
		--	Item = "Pickaxe",
		--	Description = "Collects 5 Pollen from 5 patches in 0.9 seconds.",
		--	Type = "Tool",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 700,
		--	Craft = {}
		--},
		--[7] = {
		--	Item = "pitchforks",
		--	Description = "Collects 7 Pollen from 7 patches in 0.65 seconds.",
		--	Type = "Tool",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 4500,
		--	Craft = {}
		--},
		--[8] = {
		--	Item = "Hoe",
		--	Description = "Collects 10 Pollen from 6 patches in 0.55 seconds.",
		--	Type = "Tool",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 15000,
		--	Craft = {}
		--},
	}
}


return module