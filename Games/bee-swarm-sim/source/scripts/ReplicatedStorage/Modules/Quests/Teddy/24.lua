return {
	Quest = "#24 Tidal Wave",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Blue Flowers",
			Amount = 9500000,
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Lemon",
			Amount = 11500000,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Pine Tree",
			Amount = 13500000,
		},
		[4] = {
			Type = "CollectPollen",
			Field = "Cattail",
			Amount = 17500000,
		},
	},
	Dialogues = {
		["Start"] = {
			"gl",
		},
		["During"] = {
			"..."
		},
		["Finish"] = {
			"...",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 20000000,
		},
		{
			Type = "Item",
			Name = "Blueberry Juice",
			Amount = 30
		},
	}
}