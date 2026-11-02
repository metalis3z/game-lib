return {
	Quest = "#14 Sprout Party",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Strawberry",
			Color = "Red",
			Amount = 250000,
		},
		[2] = {
			Type = "UseItem",
			Item = "Sprout Bean",
			Amount = 3
			},
	},	
	Dialogues = {
		["Start"] = {
			"Hi Again",
			"I was thinking, why every quest has the pollen requirement?",
			"Why can't we just do something else..",
			"So.. I came up with this quest!",
			"Here you go.. Have fun!",
		},
		["During"] = {
			"..."
		},
		["Finish"] = {
			"I think it felt much better to do this kind of quest.. With no pollen..",
			"Hm?",
			"No?..",
			"Oh.. Well I'll just keep putting in pollen tasks then..",
			"Here's your reward."
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 100000,
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 10,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 5,
		},
	}
}