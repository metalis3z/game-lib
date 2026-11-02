local Collectors = require(game.ReplicatedStorage.Modules.Equipment.Collectors)

local module = {
	ShopName = "Skilled Shop",
	RealName = "ExpShop",
	Items = {
		[1] = {
			Item = "Honey Dipper",
			Description = "Flower stick to it when you collect with it... \n\n Collects 80 Pollen from 20 patches in 1.3 seconds.",
			
			Type = "Tool",
			Category = "Equipment",
			
			CraftNum = 2,
			Cost = 100000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Treat",
					Amount = 25,
				},
				[2] = {
					Name = "Caramel",
					Amount = 5,
				},
			}
		},
		[2] = {
			Item = "Scythe",
			Description = "Finally, a normal cutting tool. \n\n Collects 150 Pollen from 13 patches in 1.1 seconds.",

			Type = "Tool",
			Category = "Equipment",

			CraftNum = 2,
			Cost = 350000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Lemon",
					Amount = 25,
				},
				[2] = {
					Name = "Strawberry Juice",
					Amount = 1,
				},
			}
		},
		[3] = {
			Item = "Magic Wand",
			Description = "I cast, I cast! \n\n Collects 200 Pollen from 16 patches in 1.1 seconds.",

			Type = "Tool",
			Category = "Equipment",

			CraftNum = 2,
			Cost = 800000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Lemon",
					Amount = 34,
				},
				[2] = {
					Name = "Seed",
					Amount = 43,
				},
			}
		},
		[4] = {
			Item = "Axe",
			Description = "Hey, maybe you can cut trees with it. \n\n\ Collects 400 Pollen from 14 patches in 1.1 seconds.",

			Type = "Tool",
			Category = "Equipment",

			CraftNum = 1,
			Cost = 1300000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Lemon",
					Amount = 100,
				},
			}
		},
		[5] = {
			Item = "Grand Hammer",
			Description = "The biggest hammer of them all. \n\n Collects 650 Pollen from 31 patches in 1.1 seconds.",

			Type = "Tool",
			Category = "Equipment",

			CraftNum = 3,
			Cost = 2000000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Strawberry Juice",
					Amount = 5,
				},
				[2] = {
					Name = "Blueberry Juice",
					Amount = 5,
				},
				[3] = {
					Name = "Oil",
					Amount = 5,
				},
			}
		},
		[6] = {
			Item = "Huge Barrel",
			Description = "You can hide in it. \n\n Holds up to 25.000 Pollen.",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 1,
			Cost = 100000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Strawberry",
					Amount = 100,
				}
			}
		},
		[7] = {
			Item = "Cauldron",
			Description = "If you put anything else except honey, the cauldron may explode.\n\n Holds up to 75.000 Pollen.",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 1,
			Cost = 350000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Treat",
					Amount = 150,
				}
			}
		},
		[8] = {
			Item = "Giant Flask",
			Description = "A giant version of the honey flask. \n\n Holds up to 140.000 Pollen.",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 2,
			Cost = 650000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Basic Egg",
					Amount = 1,
				},
				[2] = {
					Name = "Bee Jar",
					Amount = 50,
				},
			}
		},
		[9] = {
			Item = "Big Bag",
			Description = "A BIG bag used for collecting BIG numbers. \n\n Holds up to 250.000 Pollen.",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 2,
			Cost = 1350000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Seed",
					Amount = 50,
				},
			}
		},
		[10] = {
			Item = "Port-O-Beehive",
			Description = "A portable hive! Sadly only 3-4 of your bees can fit in there. \n\n Holds up to 750.000 Pollen. \n [Stats] \n +100% Convert Rate \n +15% Pollen",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 3,
			Cost = 2500000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Oil",
					Amount = 5,
				},
				[2] = {
					Name = "Energy Drink",
					Amount = 5,
				},
				[3] = {
					Name = "Caramel Bottle",
					Amount = 1,
				},
			}
		},
	}
}


return module