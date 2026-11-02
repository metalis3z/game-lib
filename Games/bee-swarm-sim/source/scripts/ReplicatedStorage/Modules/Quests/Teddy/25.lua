return {
	Quest = "#25 Bloodbath",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Red Flowers",
			Amount = 20000000,
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Strawberry",
			Amount = 35000000,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Rose",
			Amount = 50000000,
		},
		[4] = {
			Type = "CollectPollen",
			Field = "Tomato",
			Amount = 110000000,
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
			Amount = 100000000,
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 30
		},
	}
}