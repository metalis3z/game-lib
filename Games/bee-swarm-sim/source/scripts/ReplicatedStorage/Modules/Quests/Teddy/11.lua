return {
	Quest = "#11 Red Converting",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Red Flowers",
			Color = "Red",
			Amount = 100000,
		},
		--[2] = {
		--	Type = "CollectTokens",
		--	Token = "", --красный буст
		--	Amount = 30,
		--},
		[2] = {
			 Type = "ConvertPollen",
			 Amount = 50000,
		}
	},	
	Dialogues = {
		["Start"] = {
			"Hello!",
			"I hope you enjoyed reward for the big game!",
			"This quest is really easy compared to last one..",
			"All I need from you is..",
			"Collect 100K Red Pollen from Daisy field,",
			"..collect 30 red boost tokens,",
			"..and convert 50K Pollen!",
			"Return when you're done!"
		},
		["During"] = {
			"..."
		},
		["Finish"] = {
			"You did it!",
			"I hope bees aren't very tired after converting this much pollen",
			"Here's your reward!",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 90000,
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 2,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 5,
		},
	}
}