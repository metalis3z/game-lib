return {
	Quest = "Let's try blue again",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Blue Flower",
			Amount = 5000
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Pine Tree",
			Amount = 5000
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Cattail",
			Amount = 5000
		},
		[4] = {
			Type = "CollectPollen",
			Color = "Blue",
			Amount = 10000
		},
		[5] = {
			Type = "UseItem",
			Item = "Blueberry Juice",
			Field = "Blue Flowers",
			Amount = 5,
		},
	},
	Dialogues = {
		["Start"] = {
			"Okay.... Listen.",
			"Maybe we were too rough with blue...",
			"Wanna try it again?",
			"No? You still will.",
		},
		["During"] = {
			"Why are you still here?",
			"Go complete the quest!"
		},
		["Finish"] = {
			"Back so soon?",
			"Thought this would take you longer.",
			"Here you go!"
		}
	},

	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 20000,
		},
		{
			Type = "Item",
			Name = "Oil",
			Amount = 5,
		},
		{
			Type = "Item",
			Name = "Blueberry Juice",
			Amount = 25,
		},
	}
}