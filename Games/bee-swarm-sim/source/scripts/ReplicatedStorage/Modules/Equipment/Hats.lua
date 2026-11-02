local Items = {} do
	Items.Hats = {
		["Worker's Ant Helmet"] = {
			Type = "Hat",
			Name = "Worker's Ant Helmet",
			Description = "-",
			Image = "rbxassetid://14931762732", -- поменять на новую
			Desc = "-",
			Buffs = {
				{"Pollen", "Percent", 3},
				{"Instant", "Percent", 5},
				{"Convert Rate", "Percent", 25}
			},
		},
		["Burning Hot Mask"] = {
			Type = "Hat",
			Name = "Burning Hot Mask",
			Description = "-",
			Image = "rbxassetid://14931762732", -- поменять на новую
			Desc = "-",
			Buffs = {
				{"Red Pollen", "Percent", 25},
				{"Pollen", "Percent", 15},
				{"Convert Rate", "Percent", 50}
			},
		},
		["Permafrost Mask"] = {
			Type = "Hat",
			Name = "Permafrost Mask",
			Description = "-",
			Image = "rbxassetid://14931762732", -- поменять на новую
			Desc = "-",
			Buffs = {
				{"Pollen", "Percent", 5},
				{"Instant", "Percent", 20},
				{"Convert Rate", "Percent", 20},
				{"Blue Pollen", "Percent", 25}
			},
		},
	}
end

return Items
