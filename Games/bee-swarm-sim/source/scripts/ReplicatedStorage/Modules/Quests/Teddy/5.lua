return {
	Quest = "#5 Multicolor Madness",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Daisy",
			Amount = 2500
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Blue Flowers",
			Amount = 2500,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Red Flowers",
			Amount = 2500,
		},
	},
	Dialogues = {
		["Start"] = {
			"You already finished 4 of my quests.. But this one is special!",
			"After completing this long quest you will get something really cool!",
			"But first, the quest:",
			"Collect 2.5k pollen on the Daisy field",
			"Collect 2.5k pollen on the Blue Flowers field",
			"and..",
			"Collect 2.5k pollen on the Red Flowers field",
			"Good luck!"
		},
		["During"] = {
			"I think you want to know what will you get for this quest..",
			"Finish the quest and come back for an amazing reward.."
		},
		["Finish"] = {
			"Wow! You actually did it!",
			"It wasn't that hard, was it?",
			"So now it's time for the reward.. I present to you..",
			".. a SILVER EGG!",
			"Use it in your hive to get a rare bee or any bee with a higher rarity!",
			"You can get a rare bee with 80% chance,",
			"an EPIC bee with 17% chance,",
			"and a LEGENDARY bee with 3% chance!",
			"Good luck hatching something cool!!",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 5500,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 10,
		},
		{
			Type = "Item",
			Name = "Fertilizer",
			Amount = 3,
		},
		{
			Type = "Item",
			Name = "Silver Egg",
			Amount = 1,
		},
	},
}