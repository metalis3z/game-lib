return {
	Quest = "#2 Exploring Time",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "White",
			Field = "Fungus",
			Amount = 250,
		},
		[2] = {
			Type = "CollectPollen",
			Color = "Blue",
			Amount = 350
		},
	},
	Dialogues = {
		["Start"] = {
			"Hello!",
			"Do you see that mushroom field over there?",
			"Those are not common mushrooms, they are really rare!",
			"Would you mind collecting some pollen there for me?",
			"Thanks a lot! Come back after you finish the quest for the reward!"
		},
		["During"] = {
			"Track your quests in the Quests Menu!",
			"It's accessible through the *QUESTS* button on the left of the screen!"
		},
		["Finish"] = {
			"Congrats on completing my second quest!",
			"Your reward for this one is 450 HONEY and 15 STRAWBERRIES",
			"Come back when you're ready!",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 450,
		},
		{
			Type = "Item",
			Name = "Strawberry",
			Amount = 15,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 3,
		},
	}
}