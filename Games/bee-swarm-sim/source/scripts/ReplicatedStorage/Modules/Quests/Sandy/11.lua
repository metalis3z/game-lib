return {
	Quest = "Playtime over...",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "White",
			Amount = 2500
		},
		[2] = {
			Type = "CollectPollen",
			Color = "Blue",
			Amount = 2500
		},
		[3] = {
			Type = "CollectPollen",
			Color = "Red",
			Amount = 2500
		},
		[4] = {
			Type = "CollectPollen",
			Amount = 2500
		},
		[5] = {
			Type = "UseItem",
			Item = "Fertilizer",
			Amount = 1,
		},
	},
	Dialogues = {
		["Start"] = {
			"Hey! Congratulations on completing that 10th quest!",
			"Anyways. No more playing games.",
			"Only hard quests from now.",
			"Good luck.",
		},
		["During"] = {
			"Go.",
			"..."
		},
		["Finish"] = {
			"Hmm. i didn't actually think you would complete it.",
			"Here you go, i guess."
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
			Amount = 10,
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 10,
		},
		{
			Type = "Item",
			Name = "Oil",
			Amount = 10,
		},
		{
			Type = "Item",
			Name = "Blueberry Juice",
			Amount = 10,
		},
	}
}