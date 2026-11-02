return {
	Quest = "#22 Multicolor Madness III",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "Blue",
			Amount = 15000000,
		},
		[2] = {
			Type = "CollectPollen",
			Color = "Red",
			Amount = 15000000,
		},
		[3] = {
			Type = "CollectPollen",
			Color = "White",
			Amount = 15000000,
		},
		[4] = {
			Type = "UseItem",
			Item = "Blueberry Juice",
			Amount = 1,
		},
		[5] = {
			Type = "UseItem",
			Item = "Strawberry Juice",
			Amount = 1,
		},	
	},	
	Dialogues = {
		["Start"] = {
			"gl",
		},
		["During"] = {
			"..."
		},
		["Finish"] = {
			"...",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 20000000,
		},
		{
			Type = "Item",
			Name = "Caramel Bottle",
			Amount = 15
		},
		{
			Type = "Item",
			Name = "Blueberry Juice",
			Amount = 15
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 15
		},
	}
}