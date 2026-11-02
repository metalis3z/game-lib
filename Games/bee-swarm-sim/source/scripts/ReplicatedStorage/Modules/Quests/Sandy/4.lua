return {
	Quest = "Revenge Reversed",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "White",
			Amount = 700
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Wheat",
			Amount = 1800,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Daisy",
			Amount = 500,
		},
		[4] = {
			Type = "CollectPollen",
			Field = "Strawberry",
			Amount = 2000,
		},
		[5] = {
			Type = "UseItem",
			Item = "Strawberry Juice",
			Amount = 1
		},
	},
	Dialogues = {
		["Start"] = {
			"Hello!",
			"Did you like the last quest?",
			"Well... Now the reds are mad.",
			"Wanna help them?",
			"Collect 2000 pollen in the Strawberry field,",
			"Collect 1800 pollen in the Wheat field,",
			"Collect 700 white pollen,",
			"Collect 500 pollen from Daisy field,",
			"And...",
			"Use 1 Strawberry Juice!",
			"Go beekeeper, go!",
		},
		["During"] = {
			"Why are you still here?",
			"Help them!!"
		},
		["Finish"] = {
			"Okay, Congrats.",
			"Here is your reward!"
		}
	},

	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 3500,
		},
		{
			Type = "Item",
			Name = "Caramel Bottle",
			Amount = 5,
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 5,
		},
	}
}