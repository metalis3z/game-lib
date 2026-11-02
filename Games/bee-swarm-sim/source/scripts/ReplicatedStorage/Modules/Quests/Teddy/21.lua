return {
	Quest = "#21 Pollen Collecting XXL",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Amount = 30000000,
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
			Amount = 10000000,
		},
		{
			Type = "Item",
			Name = "Oil",
			Amount = 10
		}
	}
}