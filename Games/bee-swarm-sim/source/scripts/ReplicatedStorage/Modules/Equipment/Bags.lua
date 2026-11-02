local Items = {} do

	Items.Bags = {
		["Pouch"] = {
			Name = "Pouch",

			Capacity = 300,
			Loses = 20,
			Timer = 60,

			BagColor = "None",
		},
		["Honey Flask"] = {
			Name = "Honey Flask",

			Capacity = 900,
			Loses = 15,
			Timer = 40,

			BagColor = "None",
		},
		["Electrical Panel"] = {
			Name = "Electrical Panel",

			Capacity = 2700,
			Loses = 25,
			Timer = 120,

			BagColor = "None",
		},
		["Tall Grass Bag"] = {
			Name = "Tall Grass Bag",

			Capacity = 6200,
			Loses = 100,
			Timer = 300,

			BagColor = "None",
		},
		["Camping Backpack"] = {
			Name = "Camping Backpack",

			Capacity = 12500,
			Loses = 120,
			Timer = 600,
			Buffs = {
				{"Convert Rate", "Percent", 10},
				{"Pollen", "Percent", 5}
			},
			BagColor = "None",
		},



		["Huge Barrel"] = {
			Name = "Huge Barrel",

			Capacity = 25000,
			Loses = 120,
			Timer = 600,
			Buffs = {
				{"Convert Rate", "Percent", 25},
				{"Pollen", "Percent", 10}
			},
			BagColor = "None",
		},
		["Cauldron"] = {
			Name = "Cauldron",

			Capacity = 75000,
			Loses = 120,
			Timer = 600,
			Buffs = {
				{"Convert Rate", "Percent", 25},
				{"Pollen", "Percent", 10}
			},
			BagColor = "None",
		},
		["Giant Flask"] = {
			Name = "Giant Flask",

			Capacity = 140000,
			Loses = 120,
			Timer = 600,
			Buffs = {
				{"Convert Rate", "Percent", 25},
				{"Pollen", "Percent", 10}
			},
			BagColor = "None",
		},
		["Big Bag"] = {
			Name = "Big Bag",

			Capacity = 350000,
			Loses = 120,
			Timer = 600,
			Buffs = {
				{"Convert Rate", "Percent", 25},
				{"Pollen", "Percent", 10}
			},
			BagColor = "None",
		},
		["Port-O-Beehive"] = {
			Name = "Port-O-Beehive",

			Capacity = 950000,
			Loses = 120,
			Timer = 600,
			Buffs = {
				{"Convert Rate", "Percent", 100},
				{"Pollen", "Percent", 15}
			},
			BagColor = "None",
		},
		["Port-O-Furnace"] = {
			Name = "Port-O-Furnace",

			Capacity = 5000000,
			Loses = 120,
			Timer = 600,
			Buffs = {
				{"Convert Rate", "Percent", 425},
				{"Pollen", "Percent", 15},
				{'Red Pollen', "Percent", 10},
			},
			BagColor = "Red",
		},
		["Freezer"] = {
			Name = "Freezer",

			Capacity = 4500000,
			Loses = 120,
			Timer = 600,
			Buffs = {
				{"Instant", "Percent", 15},
				{"Convert Rate", "Percent", 550},
				{"Blue Pollen", "Percent", 15},
			},
			BagColor = "Blue",
		},
	}
	

end

return Items