return {
	Quest = "One more!",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "White",
			Amount = 17500
		},
		[2] = {
			Type = "CollectPollen",
			Color = "Blue",
			Amount = 17500
		},
		[3] = {
			Type = "CollectPollen",
			Color = "Red",
			Amount = 17500
		},
		[4] = {
			Type = "CollectPollen",
			Amount = 17500
		},
		[5] = {
			Type = "CollectTokens",
			Amount = 50,
		},
	},
	Dialogues = {
		["Start"] = {
			"Greetings, beekeeper!",
			"Only one quest left before the big reveal.",
			"Are you ready?",
			"GO!",
		},
		["During"] = {
			"Stop wasting time, go, go!",
		},
		["Finish"] = {
			"Back so fast? I knew i could count on you.",
			"Anyways. I think you're ready."
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