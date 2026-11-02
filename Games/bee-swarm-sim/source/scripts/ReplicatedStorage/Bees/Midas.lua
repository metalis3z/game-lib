local module = {
	Name = "Midas",
	Description = "An ordinary bee, but you'll never know how useful it is",
	
	Rarity = "Exclusive",
	Color = "Colorless",
	Sim = "",
	
	Attack = 7,
	Layout = 20,
	
	Icon = "rbxassetid://18631320566",
	Thumb = "rbxassetid://17256964441",
	GiftedThumb = "rbxassetid://15046296630",
	
	GiftedBonus = {"Pollen","Mult", 1.25},
	FavoriteFood = "Magic Treat",
	
	Speed = 12,
	Energy = 100,
	Particles = 5,
	
	CollectTime = 6,
	
	Tokens = {},
	
	ConvertsTime = 6,
	Converts = 250,
	
	StatsModule = {
		Collecting = 150,
		Power = 0.5,

		Bee = true,
		Color = "White",
		ColorMutltiplier = 4,
	},
}

return module