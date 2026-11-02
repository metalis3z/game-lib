return {
	Quest = "#18 Diamond Journey III",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Lemon",
			Color = "Red",
			Amount = 50000,
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Cabbage",
			Color = "Red",
			Amount = 25000,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Cabbage",
			Color = "Blue",
			Amount = 25000,
		},
		[4] = {
			Type = "CollectPollen",
			Field = "Strawberry",
			Color = "White",
			Amount = 50000,
		},
	},	
	Dialogues = {
		["Start"] = {
			"...",
			"I guess I can't stop you.",
			"Any quest I give you..",
			"It's like a nothing to you",
			"Nevermind. Here you go."
		},
		["During"] = {
			"..."
		},
		["Finish"] = {
			"Wow!",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 1500000,
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 3,
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