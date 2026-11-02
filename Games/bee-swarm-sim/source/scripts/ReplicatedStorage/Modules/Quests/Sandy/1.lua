return {
	Quest = "Summer Sun",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Amount = 1250,
		}, 
		--remove below
	},
	Dialogues = {
		["Start"] = {
			"Huh? Where am I? I wasn't here like 20 Minutes ago, was I?",
			"Anyways, my name is Sandy Bear.",
			"Good Luck completing my first quest.",
		},
		["During"] = {
			"Why are you still here?",
			"Talk to me when you complete the quest."
		},
		["Finish"] = {
			"Good job, i guess?",
			"You have completed the first quest...",
			"Here is your reward.",
		}
	},

	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 1250,
		},
		{
			Type = "Item",
			Name = "Blueberry Juice",
			Amount = 2,
		},
	}
}