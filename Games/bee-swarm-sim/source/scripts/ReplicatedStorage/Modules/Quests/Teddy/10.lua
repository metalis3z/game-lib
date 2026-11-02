return {
	Quest = "#10 BIG GAME I",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Strawberry",
			Amount = 15000
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Lemon",
			Amount = 15000
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Cabbage",
			Amount = 15000
		},
		[4] = {
			Type = "CollectPollen",
			Field = "Red Flowers",
			Amount = 10000
		},
		[5] = {
			Type = "CollectPollen",
			Field = "Blue Flowers",
			Amount = 10000
		},
		[6] = {
			Type = "CollectPollen",
			Field = "Daisy",
			Amount = 10000
		},
		[7] = {
			Type = "CollectPollen",
			Field = "Fungus",
			Amount = 10000
		},
		[8] = {
			Type = "CollectPollen",
			Color = "Red",
			Amount = 30000
		},
		[9] = {
			Type = "CollectPollen",
			Color = "White",
			Amount = 30000
		},
		[10] = {
			Type = "CollectPollen",
			Color = "Blue",
			Amount = 30000
		},
		--[11] = {
		--	Type = "CollectTokens",
		--	Token = "Lemon", 
		--	Amount = 10,
		--},
		--[12] = {
		--	Type = "CollectTokens",
		--	Token = "Strawberry",
		--	Amount = 10,
		--},
	},
	Dialogues = {
		["Start"] = {
			"Welcome to the BIG GAME!",
			"You have a lot to do in this quest",
			"Now there will be a few words about big games",
			"There are a couple more such big games waiting for you, in the last game you will have a very big quest",
			"And",
			"There will also be a very big reward, which you will learn about later",
			"Also, for each big game you will get a good, big reward that you will like.",
			"I hope you have the strength to reach the end!",
			"Good luck with this big assignment!",
			"I'm sure you can do it!",
		},
		["During"] = {
			"You haven't done the quest yet",
			"You still need to complete some tasks so that I can accept the quest from you!",
		},
		["Finish"] = {
			"YOU HAVE COMPLETED THE FIRST BIG GAME!",
			"I CONGRATULATE YOU ON THIS!",
			"Now you will find even more difficult quests that you will like",
			"It's time for you to get your reward!",
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
			Name = "BJ Point",
			Amount = 10,
		},
		{
			Type = "Item",
			Name = "Treat",
			Amount = 500,
		},
		{
			Type = "Item",
			Name = "Seed",
			Amount = 100,
		},
		{
			Type = "Item",
			Name = "Ticket",
			Amount = 30,
		},
		{
			Type = "Item",
			Name = "Sugar",
			Amount = 35,
		},
		{
			Type = "Item",
			Name = "Instant Converter",
			Amount = 5,
		},
		{
			Type = "Item",
			Name = "Sprout Bean",
			Amount = 5,
		},
		{
			Type = "Item",
			Name = "Caramel",
			Amount = 15,
		},
		{
			Type = "Item",
			Name = "Golden Egg",
			Amount = 1,
		},
	}
}