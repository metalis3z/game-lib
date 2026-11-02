-- SecretMachineData
-- Définit tous les secrets disponibles dans la machine

local SecretMachineData = {}

-- Coût en coins pour acheter un secret (quand la free daily est épuisée)
SecretMachineData.CostPerSpin = 500

-- Liste des secrets avec leurs poids (chance relative)
-- Plus le Weight est haut, plus le secret est commun
SecretMachineData.Secrets = {
	{ Name = "Secret du Brainrot",      Emoji = "🧠", Rarity = "Common",    Weight = 40 },
	{ Name = "Secret de la Pizza",      Emoji = "🍕", Rarity = "Common",    Weight = 35 },
	{ Name = "Secret du Chat",          Emoji = "🐱", Rarity = "Uncommon",  Weight = 20 },
	{ Name = "Secret du Canard",        Emoji = "🦆", Rarity = "Uncommon",  Weight = 15 },
	{ Name = "Secret de l'Alien",       Emoji = "👽", Rarity = "Rare",      Weight = 8  },
	{ Name = "Secret du Dragon",        Emoji = "🐉", Rarity = "Rare",      Weight = 6  },
	{ Name = "Secret Cosmique",         Emoji = "🌌", Rarity = "Epic",      Weight = 3  },
	{ Name = "Secret Divin",            Emoji = "✨", Rarity = "Legendary", Weight = 1  },
}

-- Couleurs par rareté (pour affichage client)
SecretMachineData.RarityColors = {
	Common    = Color3.fromRGB(180, 180, 180),
	Uncommon  = Color3.fromRGB(100, 220, 100),
	Rare      = Color3.fromRGB(80, 120, 255),
	Epic      = Color3.fromRGB(180, 80, 255),
	Legendary = Color3.fromRGB(255, 200, 0),
}

return SecretMachineData
