return {
	Quest = "#17 Diamond Journey II",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Fungus",
			Amount = 750000,
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Clover",
			Amount = 750000,
		},
		[3] = {
			Type = "CollectPollen",
			Color = "Blue",
			Amount = 1000000,
		},
	},	
	Dialogues = {
		["Start"] = {
			"You're not an average beekeeper..",
			"You're the one, who won't stop until he gets to the top..",
			"I think you would like a raise of difficulty?",
			"Take the quest",
		},
		["During"] = {
			"..."
		},
		["Finish"] = {
			"You're.. unstoppable??",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 1000000,
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 3,
		},
		{
			Type = "Item",
			Name = "BJ Point",
			Amount = 2,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 5,
		},
	}
}