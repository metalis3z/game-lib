local DeivyConfig = {

	DisplayName = "Deivy",
	Quote = "\"hi guys, welcome to another tutorial!\"",
	Credits = "By: ImWaffles",
	Class = "Survivalist",
	RenderImage = "rbxassetid://90795979050143",
	Price = 800,

	Speed = 12,
	PlayerZapped = script.PlayerZap,
	LanternZapped = script.LanternZap,
	Beams = script.ZapBeams,
	HL = script.HL,
	WarningTemplate = script.Warning,
	LanternTemplate = script.Lantern,
	PointsTemplate = script.PointsUI,
	AddedTemplate = script.Points,

	PointsOnSpawn = 10,
	GeneratorReward = 25,
	OvertimeReward = 20,
	OvertimeInterval = 10,
	BuyCooldown = 5.25,
	MaxLanterns = 3,
	BuyCost = 50,

	ZapSize = Vector3.new(3.5, 3.5, 50),
	ZapCooldown = 1.5,
	SwapCooldown = 0.2,
	UpgradeCooldown = 2,
	Level1Cost = 20,
	Level2Cost = 35,

	Level0Effects = {
		Killer = {
			Slowness = { Level = 1, Duration = 3 },
			Exhaustion = { Level = 1, Duration = 2 }
		},
		Survivor = {}, 
		Yourself = {} 
	},

	Level1Effects = {
		Killer = {
			Stunned = { Level = 1, Duration = 2 }
		},
		Survivor = {
			Regeneration = { Level = 1, Duration = 7 }
		},
		Yourself = {} 
	},

	Level2Effects = {
		Yourself = {
			Speed = { Level = 2, Duration = 4 }
		},
		Killer = {
			Stunned = { Level = 1, Duration = 2.75 }
		},
		Survivor = {
			Slateskin = { Level = 2, Duration = 7 }
		}
	},

	Expressions = {
		Default = "rbxassetid://107463038895955",
		Injured = "rbxassetid://86033144554050",
		Dead = "rbxassetid://111986001435024"
	},

	Animations = {
		Buy = "rbxassetid://113554945978135",
		Buy2 = "rbxassetid://71570446699650",
		Upgrade = "rbxassetid://128530021615424",
		Upgrade2 = "rbxassetid://122383524994618",
		Zap = "rbxassetid://96370776906696"
	},

	Sounds = {
		Buy = "rbxassetid://126315588303825",
		Upgrade = "rbxassetid://132755898955805",
		Zap = "rbxassetid://103087946094940",
		ZapHit = "rbxassetid://92918937559659"
	},

	TextInteractions = {
		Requests = {

			ElliotPizza = { "Dude, I'm gonna need some of that pizza. I'm falling apart.", "I feel like I'm melting... Could I have some of that pizza?", "Don't look at my face... just... give me the pizza." },
			BuildermanSentry = { "Sentry would be about nice over... here.", "Good sentry would be there.", "Need a sentry here." },
			BuildermanDispenser = { "Place a dispenser over here, my face is falling apart.", "Good spot over there for your dispenser.", "Could I get a dispenser?", "Need a dispenser here." },
			DusekkarProtection = { "Could use some of that magic right about now!", "Look, these lamps aren't doing much, I need some of your magic.", "I need some help over here!", "I don't wanna get hurt without your magic." }
		},

		Thanks = {

			Regular = { "Good stuff. Thanks.", "Thank you.", "I'll remember you. Appreciate it." }
		}

	},

	Information = {
		{ Separator = "GENERAL INFO" },

		{ Header = "DEIVY", Text = "DeivyDoesTutorials33 is a character that has the sole interest on themselves, though occasionally can help other survivors.\n" },

		{ Header = "STATS", Text = "Difficulty: \226\152\133\226\152\133\226\152\134\226\152\134\226\152\134\nHealth: 100\nRegular Speed: 12\nSprinting Speed: 26\nMax Stamina: 100\nStamina Loss per sec: 10\nStamina Gain per sec: 20" },

		{ Separator = "PASSIVES" },

		{ Image = nil, Header = "PIECE WORK", Quote = "\"Lemme do dis\" - Deivy", Text = "Completing a generator puzzle will grant you $25, opening up his skill set." },

		{ Image = nil, Header = "OVERTIME", Quote = "\"I gotta keep doing dis\" - Deivy", Text = "Being the last survivor puts you in overtime. During overtime, you earn $20 every 10 seconds." },

		{ Separator = "ABILITIES" },

		{ Header = "BUY", Image = "rbxassetid://132289860246962", Text = "Cooldown: 10s\nInitially costs $50 and will spawn a lantern which rotates around Deivy\nOnly 3 lanterns are able to be equipped at the same time." },

		{ Header = "ZAP", Image = "rbxassetid://125360611591968", Text = "Cooldown: 35s\nOne of Deivy's lanterns will be used and zap anything 60 studs in front of him.\nThe effect of each zap depends on the lantern's level." },

		{ Header = "UPGRADE", Image = "rbxassetid://72823847058475", Text = "Cooldown: 2s\nBy default your lantern will apply 'Slowness' and 'Exhaustion' to the killer\nThe first upgrade will allow you to heal teammates and stun the killer.\nThe second upgrade can provide you a speed boost and stun the killer for a longer duration." },

		{ Header = "SWAP", Image = "rbxassetid://86715533828811", Text = "Cooldown: 0.1s\nThis allows you to specifically select which lantern you want to upgrade/zap with. It will be indicated with a white outline." }

	}

}

return DeivyConfig