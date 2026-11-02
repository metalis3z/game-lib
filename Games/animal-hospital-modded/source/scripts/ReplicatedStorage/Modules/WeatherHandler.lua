local WeatherHandler = {}

-- "rbxassetid://101156689731388",


--Candy
--Lava 
--Frost
--Toxic
--Disco
--Hacker
--Aura

WeatherHandler.Normal = {
	ClockTime = 13,
	AtmosphereColor = Color3.fromRGB(255, 255, 255),
}


WeatherHandler.WheatherList = {
	
	Candy = {
		FolderName	= "Candy",
		ClockTime	= 3,
		AtmosphereColor = Color3.fromRGB(255, 65, 122),
		FlashColor	= Color3.fromRGB(238, 104, 248),
		SoundID  = "rbxassetid://101156689731388",
		Image	= "rbxassetid://97104601440416",
		Time	= 1 * 60, -- one minute
		Bonuses = {
			LuckMultiplier = 4,
			CashMultiplier = 2,
		},
	},
	
	Lava = {
		FolderName	= "Lava",
		ClockTime	= 3,
		AtmosphereColor = Color3.fromRGB(173, 0, 6),
		FlashColor	= Color3.fromRGB(191, 33, 36),
		SoundID  = "rbxassetid://101156689731388",
		Image	= "rbxassetid://92739126612427",
		Time	= 2 * 60, -- two minute
		Bonuses = {
			LuckMultiplier = 4,
			CashMultiplier = 2,
		},
	},
	
	Frost = {
		FolderName	= "Frost",
		ClockTime	= 3,
		AtmosphereColor = Color3.fromRGB(0, 130, 115),
		FlashColor	= Color3.fromRGB(108, 194, 199),
		SoundID  = "rbxassetid://101156689731388",
		Image	= "rbxassetid://120259513292808",
		Time	= 1 * 60, -- one minute
		Bonuses = {
			LuckMultiplier = 4,
			CashMultiplier = 2,
		},
	},
	
	Toxic = {
		FolderName	= "Toxic",
		ClockTime	= 3,
		AtmosphereColor = Color3.fromRGB(103, 130, 86),
		FlashColor	= Color3.fromRGB(59, 166, 48),
		SoundID  = "rbxassetid://101156689731388",
		Image	= "rbxassetid://127515636530894",
		Time	= 2 * 60, -- two minute
		Bonuses = {
			LuckMultiplier = 4,
			CashMultiplier = 2,
		},
	},
	
	Disco = {
		FolderName	= "Disco",
		ClockTime	= 3,
		AtmosphereColor = Color3.fromRGB(130, 52, 113),
		FlashColor	= Color3.fromRGB(163, 41, 167),
		SoundID  = "rbxassetid://101156689731388",
		Image	= "rbxassetid://139307491311295",
		Time	= 1 * 60, -- one minute
		Bonuses = {
			LuckMultiplier = 4,
			CashMultiplier = 2,
		},
	},
	
	Hacker = {
		FolderName	= "Hacker",
		ClockTime	= 3,
		AtmosphereColor = Color3.fromRGB(49, 138, 67),
		FlashColor	= Color3.fromRGB(59, 166, 48),
		SoundID  = "rbxassetid://101156689731388",
		Image	= "rbxassetid://121713236923287",
		Time	= 2 * 60, -- two minute
		Bonuses = {
			LuckMultiplier = 4,
			CashMultiplier = 2,
		},
	},
	
	Aura = {
		FolderName	= "Aura",
		ClockTime	= 3,
		AtmosphereColor = Color3.fromRGB(130, 52, 113),
		FlashColor	= Color3.fromRGB(163, 41, 167),
		SoundID  = "rbxassetid://101156689731388",
		Image	= "rbxassetid://125356575288990",
		Time	= 1 * 60, -- one minute
		Bonuses = {
			LuckMultiplier = 4,
			CashMultiplier = 2,
		},
	},
}


return WeatherHandler
