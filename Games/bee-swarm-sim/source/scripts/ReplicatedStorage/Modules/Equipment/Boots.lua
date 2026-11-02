local Items = {} do

	Items.Boots = {
		["Worker's Boots"] = {
			Name = "Worker's Boots",
			Capacity = 3000,
			Image = "rbxassetid://14931762732",
			Description = "Worker Boots \nMovement Collection - 1 \n+20% Player Movespeed \n+10% Jump Power",
			Desc = "Worker Boots \n[Stats] \nMovement Collection - 1 \n+20% Player Movespeed \n+10% Jump Power",
			Buffs = {
				{"Movement Collection", "Percent", 1},
				{"Player Movespeed", "Percent", 20},
				{"Jump Power", "Percent", 10},
			}
		},
		["Burning Boots"] = {
			Name = "Burning Boots",
			Capacity = 7000,
			Image = "rbxassetid://14931762732",
			Description = "Red Boots \nMovement Collection - 3 \n+35% Player Movespeed \n+15% Jump Power",
			Desc = "Red Boots \n[Stats] \nMovement Collection - 3 \n+35% Player Movespeed \n+15% Jump Power",
			Buffs = {
				{"Movement Collection", "Percent", 3},
				{"Player Movespeed", "Percent", 35},
				{"Jump Power", "Percent", 15},
			}
		},
		["Frostwalker Boots"] = {
			Name = "Frostwalker Boots",
			Capacity = 7000,
			Image = "rbxassetid://14931762732",
			Description = "",
			Desc = "",
			Buffs = {
				{"Movement Collection", "Percent", 3},
				{"Player Movespeed", "Percent", 25},
				{"Jump Power", "Percent", 25},
			}
		},
	}
	end
return Items
