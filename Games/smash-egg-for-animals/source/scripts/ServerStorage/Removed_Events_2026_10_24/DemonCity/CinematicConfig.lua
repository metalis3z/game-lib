-- DemonCity.CinematicConfig : tous les réglages de la cinématique "Demon City" et du combat contre le TRUE DEMON.
-- Utilisé par : DemonCityBuilder (ville), FightFilm.DemonFilm (cinématique), DemonCinematicServer, DemonBossController,
-- DemonArenaClient. Positions relatives au centre de la place (CENTER) ; le sol de la place est à CENTER.Y.
local V = Vector3.new
local Config = {}

---------------------------------------------------------------- la ville (loin de la carte, comme les autres décors de cinématique)
Config.CENTER = V(-6000, 300, -6000)
Config.PLAZA_HALF = 110      -- la grande place au centre (l'arène du boss) : 220 x 220 studs
Config.AVENUE_HALF = 34      -- demi-largeur de l'avenue sud et des rues est / ouest
Config.CITY_HALF = 430       -- la ville construite (au-delà : silhouettes d'immeubles lointains)
Config.ARENA_HALF = 104      -- les murs invisibles du combat (un peu à l'intérieur de la place)
Config.SEED = 6661

-- repères de la cinématique (relatifs à CENTER)
Config.Points = {
	HeroKino = V(-5, 0, 62),
	HeroRex = V(5, 0, 64),
	BossLand = V(0, 0, -6),
	HotelFront = -118,        -- z de la façade de l'hôtel abandonné (bout nord de la place) : le boss y est projeté
	TrueDemon = V(0, 0, -330), -- la silhouette géante de la phase 2 se lève derrière les immeubles du nord
	BossSpot = V(0, 0, -30),   -- départ du boss pendant le combat
}

---------------------------------------------------------------- cinématique
Config.Film = {
	Length = 61.5,   -- secondes de film (les ralentis l'allongent de quelques secondes en temps réel)
	MaxWait = 100,   -- le serveur lance le combat au plus tard après ce délai, même si aucun client n'a prévenu
	BossScale = 3.2, -- le démon de la phase 1 (environ 18 studs de haut)
	GiantScale = 24, -- la silhouette du TRUE DEMON au bout de l'avenue (environ 175 studs de haut)
}
-- textes à l'écran (modifiables ici)
Config.Lines = {
	Now = "MAINTENANT !",
	Behind = "Attends… regarde derrière toi.",
	Title = "PHASE 2 — THE TRUE DEMON",
	BossName = "THE TRUE DEMON",
	Kino = "kinoshi112",
	Rex = "rexydev1",
}

---------------------------------------------------------------- combat jouable (phase 2)
Config.Boss = {
	Scale = 6.2,           -- taille du TRUE DEMON dans l'arène (environ 36 studs de haut)
	MaxHp = 12000,
	BatDamage = 50, BatReach = 12, BatCooldown = 0.42,
	WalkSpeed = 14, RageWalkSpeed = 19,
	-- coup au sol : une onde rouge traverse la place, il faut sauter
	SlamEvery = 14, RageSlamEvery = 9, SlamWindup = 1.3, WaveTime = 2.4, WaveDamage = 25, WaveThickness = 6, SafeJump = 3.2,
	-- pluie de météores : des cercles rouges au sol, les boules de feu tombent 1,6 s plus tard
	MeteorEvery = 17, RageMeteorEvery = 11, MeteorWarn = 1.6, MeteorRadius = 10, MeteorDamage = 30, MeteorCount = 8,
	-- griffes : coup devant lui quand un joueur est tout près
	SwipeWindup = 0.75, SwipeDamage = 25, SwipeRange = 16,
	-- charge : une ligne rouge, puis il fonce à travers la place
	ChargeEvery = 22, RageChargeEvery = 15, ChargeWarn = 1.2, ChargeTime = 0.9, ChargeLength = 150, ChargeDamage = 35,
	-- phase enragée (sous la moitié des PV) : colonnes de feu qui filent du boss vers chaque joueur
	PillarEvery = 13, PillarDamage = 25, PillarStep = 9, PillarRadius = 6,
	EventSpeed = 60,       -- vitesse des joueurs pendant tout l'event (attribut EventSpeed, SpeedServer)
	MaxTime = 420, EmptyEnd = 4,
}
-- récompenses : classement aux dégâts, du meilleur au plus faible (les animaux de la Demon Zone)
Config.Rewards = {"Cerberus", "Hydra", "Chimera", "Manticore", "TripleCobra", "Bugman", "GargoyleBat", "WingedImp"}

---------------------------------------------------------------- sons et musiques (identifiants déjà utilisés dans le jeu)
Config.Music = {Epic = 9045936046, Fight = 1838626086}
Config.Sounds = {
	Boom = 7157159568, CosmicBoom = 9126102254, Meltdown = 6463943513, Punch = 109316755832781, HeavyPunch = 124469494822166,
	Clang = 9119747138, Spark = 9116279560, Screech = 9118850866, Hum = 9119392328, Fire = 9079463756, BatHit = 115569575216445,
	Whoosh = "rbxasset://sounds/swordlunge.wav", Swing = "rbxasset://sounds/swordslash.wav", Thud = "rbxasset://sounds/collide.wav",
	Thunder = "rbxasset://sounds/HalloweenThunder.wav", Ghost = "rbxasset://sounds/HalloweenGhost.wav",
}

function Config.world(localPos) return Config.CENTER + localPos end

return Config
