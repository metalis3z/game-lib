local module = {
	Name = script.Name,
	Description = "He is really happy to spend time with you",
	
	Rarity = "Rare",
	Color = "Colorless",
	Sim = "!",
	
	Attack = 2,
	Layout = 30,
	
	Icon = "rbxassetid://16827170837",
	Thumb = "rbxassetid://17256972738",
	GiftedThumb = "rbxassetid://15046296630",
	
	GiftedBonus = {"Player Movespeed","Mult", 1.2},
	FavoriteFood = "Lemon",
	
	Speed = 20,
	Energy = 30,
	Particles = 10,
	
	CollectTime = 1,

	Tokens = {"Haste"},
	
	ConvertsTime = 1,
	Converts = 50,
	
	StatsModule = {
		Collecting = 20,
		Power = 0.1,
		
		Bee = true,
		Color = "White",
		ColorMutltiplier = 5,
	},
}

return module