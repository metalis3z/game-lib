-- Configuration des oeufs, des animaux et de l'inventaire
local rgb = Color3.fromRGB
local K = ColorSequenceKeypoint.new

local EggConfig = {}

EggConfig.MaxPlaced = 10      -- animaux posés max dans le jardin
EggConfig.MaxInventory = 50   -- animaux max dans l'inventaire
EggConfig.MaxEggs = 50        -- oeufs max (inventaire + jardin)
EggConfig.MaxPlacedEggs = 10  -- oeufs posés en même temps dans le jardin
EggConfig.OwnerCooldown = 5   -- temps d'éclosion (s) pour le créateur, quel que soit l'oeuf
EggConfig.WanderSpeed = 10    -- vitesse de balade (studs / seconde)

-- Durées (s) de l'animation de sortie d'oeuf
EggConfig.Hatch = {
	Wobble = 3,   -- l'oeuf tremble avant de s'ouvrir
	Pop = 0.4,    -- l'animal sort
	Circle = 2, -- il monte en tournant sur lui-même : un tour complet (360°) en 2 secondes
	Pocket = 1.0, -- il redescend dans la poche en rétrécissant
}
EggConfig.HatchTime = EggConfig.Hatch.Wobble + EggConfig.Hatch.Pop + EggConfig.Hatch.Circle + EggConfig.Hatch.Pocket

-- Les animaux sont les modèles en mesh de ReplicatedStorage.AnimalKit.Models : la clé d'un animal est le nom de son modèle.
-- Leurs copies prêtes à l'emploi (EggSystem.Pets) et les œufs (EggSystem.EggModels) sont construits par ServerStorage.AnimalWiring.
-- Fly = "Always" : l'animal vole, nage ou flotte au-dessus du sol, à FlyHeight studs.
EggConfig.Pets = {
	-- Common (Forest Zone)
	Chicken = {Name = "Chicken", Rarity = "Common", Kg = 2, Income = 5},
	Hamster = {Name = "Hamster", Rarity = "Common", Kg = 0.1, Income = 7},
	Bunny = {Name = "Bunny", Rarity = "Common", Kg = 1.5, Income = 9},
	Pigeon = {Name = "Pigeon", Rarity = "Common", Kg = 0.4, Income = 12, Fly = "Always", FlyHeight = 2},
	Cat = {Name = "Cat", Rarity = "Common", Kg = 4, Income = 16},
	Dog = {Name = "Dog", Rarity = "Common", Kg = 12, Income = 22},
	Goat = {Name = "Goat", Rarity = "Common", Kg = 50, Income = 30},
	Cow = {Name = "Cow", Rarity = "Common", Kg = 300, Income = 40},
	-- Uncommon (Jungle Zone)
	Frog = {Name = "Frog", Rarity = "Uncommon", Kg = 0.2, Income = 50},
	Snail = {Name = "Snail", Rarity = "Uncommon", Kg = 0.05, Income = 67},
	Parrot = {Name = "Parrot", Rarity = "Uncommon", Kg = 1, Income = 91, Fly = "Always", FlyHeight = 2},
	Capybara = {Name = "Capybara", Rarity = "Uncommon", Kg = 50, Income = 120},
	Snake = {Name = "Snake", Rarity = "Uncommon", Kg = 8, Income = 160},
	Kangaroo = {Name = "Kangaroo", Rarity = "Uncommon", Kg = 70, Income = 220},
	Gorilla = {Name = "Gorilla", Rarity = "Uncommon", Kg = 160, Income = 300},
	Tiger = {Name = "Tiger", Rarity = "Uncommon", Kg = 220, Income = 400},
	-- Rare (Aquatic Zone)
	Goldfish = {Name = "Goldfish", Rarity = "Rare", Kg = 0.2, Income = 500, Fly = "Always", FlyHeight = 1.4},
	Crab = {Name = "Crab", Rarity = "Rare", Kg = 1, Income = 670},
	Seahorse = {Name = "Seahorse", Rarity = "Rare", Kg = 0.1, Income = 910, Fly = "Always", FlyHeight = 1.4},
	Pufferfish = {Name = "Pufferfish", Rarity = "Rare", Kg = 2, Income = 1200, Fly = "Always", FlyHeight = 1.4},
	Turtle = {Name = "Turtle", Rarity = "Rare", Kg = 90, Income = 1600},
	Stingray = {Name = "Stingray", Rarity = "Rare", Kg = 120, Income = 2200, Fly = "Always", FlyHeight = 1.4},
	Swordfish = {Name = "Swordfish", Rarity = "Rare", Kg = 400, Income = 3000, Fly = "Always", FlyHeight = 1.4},
	Shark = {Name = "Shark", Rarity = "Rare", Kg = 900, Income = 4000, Fly = "Always", FlyHeight = 1.4},
	-- Epic (Ice Zone)
	Seal = {Name = "Seal", Rarity = "Epic", Kg = 120, Income = 5000},
	Owl = {Name = "Snowy Owl", Rarity = "Epic", Kg = 2, Income = 6700, Fly = "Always", FlyHeight = 2},
	Wolf = {Name = "Wolf", Rarity = "Epic", Kg = 40, Income = 9100},
	Bear = {Name = "Bear", Rarity = "Epic", Kg = 350, Income = 12000},
	PolarBear = {Name = "Polar Bear", Rarity = "Epic", Kg = 450, Income = 16000},
	Sabertooth = {Name = "Sabertooth", Rarity = "Epic", Kg = 300, Income = 22000},
	Mammoth = {Name = "Mammoth", Rarity = "Epic", Kg = 2000, Income = 30000},
	Whale = {Name = "Whale", Rarity = "Epic", Kg = 3000, Income = 40000, Fly = "Always", FlyHeight = 1.4},
	-- Legendary (Desert Zone)
	Lizard = {Name = "Lizard", Rarity = "Legendary", Kg = 1, Income = 50000},
	Ostrich = {Name = "Ostrich", Rarity = "Legendary", Kg = 110, Income = 67000},
	Zebra = {Name = "Zebra", Rarity = "Legendary", Kg = 320, Income = 91000},
	Giraffe = {Name = "Giraffe", Rarity = "Legendary", Kg = 1100, Income = 120000},
	Cobra = {Name = "Cobra", Rarity = "Legendary", Kg = 9, Income = 160000},
	Lion = {Name = "Lion", Rarity = "Legendary", Kg = 190, Income = 220000},
	Elephant = {Name = "Elephant", Rarity = "Legendary", Kg = 2500, Income = 300000},
	Sphinx = {Name = "Sphinx", Rarity = "Legendary", Kg = 450, Income = 400000},
	-- Mythic (Lava Zone)
	Bull = {Name = "Lava Bull", Rarity = "Mythic", Kg = 900, Income = 500000},
	Cockatrice = {Name = "Cockatrice", Rarity = "Mythic", Kg = 30, Income = 670000},
	Minotaur = {Name = "Minotaur", Rarity = "Mythic", Kg = 500, Income = 910000},
	Wyvern = {Name = "Wyvern", Rarity = "Mythic", Kg = 700, Income = 1200000, Fly = "Always", FlyHeight = 2},
	FireDragonBaby = {Name = "Baby Fire Dragon", Rarity = "Mythic", Kg = 200, Income = 1600000, Fly = "Always", FlyHeight = 2},
	FirePhoenix = {Name = "Fire Phoenix", Rarity = "Mythic", Kg = 25, Income = 2200000, Fly = "Always", FlyHeight = 2},
	InfernoEnforcer = {Name = "Inferno Enforcer", Rarity = "Mythic", Kg = 2500, Income = 3000000},
	FireDragon = {Name = "Fire Dragon", Rarity = "Mythic", Kg = 1500, Income = 4000000, Fly = "Always", FlyHeight = 2},
	-- Secret (Demon Zone)
	WingedImp = {Name = "Winged Imp", Rarity = "Secret", Kg = 20, Income = 5000000, Fly = "Always", FlyHeight = 2},
	GargoyleBat = {Name = "Gargoyle Bat", Rarity = "Secret", Kg = 60, Income = 6700000, Fly = "Always", FlyHeight = 2},
	Bugman = {Name = "Bugman", Rarity = "Secret", Kg = 80, Income = 9100000, Fly = "Always", FlyHeight = 2},
	TripleCobra = {Name = "Triple Cobra", Rarity = "Secret", Kg = 40, Income = 12000000},
	Manticore = {Name = "Manticore", Rarity = "Secret", Kg = 600, Income = 16000000},
	Chimera = {Name = "Chimera", Rarity = "Secret", Kg = 800, Income = 22000000},
	Hydra = {Name = "Hydra", Rarity = "Secret", Kg = 2000, Income = 30000000},
	Cerberus = {Name = "Cerberus", Rarity = "Secret", Kg = 1200, Income = 40000000},
	-- Ancient (Dino Zone)
	Velociraptor = {Name = "Velociraptor", Rarity = "Ancient", Kg = 15, Income = 50000000},
	Dimetrodon = {Name = "Dimetrodon", Rarity = "Ancient", Kg = 250, Income = 67000000},
	Pteranodon = {Name = "Pteranodon", Rarity = "Ancient", Kg = 25, Income = 91000000, Fly = "Always", FlyHeight = 2},
	Stegosaurus = {Name = "Stegosaurus", Rarity = "Ancient", Kg = 1800, Income = 120000000},
	Triceratops = {Name = "Triceratops", Rarity = "Ancient", Kg = 2200, Income = 160000000},
	Brachiosaurus = {Name = "Brachiosaurus", Rarity = "Ancient", Kg = 3000, Income = 220000000},
	Spinosaurus = {Name = "Spinosaurus", Rarity = "Ancient", Kg = 2400, Income = 300000000},
	TRex = {Name = "T-Rex", Rarity = "Ancient", Kg = 2600, Income = 400000000},
	-- OG (Candy Zone)
	GummyBear = {Name = "Gummy Bear", Rarity = "OG", Kg = 30, Income = 500000000},
	CottonCandyUnicorn = {Name = "Cotton Candy Unicorn", Rarity = "OG", Kg = 300, Income = 760000000},
	BubblegumElephant = {Name = "Bubblegum Elephant", Rarity = "OG", Kg = 2500, Income = 1100000000},
	GingerbreadLion = {Name = "Gingerbread Lion", Rarity = "OG", Kg = 180, Income = 1700000000},
	LollipopStegosaurus = {Name = "Lollipop Stegosaurus", Rarity = "OG", Kg = 1800, Income = 2600000000},
	RockCandyDragon = {Name = "Rock Candy Dragon", Rarity = "OG", Kg = 1300, Income = 4000000000, Fly = "Always", FlyHeight = 2},
	-- Divine (Angel Zone)
	Unicorn = {Name = "Unicorn", Rarity = "Divine", Kg = 400, Income = 5000000000},
	Qilin = {Name = "Qilin", Rarity = "Divine", Kg = 350, Income = 6700000000},
	Kitsune = {Name = "Kitsune", Rarity = "Divine", Kg = 12, Income = 9100000000},
	Pegasus = {Name = "Pegasus", Rarity = "Divine", Kg = 380, Income = 12000000000, Fly = "Always", FlyHeight = 2},
	Roc = {Name = "Roc", Rarity = "Divine", Kg = 900, Income = 16000000000, Fly = "Always", FlyHeight = 2},
	Thunderbird = {Name = "Thunderbird", Rarity = "Divine", Kg = 120, Income = 22000000000, Fly = "Always", FlyHeight = 2},
	Griffin = {Name = "Griffin", Rarity = "Divine", Kg = 300, Income = 30000000000, Fly = "Always", FlyHeight = 2},
	Dragon = {Name = "Angel Dragon", Rarity = "Divine", Kg = 2000, Income = 40000000000, Fly = "Always", FlyHeight = 2, Angel = true, AngelColor = rgb(255, 224, 140)}, -- doré pâle : un dragon blanc ne se voyait pas sur le sol blanc de sa zone
	-- Prismatic (Halloween Zone)
	Bat = {Name = "Vampire Bat", Rarity = "Prismatic", Kg = 1.5, Income = 50000000000, Fly = "Always", FlyHeight = 2},
	Moth = {Name = "Ghost Moth", Rarity = "Prismatic", Kg = 0.01, Income = 71000000000, Fly = "Always", FlyHeight = 2},
	Jellyfish = {Name = "Phantom Jellyfish", Rarity = "Prismatic", Kg = 3, Income = 100000000000, Fly = "Always", FlyHeight = 1.2},
	Crocodile = {Name = "Swamp Crocodile", Rarity = "Prismatic", Kg = 500, Income = 140000000000},
	Megalodon = {Name = "Cursed Megalodon", Rarity = "Prismatic", Kg = 2500, Income = 200000000000, Fly = "Always", FlyHeight = 1.4},
	Leviathan = {Name = "Shadow Leviathan", Rarity = "Prismatic", Kg = 2800, Income = 280000000000, Fly = "Always", FlyHeight = 1.4},
	Kraken = {Name = "Nightmare Kraken", Rarity = "Prismatic", Kg = 3000, Income = 400000000000, Fly = "Always", FlyHeight = 1.2},
}

