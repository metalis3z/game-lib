return {
	Quest = "#6 Get Fertilized",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "White",
			Amount = 3500
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Daisy",
			Amount = 2750,
		},
		--[3] = {
		--	Type = "CollectToken",
		--	--Token = "", -- Какой-то белый токен 
		--	Amount = 5,
		--},
		[3] = {
			Type = "UseItem",
			Item = "Fertilizer",
			Amount = 1,
		},
	},
	Dialogues = {
		["Start"] = {
			"Hello again. Did you hatch that silver egg I gave you?",
			"I hope you got something good!",
			"If not.. You can buy BEE JELLIES in that shop to the left of the hives",
			"They are quite pricy though",
			"Nevermind! Lets get back to you next quest!",
			"This time, you will need to use the item I gave you last quest to see how it works",
			"No, not the silver egg, the FERTILIZER",
			"Go to daisy field and use it! I bet you'll like what happens next!"
		},
		["During"] = {
			"You didn't use fertilizer before you took my quest, did you?"
		},
		["Finish"] = {
			"Well done! You've completed my quest!",
			"How do you like the new tasks? Do you understand everything?",
			"New quests will often have those kind of tasks, so get ready",
			"I will be waiting for you here!",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 6850,
		},
		{
			Type = "Item",
			Name = "Treat",
			Amount = 100,
		},
		{
			Type = "Item",
			Name = "Oil",
			Amount = 1,
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