-- EXCHANGE EXAMPLE --

   --[[ CurrencyExchange = {
        Type = "Materials", 
        Description = "Exchange 1(amount) EventCurrency for 20(reward amount) YourCurrency.", 
        LayoutOrder = 1000, 
        Price = {
            EventCurreny = 1(amount)
        }, 
        RewardID = "YourCurrency", 
        RewardAmount = 20(reward amount)
    },]]


return {
	Key = {
		Type = "Weapons", 
		Description = "Can be used once to open a standard mystery box. Tradeable!", 
		Price = {
			Gems = 125
		}, 
		LayoutOrder = 1000
	}, 
	Summer2026Box = {
		LayoutOrder = 1,
		Price = {
			Gems = 60,
			SummerKey2026 = 120,
		},
		Type = "MysteryBox",
	},
	GoldFakeBomb = {
		Type = "Toys", 
		Description = "[Limited] Available for a limited time, then goes off-sale.", 
		Price = {
			Robux = 39
		}, 
		RewardItems = {
			{
				ItemId = "GoldBomb", 
				ItemType = "Toys"
			}
		}, 
		GamepassId = 1405542167, 
		DevProductId = 00, 
		Limited = false
	}, 
	MysteryBox1 = {
		Type = "MysteryBox", 
		Price = {
			Coins = 1000, 
			Gems = 100, 
			Key = 1
		}, 
		LayoutOrder = 100
	}, 
	MysteryBox2 = {
		Type = "MysteryBox", 
		Price = {
			Coins = 1000, 
			Gems = 100, 
			Key = 1
		}, 
		LayoutOrder = 100
	}, 
	KnifeBox1 = {
		Type = "MysteryBox", 
		Price = {
			Coins = 1000, 
			Gems = 100, 
			Key = 1
		}, 
		LayoutOrder = 301
	}, 
	KnifeBox2 = {
		Type = "MysteryBox", 
		Price = {
			Coins = 1000, 
			Gems = 100, 
			Key = 1
		}, 
		LayoutOrder = 302
	}, 
	KnifeBox3 = {
		Type = "MysteryBox", 
		Price = {
			Coins = 1000, 
			Gems = 100, 
			Key = 1
		}, 
		LayoutOrder = 303
	}, 
	KnifeBox4 = {
		Type = "MysteryBox", 
		Price = {
			Coins = 1000, 
			Gems = 100, 
			Key = 1
		}, 
		LayoutOrder = 304
	}, 
	KnifeBox5 = {
		Type = "MysteryBox", 
		Price = {
			Coins = 1000, 
			Gems = 100, 
			Key = 1
		}, 
		LayoutOrder = 305
	}, 
	["MLG Box"] = {
		Type = "MysteryBox", 
		Price = {
			Coins = 1000, 
			Gems = 100, 
			Key = 1
		}, 
		LayoutOrder = 306
	}, 
	GunBox1 = {
		Type = "MysteryBox", 
		Price = {
			Coins = 1000, 
			Gems = 100, 
			Key = 1
		}, 
		LayoutOrder = 401
	}, 
	GunBox2 = {
		Type = "MysteryBox", 
		Price = {
			Coins = 1000, 
			Gems = 100, 
			Key = 1
		}, 
		LayoutOrder = 402
	}, 
	GunBox3 = {
		Type = "MysteryBox", 
		Price = {
			Coins = 1000, 
			Gems = 100, 
			Key = 1
		}, 
		LayoutOrder = 403
	}, 
	Knifeception = {
		Type = "Effects", 
		Price = {
			Gems = 300
		},
		LayoutOrder = 7
	}, 
	Burn = {
		Type = "Effects", 
		Price = {
			Coins = 4000
		},
		LayoutOrder = 6
	}, 
	BlueFire = {
		Type = "Effects", 
		Price = {
			Gems = 800
		},
		LayoutOrder = 9
	}, 
	PinkFire = {
		Type = "Effects", 
		Price = {
			Gems = 800
		},
		LayoutOrder = 10
	}, 
	GreenFire = {
		Type = "Effects", 
		Price = {
			Gems = 800
		},
		LayoutOrder = 8
	}, 
	Dual = {
		Type = "Effects", 
		Price = {
			Gems = 900
		},
		LayoutOrder = 11
	}, 
	Electric = {
		Type = "Effects", 
		Price = {
			Gems = 1000
		},
		LayoutOrder = 12
	}, 
	Ghostify = {
		Type = "Effects", 
		Price = {
			Gems = 200, 
			Coins = 2000
		},
		LayoutOrder = 4
	}, 
	Heartify = {
		Type = "Effects", 
		Price = {
			Coins = 2400
		},
		LayoutOrder = 5
	}, 
	Radioactive = {
		Type = "Effects", 
		Price = {
			Coins = 1600
		},
		LayoutOrder = 2
	}, 
	Musical = {
		Type = "Effects", 
		Price = {
			Coins = 2000
		},
		LayoutOrder = 3
	}, 
	Sleight = {
		Type = "Perks", 
		Price = {
			Coins = 1000, 
			Gems = 100
		},
		LayoutOrder = 2
	}, 
	Ninja = {
		Type = "Perks", 
		Price = {
			Coins = 1000, 
			Gems = 100
		},
		LayoutOrder = 1
	}, 
	FakeGun = {
		Type = "Perks", 
		Price = {
			Coins = 3000, 
			Gems = 400
		},
		LayoutOrder = 6
	}, 
	Haste = {
		Type = "Perks", 
		Price = {
			Coins = 3000, 
			Gems = 400
		},
		LayoutOrder = 3
	}, 
	Sprint = {
		Type = "Perks", 
		Price = {
			Coins = 3000, 
			Gems = 400
		},
		LayoutOrder = 5
	}, 
	Trap = {
		Type = "Perks", 
		Price = {
			Coins = 3000, 
			Gems = 400
		},
		LayoutOrder = 4
	}, 
	Ghost = {
		Type = "Perks", 
		Price = {
			Coins = 6000, 
			Gems = 800
		},
		LayoutOrder = 8
	}, 
	Xray = {
		Type = "Perks", 
		Price = {
			Coins = 6000, 
			Gems = 800
		},
		LayoutOrder = 9
	}, 
	Decoy = {
		Type = "Perks", 
		Price = {
			Coins = 3000, 
			Gems = 400
		},
		LayoutOrder = 7
	}, 
	sit = {
		Type = "Emotes", 
		Description = "Have a seat after a long day of coin-collecting.", 
		Price = {
			Coins = 800
		},
		LayoutOrder = 6
	}, 
	ninja = {
		Type = "Emotes", 
		Description = "Embrace the shadow of a ninja with this flexible pose.", 
		Price = {
			Coins = 2600
		},
		LayoutOrder = 8
	}, 
	dab = {
		Type = "Emotes", 
		Description = "Hit a HUGE dab on your enemies!", 
		Price = {
			Coins = 2800
		},
		LayoutOrder = 9
	}, 
	zen = {
		Type = "Emotes", 
		Description = "Experience tranquility with this relaxing zen pose.", 
		Price = {
			Gems = 800
		},
		LayoutOrder = 14
	}, 
	floss = {
		Description = "FLOSS on your enemies!", 
		Type = "Emotes", 
		Price = {
			Gems = 750
		},
		LayoutOrder = 13
	}, 
	Fireflies = {
		Type = "Toys", 
		Description = "Release a jar of fireflies.", 
		Price = {
			Coins = 1500
		},
		LayoutOrder = 7
	}, 
	GGSign = {
		Type = "Toys", 
		Description = "Good game!", 
		Price = {
			Gems = 100
		},
		LayoutOrder = 11
	}, 
	ChocolateMilk = {
		Type = "Toys", 
		Description = "Relax after a long day of unboxing crates with a cool glass of chocolate milk.", 
		Price = {
			Coins = 400
		},
		LayoutOrder = 4
	}, 
	SprayPaint = {
		Type = "Toys", 
		Description = "Spray paint your favorite decals on the walls.", 
		Price = {
			Gems = 750
		},
		LayoutOrder = 12
	}, 
	FakeBomb = {
		Type = "Toys", 
		Description = "Prank your friends with this confetti bomb!", 
		Price = {
			Coins = 4800
		},
		LayoutOrder = 10
	}, 
	IceCream = {
		Type = "Toys", 
		Description = "Yummy!", 
		Price = {
			Coins = 400
		},
		LayoutOrder = 3
	}, 
	Pizza = {
		Type = "Toys", 
		Description = "Pizza = delicious.", 
		Price = {
			Coins = 400
		},
		LayoutOrder = 2
	}, 
	Teddy = {
		Type = "Toys", 
		Description = "He will always love you forever.", 
		Price = {
			Coins = 600
		},
		LayoutOrder = 5
	}, 
	Dubstep = {
		Type = "Radios", 
		Price = {
			Coins = 1200
		},
		LayoutOrder = 7
	}, 
	Gold = {
		Type = "Radios", 
		Price = {
			Coins = 12000
		},
		LayoutOrder = 13
	}, 
	BluesteelRadio = {
		Type = "Radios", 
		Price = {
			Coins = 3200
		},
		LayoutOrder = 9
	}, 
	CamoRadio = {
		Type = "Radios", 
		Price = {
			Coins = 2000
		},
		LayoutOrder = 8
	}, 
	Boombastic = {
		Type = "Radios", 
		Price = {
			Coins = 3600
		},
		LayoutOrder = 12
	}, 
	Omega = {
		Type = "Radios", 
		Price = {
			Gems = 400
		},
		LayoutOrder = 14
	}, 
	RainbowRadio = {
		Type = "Radios", 
		Price = {
			Gems = 800
		},
		LayoutOrder = 2
	}, 
	FadeRadio = {
		Type = "Radios", 
		Price = {
			Gems = 400
		},
		LayoutOrder = 1
	}, 
	Flaming = {
		Description = "A flaming radio.", 
		Type = "Radios", 
		Price = {
			Gems = 900
		},
		LayoutOrder = 3
	}, 
	GreenSparkleRadio = {
		Description = "A green sparkly radio.", 
		Type = "Radios", 
		Price = {
			Gems = 1000
		},
		LayoutOrder = 5
	}, 
	PinkSparkleRadio = {
		Description = "A pink sparkly radio.", 
		Type = "Radios", 
		Price = {
			Gems = 1000
		},
		LayoutOrder = 15
	}, 
	BlueSparkleRadio = {
		Description = "A blue sparkly radio.", 
		Type = "Radios", 
		Price = {
			Gems = 1000
		},
		LayoutOrder = 6
	}, 
	RedSparkleRadio = {
		Description = "A red sparkly radio.", 
		Type = "Radios", 
		Price = {
			Gems = 1000
		},
		LayoutOrder = 4
	}, 
	DiamondRadio = {
		Description = "A diamond radio.", 
		Type = "Radios", 
		Price = {
			Gems = 2500
		},
		LayoutOrder = 16
	}, 
	Egg = {
		Type = "Eggs", 
		Price = {
			Coins = 1000, 
			Gems = 100
		}, 
		LayoutOrder = 100
	},
};