return {
	Quest = "#9 Exploring Time II",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "Red",
			Amount = 15000
		},
		[2] = {
			Type = "CollectPollen",
			Color = "Blue",
			Amount = 15000
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Strawberry",
			Amount = 8000
		},
		
		[4] = {
			Type = "CollectPollen",
			Field = "Lemon",
			Amount = 10000,
		},
		--[5] = {
		--	Type = "UseItem",
		--	Item = "",-- Blueberry Juice
		--	Amount = 1,
		--},
		--[6] = {
		--	Type = "UseItem",
		--	Item = "",-- Strawberry Juice
		--	Amount = 1,
		--},
	},
	Dialogues = {
		["Start"] = {
			"Hello!",
			"This is the last quest before the BIG GAME!",
			"It's time for you to explore new fields",
			"Good luck! :D"
		},
		["During"] = {
			"Return when you complete the quest!"
		},
		["Finish"] = {
			"You've completed my quest!",
			"How do you like the new fields?",
			"I hope you enjoyed those, but I'm waiting for you on the next assignment!",
			"It'll be hard..",
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
			Name = "Strawberry",
			Amount = 70,
		},
		{
			Type = "Item",
			Name = "Lemon",
			Amount = 70,
		},
		{
			Type = "Item",
			Name = "Energy Drink",
			Amount = 2,
		},
		{
			Type = "Item",
			Name = "Caramel",
			Amount = 10,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 3,
		},
	}
}