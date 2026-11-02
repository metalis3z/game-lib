local Collectors = require(game.ReplicatedStorage.Modules.Equipment.Collectors)

local module = {
	ShopName = "Worker Shop",
	RealName = "WorkerShop",
	Items = {
		[1] = {
			Item = "Shovel",
			Description = "A basic shovel. Is something wrong? \n\n Collects 1 Pollen from 2 patches in 0.75 seconds",
			Type = "Tool",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 0,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[2] = {
			Item = "Pitchfork",
			Description = "Careful, you might stab yourself. \n\n Collects 3 Pollen from 6 patches in 0.6 seconds",
			Type = "Tool",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 750,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[3] = {
			Item = "Magnet",
			Description = "You might find something you didn't expect to find while collecting with this... \n\n Collects 10 Pollen from 12 patches in 0.8 seconds",
			Type = "Tool",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 2700,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[4] = {
			Item = "Scissors",
			Description = "Cut flowers with it! \n\n Collecting 65 Pollen from 2 patches in 0.55 seconds",
			Type = "Tool",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 8750,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[5] = {
			Item = "Balalaika",
			Description = "Did you know that the earliest mention of the 'Balalaika' dates back to a 1688 Russian document? \n\n Collecting 65 Pollen from 13 patches in 0.7 seconds",
			Type = "Tool",
			Category = "Equipment",
			CraftNum = 2,
			Cost = 23000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Strawberry",
					Amount = 25,
				},
				[2] = {
					Name = "Sugar",
					Amount = 3,
				},
			}
		},
		[6] = {
			Item = "Pouch",
			Description = "A Basic pouch. \n\n Can Contain up to 300 Pollen.",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 0,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[7] = {
			Item = "Honey Flask",
			Description = "You can store honey in there, probably.... \n\n Can Contain up to 9	00 Pollen",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 850,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[8] = {
			Item = "Electrical Panel",
			Description = "'Bzzt!' goes the electric panel. \n\n Can Contain up to 2700 Pollen",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 6250,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[9] = {
			Item = "Tall Grass Bag",
			Description = "Who knows how it even contains honey. \n\n Can Contain up to 6200 Pollen",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 12500,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[10] = {
			Item = "Camping Backpack",
			Description = "Somehow a camping backpack can hold honey. \n\n Contains 12.500 Pollen",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 2,
			Cost = 24750,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Treat",
					Amount = 25,
				},
				[2] = {
					Name = "Oil",
					Amount = 1,
				}
			}
		},
		[11] = {
			Item = "Worker's Boots",
			Description = "The Boots of a hard worker! \n[Stats] \n+3000 Capacity \n+1% Movement Collection \n+20% Player Movespeed \n+10% Jump Power",
			Type = "Boot",
			Category = "Equipment",

			CraftNum = 2,
			Cost = 35000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Strawberry",
					Amount = 30,
				},
				[2] = {
					Name = "Blueberry",
					Amount = 30,
				}
			}
		},
		[12] = {
			Item = "Worker's Gloves",
			Description = "Probably dirty... \n[Stats] \n+1500 Capacity \n+3% Movement Collection \n+5% Player Movespeed \n+15% White Pollen",
			Type = "Glove",
			Category = "Equipment",

			CraftNum = 3,
			Cost = 21500,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[13] = {
			Item = "Worker's Belt",
			Description = "A worker's belt which has all of the instruments needed! \n[Stats] \n+2350 Capacity \n+25% Pollen \n+15% White Pollen",
			Type = "Belt",
			Category = "Equipment",

			CraftNum = 2,
			Cost = 17500,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Blueberry",
					Amount = 10,
				},
				[2] = {
					Name = "Seed",
					Amount = 5,
				}
			}
		},
		[14] = {
			Item = "Worker's Ant Helmet",
			Description = "Who knew they were wearing ant masks all alone! \n\n [Stats] \n+3% Pollen \n+5% Instant Conversion \n+25% Convert Rate",
			Type = "Hat",
			Category = "Equipment",

			CraftNum = 3,
			Cost = 19500,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Oil",
					Amount = 3,
				},
				[2] = {
					Name = "Fertilizer",
					Amount = 1,
				},
				[3] = {
					Name = "Treat",
					Amount = 50,
				},
			}
		},
		[15] = {
			Item = "Hive Slot",
			Description = "Adds 1 Honeycomb to your Hive!",
			Type = "Hive Slot",
			Category = "Hive Slot",

			CraftNum = 0,
			Cost = 250,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[16] = {
			Item = "Basic Egg",
			Description = "\nHatches an ordinary bee.\n",

			Type = "Item",
			Category = "Inventory",

			Amount = 1,

			CraftNum = 0,
			Cost = 600,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[17] = {
			Item = "Bee Jar",
			Description = "Jar with random any bee. Can only be used on occupied cells.",

			Type = "Item",
			Category = "Inventory",

			Amount = 1,

			MultiBuy = {1,10,100,1000,10000,100000,1000000,10000000},

			CraftNum = 0,
			Cost = 10000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[18] = {
			Item = "Treat",
			Description = "Grants 10 Bonds for Bee.",

			Type = "Item",
			Category = "Inventory",

			Amount = 1,

			MultiBuy = {1,10,100,1000,10000,100000,1000000,10000000},

			CraftNum = 0,
			Cost = 1000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
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