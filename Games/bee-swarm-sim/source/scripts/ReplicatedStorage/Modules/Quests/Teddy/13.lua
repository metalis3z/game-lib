return {
	Quest = "#13 Multicolor Madness II",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Daisy",
			Color = "White",
			Amount = 30000,
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Blue Flowers",
			Color = "Blue",
			Amount = 30000,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Red Flowers",
			Color = "Red",
			Amount = 30000,
		},
		[4] = {
			Type = "CollectPollen",
			Field = "Lemon",
			Color = "Blue",
			Amount = 35000,
		},
		[5] = {
			Type = "CollectPollen",
			Field = "Strawberry",
			Color = "Red",
			Amount = 35000,
		},
		[6] = {
			Type = "CollectPollen",
			Field = "Cabbage",
			Color = "White",
			Amount = 35000,
		},
	},	
	Dialogues = {
		["Start"] = {
			"Welcome back to my quests!!",
			"Remember Multicolor Madness quest?",
			"Well here it is.. But with higher requirements and more fields!!",
			"I dont think it'll take a lot of time..",
		},
		["During"] = {
			"..."
		},
		["Finish"] = {
			"Congrats on completing my quest!",
			"...",
			"Take the reward..",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 200000,
		},
		{
			Type = "Item",
			Name = "Blueberry Juice",
			Amount = 1,
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 1,
		},
		{
			Type = "Item",
			Name = "Fertilizer",
			Amount = 1,
		},
		{
			Type = "Item",
			Name = "Sprout Bean",
			Amount = 3,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 5,
		},
	}
}