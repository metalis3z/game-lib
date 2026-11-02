return {
	Quest = "Pollen Collecting I",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Amount = 50000
		},
		[2] = {
			Type = "UseItem",
			Item = "Fertilizer",
			Field = "Daisy",
			Amount = 2
		},
	},
	Dialogues = {
		["Start"] = {
			"Oh. Hello.",
			"You know, since i don't need anything,",
			"How about you just collect pollen for me?",
			"Good luck.",
		},
		["During"] = {
			"Why are you still here?",
			"Is it too hard to collect some pollen?"
		},
		["Finish"] = {
			"Great!",
			"Here is your reward."
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
			Name = "Fertilizer",
			Amount = 15,
		},
	}
}