-- Oeufs : UN OEUF PAR ANIMAL. Nom affiché, prix, Cooldown = temps d'éclosion en secondes une fois posé,
-- Colors = les trois couleurs de la coquille (principale, taches, reflets).
EggConfig.Eggs = {
	-- Common (Forest Zone)
	ChickenEgg = {Order = 1, Name = "Chicken Egg", Rarity = "Common", Price = 100, Cooldown = 30, Kg = 1, Colors = {rgb(221, 242, 109), rgb(111, 158, 40), rgb(255, 248, 209)},
		Pets = {{Pet = "Chicken", Chance = 100}}},
	HamsterEgg = {Order = 2, Name = "Hamster Egg", Rarity = "Common", Price = 140, Cooldown = 30, Kg = 1, Colors = {rgb(201, 242, 100), rgb(97, 162, 40), rgb(255, 255, 209)},
		Pets = {{Pet = "Hamster", Chance = 100}}},
	BunnyEgg = {Order = 3, Name = "Bunny Egg", Rarity = "Common", Price = 180, Cooldown = 30, Kg = 1, Colors = {rgb(179, 242, 92), rgb(83, 165, 41), rgb(249, 255, 209)},
		Pets = {{Pet = "Bunny", Chance = 100}}},
	PigeonEgg = {Order = 4, Name = "Pigeon Egg", Rarity = "Common", Price = 240, Cooldown = 30, Kg = 1, Colors = {rgb(154, 242, 83), rgb(68, 169, 42), rgb(243, 255, 209)},
		Pets = {{Pet = "Pigeon", Chance = 100}}},
	CatEgg = {Order = 5, Name = "Cat Egg", Rarity = "Common", Price = 320, Cooldown = 30, Kg = 1, Colors = {rgb(127, 242, 74), rgb(53, 173, 43), rgb(237, 255, 209)},
		Pets = {{Pet = "Cat", Chance = 100}}},
	DogEgg = {Order = 6, Name = "Dog Egg", Rarity = "Common", Price = 440, Cooldown = 30, Kg = 1, Colors = {rgb(98, 242, 66), rgb(44, 176, 52), rgb(231, 255, 209)},
		Pets = {{Pet = "Dog", Chance = 100}}},
	GoatEgg = {Order = 7, Name = "Goat Egg", Rarity = "Common", Price = 600, Cooldown = 30, Kg = 1, Colors = {rgb(66, 242, 57), rgb(45, 180, 71), rgb(225, 255, 209)},
		Pets = {{Pet = "Goat", Chance = 100}}},
	CowEgg = {Order = 8, Name = "Cow Egg", Rarity = "Common", Price = 800, Cooldown = 30, Kg = 1, Colors = {rgb(48, 242, 64), rgb(46, 184, 90), rgb(219, 255, 209)},
		Pets = {{Pet = "Cow", Chance = 100}}},
	-- Uncommon (Jungle Zone)
	FrogEgg = {Order = 9, Name = "Frog Egg", Rarity = "Uncommon", Price = 1000, Cooldown = 120, Kg = 1.5, Colors = {rgb(133, 242, 109), rgb(40, 158, 46), rgb(231, 255, 209)},
		Pets = {{Pet = "Frog", Chance = 100}}},
	SnailEgg = {Order = 10, Name = "Snail Egg", Rarity = "Uncommon", Price = 1340, Cooldown = 120, Kg = 1.5, Colors = {rgb(107, 242, 100), rgb(40, 162, 63), rgb(225, 255, 209)},
		Pets = {{Pet = "Snail", Chance = 100}}},
	ParrotEgg = {Order = 11, Name = "Parrot Egg", Rarity = "Uncommon", Price = 1820, Cooldown = 120, Kg = 1.5, Colors = {rgb(92, 242, 104), rgb(41, 165, 81), rgb(219, 255, 209)},
		Pets = {{Pet = "Parrot", Chance = 100}}},
	CapybaraEgg = {Order = 12, Name = "Capybara Egg", Rarity = "Uncommon", Price = 2400, Cooldown = 120, Kg = 1.5, Colors = {rgb(83, 242, 117), rgb(42, 169, 100), rgb(213, 255, 209)},
		Pets = {{Pet = "Capybara", Chance = 100}}},
	SnakeEgg = {Order = 13, Name = "Snake Egg", Rarity = "Uncommon", Price = 3200, Cooldown = 120, Kg = 1.5, Colors = {rgb(74, 242, 132), rgb(43, 173, 119), rgb(209, 255, 211)},
		Pets = {{Pet = "Snake", Chance = 100}}},
	KangarooEgg = {Order = 14, Name = "Kangaroo Egg", Rarity = "Uncommon", Price = 4400, Cooldown = 120, Kg = 1.5, Colors = {rgb(66, 242, 150), rgb(44, 176, 139), rgb(209, 255, 217)},
		Pets = {{Pet = "Kangaroo", Chance = 100}}},
	GorillaEgg = {Order = 15, Name = "Gorilla Egg", Rarity = "Uncommon", Price = 6000, Cooldown = 120, Kg = 1.5, Colors = {rgb(57, 242, 170), rgb(45, 180, 160), rgb(209, 255, 223)},
		Pets = {{Pet = "Gorilla", Chance = 100}}},
	TigerEgg = {Order = 16, Name = "Tiger Egg", Rarity = "Uncommon", Price = 8000, Cooldown = 120, Kg = 1.5, Colors = {rgb(48, 242, 192), rgb(46, 184, 181), rgb(209, 255, 229)},
		Pets = {{Pet = "Tiger", Chance = 100}}},
	-- Rare (Aquatic Zone)
	GoldfishEgg = {Order = 17, Name = "Goldfish Egg", Rarity = "Rare", Price = 10000, Cooldown = 300, Kg = 2, Colors = {rgb(109, 242, 237), rgb(40, 135, 158), rgb(209, 255, 239)},
		Pets = {{Pet = "Goldfish", Chance = 100}}},
	CrabEgg = {Order = 18, Name = "Crab Egg", Rarity = "Rare", Price = 13400, Cooldown = 300, Kg = 2, Colors = {rgb(100, 229, 242), rgb(40, 122, 162), rgb(209, 255, 245)},
		Pets = {{Pet = "Crab", Chance = 100}}},
	SeahorseEgg = {Order = 19, Name = "Seahorse Egg", Rarity = "Rare", Price = 18200, Cooldown = 300, Kg = 2, Colors = {rgb(92, 209, 242), rgb(41, 108, 165), rgb(209, 255, 251)},
		Pets = {{Pet = "Seahorse", Chance = 100}}},
	PufferfishEgg = {Order = 20, Name = "Pufferfish Egg", Rarity = "Rare", Price = 24000, Cooldown = 300, Kg = 2, Colors = {rgb(83, 186, 242), rgb(42, 94, 169), rgb(209, 253, 255)},
		Pets = {{Pet = "Pufferfish", Chance = 100}}},
	TurtleEgg = {Order = 21, Name = "Turtle Egg", Rarity = "Rare", Price = 32000, Cooldown = 300, Kg = 2, Colors = {rgb(74, 161, 242), rgb(43, 79, 173), rgb(209, 246, 255)},
		Pets = {{Pet = "Turtle", Chance = 100}}},
	StingrayEgg = {Order = 22, Name = "Stingray Egg", Rarity = "Rare", Price = 44000, Cooldown = 300, Kg = 2, Colors = {rgb(66, 133, 242), rgb(44, 63, 176), rgb(209, 240, 255)},
		Pets = {{Pet = "Stingray", Chance = 100}}},
	SwordfishEgg = {Order = 23, Name = "Swordfish Egg", Rarity = "Rare", Price = 60000, Cooldown = 300, Kg = 2, Colors = {rgb(57, 103, 242), rgb(45, 46, 180), rgb(209, 234, 255)},
		Pets = {{Pet = "Swordfish", Chance = 100}}},
	SharkEgg = {Order = 24, Name = "Shark Egg", Rarity = "Rare", Price = 80000, Cooldown = 300, Kg = 2, Colors = {rgb(48, 71, 242), rgb(63, 46, 184), rgb(209, 228, 255)},
		Pets = {{Pet = "Shark", Chance = 100}}},
	-- Epic (Ice Zone)
	SealEgg = {Order = 25, Name = "Seal Egg", Rarity = "Epic", Price = 100000, Cooldown = 600, Kg = 3, Colors = {rgb(109, 242, 197), rgb(40, 158, 146), rgb(209, 255, 226)},
		Pets = {{Pet = "Seal", Chance = 100}}},
	OwlEgg = {Order = 26, Name = "Snowy Owl Egg", Rarity = "Epic", Price = 134000, Cooldown = 600, Kg = 3, Colors = {rgb(100, 242, 212), rgb(40, 158, 162), rgb(209, 255, 232)},
		Pets = {{Pet = "Owl", Chance = 100}}},
	WolfEgg = {Order = 27, Name = "Wolf Egg", Rarity = "Epic", Price = 182000, Cooldown = 600, Kg = 3, Colors = {rgb(92, 242, 231), rgb(41, 145, 165), rgb(209, 255, 238)},
		Pets = {{Pet = "Wolf", Chance = 100}}},
	BearEgg = {Order = 28, Name = "Bear Egg", Rarity = "Epic", Price = 240000, Cooldown = 600, Kg = 3, Colors = {rgb(83, 234, 242), rgb(42, 132, 169), rgb(209, 255, 244)},
		Pets = {{Pet = "Bear", Chance = 100}}},
	PolarBearEgg = {Order = 29, Name = "Polar Bear Egg", Rarity = "Epic", Price = 320000, Cooldown = 600, Kg = 3, Colors = {rgb(74, 211, 242), rgb(43, 118, 173), rgb(209, 255, 250)},
		Pets = {{Pet = "PolarBear", Chance = 100}}},
	SabertoothEgg = {Order = 30, Name = "Sabertooth Egg", Rarity = "Epic", Price = 440000, Cooldown = 600, Kg = 3, Colors = {rgb(66, 186, 242), rgb(44, 103, 176), rgb(209, 254, 255)},
		Pets = {{Pet = "Sabertooth", Chance = 100}}},
	MammothEgg = {Order = 31, Name = "Mammoth Egg", Rarity = "Epic", Price = 600000, Cooldown = 600, Kg = 3, Colors = {rgb(57, 159, 242), rgb(45, 87, 180), rgb(209, 248, 255)},
		Pets = {{Pet = "Mammoth", Chance = 100}}},
	WhaleEgg = {Order = 32, Name = "Whale Egg", Rarity = "Epic", Price = 800000, Cooldown = 600, Kg = 3, Colors = {rgb(48, 129, 242), rgb(46, 70, 184), rgb(209, 242, 255)},
		Pets = {{Pet = "Whale", Chance = 100}}},
	-- Legendary (Desert Zone)
	LizardEgg = {Order = 33, Name = "Lizard Egg", Rarity = "Legendary", Price = 1000000, Cooldown = 900, Kg = 5, Colors = {rgb(242, 143, 109), rgb(158, 99, 40), rgb(255, 209, 211)},
		Pets = {{Pet = "Lizard", Chance = 100}}},
	OstrichEgg = {Order = 34, Name = "Ostrich Egg", Rarity = "Legendary", Price = 1340000, Cooldown = 900, Kg = 5, Colors = {rgb(242, 156, 100), rgb(162, 117, 40), rgb(255, 213, 209)},
		Pets = {{Pet = "Ostrich", Chance = 100}}},
	ZebraEgg = {Order = 35, Name = "Zebra Egg", Rarity = "Legendary", Price = 1820000, Cooldown = 900, Kg = 5, Colors = {rgb(242, 170, 92), rgb(165, 136, 41), rgb(255, 219, 209)},
		Pets = {{Pet = "Zebra", Chance = 100}}},
	GiraffeEgg = {Order = 36, Name = "Giraffe Egg", Rarity = "Legendary", Price = 2400000, Cooldown = 900, Kg = 5, Colors = {rgb(242, 187, 83), rgb(169, 156, 42), rgb(255, 225, 209)},
		Pets = {{Pet = "Giraffe", Chance = 100}}},
	CobraEgg = {Order = 37, Name = "Cobra Egg", Rarity = "Legendary", Price = 3200000, Cooldown = 900, Kg = 5, Colors = {rgb(242, 206, 74), rgb(169, 173, 43), rgb(255, 231, 209)},
		Pets = {{Pet = "Cobra", Chance = 100}}},
	LionEgg = {Order = 38, Name = "Lion Egg", Rarity = "Legendary", Price = 4400000, Cooldown = 900, Kg = 5, Colors = {rgb(242, 228, 66), rgb(155, 176, 44), rgb(255, 237, 209)},
		Pets = {{Pet = "Lion", Chance = 100}}},
	ElephantEgg = {Order = 39, Name = "Elephant Egg", Rarity = "Legendary", Price = 6000000, Cooldown = 900, Kg = 5, Colors = {rgb(233, 242, 57), rgb(141, 180, 45), rgb(255, 244, 209)},
		Pets = {{Pet = "Elephant", Chance = 100}}},
	SphinxEgg = {Order = 40, Name = "Sphinx Egg", Rarity = "Legendary", Price = 8000000, Cooldown = 900, Kg = 5, Colors = {rgb(207, 242, 48), rgb(125, 184, 46), rgb(255, 250, 209)},
		Pets = {{Pet = "Sphinx", Chance = 100}}},
	-- Mythic (Lava Zone)
	BullEgg = {Order = 41, Name = "Lava Bull Egg", Rarity = "Mythic", Price = 10000000, Cooldown = 1200, Kg = 8, Colors = {rgb(242, 109, 147), rgb(158, 40, 45), rgb(255, 209, 236)},
		Pets = {{Pet = "Bull", Chance = 100}}},
	CockatriceEgg = {Order = 42, Name = "Cockatrice Egg", Rarity = "Mythic", Price = 13400000, Cooldown = 1200, Kg = 8, Colors = {rgb(242, 100, 122), rgb(162, 51, 40), rgb(255, 209, 230)},
		Pets = {{Pet = "Cockatrice", Chance = 100}}},
	MinotaurEgg = {Order = 43, Name = "Minotaur Egg", Rarity = "Mythic", Price = 18200000, Cooldown = 1200, Kg = 8, Colors = {rgb(242, 92, 94), rgb(165, 69, 41), rgb(255, 209, 224)},
		Pets = {{Pet = "Minotaur", Chance = 100}}},
	WyvernEgg = {Order = 44, Name = "Wyvern Egg", Rarity = "Mythic", Price = 24000000, Cooldown = 1200, Kg = 8, Colors = {rgb(242, 101, 83), rgb(169, 87, 42), rgb(255, 209, 218)},
		Pets = {{Pet = "Wyvern", Chance = 100}}},
	FireDragonBabyEgg = {Order = 45, Name = "Baby Fire Dragon Egg", Rarity = "Mythic", Price = 32000000, Cooldown = 1200, Kg = 8, Colors = {rgb(242, 116, 74), rgb(173, 106, 43), rgb(255, 209, 212)},
		Pets = {{Pet = "FireDragonBaby", Chance = 100}}},
	FirePhoenixEgg = {Order = 46, Name = "Fire Phoenix Egg", Rarity = "Mythic", Price = 44000000, Cooldown = 1200, Kg = 8, Colors = {rgb(242, 132, 66), rgb(176, 126, 44), rgb(255, 213, 209)},
		Pets = {{Pet = "FirePhoenix", Chance = 100}}},
	InfernoEnforcerEgg = {Order = 47, Name = "Inferno Enforcer Egg", Rarity = "Mythic", Price = 60000000, Cooldown = 1200, Kg = 8, Colors = {rgb(242, 152, 57), rgb(180, 146, 45), rgb(255, 219, 209)},
		Pets = {{Pet = "InfernoEnforcer", Chance = 100}}},
	FireDragonEgg = {Order = 48, Name = "Fire Dragon Egg", Rarity = "Mythic", Price = 80000000, Cooldown = 1200, Kg = 8, Colors = {rgb(242, 173, 48), rgb(184, 167, 46), rgb(255, 225, 209)},
		Pets = {{Pet = "FireDragon", Chance = 100}}},
	-- Secret (Demon Zone)
	WingedImpEgg = {Order = 49, Name = "Winged Imp Egg", Rarity = "Secret", Price = 100000000, Cooldown = 1800, Kg = 12, Colors = {rgb(138, 109, 242), rgb(94, 40, 158), rgb(209, 213, 255)},
		Pets = {{Pet = "WingedImp", Chance = 100}}},
	GargoyleBatEgg = {Order = 50, Name = "Gargoyle Bat Egg", Rarity = "Secret", Price = 134000000, Cooldown = 1800, Kg = 12, Colors = {rgb(150, 100, 242), rgb(112, 40, 162), rgb(211, 209, 255)},
		Pets = {{Pet = "GargoyleBat", Chance = 100}}},
	BugmanEgg = {Order = 51, Name = "Bugman Egg", Rarity = "Secret", Price = 182000000, Cooldown = 1800, Kg = 12, Colors = {rgb(164, 92, 242), rgb(131, 41, 165), rgb(217, 209, 255)},
		Pets = {{Pet = "Bugman", Chance = 100}}},
	TripleCobraEgg = {Order = 52, Name = "Triple Cobra Egg", Rarity = "Secret", Price = 240000000, Cooldown = 1800, Kg = 12, Colors = {rgb(181, 83, 242), rgb(151, 42, 169), rgb(224, 209, 255)},
		Pets = {{Pet = "TripleCobra", Chance = 100}}},
	ManticoreEgg = {Order = 53, Name = "Manticore Egg", Rarity = "Secret", Price = 320000000, Cooldown = 1800, Kg = 12, Colors = {rgb(200, 74, 242), rgb(171, 43, 173), rgb(230, 209, 255)},
		Pets = {{Pet = "Manticore", Chance = 100}}},
	ChimeraEgg = {Order = 54, Name = "Chimera Egg", Rarity = "Secret", Price = 440000000, Cooldown = 1800, Kg = 12, Colors = {rgb(221, 66, 242), rgb(176, 44, 161), rgb(236, 209, 255)},
		Pets = {{Pet = "Chimera", Chance = 100}}},
	HydraEgg = {Order = 55, Name = "Hydra Egg", Rarity = "Secret", Price = 600000000, Cooldown = 1800, Kg = 12, Colors = {rgb(242, 57, 240), rgb(180, 45, 146), rgb(242, 209, 255)},
		Pets = {{Pet = "Hydra", Chance = 100}}},
	CerberusEgg = {Order = 56, Name = "Cerberus Egg", Rarity = "Secret", Price = 800000000, Cooldown = 1800, Kg = 12, Colors = {rgb(242, 48, 215), rgb(184, 46, 131), rgb(248, 209, 255)},
		Pets = {{Pet = "Cerberus", Chance = 100}}},
	-- Ancient (Dino Zone)
	VelociraptorEgg = {Order = 57, Name = "Velociraptor Egg", Rarity = "Ancient", Price = 1000000000, Cooldown = 2400, Kg = 15, Colors = {rgb(173, 242, 109), rgb(68, 158, 40), rgb(245, 255, 209)},
		Pets = {{Pet = "Velociraptor", Chance = 100}}},
	DimetrodonEgg = {Order = 58, Name = "Dimetrodon Egg", Rarity = "Ancient", Price = 1340000000, Cooldown = 2400, Kg = 15, Colors = {rgb(150, 242, 100), rgb(54, 162, 40), rgb(239, 255, 209)},
		Pets = {{Pet = "Dimetrodon", Chance = 100}}},
	PteranodonEgg = {Order = 59, Name = "Pteranodon Egg", Rarity = "Ancient", Price = 1820000000, Cooldown = 2400, Kg = 15, Colors = {rgb(125, 242, 92), rgb(41, 165, 44), rgb(233, 255, 209)},
		Pets = {{Pet = "Pteranodon", Chance = 100}}},
	StegosaurusEgg = {Order = 60, Name = "Stegosaurus Egg", Rarity = "Ancient", Price = 2400000000, Cooldown = 2400, Kg = 15, Colors = {rgb(97, 242, 83), rgb(42, 169, 62), rgb(227, 255, 209)},
		Pets = {{Pet = "Stegosaurus", Chance = 100}}},
	TriceratopsEgg = {Order = 61, Name = "Triceratops Egg", Rarity = "Ancient", Price = 3200000000, Cooldown = 2400, Kg = 15, Colors = {rgb(74, 242, 82), rgb(43, 173, 80), rgb(221, 255, 209)},
		Pets = {{Pet = "Triceratops", Chance = 100}}},
	BrachiosaurusEgg = {Order = 62, Name = "Brachiosaurus Egg", Rarity = "Ancient", Price = 4400000000, Cooldown = 2400, Kg = 15, Colors = {rgb(66, 242, 97), rgb(44, 176, 99), rgb(215, 255, 209)},
		Pets = {{Pet = "Brachiosaurus", Chance = 100}}},
	SpinosaurusEgg = {Order = 63, Name = "Spinosaurus Egg", Rarity = "Ancient", Price = 6000000000, Cooldown = 2400, Kg = 15, Colors = {rgb(57, 242, 114), rgb(45, 180, 119), rgb(209, 255, 210)},
		Pets = {{Pet = "Spinosaurus", Chance = 100}}},
	TRexEgg = {Order = 64, Name = "T-Rex Egg", Rarity = "Ancient", Price = 8000000000, Cooldown = 2400, Kg = 15, Colors = {rgb(48, 242, 134), rgb(46, 184, 140), rgb(209, 255, 216)},
		Pets = {{Pet = "TRex", Chance = 100}}},
	-- OG (Candy Zone)
	GummyBearEgg = {Order = 65, Name = "Gummy Bear Egg", Rarity = "OG", Price = 10000000000, Cooldown = 3000, Kg = 20, Colors = {rgb(242, 109, 233), rgb(158, 40, 121), rgb(244, 209, 255)},
		Pets = {{Pet = "GummyBear", Chance = 100}}},
	CottonCandyUnicornEgg = {Order = 66, Name = "Cotton Candy Unicorn Egg", Rarity = "OG", Price = 15200000000, Cooldown = 3000, Kg = 20, Colors = {rgb(242, 97, 213), rgb(163, 41, 109), rgb(251, 209, 255)},
		Pets = {{Pet = "CottonCandyUnicorn", Chance = 100}}},
	BubblegumElephantEgg = {Order = 67, Name = "Bubblegum Elephant Egg", Rarity = "OG", Price = 22000000000, Cooldown = 3000, Kg = 20, Colors = {rgb(242, 85, 190), rgb(168, 42, 96), rgb(255, 209, 253)},
		Pets = {{Pet = "BubblegumElephant", Chance = 100}}},
	GingerbreadLionEgg = {Order = 68, Name = "Gingerbread Lion Egg", Rarity = "OG", Price = 34000000000, Cooldown = 3000, Kg = 20, Colors = {rgb(242, 73, 163), rgb(173, 43, 82), rgb(255, 209, 247)},
		Pets = {{Pet = "GingerbreadLion", Chance = 100}}},
	LollipopStegosaurusEgg = {Order = 69, Name = "Lollipop Stegosaurus Egg", Rarity = "OG", Price = 52000000000, Cooldown = 3000, Kg = 20, Colors = {rgb(242, 61, 134), rgb(178, 45, 66), rgb(255, 209, 241)},
		Pets = {{Pet = "LollipopStegosaurus", Chance = 100}}},
	RockCandyDragonEgg = {Order = 70, Name = "Rock Candy Dragon Egg", Rarity = "OG", Price = 80000000000, Cooldown = 3000, Kg = 20, Colors = {rgb(242, 48, 101), rgb(184, 46, 50), rgb(255, 209, 235)},
		Pets = {{Pet = "RockCandyDragon", Chance = 100}}},
	-- Divine (Angel Zone)
	UnicornEgg = {Order = 71, Name = "Unicorn Egg", Rarity = "Divine", Price = 100000000000, Cooldown = 3600, Kg = 25, Colors = {rgb(242, 167, 109), rgb(158, 120, 40), rgb(255, 215, 209)},
		Pets = {{Pet = "Unicorn", Chance = 100}}},
	QilinEgg = {Order = 72, Name = "Qilin Egg", Rarity = "Divine", Price = 134000000000, Cooldown = 3600, Kg = 25, Colors = {rgb(242, 181, 100), rgb(162, 139, 40), rgb(255, 221, 209)},
		Pets = {{Pet = "Qilin", Chance = 100}}},
	KitsuneEgg = {Order = 73, Name = "Kitsune Egg", Rarity = "Divine", Price = 182000000000, Cooldown = 3600, Kg = 25, Colors = {rgb(242, 197, 92), rgb(165, 158, 41), rgb(255, 228, 209)},
		Pets = {{Pet = "Kitsune", Chance = 100}}},
	PegasusEgg = {Order = 74, Name = "Pegasus Egg", Rarity = "Divine", Price = 240000000000, Cooldown = 3600, Kg = 25, Colors = {rgb(242, 216, 83), rgb(160, 169, 42), rgb(255, 234, 209)},
		Pets = {{Pet = "Pegasus", Chance = 100}}},
	RocEgg = {Order = 75, Name = "Roc Egg", Rarity = "Divine", Price = 320000000000, Cooldown = 3600, Kg = 25, Colors = {rgb(242, 237, 74), rgb(146, 173, 43), rgb(255, 240, 209)},
		Pets = {{Pet = "Roc", Chance = 100}}},
	ThunderbirdEgg = {Order = 76, Name = "Thunderbird Egg", Rarity = "Divine", Price = 440000000000, Cooldown = 3600, Kg = 25, Colors = {rgb(225, 242, 66), rgb(132, 176, 44), rgb(255, 246, 209)},
		Pets = {{Pet = "Thunderbird", Chance = 100}}},
	GriffinEgg = {Order = 77, Name = "Griffin Egg", Rarity = "Divine", Price = 600000000000, Cooldown = 3600, Kg = 25, Colors = {rgb(200, 242, 57), rgb(117, 180, 45), rgb(255, 252, 209)},
		Pets = {{Pet = "Griffin", Chance = 100}}},
	DragonEgg = {Order = 78, Name = "Angel Dragon Egg", Rarity = "Divine", Price = 800000000000, Cooldown = 3600, Kg = 25, Colors = {rgb(172, 242, 48), rgb(101, 184, 46), rgb(252, 255, 209)},
		Pets = {{Pet = "Dragon", Chance = 100}}},
	-- Prismatic (Halloween Zone)
	BatEgg = {Order = 79, Name = "Vampire Bat Egg", Rarity = "Prismatic", Price = 1000000000000, Cooldown = 4200, Kg = 30, ZoneOnly = true, Colors = {rgb(242, 120, 109), rgb(158, 78, 40), rgb(255, 209, 219)},
		Pets = {{Pet = "Bat", Chance = 100}}},
	MothEgg = {Order = 80, Name = "Ghost Moth Egg", Rarity = "Prismatic", Price = 1420000000000, Cooldown = 4200, Kg = 30, ZoneOnly = true, Colors = {rgb(242, 130, 99), rgb(162, 96, 41), rgb(255, 209, 213)},
		Pets = {{Pet = "Moth", Chance = 100}}},
	JellyfishEgg = {Order = 81, Name = "Phantom Jellyfish Egg", Rarity = "Prismatic", Price = 2000000000000, Cooldown = 4200, Kg = 30, ZoneOnly = true, Colors = {rgb(242, 142, 89), rgb(167, 115, 42), rgb(255, 211, 209)},
		Pets = {{Pet = "Jellyfish", Chance = 100}}},
	CrocodileEgg = {Order = 82, Name = "Swamp Crocodile Egg", Rarity = "Prismatic", Price = 2800000000000, Cooldown = 4200, Kg = 30, ZoneOnly = true, Colors = {rgb(242, 157, 79), rgb(171, 135, 43), rgb(255, 217, 209)},
		Pets = {{Pet = "Crocodile", Chance = 100}}},
	MegalodonEgg = {Order = 83, Name = "Cursed Megalodon Egg", Rarity = "Prismatic", Price = 4000000000000, Cooldown = 4200, Kg = 30, ZoneOnly = true, Colors = {rgb(242, 175, 69), rgb(175, 156, 44), rgb(255, 223, 209)},
		Pets = {{Pet = "Megalodon", Chance = 100}}},
	LeviathanEgg = {Order = 84, Name = "Shadow Leviathan Egg", Rarity = "Prismatic", Price = 5600000000000, Cooldown = 4200, Kg = 30, ZoneOnly = true, Colors = {rgb(242, 195, 59), rgb(179, 177, 45), rgb(255, 229, 209)},
		Pets = {{Pet = "Leviathan", Chance = 100}}},
	KrakenEgg = {Order = 85, Name = "Nightmare Kraken Egg", Rarity = "Prismatic", Price = 8000000000000, Cooldown = 4200, Kg = 30, ZoneOnly = true, Colors = {rgb(242, 218, 48), rgb(168, 184, 46), rgb(255, 236, 209)},
		Pets = {{Pet = "Kraken", Chance = 100}}},
}

