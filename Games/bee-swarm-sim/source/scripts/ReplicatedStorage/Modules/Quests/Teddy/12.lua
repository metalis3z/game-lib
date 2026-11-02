return {
	Quest = "#12 Blue Converting",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Blue Flowers",
			Color = "Blue",
			Amount = 120000,
		},
		--[2] = {
		--	Type = "CollectTokens",
		--	Token = "", --синий буст
		--	Amount = 30,
		--},
		[2] = {
			 Type = "ConvertPollen",
			 Amount = 70000,
		}
	},	
	Dialogues = {
		["Start"] = {
			"Ready for you next quest?",
			"This time you need to do the same but with blue pollen!",
			"And a bit of a requirement increase, of course..",
		},
		["During"] = {
			"..."
		},
		["Finish"] = {
			"That wasn't too hard right?",
			"especially compared to that BIG GAME quest..",
			"Take the reward",
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
			Name = "Blueberry Juice",
			Amount = 2,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 5,
		},
	}
}