return {
	Quest = "#19 Diamond Journey IV",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Pine Tree",
			Color = "White",
			Amount = 100000,
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Clover",
			Color = "Blue",
			Amount = 50000,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Dandelion",
			Amount = 500000,
		},
		--[4] = {
		--	Type = "CollectToken",
		--	Token = "Strawberry",
		--	Amount = 100,
		--},
		--[5] = {
		--	Type = "CollectToken",
		--	Token = "Bee Jar",
		--	Amount = 10,
		--},
	},	
	Dialogues = {
		["Start"] = {
			"So.. Only 2 quests left until that DIAMOND EGG!",
			"Keep going! This one is gonna be tough.",
		},
		["During"] = {
			"..."
		},
		["Finish"] = {
			"You did it much faster than I expected!",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 2000000,
		},
		{
			Type = "Item",
			Name = "Oil",
			Amount = 5,
		},
		{
			Type = "Item",
			Name = "Energy Drink",
			Amount = 5,
		},
		{
			Type = "Item",
			Name = "BJ Point",
			Amount = 2,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 5,
		},
	}
}