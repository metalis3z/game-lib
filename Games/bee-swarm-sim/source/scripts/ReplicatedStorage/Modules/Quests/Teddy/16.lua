	return {
	Quest = "#16 Diamond Journey I",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Clover",
			Amount = 500000,
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Pine Tree",
			Amount = 500000,
		},
		[3] = {
			Type = "UseItem",
			Item = "Blueberry Juice",
			Amount = 2,
		},
	},	
	Dialogues = {
		["Start"] = {
			"So.. I wanted to ask.",
			"Have you got any legendary bees?",
			"Or maybe even MYTHIC bees?",
			"Want to know how to get those?..",
			"a DIAMOND EGG may help you..",
			"With 95% chance of hatching a legendary bee,",
			"..and 5% of hatching a MYTHIC bee!",
			"I know you want that DIAMOND EGG..",
			"Complete next 5 quests and it's yours!",
			"Here you go.. Check the quest menu for the quest, as always"
		},
		["During"] = {
			"I want those mythic bees"
		},
		["Finish"] = {
			"Just.. Take the reward",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 750000,
		},
		{
			Type = "Item",
			Name = "Blueberry Juice",
			Amount = 1,
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



-- 16-20 КВЕСТЫ ПОТЕНЦИАЛЬНЫЙ НЕРФ