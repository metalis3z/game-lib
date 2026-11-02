return {
	Quest = "#4 Daybloom",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "Red",
			Field = "Red Flowers",
			Amount = 1000,
		},
	},
	Dialogues = {
		["Start"] = {
			"Hello, I have a question",
			"Have you ever been to the Red Flowers field?",
			"No? Then your next quest will contain tasks on this field!",
			"Collect 1000 Red pollen from Red Flowers Field!",
			"They say if you stay too long on red fields you will burn!",
			"I wonder if it's true..",
		},
		["During"] = {
			"Is it hot there?",
		},
		["Finish"] = {
			"Congrats! You did it!",
			"Next quest is very interesting.. With a crazy reward!",
			"See you later!"
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 2750,
		},
		{
			Type = "Item",
			Name = "Strawberry",
			Amount = 35,
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 1,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 3,
		},
	}
}