-- Raretés, de la première zone à la dernière (une zone d'œufs par rareté)
EggConfig.Rarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Ancient", "OG", "Divine", "Prismatic"}
EggConfig.RarityRank = {}
for rank, rarity in EggConfig.Rarities do EggConfig.RarityRank[rarity] = rank end
EggConfig.ZoneTitles = {Common = "Forest Zone", Uncommon = "Jungle Zone", Rare = "Aquatic Zone", Epic = "Ice Zone", Legendary = "Desert Zone", Mythic = "Lava Zone", Secret = "Demon Zone", Ancient = "Dino Zone", OG = "Candy Zone", Divine = "Angel Zone", Prismatic = "Halloween Zone"}
-- anciens animaux et œufs (avant les modèles en mesh) : une sauvegarde qui en contient reçoit l'animal du même rang
EggConfig.LegacyPets = {Chick = "Hamster", Rooster = "Bunny", Duck = "Pigeon", Turkey = "Cat", FireFish = "Dog", Pig = "Frog", Sheep = "Snail", Horse = "Snake", Goose = "Kangaroo", ForestFish = "Gorilla", Deer = "Goldfish", Fox = "Crab", Eagle = "Stingray", IceFish = "Swordfish", Bee = "Seal", Ladybug = "Owl", Butterfly = "Wolf", Scarab = "Bear", Firefly = "PolarBear", OceanFish = "Sabertooth", IceDragon = "Ostrich", Phoenix = "Zebra", Golem = "Giraffe", ThunderFish = "Lion", Celestial = "Minotaur", CrystalFish = "FirePhoenix", Demon = "WingedImp", VoidDragon = "GargoyleBat", Reaper = "Bugman", Hellhound = "TripleCobra", CosmicCat = "Manticore", VoidFish = "Chimera", Pumpkin = "Bat", Ghost = "Moth", WitchCat = "Jellyfish", SkeletonDog = "Crocodile", VampireBat = "Megalodon"}
EggConfig.LegacyEggs = {ChickEgg = "HamsterEgg", RoosterEgg = "BunnyEgg", DuckEgg = "PigeonEgg", TurkeyEgg = "CatEgg", FireFishEgg = "DogEgg", PigEgg = "FrogEgg", SheepEgg = "SnailEgg", HorseEgg = "SnakeEgg", GooseEgg = "KangarooEgg", ForestFishEgg = "GorillaEgg", DeerEgg = "GoldfishEgg", FoxEgg = "CrabEgg", EagleEgg = "StingrayEgg", IceFishEgg = "SwordfishEgg", BeeEgg = "SealEgg", LadybugEgg = "OwlEgg", ButterflyEgg = "WolfEgg", ScarabEgg = "BearEgg", FireflyEgg = "PolarBearEgg", OceanFishEgg = "SabertoothEgg", IceDragonEgg = "OstrichEgg", PhoenixEgg = "ZebraEgg", GolemEgg = "GiraffeEgg", ThunderFishEgg = "LionEgg", CelestialEgg = "MinotaurEgg", CrystalFishEgg = "FirePhoenixEgg", DemonEgg = "WingedImpEgg", VoidDragonEgg = "GargoyleBatEgg", ReaperEgg = "BugmanEgg", HellhoundEgg = "TripleCobraEgg", CosmicCatEgg = "ManticoreEgg", VoidFishEgg = "ChimeraEgg", PumpkinEgg = "BatEgg", GhostEgg = "MothEgg", WitchEgg = "JellyfishEgg", SkeletonEgg = "CrocodileEgg", VampireEgg = "MegalodonEgg"}

-- Chances d'apparition dans les zones : dans chaque rareté, les oeufs sont classés du moins cher au meilleur
-- (revenu de base de l'animal, donc l'ordre de l'index). Le premier apparaît 60 % du temps, le meilleur 1 %.
-- Une ligne par nombre d'oeufs dans la rareté ; chaque ligne fait 100 %.
EggConfig.SpawnChances = {
	[5] = {60, 25, 10, 4, 1},
	[6] = {60, 22, 10, 5, 2, 1},
	[7] = {60, 20, 10, 5, 2.5, 1.5, 1},
}

-- pour un autre nombre d'oeufs : 60 % pour le premier, 1 % pour le dernier, le reste divisé par deux à chaque rang
function EggConfig.SpawnChancesFor(count)
	local known = EggConfig.SpawnChances[count]
	if known then return known end
	if count <= 1 then return {100} end
	if count == 2 then return {99, 1} end
	local chances, weights, total = {60}, {}, 0
	for i = 1, count - 2 do
		weights[i] = 0.5 ^ (i - 1)
		total += weights[i]
	end
	for i = 1, count - 2 do chances[i + 1] = 39 * weights[i] / total end
	chances[count] = 1
	EggConfig.SpawnChances[count] = chances
	return chances
end

-- les oeufs d'une rareté, du moins bon au meilleur
local sortedCache = {}
function EggConfig.EggsByValue(rarity)
	if sortedCache[rarity] then return sortedCache[rarity] end
	local keys = {}
	for key, info in EggConfig.Eggs do
		if info.Rarity == rarity and not info.ZoneEgg then table.insert(keys, key) end
	end
	local function value(key)
		local egg = EggConfig.Eggs[key]
		local pet = egg.Pets and egg.Pets[1] and EggConfig.Pets[egg.Pets[1].Pet]
		return pet and pet.Income or 0
	end
	table.sort(keys, function(a, b)
		local va, vb = value(a), value(b)
		if va ~= vb then return va < vb end
		return (EggConfig.Eggs[a].Order or 0) < (EggConfig.Eggs[b].Order or 0)
	end)
	sortedCache[rarity] = keys
	return keys
end

-- chance (en %) qu'un oeuf précis apparaisse parmi ceux de sa rareté
function EggConfig.SpawnChanceOf(eggKey)
	local info = EggConfig.Eggs[eggKey]
	if not info then return nil end
	local keys = EggConfig.EggsByValue(info.Rarity)
	local index = table.find(keys, eggKey)
	return index and EggConfig.SpawnChancesFor(#keys)[index] or nil
end

-- 60 -> "60%", 2.5 -> "2.5%"
function EggConfig.FormatChance(chance)
	return (string.format("%.1f", chance):gsub("%.0$", "")) .. "%"
end

-- Kilos : chaque oeuf acheté a un poids proche de son poids normal (Kg dans Eggs et Pets).
-- La chance se joue quand on POSE l'oeuf dans le jardin :
-- 1) Poids bonus : Chance en % de gagner entre Min et Max kilos en plus (sinon l'oeuf garde son poids normal).
--    L'animal qui sort de l'oeuf garde ces kilos en plus.
EggConfig.WeightTiers = {
	{Chance = 0.0003, Min = 90000, Max = 110000}, -- environ 100 000 kg : taille maximale (nerf : 0.001 -> 0.0003)
	{Chance = 0.012, Min = 30000, Max = 70000},    -- 0.049 -> 0.012
	{Chance = 0.12, Min = 10000, Max = 30000},     -- 0.45 -> 0.12
	{Chance = 0.8, Min = 2000, Max = 10000},       -- 2.5 -> 0.8
	{Chance = 3, Min = 500, Max = 2000},           -- 7 -> 3
}
EggConfig.KgVariation = 0.15 -- variation au hasard du poids, toujours vers le haut : jusqu'à +30 % du poids de base

-- Taille : +1x tous les SizeStepKg kilos (2x à 10 000 kg, 3x à 20 000 kg...).
-- Au-delà de MaxSizeKg le poids peut encore monter, mais la taille ne grossit plus.
EggConfig.SizeStepKg = 10000
EggConfig.MaxSizeKg = 900000 -- assez pour les oeufs géants des zones (jusqu'à ~90 fois la taille normale)
-- Poids et revenus : tous les animaux (et tous les œufs) pèsent BaseKg « de base », jamais moins. Plus lourd = plus de revenus :
-- 100 kg = x1, 1 000 kg = x2, 10 000 kg = x3, 100 000 kg = x4, 1 000 000 kg = x5 (le maximum, même au-delà).
EggConfig.BaseKg = 100
function EggConfig.WeightMult(kg)
	return math.clamp(1 + math.log10(math.max(kg, EggConfig.BaseKg) / EggConfig.BaseKg), 1, 5)
end

-- 2) Mutation : Chance en %, Mult = multiplicateur de revenu. L'oeuf prend la couleur de la mutation,
-- et l'animal qui en sort la garde.
EggConfig.Mutations = {
	{Name = "Rainbow", Chance = 0.1, Mult = 10},
	{Name = "Diamond", Chance = 1, Mult = 5, Color = rgb(150, 235, 255)},
	{Name = "Gold", Chance = 10, Mult = 2, Color = rgb(255, 215, 60)},
	-- Like : seulement pendant l'event CONCERT (les danseurs lancent des j'aime sur les oeufs des zones), jamais tirée au hasard
	{Name = "Like", Chance = 0, Mult = 5, Color = rgb(255, 70, 130)},
	-- events du ciel (SkyEventsServer), jamais tirées au hasard. NoTint : l'animal garde ses couleurs, c'est l'effet
	-- autour de lui qui montre la mutation (TraitDeco.MutationFx)
	{Name = "Cosmic", Chance = 0, Mult = 4, NoTint = true, Color = rgb(140, 160, 255)}, -- PLUIE DE MÉTÉORES : comètes en orbite
	{Name = "Storm", Chance = 0, Mult = 4, NoTint = true, Color = rgb(120, 220, 255)},  -- ORAGE : arcs électriques, petit nuage
	{Name = "Alien", Chance = 0, Mult = 4, NoTint = true, Color = rgb(110, 255, 120)},  -- INVASION OVNI : halo vert qui tourne
	{Name = "Candy", Chance = 0, Mult = 4, NoTint = true, Color = rgb(255, 130, 210)},  -- CANDY RAIN : bonbons qui tournent, sucre
	{Name = "Blood", Chance = 0, Mult = 4, NoTint = true, Color = rgb(235, 50, 70)},    -- BLOOD MOON : chauves-souris, brume rouge
	{Name = "Frozen", Chance = 0, Mult = 4, NoTint = true, Color = rgb(160, 225, 255)}, -- BLIZZARD : éclats de glace, neige
	{Name = "Hacked", Chance = 0, Mult = 5, NoTint = true, Color = rgb(40, 255, 110)},  -- HACKER ATTACK : code vert, anneaux de données (1 % par œuf)
}

-- Nuit : AUCUNE nouvelle mutation d'œuf. La source de vérité est NightServer : il pose l'attribut IsNight de ReplicatedStorage
-- pendant toute la nuit (du fondu noir jusqu'à ce que le mur soit retombé). Les mutations déjà obtenues sont gardées.
-- Chaque endroit du serveur qui attribue une mutation appelle cette fonction juste avant de modifier l'œuf.
function EggConfig.MutationsAllowed()
	local storage = game:GetService("ReplicatedStorage")
	return storage:GetAttribute("IsNight") ~= true and storage:GetAttribute("NightEnd") == nil
end

-- 3) Croissance : pendant que l'oeuf couve, à chaque Interval (s) il a Chance % de grossir de Mult
EggConfig.Growth = {Interval = 60, Chance = 10, Mult = 1.15}

-- Recolore un modèle (oeuf ou animal) selon sa mutation, en gardant les ombres et les détails :
-- Gold / Diamond = une seule teinte, Rainbow = arc-en-ciel doux de bas en haut (sans néon).
function EggConfig.ApplyMutation(model, mutationName)
	local mutation = mutationName and EggConfig.GetMutation(mutationName)
	if not mutation or mutation.NoTint then return end
	local cf, size = model:GetBoundingBox()
	local bottom = cf.Position.Y - size.Y / 2
	for _, part in model:GetDescendants() do
		if part:IsA("BasePart") and part.Transparency < 1 then
			local surface = part:FindFirstChildOfClass("SurfaceAppearance")
			if surface then -- animal en mesh : la texture est teintée (Rainbow : la teinte tourne, voir MeshAnimalClient)
				surface.Color = mutation.Color and mutation.Color:Lerp(Color3.new(1, 1, 1), 0.1) or Color3.fromHSV(0.83, 0.45, 1)
				if not mutation.Color then part:SetAttribute("RainbowTint", true) end
				continue
			end
			local c = part.Color
			local light = 0.62 + 0.55 * (0.3 * c.R + 0.59 * c.G + 0.11 * c.B) -- clair reste clair, foncé reste foncé
			if mutation.Color then
				local m = mutation.Color
				part.Color = Color3.new(math.min(m.R * light, 1), math.min(m.G * light, 1), math.min(m.B * light, 1))
			else
				local hue = math.clamp((part.Position.Y - bottom) / math.max(size.Y, 0.01), 0, 1) * 0.85
				part.Color = Color3.fromHSV(hue, 0.6, math.min(light, 1))
			end
			if part.Material == Enum.Material.Neon then part.Material = Enum.Material.Plastic end
		end
	end
end

function EggConfig.GetMutation(name)
	for _, mutation in EggConfig.Mutations do
		if mutation.Name == name then return mutation end
	end
	return nil
end

-- Revenu par seconde d'un animal posé :
-- revenu normal x multiplicateur du poids (EggConfig.WeightMult) x mutation x bonus de niveau
function EggConfig.GetIncome(petName, kg, mutationName, level)
	local info = EggConfig.Pets[petName]
	if not info then return 0 end
	local mutation = mutationName and EggConfig.GetMutation(mutationName)
	local weight = EggConfig.WeightMult(kg)
	local levelBonus = 1 + ((level or 1) - 1) * EggConfig.LevelIncomeBonus
	return math.max(1, math.floor(info.Income * weight * (mutation and mutation.Mult or 1) * levelBonus + 0.5))
end

-- Taille à l'écran d'un oeuf ou d'un animal selon son poids
-- taille d'affichage des pets (jardin, éclosion, portés...) : 1,8 fois leur taille d'origine (le poids ne change pas)
EggConfig.PetSize = 1.8

function EggConfig.SizeScale(kg)
	return 1 + math.min(kg, EggConfig.MaxSizeKg) / EggConfig.SizeStepKg
end

-- 0.021 -> "0.021 kg", 2.134 -> "2.13 kg", 912.4 -> "912.4 kg", 104300 -> "104.3K kg"
function EggConfig.FormatKg(kg)
	if kg >= 1000000 then return (string.format("%.2f", kg / 1000000):gsub("%.?0+$", "")) .. "M kg" end
	if kg >= 1000 then return (string.format("%.1f", kg / 1000):gsub("%.0$", "")) .. "K kg" end
	if kg >= 100 then return (string.format("%.1f", kg):gsub("%.0$", "")) .. " kg" end
	if kg >= 1 then return string.format("%.2f kg", kg) end
	return string.format("%.3f kg", kg)
end

-- Niveaux des animaux : on les nourrit avec des plantes pour gagner de l'XP
EggConfig.MaxLevel = 50
EggConfig.LevelIncomeBonus = 0.1 -- +10 % de revenu par niveau au-dessus du niveau 1

-- XP nécessaire pour passer de `level` à `level + 1`
function EggConfig.XpForLevel(level)
	return 50 * level * level
end

-- Argent
EggConfig.StartMoney = 500               -- argent de départ des joueurs
EggConfig.OwnerStartMoney = 1000000000   -- argent de départ du créateur (1B)
EggConfig.OwnerUserIds = {2709850193}    -- rexydev1

local SUFFIXES = {{1e33, "Dc"}, {1e30, "No"}, {1e27, "Oc"}, {1e24, "Sp"}, {1e21, "Sx"}, {1e18, "Qi"}, {1e15, "Q"}, {1e12, "T"}, {1e9, "B"}, {1e6, "M"}, {1e3, "K"}}

-- 90 -> "1:30", 1800 -> "30:00"
function EggConfig.FormatTime(seconds)
	seconds = math.max(0, math.ceil(seconds))
	local h, m, s = seconds // 3600, seconds % 3600 // 60, seconds % 60
	if h > 0 then return string.format("%d:%02d:%02d", h, m, s) end
	return string.format("%d:%02d", m, s)
end

-- 1500 -> "$1.5K", 1000000 -> "$1M"
function EggConfig.FormatMoney(amount)
	for _, suffix in SUFFIXES do
		if amount >= suffix[1] then
			local text = string.format("%.2f", amount / suffix[1]):gsub("%.?0+$", "")
			return "$" .. text .. suffix[2]
		end
	end
	return "$" .. tostring(math.floor(amount))
end

-- Raretés spéciales : gradient animé sur le texte (les autres restent blanches)
EggConfig.Gradients = {
	Legendary = ColorSequence.new({K(0, rgb(255, 170, 0)), K(0.5, rgb(255, 255, 140)), K(1, rgb(255, 110, 0))}),
	Mythic = ColorSequence.new({K(0, rgb(255, 90, 200)), K(0.35, rgb(170, 110, 255)), K(0.7, rgb(90, 220, 255)), K(1, rgb(255, 90, 200))}),
	Rainbow = ColorSequence.new({K(0, rgb(255, 80, 80)), K(0.2, rgb(255, 200, 60)), K(0.4, rgb(100, 255, 110)), K(0.6, rgb(80, 200, 255)), K(0.8, rgb(190, 110, 255)), K(1, rgb(255, 80, 80))}),
	Secret = ColorSequence.new({K(0, rgb(255, 0, 60)), K(0.5, rgb(255, 255, 255)), K(1, rgb(150, 0, 255))}),
	Like = ColorSequence.new({K(0, rgb(255, 60, 120)), K(0.33, rgb(255, 150, 200)), K(0.66, rgb(80, 200, 255)), K(1, rgb(255, 60, 120))}),
	Hacked = ColorSequence.new({K(0, rgb(20, 255, 100)), K(0.35, rgb(200, 255, 210)), K(0.55, rgb(0, 160, 60)), K(0.8, rgb(120, 255, 170)), K(1, rgb(20, 255, 100))}),
	Ancient = ColorSequence.new({K(0, rgb(120, 220, 90)), K(0.5, rgb(255, 240, 150)), K(1, rgb(60, 160, 70))}),
	OG = ColorSequence.new({K(0, rgb(255, 215, 60)), K(0.5, rgb(255, 255, 255)), K(1, rgb(255, 150, 30))}),
	Divine = ColorSequence.new({K(0, rgb(255, 255, 255)), K(0.5, rgb(255, 228, 120)), K(1, rgb(170, 225, 255))}),
	Prismatic = ColorSequence.new({K(0, rgb(255, 90, 90)), K(0.17, rgb(255, 180, 70)), K(0.34, rgb(255, 245, 110)), K(0.5, rgb(110, 255, 150)), K(0.67, rgb(90, 200, 255)), K(0.84, rgb(200, 120, 255)), K(1, rgb(255, 90, 90))}),
}

-- Jardin : 5 animaux posés au départ, +1 par agrandissement (panneau UpgradeSign de la base), jusqu'à MaxPlaced
EggConfig.BasePlaced = 5
EggConfig.GardenCosts = {1000, 10000, 100000, 1000000, 10000000}

-- Index : argent gagné (une seule fois) quand tous les animaux d'une rareté sont découverts
EggConfig.IndexRewards = {Common = 10000, Uncommon = 100000, Rare = 1000000, Epic = 10000000, Legendary = 100000000, Mythic = 1000000000, Secret = 10000000000, Ancient = 100000000000, OG = 1000000000000, Divine = 10000000000000, Prismatic = 100000000000000}

-- Speed conseillé dans chaque zone : en dessous, le gardien court plus vite que le joueur ; au-dessus, il ne le rattrape plus (ZoneBossServer)
EggConfig.ZoneSpeed = {Common = 0, Uncommon = 1e2, Rare = 1e3, Epic = 1e4, Legendary = 1e5, Mythic = 1e6, Secret = 1e7, Ancient = 1e8, OG = 1e9, Divine = 1e10, Prismatic = 6e11} -- (Prismatic/Halloween : 600B = courir à 200, la vitesse du Pumpking)
-- Marteau qu'il faut au moins pour casser les œufs d'une zone (numéro dans HammerConfig.Tiers) : un nouveau marteau toutes les deux zones
function EggConfig.ZoneHammer(rarity)
	return 1
end

-- BOUTIQUE : l'œuf en vedette (ShopConfig.Featured) et ses six animaux ange. Rareté "Exclusive" : on ne les trouve dans aucune zone.
-- Model = le modèle du kit réutilisé ; Angel = corps blanc, auréole et ailes de plumes (fabriqués par ServerStorage.AnimalWiring).
EggConfig.Pets.AngelKitsune = {Name = "Angel Kitsune", Rarity = "Exclusive", Model = "KitsuneBaby", Angel = true, Kg = 8, Income = 40000000}
EggConfig.Pets.AngelPony = {Name = "Angel Pony", Rarity = "Exclusive", Model = "Pony", Angel = true, Kg = 200, Income = 80000000}
EggConfig.Pets.AngelCaladrius = {Name = "Holy Caladrius", Rarity = "Exclusive", Model = "Caladrius", Angel = true, Kg = 6, Income = 160000000, Fly = "Always", FlyHeight = 2}
EggConfig.Pets.AngelLion = {Name = "Seraph Lion", Rarity = "Exclusive", Model = "Lion", Angel = true, Kg = 190, Income = 320000000}
EggConfig.Pets.AngelGaruda = {Name = "Archangel Garuda", Rarity = "Exclusive", Model = "Garuda", Angel = true, Kg = 90, Income = 600000000, Fly = "Always", FlyHeight = 2}
EggConfig.Pets.AngelCerberus = {Name = "Heaven Cerberus", Rarity = "Exclusive", Model = "Cerberus", Angel = true, Kg = 1200, Income = 1200000000}
EggConfig.Eggs.AngelEgg = {Order = 200, Name = "Fallen Angel Egg", Rarity = "Exclusive", Price = 0, Cooldown = 60, Kg = 20, ZoneOnly = true, Angel = true,
	Colors = {rgb(255, 252, 240), rgb(255, 208, 60), rgb(150, 220, 255)},
	Pets = {{Pet = "AngelKitsune", Chance = 70}, {Pet = "AngelPony", Chance = 18}, {Pet = "AngelCaladrius", Chance = 9.9}, {Pet = "AngelLion", Chance = 1}, {Pet = "AngelGaruda", Chance = 1}, {Pet = "AngelCerberus", Chance = 0.1}}}
EggConfig.Gradients.Cosmic = ColorSequence.new({K(0, rgb(110, 140, 255)), K(0.5, rgb(235, 170, 255)), K(1, rgb(110, 140, 255))})
EggConfig.Gradients.Storm = ColorSequence.new({K(0, rgb(90, 200, 255)), K(0.5, rgb(240, 255, 255)), K(1, rgb(90, 200, 255))})
EggConfig.Gradients.Alien = ColorSequence.new({K(0, rgb(80, 255, 110)), K(0.5, rgb(220, 255, 140)), K(1, rgb(80, 255, 110))})
EggConfig.Gradients.Candy = ColorSequence.new({K(0, rgb(255, 110, 190)), K(0.33, rgb(255, 230, 120)), K(0.66, rgb(130, 210, 255)), K(1, rgb(255, 110, 190))})
EggConfig.Gradients.Blood = ColorSequence.new({K(0, rgb(170, 10, 30)), K(0.5, rgb(255, 90, 90)), K(1, rgb(170, 10, 30))})
EggConfig.Gradients.Frozen = ColorSequence.new({K(0, rgb(150, 220, 255)), K(0.5, rgb(255, 255, 255)), K(1, rgb(150, 220, 255))})
EggConfig.Gradients.Exclusive = ColorSequence.new({K(0, rgb(255, 255, 255)), K(0.5, rgb(255, 214, 80)), K(1, rgb(150, 220, 255))})

-- ŒUFS DE ZONE : deux œufs par zone, qui contiennent TOUS les animaux de la zone (les anciens œufs, un par animal, sont
-- gardés pour les sauvegardes, l'Index et l'admin). Ce sont eux qui apparaissent dans les zones (EggZoneServer).
--   <Zone> Egg       : le plus courant, moins de points de vie, surtout des animaux faibles
--   Royal <Zone> Egg : deux fois plus de points de vie, bien meilleures chances d'avoir un bon animal
-- Hp = points de vie de base (un œuf géant en a plus) ; SpawnWeight = part des apparitions dans la zone.
EggConfig.ZoneEggHp = { -- {œuf normal, œuf royal}
	Common = {10, 20}, Uncommon = {120, 250}, Rare = {1.5e3, 3e3}, Epic = {1.8e4, 3.6e4}, Legendary = {2e5, 4e5}, Mythic = {2.5e6, 5e6},
	Secret = {3e7, 6e7}, Ancient = {3.5e8, 7e8}, OG = {4e9, 8e9}, Divine = {4.5e10, 9e10}, Prismatic = {5e11, 1e12},
}
EggConfig.ZoneEggSpawn = {99, 1} -- % d'apparition : œuf normal / œuf royal (le très bon œuf est très rare : 1 %)
-- chances (en %) d'avoir chaque animal de la zone, du plus faible au meilleur (selon le nombre d'animaux dans la zone)
-- (œuf normal : les meilleurs animaux sont rares)
EggConfig.ZoneEggLoot = {
	[6] = {Base = {45, 27, 16, 8, 3.2, 0.8}, Royal = {24, 22, 20, 17, 11, 6}},
	[7] = {Base = {41, 26, 17, 10, 4.2, 1.4, 0.4}, Royal = {21, 19, 18, 16, 13, 8.5, 4.5}},
	[8] = {Base = {39, 25, 16, 10.5, 6, 2.5, 0.8, 0.2}, Royal = {20, 18, 17, 15, 12, 9, 6, 3}},
}
local function lootFor(count, royal)
	local known = EggConfig.ZoneEggLoot[count]
	if known then return royal and known.Royal or known.Base end
	local weights, total = {}, 0 -- autre nombre d'animaux : chaque animal ~0,65x (normal) ou ~0,85x (royal) moins probable que le précédent
	for i = 1, count do weights[i] = (royal and 0.8 or 0.58) ^ (i - 1) total += weights[i] end
	for i = 1, count do weights[i] = math.floor(weights[i] / total * 1000 + 0.5) / 10 end
	return weights
end
EggConfig.ZoneEggKeys = {} -- [rareté] = {clé de l'œuf normal, clé de l'œuf royal}
for rank, rarity in EggConfig.Rarities do
	local keys = EggConfig.EggsByValue(rarity)
	if #keys > 0 then
		local zoneName = (string.gsub(EggConfig.ZoneTitles[rarity] or rarity, " Zone$", ""))
		local first, best = EggConfig.Eggs[keys[1]], EggConfig.Eggs[keys[#keys]]
		EggConfig.ZoneEggKeys[rarity] = {}
		for tier, royal in {false, true} do
			local chances = lootFor(#keys, royal)
			local pets = {}
			for i, key in keys do table.insert(pets, {Pet = EggConfig.Eggs[key].Pets[1].Pet, Chance = chances[i]}) end
			local key = (royal and "RoyalZoneEgg_" or "ZoneEgg_") .. rarity
			EggConfig.Eggs[key] = {
				Order = 1000 + rank * 2 + tier, ZoneEgg = true, Royal = royal, Rarity = rarity,
				Name = (royal and "Royal " or "") .. zoneName .. " Egg",
				Hp = EggConfig.ZoneEggHp[rarity][tier], SpawnWeight = EggConfig.ZoneEggSpawn[tier],
				Price = 0, Cooldown = best.Cooldown, Kg = 1,
				Template = royal and keys[#keys] or keys[1], -- modèle de base pour la coquille et le nid
				Colors = royal and {best.Colors[1]:Lerp(rgb(255, 215, 90), 0.35), rgb(255, 205, 60), rgb(255, 250, 220)} or first.Colors,
				Pets = pets,
			}
			table.insert(EggConfig.ZoneEggKeys[rarity], key)
		end
	end
end

-- Nightmare Kraken, Cursed Megalodon, Swamp Crocodile et Shadow Leviathan : 0,2 % chacun dans les œufs Halloween (normal et royal) ;
-- le reste des chances est redistribué aux autres animaux de l'œuf, en gardant leurs proportions
EggConfig.CappedPets = {Kraken = 0.2, Megalodon = 0.2, Crocodile = 0.2, Leviathan = 0.2, Jellyfish = 0.2}
for _, key in EggConfig.ZoneEggKeys.Prismatic or {} do
	local egg = EggConfig.Eggs[key]
	local capped, others = 0, 0
	for _, entry in egg.Pets do
		if EggConfig.CappedPets[entry.Pet] then capped += EggConfig.CappedPets[entry.Pet] else others += entry.Chance end
	end
	local rest = 100 - capped
	for _, entry in egg.Pets do
		entry.Chance = EggConfig.CappedPets[entry.Pet] or math.floor(entry.Chance / others * rest * 100 + 0.5) / 100
	end
end

-- ŒUFS DE ZONE MÉLANGÉS (pour l'économie) : on n'a pas un animal de la zone à coup sûr. Une partie des ouvertures donne un
-- animal d'une zone d'avant (avec les chances habituelles de l'œuf normal de cette zone).
--   Own = part (en %) des animaux de la zone elle-même (œuf normal / œuf royal)
--   Previous = poids des zones d'avant, de la plus proche à la plus lointaine (le reste des % est partagé selon ces poids)
-- La première zone (Common) n'a pas de zone avant elle : elle reste à 100 %.
EggConfig.ZoneMix = {Own = {Normal = 50, Royal = 65}, Previous = {20, 12, 8, 6, 4}}
do
	local ordered = {}
	for _, rarity in EggConfig.Rarities do
		if EggConfig.ZoneEggKeys[rarity] then table.insert(ordered, rarity) end
	end
	-- chances d'origine de l'œuf normal de chaque zone (avant tout mélange)
	local original = {}
	for _, rarity in ordered do
		local egg = EggConfig.Eggs[EggConfig.ZoneEggKeys[rarity][1]]
		original[rarity] = {}
		for _, entry in egg.Pets do table.insert(original[rarity], {Pet = entry.Pet, Chance = entry.Chance}) end
	end
	for index, rarity in ordered do
		if index > 1 then
			-- zones d'avant prises en compte (au plus autant que de poids) et leur part du reste
			local sources, weightSum = {}, 0
			for back, weight in EggConfig.ZoneMix.Previous do
				local prev = ordered[index - back]
				if prev then table.insert(sources, {prev, weight}) weightSum += weight end
			end
			for tier, key in EggConfig.ZoneEggKeys[rarity] do
				local egg = EggConfig.Eggs[key]
				local own = EggConfig.ZoneMix.Own[tier == 2 and "Royal" or "Normal"]
				local pets = {}
				-- animaux de la zone : les animaux plafonnés (CappedPets) gardent leur chance, les autres se partagent le reste
				local capSum, freeSum = 0, 0
				for _, entry in egg.Pets do
					if EggConfig.CappedPets[entry.Pet] then capSum += EggConfig.CappedPets[entry.Pet] else freeSum += entry.Chance end
				end
				for _, entry in egg.Pets do
					local chance = EggConfig.CappedPets[entry.Pet] or entry.Chance / freeSum * (own - capSum)
					table.insert(pets, {Pet = entry.Pet, Chance = math.floor(chance * 1000 + 0.5) / 1000})
				end
				-- animaux des zones d'avant
				for _, source in sources do
					local share = (100 - own) * source[2] / weightSum
					local total = 0
					for _, entry in original[source[1]] do total += entry.Chance end
					for _, entry in original[source[1]] do
						table.insert(pets, {Pet = entry.Pet, Chance = math.floor(entry.Chance / total * share * 1000 + 0.5) / 1000})
					end
				end
				egg.Pets = pets
			end
		end
	end
end

-- REVENUS ADAPTÉS AUX ZONES : multiplicateur appliqué au revenu de base de chaque animal selon sa rareté.
-- Les premières zones gardent presque tout (un débutant n'a encore aucun bonus) ; plus la zone est avancée, plus on réduit,
-- car un joueur avancé cumule les bonus (niveaux, poids, mutations, events). Changer une valeur ici suffit.
EggConfig.IncomeScale = {
	Common = 1, Uncommon = 0.75, Rare = 0.65, Epic = 0.55, Legendary = 0.43, Mythic = 0.3,
	Secret = 0.25, Ancient = 0.22, OG = 0.18, Divine = 0.155, Prismatic = 0.13, Exclusive = 0.27,
}
for _, info in EggConfig.Pets do
	local scale = EggConfig.IncomeScale[info.Rarity]
	if scale and type(info.Income) == "number" then info.Income = math.max(1, math.floor(info.Income * scale + 0.5)) end
end

-- tous les animaux et tous les œufs partent du même poids de base (voir EggConfig.BaseKg)
for _, info in EggConfig.Pets do info.Kg = EggConfig.BaseKg end
for _, info in EggConfig.Eggs do info.Kg = EggConfig.BaseKg end

-- poids maximum d'un œuf ou d'un animal (œufs qui apparaissent, kilos bonus, panneau admin)
EggConfig.MaxKg = 1000000

return EggConfig
