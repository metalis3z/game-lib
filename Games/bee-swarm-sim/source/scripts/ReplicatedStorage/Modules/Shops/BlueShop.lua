	local Collectors = require(game.ReplicatedStorage.Modules.Equipment.Collectors)

local module = {
	ShopName = "Blue Shop",
	RealName = "BlueShop",
	Items = {
		[1] = {
			Item = "Frozen Shovel",
			Description = "Its cold? try wearing some gloves on.",
			Type = "Tool",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 12500000, -- 15.500.000
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Blueberry Juice",
					Amount = 25,
				},
				[2] = {
					Name = "Oil",
					Amount = 5,
				},
			}
		},
		[2] = {
			Item = "Freezer",
			Description = "Have you even thought when exactly the lights in your freezer turn off? You should think about that. \n\n [Stats] \n +15% Instant Conversion \n +550% Convert Rate \n +15% Blue Pollen",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 15000000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Blueberry Juice",
					Amount = 30,
				},
				[2] = {
					Name = "Oil",
					Amount = 10,
				},
			}
		},
		[3] = {
			Item = "Permafrost Mask",
			Description = "It's been stuck under ice for decades. Who knows for how much exactly... \n\n [Stats] \n +5% Pollen \n +20% Instant Conversion \n +20% Convert Rate \n +25% Blue Pollen",
			Type = "Hat",
			Category = "Equipment",

			CraftNum = 2,
			Cost = 75000000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Blueberry Juice",
					Amount = 50,
				},
				[2] = {
					Name = "Oil",
					Amount = 25,
				}
			}
		},
		[4] = {
			Item = "Frozen Belt",
			Description = "#TeamBlue!!! Wearing this belt indicates that you are a true blue fighter! \n\n [Stats] \n +25% Blue Pollen \n +10% Instant Conversion",
			Type = "Belt",
			Category = "Equipment",

			CraftNum = 2,
			Cost = 30000000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Blueberry Juice",
					Amount = 20,
				},
			}
		},
		[5] = {
			Item = "Frosty Gauntlets",
			Description = "Not normal gloves, silly! I was talking about these gloves. What? They're still cold? You will get used to it. \n\n [Stats] \n +5% Pollen \n +15% Pollen From Tools \n +10% Instant Conversion",
			Type = "Glove",
			Category = "Equipment",

			CraftNum = 3,
			Cost = 50000000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Blueberry Juice",
					Amount = 20,
				},
				[2] = {
					Name = "Oil",
					Amount = 10,
				},
			}
		},
		[6] = {
			Item = "Frostwalker Boots",
			Description = "Rumors are that if you go into water with these, the water will freeze. Totally not referencing minecraft... \n\n [Stats] \n +3 Movement Collection \n +25% Player Movespeed \n +25% Jump Power",
			Type = "Boot",
			Category = "Equipment",

			CraftNum = 3,
			Cost = 30000000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Blueberry Juice",
					Amount = 40,
				},
			}
		},
	}
	}

return module