return {
	Quest = "Too hot!",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Red Flowers",
			Amount = 1200,
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Strawberry",
			Amount = 500
		},
	},
	Dialogues = {
		["Start"] = {
			"Hello!",
			"Back again?",
			"Anyways... Its getting pretty hot in here, and i don't want to get up.",
			"Could you help me?",
		},
		["During"] = {
			"Why are you still here?",
			"Talk to me when you complete the quest."
		},
		["Finish"] = {
			"Phew!",
			"You were really fast! I though this was going to take ages!",
			"Here is your reward!",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 1500,
		},
		{
			Type = "Item",
			Name = "Blueberry",
			Amount = 15,
		},
		{
			Type = "Item",
			Name = "Strawberry",
			Amount = 15,
		},
	}
}