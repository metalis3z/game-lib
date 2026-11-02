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

-- Fly : "Always" = vole tout le temps, "Sometimes" = marche et s'envole de temps en temps, rien = marche
-- FlyHeight : hauteur de vol (studs) | FlapSpeed / FlapAngle : battement d'ailes | Idle = "Peck" : picore à l'arrêt
EggConfig.Pets = {
	Chicken = {Name = "Chicken", Rarity = "Common", Kg = 2, Income = 5, Idle = "Peck", Fly = "Sometimes", FlyHeight = 1.4, FlapSpeed = 20, FlapAngle = 30},
	Chick = {Name = "Chick", Rarity = "Common", Kg = 0.3, Income = 10, Idle = "Peck", Fly = "Sometimes", FlyHeight = 1.4, FlapSpeed = 20, FlapAngle = 30},
	Rooster = {Name = "Rooster", Rarity = "Common", Kg = 3, Income = 15, Idle = "Peck", Fly = "Sometimes", FlyHeight = 1.4, FlapSpeed = 20, FlapAngle = 30},
	Duck = {Name = "Duck", Rarity = "Common", Kg = 1.5, Income = 20, Idle = "Peck", Fly = "Sometimes", FlyHeight = 1.4, FlapSpeed = 20, FlapAngle = 30},
	Turkey = {Name = "Turkey", Rarity = "Common", Kg = 6, Income = 25, Idle = "Peck", Fly = "Sometimes", FlyHeight = 1.4, FlapSpeed = 20, FlapAngle = 30},
	OceanFish = {Name = "Ocean Fish", Rarity = "Epic", Kg = 2, Income = 3400, Fly = "Always", FlyHeight = 1.6, FlapSpeed = 8, FlapAngle = 34},

	Pig = {Name = "Pig", Rarity = "Uncommon", Kg = 60, Income = 25},
	Sheep = {Name = "Sheep", Rarity = "Uncommon", Kg = 45, Income = 40},
	Cow = {Name = "Cow", Rarity = "Uncommon", Kg = 300, Income = 55},
	Goat = {Name = "Goat", Rarity = "Uncommon", Kg = 50, Income = 75},
	Horse = {Name = "Horse", Rarity = "Uncommon", Kg = 450, Income = 100},
	Goose = {Name = "Goose", Rarity = "Uncommon", Kg = 5, Income = 125, Idle = "Peck", Fly = "Sometimes", FlyHeight = 2.5, FlapSpeed = 9, FlapAngle = 32},
	ForestFish = {Name = "Forest Fish", Rarity = "Uncommon", Kg = 4, Income = 190, Fly = "Always", FlyHeight = 1.6, FlapSpeed = 8, FlapAngle = 34},

	Deer = {Name = "Deer", Rarity = "Rare", Kg = 80, Income = 125},
	Fox = {Name = "Fox", Rarity = "Rare", Kg = 6, Income = 190},
	Wolf = {Name = "Wolf", Rarity = "Rare", Kg = 40, Income = 270},
	Bear = {Name = "Bear", Rarity = "Rare", Kg = 350, Income = 370},
	Tiger = {Name = "Tiger", Rarity = "Rare", Kg = 220, Income = 480},
	Eagle = {Name = "Eagle", Rarity = "Rare", Kg = 6, Income = 625, Fly = "Sometimes", FlyHeight = 3.5, FlapSpeed = 7, FlapAngle = 34},
	FireFish = {Name = "Fire Fish", Rarity = "Common", Kg = 6, Income = 40, Fly = "Always", FlyHeight = 1.6, FlapSpeed = 8, FlapAngle = 34},

	Bee = {Name = "Bee", Rarity = "Epic", Kg = 0.02, Income = 450, Fly = "Always", FlyHeight = 1.5, FlapSpeed = 45, FlapAngle = 22},
	Ladybug = {Name = "Ladybug", Rarity = "Epic", Kg = 0.01, Income = 700, Fly = "Sometimes", FlyHeight = 1.8, FlapSpeed = 40, FlapAngle = 25},
	Butterfly = {Name = "Butterfly", Rarity = "Epic", Kg = 0.01, Income = 1100, Fly = "Always", FlyHeight = 2, FlapSpeed = 9, FlapAngle = 50},
	Scarab = {Name = "Scarab", Rarity = "Epic", Kg = 0.05, Income = 1600},
	Firefly = {Name = "Firefly", Rarity = "Epic", Kg = 0.01, Fly = "Always", FlyHeight = 1.8, FlapSpeed = 40, FlapAngle = 25, Income = 2250},
	IceFish = {Name = "Ice Fish", Rarity = "Rare", Kg = 3, Income = 950, Fly = "Always", FlyHeight = 1.6, FlapSpeed = 8, FlapAngle = 34},

	Dragon = {Name = "Dragon", Rarity = "Legendary", Kg = 900, Income = 1250, Fly = "Sometimes", FlyHeight = 3.5, FlapSpeed = 8, FlapAngle = 32},
	IceDragon = {Name = "Ice Dragon", Rarity = "Legendary", Kg = 850, Income = 2000, Fly = "Sometimes", FlyHeight = 3.5, FlapSpeed = 8, FlapAngle = 32},
	Phoenix = {Name = "Phoenix", Rarity = "Legendary", Kg = 25, Income = 3000, Fly = "Always", FlyHeight = 2.5, FlapSpeed = 7, FlapAngle = 35},
	Golem = {Name = "Golem", Rarity = "Legendary", Kg = 2000, Income = 4500},
	Griffin = {Name = "Griffin", Rarity = "Legendary", Kg = 300, Fly = "Sometimes", FlyHeight = 3.5, FlapSpeed = 7, FlapAngle = 34, Income = 6250},
	ThunderFish = {Name = "Thunder Fish", Rarity = "Legendary", Kg = 8, Income = 9500, Fly = "Always", FlyHeight = 1.6, FlapSpeed = 8, FlapAngle = 34},

	Unicorn = {Name = "Unicorn", Rarity = "Mythic", Kg = 400, Income = 3000},
	Pegasus = {Name = "Pegasus", Rarity = "Mythic", Kg = 380, Income = 4500, Fly = "Sometimes", FlyHeight = 3.5, FlapSpeed = 7, FlapAngle = 34},
	Celestial = {Name = "Celestial", Rarity = "Mythic", Kg = 500, Income = 7000, Fly = "Sometimes", FlyHeight = 4, FlapSpeed = 6, FlapAngle = 34},
	Kitsune = {Name = "Kitsune", Rarity = "Mythic", Kg = 12, Income = 10000},
	Sphinx = {Name = "Sphinx", Rarity = "Mythic", Kg = 450, Fly = "Sometimes", FlyHeight = 3.5, FlapSpeed = 7, FlapAngle = 34, Income = 15000},
	CrystalFish = {Name = "Crystal Fish", Rarity = "Mythic", Kg = 5, Income = 22500, Fly = "Always", FlyHeight = 1.6, FlapSpeed = 8, FlapAngle = 34},

	Demon = {Name = "Demon", Rarity = "Secret", Kg = 70, Income = 5000, Fly = "Sometimes", FlyHeight = 2.5, FlapSpeed = 10, FlapAngle = 30},
	VoidDragon = {Name = "Void Dragon", Rarity = "Secret", Kg = 1200, Income = 7500, Fly = "Sometimes", FlyHeight = 4, FlapSpeed = 7, FlapAngle = 32},
	Reaper = {Name = "Reaper", Rarity = "Secret", Kg = 55, Income = 11000, Fly = "Always", FlyHeight = 0.9},
	Hellhound = {Name = "Hellhound", Rarity = "Secret", Kg = 90, Income = 17000},
	CosmicCat = {Name = "Cosmic Cat", Rarity = "Secret", Kg = 5, Fly = "Always", FlyHeight = 1, Income = 25000},
	VoidFish = {Name = "Void Fish", Rarity = "Secret", Kg = 10, Income = 37500, Fly = "Always", FlyHeight = 1.6, FlapSpeed = 8, FlapAngle = 34},

	-- HALLOWEEN : les meilleurs animaux du jeu (seulement dans la zone Halloween, gardée par le boss Pumpking)
	-- Special = animation propre à chaque animal (jouée par PetClient)
	Pumpkin = {Name = "Pumpkin", Rarity = "Halloween", Kg = 20, Income = 50000, Special = "Pumpkin"},
	Ghost = {Name = "Ghost", Rarity = "Halloween", Kg = 0.5, Income = 65000, Fly = "Always", FlyHeight = 1.4, Special = "Ghost"},
	WitchCat = {Name = "Witch Cat", Rarity = "Halloween", Kg = 6, Income = 85000, Special = "WitchCat"},
	SkeletonDog = {Name = "Skeleton Dog", Rarity = "Halloween", Kg = 15, Income = 110000, Special = "SkeletonDog"},
	VampireBat = {Name = "Vampire Bat", Rarity = "Halloween", Kg = 1.5, Income = 150000, Fly = "Always", FlyHeight = 2.2, FlapSpeed = 14, FlapAngle = 40, Special = "VampireBat"},
}

