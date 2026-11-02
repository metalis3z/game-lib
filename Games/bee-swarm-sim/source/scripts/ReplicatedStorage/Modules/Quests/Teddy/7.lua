return {
	Quest = "#7 Preparing a big quest",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "White",
			Amount = 10000
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Daisy",
			Amount = 7500
		},
		
		[3] = {
			Type = "CollectPollen",
			Color = "White",
			Field = "Red Flowers",
			Amount = 1000,
		},
		[4] = {
			Type = "CollectPollen",
			Color = "White",
			Field = "Blue Flowers",
			Amount = 1000,
		},
		--[5] = {
		--	Type = "CollectToken",
		--	--Token = "", -- Белые токены 
		--	Amount = 10,
		--},
	},
	Dialogues = {
		["Start"] = {
			"Are you ready for your new quest?",
			"In this task you will collect only white pollen!",
			"After a couple of such quests, you will face a real challenge!",
			"And now I'm going to start preparing you for this.",
			"Therefore, complete this quest for me!",
			"Good luck!"
		},
		["During"] = {
			"It shouldn't be that hard..."
		},
		["Finish"] = {
			"Well done, you did the job pretty well!",
			"But do not relax yet, you will find difficult quests in the future.",
			"See you soon!",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 8000,
		},
		{
			Type = "Item",
			Name = "Seed",
			Amount = 85,
		},
		{
			Type = "Item",
			Name = "Blueberry Juice",
			Amount = 2,
		},
		{
			Type = "Item",
			Name = "Strawberry Juice",
			Amount = 2,
		},
		{
			Type = "Item",
			Name = "Fertilizer",
			Amount = 1,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 3,
		},
	}
}