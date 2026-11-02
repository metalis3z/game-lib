return {
	Quest = "#23 Roundabout",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Fungus",
			Amount = 5000000,
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Cabbage",
			Amount = 6000000,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Clover",
			Amount = 7000000,
		},
		[4] = {
			Type = "CollectPollen",
			Field = "Tomato",
			Amount = 8000000,
		},
		[5] = {
			Type = "CollectPollen",
			Field = "Sunflower",
			Amount = 9000000,
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
			Name = "Oil",
			Amount = 15
		},
	}
}