-- Oeufs : UN OEUF PAR ANIMAL. Nom affiché, prix, Cooldown = temps d'éclosion en secondes une fois posé.
-- Dans chaque rareté, le 2e oeuf coûte x1.5 et le 3e x2.25.
EggConfig.Eggs = {
	ChickenEgg = {Order = 1, Name = "Chicken Egg", Rarity = "Common", Price = 100, Cooldown = 30, Kg = 1,
		Pets = {{Pet = "Chicken", Chance = 100}}},
	ChickEgg = {Order = 2, Name = "Chick Egg", Rarity = "Common", Price = 150, Cooldown = 30, Kg = 1,
		Pets = {{Pet = "Chick", Chance = 100}}},
	RoosterEgg = {Order = 3, Name = "Rooster Egg", Rarity = "Common", Price = 225, Cooldown = 30, Kg = 1,
		Pets = {{Pet = "Rooster", Chance = 100}}},
	DuckEgg = {Order = 4, Name = "Duck Egg", Rarity = "Common", Price = 175, Cooldown = 30, Kg = 1,
		Pets = {{Pet = "Duck", Chance = 100}}},
	TurkeyEgg = {Order = 5, Name = "Turkey Egg", Rarity = "Common", Price = 200, Cooldown = 30, Kg = 1,
		Pets = {{Pet = "Turkey", Chance = 100}}},
	OceanFishEgg = {Order = 26, Name = "Ocean Fish Egg", Rarity = "Epic", Price = 170000, Cooldown = 600, Kg = 3,
		Pets = {{Pet = "OceanFish", Chance = 100}}},
	PigEgg = {Order = 7, Name = "Pig Egg", Rarity = "Uncommon", Price = 750, Cooldown = 120, Kg = 1.5,
		Pets = {{Pet = "Pig", Chance = 100}}},
	SheepEgg = {Order = 8, Name = "Sheep Egg", Rarity = "Uncommon", Price = 1125, Cooldown = 120, Kg = 1.5,
		Pets = {{Pet = "Sheep", Chance = 100}}},
	CowEgg = {Order = 9, Name = "Cow Egg", Rarity = "Uncommon", Price = 1700, Cooldown = 120, Kg = 1.5,
		Pets = {{Pet = "Cow", Chance = 100}}},
	GoatEgg = {Order = 10, Name = "Goat Egg", Rarity = "Uncommon", Price = 2550, Cooldown = 120, Kg = 1.5,
		Pets = {{Pet = "Goat", Chance = 100}}},
	HorseEgg = {Order = 11, Name = "Horse Egg", Rarity = "Uncommon", Price = 3750, Cooldown = 120, Kg = 1.5,
		Pets = {{Pet = "Horse", Chance = 100}}},
	GooseEgg = {Order = 12, Name = "Goose Egg", Rarity = "Uncommon", Price = 5600, Cooldown = 120, Kg = 1.5,
		Pets = {{Pet = "Goose", Chance = 100}}},
	ForestFishEgg = {Order = 13, Name = "Forest Fish Egg", Rarity = "Uncommon", Price = 8000, Cooldown = 120, Kg = 1.5,
		Pets = {{Pet = "ForestFish", Chance = 100}}},
	DeerEgg = {Order = 14, Name = "Deer Egg", Rarity = "Rare", Price = 5000, Cooldown = 300, Kg = 2,
		Pets = {{Pet = "Deer", Chance = 100}}},
	FoxEgg = {Order = 15, Name = "Fox Egg", Rarity = "Rare", Price = 7500, Cooldown = 300, Kg = 2,
		Pets = {{Pet = "Fox", Chance = 100}}},
	WolfEgg = {Order = 16, Name = "Wolf Egg", Rarity = "Rare", Price = 11500, Cooldown = 300, Kg = 2,
		Pets = {{Pet = "Wolf", Chance = 100}}},
	BearEgg = {Order = 17, Name = "Bear Egg", Rarity = "Rare", Price = 17000, Cooldown = 300, Kg = 2,
		Pets = {{Pet = "Bear", Chance = 100}}},
	TigerEgg = {Order = 18, Name = "Tiger Egg", Rarity = "Rare", Price = 25000, Cooldown = 300, Kg = 2,
		Pets = {{Pet = "Tiger", Chance = 100}}},
	EagleEgg = {Order = 19, Name = "Eagle Egg", Rarity = "Rare", Price = 37500, Cooldown = 300, Kg = 2,
		Pets = {{Pet = "Eagle", Chance = 100}}},
	FireFishEgg = {Order = 6, Name = "Fire Fish Egg", Rarity = "Common", Price = 300, Cooldown = 30, Kg = 1,
		Pets = {{Pet = "FireFish", Chance = 100}}},
	BeeEgg = {Order = 21, Name = "Bee Egg", Rarity = "Epic", Price = 25000, Cooldown = 600, Kg = 3,
		Pets = {{Pet = "Bee", Chance = 100}}},
	LadybugEgg = {Order = 22, Name = "Ladybug Egg", Rarity = "Epic", Price = 37500, Cooldown = 600, Kg = 3,
		Pets = {{Pet = "Ladybug", Chance = 100}}},
	ButterflyEgg = {Order = 23, Name = "Butterfly Egg", Rarity = "Epic", Price = 56500, Cooldown = 600, Kg = 3,
		Pets = {{Pet = "Butterfly", Chance = 100}}},
	ScarabEgg = {Order = 24, Name = "Scarab Egg", Rarity = "Epic", Price = 85000, Cooldown = 600, Kg = 3,
		Pets = {{Pet = "Scarab", Chance = 100}}},
	FireflyEgg = {Order = 25, Name = "Firefly Egg", Rarity = "Epic", Price = 125000, Cooldown = 600, Kg = 3,
		Pets = {{Pet = "Firefly", Chance = 100}}},
	IceFishEgg = {Order = 20, Name = "Ice Fish Egg", Rarity = "Rare", Price = 50000, Cooldown = 300, Kg = 2,
		Pets = {{Pet = "IceFish", Chance = 100}}},
	DragonEgg = {Order = 27, Name = "Dragon Egg", Rarity = "Legendary", Price = 100000, Cooldown = 900, Kg = 5,
		Pets = {{Pet = "Dragon", Chance = 100}}},
	IceDragonEgg = {Order = 28, Name = "Ice Dragon Egg", Rarity = "Legendary", Price = 150000, Cooldown = 900, Kg = 5,
		Pets = {{Pet = "IceDragon", Chance = 100}}},
	PhoenixEgg = {Order = 29, Name = "Phoenix Egg", Rarity = "Legendary", Price = 225000, Cooldown = 900, Kg = 5,
		Pets = {{Pet = "Phoenix", Chance = 100}}},
	GolemEgg = {Order = 30, Name = "Golem Egg", Rarity = "Legendary", Price = 340000, Cooldown = 900, Kg = 5,
		Pets = {{Pet = "Golem", Chance = 100}}},
	GriffinEgg = {Order = 31, Name = "Griffin Egg", Rarity = "Legendary", Price = 500000, Cooldown = 900, Kg = 5,
		Pets = {{Pet = "Griffin", Chance = 100}}},
	ThunderFishEgg = {Order = 32, Name = "Thunder Fish Egg", Rarity = "Legendary", Price = 700000, Cooldown = 900, Kg = 5,
		Pets = {{Pet = "ThunderFish", Chance = 100}}},
	UnicornEgg = {Order = 33, Name = "Unicorn Egg", Rarity = "Mythic", Price = 400000, Cooldown = 1200, Kg = 8,
		Pets = {{Pet = "Unicorn", Chance = 100}}},
	PegasusEgg = {Order = 34, Name = "Pegasus Egg", Rarity = "Mythic", Price = 600000, Cooldown = 1200, Kg = 8,
		Pets = {{Pet = "Pegasus", Chance = 100}}},
	CelestialEgg = {Order = 35, Name = "Celestial Egg", Rarity = "Mythic", Price = 900000, Cooldown = 1200, Kg = 8,
		Pets = {{Pet = "Celestial", Chance = 100}}},
	KitsuneEgg = {Order = 36, Name = "Kitsune Egg", Rarity = "Mythic", Price = 1360000, Cooldown = 1200, Kg = 8,
		Pets = {{Pet = "Kitsune", Chance = 100}}},
	SphinxEgg = {Order = 37, Name = "Sphinx Egg", Rarity = "Mythic", Price = 2000000, Cooldown = 1200, Kg = 8,
		Pets = {{Pet = "Sphinx", Chance = 100}}},
	CrystalFishEgg = {Order = 38, Name = "Crystal Fish Egg", Rarity = "Mythic", Price = 2800000, Cooldown = 1200, Kg = 8,
		Pets = {{Pet = "CrystalFish", Chance = 100}}},
	DemonEgg = {Order = 39, Name = "Demon Egg", Rarity = "Secret", Price = 1000000, Cooldown = 1800, Kg = 12,
		Pets = {{Pet = "Demon", Chance = 100}}},
	VoidDragonEgg = {Order = 40, Name = "Void Dragon Egg", Rarity = "Secret", Price = 1500000, Cooldown = 1800, Kg = 12,
		Pets = {{Pet = "VoidDragon", Chance = 100}}},
	ReaperEgg = {Order = 41, Name = "Reaper Egg", Rarity = "Secret", Price = 2250000, Cooldown = 1800, Kg = 12,
		Pets = {{Pet = "Reaper", Chance = 100}}},
	HellhoundEgg = {Order = 42, Name = "Hellhound Egg", Rarity = "Secret", Price = 3400000, Cooldown = 1800, Kg = 12,
		Pets = {{Pet = "Hellhound", Chance = 100}}},
	CosmicCatEgg = {Order = 43, Name = "Cosmic Cat Egg", Rarity = "Secret", Price = 5000000, Cooldown = 1800, Kg = 12,
		Pets = {{Pet = "CosmicCat", Chance = 100}}},
	VoidFishEgg = {Order = 44, Name = "Void Fish Egg", Rarity = "Secret", Price = 7000000, Cooldown = 1800, Kg = 12,
		Pets = {{Pet = "VoidFish", Chance = 100}}},

	-- HALLOWEEN (ZoneOnly : on ne peut pas les acheter, on les trouve seulement dans la zone Halloween)
	PumpkinEgg = {Order = 45, Name = "Pumpkin Egg", Rarity = "Halloween", Price = 10000000, Cooldown = 2400, Kg = 15, ZoneOnly = true,
		Pets = {{Pet = "Pumpkin", Chance = 100}}},
	GhostEgg = {Order = 46, Name = "Ghost Egg", Rarity = "Halloween", Price = 15000000, Cooldown = 2400, Kg = 15, ZoneOnly = true,
		Pets = {{Pet = "Ghost", Chance = 100}}},
	WitchEgg = {Order = 47, Name = "Witch Egg", Rarity = "Halloween", Price = 22500000, Cooldown = 2400, Kg = 15, ZoneOnly = true,
		Pets = {{Pet = "WitchCat", Chance = 100}}},
	SkeletonEgg = {Order = 48, Name = "Skeleton Egg", Rarity = "Halloween", Price = 34000000, Cooldown = 2400, Kg = 15, ZoneOnly = true,
		Pets = {{Pet = "SkeletonDog", Chance = 100}}},
	VampireEgg = {Order = 49, Name = "Vampire Egg", Rarity = "Halloween", Price = 50000000, Cooldown = 2400, Kg = 15, ZoneOnly = true,
		Pets = {{Pet = "VampireBat", Chance = 100}}},
}

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
		if info.Rarity == rarity then table.insert(keys, key) end
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
EggConfig.KgVariation = 0.15 -- +/- 15 % de variation au hasard sur le poids normal

