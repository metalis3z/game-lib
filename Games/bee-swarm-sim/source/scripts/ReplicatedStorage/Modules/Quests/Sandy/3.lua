return {
	Quest = "Blue Revenge",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "Blue",
			Amount = 700
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Blue Flowers",
			Amount = 1200,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Lemon",
			Amount = 1400,
		},
		[4] = {
			Type = "CollectPollen",
			Field = "Strawberry",
			Amount = 700,
		},
		[5] = {
			Type = "UseItem",
			Item = "Sprout Bean",
			Amount = 1
		},
	},
	Dialogues = {
		["Start"] = {
			"Hello Again!",
			"I've never actually heard anyone speak about blue hive color. Why is that?",
			"Let's make them pay for it!",
			"Collect 700 Blue pollen,",
			"Collect 1400 pollen in the Lemon field,",
			"Collect 1400 pollen in the Blue Flowers field,",
			"Collect 700 pollen in the Strawberry field,",
			"And...",
			"Use 1 sprout!",
			"Go beekeeper, go!",
		},
		["During"] = {
			"Why are you still here?",
			"Make reds regret it!"
		},
		["Finish"] = {
			"Here is your reward!"
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 4000,
		},
		{
			Type = "Item",
			Name = "Oil",
			Amount = 5,
		},
		{
			Type = "Item",
			Name = "Blueberry Juice",
			Amount = 3,
		},
		{
			Type = "Item",
			Name = "Sugar",
			Amount = 25,
		},
	}
}