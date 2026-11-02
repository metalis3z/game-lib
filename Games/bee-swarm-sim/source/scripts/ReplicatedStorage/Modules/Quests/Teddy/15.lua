return {
	Quest = "#15 The End is the Beggining",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Daisy",
			Amount = 100000,
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Fungus",
			Amount = 100000,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Blue Flowers",
			Amount = 100000,
		},
		[4] = {
			Type = "CollectPollen",
			Field = "Red Flowers",
			Amount = 100000,
		},
	},	
	Dialogues = {
		["Start"] = {
			"Hi!",
			"So you like pollen quests more",
			"Here you go! A quest with only pollen collection!",
			"Good Luck",
		},
		["During"] = {
			"..."
		},
		["Finish"] = {
			"Did you like this quest?",
			"Of course you did! Because you get rewarded for it!",
			"Come back when you're ready",
			"..and let the journey begin..."
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 300000,
		},
		{
			Type = "Item",
			Name = "Fertilizer",
			Amount = 3,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 5,
		},
	}
}