-- Taille : +1x tous les SizeStepKg kilos (2x à 10 000 kg, 3x à 20 000 kg...).
-- Au-delà de MaxSizeKg le poids peut encore monter, mais la taille ne grossit plus.
EggConfig.SizeStepKg = 10000
EggConfig.MaxSizeKg = 900000 -- assez pour les oeufs géants des zones (jusqu'à ~90 fois la taille normale)
-- Revenus : +1x tous les IncomeStepKg kilos au-dessus du poids normal (sans limite)
EggConfig.IncomeStepKg = 2000

-- 2) Mutation : Chance en %, Mult = multiplicateur de revenu. L'oeuf prend la couleur de la mutation,
-- et l'animal qui en sort la garde.
EggConfig.Mutations = {
	{Name = "Rainbow", Chance = 0.1, Mult = 10},
	{Name = "Diamond", Chance = 1, Mult = 5, Color = rgb(150, 235, 255)},
	{Name = "Gold", Chance = 10, Mult = 2, Color = rgb(255, 215, 60)},
	-- Like : seulement pendant l'event CONCERT (les danseurs lancent des j'aime sur les oeufs des zones), jamais tirée au hasard
	{Name = "Like", Chance = 0, Mult = 5, Color = rgb(255, 70, 130)},
}

-- 3) Croissance : pendant que l'oeuf couve, à chaque Interval (s) il a Chance % de grossir de Mult
EggConfig.Growth = {Interval = 60, Chance = 10, Mult = 1.15}

