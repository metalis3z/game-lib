local module = {
	Name = "Sandy",
	Description = "An ordinary bee, but you'll never know how useful it is",
	
	Rarity = "Exclusive",
	Color = "Colorless",
	Sim = "",
	
	Attack = 5,
	Layout = 10,
	
	Icon = "rbxassetid://18631328138",
	Thumb = "rbxassetid://17256964441",
	GiftedThumb = "rbxassetid://15046296630",
	
	GiftedBonus = {"Pollen","Mult", 1.25},
	FavoriteFood = "Magic Treat",
	
	Speed = 13,
	Energy = 55,
	Particles = 5,
	
	CollectTime = 3,
	
	Tokens = {},
	
	ConvertsTime = 2,
	Converts = 150,
	
	StatsModule = {
		Collecting = 100,
		Power = 0.15,

		Bee = true,
		Color = "White",
		ColorMutltiplier = 4,
	},
}

return module