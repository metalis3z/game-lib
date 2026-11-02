return {
	Quest = "#1 Welcome to the game!", -- Bees Journey X
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Amount = 350,
		},
	},
	Dialogues = {
		["Start"] = {
			"Hm?",
			"Oh! A new beekeeper arrived!",
			"Welcome to Bees Journey X! I'm Teddy.",
			"I will be helping you throughout your journey!",
			"Take your first quest. This one is really easy!",
			"Good Luck!!"
		},
		["During"] = {
			"Struggling with the quest?",
			"Use LMB while staying in the field to collect pollen!"
		},
		["Finish"] = {
			"Great job! You did it much faster than the others!",
			"And now, as a reward you'll get...",
			"250 Honey!",
			"Come back when you're ready for your second quest!"
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 250,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 1,
		},
	}
}