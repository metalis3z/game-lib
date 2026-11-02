local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Datas = ReplicatedStorage:WaitForChild("Datas")
local LuckyBlocks = require(Datas.LuckyBlocks)

require(Datas.Rarities)

local Shared = ReplicatedStorage:WaitForChild("Shared")

require(Shared.Updates)

local t = {
	["Noobini Pizzanini"] = {
		DisplayName = "Noobini Pizzanini",
		Rarity = "Common",
		Price = 25,
		Generation = 1,
		RoadWeight = 100,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Liril\195\172 Laril\195\160"] = {
		DisplayName = "Liril\195\172 Laril\195\160",
		Rarity = "Common",
		Price = 250,
		Generation = 3,
		RoadWeight = 55,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Tim Cheese"] = {
		DisplayName = "Tim Cheese",
		Rarity = "Common",
		Price = 500,
		Generation = 5,
		RoadWeight = 50,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	Fluriflura = {
		DisplayName = "Fluriflura",
		Rarity = "Common",
		Price = 750,
		Generation = 7,
		RoadWeight = 45,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Svinina Bombardino"] = {
		DisplayName = "Svinina Bombardino",
		Rarity = "Common",
		Price = 1250,
		Generation = 10,
		RoadWeight = 40,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Talpa Di Fero"] = {
		DisplayName = "Talpa Di Fero",
		Rarity = "Common",
		Price = 1000,
		Generation = 9,
		RoadWeight = 43,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Pipi Kiwi"] = {
		DisplayName = "Pipi Kiwi",
		Rarity = "Common",
		Price = 1500,
		Generation = 13,
		RoadWeight = 37,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Pipi Corni"] = {
		DisplayName = "Pipi Corni",
		Rarity = "Common",
		Price = 1750,
		Generation = 14,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Raccooni Jandelini"] = {
		DisplayName = "Raccooni Jandelini",
		Rarity = "Common",
		Price = 1350,
		Generation = 12,
		ObtainedFrom = {
			Source = "Admin Abuse War",
			Obtainable = false
		}
	},
	Tartaragno = {
		DisplayName = "Tartaragno",
		Rarity = "Common",
		Price = 1500,
		Generation = 13,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Noobini Santanini"] = {
		DisplayName = "Noobini Santanini",
		Rarity = "Common",
		Price = 1300,
		Generation = 11,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Holy Arepa"] = {
		DisplayName = "Holy Arepa",
		Rarity = "Common",
		Price = 1750,
		Generation = 14,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Trippi Troppi"] = {
		DisplayName = "Trippi Troppi",
		Rarity = "Rare",
		Price = 2000,
		Generation = 15,
		RoadWeight = 30,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Gangster Footera"] = {
		DisplayName = "Gangster Footera",
		Rarity = "Rare",
		Price = 4000,
		Generation = 30,
		RoadWeight = 25,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
		
	},
	["Boneca Ambalabu"] = {
		DisplayName = "Boneca Ambalabu",
		Rarity = "Rare",
		Price = 5000,
		Generation = 40,
		RoadWeight = 20,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["4th Bros"] = {
		DisplayName = "4th Bros",
		Rarity = "Secret",
		Price = 800000000,
		Generation = 3750000,
		SpawnVFX = "4th of July",
		SpawnDelay = 3.5,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = true
		},
	},
	["Var Var Var"] = {
		DisplayName = "Var Var Var",
		Rarity = "Secret",
		Price = 1000000000,
		Generation = 5500000,
		SpawnVFX = "LiveSoccer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Soccer Board",
			Obtainable = true
		},
	},
	["Bufalino Boomberino"] = {
		DisplayName = "Bufalino Boomberino",
		Rarity = "Secret",
		Price = 4000000000,
		Generation = 32000000,
		SpawnVFX = "4th of July",
		SpawnDelay = 3.5,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = true
		},
	},
	["Capitano Americano"] = {
		DisplayName = "Capitano Americano",
		Rarity = "Secret",
		Price = 21000000000,
		Generation = 72500000,
		SpawnVFX = "4th of July",
		SpawnDelay = 3.5,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = true
		},
	},
	["Ta Ta Ta Ta Sahur"] = {
		DisplayName = "Ta Ta Ta Ta Sahur",
		Rarity = "Rare",
		Price = 7500,
		Generation = 55,
		RoadWeight = 17
	},
	["Tric Trac Baraboom"] = {
		DisplayName = "Tric Trac Baraboom",
		Rarity = "Rare",
		Price = 9000,
		Generation = 65,
		RoadWeight = 15,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Bandito Bobritto"] = {
		DisplayName = "Bandito Bobritto",
		Rarity = "Rare",
		Price = 4500,
		Generation = 35,
		RoadWeight = 22.5,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Cacto Hipopotamo"] = {
		DisplayName = "Cacto Hipopotamo",
		Rarity = "Rare",
		Price = 6500,
		Generation = 50,
		RoadWeight = 18.5,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Pipi Avocado"] = {
		DisplayName = "Pipi Avocado",
		Rarity = "Rare",
		Price = 9500,
		Generation = 70,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Pinealotto Fruttarino"] = {
		DisplayName = "Pinealotto Fruttarino",
		Rarity = "Rare",
		Price = 9750,
		Generation = 75,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Cupcake Koala"] = {
		DisplayName = "Cupcake Koala",
		Rarity = "Rare",
		Price = 8000,
		Generation = 60,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Frogo Elfo"] = {
		DisplayName = "Frogo Elfo",
		Rarity = "Rare",
		Price = 9250,
		Generation = 67,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Pengolino Nuvoletto"] = {
		DisplayName = "Pengolino Nuvoletto",
		Rarity = "Rare",
		Price = 9600,
		Generation = 72,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Cappuccino Assassino"] = {
		DisplayName = "Cappuccino Assassino",
		Rarity = "Epic",
		Price = 10000,
		Generation = 75,
		RoadWeight = 13,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Brr Brr Patapim"] = {
		DisplayName = "Brr Brr Patapim",
		Rarity = "Epic",
		Price = 15000,
		Generation = 100,
		RoadWeight = 10,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Trulimero Trulicina"] = {
		DisplayName = "Trulimero Trulicina",
		Rarity = "Epic",
		Price = 20000,
		Generation = 125,
		RoadWeight = 7,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Bananita Dolphinita"] = {
		DisplayName = "Bananita Dolphinita",
		Rarity = "Epic",
		Price = 25000,
		Generation = 150,
		RoadWeight = 5,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Brri Brri Bicus Dicus Bombicus"] = {
		DisplayName = "Brri Brri Bicus Dicus Bombicus",
		Rarity = "Epic",
		Price = 30000,
		Generation = 175,
		RoadWeight = 3.5,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Bambini Crostini"] = {
		DisplayName = "Bambini Crostini",
		Rarity = "Epic",
		Price = 22500,
		Generation = 135,
		RoadWeight = 6,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}

	},
	["Ref Ref Ref Sahur"] = {
		DisplayName = "Ref Ref Ref Sahur",
		Rarity = "Secret",
		Price = 650000000,
		Generation = 2750000,
		SpawnVFX = "LiveSoccer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Soccer Board",
			Obtainable = true
		},
	},
	["Hippo Golazo"] = {
		DisplayName = "Hippo Golazo",
		Rarity = "Secret",
		Price = 300000000,
		Generation = 1250000,
		SpawnVFX = "LiveSoccer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Soccer Board",
			Obtainable = true
		},
	},
	["Esok Goala"] = {
		DisplayName = "Esok Goala",
		Rarity = "Secret",
		Price = 4250000000,
		Generation = 32500000,
		SpawnVFX = "LiveSoccer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Soccer Board",
			Obtainable = true
		}
	},
	["Perochello Lemonchello"] = {
		DisplayName = "Perochello Lemonchello",
		Rarity = "Epic",
		Price = 27500,
		Generation = 160,
		RoadWeight = 4.5,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Avocadini Guffo"] = {
		DisplayName = "Avocadini Guffo",
		Rarity = "Epic",
		Price = 35000,
		Generation = 225,
		RoadWeight = 3,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Salamino Penguino"] = {
		DisplayName = "Salamino Penguino",
		Rarity = "Epic",
		Price = 40000,
		Generation = 250,
		RoadWeight = 2.5,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Ti Ti Ti Sahur"] = {
		DisplayName = "Ti Ti Ti Sahur",
		Rarity = "Epic",
		Price = 37500,
		Generation = 225,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Penguino Cocosino"] = {
		DisplayName = "Penguino Cocosino",
		Rarity = "Epic",
		Price = 45000,
		Generation = 300,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Avocadini Antilopini"] = {
		DisplayName = "Avocadini Antilopini",
		Rarity = "Epic",
		Price = 17500,
		Generation = 115,
		RoadWeight = 8.5,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Malame Amarele"] = {
		DisplayName = "Malame Amarele",
		Rarity = "Epic",
		Price = 23500,
		Generation = 140,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Mangolini Parrocini"] = {
		DisplayName = "Mangolini Parrocini",
		Rarity = "Epic",
		Price = 38500,
		Generation = 235,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Mummio Rappitto"] = {
		DisplayName = "Mummio Rappitto",
		Rarity = "Epic",
		Price = 47500,
		Generation = 325,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Frogato Pirato"] = {
		DisplayName = "Frogato Pirato",
		Rarity = "Epic",
		Price = 39000,
		Generation = 240,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Wombo Rollo"] = {
		DisplayName = "Wombo Rollo",
		Rarity = "Epic",
		Price = 42500,
		Generation = 275,
		RoadWeight = 1.75,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Doi Doi Do"] = {
		DisplayName = "Doi Doi Do",
		Rarity = "Epic",
		Price = 41000,
		Generation = 260,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Penguin Tree"] = {
		DisplayName = "Penguin Tree",
		Rarity = "Epic",
		Price = 42000,
		Generation = 270,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Gato Celesto"] = {
		DisplayName = "Gato Celesto",
		Rarity = "Epic",
		Price = 40000,
		Generation = 250,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Burbaloni Loliloli"] = {
		DisplayName = "Burbaloni Loliloli",
		Rarity = "Legendary",
		Price = 35000,
		Generation = 200,
		RoadWeight = 1,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Chimpanzini Bananini"] = {
		DisplayName = "Chimpanzini Bananini",
		Rarity = "Legendary",
		Price = 50000,
		Generation = 300,
		RoadWeight = 0.75,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Ballerina Cappuccina"] = {
		DisplayName = "Ballerina Cappuccina",
		Rarity = "Legendary",
		Price = 100000,
		Generation = 500,
		RoadWeight = 0.55,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Chef Crabracadabra"] = {
		DisplayName = "Chef Crabracadabra",
		Rarity = "Legendary",
		Price = 150000,
		Generation = 600,
		RoadWeight = 0.5,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Glorbo Fruttodrillo"] = {
		DisplayName = "Glorbo Fruttodrillo",
		Rarity = "Legendary",
		Price = 200000,
		Generation = 750,
		RoadWeight = 0.45,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Blueberrinni Octopusini"] = {
		DisplayName = "Blueberrinni Octopusini",
		Rarity = "Legendary",
		Price = 250000,
		Generation = 1000,
		RoadWeight = 0.4,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Lionel Cactuseli"] = {
		DisplayName = "Lionel Cactuseli",
		Rarity = "Legendary",
		Price = 175000,
		Generation = 650,
		RoadWeight = 0.47,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Pandaccini Bananini"] = {
		DisplayName = "Pandaccini Bananini",
		Rarity = "Legendary",
		Price = 300000,
		Generation = 1250,
		RoadWeight = 0.35,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Strawberrelli Flamingelli"] = {
		DisplayName = "Strawberrelli Flamingelli",
		Rarity = "Legendary",
		Price = 275000,
		Generation = 1150,
		RoadWeight = 0.37,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Cocosini Mama"] = {
		DisplayName = "Cocosini Mama",
		Rarity = "Legendary",
		Price = 285000,
		Generation = 1200,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Pi Pi Watermelon"] = {
		DisplayName = "Pi Pi Watermelon",
		Rarity = "Legendary",
		Price = 315000,
		Generation = 1300,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Sigma Boy"] = {
		DisplayName = "Sigma Boy",
		Rarity = "Legendary",
		Price = 325000,
		Generation = 1350,
		RoadWeight = 0.3,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Pipi Potato"] = {
		DisplayName = "Pipi Potato",
		Rarity = "Legendary",
		Price = 265000,
		Generation = 1100,
		RoadWeight = 0.385,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Quivioli Ameleonni"] = {
		DisplayName = "Quivioli Ameleonni",
		Rarity = "Legendary",
		Price = 225000,
		Generation = 900,
		RoadWeight = 0.425,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Caramello Filtrello"] = {
		DisplayName = "Caramello Filtrello",
		Rarity = "Legendary",
		Price = 255000,
		Generation = 1050,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Sigma Girl"] = {
		DisplayName = "Sigma Girl",
		Rarity = "Legendary",
		Price = 340000,
		Generation = 1800,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	Quackula = {
		DisplayName = "Quackula",
		Rarity = "Legendary",
		Price = 310000,
		Generation = 1275,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Buho de Fuego"] = {
		DisplayName = "Buho de Fuego",
		Rarity = "Legendary",
		Price = 345000,
		Generation = 1850,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Clickerino Crabo"] = {
		DisplayName = "Clickerino Crabo",
		Rarity = "Legendary",
		Price = 250000,
		Generation = 1000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	Puffaball = {
		DisplayName = "Puffaball",
		Rarity = "Legendary",
		Price = 330000,
		Generation = 1500,
		ObtainedFrom = {
			Source = "Fishing Event",
			Obtainable = false
		}
	},
	["Chocco Bunny"] = {
		DisplayName = "Chocco Bunny",
		Rarity = "Legendary",
		Price = 327500,
		Generation = 1400,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Sealo Regalo"] = {
		DisplayName = "Sealo Regalo",
		Rarity = "Legendary",
		Price = 342500,
		Generation = 1825,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Buho del Cielo"] = {
		DisplayName = "Buho del Cielo",
		Rarity = "Legendary",
		Price = 325000,
		Generation = 1350,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Seraphino Gruyero"] = {
		DisplayName = "Seraphino Gruyero",
		Rarity = "Legendary",
		Price = 347500,
		Generation = 1900,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Bandito Axolito"] = {
		DisplayName = "Bandito Axolito",
		Rarity = "Legendary",
		Price = 290000,
		Generation = 1225,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Electro Quacko"] = {
		DisplayName = "Electro Quacko",
		Rarity = "Legendary",
		Price = 345000,
		Generation = 1850,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Frigo Camelo"] = {
		DisplayName = "Frigo Camelo",
		Rarity = "Mythic",
		Price = 350000,
		Generation = 2000,
		RoadWeight = 0.2,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Orangutini Ananassini"] = {
		DisplayName = "Orangutini Ananassini",
		Rarity = "Mythic",
		Price = 400000,
		Generation = 2100,
		RoadWeight = 0.18,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Bombardiro Crocodilo"] = {
		DisplayName = "Bombardiro Crocodilo",
		Rarity = "Mythic",
		Price = 500000,
		Generation = 2500,
		RoadWeight = 0.15,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Bombombini Gusini"] = {
		DisplayName = "Bombombini Gusini",
		Rarity = "Mythic",
		Price = 1000000,
		Generation = 5000,
		RoadWeight = 0.14,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Rhino Toasterino"] = {
		DisplayName = "Rhino Toasterino",
		Rarity = "Mythic",
		Price = 450000,
		Generation = 2150,
		RoadWeight = 0.16
	},
	["Cavallo Virtuoso"] = {
		DisplayName = "Cavallo Virtuoso",
		Rarity = "Mythic",
		Price = 2500000,
		Generation = 7500,
		RoadWeight = 0.1,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Spioniro Golubiro"] = {
		DisplayName = "Spioniro Golubiro",
		Rarity = "Mythic",
		Price = 750000,
		Generation = 3500
	},
	["Zibra Zubra Zibralini"] = {
		DisplayName = "Zibra Zubra Zibralini",
		Rarity = "Mythic",
		Price = 1500000,
		Generation = 6000
	},
	["Tigrilini Watermelini"] = {
		DisplayName = "Tigrilini Watermelini",
		Rarity = "Mythic",
		Price = 1750000,
		Generation = 6500
	},
	["Gorillo Watermelondrillo"] = {
		DisplayName = "Gorillo Watermelondrillo",
		Rarity = "Mythic",
		Price = 3000000,
		Generation = 8000,
		RoadWeight = 0.08,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	Avocadorilla = {
		DisplayName = "Avocadorilla",
		Rarity = "Mythic",
		Price = 2000000,
		Generation = 7000,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Ganganzelli Trulala"] = {
		DisplayName = "Ganganzelli Trulala",
		Rarity = "Mythic",
		Price = 3750000,
		Generation = 9000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Tob Tobi Tobi"] = {
		DisplayName = "Tob Tobi Tobi",
		Rarity = "Mythic",
		Price = 3250000,
		Generation = 8500,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Te Te Te Sahur"] = {
		DisplayName = "Te Te Te Sahur",
		Rarity = "Mythic",
		Price = 4000000,
		Generation = 9500,
		RoadWeight = 0.07,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Tracoducotulu Delapeladustuz"] = {
		DisplayName = "Tracoducotulu Delapeladustuz",
		Rarity = "Mythic",
		Price = 4250000,
		Generation = 12000,
		RoadWeight = 0.06,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	Lerulerulerule = {
		DisplayName = "Lerulerulerule",
		Rarity = "Mythic",
		Price = 3500000,
		Generation = 8750,
		RoadWeight = 0.75,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	Carloo = {
		DisplayName = "Carloo",
		Rarity = "Mythic",
		Price = 4500000,
		Generation = 13500,
		IgnoreIndexCounter = true
	},
	["Carrotini Brainini"] = {
		DisplayName = "Carrotini Brainini",
		Rarity = "Mythic",
		Price = 4750000,
		Generation = 15000
	},
	["Brutto Gialutto"] = {
		DisplayName = "Brutto Gialutto",
		Rarity = "Mythic",
		Price = 600000,
		Generation = 3000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Gorillo Subwoofero"] = {
		DisplayName = "Gorillo Subwoofero",
		Rarity = "OG",
		Price = 500000000000,
		Generation = 500000000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Los Noobinis"] = {
		DisplayName = "Los Noobinis",
		Rarity = "Mythic",
		Price = 4350000,
		Generation = 12500,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Rhino Helicopterino"] = {
		DisplayName = "Rhino Helicopterino",
		Rarity = "Mythic",
		Price = 4100000,
		Generation = 11000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Toiletto Focaccino"] = {
		DisplayName = "Toiletto Focaccino",
		Rarity = "Mythic",
		Price = 4850000,
		Generation = 16000,
		RoadWeight = 0.05,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Cachorrito Melonito"] = {
		DisplayName = "Cachorrito Melonito",
		Rarity = "Mythic",
		Price = 4400000,
		Generation = 13000,
		RoadWeight = 0.055,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Bananito Bandito"] = {
		DisplayName = "Bananito Bandito",
		Rarity = "Mythic",
		Price = 4900000,
		Generation = 16500
	},
	["Magi Ribbitini"] = {
		DisplayName = "Magi Ribbitini",
		Rarity = "Mythic",
		Price = 4200000,
		Generation = 11500,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Jacko Spaventosa"] = {
		DisplayName = "Jacko Spaventosa",
		Rarity = "Mythic",
		Price = 4875000,
		Generation = 16250,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Stoppo Luminino"] = {
		DisplayName = "Stoppo Luminino",
		Rarity = "Mythic",
		Price = 3000000,
		Generation = 8000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Centrucci Nuclucci"] = {
		DisplayName = "Centrucci Nuclucci",
		Rarity = "Mythic",
		Price = 4800000,
		Generation = 15500,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Jingle Jingle Sahur"] = {
		DisplayName = "Jingle Jingle Sahur",
		Rarity = "Mythic",
		Price = 4300000,
		Generation = 12250,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Tree Tree Tree Sahur"] = {
		DisplayName = "Tree Tree Tree Sahur",
		Rarity = "Mythic",
		Price = 4950000,
		Generation = 17000,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Spongini Quackini"] = {
		DisplayName = "Spongini Quackini",
		Rarity = "Mythic",
		Price = 4400000,
		Generation = 13000,
		ObtainedFrom = {
			Source = "OG Fuse",
			Obtainable = false
		}
	},
	["Fizzy Soda"] = {
		DisplayName = "Fizzy Soda",
		Rarity = "Mythic",
		Price = 4975000,
		Generation = 17250,
		ObtainedFrom = {
			Source = "OG Fuse",
			Obtainable = false
		}
	},
	Harpuccino = {
		DisplayName = "Harpuccino",
		Rarity = "Mythic",
		Price = 4650000,
		Generation = 14000,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Berenjello Angello"] = {
		DisplayName = "Berenjello Angello",
		Rarity = "Mythic",
		Price = 5500000,
		Generation = 18000,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Bee Loco"] = {
		DisplayName = "Bee Loco",
		Rarity = "Mythic",
		Price = 4500000,
		Generation = 13500,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Orbi Mochi"] = {
		DisplayName = "Orbi Mochi",
		Rarity = "Mythic",
		Price = 6000000,
		Generation = 18500,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	Cocoteddy = {
		DisplayName = "Cocoteddy",
		Rarity = "Mythic",
		Price = 4750000,
		Generation = 15000,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	Bucketoro = {
		DisplayName = "Bucketoro",
		Rarity = "Mythic",
		Price = 5750000,
		Generation = 18250,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Chihuanini Taconini"] = {
		DisplayName = "Chihuanini Taconini",
		Rarity = "Brainrot God",
		Price = 8500000,
		Generation = 45000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Taco",
		SpawnDelay = 3
	},
	["Cocofanto Elefanto"] = {
		DisplayName = "Cocofanto Elefanto",
		Rarity = "Brainrot God",
		Price = 6500000,
		Generation = 19000,
		RoadWeight = 0.05,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Tralalero Tralala"] = {
		DisplayName = "Tralalero Tralala",
		Rarity = "Brainrot God",
		Price = 10000000,
		Generation = 50000,
		RoadWeight = 0.01,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Odin Din Din Dun"] = {
		DisplayName = "Odin Din Din Dun",
		Rarity = "Brainrot God",
		Price = 15000000,
		Generation = 75000,
		RoadWeight = 0.007
	},
	["Girafa Celestre"] = {
		DisplayName = "Girafa Celestre",
		Rarity = "Brainrot God",
		Price = 7500000,
		Generation = 20000,
		RoadWeight = 0.03,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Trenostruzzo Turbo 3000"] = {
		DisplayName = "Trenostruzzo Turbo 3000",
		Rarity = "Brainrot God",
		Price = 25000000,
		Generation = 150000,
		RoadWeight = 0.005,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	Matteo = {
		DisplayName = "Matteo",
		Rarity = "Brainrot God",
		Price = 10000000,
		Generation = 50000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Matteo",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	["Tigroligre Frutonni"] = {
		DisplayName = "Tigroligre Frutonni",
		Rarity = "Brainrot God",
		Price = 14000000,
		Generation = 60000
	},
	["Orcalero Orcala"] = {
		DisplayName = "Orcalero Orcala",
		Rarity = "Brainrot God",
		Price = 25000000,
		Generation = 100000
	},
	["Unclito Samito"] = {
		DisplayName = "Unclito Samito",
		Rarity = "Brainrot God",
		Price = 20000000,
		Generation = 75000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	["Gattatino Nyanino"] = {
		DisplayName = "Gattatino Nyanino",
		Rarity = "Brainrot God",
		Price = 7500000,
		Generation = 35000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Gattatino Nyanino",
		SpawnDelay = 9,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	["Espresso Signora"] = {
		DisplayName = "Espresso Signora",
		Rarity = "Brainrot God",
		Price = 25000000,
		Generation = 70000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	["Ballerino Lololo"] = {
		DisplayName = "Ballerino Lololo",
		Rarity = "Brainrot God",
		Price = 35000000,
		Generation = 200000,
		RoadWeight = 0.0001,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Piccione Macchina"] = {
		DisplayName = "Piccione Macchina",
		Rarity = "Brainrot God",
		Price = 40000000,
		Generation = 225000,
		RoadWeight = 0.0008,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Los Crocodillitos"] = {
		DisplayName = "Los Crocodillitos",
		Rarity = "Brainrot God",
		Price = 12500000,
		Generation = 55000,
		ObtainedFrom = {
			Source = "Bombardiro Event",
			Obtainable = false
		}
	},
	["Los Crocodillitos"] = {
		DisplayName = "Los Crocodillitos",
		Rarity = "Brainrot God",
		Price = 12500000,
		Generation = 55000,
		ObtainedFrom = {
			Source = "Bombardiro Event",
			Obtainable = false
		}
	},
	["Tukanno Bananno"] = {
		DisplayName = "Tukanno Bananno",
		Rarity = "Brainrot God",
		Price = 22500000,
		Generation = 100000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Trippi Troppi Troppa Trippa"] = {
		DisplayName = "Trippi Troppi Troppa Trippa",
		Rarity = "Brainrot God",
		Price = 30000000,
		Generation = 175000,
		RoadWeight = 0.0035,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Los Tungtungtungcitos"] = {
		DisplayName = "Los Tungtungtungcitos",
		Rarity = "Brainrot God",
		Price = 37500000,
		Generation = 210000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Bulbito Bandito Traktorito"] = {
		DisplayName = "Bulbito Bandito Traktorito",
		Rarity = "Brainrot God",
		Price = 35000000,
		Generation = 205000,
		IgnoreIndexCounter = true
	},
	["Los Orcalitos"] = {
		DisplayName = "Los Orcalitos",
		Rarity = "Brainrot God",
		Price = 45000000,
		Generation = 235000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Tipi Topi Taco"] = {
		DisplayName = "Tipi Topi Taco",
		Rarity = "Brainrot God",
		Price = 20000000,
		Generation = 75000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Taco Event",
			Obtainable = false
		}
	},
	["Bombardini Tortinii"] = {
		DisplayName = "Bombardini Tortinii",
		Rarity = "Brainrot God",
		Price = 50000000,
		Generation = 225000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Taco",
		SpawnDelay = 3
	},
	["Tralalita Tralala"] = {
		DisplayName = "Tralalita Tralala",
		Rarity = "Brainrot God",
		Price = 20000000,
		Generation = 100000,
		RoadWeight = 0.006,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Urubini Flamenguini"] = {
		DisplayName = "Urubini Flamenguini",
		Rarity = "Brainrot God",
		Price = 30000000,
		Generation = 150000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	Alessio = {
		DisplayName = "Alessio",
		Rarity = "Brainrot God",
		Price = 17500000,
		Generation = 85000,
		IgnoreIndexCounter = true
	},
	Pakrahmatmamat = {
		DisplayName = "Pakrahmatmamat",
		Rarity = "Brainrot God",
		Price = 37500000,
		Generation = 215000,
		RoadWeight = 0.0009,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Los Bombinitos"] = {
		DisplayName = "Los Bombinitos",
		Rarity = "Brainrot God",
		Price = 42500000,
		Generation = 220000,
		IgnoreIndexCounter = true
	},
	["Brr es Teh Patipum"] = {
		DisplayName = "Brr es Teh Patipum",
		Rarity = "Brainrot God",
		Price = 40000000,
		Generation = 225000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Tartaruga Cisterna"] = {
		DisplayName = "Tartaruga Cisterna",
		Rarity = "Brainrot God",
		Price = 45000000,
		Generation = 250000,
		ObtainedFrom = {
			Source = "This is obtained from Sammy\'s Base",
			Obtainable = false,
			FullText = true
		}
	},
	["Cacasito Satalito"] = {
		DisplayName = "Cacasito Satalito",
		Rarity = "Brainrot God",
		Price = 45000000,
		Generation = 240000,
		RoadWeight = 0.0006,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Mastodontico Telepiedone"] = {
		DisplayName = "Mastodontico Telepiedone",
		Rarity = "Brainrot God",
		Price = 47500000,
		Generation = 275000
	},
	["Crabbo Limonetta"] = {
		DisplayName = "Crabbo Limonetta",
		Rarity = "Brainrot God",
		Price = 46000000,
		Generation = 235000,
		IgnoreIndexCounter = true
	},
	["Gattito Tacoto"] = {
		DisplayName = "Gattito Tacoto",
		Rarity = "Brainrot God",
		Price = 32500000,
		Generation = 165000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Taco",
		SpawnDelay = 3
	},
	["Los Tipi Tacos"] = {
		DisplayName = "Los Tipi Tacos",
		Rarity = "Brainrot God",
		Price = 46000000,
		Generation = 260000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Taco",
		SpawnDelay = 3
	},
	["Las Capuchinas"] = {
		DisplayName = "Las Capuchinas",
		Rarity = "Brainrot God",
		Price = 32500000,
		Generation = 185000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Orcalita Orcala"] = {
		DisplayName = "Orcalita Orcala",
		Rarity = "Brainrot God",
		Price = 45000000,
		Generation = 240000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Piccionetta Macchina"] = {
		DisplayName = "Piccionetta Macchina",
		Rarity = "Brainrot God",
		Price = 47000000,
		Generation = 270000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Anpali Babel"] = {
		DisplayName = "Anpali Babel",
		Rarity = "Brainrot God",
		Price = 48000000,
		Generation = 280000,
		ObtainedFrom = {
			Source = "This was obtained from the Craft Machine",
			Obtainable = false,
			FullText = true
		}
	},
	["Extinct Ballerina"] = {
		DisplayName = "Extinct Ballerina",
		Rarity = "Brainrot God",
		Price = 23500000,
		Generation = 125000,
		SpawnVFX = "Extinct",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Extinct Event",
			Obtainable = false
		}
	},
	["Tractoro Dinosauro"] = {
		DisplayName = "Tractoro Dinosauro",
		Rarity = "Brainrot God",
		Price = 42500000,
		Generation = 230000,
		RoadWeight = 0.00065,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Belula Beluga"] = {
		DisplayName = "Belula Beluga",
		Rarity = "Brainrot God",
		Price = 60000000,
		Generation = 290000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Capi Taco"] = {
		DisplayName = "Capi Taco",
		Rarity = "Brainrot God",
		Price = 31000000,
		Generation = 155000,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Taco Event",
			Obtainable = false
		}
	},
	["Corn Corn Corn Sahur"] = {
		DisplayName = "Corn Corn Corn Sahur",
		Rarity = "Brainrot God",
		Price = 45000000,
		Generation = 250000,
		ObtainedFrom = {
			Source = "The Pi\195\177ata",
			Obtainable = false
		}
	},
	["Brasilini Berimbini"] = {
		DisplayName = "Brasilini Berimbini",
		Rarity = "Brainrot God",
		Price = 55000000,
		Generation = 285000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	Squalanana = {
		DisplayName = "Squalanana",
		Rarity = "Brainrot God",
		Price = 45000000,
		Generation = 250000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Pop Pop Sahur"] = {
		DisplayName = "Pop Pop Sahur",
		Rarity = "Brainrot God",
		Price = 65000000,
		Generation = 295000
	},
	["Vampira Cappucina"] = {
		DisplayName = "Vampira Cappucina",
		Rarity = "Brainrot God",
		Price = 24500000,
		Generation = 125000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Witching Hour",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Halloween Event",
			Obtainable = false
		}
	},
	["Jacko Jack Jack"] = {
		DisplayName = "Jacko Jack Jack",
		Rarity = "Brainrot God",
		Price = 30000000,
		Generation = 150000,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	Snailenzo = {
		DisplayName = "Snailenzo",
		Rarity = "Brainrot God",
		Price = 45000000,
		Generation = 250000,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Tentacolo Tecnico"] = {
		DisplayName = "Tentacolo Tecnico",
		Rarity = "Brainrot God",
		Price = 62500000,
		Generation = 292500,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	Pakrahmatmatina = {
		DisplayName = "Pakrahmatmatina",
		Rarity = "Brainrot God",
		Price = 40500000,
		Generation = 225000,
		ObtainedFrom = {
			Source = "Pole Game",
			Obtainable = false
		}
	},
	["Bambu Bambu Sahur"] = {
		DisplayName = "Bambu Bambu Sahur",
		Rarity = "Brainrot God",
		Price = 47500000,
		Generation = 275000,
		ObtainedFrom = {
			Source = "Indonesia Event",
			Obtainable = false
		}
	},
	["Krupuk Pagi Pagi"] = {
		DisplayName = "Krupuk Pagi Pagi",
		Rarity = "Brainrot God",
		Price = 60000000,
		Generation = 290000,
		ObtainedFrom = {
			Source = "Indonesia Event",
			Obtainable = false
		}
	},
	["Mummy Ambalabu"] = {
		DisplayName = "Mummy Ambalabu",
		Rarity = "Brainrot God",
		Price = 45000000,
		Generation = 250000
	},
	["Cappuccino Clownino"] = {
		DisplayName = "Cappuccino Clownino",
		Rarity = "Brainrot God",
		Price = 48500000,
		Generation = 285000
	},
	["Skull Skull Skull"] = {
		DisplayName = "Skull Skull Skull",
		Rarity = "Brainrot God",
		Price = 60000000,
		Generation = 290000,
		ObtainedFrom = {
			Source = "Halloween Event",
			Obtainable = false
		}
	},
	Aquanaut = {
		DisplayName = "Aquanaut",
		Rarity = "Brainrot God",
		Price = 45500000,
		Generation = 245000,
		RoadWeight = 0.00055,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Frio Ninja"] = {
		DisplayName = "Frio Ninja",
		Rarity = "Brainrot God",
		Price = 46500000,
		Generation = 265000,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Money Money Man"] = {
		DisplayName = "Money Money Man",
		Rarity = "OG",
		Price = 550000000000,
		Generation = 550000000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Noo La Polizia"] = {
		DisplayName = "Noo La Polizia",
		Rarity = "Brainrot God",
		Price = 67000000,
		Generation = 280000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Los Chihuaninis"] = {
		DisplayName = "Los Chihuaninis",
		Rarity = "Brainrot God",
		Price = 32000000,
		Generation = 160000
	},
	["Los Gattitos"] = {
		DisplayName = "Los Gattitos",
		Rarity = "Brainrot God",
		Price = 47500000,
		Generation = 275000
	},
	["Granchiello Spiritell"] = {
		DisplayName = "Granchiello Spiritell",
		Rarity = "Brainrot God",
		Price = 46000000,
		Generation = 260000,
		ObtainedFrom = {
			Source = "Fishing Event",
			Obtainable = false
		}
	},
	["Ballerina Peppermintina"] = {
		DisplayName = "Ballerina Peppermintina",
		Rarity = "Brainrot God",
		Price = 37500000,
		Generation = 215000,
		SpawnVFX = "Winter Hour",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Advent/Winter Hour",
			Obtainable = false
		}
	},
	["Ginger Globo"] = {
		DisplayName = "Ginger Globo",
		Rarity = "Brainrot God",
		Price = 45750000,
		Generation = 257500,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Ginger Cisterna"] = {
		DisplayName = "Ginger Cisterna",
		Rarity = "Brainrot God",
		Price = 63500000,
		Generation = 293500,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Yeti Claus"] = {
		DisplayName = "Yeti Claus",
		Rarity = "Brainrot God",
		Price = 45750000,
		Generation = 257500,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Buho de Noelo"] = {
		DisplayName = "Buho de Noelo",
		Rarity = "Brainrot God",
		Price = 46750000,
		Generation = 267500,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	Chrismasmamat = {
		DisplayName = "Chrismasmamat",
		Rarity = "Brainrot God",
		Price = 47750000,
		Generation = 277500
	},
	["Cocoa Assassino"] = {
		DisplayName = "Cocoa Assassino",
		Rarity = "Brainrot God",
		Price = 61000000,
		Generation = 291000,
		ObtainedFrom = {
			Source = "Christmas Event",
			Obtainable = false
		}
	},
	["Pandanini Frostini"] = {
		DisplayName = "Pandanini Frostini",
		Rarity = "Brainrot God",
		Price = 64000000,
		Generation = 294000
	},
	["Tootini Shrimpini"] = {
		DisplayName = "Tootini Shrimpini",
		Rarity = "Brainrot God",
		Price = 46000000,
		Generation = 260000,
		SpawnVFX = "New Years 2026",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "New Year\'s Event",
			Obtainable = false
		}
	},
	["Boba Panda"] = {
		DisplayName = "Boba Panda",
		Rarity = "Brainrot God",
		Price = 47000000,
		Generation = 270000,
		ObtainedFrom = {
			Source = "OG Fuse",
			Obtainable = false
		}
	},
	["Dolphini Jetskini"] = {
		DisplayName = "Dolphini Jetskini",
		Rarity = "Brainrot God",
		Price = 64500000,
		Generation = 294500,
		ObtainedFrom = {
			Source = "OG Fuse",
			Obtainable = false
		}
	},
	["Luv Luv Luv"] = {
		DisplayName = "Luv Luv Luv",
		Rarity = "Brainrot God",
		Price = 48250000,
		Generation = 282500,
		SpawnVFX = "Valentines",
		SpawnDelay = 3
	},
	["Karkerheart Luvkur"] = {
		DisplayName = "Karkerheart Luvkur",
		Rarity = "Brainrot God",
		Price = 67500000,
		Generation = 297500,
		SpawnVFX = "Valentines",
		SpawnDelay = 3
	},
	["Divino Platypio"] = {
		DisplayName = "Divino Platypio",
		Rarity = "Brainrot God",
		Price = 32000000,
		Generation = 160000,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Astrolero Cervalero"] = {
		DisplayName = "Astrolero Cervalero",
		Rarity = "Brainrot God",
		Price = 48000000,
		Generation = 280000,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Dumborino Miracello"] = {
		DisplayName = "Dumborino Miracello",
		Rarity = "Brainrot God",
		Price = 75000000,
		Generation = 315000,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	Patteo = {
		DisplayName = "Patteo",
		Rarity = "Brainrot God",
		Price = 57500000,
		Generation = 287500,
		SpawnVFX = "Clover",
		SpawnDelay = 3
	},
	["Clovkur Kurkur"] = {
		DisplayName = "Clovkur Kurkur",
		Rarity = "Brainrot God",
		Price = 70000000,
		Generation = 305000,
		SpawnVFX = "Clover",
		SpawnDelay = 3
	},
	["Bunny Tralala"] = {
		DisplayName = "Bunny Tralala",
		Rarity = "Brainrot God",
		Price = 47000000,
		Generation = 270000,
		SpawnVFX = "Easter",
		SpawnDelay = 3
	},
	["Eggdin Egg Egg Dun"] = {
		DisplayName = "Eggdin Egg Egg Dun",
		Rarity = "Brainrot God",
		Price = 72500000,
		Generation = 310000,
		SpawnVFX = "Easter",
		SpawnDelay = 3
	},
	Pineaplino = {
		DisplayName = "Pineaplino",
		Rarity = "Brainrot God",
		Price = 35000000,
		Generation = 200000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "DLC Code",
			Obtainable = false
		}
	},
	["Lazy Ducky"] = {
		DisplayName = "Lazy Ducky",
		Rarity = "Brainrot God",
		Price = 45500000,
		Generation = 255000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "DLC Code",
			Obtainable = false
		}
	},
	["Cola Cat"] = {
		DisplayName = "Cola Cat",
		Rarity = "Brainrot God",
		Price = 47500000,
		Generation = 275000,
		IgnoreIndexCounter = true,
		HideFromIndex = true,
		ObtainedFrom = {
			Source = "DLC Code",
			Obtainable = false
		},
		IsEnabled = function() --[[ IsEnabled | Line: 1710 ]]
			return false
		end
	},
	["Tenini Ballini"] = {
		DisplayName = "Tenini Ballini",
		Rarity = "Brainrot God",
		Price = 69000000,
		Generation = 300000,
		IgnoreIndexCounter = true,
		HideFromIndex = true,
		ObtainedFrom = {
			Source = "DLC Code",
			Obtainable = false
		},
		IsEnabled = function() --[[ IsEnabled | Line: 1723 ]]
			return false
		end
	},
	Appelini = {
		DisplayName = "Appelini",
		Rarity = "Brainrot God",
		Price = 69000000,
		Generation = 300000,
		RoadWeight = 0.0004,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Trenotubo Axolotrico 9000"] = {
		DisplayName = "Trenotubo Axolotrico 9000",
		Rarity = "Brainrot God",
		Price = 45500000,
		Generation = 255000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Pretzo Robo"] = {
		DisplayName = "Pretzo Robo",
		Rarity = "Brainrot God",
		Price = 77000000,
		Generation = 320000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Lumaca Malefica"] = {
		DisplayName = "Lumaca Malefica",
		Rarity = "Brainrot God",
		Price = 46500000,
		Generation = 265000,
		ObtainedFrom = {
			Source = "Backrooms Event",
			Obtainable = false
		}
	},
	["Robo Grafito"] = {
		DisplayName = "Robo Grafito",
		Rarity = "Brainrot God",
		Price = 76000000,
		Generation = 317500,
		ObtainedFrom = {
			Source = "Backrooms Event",
			Obtainable = false
		}
	},
	["Sundrilla Sundae"] = {
		DisplayName = "Sundrilla Sundae",
		Rarity = "Brainrot God",
		Price = 31000000,
		Generation = 180000,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Lemonita Splashita"] = {
		DisplayName = "Lemonita Splashita",
		Rarity = "Brainrot God",
		Price = 48000000,
		Generation = 280000,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Flippo Marino"] = {
		DisplayName = "Flippo Marino",
		Rarity = "Brainrot God",
		Price = 75500000,
		Generation = 316000,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Tortuginni Sandcastlini"] = {
		DisplayName = "Tortuginni Sandcastlini",
		Rarity = "Brainrot God",
		Price = 76000000,
		Generation = 317500,
		SpawnVFX = "Summer",
		SpawnDelay = 3
	},
	["La Vacca Saturno Saturnita"] = {
		DisplayName = "La Vacca Saturno Saturnita",
		Rarity = "Secret",
		Price = 80000000,
		Generation = 325000,
		RoadWeight = 0.0003,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Los Tralaleritos"] = {
		DisplayName = "Los Tralaleritos",
		Rarity = "Secret",
		Price = 100000000,
		Generation = 500000,
		RoadWeight = 0.0001,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Graipuss Medussi"] = {
		DisplayName = "Graipuss Medussi",
		Rarity = "Secret",
		Price = 250000000,
		Generation = 1000000,
		RoadWeight = 1e-6,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["La Grande Combinasion"] = {
		DisplayName = "La Grande Combinasion",
		Rarity = "Secret",
		OverheadYOffsetModifier = 0.8,
		Price = 1000000000,
		Generation = 10000000,
		RoadWeight = 1e-8,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Sammyni Spyderini"] = {
		DisplayName = "Sammyni Spyderini",
		Rarity = "Secret",
		Price = 75000000,
		Generation = 325000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Los Spyderinis",
		SpawnDelay = 3.5
	},
	["Garama and Madundung"] = {
		DisplayName = "Garama and Madundung",
		Rarity = "Secret",
		Price = 10000000000,
		Generation = 50000000,
		RoadWeight = 1e-10,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Torrtuginni Dragonfrutini"] = {
		DisplayName = "Torrtuginni Dragonfrutini",
		Rarity = "Secret",
		Price = 125000000,
		Generation = 350000
	},
	["Las Tralaleritas"] = {
		DisplayName = "Las Tralaleritas",
		Rarity = "Secret",
		Price = 150000000,
		Generation = 650000,
		RoadWeight = 0.00007,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Pot Hotspot"] = {
		DisplayName = "Pot Hotspot",
		Rarity = "Secret",
		Price = 600000000,
		Generation = 2500000
	},
	["Nuclearo Dinossauro"] = {
		DisplayName = "Nuclearo Dinossauro",
		Rarity = "Secret",
		Price = 2500000000,
		Generation = 15000000,
		RoadWeight = 1e-10,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Las Vaquitas Saturnitas"] = {
		DisplayName = "Las Vaquitas Saturnitas",
		Rarity = "Secret",
		Price = 200000000,
		Generation = 750000,
		ObtainedFrom = {
			Source = "La Vacca Ritual",
			Obtainable = false
		}
	},
	["Chicleteira Bicicleteira"] = {
		DisplayName = "Chicleteira Bicicleteira",
		Rarity = "Secret",
		Price = 750000000,
		Generation = 3500000,
		RoadWeight = 1e-7,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Agarrini la Palini"] = {
		DisplayName = "Agarrini la Palini",
		Rarity = "Secret",
		Price = 80000000,
		Generation = 425000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Los Combinasionas"] = {
		DisplayName = "Los Combinasionas",
		Rarity = "Secret",
		Price = 2000000000,
		Generation = 15000000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Karkerkar Kurkur"] = {
		DisplayName = "Karkerkar Kurkur",
		Rarity = "Secret",
		Price = 80000000,
		Generation = 325000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Karkerkar Kurkur",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	["Dragon Cannelloni"] = {
		DisplayName = "Dragon Cannelloni",
		Rarity = "Secret",
		Price = 250000000000,
		Generation = 250000000,
		RoadWeight = 1e-14,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Los Hotspotsitos"] = {
		DisplayName = "Los Hotspotsitos",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 20000000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Esok Sekolah"] = {
		DisplayName = "Esok Sekolah",
		Rarity = "Secret",
		Price = 3500000000,
		Generation = 30000000,
		IgnoreIndexCounter = true
	},
	["Nooo My Hotspot"] = {
		DisplayName = "Nooo My Hotspot",
		Rarity = "Secret",
		Price = 500000000,
		Generation = 1500000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Taco Event",
			Obtainable = false
		}
	},
	["Los Matteos"] = {
		DisplayName = "Los Matteos",
		Rarity = "Secret",
		Price = 80000000,
		Generation = 325000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Matteo",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Matteo Ritual",
			Obtainable = false
		}
	},
	["Job Job Job Sahur"] = {
		DisplayName = "Job Job Job Sahur",
		Rarity = "Secret",
		Price = 175000000,
		Generation = 700000,
		RoadWeight = 5e-6,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Dul Dul Dul"] = {
		DisplayName = "Dul Dul Dul",
		Rarity = "Secret",
		Price = 150000000,
		Generation = 375000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	["Blackhole Goat"] = {
		DisplayName = "Blackhole Goat",
		Rarity = "Secret",
		Price = 75000000,
		Generation = 400000,
		IgnoreIndexCounter = true
	},
	["Los Spyderinis"] = {
		DisplayName = "Los Spyderinis",
		Rarity = "Secret",
		Price = 125000000,
		Generation = 425000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Los Spyderinis",
		SpawnDelay = 3.5,
		ObtainedFrom = {
			Source = "Spyderini Ritual",
			Obtainable = false
		}
	},
	["Ketupat Kepat"] = {
		DisplayName = "Ketupat Kepat",
		Rarity = "Secret",
		Price = 5000000000,
		Generation = 35000000,
		RoadWeight = 5e-11,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["La Supreme Combinasion"] = {
		DisplayName = "La Supreme Combinasion",
		Rarity = "Secret",
		Price = 200000000000,
		Generation = 200000000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Bisonte Giuppitere"] = {
		DisplayName = "Bisonte Giuppitere",
		Rarity = "Secret",
		Price = 80000000,
		Generation = 325000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "This is obtained from Sammy\'s Base",
			Obtainable = false,
			FullText = true
		}
	},
	["Guerriro Digitale"] = {
		DisplayName = "Guerriro Digitale",
		Rarity = "Secret",
		Price = 120000000,
		Generation = 550000,
		IgnoreIndexCounter = true
	},
	["Ketchuru and Musturu"] = {
		DisplayName = "Ketchuru and Musturu",
		Rarity = "Secret",
		Price = 7500000000,
		Generation = 42500000,
		RoadWeight = 2.5e-11,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Spaghetti Tualetti"] = {
		DisplayName = "Spaghetti Tualetti",
		Rarity = "Secret",
		Price = 15000000000,
		Generation = 60000000
	},
	["Los Nooo My Hotspotsitos"] = {
		DisplayName = "Los Nooo My Hotspotsitos",
		Rarity = "Secret",
		Price = 1000000000,
		Generation = 5500000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Taco",
		SpawnDelay = 3
	},
	["Trenostruzzo Turbo 4000"] = {
		DisplayName = "Trenostruzzo Turbo 4000",
		Rarity = "Secret",
		Price = 90000000,
		Generation = 335000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Fragola La La La"] = {
		DisplayName = "Fragola La La La",
		Rarity = "Secret",
		Price = 4250000000,
		Generation = 32500000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["La Sahur Combinasion"] = {
		DisplayName = "La Sahur Combinasion",
		Rarity = "Secret",
		Price = 550000000,
		Generation = 2000000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["La Karkerkar Combinasion"] = {
		DisplayName = "La Karkerkar Combinasion",
		Rarity = "Secret",
		Price = 160000000,
		Generation = 600000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	Tralaledon = {
		DisplayName = "Tralaledon",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 27500000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Los Bros"] = {
		DisplayName = "Los Bros",
		Rarity = "Secret",
		Price = 2600000000,
		Generation = 24000000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Los Chicleteiras"] = {
		DisplayName = "Los Chicleteiras",
		Rarity = "Secret",
		Price = 1200000000,
		Generation = 7000000,
		SpawnVFX = "Los Chicleteiras",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Chicleteira Ritual",
			Obtainable = false
		}
	},
	Chachechi = {
		DisplayName = "Chachechi",
		Rarity = "Secret",
		Price = 85000000,
		Generation = 400000,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	["Extinct Tralalero"] = {
		DisplayName = "Extinct Tralalero",
		Rarity = "Secret",
		Price = 125000000,
		Generation = 450000,
		SpawnVFX = "Extinct",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Extinct Event",
			Obtainable = false
		}
	},
	["Extinct Matteo"] = {
		DisplayName = "Extinct Matteo",
		Rarity = "Secret",
		Price = 162500000,
		Generation = 625000,
		SpawnVFX = "Extinct",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Extinct Event",
			Obtainable = false
		}
	},
	["67"] = {
		DisplayName = "67",
		Rarity = "Secret",
		Price = 1250000000,
		Generation = 7500000
	},
	["Las Sis"] = {
		DisplayName = "Las Sis",
		Rarity = "Secret",
		Price = 2500000000,
		Generation = 17500000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Celularcini Viciosini"] = {
		DisplayName = "Celularcini Viciosini",
		Rarity = "Secret",
		Price = 2750000000,
		Generation = 22500000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["La Extinct Grande"] = {
		DisplayName = "La Extinct Grande",
		Rarity = "Secret",
		Price = 3250000000,
		Generation = 23500000,
		SpawnVFX = "Extinct",
		SpawnDelay = 3,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "Extinct Event",
			Obtainable = false
		}
	},
	["Quesadilla Crocodila"] = {
		DisplayName = "Quesadilla Crocodila",
		Rarity = "Secret",
		Price = 700000000,
		Generation = 3000000,
		SpawnVFX = "Taco",
		SpawnDelay = 3
	},
	["Tacorita Bicicleta"] = {
		DisplayName = "Tacorita Bicicleta",
		Rarity = "Secret",
		Price = 2250000000,
		Generation = 16500000,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Taco Event",
			Obtainable = false
		}
	},
	["La Cucaracha"] = {
		DisplayName = "La Cucaracha",
		Rarity = "Secret",
		Price = 110000000,
		Generation = 475000,
		SpawnVFX = "Mexico",
		SpawnDelay = 3.5,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	["To to to Sahur"] = {
		DisplayName = "To to to Sahur",
		Rarity = "Secret",
		Price = 575000000,
		Generation = 2250000,
		RoadWeight = 5e-7,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Mariachi Corazoni"] = {
		DisplayName = "Mariachi Corazoni",
		Rarity = "Secret",
		Price = 1750000000,
		Generation = 12500000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "The Pi\195\177ata",
			Obtainable = false
		}
	},
	["Los Tacoritas"] = {
		DisplayName = "Los Tacoritas",
		Rarity = "Secret",
		Price = 4000000000,
		Generation = 32000000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Tictac Sahur"] = {
		DisplayName = "Tictac Sahur",
		Rarity = "Secret",
		Price = 6000000000,
		Generation = 37500000,
		RoadWeight = 3.5e-11,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Yess my examine"] = {
		DisplayName = "Yess my examine",
		Rarity = "Secret",
		Price = 130000000,
		Generation = 575000,
		ObtainedFrom = {
			Source = "Dul Dul Ritual",
			Obtainable = false
		}
	},
	["Karker Sahur"] = {
		DisplayName = "Karker Sahur",
		Rarity = "Secret",
		Price = 185000000,
		Generation = 725000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Noo my examine"] = {
		DisplayName = "Noo my examine",
		Rarity = "Secret",
		Price = 525000000,
		Generation = 1750000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "Dul Dul Ritual",
			Obtainable = false
		}
	},
	["Money Money Puggy"] = {
		DisplayName = "Money Money Puggy",
		Rarity = "Secret",
		Price = 2600000000,
		Generation = 21000000,
		RoadWeight = 5e-10,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Los Primos"] = {
		DisplayName = "Los Primos",
		Rarity = "Secret",
		Price = 3750000000,
		Generation = 31000000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Tang Tang Keletang"] = {
		DisplayName = "Tang Tang Keletang",
		Rarity = "Secret",
		Price = 4500000000,
		Generation = 33500000,
		RoadWeight = 7.5e-11,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Perrito Burrito"] = {
		DisplayName = "Perrito Burrito",
		Rarity = "Secret",
		Price = 250000000,
		Generation = 1000000,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["Chillin Chili"] = {
		DisplayName = "Chillin Chili",
		Rarity = "Secret",
		Price = 2500000000,
		Generation = 25000000,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["Los Tortus"] = {
		DisplayName = "Los Tortus",
		Rarity = "Secret",
		Price = 100000000,
		Generation = 500000
	},
	["Los Karkeritos"] = {
		DisplayName = "Los Karkeritos",
		Rarity = "Secret",
		Price = 200000000,
		Generation = 750000,
		SpawnVFX = "Karkerkar Kurkur",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Karker Ritual",
			Obtainable = false
		}
	},
	["Los Jobcitos"] = {
		DisplayName = "Los Jobcitos",
		Rarity = "Secret",
		Price = 500000000,
		Generation = 1500000
	},
	["Los 67"] = {
		DisplayName = "Los 67",
		Rarity = "Secret",
		Price = 2750000000,
		Generation = 22500000
	},
	["La Secret Combinasion"] = {
		DisplayName = "La Secret Combinasion",
		Rarity = "Secret",
		Price = 50000000000,
		Generation = 125000000
	},
	["Burguro And Fryuro"] = {
		DisplayName = "Burguro And Fryuro",
		Rarity = "Secret",
		Price = 75000000000,
		Generation = 150000000,
		RoadWeight = 2e-13
	},
	["Zombie Tralala"] = {
		DisplayName = "Zombie Tralala",
		Rarity = "Secret",
		Price = 100000000,
		Generation = 500000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Witching Hour",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Halloween Event",
			Obtainable = false
		}
	},
	["Vulturino Skeletono"] = {
		DisplayName = "Vulturino Skeletono",
		Rarity = "Secret",
		Price = 110000000,
		Generation = 500000,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	Frankentteo = {
		DisplayName = "Frankentteo",
		Rarity = "Secret",
		Price = 175000000,
		Generation = 700000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Witching Hour",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Halloween Event",
			Obtainable = false
		}
	},
	["La Vacca Jacko Linterino"] = {
		DisplayName = "La Vacca Jacko Linterino",
		Rarity = "Secret",
		Price = 225000000,
		Generation = 850000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Witching Hour",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Halloween Event",
			Obtainable = false
		}
	},
	["Chicleteirina Bicicleteirina"] = {
		DisplayName = "Chicleteirina Bicicleteirina",
		Rarity = "Secret",
		Price = 850000000,
		Generation = 4000000,
		RoadWeight = 5e-8,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	Eviledon = {
		DisplayName = "Eviledon",
		Rarity = "Secret",
		Price = 3850000000,
		Generation = 31500000,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["La Spooky Grande"] = {
		DisplayName = "La Spooky Grande",
		Rarity = "Secret",
		Price = 2900000000,
		Generation = 24500000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Witching Hour",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["Los Mobilis"] = {
		DisplayName = "Los Mobilis",
		Rarity = "Secret",
		Price = 2700000000,
		Generation = 22000000,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Spooky and Pumpky"] = {
		DisplayName = "Spooky and Pumpky",
		Rarity = "Secret",
		Price = 25000000000,
		Generation = 80000000,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Boatito Auratito"] = {
		DisplayName = "Boatito Auratito",
		Rarity = "Secret",
		Price = 115000000,
		Generation = 525000,
		IgnoreIndexCounter = true,
		SpawnVFX = "Indonesia",
		SpawnDelay = 3.5,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	["Horegini Boom"] = {
		DisplayName = "Horegini Boom",
		Rarity = "Secret",
		Price = 650000000,
		Generation = 2750000,
		ObtainedFrom = {
			Source = "Aura Boat",
			Obtainable = false
		}
	},
	["Rang Ring Bus"] = {
		DisplayName = "Rang Ring Bus",
		Rarity = "Secret",
		Price = 1100000000,
		Generation = 6000000,
		ObtainedFrom = {
			Source = "Pole Game",
			Obtainable = false
		}
	},
	["Mieteteira Bicicleteira"] = {
		DisplayName = "Mieteteira Bicicleteira",
		Rarity = "Secret",
		Price = 2750000000,
		Generation = 26000000,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	["Quesadillo Vampiro"] = {
		DisplayName = "Quesadillo Vampiro",
		Rarity = "Secret",
		Price = 750000000,
		Generation = 3500000,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["Burrito Bandito"] = {
		DisplayName = "Burrito Bandito",
		Rarity = "Secret",
		Price = 850000000,
		Generation = 4000000,
		SpawnVFX = "Taco",
		SpawnDelay = 3
	},
	["Chipso and Queso"] = {
		DisplayName = "Chipso and Queso",
		Rarity = "Secret",
		Price = 2500000000,
		Generation = 25000000,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	Jackorilla = {
		DisplayName = "Jackorilla",
		Rarity = "Secret",
		Price = 80000000,
		Generation = 315000
	},
	["Pumpkini Spyderini"] = {
		DisplayName = "Pumpkini Spyderini",
		Rarity = "Secret",
		Price = 165000000,
		Generation = 650000
	},
	Trickolino = {
		DisplayName = "Trickolino",
		Rarity = "Secret",
		Price = 235000000,
		Generation = 900000
	},
	Telemorte = {
		DisplayName = "Telemorte",
		Rarity = "Secret",
		Price = 550000000,
		Generation = 2000000
	},
	["Pot Pumpkin"] = {
		DisplayName = "Pot Pumpkin",
		Rarity = "Secret",
		Price = 700000000,
		Generation = 3000000,
		ObtainedFrom = {
			Source = "Halloween Event",
			Obtainable = false
		}
	},
	["Noo my Candy"] = {
		DisplayName = "Noo my Candy",
		Rarity = "Secret",
		Price = 900000000,
		Generation = 5000000,
		ObtainedFrom = {
			Source = "Trick Or Treat",
			Obtainable = false
		}
	},
	["Los Spooky Combinasionas"] = {
		DisplayName = "Los Spooky Combinasionas",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 20000000
	},
	["La Casa Boo"] = {
		DisplayName = "La Casa Boo",
		Rarity = "Secret",
		Price = 40000000000,
		Generation = 100000000
	},
	["La Taco Combinasion"] = {
		DisplayName = "La Taco Combinasion",
		Rarity = "Secret",
		Price = 5000000000,
		Generation = 35000000,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["1x1x1x1"] = {
		DisplayName = "1x1x1x1",
		Rarity = "Secret",
		Price = 255555555,
		Generation = 1111111,
		ObtainedFrom = {
			Source = "Cave Ritual",
			Obtainable = false
		}
	},
	["John Doe"] = {
		DisplayName = "John Doe",
		Rarity = "Secret",
		Price = 1250000000,
		Generation = 7500000,
		ObtainedFrom = {
			Source = "Cave Ritual",
			Obtainable = false
		}
	},
	["Capitano Moby"] = {
		DisplayName = "Capitano Moby",
		Rarity = "Secret",
		Price = 125000000000,
		Generation = 160000000,
		RoadWeight = 1e-13,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Guest 666"] = {
		DisplayName = "Guest 666",
		Rarity = "Secret",
		Price = 15666666666,
		Generation = 66666666,
		ObtainedFrom = {
			Source = "Cave Ritual",
			Obtainable = false
		}
	},
	["Pirulitoita Bicicleteira"] = {
		DisplayName = "Pirulitoita Bicicleteira",
		Rarity = "Secret",
		Price = 600000000,
		Generation = 2500000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Los Puggies"] = {
		DisplayName = "Los Puggies",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 30000000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Los Spaghettis"] = {
		DisplayName = "Los Spaghettis",
		Rarity = "Secret",
		Price = 20000000000,
		Generation = 70000000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Fragrama and Chocrama"] = {
		DisplayName = "Fragrama and Chocrama",
		Rarity = "Secret",
		Price = 40000000000,
		Generation = 100000000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Swag Soda"] = {
		DisplayName = "Swag Soda",
		Rarity = "Secret",
		Price = 1800000000,
		Generation = 13000000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	Orcaledon = {
		DisplayName = "Orcaledon",
		Rarity = "Secret",
		Price = 7000000000,
		Generation = 40000000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Los Cucarachas"] = {
		DisplayName = "Los Cucarachas",
		Rarity = "Secret",
		Price = 300000000,
		Generation = 1250000
	},
	["Los Burritos"] = {
		DisplayName = "Los Burritos",
		Rarity = "Secret",
		Price = 1400000000,
		Generation = 8500000
	},
	["Los Quesadillas"] = {
		DisplayName = "Los Quesadillas",
		Rarity = "Secret",
		Price = 875000000,
		Generation = 4500000
	},
	["Cuadramat and Pakrahmatmamat"] = {
		DisplayName = "Cuadramat and Pakrahmatmamat",
		Rarity = "Secret",
		Price = 400000000,
		Generation = 1400000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["Fishino Clownino"] = {
		DisplayName = "Fishino Clownino",
		Rarity = "Secret",
		Price = 9000000000,
		Generation = 47000000,
		ObtainedFrom = {
			Source = "Fishing Event",
			Obtainable = false
		}
	},
	["Los Planitos"] = {
		DisplayName = "Los Planitos",
		Rarity = "Secret",
		Price = 2750000000,
		Generation = 18500000,
		ObtainedFrom = {
			Source = "Brainrot Trader",
			Obtainable = false
		}
	},
	["W or L"] = {
		DisplayName = "W or L",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 30000000,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["Lavadorito Spinito"] = {
		DisplayName = "Lavadorito Spinito",
		Rarity = "Secret",
		Price = 8000000000,
		Generation = 45000000,
		RoadWeight = 1.5e-11,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Gobblino Uniciclino"] = {
		DisplayName = "Gobblino Uniciclino",
		Rarity = "Secret",
		Price = 2850000000,
		Generation = 27500000,
		ObtainedFrom = {
			Source = "Thanksgiving Event",
			Obtainable = false
		}
	},
	["Giftini Spyderini"] = {
		DisplayName = "Giftini Spyderini",
		Rarity = "Secret",
		Price = 240000000,
		Generation = 999999,
		ObtainedFrom = {
			Source = "This was obtained from the North Pole",
			Obtainable = false,
			FullText = true
		}
	},
	["Cooki and Milki"] = {
		DisplayName = "Cooki and Milki",
		Rarity = "Secret",
		Price = 100000000000,
		Generation = 155000000,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["25"] = {
		DisplayName = "25",
		Rarity = "Secret",
		Price = 600000000,
		Generation = 2500000,
		ObtainedFrom = {
			Source = "Advent Calendar",
			Obtainable = false
		}
	},
	["La Vacca Prese Presente"] = {
		DisplayName = "La Vacca Prese Presente",
		Rarity = "Secret",
		Price = 160000000,
		Generation = 600000,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Reindeer Tralala"] = {
		DisplayName = "Reindeer Tralala",
		Rarity = "Secret",
		Price = 160000000,
		Generation = 600000,
		SpawnVFX = "Winter Hour",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Christmas Event",
			Obtainable = false
		}
	},
	Santteo = {
		DisplayName = "Santteo",
		Rarity = "Secret",
		Price = 210000000,
		Generation = 800000,
		SpawnVFX = "Winter Hour",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Christmas Event",
			Obtainable = false
		}
	},
	["Please my Present"] = {
		DisplayName = "Please my Present",
		Rarity = "Secret",
		Price = 350000000,
		Generation = 1300000,
		ObtainedFrom = {
			Source = "Advent Calendar",
			Obtainable = false
		}
	},
	["List List List Sahur"] = {
		DisplayName = "List List List Sahur",
		Rarity = "Secret",
		Price = 550000000,
		Generation = 2000000,
		SpawnVFX = "Winter Hour",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Christmas Event",
			Obtainable = false
		}
	},
	["Ho Ho Ho Sahur"] = {
		DisplayName = "Ho Ho Ho Sahur",
		Rarity = "Secret",
		Price = 725000000,
		Generation = 3250000,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Chicleteira Noelteira"] = {
		DisplayName = "Chicleteira Noelteira",
		Rarity = "Secret",
		Price = 2000000000,
		Generation = 15000000,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["La Jolly Grande"] = {
		DisplayName = "La Jolly Grande",
		Rarity = "Secret",
		Price = 3500000000,
		Generation = 30000000,
		SpawnVFX = "Winter Hour",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Christmas Wheel Spin",
			Obtainable = false
		}
	},
	["Los Candies"] = {
		DisplayName = "Los Candies",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 23000000,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Triplito Tralaleritos"] = {
		DisplayName = "Triplito Tralaleritos",
		Rarity = "Secret",
		Price = 230000000,
		Generation = 875000
	},
	["Santa Hotspot"] = {
		DisplayName = "Santa Hotspot",
		Rarity = "Secret",
		Price = 625000000,
		Generation = 2600000
	},
	["La Ginger Sekolah"] = {
		DisplayName = "La Ginger Sekolah",
		Rarity = "Secret",
		Price = 23000000000,
		Generation = 75000000
	},
	["Reinito Sleighito"] = {
		DisplayName = "Reinito Sleighito",
		Rarity = "Secret",
		Price = 60000000000,
		Generation = 140000000
	},
	["Naughty Naughty"] = {
		DisplayName = "Naughty Naughty",
		Rarity = "Secret",
		Price = 700000000,
		Generation = 3000000,
		ObtainedFrom = {
			Source = "Christmas Event",
			Obtainable = false
		}
	},
	["Noo my Present"] = {
		DisplayName = "Noo my Present",
		Rarity = "Secret",
		Price = 1100000000,
		Generation = 6000000,
		ObtainedFrom = {
			Source = "Christmas Event",
			Obtainable = false
		}
	},
	["Los 25"] = {
		DisplayName = "Los 25",
		Rarity = "Secret",
		Price = 1500000000,
		Generation = 10000000
	},
	Chimnino = {
		DisplayName = "Chimnino",
		Rarity = "Secret",
		Price = 1900000000,
		Generation = 14000000
	},
	["Festive 67"] = {
		DisplayName = "Festive 67",
		Rarity = "Secret",
		Price = 16000000000,
		Generation = 67000000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "DLC Code",
			Obtainable = false
		}
	},
	["Swaggy Bros"] = {
		DisplayName = "Swaggy Bros",
		Rarity = "Secret",
		Price = 7000000000,
		Generation = 40000000,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	Bunnyman = {
		DisplayName = "Bunnyman",
		Rarity = "Secret",
		Price = 500000000,
		Generation = 1500000,
		ObtainedFrom = {
			Source = "Advent Calendar",
			Obtainable = false
		}
	},
	["Dragon Gingerini"] = {
		DisplayName = "Dragon Gingerini",
		Rarity = "Secret",
		Price = 350000000000,
		Generation = 350000000,
		ObtainedFrom = {
			Source = "Santa\'s Fuse",
			Obtainable = false
		}
	},
	["Donkeyturbo Express"] = {
		DisplayName = "Donkeyturbo Express",
		Rarity = "Secret",
		Price = 1250000000,
		Generation = 7500000,
		ObtainedFrom = {
			Source = "Christmas Event",
			Obtainable = false
		}
	},
	["Money Money Reindeer"] = {
		DisplayName = "Money Money Reindeer",
		Rarity = "Secret",
		Price = 2500000000,
		Generation = 25000000,
		SpawnVFX = "Money Money Reindeer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Santa\'s Market",
			Obtainable = false
		}
	},
	["Los Jolly Combinasionas"] = {
		DisplayName = "Los Jolly Combinasionas",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 20000000,
		ObtainedFrom = {
			Source = "Santa\'s Market",
			Obtainable = false
		}
	},
	["Jolly Jolly Sahur"] = {
		DisplayName = "Jolly Jolly Sahur",
		Rarity = "Secret",
		Price = 8000000000,
		Generation = 45000000,
		ObtainedFrom = {
			Source = "Santa\'s Market",
			Obtainable = false
		}
	},
	["Ginger Gerat"] = {
		DisplayName = "Ginger Gerat",
		Rarity = "Secret",
		Price = 22500000000,
		Generation = 75000000,
		ObtainedFrom = {
			Source = "Santa\'s Market",
			Obtainable = false
		}
	},
	["Rocco Disco"] = {
		DisplayName = "Rocco Disco",
		Rarity = "Secret",
		Price = 150000000,
		Generation = 650000,
		SpawnVFX = "New Years 2026",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "New Year\'s Event",
			Obtainable = false
		}
	},
	["Bunito Bunito Spinito"] = {
		DisplayName = "Bunito Bunito Spinito",
		Rarity = "Secret",
		Price = 900000000,
		Generation = 3000000,
		SpawnVFX = "New Years 2026",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "New Year\'s Event",
			Obtainable = false
		}
	},
	["Tuff Toucan"] = {
		DisplayName = "Tuff Toucan",
		Rarity = "Secret",
		Price = 2750000000,
		Generation = 26000000,
		SpawnVFX = "New Years 2026",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "New Year\'s Event",
			Obtainable = false
		}
	},
	Cerberus = {
		DisplayName = "Cerberus",
		Rarity = "Secret",
		Price = 150000000000,
		Generation = 175000000,
		RoadWeight = 3e-14,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	GOAT = {
		DisplayName = "GOAT",
		Rarity = "Secret",
		Price = 237500000,
		Generation = 950000,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	["Brunito Marsito"] = {
		DisplayName = "Brunito Marsito",
		Rarity = "Secret",
		Price = 750000000,
		Generation = 3500000,
		ObtainedFrom = {
			Source = "This was spawned during Bruno\'s Concert Event",
			Obtainable = false,
			FullText = true
		}
	},
	["Los Trios"] = {
		DisplayName = "Los Trios",
		Rarity = "Secret",
		Price = 175000000,
		Generation = 700000,
		ObtainedFrom = {
			Source = "OG Fuse",
			Obtainable = false
		}
	},
	["Chill Puppy"] = {
		DisplayName = "Chill Puppy",
		Rarity = "Secret",
		Price = 850000000,
		Generation = 4000000,
		ObtainedFrom = {
			Source = "OG Fuse",
			Obtainable = false
		}
	},
	Arcadopus = {
		DisplayName = "Arcadopus",
		Rarity = "Secret",
		Price = 900000000,
		Generation = 5000000,
		ObtainedFrom = {
			Source = "Tsunami LTM",
			Obtainable = false
		}
	},
	["Spinny Hammy"] = {
		DisplayName = "Spinny Hammy",
		Rarity = "Secret",
		Price = 2300000000,
		Generation = 17000000,
		ObtainedFrom = {
			Source = "OG Fuse",
			Obtainable = false
		}
	},
	["Bacuru and Egguru"] = {
		DisplayName = "Bacuru and Egguru",
		Rarity = "Secret",
		Price = 3850000000,
		Generation = 24000000,
		ObtainedFrom = {
			Source = "OG Fuse",
			Obtainable = false
		}
	},
	["Ketupat Bros"] = {
		DisplayName = "Ketupat Bros",
		Rarity = "Secret",
		Price = 65000000000,
		Generation = 145000000,
		ObtainedFrom = {
			Source = "OG Fuse",
			Obtainable = false
		}
	},
	["Hydra Dragon Cannelloni"] = {
		DisplayName = "Hydra Dragon Cannelloni",
		Rarity = "Secret",
		Price = 300000000000,
		Generation = 300000000,
		ObtainedFrom = {
			Source = "OG Fuse",
			Obtainable = false
		}
	},
	["Mi Gatito"] = {
		DisplayName = "Mi Gatito",
		Rarity = "Secret",
		Price = 725000000,
		Generation = 3250000,
		SpawnVFX = "Mi Gatito",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Admin Abuse",
			Obtainable = false
		}
	},
	["Los Mi Gatitos"] = {
		DisplayName = "Los Mi Gatitos",
		Rarity = "Secret",
		Price = 1250000000,
		Generation = 6500000,
		SpawnVFX = "Mi Gatito",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Mi Gatito Ritual",
			Obtainable = false
		}
	},
	["Popcuru and Fizzuru"] = {
		DisplayName = "Popcuru and Fizzuru",
		Rarity = "Secret",
		Price = 135000000000,
		Generation = 170000000,
		ObtainedFrom = {
			Source = "OG Fuse",
			Obtainable = false
		}
	},
	["Love Love Love Sahur"] = {
		DisplayName = "Love Love Love Sahur",
		Rarity = "Secret",
		Price = 250000000,
		Generation = 1000000,
		SpawnVFX = "Valentines",
		SpawnDelay = 3
	},
	["Cupid Cupid Sahur"] = {
		DisplayName = "Cupid Cupid Sahur",
		Rarity = "Secret",
		Price = 715000000,
		Generation = 3100000,
		SpawnVFX = "Valentines",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Cupid\'s Machine",
			Obtainable = false
		}
	},
	["Cupid Hotspot"] = {
		DisplayName = "Cupid Hotspot",
		Rarity = "Secret",
		Price = 750000000,
		Generation = 3500000,
		SpawnVFX = "Valentines",
		SpawnDelay = 3
	},
	["Noo my Heart"] = {
		DisplayName = "Noo my Heart",
		Rarity = "Secret",
		Price = 1800000000,
		Generation = 13000000,
		SpawnVFX = "Valentines",
		SpawnDelay = 3
	},
	["Chicleteira Cupideira"] = {
		DisplayName = "Chicleteira Cupideira",
		Rarity = "Secret",
		Price = 2500000000,
		Generation = 17500000,
		SpawnVFX = "Valentines",
		SpawnDelay = 3
	},
	["Lovin Rose"] = {
		DisplayName = "Lovin Rose",
		Rarity = "Secret",
		Price = 4250000000,
		Generation = 32500000,
		SpawnVFX = "Valentines",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Cupid\'s Machine",
			Obtainable = false
		}
	},
	["La Romantic Grande"] = {
		DisplayName = "La Romantic Grande",
		Rarity = "Secret",
		Price = 7000000000,
		Generation = 40000000,
		SpawnVFX = "Valentines",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["Rosetti Tualetti"] = {
		DisplayName = "Rosetti Tualetti",
		Rarity = "Secret",
		Price = 10000000000,
		Generation = 50000000,
		SpawnVFX = "Valentines",
		SpawnDelay = 3
	},
	["Love Love Bear"] = {
		DisplayName = "Love Love Bear",
		Rarity = "Secret",
		Price = 225000000000,
		Generation = 225000000,
		SpawnVFX = "Valentines",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Cupid\'s Machine",
			Obtainable = false
		}
	},
	["Rosey and Teddy"] = {
		DisplayName = "Rosey and Teddy",
		Rarity = "Secret",
		Price = 130000000000,
		Generation = 165000000,
		SpawnVFX = "Valentines",
		SpawnDelay = 3
	},
	["Los Sweethearts"] = {
		DisplayName = "Los Sweethearts",
		Rarity = "Secret",
		Price = 2250000000,
		Generation = 16500000,
		SpawnVFX = "Valentines",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "First Fuse Machine",
			Obtainable = false
		}
	},
	["Sammyni Fattini"] = {
		DisplayName = "Sammyni Fattini",
		Rarity = "Secret",
		Price = 20000000000,
		Generation = 70000000
	},
	["La Food Combinasion"] = {
		DisplayName = "La Food Combinasion",
		Rarity = "Secret",
		Price = 30000000000,
		Generation = 90000000
	},
	["Los Sekolahs"] = {
		DisplayName = "Los Sekolahs",
		Rarity = "Secret",
		Price = 45000000000,
		Generation = 110000000
	},
	["Los Amigos"] = {
		DisplayName = "Los Amigos",
		Rarity = "Secret",
		Price = 55000000000,
		Generation = 130000000
	},
	["Tirilikalika Tirilikalako"] = {
		DisplayName = "Tirilikalika Tirilikalako",
		Rarity = "Secret",
		Price = 7500000000,
		Generation = 42500000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	Antonio = {
		DisplayName = "Antonio",
		Rarity = "Secret",
		Price = 50000000000,
		Generation = 125000000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Elefanto Frigo"] = {
		DisplayName = "Elefanto Frigo",
		Rarity = "Secret",
		Price = 175000000000,
		Generation = 185000000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["Signore Carapace"] = {
		DisplayName = "Signore Carapace",
		Rarity = "Secret",
		Price = 275000000000,
		Generation = 275000000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	Fishboard = {
		DisplayName = "Fishboard",
		Rarity = "Secret",
		Price = 215000000,
		Generation = 825000,
		RoadWeight = 4e-6,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["DJ Panda"] = {
		DisplayName = "DJ Panda",
		Rarity = "Secret",
		Price = 2500000000,
		Generation = 17500000,
		RoadWeight = 3e-9,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Ventoliero Pavonero"] = {
		DisplayName = "Ventoliero Pavonero",
		Rarity = "Secret",
		Price = 15500000000,
		Generation = 65000000,
		RoadWeight = 7e-12,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Celestial Pegasus"] = {
		DisplayName = "Celestial Pegasus",
		Rarity = "Secret",
		Price = 150000000000,
		Generation = 175000000
	},
	["Tacorillo Crocodillo"] = {
		DisplayName = "Tacorillo Crocodillo",
		Rarity = "Secret",
		Price = 1500000000,
		Generation = 12500000,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["Nacho Spyder"] = {
		DisplayName = "Nacho Spyder",
		Rarity = "Secret",
		Price = 10000000000,
		Generation = 50000000,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["Paradiso Axolottino"] = {
		DisplayName = "Paradiso Axolottino",
		Rarity = "Secret",
		Price = 235000000,
		Generation = 900000,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Serafinna Medusella"] = {
		DisplayName = "Serafinna Medusella",
		Rarity = "Secret",
		Price = 1000000000,
		Generation = 5500000,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Cigno Fulgoro"] = {
		DisplayName = "Cigno Fulgoro",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 20000000,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Los Cupids"] = {
		DisplayName = "Los Cupids",
		Rarity = "Secret",
		Price = 3500000000,
		Generation = 30000000,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	Griffin = {
		DisplayName = "Griffin",
		Rarity = "Secret",
		Price = 400000000000,
		Generation = 400000000,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["La Vacca Lepre Lepreino"] = {
		DisplayName = "La Vacca Lepre Lepreino",
		Rarity = "Secret",
		Price = 255000000,
		Generation = 1100000,
		SpawnVFX = "Clover",
		SpawnDelay = 3
	},
	["Luck Luck Luck Sahur"] = {
		DisplayName = "Luck Luck Luck Sahur",
		Rarity = "Secret",
		Price = 800000000,
		Generation = 3750000,
		SpawnVFX = "Clover",
		SpawnDelay = 3
	},
	["Noo my Gold"] = {
		DisplayName = "Noo my Gold",
		Rarity = "Secret",
		Price = 1850000000,
		Generation = 13500000,
		SpawnVFX = "Clover",
		SpawnDelay = 3
	},
	["Snailo Clovero"] = {
		DisplayName = "Snailo Clovero",
		Rarity = "Secret",
		Price = 2750000000,
		Generation = 18500000,
		SpawnVFX = "Clover",
		SpawnDelay = 3
	},
	["Gold Gold Gold"] = {
		DisplayName = "Gold Gold Gold",
		Rarity = "Secret",
		Price = 8000000000,
		Generation = 45000000,
		SpawnVFX = "Clover",
		SpawnDelay = 3
	},
	["Fortunu and Cashuru"] = {
		DisplayName = "Fortunu and Cashuru",
		Rarity = "Secret",
		Price = 55000000000,
		Generation = 130000000,
		SpawnVFX = "Clover",
		SpawnDelay = 3
	},
	["Cloverat Clapat"] = {
		DisplayName = "Cloverat Clapat",
		Rarity = "Secret",
		Price = 15000000000,
		Generation = 60000000,
		SpawnVFX = "Clover",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "St Patricks Event",
			Obtainable = false
		}
	},
	["Dug dug dug"] = {
		DisplayName = "Dug dug dug",
		Rarity = "Secret",
		Price = 5000000000,
		Generation = 35000000,
		ObtainedFrom = {
			Source = "First Craft Machine",
			Obtainable = false
		}
	},
	["La Lucky Grande"] = {
		DisplayName = "La Lucky Grande",
		Rarity = "Secret",
		Price = 7000000000,
		Generation = 40000000,
		SpawnVFX = "Clover",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["Eid Eid Eid Sahur"] = {
		DisplayName = "Eid Eid Eid Sahur",
		Rarity = "Secret",
		Price = 750000000,
		Generation = 3500000,
		ObtainedFrom = {
			Source = "Eid Event",
			Obtainable = false
		}
	},
	Granny = {
		DisplayName = "Granny",
		Rarity = "Secret",
		Price = 850000000,
		Generation = 4000000,
		SpawnVFX = "Granny",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Granny\'s Funeral Event",
			Obtainable = false
		}
	},
	["Foxini Lanternini"] = {
		DisplayName = "Foxini Lanternini",
		Rarity = "Secret",
		Price = 47500000000,
		Generation = 115000000,
		ObtainedFrom = {
			Source = "Eid Event",
			Obtainable = false
		}
	},
	Buntteo = {
		DisplayName = "Buntteo",
		Rarity = "Secret",
		Price = 225000000,
		Generation = 850000,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Easter Event",
			Obtainable = false
		}
	},
	["Bunny Bunny Bunny Sahur"] = {
		DisplayName = "Bunny Bunny Bunny Sahur",
		Rarity = "Secret",
		Price = 575000000,
		Generation = 2250000,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Easter Event",
			Obtainable = false
		}
	},
	["Noo my Eggs"] = {
		DisplayName = "Noo my Eggs",
		Rarity = "Secret",
		Price = 1200000000,
		Generation = 7000000,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Easter Event",
			Obtainable = false
		}
	},
	["La Easter Grande"] = {
		DisplayName = "La Easter Grande",
		Rarity = "Secret",
		Price = 12500000000,
		Generation = 55000000,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["Easter Easter Easter Sahur"] = {
		DisplayName = "Easter Easter Easter Sahur",
		Rarity = "Secret",
		Price = 300000000,
		Generation = 1250000,
		SpawnVFX = "Easter",
		SpawnDelay = 3
	},
	["Los Bunitos"] = {
		DisplayName = "Los Bunitos",
		Rarity = "Secret",
		Price = 865000000,
		Generation = 4250000,
		SpawnVFX = "Easter",
		SpawnDelay = 3
	},
	Baskito = {
		DisplayName = "Baskito",
		Rarity = "Secret",
		Price = 2100000000,
		Generation = 16000000,
		SpawnVFX = "Easter",
		SpawnDelay = 3
	},
	["Churrito Bunnito"] = {
		DisplayName = "Churrito Bunnito",
		Rarity = "Secret",
		Price = 2600000000,
		Generation = 21000000,
		SpawnVFX = "Easter",
		SpawnDelay = 3
	},
	["Quackini Snackini"] = {
		DisplayName = "Quackini Snackini",
		Rarity = "Secret",
		Price = 15500000000,
		Generation = 65000000,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Egg Town Event",
			Obtainable = false
		}
	},
	["Hopilikalika Hopilikalako"] = {
		DisplayName = "Hopilikalika Hopilikalako",
		Rarity = "Secret",
		Price = 12500000000,
		Generation = 55000000,
		SpawnVFX = "Easter",
		SpawnDelay = 3
	},
	["Boppin Bunny"] = {
		DisplayName = "Boppin Bunny",
		Rarity = "Secret",
		Price = 25000000000,
		Generation = 80000000,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "DLC Code",
			Obtainable = false
		}
	},
	["Hydra Bunny"] = {
		DisplayName = "Hydra Bunny",
		Rarity = "Secret",
		Price = 175000000000,
		Generation = 185000000,
		SpawnVFX = "Easter",
		SpawnDelay = 3
	},
	["Bunny and Eggy"] = {
		DisplayName = "Bunny and Eggy",
		Rarity = "Secret",
		Price = 135000000000,
		Generation = 170000000,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Divine Fuse",
			Obtainable = false
		}
	},
	["Globa Steppa"] = {
		DisplayName = "Globa Steppa",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 27500000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "DLC Codes",
			Obtainable = false
		}
	},
	["Rico Dinero"] = {
		DisplayName = "Rico Dinero",
		Rarity = "Secret",
		Price = 7500000000,
		Generation = 42500000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "DLC Codes",
			Obtainable = false
		}
	},
	["Pancake and Syrup"] = {
		DisplayName = "Pancake and Syrup",
		Rarity = "Secret",
		Price = 50000000000,
		Generation = 125000000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "DLC Codes",
			Obtainable = false
		}
	},
	Arcadragon = {
		DisplayName = "Arcadragon",
		Rarity = "Secret",
		Price = 160000000000,
		Generation = 150000000,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "DLC Codes",
			Obtainable = false
		}
	},
	Berryno = {
		DisplayName = "Berryno",
		Rarity = "Secret",
		Price = 500000000,
		Generation = 1500000,
		RoadWeight = 7e-7,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	Strawberrita = {
		DisplayName = "Strawberrita",
		Rarity = "Secret",
		Price = 1250000000,
		Generation = 6500000,
		RoadWeight = 3e-8
	},
	Bananito = {
		DisplayName = "Bananito",
		Rarity = "Secret",
		Price = 2000000000,
		Generation = 15000000,
		RoadWeight = 8e-9,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Cash or Card"] = {
		DisplayName = "Cash or Card",
		Rarity = "Secret",
		Price = 40000000000,
		Generation = 100000000,
		RoadWeight = 3e-13,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Los Mariachis"] = {
		DisplayName = "Los Mariachis",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 30000000,
		ObtainedFrom = {
			Source = "The Pi\195\177ata",
			Obtainable = false
		}
	},
	["Buho de Volto"] = {
		DisplayName = "Buho de Volto",
		Rarity = "Secret",
		Price = 650000000,
		Generation = 2750000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Futbolini Skatini"] = {
		DisplayName = "Futbolini Skatini",
		Rarity = "Secret",
		Price = 875000000,
		Generation = 4500000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Camera Ramena"] = {
		DisplayName = "Camera Ramena",
		Rarity = "Secret",
		Price = 2300000000,
		Generation = 17000000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Gym Bros"] = {
		DisplayName = "Gym Bros",
		Rarity = "Secret",
		Price = 7500000000,
		Generation = 42500000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Money Money Bros"] = {
		DisplayName = "Money Money Bros",
		Rarity = "Secret",
		Price = 9000000000,
		Generation = 47000000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Los Chillis"] = {
		DisplayName = "Los Chillis",
		Rarity = "Secret",
		Price = 22500000000,
		Generation = 75000000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Los Hackers"] = {
		DisplayName = "Los Hackers",
		Rarity = "Secret",
		Price = 22500000000,
		Generation = 75000000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Duggy Bros"] = {
		DisplayName = "Duggy Bros",
		Rarity = "Secret",
		Price = 30000000000,
		Generation = 90000000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Kalika Bros"] = {
		DisplayName = "Kalika Bros",
		Rarity = "Secret",
		Price = 47500000000,
		Generation = 115000000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	["Digi Narwhal"] = {
		DisplayName = "Digi Narwhal",
		Rarity = "Secret",
		Price = 200000000000,
		Generation = 200000000,
		ObtainedFrom = {
			Source = "Cyber Craft",
			Obtainable = false
		}
	},
	Flancito = {
		DisplayName = "Flancito",
		Rarity = "Secret",
		Price = 800000000,
		Generation = 3750000,
		ObtainedFrom = {
			Source = "SAB\'s Anniversary Event",
			Obtainable = false
		}
	},
	["La Anniversary Grande"] = {
		DisplayName = "La Anniversary Grande",
		Rarity = "Secret",
		Price = 10000000000,
		Generation = 50000000,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	["Sammyni Cakini"] = {
		DisplayName = "Sammyni Cakini",
		Rarity = "Secret",
		Price = 12500000000,
		Generation = 85000000,
		ObtainedFrom = {
			Source = "SAB\'s Anniversary Event",
			Obtainable = false
		}
	},
	["Jelly Moby"] = {
		DisplayName = "Jelly Moby",
		Rarity = "Secret",
		Price = 150000000000,
		Generation = 175000000,
		ObtainedFrom = {
			Source = "SAB\'s Anniversary Event",
			Obtainable = false
		}
	},
	["Eggdin Egg Egg Dun Egg"] = {
		DisplayName = "Eggdin Egg Egg Dun Egg",
		Rarity = "Easter",
		Price = 72500000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 300,
			Animals = {
				{
					Name = "Eggdin Egg Egg Dun",
					Chance = 100
				}
			}
		}
	},
	["Bunny Tralala Egg"] = {
		DisplayName = "Bunny Tralala Egg",
		Rarity = "Easter",
		Price = 47000000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 300,
			Animals = {
				{
					Name = "Bunny Tralala",
					Chance = 100
				}
			}
		}
	},
	["Easter Easter Easter Sahur Egg"] = {
		DisplayName = "Easter Easter Easter Sahur Egg",
		Rarity = "Easter",
		Price = 300000000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 900,
			Animals = {
				{
					Name = "Easter Easter Easter Sahur",
					Chance = 100
				}
			}
		}
	},
	["Noo my Eggs Egg"] = {
		DisplayName = "Noo my Eggs Egg",
		Rarity = "Easter",
		Price = 1200000000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 900,
			Animals = {
				{
					Name = "Noo my Eggs",
					Chance = 100
				}
			}
		}
	},
	["Buntteo Egg"] = {
		DisplayName = "Buntteo Egg",
		Rarity = "Easter",
		Price = 225000000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 900,
			Animals = {
				{
					Name = "Buntteo",
					Chance = 100
				}
			}
		}
	},
	["Hopilikalika Hopilikalako Egg"] = {
		DisplayName = "Hopilikalika Hopilikalako Egg",
		Rarity = "Easter",
		Price = 12500000000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 900,
			Animals = {
				{
					Name = "Hopilikalika Hopilikalako",
					Chance = 100
				}
			}
		}
	},
	["Los Bunitos Egg"] = {
		DisplayName = "Los Bunitos Egg",
		Rarity = "Easter",
		Price = 865000000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 900,
			Animals = {
				{
					Name = "Los Bunitos",
					Chance = 100
				}
			}
		}
	},
	["Hydra Bunny Egg"] = {
		DisplayName = "Hydra Bunny Egg",
		Rarity = "Easter",
		Price = 175000000000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 900,
			Animals = {
				{
					Name = "Hydra Bunny",
					Chance = 100
				}
			}
		}
	},
	["Baskito Egg"] = {
		DisplayName = "Baskito Egg",
		Rarity = "Easter",
		Price = 2100000000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 900,
			Animals = {
				{
					Name = "Baskito",
					Chance = 100
				}
			}
		}
	},
	["Quackini Snackini Egg"] = {
		DisplayName = "Quackini Snackini Egg",
		Rarity = "Easter",
		Price = 15500000000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 900,
			Animals = {
				{
					Name = "Quackini Snackini",
					Chance = 100
				}
			}
		}
	},
	["Churrito Bunnito Egg"] = {
		DisplayName = "Churrito Bunnito Egg",
		Rarity = "Easter",
		Price = 2600000000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 900,
			Animals = {
				{
					Name = "Churrito Bunnito",
					Chance = 100
				}
			}
		}
	},
	["Bunny Bunny Bunny Sahur Egg"] = {
		DisplayName = "Bunny Bunny Bunny Sahur Egg",
		Rarity = "Easter",
		Price = 575000000,
		Generation = 0,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		HideFromIndex = true,
		Egg = {
			Timer = 900,
			Animals = {
				{
					Name = "Bunny Bunny Bunny Sahur",
					Chance = 100
				}
			}
		}
	},
	Glaciator = {
		DisplayName = "Glaciator",
		Rarity = "Secret",
		Price = 580000000,
		Generation = 2300000,
		ObtainedFrom = {
			Source = "Backrooms Event",
			Obtainable = false
		}
	},
	["Flipa Sandala"] = {
		DisplayName = "Flipa Sandala",
		Rarity = "Secret",
		Price = 1100000000,
		Generation = 6000000,
		ObtainedFrom = {
			Source = "Backrooms Event",
			Obtainable = false
		}
	},
	Abyssaloco = {
		DisplayName = "Abyssaloco",
		Rarity = "Secret",
		Price = 4333333333,
		Generation = 33333333,
		ObtainedFrom = {
			Source = "Backrooms Event",
			Obtainable = false
		}
	},
	Rubrikiko = {
		DisplayName = "Rubrikiko",
		Rarity = "Secret",
		Price = 20000000000,
		Generation = 70000000,
		ObtainedFrom = {
			Source = "Backrooms Event",
			Obtainable = false
		}
	},
	["Bombardiro Vaccariro"] = {
		DisplayName = "Bombardiro Vaccariro",
		Rarity = "Secret",
		Price = 250000000,
		Generation = 1000000,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Ombrello Topolino"] = {
		DisplayName = "Ombrello Topolino",
		Rarity = "Secret",
		Price = 1250000000,
		Generation = 6500000,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Capitano Gullini"] = {
		DisplayName = "Capitano Gullini",
		Rarity = "Secret",
		Price = 2700000000,
		Generation = 22000000,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Coco and Mango"] = {
		DisplayName = "Coco and Mango",
		Rarity = "Secret",
		Price = 4500000000,
		Generation = 33500000,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Dragon Aquanini"] = {
		DisplayName = "Dragon Aquanini",
		Rarity = "Secret",
		Price = 375000000000,
		Generation = 375000000,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Steakini Fattini"] = {
		DisplayName = "Steakini Fattini",
		Rarity = "Secret",
		Price = 12500000000,
		Generation = 55000000,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	Caylusaurus = {
		DisplayName = "Caylusaurus",
		Rarity = "Secret",
		Price = 12500000000,
		Generation = 55000000,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = false
		}
	},
	Craburger = {
		DisplayName = "Craburger",
		Rarity = "Secret",
		Price = 350000000,
		Generation = 1300000,
		SpawnVFX = "Summer",
		SpawnDelay = 3
	},
	["Rocketini Frostini"] = {
		DisplayName = "Rocketini Frostini",
		Rarity = "Secret",
		Price = 700000000,
		Generation = 3000000,
		SpawnVFX = "Summer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Sammy\'s Code",
			Obtainable = false
		}
	},
	Octoball = {
		DisplayName = "Octoball",
		Rarity = "Secret",
		Price = 725000000,
		Generation = 3250000,
		SpawnVFX = "Summer",
		SpawnDelay = 3
	},
	["Sushi Inu"] = {
		DisplayName = "Sushi Inu",
		Rarity = "Secret",
		Price = 1300000000,
		Generation = 8000000,
		SpawnVFX = "Summer",
		SpawnDelay = 3
	},
	["Girafini Raftini"] = {
		DisplayName = "Girafini Raftini",
		Rarity = "Secret",
		Price = 2600000000,
		Generation = 18000000,
		SpawnVFX = "Summer",
		SpawnDelay = 3
	},
	["Frullato Framingo"] = {
		DisplayName = "Frullato Framingo",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 20000000,
		SpawnVFX = "Summer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Sammy\'s Code",
			Obtainable = false
		}
	},
	["Los Fruits"] = {
		DisplayName = "Los Fruits",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 23000000,
		SpawnVFX = "Summer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	["Sand Sand Sand"] = {
		DisplayName = "Sand Sand Sand",
		Rarity = "Secret",
		Price = 3000000000,
		Generation = 30000000,
		SpawnVFX = "Summer",
		SpawnDelay = 3
	},
	["Bearito Cabinito"] = {
		DisplayName = "Bearito Cabinito",
		Rarity = "Secret",
		Price = 21000000000,
		Generation = 72500000,
		SpawnVFX = "Summer",
		SpawnDelay = 3
	},
	Venuspino = {
		DisplayName = "Venuspino",
		Rarity = "Secret",
		Price = 150000000000,
		Generation = 175000000,
		SpawnVFX = "Summer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Summer Fuse",
			Obtainable = true
		}
	},
	Kraken = {
		DisplayName = "Kraken",
		Rarity = "Secret",
		Price = 200000000000,
		Generation = 200000000,
		SpawnVFX = "Summer",
		SpawnDelay = 3
	},
	["Gelato Lumacho"] = {
		DisplayName = "Gelato Lumacho",
		Rarity = "Secret",
		Price = 400000000,
		Generation = 1400000,
		SpawnVFX = "Summer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Summer Hour",
			Obtainable = true
		}
	},
	Aquarino = {
		DisplayName = "Aquarino",
		Rarity = "Secret",
		Price = 865000000,
		Generation = 4250000,
		SpawnVFX = "Summer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Summer Hour",
			Obtainable = true
		}
	},
	["Chicleteira Surfeiteira"] = {
		DisplayName = "Chicleteira Surfeiteira",
		Rarity = "Secret",
		Price = 2100000000,
		Generation = 16000000,
		SpawnVFX = "Summer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Summer Hour",
			Obtainable = true
		}
	},
	["La Summer Grande"] = {
		DisplayName = "La Summer Grande",
		Rarity = "Secret",
		Price = 15000000000,
		Generation = 60000000,
		SpawnVFX = "Summer",
		SpawnDelay = 3,
		ObtainedFrom = {
			Source = "Limited Quantity Craft",
			Obtainable = true
		}
	},
	["Skibidi Toilet"] = {
		DisplayName = "Skibidi Toilet",
		Rarity = "OG",
		Price = 450000000000,
		Generation = 450000000,
		TriggerEvent = "Skibidi",
		SpawnVFX = "Skibidi Toilet",
		SpawnDelay = 3,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Strawberry Elephant"] = {
		DisplayName = "Strawberry Elephant",
		Rarity = "OG",
		Price = 750000000000,
		Generation = 750000000,
		TriggerEvent = "Strawberry",
		SpawnVFX = "Strawberry",
		SpawnDelay = 3.5,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Strawberry Harder"] = {
		DisplayName = "Strawberry Harder",
		Rarity = "OG",
		Price = 850000000000,
		Generation = 850000000,
		SpawnVFX = "Strawberry Harder",
		SpawnDelay = 3.5,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Smurf Cat"] = {
		DisplayName = "Smurf Cat",
		Rarity = "OG",
		Price = 450000000000,
		Generation = 750000000,
		SpawnDelay = 3.5,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = false
		}
	},
	["Spyder Elephant"] = {
		DisplayName = "Spyder Elephant",
		Rarity = "OG",
		Price = 1000000000000,
		Generation = 1000000000,
		HideFromIndex = true,
		IgnoreIndexCounter = true,
		TriggerEvent = "Strawberry",
		SpawnVFX = "Strawberry",
		SpawnDelay = 3.5
	},
	["Headless Horseman"] = {
		DisplayName = "Headless Horseman",
		Rarity = "OG",
		Price = 600000000000,
		Generation = 600000000,
		ObtainedFrom = {
			Source = "Witch\'s Fuse",
			Obtainable = false
		}
	},
	Meowl = {
		DisplayName = "Meowl",
		Rarity = "OG",
		Price = 650000000000,
		Generation = 600000000,
		TriggerEvent = "Meowl",
		SpawnVFX = "Meowl",
		SpawnDelay = 3.5,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["John Pork"] = {
		DisplayName = "John Pork",
		Rarity = "OG",
		Price = 500000000000,
		Generation = 500000000,
		TriggerEventBeforeDelay = true,
		TriggerEvent = "John Pork",
		TriggerEventDelay = 0,
		SpawnVFX = "John Pork",
		SpawnDelay = 3,
		IgnoreIndexCounter = true,
		ObtainedFrom = {
			Source = "The Red Carpet",
			Obtainable = true
		}
	},
	["Mythic Lucky Block"] = {
		DisplayName = "Lucky Block",
		Rarity = "Mythic",
		Price = 2500000,
		Generation = 0,
		RoadWeight = 0.05,
		HideFromIndex = true,
		LuckyBlock = LuckyBlocks["Mythic Lucky Block"]
	},
	["Brainrot God Lucky Block"] = {
		DisplayName = "Lucky Block",
		Rarity = "Brainrot God",
		Price = 25000000,
		Generation = 0,
		RoadWeight = 0.001,
		HideFromIndex = true,
		LuckyBlock = LuckyBlocks["Brainrot God Lucky Block"]
	},
	["Secret Lucky Block"] = {
		DisplayName = "Lucky Block",
		Rarity = "Secret",
		Price = 750000000,
		Generation = 0,
		RoadWeight = 7e-7,
		HideFromIndex = true,
		LuckyBlock = LuckyBlocks["Secret Lucky Block"]
	},
	["Admin Lucky Block"] = {
		DisplayName = "Lucky Block",
		Rarity = "Admin",
		Price = 100000000,
		Generation = 0,
		HideFromIndex = true,
		LuckyBlock = LuckyBlocks["Admin Lucky Block"]
	},
	["Taco Lucky Block"] = {
		DisplayName = "Lucky Block",
		Rarity = "Taco",
		Price = 50000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Taco Lucky Block"]
	},
	["Los Lucky Blocks"] = {
		DisplayName = "Los Lucky Blocks",
		Rarity = "Admin",
		Price = 250000000,
		Generation = 0,
		HideFromIndex = true,
		LuckyBlock = LuckyBlocks["Los Lucky Blocks"]
	},
	["Spooky Lucky Block"] = {
		DisplayName = "Spooky Lucky Block",
		Rarity = "Spooky",
		Price = 350000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Spooky",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Spooky Lucky Block"]
	},
	["Los Taco Blocks"] = {
		DisplayName = "Los Taco Blocks",
		Rarity = "Taco",
		Price = 300000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Taco",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Los Taco Blocks"]
	},
	["Festive Lucky Block"] = {
		DisplayName = "Festive Lucky Block",
		Rarity = "Festive",
		Price = 400000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Christmas",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Festive Lucky Block"]
	},
	["Premium Festive Lucky Block"] = {
		DisplayName = "Premium Festive Lucky Block",
		Rarity = "Festive",
		Price = 400000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Christmas",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Premium Festive Lucky Block"]
	},
	["Heart Lucky Block"] = {
		DisplayName = "Heart Lucky Block",
		Rarity = "Valentines",
		Price = 350000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Valentines",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Heart Lucky Block"]
	},
	["Premium Heart Lucky Block"] = {
		DisplayName = "Premium Heart Lucky Block",
		Rarity = "Valentines",
		Price = 350000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Valentines",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Premium Heart Lucky Block"]
	},
	["Leprechaun Lucky Block"] = {
		DisplayName = "Leprechaun Lucky Block",
		Rarity = "St Patrick\'s",
		Price = 400000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Clover",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Leprechaun Lucky Block"]
	},
	["Premium Leprechaun Lucky Block"] = {
		DisplayName = "Premium Leprechaun Lucky Block",
		Rarity = "St Patrick\'s",
		Price = 400000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Clover",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Premium Leprechaun Lucky Block"]
	},
	["Egg Lucky Block"] = {
		DisplayName = "Egg Lucky Block",
		Rarity = "Easter",
		Price = 500000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Egg Lucky Block"]
	},
	["Premium Egg Lucky Block"] = {
		DisplayName = "Premium Egg Lucky Block",
		Rarity = "Easter",
		Price = 500000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Easter",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Premium Egg Lucky Block"]
	},
	["Octo Lucky Block"] = {
		DisplayName = "Octo Lucky Block",
		Rarity = "Summer",
		Price = 600000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Summer",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Octo Lucky Block"]
	},
	["Premium Octo Lucky Block"] = {
		DisplayName = "Premium Octo Lucky Block",
		Rarity = "Summer",
		Price = 600000000,
		Generation = 0,
		HideFromIndex = true,
		SpawnVFX = "Summer",
		SpawnDelay = 3,
		LuckyBlock = LuckyBlocks["Premium Octo Lucky Block"]
	},
	["Gold Egg"] = {
		DisplayName = "Gold Egg",
		Rarity = "Secret",
		Price = 0,
		Generation = 0,
		HideFromIndex = true,
		HideGeneration = true,
		HidePrice = true,
		HideRarity = true,
		HideOverhead = true,
		SpawnVFX = "Easter",
		SpawnDelay = 3
	},
	["Gold Elf"] = {
		DisplayName = "Gold Elf",
		Rarity = "Secret",
		Price = 0,
		Generation = 0,
		HideFromIndex = true,
		HideOverhead = true,
		SpawnVFX = "Gold Elf",
		SpawnDelay = 3
	},
	["Wheelchair Granny"] = {
		DisplayName = "Granny",
		Rarity = "Secret",
		TriggerEvent = "Rip My Granny",
		TriggerEventDelay = 7,
		SpawnVFX = "Granny",
		SpawnDelay = 3,
		IgnoreIndexCounter = true,
		Price = 0,
		Generation = 0,
		HideFromIndex = true,
		HideOverhead = true,
		TriggerEventOptions = { "RunIntro" }
	}
}

if RunService:IsServer() then
	local ServerStorage = game:GetService("ServerStorage")

	for v1, v2 in require(ServerStorage.Modules.ServerRoadWeights) do
		if t[v1] then
			t[v1].RoadWeight = v2
		end
	end
end

return t