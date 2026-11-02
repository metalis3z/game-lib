return {
	Quest = "Each quest closer...",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Dandelion",
			Amount = 3000,
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Clover",
			Amount = 2300,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Pine Tree",
			Amount = 4000
		},
		[4] = {
			Type = "CollectPollen",
			Amount = 5000
		},
		[5] = {
			Type = "UseItem",
			Item = "Oil",
			Amount = 2,
		},
	},
	Dialogues = {
		["Start"] = {
			"Welcome back!",
			"I have nothing else to say to you, so just collect.",
			"Good luck!",
		},
		["During"] = {
			"~Laa, lalalaaaa~",
		},
		["Finish"] = {
			"Good job!",
			"Here you go! Talk to me for the next quest."
		}
	},

	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 10000,
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