-- Recolore un modèle (oeuf ou animal) selon sa mutation, en gardant les ombres et les détails :
-- Gold / Diamond = une seule teinte, Rainbow = arc-en-ciel doux de bas en haut (sans néon).
function EggConfig.ApplyMutation(model, mutationName)
	local mutation = mutationName and EggConfig.GetMutation(mutationName)
	if not mutation then return end
	local cf, size = model:GetBoundingBox()
	local bottom = cf.Position.Y - size.Y / 2
	for _, part in model:GetDescendants() do
		if part:IsA("BasePart") and part.Transparency < 1 then
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
-- revenu normal x (petite variation de poids + kilos bonus / IncomeStepKg) x mutation x bonus de niveau
function EggConfig.GetIncome(petName, kg, mutationName, level)
	local info = EggConfig.Pets[petName]
	if not info then return 0 end
	local mutation = mutationName and EggConfig.GetMutation(mutationName)
	local weight = math.clamp(kg / info.Kg, 0.5, 1.3) + math.max(0, kg - info.Kg) / EggConfig.IncomeStepKg
	local levelBonus = 1 + ((level or 1) - 1) * EggConfig.LevelIncomeBonus
	return math.max(1, math.floor(info.Income * weight * (mutation and mutation.Mult or 1) * levelBonus + 0.5))
end

-- Taille à l'écran d'un oeuf ou d'un animal selon son poids
function EggConfig.SizeScale(kg)
	return 1 + math.min(kg, EggConfig.MaxSizeKg) / EggConfig.SizeStepKg
end

-- 0.021 -> "0.021 kg", 2.134 -> "2.13 kg", 912.4 -> "912.4 kg", 104300 -> "104.3K kg"
function EggConfig.FormatKg(kg)
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
	Halloween = ColorSequence.new({K(0, rgb(255, 120, 0)), K(0.35, rgb(255, 200, 60)), K(0.7, rgb(160, 60, 255)), K(1, rgb(255, 120, 0))}),
}

-- Jardin : 5 animaux posés au départ, +1 par agrandissement (panneau UpgradeSign de la base), jusqu'à MaxPlaced
EggConfig.BasePlaced = 5
EggConfig.GardenCosts = {1000, 10000, 100000, 1000000, 10000000}

-- Index : argent gagné (une seule fois) quand tous les animaux d'une rareté sont découverts
EggConfig.IndexRewards = {Common = 1000, Uncommon = 10000, Rare = 50000, Epic = 100000, Legendary = 1000000, Mythic = 5000000, Secret = 10000000, Halloween = 25000000}

return EggConfig
