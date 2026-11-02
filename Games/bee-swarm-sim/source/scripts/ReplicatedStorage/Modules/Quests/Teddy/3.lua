return {
	Quest = "#3 Moon Flowers",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "Blue",
			Field = "Blue Flowers",
			Amount = 700,
		},
	},
	Dialogues = {
		["Start"] = {
			"Hello Again",
			"I wonder why they say that blue pollen is better..",
			"No idea. But I need that blue pollen!",
			"Could you please collect 700 Blue pollen in blue flowers field?",
			"Thanks! I appreciate your work!",
			"Come back after you finish for the reward, as always!",
		},
		["During"] = {
			"I still don't know why blue is better...",
		},
		["Finish"] = {
			"Well done, you have completed my quest. Here's the reward!",
			"Come back for more quests!"
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 800,
		},
		{
			Type = "Item",
			Name = "Blueberry",
			Amount = 35,
		},
		{
			Type = "Item",
			Name = "Blueberry Juice",
			Amount = 1,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 3,
		},
	}
}