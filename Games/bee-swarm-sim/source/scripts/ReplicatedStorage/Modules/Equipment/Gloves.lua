local Items = {} do

	Items.Gloves = {
		["Worker's Gloves"] = {
			Name = "Worker's Gloves",
			Capacity = 1500,
			Image = "rbxassetid://14931762732",-- поставить другую
			Description = "",
			Desc = "",
			Buffs = {
				{"Movement Collection", "Percent", 3},
				{"Player Movespeed", "Percent", 5},
				{"White Pollen", "Percent", 15},
			}
		},
		["Ever-burning Gauntlets"] = {
			Name = "Ever-burning Gauntlets",
			Capacity = 7000,
			Image = "rbxassetid://14931762732",-- поставить другую
			Description = "",
			Desc = "",
			Buffs = {
				{"Pollen", "Percent", 5},
				{"Pollen From Tools", "Percent", 15},
				{"Red Pollen", "Percent", 20},
			}
		},
		["Frosty Gauntlets"] = {
			Name = "Frosty Gauntlets",
			Capacity = 1500,
			Image = "rbxassetid://14931762732",-- поставить другую
			Description = "",
			Desc = "",
			Buffs = {
				{"Pollen", "Percent", 5},
				{"Pollen From Tools", "Percent", 15},
				{"Instant", "Percent", 10},
			}
		},
	}
end
return Items
