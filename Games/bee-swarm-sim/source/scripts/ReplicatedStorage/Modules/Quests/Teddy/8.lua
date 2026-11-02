return {
	Quest = "#8 Pollen Harvesting",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Amount = 30000,
		},
	},
	
	Dialogues = {
		["Start"] = {
			"Hello again!",
			"This quest is gonna be easy!",
			"And reward wont be horrible, trust me!",
			"I'm waiting for you!"
		},
		["During"] = {
			"Quest isnt even that hard!"
		},
		["Finish"] = {
			"You did it! And now you're ready for the difficulty increase!",
			"The next quest will be much harder!",
			"I'm waiting for you here!",
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
			Name = "Treat",
			Amount = 50,
		},
		{
			Type = "Item",
			Name = "Lemon",
			Amount = 15,
		},
		{
			Type = "Item",
			Name = "Oil",
			Amount = 5,
		},
		{
			Type = "Item",
			Name = "Energy Drink",
			Amount = 3,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 3,
		},
	},
}