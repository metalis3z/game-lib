return {
	Quest = "THE BIG REVEAL!",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Tomato",
			Amount = 25000
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Rose",
			Amount = 25000
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Dandelion",
			Amount = 25000
		},
		[4] = {
			Type = "CollectPollen",
			Field = "Sunflower",
			Amount = 25000
		},
		[5] = {
			Type = "CollectPollen",
			Field = "Cattail",
			Amount = 25000,
		},
	},
	Dialogues = {
		["Start"] = {
			"WELCOME",
			"TO THE BIG REVEAL!",
			"FIVE MORE QUESTS FOR THE SANDY BEE!",
			"GO.",
		},
		["During"] = {
			"Too hard, huh?",
			"Well i don't care. If you want the bee - complete them."
		},
		["Finish"] = {
			"YOU'VE DONE IT MY FRIEND.",
			"CONGRATULATIONS"
		}
	},

	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 7500,
		},
		{
			Type = "Item",
			Name = "Caramel Bottle",
			Amount = 20,
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 20,
		},
		{
			Type = "Item",
			Name = "Oil",
			Amount = 20,
		},
		{
			Type = "Item",
			Name = "Blueberry Juice",
			Amount = 20,
		},
	}
}