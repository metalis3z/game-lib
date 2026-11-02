local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Datas = ReplicatedStorage:WaitForChild("Datas")
local Shared = ReplicatedStorage:WaitForChild("Shared")

local LuckyBlocks = require(Datas.LuckyBlocks)
local Updates = require(Shared.Updates)

local Animals = {
	["Noobini Pizzanini"] = {
		["DisplayName"] = "Noobini Pizzanini",
		["Rarity"] = "Common",
		["Price"] = 25,
		["Generation"] = 1,
		["RoadWeight"] = 100
	},
	["Liril\195\172 Laril\195\160"] = {
		["DisplayName"] = "Liril\195\172 Laril\195\160",
		["Rarity"] = "Common",
		["Price"] = 250,
		["Generation"] = 3,
		["RoadWeight"] = 55
	},
	["Strawberry Elephant"] = {
		["DisplayName"] = "Strawberry Elephant",
		["Rarity"] = "Secret",
		["Price"] = 10000000000,
		["Generation"] = 15000000,
	},
	["Tim Cheese"] = {
		["DisplayName"] = "Tim Cheese",
		["Rarity"] = "Common",
		["Price"] = 500,
		["Generation"] = 5,
		["RoadWeight"] = 50
	},
	["Fluriflura"] = {
		["DisplayName"] = "Fluriflura",
		["Rarity"] = "Common",
		["Price"] = 750,
		["Generation"] = 7,
		["RoadWeight"] = 45
	},
	["Svinina Bombardino"] = {
		["DisplayName"] = "Svinina Bombardino",
		["Rarity"] = "Common",
		["Price"] = 1250,
		["Generation"] = 10,
		["RoadWeight"] = 40
	},
	["Talpa Di Fero"] = {
		["DisplayName"] = "Talpa Di Fero",
		["Rarity"] = "Common",
		["Price"] = 1000,
		["Generation"] = 9,
		["RoadWeight"] = 43
	},
	["Pipi Kiwi"] = {
		["DisplayName"] = "Pipi Kiwi",
		["Rarity"] = "Common",
		["Price"] = 1500,
		["Generation"] = 13,
		["RoadWeight"] = 37
	},
	["Pipi Corni"] = {
		["DisplayName"] = "Pipi Corni",
		["Rarity"] = "Common",
		["Price"] = 1750,
		["Generation"] = 14
	},
	["Raccooni Jandelini"] = {
		["DisplayName"] = "Raccooni Jandelini",
		["Rarity"] = "Common",
		["Price"] = 1350,
		["Generation"] = 12
	},
	["Tartaragno"] = {
		["DisplayName"] = "Tartaragno",
		["Rarity"] = "Common",
		["Price"] = 1500,
		["Generation"] = 13
	},
	["Noobini Santanini"] = {
		["DisplayName"] = "Noobini Santanini",
		["Rarity"] = "Common",
		["Price"] = 1300,
		["Generation"] = 11
	},
	["Holy Arepa"] = {
		["DisplayName"] = "Holy Arepa",
		["Rarity"] = "Common",
		["Price"] = 1750,
		["Generation"] = 14
	},
	["Trippi Troppi"] = {
		["DisplayName"] = "Trippi Troppi",
		["Rarity"] = "Rare",
		["Price"] = 2000,
		["Generation"] = 15,
		["RoadWeight"] = 30
	},
	["Gangster Footera"] = {
		["DisplayName"] = "Gangster Footera",
		["Rarity"] = "Rare",
		["Price"] = 4000,
		["Generation"] = 30,
		["RoadWeight"] = 25
	},
	["Boneca Ambalabu"] = {
		["DisplayName"] = "Boneca Ambalabu",
		["Rarity"] = "Rare",
		["Price"] = 5000,
		["Generation"] = 40,
		["RoadWeight"] = 20
	},
	["Ta Ta Ta Ta Sahur"] = {
		["DisplayName"] = "Ta Ta Ta Ta Sahur",
		["Rarity"] = "Rare",
		["Price"] = 7500,
		["Generation"] = 55,
		["RoadWeight"] = 17
	},
	["Tric Trac Baraboom"] = {
		["DisplayName"] = "Tric Trac Baraboom",
		["Rarity"] = "Rare",
		["Price"] = 9000,
		["Generation"] = 65,
		["RoadWeight"] = 15
	},
	["Bandito Bobritto"] = {
		["DisplayName"] = "Bandito Bobritto",
		["Rarity"] = "Rare",
		["Price"] = 4500,
		["Generation"] = 35,
		["RoadWeight"] = 22.5
	},
	["Cacto Hipopotamo"] = {
		["DisplayName"] = "Cacto Hipopotamo",
		["Rarity"] = "Rare",
		["Price"] = 6500,
		["Generation"] = 50,
		["RoadWeight"] = 18.5
	},
	["Pipi Avocado"] = {
		["DisplayName"] = "Pipi Avocado",
		["Rarity"] = "Rare",
		["Price"] = 9500,
		["Generation"] = 70
	},
	["Pinealotto Fruttarino"] = {
		["DisplayName"] = "Pinealotto Fruttarino",
		["Rarity"] = "Rare",
		["Price"] = 9750,
		["Generation"] = 75
	},
	["Cupcake Koala"] = {
		["DisplayName"] = "Cupcake Koala",
		["Rarity"] = "Rare",
		["Price"] = 8000,
		["Generation"] = 60
	},
	["Frogo Elfo"] = {
		["DisplayName"] = "Frogo Elfo",
		["Rarity"] = "Rare",
		["Price"] = 9250,
		["Generation"] = 67
	},
	["Pengolino Nuvoletto"] = {
		["DisplayName"] = "Pengolino Nuvoletto",
		["Rarity"] = "Rare",
		["Price"] = 9600,
		["Generation"] = 72
	},
	["Cappuccino Assassino"] = {
		["DisplayName"] = "Cappuccino Assassino",
		["Rarity"] = "Epic",
		["Price"] = 10000,
		["Generation"] = 75,
		["RoadWeight"] = 13
	},
	["Brr Brr Patapim"] = {
		["DisplayName"] = "Brr Brr Patapim",
		["Rarity"] = "Epic",
		["Price"] = 15000,
		["Generation"] = 100,
		["RoadWeight"] = 10
	},
	["Trulimero Trulicina"] = {
		["DisplayName"] = "Trulimero Trulicina",
		["Rarity"] = "Epic",
		["Price"] = 20000,
		["Generation"] = 125,
		["RoadWeight"] = 7
	},
	["Bananita Dolphinita"] = {
		["DisplayName"] = "Bananita Dolphinita",
		["Rarity"] = "Epic",
		["Price"] = 25000,
		["Generation"] = 150,
		["RoadWeight"] = 5
	},
	["Brri Brri Bicus Dicus Bombicus"] = {
		["DisplayName"] = "Brri Brri Bicus Dicus Bombicus",
		["Rarity"] = "Epic",
		["Price"] = 30000,
		["Generation"] = 175,
		["RoadWeight"] = 3.5
	},
	["Bambini Crostini"] = {
		["DisplayName"] = "Bambini Crostini",
		["Rarity"] = "Epic",
		["Price"] = 22500,
		["Generation"] = 135,
		["RoadWeight"] = 6
	},
	["Perochello Lemonchello"] = {
		["DisplayName"] = "Perochello Lemonchello",
		["Rarity"] = "Epic",
		["Price"] = 27500,
		["Generation"] = 160,
		["RoadWeight"] = 4.5
	},
	["Avocadini Guffo"] = {
		["DisplayName"] = "Avocadini Guffo",
		["Rarity"] = "Epic",
		["Price"] = 35000,
		["Generation"] = 225,
		["RoadWeight"] = 3
	},
	["Salamino Penguino"] = {
		["DisplayName"] = "Salamino Penguino",
		["Rarity"] = "Epic",
		["Price"] = 40000,
		["Generation"] = 250,
		["RoadWeight"] = 2.5
	},
	["Ti Ti Ti Sahur"] = {
		["DisplayName"] = "Ti Ti Ti Sahur",
		["Rarity"] = "Epic",
		["Price"] = 37500,
		["Generation"] = 225
	},
	["Penguino Cocosino"] = {
		["DisplayName"] = "Penguino Cocosino",
		["Rarity"] = "Epic",
		["Price"] = 45000,
		["Generation"] = 300
	},
	["Avocadini Antilopini"] = {
		["DisplayName"] = "Avocadini Antilopini",
		["Rarity"] = "Epic",
		["Price"] = 17500,
		["Generation"] = 115,
		["RoadWeight"] = 8.5
	},
	["Bandito Axolito"] = {
		["DisplayName"] = "Bandito Axolito",
		["Rarity"] = "Epic",
		["Price"] = 12500,
		["Generation"] = 90
	},
	["Malame Amarele"] = {
		["DisplayName"] = "Malame Amarele",
		["Rarity"] = "Epic",
		["Price"] = 23500,
		["Generation"] = 140
	},
	["Mangolini Parrocini"] = {
		["DisplayName"] = "Mangolini Parrocini",
		["Rarity"] = "Epic",
		["Price"] = 38500,
		["Generation"] = 235
	},
	["Mummio Rappitto"] = {
		["DisplayName"] = "Mummio Rappitto",
		["Rarity"] = "Epic",
		["Price"] = 47500,
		["Generation"] = 325
	},
	["Frogato Pirato"] = {
		["DisplayName"] = "Frogato Pirato",
		["Rarity"] = "Epic",
		["Price"] = 39000,
		["Generation"] = 240
	},
	["Wombo Rollo"] = {
		["DisplayName"] = "Wombo Rollo",
		["Rarity"] = "Epic",
		["Price"] = 42500,
		["Generation"] = 275,
		["RoadWeight"] = 1.75
	},
	["Doi Doi Do"] = {
		["DisplayName"] = "Doi Doi Do",
		["Rarity"] = "Epic",
		["Price"] = 41000,
		["Generation"] = 260
	},
	["Penguin Tree"] = {
		["DisplayName"] = "Penguin Tree",
		["Rarity"] = "Epic",
		["Price"] = 42000,
		["Generation"] = 270
	},
	["Gato Celesto"] = {
		["DisplayName"] = "Gato Celesto",
		["Rarity"] = "Epic",
		["Price"] = 40000,
		["Generation"] = 250
	},
	["Burbaloni Loliloli"] = {
		["DisplayName"] = "Burbaloni Loliloli",
		["Rarity"] = "Legendary",
		["Price"] = 35000,
		["Generation"] = 200,
		["RoadWeight"] = 1
	},
	["Chimpanzini Bananini"] = {
		["DisplayName"] = "Chimpanzini Bananini",
		["Rarity"] = "Legendary",
		["Price"] = 50000,
		["Generation"] = 300,
		["RoadWeight"] = 0.75
	},
	["Ballerina Cappuccina"] = {
		["DisplayName"] = "Ballerina Cappuccina",
		["Rarity"] = "Legendary",
		["Price"] = 100000,
		["Generation"] = 500,
		["RoadWeight"] = 0.55
	},
	["Chef Crabracadabra"] = {
		["DisplayName"] = "Chef Crabracadabra",
		["Rarity"] = "Legendary",
		["Price"] = 150000,
		["Generation"] = 600,
		["RoadWeight"] = 0.5
	},
	["Glorbo Fruttodrillo"] = {
		["DisplayName"] = "Glorbo Fruttodrillo",
		["Rarity"] = "Legendary",
		["Price"] = 200000,
		["Generation"] = 750,
		["RoadWeight"] = 0.45
	},
	["Blueberrinni Octopusini"] = {
		["DisplayName"] = "Blueberrinni Octopusini",
		["Rarity"] = "Legendary",
		["Price"] = 250000,
		["Generation"] = 1000,
		["RoadWeight"] = 0.4
	},
	["Lionel Cactuseli"] = {
		["DisplayName"] = "Lionel Cactuseli",
		["Rarity"] = "Legendary",
		["Price"] = 175000,
		["Generation"] = 650,
		["RoadWeight"] = 0.47
	},
	["Pandaccini Bananini"] = {
		["DisplayName"] = "Pandaccini Bananini",
		["Rarity"] = "Legendary",
		["Price"] = 300000,
		["Generation"] = 1250,
		["RoadWeight"] = 0.35
	},
	["Strawberrelli Flamingelli"] = {
		["DisplayName"] = "Strawberrelli Flamingelli",
		["Rarity"] = "Legendary",
		["Price"] = 275000,
		["Generation"] = 1150,
		["RoadWeight"] = 0.37
	},
	["Cocosini Mama"] = {
		["DisplayName"] = "Cocosini Mama",
		["Rarity"] = "Legendary",
		["Price"] = 285000,
		["Generation"] = 1200
	},
	["Pi Pi Watermelon"] = {
		["DisplayName"] = "Pi Pi Watermelon",
		["Rarity"] = "Legendary",
		["Price"] = 315000,
		["Generation"] = 1300
	},
	["Sigma Boy"] = {
		["DisplayName"] = "Sigma Boy",
		["Rarity"] = "Legendary",
		["Price"] = 325000,
		["Generation"] = 1350,
		["RoadWeight"] = 0.3
	},
	["Pipi Potato"] = {
		["DisplayName"] = "Pipi Potato",
		["Rarity"] = "Legendary",
		["Price"] = 265000,
		["Generation"] = 1100,
		["RoadWeight"] = 0.385
	},
	["Quivioli Ameleonni"] = {
		["DisplayName"] = "Quivioli Ameleonni",
		["Rarity"] = "Legendary",
		["Price"] = 225000,
		["Generation"] = 900,
		["RoadWeight"] = 0.425
	},
	["Caramello Filtrello"] = {
		["DisplayName"] = "Caramello Filtrello",
		["Rarity"] = "Legendary",
		["Price"] = 255000,
		["Generation"] = 1050
	},
	["Sigma Girl"] = {
		["DisplayName"] = "Sigma Girl",
		["Rarity"] = "OP",
		["Price"] = 340000,
		["Generation"] = 676767676
	},
	["Quackula"] = {
		["DisplayName"] = "Quackula",
		["Rarity"] = "Legendary",
		["Price"] = 310000,
		["Generation"] = 1275
	},
	["Buho de Fuego"] = {
		["DisplayName"] = "Buho de Fuego",
		["Rarity"] = "Legendary",
		["Price"] = 345000,
		["Generation"] = 1850
	},
	["Clickerino Crabo"] = {
		["DisplayName"] = "Clickerino Crabo",
		["Rarity"] = "Legendary",
		["Price"] = 250000,
		["Generation"] = 1000
	},
	["Puffaball"] = {
		["DisplayName"] = "Puffaball",
		["Rarity"] = "Legendary",
		["Price"] = 330000,
		["Generation"] = 1500
	},
	["Chocco Bunny"] = {
		["DisplayName"] = "Chocco Bunny",
		["Rarity"] = "Legendary",
		["Price"] = 327500,
		["Generation"] = 1400
	},
	["Sealo Regalo"] = {
		["DisplayName"] = "Sealo Regalo",
		["Rarity"] = "Legendary",
		["Price"] = 342500,
		["Generation"] = 1825
	},
	["Buho del Cielo"] = {
		["DisplayName"] = "Buho del Cielo",
		["Rarity"] = "Legendary",
		["Price"] = 325000,
		["Generation"] = 1350
	},
	["Seraphino Gruyero"] = {
		["DisplayName"] = "Seraphino Gruyero",
		["Rarity"] = "Legendary",
		["Price"] = 347500,
		["Generation"] = 1900
	},
	["Frigo Camelo"] = {
		["DisplayName"] = "Frigo Camelo",
		["Rarity"] = "Mythic",
		["Price"] = 350000,
		["Generation"] = 2000,
		["RoadWeight"] = 0.2
	},
	["Orangutini Ananassini"] = {
		["DisplayName"] = "Orangutini Ananassini",
		["Rarity"] = "Mythic",
		["Price"] = 400000,
		["Generation"] = 2100,
		["RoadWeight"] = 0.18
	},
	["Bombardiro Crocodilo"] = {
		["DisplayName"] = "Bombardiro Crocodilo",
		["Rarity"] = "Mythic",
		["Price"] = 500000,
		["Generation"] = 2500,
		["RoadWeight"] = 0.15
	},
	["Bombombini Gusini"] = {
		["DisplayName"] = "Bombombini Gusini",
		["Rarity"] = "Mythic",
		["Price"] = 1000000,
		["Generation"] = 5000,
		["RoadWeight"] = 0.14
	},
	["Rhino Toasterino"] = {
		["DisplayName"] = "Rhino Toasterino",
		["Rarity"] = "Mythic",
		["Price"] = 450000,
		["Generation"] = 2150,
		["RoadWeight"] = 0.16
	},
	["Cavallo Virtuoso"] = {
		["DisplayName"] = "Cavallo Virtuoso",
		["Rarity"] = "Mythic",
		["Price"] = 2500000,
		["Generation"] = 7500,
		["RoadWeight"] = 0.1
	},
	["Spioniro Golubiro"] = {
		["DisplayName"] = "Spioniro Golubiro",
		["Rarity"] = "Mythic",
		["Price"] = 750000,
		["Generation"] = 3500
	},
	["Zibra Zubra Zibralini"] = {
		["DisplayName"] = "Zibra Zubra Zibralini",
		["Rarity"] = "Mythic",
		["Price"] = 1500000,
		["Generation"] = 6000
	},
	["Tigrilini Watermelini"] = {
		["DisplayName"] = "Tigrilini Watermelini",
		["Rarity"] = "Mythic",
		["Price"] = 1750000,
		["Generation"] = 6500
	},
	["Gorillo Watermelondrillo"] = {
		["DisplayName"] = "Gorillo Watermelondrillo",
		["Rarity"] = "Mythic",
		["Price"] = 3000000,
		["Generation"] = 8000,
		["RoadWeight"] = 0.08
	},
	["Avocadorilla"] = {
		["DisplayName"] = "Avocadorilla",
		["Rarity"] = "Mythic",
		["Price"] = 2000000,
		["Generation"] = 7000
	},
	["Ganganzelli Trulala"] = {
		["DisplayName"] = "Ganganzelli Trulala",
		["Rarity"] = "Mythic",
		["Price"] = 3750000,
		["Generation"] = 9000,
		["IgnoreIndexCounter"] = true
	},
	["Tob Tobi Tobi"] = {
		["DisplayName"] = "Tob Tobi Tobi",
		["Rarity"] = "Mythic",
		["Price"] = 3250000,
		["Generation"] = 8500,
		["IgnoreIndexCounter"] = true
	},
	["Te Te Te Sahur"] = {
		["DisplayName"] = "Te Te Te Sahur",
		["Rarity"] = "Mythic",
		["Price"] = 4000000,
		["Generation"] = 9500,
		["RoadWeight"] = 0.07
	},
	["Tracoducotulu Delapeladustuz"] = {
		["DisplayName"] = "Tracoducotulu Delapeladustuz",
		["Rarity"] = "Mythic",
		["Price"] = 4250000,
		["Generation"] = 12000,
		["RoadWeight"] = 0.06
	},
	["Lerulerulerule"] = {
		["DisplayName"] = "Lerulerulerule",
		["Rarity"] = "Mythic",
		["Price"] = 3500000,
		["Generation"] = 8750,
		["RoadWeight"] = 0.75
	},
	["Carloo"] = {
		["DisplayName"] = "Carloo",
		["Rarity"] = "Mythic",
		["Price"] = 4500000,
		["Generation"] = 13500,
		["IgnoreIndexCounter"] = true
	},
	["Carrotini Brainini"] = {
		["DisplayName"] = "Carrotini Brainini",
		["Rarity"] = "Mythic",
		["Price"] = 4750000,
		["Generation"] = 15000
	},
	["Brutto Gialutto"] = {
		["DisplayName"] = "Brutto Gialutto",
		["Rarity"] = "Mythic",
		["Price"] = 600000,
		["Generation"] = 3000
	},
	["Gorillo Subwoofero"] = {
		["DisplayName"] = "Gorillo Subwoofero",
		["Rarity"] = "Mythic",
		["Price"] = 2750000,
		["Generation"] = 7750
	},
	["Los Noobinis"] = {
		["DisplayName"] = "Los Noobinis",
		["Rarity"] = "Mythic",
		["Price"] = 4350000,
		["Generation"] = 12500
	},
	["Rhino Helicopterino"] = {
		["DisplayName"] = "Rhino Helicopterino",
		["Rarity"] = "Mythic",
		["Price"] = 4100000,
		["Generation"] = 11000
	},
	["Toiletto Focaccino"] = {
		["DisplayName"] = "Toiletto Focaccino",
		["Rarity"] = "Mythic",
		["Price"] = 4850000,
		["Generation"] = 16000,
		["RoadWeight"] = 0.05
	},
	["Cachorrito Melonito"] = {
		["DisplayName"] = "Cachorrito Melonito",
		["Rarity"] = "Mythic",
		["Price"] = 4400000,
		["Generation"] = 13000,
		["RoadWeight"] = 0.055
	},
	["Bananito Bandito"] = {
		["DisplayName"] = "Bananito Bandito",
		["Rarity"] = "Mythic",
		["Price"] = 4900000,
		["Generation"] = 16500
	},
	["Magi Ribbitini"] = {
		["DisplayName"] = "Magi Ribbitini",
		["Rarity"] = "Mythic",
		["Price"] = 4200000,
		["Generation"] = 11500
	},
	["Jacko Spaventosa"] = {
		["DisplayName"] = "Jacko Spaventosa",
		["Rarity"] = "Mythic",
		["Price"] = 4875000,
		["Generation"] = 16250
	},
	["Stoppo Luminino"] = {
		["DisplayName"] = "Stoppo Luminino",
		["Rarity"] = "Mythic",
		["Price"] = 3000000,
		["Generation"] = 8000
	},
	["Centrucci Nuclucci"] = {
		["DisplayName"] = "Centrucci Nuclucci",
		["Rarity"] = "Mythic",
		["Price"] = 4800000,
		["Generation"] = 15500
	},
	["Jingle Jingle Sahur"] = {
		["DisplayName"] = "Jingle Jingle Sahur",
		["Rarity"] = "Mythic",
		["Price"] = 4300000,
		["Generation"] = 12250
	},
	["Tree Tree Tree Sahur"] = {
		["DisplayName"] = "Tree Tree Tree Sahur",
		["Rarity"] = "Mythic",
		["Price"] = 4950000,
		["Generation"] = 17000
	},
	["Spongini Quackini"] = {
		["DisplayName"] = "Spongini Quackini",
		["Rarity"] = "Mythic",
		["Price"] = 4400000,
		["Generation"] = 13000
	},
	["Fizzy Soda"] = {
		["DisplayName"] = "Fizzy Soda",
		["Rarity"] = "Mythic",
		["Price"] = 4975000,
		["Generation"] = 17250
	},
	["Harpuccino"] = {
		["DisplayName"] = "Harpuccino",
		["Rarity"] = "Mythic",
		["Price"] = 4650000,
		["Generation"] = 14000
	},
	["Berenjello Angello"] = {
		["DisplayName"] = "Berenjello Angello",
		["Rarity"] = "Mythic",
		["Price"] = 5500000,
		["Generation"] = 18000
	},
	["Chihuanini Taconini"] = {
		["DisplayName"] = "Chihuanini Taconini",
		["Rarity"] = "Brainrot God",
		["Price"] = 8500000,
		["Generation"] = 45000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Cocofanto Elefanto"] = {
		["DisplayName"] = "Cocofanto Elefanto",
		["Rarity"] = "Brainrot God",
		["Price"] = 6500000,
		["Generation"] = 19000,
		["RoadWeight"] = 0.05
	},
	["Tralalero Tralala"] = {
		["DisplayName"] = "Tralalero Tralala",
		["Rarity"] = "Brainrot God",
		["Price"] = 10000000,
		["Generation"] = 50000,
		["RoadWeight"] = 0.01
	},
	["Odin Din Din Dun"] = {
		["DisplayName"] = "Odin Din Din Dun",
		["Rarity"] = "Brainrot God",
		["Price"] = 15000000,
		["Generation"] = 75000,
		["RoadWeight"] = 0.007
	},
	["Girafa Celestre"] = {
		["DisplayName"] = "Girafa Celestre",
		["Rarity"] = "Brainrot God",
		["Price"] = 7500000,
		["Generation"] = 20000,
		["RoadWeight"] = 0.03
	},
	["Trenostruzzo Turbo 3000"] = {
		["DisplayName"] = "Trenostruzzo Turbo 3000",
		["Rarity"] = "Brainrot God",
		["Price"] = 25000000,
		["Generation"] = 150000,
		["RoadWeight"] = 0.005
	},
	["Matteo"] = {
		["DisplayName"] = "Matteo",
		["Rarity"] = "Brainrot God",
		["Price"] = 10000000,
		["Generation"] = 50000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Matteo",
		["SpawnDelay"] = 3
	},
	["Tigroligre Frutonni"] = {
		["DisplayName"] = "Tigroligre Frutonni",
		["Rarity"] = "Brainrot God",
		["Price"] = 14000000,
		["Generation"] = 60000
	},
	["Orcalero Orcala"] = {
		["DisplayName"] = "Orcalero Orcala",
		["Rarity"] = "Brainrot God",
		["Price"] = 25000000,
		["Generation"] = 100000
	},
	["Unclito Samito"] = {
		["DisplayName"] = "Unclito Samito",
		["Rarity"] = "Brainrot God",
		["Price"] = 20000000,
		["Generation"] = 75000,
		["IgnoreIndexCounter"] = true
	},
	["Gattatino Nyanino"] = {
		["DisplayName"] = "Gattatino Nyanino",
		["Rarity"] = "Brainrot God",
		["Price"] = 7500000,
		["Generation"] = 35000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Gattatino Nyanino",
		["SpawnDelay"] = 9
	},
	["Espresso Signora"] = {
		["DisplayName"] = "Espresso Signora",
		["Rarity"] = "Brainrot God",
		["Price"] = 25000000,
		["Generation"] = 70000,
		["IgnoreIndexCounter"] = true
	},
	["Ballerino Lololo"] = {
		["DisplayName"] = "Ballerino Lololo",
		["Rarity"] = "Brainrot God",
		["Price"] = 35000000,
		["Generation"] = 200000,
		["RoadWeight"] = 0.0001
	},
	["Piccione Macchina"] = {
		["DisplayName"] = "Piccione Macchina",
		["Rarity"] = "Brainrot God",
		["Price"] = 40000000,
		["Generation"] = 225000,
		["RoadWeight"] = 0.0008
	},
	["Los Crocodillitos"] = {
		["DisplayName"] = "Los Crocodillitos",
		["Rarity"] = "Brainrot God",
		["Price"] = 12500000,
		["Generation"] = 55000
	},
	["Tukanno Bananno"] = {
		["DisplayName"] = "Tukanno Bananno",
		["Rarity"] = "Brainrot God",
		["Price"] = 22500000,
		["Generation"] = 100000,
		["IgnoreIndexCounter"] = true
	},
	["Trippi Troppi Troppa Trippa"] = {
		["DisplayName"] = "Trippi Troppi Troppa Trippa",
		["Rarity"] = "Brainrot God",
		["Price"] = 30000000,
		["Generation"] = 175000,
		["RoadWeight"] = 0.0035
	},
	["Los Tungtungtungcitos"] = {
		["DisplayName"] = "Los Tungtungtungcitos",
		["Rarity"] = "Brainrot God",
		["Price"] = 37500000,
		["Generation"] = 210000,
		["IgnoreIndexCounter"] = true
	},
	["Bulbito Bandito Traktorito"] = {
		["DisplayName"] = "Bulbito Bandito Traktorito",
		["Rarity"] = "Brainrot God",
		["Price"] = 35000000,
		["Generation"] = 205000,
		["IgnoreIndexCounter"] = true
	},
	["Los Orcalitos"] = {
		["DisplayName"] = "Los Orcalitos",
		["Rarity"] = "Brainrot God",
		["Price"] = 45000000,
		["Generation"] = 235000,
		["IgnoreIndexCounter"] = true
	},
	["Tipi Topi Taco"] = {
		["DisplayName"] = "Tipi Topi Taco",
		["Rarity"] = "Brainrot God",
		["Price"] = 20000000,
		["Generation"] = 75000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Bombardini Tortinii"] = {
		["DisplayName"] = "Bombardini Tortinii",
		["Rarity"] = "Brainrot God",
		["Price"] = 50000000,
		["Generation"] = 225000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Tralalita Tralala"] = {
		["DisplayName"] = "Tralalita Tralala",
		["Rarity"] = "Brainrot God",
		["Price"] = 20000000,
		["Generation"] = 100000,
		["RoadWeight"] = 0.006
	},
	["Urubini Flamenguini"] = {
		["DisplayName"] = "Urubini Flamenguini",
		["Rarity"] = "Brainrot God",
		["Price"] = 30000000,
		["Generation"] = 150000,
		["IgnoreIndexCounter"] = true
	},
	["Alessio"] = {
		["DisplayName"] = "Alessio",
		["Rarity"] = "Brainrot God",
		["Price"] = 17500000,
		["Generation"] = 85000,
		["IgnoreIndexCounter"] = true
	},
	["Pakrahmatmamat"] = {
		["DisplayName"] = "Pakrahmatmamat",
		["Rarity"] = "Brainrot God",
		["Price"] = 37500000,
		["Generation"] = 215000,
		["RoadWeight"] = 0.0009
	},
	["Los Bombinitos"] = {
		["DisplayName"] = "Los Bombinitos",
		["Rarity"] = "Brainrot God",
		["Price"] = 42500000,
		["Generation"] = 220000,
		["IgnoreIndexCounter"] = true
	},
	["Brr es Teh Patipum"] = {
		["DisplayName"] = "Brr es Teh Patipum",
		["Rarity"] = "Brainrot God",
		["Price"] = 40000000,
		["Generation"] = 225000,
		["IgnoreIndexCounter"] = true
	},
	["Tartaruga Cisterna"] = {
		["DisplayName"] = "Tartaruga Cisterna",
		["Rarity"] = "Brainrot God",
		["Price"] = 45000000,
		["Generation"] = 250000
	},
	["Cacasito Satalito"] = {
		["DisplayName"] = "Cacasito Satalito",
		["Rarity"] = "Brainrot God",
		["Price"] = 45000000,
		["Generation"] = 240000,
		["RoadWeight"] = 0.0006
	},
	["Mastodontico Telepiedone"] = {
		["DisplayName"] = "Mastodontico Telepiedone",
		["Rarity"] = "Brainrot God",
		["Price"] = 47500000,
		["Generation"] = 275000
	},
	["Crabbo Limonetta"] = {
		["DisplayName"] = "Crabbo Limonetta",
		["Rarity"] = "Brainrot God",
		["Price"] = 46000000,
		["Generation"] = 235000,
		["IgnoreIndexCounter"] = true
	},
	["Gattito Tacoto"] = {
		["DisplayName"] = "Gattito Tacoto",
		["Rarity"] = "Brainrot God",
		["Price"] = 32500000,
		["Generation"] = 165000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Los Tipi Tacos"] = {
		["DisplayName"] = "Los Tipi Tacos",
		["Rarity"] = "Brainrot God",
		["Price"] = 46000000,
		["Generation"] = 260000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Las Capuchinas"] = {
		["DisplayName"] = "Las Capuchinas",
		["Rarity"] = "Brainrot God",
		["Price"] = 32500000,
		["Generation"] = 185000
	},
	["Orcalita Orcala"] = {
		["DisplayName"] = "Orcalita Orcala",
		["Rarity"] = "Brainrot God",
		["Price"] = 45000000,
		["Generation"] = 240000
	},
	["Piccionetta Macchina"] = {
		["DisplayName"] = "Piccionetta Macchina",
		["Rarity"] = "Brainrot God",
		["Price"] = 47000000,
		["Generation"] = 270000
	},
	["Appelini"] = {
		["DisplayName"] = "Appelini",
		["Rarity"] = "Brainrot God",
		["Price"] = 3500000000,
		["Generation"] = 300000
	},
	["Berryno"] = {
		["DisplayName"] = "Berryno",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 1200000
	},
	["Strawberrita"] = {
		["DisplayName"] = "Strawberrita",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 6500000
	},
	["Bananito"] = {
		["DisplayName"] = "Bananito",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 15000000
	},
	["Cash or Card"] = {
		["DisplayName"] = "Cash or Card",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 100000000
	},
	["Bunny and Eggy"] = {
		["DisplayName"] = "Bunny and Eggy",
		["Rarity"] = "Secret",
		["Price"] = 1500000000,
		["Generation"] = 230000000,
	},
	["Hydra Bunny"] = {
		["DisplayName"] = "Hydra Bunny",
		["Rarity"] = "Secret",
		["Price"] = 150000000000,
		["Generation"] = 175000000
	},
	["Boppin Bunny"] = {
		["DisplayName"] = "Boppin Bunny",
		["Rarity"] = "Secret",
		["Price"] = 10000000000,
		["Generation"] = 80000000,
	},
	
	["Anpali Babel"] = {
		["DisplayName"] = "Anpali Babel",
		["Rarity"] = "Brainrot God",
		["Price"] = 48000000,
		["Generation"] = 280000
	},
	["Extinct Ballerina"] = {
		["DisplayName"] = "Extinct Ballerina",
		["Rarity"] = "Brainrot God",
		["Price"] = 23500000,
		["Generation"] = 125000,
		["SpawnVFX"] = "Extinct",
		["SpawnDelay"] = 3
	},
	["Tractoro Dinosauro"] = {
		["DisplayName"] = "Tractoro Dinosauro",
		["Rarity"] = "Brainrot God",
		["Price"] = 42500000,
		["Generation"] = 230000,
		["RoadWeight"] = 0.00065
	},
	["Belula Beluga"] = {
		["DisplayName"] = "Belula Beluga",
		["Rarity"] = "Brainrot God",
		["Price"] = 60000000,
		["Generation"] = 290000
	},
	["Capi Taco"] = {
		["DisplayName"] = "Capi Taco",
		["Rarity"] = "Brainrot God",
		["Price"] = 31000000,
		["Generation"] = 155000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Corn Corn Corn Sahur"] = {
		["DisplayName"] = "Corn Corn Corn Sahur",
		["Rarity"] = "Brainrot God",
		["Price"] = 45000000,
		["Generation"] = 250000
	},
	["Buho de Volto"] = {
		["DisplayName"] = "Buho de Volto",
		["Rarity"] = "Secret",
		["Price"] = 42500000000,
		["Generation"] = 3500000
	},
	["Brasilini Berimbini"] = {
		["DisplayName"] = "Brasilini Berimbini",
		["Rarity"] = "Brainrot God",
		["Price"] = 55000000,
		["Generation"] = 285000,
		["IgnoreIndexCounter"] = true
	},
	["Squalanana"] = {
		["DisplayName"] = "Squalanana",
		["Rarity"] = "Brainrot God",
		["Price"] = 45000000,
		["Generation"] = 250000
	},
	["Sammyni Cakini"] = {
		["Rarity"] = "Secret",
		["Price"] = 12500000000,
		["DisplayName"] = "Sammyni Cakini",
		["Generation"] = 85000000,
	},
	["Flancito"] = {
		["Rarity"] = "Secret",
		["Price"] = 800000000,
		["DisplayName"] = "Flancito",
		["Generation"] = 3750000,
	},
	["Jelly Moby"] = {
		["Rarity"] = "OG",
		["Price"] = 150000000000,
		["DisplayName"] = "Jelly Moby",
		["Generation"] = 375000000,
	},
	["La Anniversary Grande"] = {
		["SpawnVFX"] = "Taco",
		["Rarity"] = "Secret",
		["Price"] = 10000000000,
		["DisplayName"] = "La Anniversary Grande",
		["Generation"] = 50000000,
		["SpawnDelay"] = 3,
	},
	["Pop Pop Sahur"] = {
		["DisplayName"] = "Pop Pop Sahur",
		["Rarity"] = "Brainrot God",
		["Price"] = 65000000,
		["Generation"] = 295000
	},
	["Vampira Cappucina"] = {
		["DisplayName"] = "Vampira Cappucina",
		["Rarity"] = "Brainrot God",
		["Price"] = 24500000,
		["Generation"] = 125000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Witching Hour",
		["SpawnDelay"] = 3
	},
	["Jacko Jack Jack"] = {
		["DisplayName"] = "Jacko Jack Jack",
		["Rarity"] = "Brainrot God",
		["Price"] = 30000000,
		["Generation"] = 150000
	},
	["Snailenzo"] = {
		["DisplayName"] = "Snailenzo",
		["Rarity"] = "Brainrot God",
		["Price"] = 45000000,
		["Generation"] = 250000
	},
	["Tentacolo Tecnico"] = {
		["DisplayName"] = "Tentacolo Tecnico",
		["Rarity"] = "Brainrot God",
		["Price"] = 62500000,
		["Generation"] = 292500
	},
	["Pakrahmatmatina"] = {
		["DisplayName"] = "Pakrahmatmatina",
		["Rarity"] = "Brainrot God",
		["Price"] = 40500000,
		["Generation"] = 225000
	},
	["Bambu Bambu Sahur"] = {
		["DisplayName"] = "Bambu Bambu Sahur",
		["Rarity"] = "Brainrot God",
		["Price"] = 47500000,
		["Generation"] = 275000
	},
	["Krupuk Pagi Pagi"] = {
		["DisplayName"] = "Krupuk Pagi Pagi",
		["Rarity"] = "Brainrot God",
		["Price"] = 60000000,
		["Generation"] = 290000
	},
	["Mummy Ambalabu"] = {
		["DisplayName"] = "Mummy Ambalabu",
		["Rarity"] = "Brainrot God",
		["Price"] = 45000000,
		["Generation"] = 250000
	},
	["Cappuccino Clownino"] = {
		["DisplayName"] = "Cappuccino Clownino",
		["Rarity"] = "Brainrot God",
		["Price"] = 48500000,
		["Generation"] = 285000
	},
	["Rico Dinero"] = {
		["DisplayName"] = "Rico Dinero",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 42500000
	},
	["Globa Steppa"] = {
		["DisplayName"] = "Globba Steppa",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 27500000
	},
	["Skull Skull Skull"] = {
		["DisplayName"] = "Skull Skull Skull",
		["Rarity"] = "Brainrot God",
		["Price"] = 60000000,
		["Generation"] = 290000
	},
	["Lazy Ducky"] = {
		["DisplayName"] = "Lazy Ducky",
		["Rarity"] = "Brainrot God",
		["Price"] = 45500000,
		["Generation"] = 255000,
	},
	["Aquanaut"] = {
		["DisplayName"] = "Aquanaut",
		["Rarity"] = "Brainrot God",
		["Price"] = 45500000,
		["Generation"] = 245000,
		["RoadWeight"] = 0.00055
	},
	["Frio Ninja"] = {
		["DisplayName"] = "Frio Ninja",
		["Rarity"] = "Brainrot God",
		["Price"] = 46500000,
		["Generation"] = 265000
	},
	["Money Money Man"] = {
		["DisplayName"] = "Money Money Man",
		["Rarity"] = "Brainrot God",
		["Price"] = 17500000,
		["Generation"] = 65000
	},
	["Arcadragon"] = {
		["DisplayName"] = "Arcadragon",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 110000000
	},
	["Noo La Polizia"] = {
		["DisplayName"] = "Noo La Polizia",
		["Rarity"] = "Brainrot God",
		["Price"] = 67000000,
		["Generation"] = 280000
	},
	["Los Chihuaninis"] = {
		["DisplayName"] = "Los Chihuaninis",
		["Rarity"] = "Brainrot God",
		["Price"] = 32000000,
		["Generation"] = 160000
	},
	["Los Gattitos"] = {
		["DisplayName"] = "Los Gattitos",
		["Rarity"] = "Brainrot God",
		["Price"] = 47500000,
		["Generation"] = 275000
	},
	["Granchiello Spiritell"] = {
		["DisplayName"] = "Granchiello Spiritell",
		["Rarity"] = "Brainrot God",
		["Price"] = 46000000,
		["Generation"] = 260000
	},
	["Ballerina Peppermintina"] = {
		["DisplayName"] = "Ballerina Peppermintina",
		["Rarity"] = "Brainrot God",
		["Price"] = 37500000,
		["Generation"] = 215000,
		["SpawnVFX"] = "Winter Hour",
		["SpawnDelay"] = 3
	},
	["Ginger Globo"] = {
		["DisplayName"] = "Ginger Globo",
		["Rarity"] = "Brainrot God",
		["Price"] = 45750000,
		["Generation"] = 257500
	},
	["Ginger Cisterna"] = {
		["DisplayName"] = "Ginger Cisterna",
		["Rarity"] = "Brainrot God",
		["Price"] = 63500000,
		["Generation"] = 293500
	},
	["Yeti Claus"] = {
		["DisplayName"] = "Yeti Claus",
		["Rarity"] = "Brainrot God",
		["Price"] = 45750000,
		["Generation"] = 257500
	},
	["Buho de Noelo"] = {
		["DisplayName"] = "Buho de Noelo",
		["Rarity"] = "Brainrot God",
		["Price"] = 46750000,
		["Generation"] = 267500
	},
	["Chrismasmamat"] = {
		["DisplayName"] = "Chrismasmamat",
		["Rarity"] = "Brainrot God",
		["Price"] = 47750000,
		["Generation"] = 277500
	},
	["Cocoa Assassino"] = {
		["DisplayName"] = "Cocoa Assassino",
		["Rarity"] = "Brainrot God",
		["Price"] = 61000000,
		["Generation"] = 291000
	},
	["Pandanini Frostini"] = {
		["DisplayName"] = "Pandanini Frostini",
		["Rarity"] = "Brainrot God",
		["Price"] = 64000000,
		["Generation"] = 294000
	},
	["Tootini Shrimpini"] = {
		["DisplayName"] = "Tootini Shrimpini",
		["Rarity"] = "Brainrot God",
		["Price"] = 46000000,
		["Generation"] = 260000,
		["SpawnVFX"] = "New Years 2026",
		["SpawnDelay"] = 3
	},
	["Boba Panda"] = {
		["DisplayName"] = "Boba Panda",
		["Rarity"] = "Brainrot God",
		["Price"] = 47000000,
		["Generation"] = 270000
	},
	["Dolphini Jetskini"] = {
		["DisplayName"] = "Dolphini Jetskini",
		["Rarity"] = "Brainrot God",
		["Price"] = 64500000,
		["Generation"] = 294500
	},
	["Luv Luv Luv"] = {
		["DisplayName"] = "Luv Luv Luv",
		["Rarity"] = "Brainrot God",
		["Price"] = 48250000,
		["Generation"] = 282500,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Karkerheart Luvkur"] = {
		["DisplayName"] = "Karkerheart Luvkur",
		["Rarity"] = "Brainrot God",
		["Price"] = 67500000,
		["Generation"] = 297500,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Divino Platypio"] = {
		["DisplayName"] = "Divino Platypio",
		["Rarity"] = "Brainrot God",
		["Price"] = 32000000,
		["Generation"] = 160000
	},
	["Astrolero Cervalero"] = {
		["DisplayName"] = "Astrolero Cervalero",
		["Rarity"] = "Brainrot God",
		["Price"] = 48000000,
		["Generation"] = 280000
	},
	["Dumborino Miracello"] = {
		["DisplayName"] = "Dumborino Miracello",
		["Rarity"] = "Brainrot God",
		["Price"] = 75000000,
		["Generation"] = 315000
	},
	["Patteo"] = {
		["DisplayName"] = "Patteo",
		["Rarity"] = "Brainrot God",
		["Price"] = 57500000,
		["Generation"] = 287500,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["Clovkur Kurkur"] = {
		["DisplayName"] = "Clovkur Kurkur",
		["Rarity"] = "Brainrot God",
		["Price"] = 70000000,
		["Generation"] = 305000,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["La Vacca Saturno Saturnita"] = {
		["DisplayName"] = "La Vacca Saturno Saturnita",
		["Rarity"] = "Secret",
		["Price"] = 80000000,
		["Generation"] = 325000,
		["RoadWeight"] = 0.0005
	},
	["Los Tralaleritos"] = {
		["DisplayName"] = "Los Tralaleritos",
		["Rarity"] = "Secret",
		["Price"] = 100000000,
		["Generation"] = 500000,
		["RoadWeight"] = 0.0001
	},
	["Graipuss Medussi"] = {
		["DisplayName"] = "Graipuss Medussi",
		["Rarity"] = "Secret",
		["Price"] = 250000000,
		["Generation"] = 1000000,
		["RoadWeight"] = 1e-6
	},
	["La Grande Combinasion"] = {
		["DisplayName"] = "La Grande Combinasion",
		["Rarity"] = "Secret",
		["OverheadYOffsetModifier"] = 0.8,
		["Price"] = 1000000000,
		["Generation"] = 5000000,
		["RoadWeight"] = 1e-8
	},
	["Futbolini Skatini"] = {
		["DisplayName"] = "Futbolini Skatini",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 6000000
	},
	["Electro Quacko"] = {
		["DisplayName"] = "Electro Quacko",
		["Rarity"] = "Legendary",
		["Price"] = 345000,
		["Generation"] = 1800,
	},
	["Money Money Bros"] = {
		["DisplayName"] = "Money Money Bros",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 24000000
	},
	["John Doe"] = {
		["DisplayName"] = "John Doe",
		["Rarity"] = "Secret",
		["OverheadYOffsetModifier"] = 0.8,
		["Price"] = 1000000000,
		["Generation"] = 7500000,
		["RoadWeight"] = 1e-8
	},
	["Duggy Bros"] = {
		["DisplayName"] = "Duggy Bros",
		["Rarity"] = "Secret",
		["OverheadYOffsetModifier"] = 0.8,
		["Price"] = 9000000000,
		["Generation"] = 90000000,
		["RoadWeight"] = 1e-8
	},
	["Los Hackers"] = {
		["DisplayName"] = "Los Hackers",
		["Rarity"] = "OP",
		["OverheadYOffsetModifier"] = 0.8,
		["Price"] = 1000000000,
		["Generation"] = 1000000000,
		["RoadWeight"] = 1e-8
	},
	["Kalika Bros"] = {
		["DisplayName"] = "Kalika Bros",
		["Rarity"] = "Secret",
		["OverheadYOffsetModifier"] = 0.8,
		["Price"] = 1000000000,
		["Generation"] = 115000000,
		["RoadWeight"] = 1e-8
	},
	["Camera Ramena"] = {
		["DisplayName"] = "Camera Ramena",
		["Rarity"] = "Secret",
		["OverheadYOffsetModifier"] = 0.8,
		["Price"] = 1000000000,
		["Generation"] = 17000000,
		["RoadWeight"] = 1e-8
	},
	["Sammyni Spyderini"] = {
		["DisplayName"] = "Sammyni Spyderini",
		["Rarity"] = "Secret",
		["Price"] = 75000000,
		["Generation"] = 325000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Los Spyderinis",
		["SpawnDelay"] = 3.5
	},
	["Garama and Madundung"] = {
		["DisplayName"] = "Garama and Madundung",
		["Rarity"] = "Secret",
		["Price"] = 10000000000,
		["Generation"] = 200000000,
		["RoadWeight"] = 2e-14
	},
	["Torrtuginni Dragonfrutini"] = {
		["DisplayName"] = "Torrtuginni Dragonfrutini",
		["Rarity"] = "Secret",
		["Price"] = 125000000,
		["Generation"] = 350000
	},
	["Las Tralaleritas"] = {
		["DisplayName"] = "Las Tralaleritas",
		["Rarity"] = "Secret",
		["Price"] = 150000000,
		["Generation"] = 650000,
		["RoadWeight"] = 0.00007
	},
	["Pot Hotspot"] = {
		["DisplayName"] = "Pot Hotspot",
		["Rarity"] = "Secret",
		["Price"] = 600000000,
		["Generation"] = 2500000
	},
	["Nuclearo Dinossauro"] = {
		["DisplayName"] = "Nuclearo Dinossauro",
		["Rarity"] = "Secret",
		["Price"] = 2500000000,
		["Generation"] = 15000000,
		["RoadWeight"] = 1e-10
	},
	["Las Vaquitas Saturnitas"] = {
		["DisplayName"] = "Las Vaquitas Saturnitas",
		["Rarity"] = "Secret",
		["Price"] = 200000000,
		["Generation"] = 750000
	},
	["Chicleteira Bicicleteira"] = {
		["DisplayName"] = "Chicleteira Bicicleteira",
		["Rarity"] = "Secret",
		["Price"] = 750000000,
		["Generation"] = 3500000,
		["RoadWeight"] = 1e-7
	},
	["Agarrini la Palini"] = {
		["DisplayName"] = "Agarrini la Palini",
		["Rarity"] = "Secret",
		["Price"] = 80000000,
		["Generation"] = 425000,
		["IgnoreIndexCounter"] = true
	},
	["Los Combinasionas"] = {
		["DisplayName"] = "Los Combinasionas",
		["Rarity"] = "Secret",
		["Price"] = 2000000000,
		["Generation"] = 15000000,
		["IgnoreIndexCounter"] = true
	},
	["Karkerkar Kurkur"] = {
		["DisplayName"] = "Karkerkar Kurkur",
		["Rarity"] = "Secret",
		["Price"] = 80000000,
		["Generation"] = 325000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Karkerkar Kurkur",
		["SpawnDelay"] = 3
	},
	["Dragon Cannelloni"] = {
		["DisplayName"] = "Dragon Cannelloni",
		["Rarity"] = "Secret",
		["Price"] = 250000000000,
		["Generation"] = 150000000,
		["RoadWeight"] = 2e-14
	},
	["Digi Narwhal"] = {
		["DisplayName"] = "Digi Narwhal",
		["Rarity"] = "Secret",
		["Price"] = 200000000000,
		["Generation"] = 105000000,
		["RoadWeight"] = 2e-14
	},
	["Los Hotspotsitos"] = {
		["DisplayName"] = "Los Hotspotsitos",
		["Rarity"] = "Secret",
		["Price"] = 3000000000,
		["Generation"] = 20000000,
		["IgnoreIndexCounter"] = true
	},
	["Esok Sekolah"] = {
		["DisplayName"] = "Esok Sekolah",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 30000000,
		["IgnoreIndexCounter"] = true
	},
	["Nooo My Hotspot"] = {
		["DisplayName"] = "Nooo My Hotspot",
		["Rarity"] = "Secret",
		["Price"] = 500000000,
		["Generation"] = 1500000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Los Matteos"] = {
		["DisplayName"] = "Los Matteos",
		["Rarity"] = "Secret",
		["Price"] = 80000000,
		["Generation"] = 325000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Matteo",
		["SpawnDelay"] = 3
	},
	["Job Job Job Sahur"] = {
		["DisplayName"] = "Job Job Job Sahur",
		["Rarity"] = "Secret",
		["Price"] = 175000000,
		["Generation"] = 700000,
		["RoadWeight"] = 5e-6
	},
	["Dul Dul Dul"] = {
		["DisplayName"] = "Dul Dul Dul",
		["Rarity"] = "Secret",
		["Price"] = 150000000,
		["Generation"] = 375000,
		["IgnoreIndexCounter"] = true
	},
	["Blackhole Goat"] = {
		["DisplayName"] = "Blackhole Goat",
		["Rarity"] = "Secret",
		["Price"] = 75000000,
		["Generation"] = 400000,
		["IgnoreIndexCounter"] = true
	},
	["Los Spyderinis"] = {
		["DisplayName"] = "Los Spyderinis",
		["Rarity"] = "Secret",
		["Price"] = 125000000,
		["Generation"] = 5000000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Los Spyderinis",
		["SpawnDelay"] = 3.5
	},
	["Ketupat Kepat"] = {
		["DisplayName"] = "Ketupat Kepat",
		["Rarity"] = "Secret",
		["Price"] = 5000000000,
		["Generation"] = 125000000,
		["RoadWeight"] = 5e-11
	},
	["Gamer Bros"] = {
		["DisplayName"] = "Gamer Bros",
		["Rarity"] = "Secret",
		["Price"] = 5000000000,
		["Generation"] = 80000000,
		["RoadWeight"] = 5e-11
	},
	["Los Chillis"] = {
		["DisplayName"] = "Los Chillis",
		["Rarity"] = "Secret",
		["Price"] = 5000000000,
		["Generation"] = 75000000,
		["RoadWeight"] = 5e-11
	},
	["La Supreme Combinasion"] = {
		["DisplayName"] = "La Supreme Combinasion",
		["Rarity"] = "OG",
		["Price"] = 200000000000,
		["Generation"] = 200000000,
		["IgnoreIndexCounter"] = true
	},
	["Dark Guigui"] = {
		["DisplayName"] = "Dark Guigui",
		["Rarity"] = "Secret",
		["Price"] = 275000000000,
		["Generation"] = 120000000,
		["IgnoreIndexCounter"] = true
	},
	["Bisonte Giuppitere"] = {
		["DisplayName"] = "Bisonte Giuppitere",
		["Rarity"] = "Secret",
		["Price"] = 80000000,
		["Generation"] = 325000,
		["IgnoreIndexCounter"] = true
	},
	["Guerriro Digitale"] = {
		["DisplayName"] = "Guerriro Digitale",
		["Rarity"] = "Secret",
		["Price"] = 120000000,
		["Generation"] = 550000,
		["IgnoreIndexCounter"] = true
	},
	["Ketchuru and Musturu"] = {
		["DisplayName"] = "Ketchuru and Musturu",
		["Rarity"] = "Secret",
		["Price"] = 7500000000,
		["Generation"] = 42500000,
		["RoadWeight"] = 2.5e-11
	},
	["Gym Bros"] = {
		["DisplayName"] = "Gym Bros",
		["Rarity"] = "Secret",
		["Price"] = 7500000000,
		["Generation"] = 42500000,
		["RoadWeight"] = 2.5e-11
	},
	["Spaghetti Tualetti"] = {
		["DisplayName"] = "Spaghetti Tualetti",
		["Rarity"] = "Secret",
		["Price"] = 15000000000,
		["Generation"] = 60000000
	},
	["Los Nooo My Hotspotsitos"] = {
		["DisplayName"] = "Los Nooo My Hotspotsitos",
		["Rarity"] = "Secret",
		["Price"] = 1000000000,
		["Generation"] = 5500000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Trenostruzzo Turbo 4000"] = {
		["DisplayName"] = "Trenostruzzo Turbo 4000",
		["Rarity"] = "Secret",
		["Price"] = 90000000,
		["Generation"] = 335000
	},
	["Fragola La La La"] = {
		["DisplayName"] = "Fragola La La La",
		["Rarity"] = "Secret",
		["Price"] = 1000000000,
		["Generation"] = 100000000
	},
	["La Sahur Combinasion"] = {
		["DisplayName"] = "La Sahur Combinasion",
		["Rarity"] = "Secret",
		["Price"] = 550000000,
		["Generation"] = 90000000
	},
	["La Karkerkar Combinasion"] = {
		["DisplayName"] = "La Karkerkar Combinasion",
		["Rarity"] = "Secret",
		["Price"] = 160000000,
		["Generation"] = 600000,
		["IgnoreIndexCounter"] = true
	},
	["Tralaledon"] = {
		["DisplayName"] = "Tralaledon",
		["Rarity"] = "Secret",
		["Price"] = 3000000000,
		["Generation"] = 27500000
	},
	["Los Bros"] = {
		["DisplayName"] = "Los Bros",
		["Rarity"] = "Secret",
		["Price"] = 2600000000,
		["Generation"] = 250000000
	},
	["Los Chicleteiras"] = {
		["DisplayName"] = "Los Chicleteiras",
		["Rarity"] = "Secret",
		["Price"] = 1200000000,
		["Generation"] = 20000000,
		["SpawnVFX"] = "Los Chicleteiras",
		["SpawnDelay"] = 3
	},
	["Chachechi"] = {
		["DisplayName"] = "Chachechi",
		["Rarity"] = "Secret",
		["Price"] = 85000000,
		["Generation"] = 400000
	},
	["Extinct Tralalero"] = {
		["DisplayName"] = "Extinct Tralalero",
		["Rarity"] = "Secret",
		["Price"] = 125000000,
		["Generation"] = 450000,
		["SpawnVFX"] = "Extinct",
		["SpawnDelay"] = 3
	},
	["Extinct Matteo"] = {
		["DisplayName"] = "Extinct Matteo",
		["Rarity"] = "Secret",
		["Price"] = 140000000,
		["Generation"] = 625000,
		["SpawnVFX"] = "Extinct",
		["SpawnDelay"] = 3
	},
	["67"] = {
		["DisplayName"] = "67",
		["Rarity"] = "Secret",
		["Price"] = 1250000000,
		["Generation"] = 10000000
	},
	["Las Sis"] = {
		["DisplayName"] = "Las Sis",
		["Rarity"] = "Secret",
		["Price"] = 2500000000,
		["Generation"] = 17500000
	},
	["Celularcini Viciosini"] = {
		["DisplayName"] = "Celularcini Viciosini",
		["Rarity"] = "Secret",
		["Price"] = 2750000000,
		["Generation"] = 22500000
	},
	["La Extinct Grande"] = {
		["DisplayName"] = "La Extinct Grande",
		["Rarity"] = "Secret",
		["Price"] = 3250000000,
		["Generation"] = 23500000,
		["SpawnVFX"] = "Extinct",
		["SpawnDelay"] = 3,
		["IgnoreIndexCounter"] = true
	},
	["Quesadilla Crocodila"] = {
		["DisplayName"] = "Quesadilla Crocodila",
		["Rarity"] = "Secret",
		["Price"] = 700000000,
		["Generation"] = 3000000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Tacorita Bicicleta"] = {
		["DisplayName"] = "Tacorita Bicicleta",
		["Rarity"] = "Secret",
		["Price"] = 2250000000,
		["Generation"] = 16500000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["La Cucaracha"] = {
		["DisplayName"] = "La Cucaracha",
		["Rarity"] = "Secret",
		["Price"] = 110000000,
		["Generation"] = 475000,
		["SpawnVFX"] = "Mexico",
		["SpawnDelay"] = 3.5,
		["IgnoreIndexCounter"] = true
	},
	["To to to Sahur"] = {
		["DisplayName"] = "To to to Sahur",
		["Rarity"] = "Secret",
		["Price"] = 575000000,
		["Generation"] = 2250000,
		["RoadWeight"] = 5e-7
	},
	["Mariachi Corazoni"] = {
		["DisplayName"] = "Mariachi Corazoni",
		["Rarity"] = "Secret",
		["Price"] = 1750000000,
		["Generation"] = 12500000,
		["IgnoreIndexCounter"] = true
	},
	["Los Tacoritas"] = {
		["DisplayName"] = "Los Tacoritas",
		["Rarity"] = "Secret",
		["Price"] = 4000000000,
		["Generation"] = 32000000
	},
	["Tictac Sahur"] = {
		["DisplayName"] = "Tictac Sahur",
		["Rarity"] = "Secret",
		["Price"] = 6000000000,
		["Generation"] = 37500000,
		["RoadWeight"] = 3.5e-11
	},
	["Yess my examine"] = {
		["DisplayName"] = "Yess my examine",
		["Rarity"] = "Secret",
		["Price"] = 130000000,
		["Generation"] = 575000
	},
	["Karker Sahur"] = {
		["DisplayName"] = "Karker Sahur",
		["Rarity"] = "Secret",
		["Price"] = 185000000,
		["Generation"] = 725000
	},
	["Noo my examine"] = {
		["DisplayName"] = "Noo my examine",
		["Rarity"] = "Secret",
		["Price"] = 525000000,
		["Generation"] = 1750000,
		["IgnoreIndexCounter"] = true
	},
	["Money Money Puggy"] = {
		["DisplayName"] = "Money Money Puggy",
		["Rarity"] = "Secret",
		["Price"] = 2600000000,
		["Generation"] = 21000000,
		["RoadWeight"] = 5e-10
	},
	["Los Primos"] = {
		["DisplayName"] = "Los Primos",
		["Rarity"] = "Secret",
		["Price"] = 3750000000,
		["Generation"] = 31000000
	},
	["Tang Tang Keletang"] = {
		["DisplayName"] = "Tang Tang Keletang",
		["Rarity"] = "Secret",
		["Price"] = 4500000000,
		["Generation"] = 33500000,
		["RoadWeight"] = 7.5e-11,
		["IgnoreIndexCounter"] = true
	},
	["Perrito Burrito"] = {
		["DisplayName"] = "Perrito Burrito",
		["Rarity"] = "Secret",
		["Price"] = 250000000,
		["Generation"] = 1000000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3,
		["IgnoreIndexCounter"] = true
	},
	["Chillin Chili"] = {
		["DisplayName"] = "Chillin Chili",
		["Rarity"] = "Secret",
		["Price"] = 2500000000,
		["Generation"] = 30000000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3,
		["IgnoreIndexCounter"] = true
	},
	["Los Tortus"] = {
		["DisplayName"] = "Los Tortus",
		["Rarity"] = "Secret",
		["Price"] = 100000000,
		["Generation"] = 500000
	},
	["Los Karkeritos"] = {
		["DisplayName"] = "Los Karkeritos",
		["Rarity"] = "Secret",
		["Price"] = 200000000,
		["Generation"] = 750000,
		["SpawnVFX"] = "Karkerkar Kurkur",
		["SpawnDelay"] = 3
	},
	["Los Jobcitos"] = {
		["DisplayName"] = "Los Jobcitos",
		["Rarity"] = "Secret",
		["Price"] = 500000000,
		["Generation"] = 1500000
	},
	["Los 67"] = {
		["DisplayName"] = "Los 67",
		["Rarity"] = "Secret",
		["Price"] = 2750000000,
		["Generation"] = 10000000
	},
	["La Secret Combinasion"] = {
		["DisplayName"] = "La Secret Combinasion",
		["Rarity"] = "Secret",
		["Price"] = 50000000000,
		["Generation"] = 125000000
	},
	["Burguro And Fryuro"] = {
		["DisplayName"] = "Burguro And Fryuro",
		["Rarity"] = "Secret",
		["Price"] = 75000000000,
		["Generation"] = 150000000,
		["RoadWeight"] = 5e-13
	},
	["Zombie Tralala"] = {
		["DisplayName"] = "Zombie Tralala",
		["Rarity"] = "Secret",
		["Price"] = 100000000,
		["Generation"] = 500000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Witching Hour",
		["SpawnDelay"] = 3
	},
	["Vulturino Skeletono"] = {
		["DisplayName"] = "Vulturino Skeletono",
		["Rarity"] = "OP",
		["Price"] = 110000000,
		["Generation"] = 1000000000
	},
	["Frankentteo"] = {
		["DisplayName"] = "Frankentteo",
		["Rarity"] = "Secret",
		["Price"] = 175000000,
		["Generation"] = 700000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Witching Hour",
		["SpawnDelay"] = 3
	},
	["La Vacca Jacko Linterino"] = {
		["DisplayName"] = "La Vacca Jacko Linterino",
		["Rarity"] = "Secret",
		["Price"] = 225000000,
		["Generation"] = 850000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Witching Hour",
		["SpawnDelay"] = 3
	},
	["Chicleteirina Bicicleteirina"] = {
		["DisplayName"] = "Chicleteirina Bicicleteirina",
		["Rarity"] = "Secret",
		["Price"] = 850000000,
		["Generation"] = 4000000,
		["RoadWeight"] = 5e-8
	},
	["Eviledon"] = {
		["DisplayName"] = "Eviledon",
		["Rarity"] = "Secret",
		["Price"] = 3850000000,
		["Generation"] = 31500000
	},
	["La Spooky Grande"] = {
		["DisplayName"] = "La Spooky Grande",
		["Rarity"] = "Secret",
		["Price"] = 2900000000,
		["Generation"] = 24500000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "Witching Hour",
		["SpawnDelay"] = 3
	},
	["Los Mobilis"] = {
		["DisplayName"] = "Los Mobilis",
		["Rarity"] = "Secret",
		["Price"] = 2700000000,
		["Generation"] = 100000000
	},
	["Spooky and Pumpky"] = {
		["DisplayName"] = "Spooky and Pumpky",
		["Rarity"] = "Secret",
		["Price"] = 25000000000,
		["Generation"] = 120000000
	},
	["Boatito Auratito"] = {
		["DisplayName"] = "Boatito Auratito",
		["Rarity"] = "Secret",
		["Price"] = 115000000,
		["Generation"] = 525000,
		["IgnoreIndexCounter"] = true,
		["SpawnVFX"] = "France",
		["SpawnDelay"] = 3.5
	},
	["Horegini Boom"] = {
		["DisplayName"] = "Horegini Boom",
		["Rarity"] = "Secret",
		["Price"] = 650000000,
		["Generation"] = 2750000
	},
	["Rang Ring Bus"] = {
		["DisplayName"] = "Rang Ring Bus",
		["Rarity"] = "Secret",
		["Price"] = 1100000000,
		["Generation"] = 6000000
	},
	["Mieteteira Bicicleteira"] = {
		["DisplayName"] = "Mieteteira Bicicleteira",
		["Rarity"] = "OP",
		["Price"] = 2750000000,
		["Generation"] = 1000000000
	},
	["Quesadillo Vampiro"] = {
		["DisplayName"] = "Quesadillo Vampiro",
		["Rarity"] = "Secret",
		["Price"] = 750000000,
		["Generation"] = 3500000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Burrito Bandito"] = {
		["DisplayName"] = "Burrito Bandito",
		["Rarity"] = "Secret",
		["Price"] = 850000000,
		["Generation"] = 4000000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Chipso and Queso"] = {
		["DisplayName"] = "Chipso and Queso",
		["Rarity"] = "Secret",
		["Price"] = 2500000000,
		["Generation"] = 200000000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Jackorilla"] = {
		["DisplayName"] = "Jackorilla",
		["Rarity"] = "Secret",
		["Price"] = 80000000,
		["Generation"] = 315000
	},
	["Pumpkini Spyderini"] = {
		["DisplayName"] = "Pumpkini Spyderini",
		["Rarity"] = "Secret",
		["Price"] = 165000000,
		["Generation"] = 650000
	},
	["Trickolino"] = {
		["DisplayName"] = "Trickolino",
		["Rarity"] = "Secret",
		["Price"] = 235000000,
		["Generation"] = 900000
	},
	["Telemorte"] = {
		["DisplayName"] = "Telemorte",
		["Rarity"] = "Secret",
		["Price"] = 550000000,
		["Generation"] = 2000000
	},
	["Pot Pumpkin"] = {
		["DisplayName"] = "Pot Pumpkin",
		["Rarity"] = "Secret",
		["Price"] = 700000000,
		["Generation"] = 3000000
	},
	["Noo my Candy"] = {
		["DisplayName"] = "Noo my Candy",
		["Rarity"] = "Secret",
		["Price"] = 900000000,
		["Generation"] = 5000000
	},
	["Los Spooky Combinasionas"] = {
		["DisplayName"] = "Los Spooky Combinasionas",
		["Rarity"] = "Secret",
		["Price"] = 3000000000,
		["Generation"] = 20000000
	},
	["La Casa Boo"] = {
		["DisplayName"] = "La Casa Boo",
		["Rarity"] = "Secret",
		["Price"] = 40000000000,
		["Generation"] = 100000000
	},
	["La Taco Combinasion"] = {
		["DisplayName"] = "La Taco Combinasion",
		["Rarity"] = "Secret",
		["Price"] = 5000000000,
		["Generation"] = 35000000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["1x1x1x1"] = {
		["DisplayName"] = "1x1x1x1",
		["Rarity"] = "Secret",
		["Price"] = 255555555,
		["Generation"] = 1111111
	},
	["Capitano Moby"] = {
		["DisplayName"] = "Capitano Moby",
		["Rarity"] = "Secret",
		["Price"] = 125000000000,
		["Generation"] = 160000000,
		["RoadWeight"] = 1e-13
	},
	["Tucano Capitano"] = {
		["DisplayName"] = "Tucano Capitano",
		["Rarity"] = "Secret",
		["Price"] = 125000000000,
		["Generation"] = 190000000,
		["RoadWeight"] = 1e-13
	},
	["Guest 666"] = {
		["DisplayName"] = "Guest 666",
		["Rarity"] = "Secret",
		["Price"] = 1166666666,
		["Generation"] = 6666666
	},
	["Pirulitoita Bicicleteira"] = {
		["DisplayName"] = "Pirulitoita Bicicleteira",
		["Rarity"] = "Secret",
		["Price"] = 600000000,
		["Generation"] = 2500000
	},
	["Los Puggies"] = {
		["DisplayName"] = "Los Puggies",
		["Rarity"] = "OP",
		["Price"] = 3000000000,
		["Generation"] = 1000000000
	},
	["Los Spaghettis"] = {
		["DisplayName"] = "Los Spaghettis",
		["Rarity"] = "Secret",
		["Price"] = 20000000000,
		["Generation"] = 70000000
	},
	["Fragrama and Chocrama"] = {
		["DisplayName"] = "Fragrama and Chocrama",
		["Rarity"] = "Secret",
		["Price"] = 40000000000,
		["Generation"] = 100000000
	},
	["Swag Soda"] = {
		["DisplayName"] = "Swag Soda",
		["Rarity"] = "Secret",
		["Price"] = 1800000000,
		["Generation"] = 13000000
	},
	["Orcaledon"] = {
		["DisplayName"] = "Orcaledon",
		["Rarity"] = "Secret",
		["Price"] = 7000000000,
		["Generation"] = 40000000
	},
	["Belugaledon"] = {
		["DisplayName"] = "Belugaledon",
		["Rarity"] = "Secret",
		["Price"] = 7000000000,
		["Generation"] = 70000000
	},
	["Los Cucarachas"] = {
		["DisplayName"] = "Los Cucarachas",
		["Rarity"] = "Secret",
		["Price"] = 300000000,
		["Generation"] = 1250000
	},
	["Los Burritos"] = {
		["DisplayName"] = "Los Burritos",
		["Rarity"] = "Secret",
		["Price"] = 1400000000,
		["Generation"] = 8500000
	},
	["Los Quesadillas"] = {
		["DisplayName"] = "Los Quesadillas",
		["Rarity"] = "Secret",
		["Price"] = 875000000,
		["Generation"] = 4500000
	},
	["Cuadramat and Pakrahmatmamat"] = {
		["DisplayName"] = "Cuadramat and Pakrahmatmamat",
		["Rarity"] = "OP",
		["Price"] = 400000000,
		["Generation"] = 1000000000
	},
	["Fishino Clownino"] = {
		["DisplayName"] = "Fishino Clownino",
		["Rarity"] = "OP",
		["Price"] = 9000000000,
		["Generation"] = 1000000000
	},
	["Los Planitos"] = {
		["DisplayName"] = "Los Planitos",
		["Rarity"] = "Secret",
		["Price"] = 2750000000,
		["Generation"] = 18500000
	},
	["W or L"] = {
		["DisplayName"] = "W or L",
		["Rarity"] = "Secret",
		["Price"] = 3000000000,
		["Generation"] = 30000000
	},
	["Lavadorito Spinito"] = {
		["DisplayName"] = "Lavadorito Spinito",
		["Rarity"] = "Secret",
		["Price"] = 8000000000,
		["Generation"] = 45000000,
		["RoadWeight"] = 1.5e-11
	},
	["Gobblino Uniciclino"] = {
		["DisplayName"] = "Gobblino Uniciclino",
		["Rarity"] = "OP",
		["Price"] = 2850000000,
		["Generation"] = 1000000000
	},
	["Giftini Spyderini"] = {
		["DisplayName"] = "Giftini Spyderini",
		["Rarity"] = "Secret",
		["Price"] = 240000000,
		["Generation"] = 999999
	},
	["Tung Tung Tung Sahur"] = {
		["DisplayName"] = "Tung Tung Tung Sahur",
		["Rarity"] = "Secret",
		["Price"] = 500000000,
		["Generation"] = 10000000
	},
	["Coffin Tung Tung Tung Sahur"] = {
		["DisplayName"] = "Coffin Tung Tung Tung Sahur",
		["Rarity"] = "OG",
		["Price"] = 500000000,
		["Generation"] = 0,
		["HideFromIndex"] = true
	},
	["Cooki and Milki"] = {
		["DisplayName"] = "Cooki and Milki",
		["Rarity"] = "Secret",
		["Price"] = 100000000000,
		["Generation"] = 155000000
	},
	["25"] = {
		["DisplayName"] = "25",
		["Rarity"] = "Secret",
		["Price"] = 600000000,
		["Generation"] = 2500000
	},
	["La Vacca Prese Presente"] = {
		["DisplayName"] = "La Vacca Prese Presente",
		["Rarity"] = "Secret",
		["Price"] = 160000000,
		["Generation"] = 600000
	},
	["Reindeer Tralala"] = {
		["DisplayName"] = "Reindeer Tralala",
		["Rarity"] = "Secret",
		["Price"] = 160000000,
		["Generation"] = 600000,
		["SpawnVFX"] = "Winter Hour",
		["SpawnDelay"] = 3
	},
	["Santteo"] = {
		["DisplayName"] = "Santteo",
		["Rarity"] = "Secret",
		["Price"] = 210000000,
		["Generation"] = 800000,
		["SpawnVFX"] = "Winter Hour",
		["SpawnDelay"] = 3
	},
	["Please my Present"] = {
		["DisplayName"] = "Please my Present",
		["Rarity"] = "Secret",
		["Price"] = 350000000,
		["Generation"] = 1300000
	},
	["List List List Sahur"] = {
		["DisplayName"] = "List List List Sahur",
		["Rarity"] = "Secret",
		["Price"] = 550000000,
		["Generation"] = 2000000,
		["SpawnVFX"] = "Winter Hour",
		["SpawnDelay"] = 3
	},
	["Ho Ho Ho Sahur"] = {
		["DisplayName"] = "Ho Ho Ho Sahur",
		["Rarity"] = "Secret",
		["Price"] = 725000000,
		["Generation"] = 3250000
	},
	["Chicleteira Noelteira"] = {
		["DisplayName"] = "Chicleteira Noelteira",
		["Rarity"] = "Secret",
		["Price"] = 2000000000,
		["Generation"] = 15000000
	},
	["La Jolly Grande"] = {
		["DisplayName"] = "La Jolly Grande",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 30000000,
		["SpawnVFX"] = "Winter Hour",
		["SpawnDelay"] = 3
	},
	["Los Candies"] = {
		["DisplayName"] = "Los Candies",
		["Rarity"] = "Secret",
		["Price"] = 3000000000,
		["Generation"] = 23000000
	},
	["Triplito Tralaleritos"] = {
		["DisplayName"] = "Triplito Tralaleritos",
		["Rarity"] = "Secret",
		["Price"] = 230000000,
		["Generation"] = 875000
	},
	["Santa Hotspot"] = {
		["DisplayName"] = "Santa Hotspot",
		["Rarity"] = "Secret",
		["Price"] = 625000000,
		["Generation"] = 2600000
	},
	["La Ginger Sekolah"] = {
		["DisplayName"] = "La Ginger Sekolah",
		["Rarity"] = "Secret",
		["Price"] = 23000000000,
		["Generation"] = 75000000
	},
	["Reinito Sleighito"] = {
		["DisplayName"] = "Reinito Sleighito",
		["Rarity"] = "Secret",
		["Price"] = 60000000000,
		["Generation"] = 140000000
	},
	["Naughty Naughty"] = {
		["DisplayName"] = "Naughty Naughty",
		["Rarity"] = "Secret",
		["Price"] = 700000000,
		["Generation"] = 3000000
	},
	["Noo my Present"] = {
		["DisplayName"] = "Noo my Present",
		["Rarity"] = "Secret",
		["Price"] = 1100000000,
		["Generation"] = 6000000
	},
	["Los 25"] = {
		["DisplayName"] = "Los 25",
		["Rarity"] = "Secret",
		["Price"] = 1500000000,
		["Generation"] = 10000000
	},
	["Chimnino"] = {
		["DisplayName"] = "Chimnino",
		["Rarity"] = "Secret",
		["Price"] = 1900000000,
		["Generation"] = 14000000
	},
	["Festive 67"] = {
		["DisplayName"] = "Festive 67",
		["Rarity"] = "Secret",
		["Price"] = 16000000000,
		["Generation"] = 67000000,
		["IgnoreIndexCounter"] = true
	},
	["Swaggy Bros"] = {
		["DisplayName"] = "Swaggy Bros",
		["Rarity"] = "Secret",
		["Price"] = 7000000000,
		["Generation"] = 40000000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Bunnyman"] = {
		["DisplayName"] = "Bunnyman",
		["Rarity"] = "Secret",
		["Price"] = 500000000,
		["Generation"] = 1500000
	},
	["Dragon Gingerini"] = {
		["DisplayName"] = "Dragon Gingerini",
		["Rarity"] = "Secret",
		["Price"] = 350000000000,
		["Generation"] = 350000000
	},
	["Donkeyturbo Express"] = {
		["DisplayName"] = "Donkeyturbo Express",
		["Rarity"] = "Secret",
		["Price"] = 1250000000,
		["Generation"] = 7500000
	},
	["Money Money Reindeer"] = {
		["DisplayName"] = "Money Money Reindeer",
		["Rarity"] = "Secret",
		["Price"] = 2500000000,
		["Generation"] = 25000000,
		["SpawnVFX"] = "Money Money Reindeer",
		["SpawnDelay"] = 3
	},
	["Los Jolly Combinasionas"] = {
		["DisplayName"] = "Los Jolly Combinasionas",
		["Rarity"] = "Secret",
		["Price"] = 3000000000,
		["Generation"] = 20000000
	},
	["Jolly Jolly Sahur"] = {
		["DisplayName"] = "Jolly Jolly Sahur",
		["Rarity"] = "Secret",
		["Price"] = 8000000000,
		["Generation"] = 45000000
	},
	["Ginger Gerat"] = {
		["DisplayName"] = "Ginger Gerat",
		["Rarity"] = "Secret",
		["Price"] = 22500000000,
		["Generation"] = 75000000
	},
	["Rocco Disco"] = {
		["DisplayName"] = "Rocco Disco",
		["Rarity"] = "Secret",
		["Price"] = 150000000,
		["Generation"] = 650000,
		["SpawnVFX"] = "New Years 2026",
		["SpawnDelay"] = 3
	},
	["Bunito Bunito Spinito"] = {
		["DisplayName"] = "Bunito Bunito Spinito",
		["Rarity"] = "Secret",
		["Price"] = 900000000,
		["Generation"] = 3000000,
		["SpawnVFX"] = "New Years 2026",
		["SpawnDelay"] = 3
	},
	["Tuff Toucan"] = {
		["DisplayName"] = "Tuff Toucan",
		["Rarity"] = "Secret",
		["Price"] = 2750000000,
		["Generation"] = 26000000,
		["SpawnVFX"] = "New Years 2026",
		["SpawnDelay"] = 3
	},
	["Cerberus"] = {
		["DisplayName"] = "Cerberus",
		["Rarity"] = "Secret",
		["Price"] = 150000000000,
		["Generation"] = 200000000,
		["RoadWeight"] = 5e-14
	},
	["GOAT"] = {
		["DisplayName"] = "GOAT",
		["Rarity"] = "Secret",
		["Price"] = 237500000,
		["Generation"] = 950000
	},
	["Brunito Marsito"] = {
		["DisplayName"] = "Brunito Marsito",
		["Rarity"] = "Secret",
		["Price"] = 750000000,
		["Generation"] = 3500000
	},
	["Los Trios"] = {
		["DisplayName"] = "Los Trios",
		["Rarity"] = "Secret",
		["Price"] = 175000000,
		["Generation"] = 700000
	},
	["Chill Puppy"] = {
		["DisplayName"] = "Chill Puppy",
		["Rarity"] = "Secret",
		["Price"] = 850000000,
		["Generation"] = 4000000
	},
	["Arcadopus"] = {
		["DisplayName"] = "Arcadopus",
		["Rarity"] = "Secret",
		["Price"] = 900000000,
		["Generation"] = 5000000
	},
	["Spinny Hammy"] = {
		["DisplayName"] = "Spinny Hammy",
		["Rarity"] = "Secret",
		["Price"] = 2300000000,
		["Generation"] = 17000000
	},
	["Bacuru and Egguru"] = {
		["DisplayName"] = "Bacuru and Egguru",
		["Rarity"] = "Secret",
		["Price"] = 3850000000,
		["Generation"] = 24000000
	},
	["Ketupat Bros"] = {
		["DisplayName"] = "Ketupat Bros",
		["Rarity"] = "Secret",
		["Price"] = 65000000000,
		["Generation"] = 145000000
	},
	["Hydra Dragon Cannelloni"] = {
		["DisplayName"] = "Hydra Dragon Cannelloni",
		["Rarity"] = "Secret",
		["Price"] = 300000000000,
		["Generation"] = 300000000
	},
	["Mi Gatito"] = {
		["DisplayName"] = "Mi Gatito",
		["Rarity"] = "Secret",
		["Price"] = 725000000,
		["Generation"] = 3250000,
		["SpawnVFX"] = "Mi Gatito",
		["SpawnDelay"] = 3
	},
	["Los Mi Gatitos"] = {
		["DisplayName"] = "Los Mi Gatitos",
		["Rarity"] = "Secret",
		["Price"] = 1250000000,
		["Generation"] = 6500000,
		["SpawnVFX"] = "Mi Gatito",
		["SpawnDelay"] = 3
	},
	["Popcuru and Fizzuru"] = {
		["DisplayName"] = "Popcuru and Fizzuru",
		["Rarity"] = "Secret",
		["Price"] = 135000000000,
		["Generation"] = 170000000
	},
	["Love Love Love Sahur"] = {
		["DisplayName"] = "Love Love Love Sahur",
		["Rarity"] = "Secret",
		["Price"] = 250000000,
		["Generation"] = 1000000,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Cupid Cupid Sahur"] = {
		["DisplayName"] = "Cupid Cupid Sahur",
		["Rarity"] = "Secret",
		["Price"] = 715000000,
		["Generation"] = 3100000,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Cupid Hotspot"] = {
		["DisplayName"] = "Cupid Hotspot",
		["Rarity"] = "Secret",
		["Price"] = 750000000,
		["Generation"] = 3500000,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Noo my Heart"] = {
		["DisplayName"] = "Noo my Heart",
		["Rarity"] = "Secret",
		["Price"] = 1800000000,
		["Generation"] = 13000000,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Chicleteira Cupideira"] = {
		["DisplayName"] = "Chicleteira Cupideira",
		["Rarity"] = "Secret",
		["Price"] = 2500000000,
		["Generation"] = 17500000,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Lovin Rose"] = {
		["DisplayName"] = "Lovin Rose",
		["Rarity"] = "Secret",
		["Price"] = 4250000000,
		["Generation"] = 32500000,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["SpongeBob"] = {
		["DisplayName"] = "SpongeBob",
		["Rarity"] = "OG",
		["Price"] = 950000000,
		["Generation"] = 950000000,
	},
	["La Romantic Grande"] = {
		["DisplayName"] = "La Romantic Grande",
		["Rarity"] = "Secret",
		["Price"] = 7000000000,
		["Generation"] = 40000000,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Rosetti Tualetti"] = {
		["DisplayName"] = "Rosetti Tualetti",
		["Rarity"] = "OP",
		["Price"] = 10000000000,
		["Generation"] = 1000000000,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Love Love Bear"] = {
		["DisplayName"] = "Love Love Bear",
		["Rarity"] = "Secret",
		["Price"] = 225000000000,
		["Generation"] = 300000000,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Rosey and Teddy"] = {
		["DisplayName"] = "Rosey and Teddy",
		["Rarity"] = "Secret",
		["Price"] = 130000000000,
		["Generation"] = 165000000,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Los Sweethearts"] = {
		["DisplayName"] = "Los Sweethearts",
		["Rarity"] = "Secret",
		["Price"] = 2250000000,
		["Generation"] = 16500000,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Sammyni Fattini"] = {
		["DisplayName"] = "Sammyni Fattini",
		["Rarity"] = "Secret",
		["Price"] = 20000000000,
		["Generation"] = 70000000
	},
	["La Food Combinasion"] = {
		["DisplayName"] = "La Food Combinasion",
		["Rarity"] = "Secret",
		["Price"] = 30000000000,
		["Generation"] = 90000000
	},
	["Los Sekolahs"] = {
		["DisplayName"] = "Los Sekolahs",
		["Rarity"] = "Secret",
		["Price"] = 45000000000,
		["Generation"] = 110000000
	},
	["Los Amigos"] = {
		["DisplayName"] = "Los Amigos",
		["Rarity"] = "Secret",
		["Price"] = 55000000000,
		["Generation"] = 130000000
	},
	["Tirilikalika Tirilikalako"] = {
		["DisplayName"] = "Tirilikalika Tirilikalako",
		["Rarity"] = "Secret",
		["Price"] = 7500000000,
		["Generation"] = 42500000
	},
	["Antonio"] = {
		["DisplayName"] = "Antonio",
		["Rarity"] = "OG",
		["Price"] = 12500000000,
		["Generation"] = 800000000
	},
	["Elefanto Frigo"] = {
		["DisplayName"] = "Elefanto Frigo",
		["Rarity"] = "OP",
		["Price"] = 12500000000,
		["Generation"] = 1000000000
	},
	["Signore Carapace"] = {
		["DisplayName"] = "Signore Carapace",
		["Rarity"] = "OG",
		["Price"] = 42500000000,
		["Generation"] = 400000000
	},
	["Fishboard"] = {
		["DisplayName"] = "Fishboard",
		["Rarity"] = "Secret",
		["Price"] = 215000000,
		["Generation"] = 825000,
		["RoadWeight"] = 4e-6
	},
	["DJ Panda"] = {
		["DisplayName"] = "DJ Panda",
		["Rarity"] = "Secret",
		["Price"] = 2500000000,
		["Generation"] = 17500000,
		["RoadWeight"] = 5e-9
	},
	["Ventoliero Pavonero"] = {
		["DisplayName"] = "Ventoliero Pavonero",
		["Rarity"] = "Secret",
		["Price"] = 15500000000,
		["Generation"] = 65000000,
		["RoadWeight"] = 7e-12
	},
	["Celestial Pegasus"] = {
		["DisplayName"] = "Celestial Pegasus",
		["Rarity"] = "Secret",
		["Price"] = 150000000000,
		["Generation"] = 175000000
	},
	["Tacorillo Crocodillo"] = {
		["DisplayName"] = "Tacorillo Crocodillo",
		["Rarity"] = "Secret",
		["Price"] = 1500000000,
		["Generation"] = 12500000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Nacho Spyder"] = {
		["DisplayName"] = "Nacho Spyder",
		["Rarity"] = "Secret",
		["Price"] = 10000000000,
		["Generation"] = 50000000,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Paradiso Axolottino"] = {
		["DisplayName"] = "Paradiso Axolottino",
		["Rarity"] = "Secret",
		["Price"] = 235000000,
		["Generation"] = 900000
	},
	["Serafinna Medusella"] = {
		["DisplayName"] = "Serafinna Medusella",
		["Rarity"] = "Secret",
		["Price"] = 1000000000,
		["Generation"] = 5500000
	},
	["Oursini lempirini"] = {
		["DisplayName"] = "Oursini lempirini",
		["Rarity"] = "OG",
		["Price"] = 900000000,
		["Generation"] = 90000000
	},
	["Cigno Fulgoro"] = {
		["DisplayName"] = "Cigno Fulgoro",
		["Rarity"] = "Secret",
		["Price"] = 3000000000,
		["Generation"] = 20000000
	},
	["Los Cupids"] = {
		["DisplayName"] = "Los Cupids",
		["Rarity"] = "Secret",
		["Price"] = 3500000000,
		["Generation"] = 30000000
	},
	["Griffin"] = {
		["DisplayName"] = "Griffin",
		["Rarity"] = "Secret",
		["Price"] = 400000000000,
		["Generation"] = 500000000
	},
	["La Vacca Lepre Lepreino"] = {
		["DisplayName"] = "La Vacca Lepre Lepreino",
		["Rarity"] = "Secret",
		["Price"] = 255000000,
		["Generation"] = 1100000,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["Luck Luck Luck Sahur"] = {
		["DisplayName"] = "Luck Luck Luck Sahur",
		["Rarity"] = "Secret",
		["Price"] = 800000000,
		["Generation"] = 3750000,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["Noo my Gold"] = {
		["DisplayName"] = "Noo my Gold",
		["Rarity"] = "Secret",
		["Price"] = 1850000000,
		["Generation"] = 13500000,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["Snailo Clovero"] = {
		["DisplayName"] = "Snailo Clovero",
		["Rarity"] = "Secret",
		["Price"] = 2750000000,
		["Generation"] = 18500000,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["Gold Gold Gold"] = {
		["DisplayName"] = "Gold Gold Gold",
		["Rarity"] = "Secret",
		["Price"] = 8000000000,
		["Generation"] = 45000000,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["Fortunu and Cashuru"] = {
		["DisplayName"] = "Fortunu and Cashuru",
		["Rarity"] = "OG",
		["Price"] = 55000000000,
		["Generation"] = 400000000,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["Cloverat Clapat"] = {
		["DisplayName"] = "Cloverat Clapat",
		["Rarity"] = "Secret",
		["Price"] = 15000000000,
		["Generation"] = 60000000,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["Dug dug dug"] = {
		["DisplayName"] = "Dug dug dug",
		["Rarity"] = "Secret",
		["Price"] = 5000000000,
		["Generation"] = 35000000
	},
	["La Lucky Grande"] = {
		["DisplayName"] = "La Lucky Grande",
		["Rarity"] = "Secret",
		["Price"] = 7000000000,
		["Generation"] = 40000000,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["Eid Eid Eid Sahur"] = {
		["DisplayName"] = "Eid Eid Eid Sahur",
		["Rarity"] = "Secret",
		["Price"] = 750000000,
		["Generation"] = 3500000
	},
	["Granny"] = {
		["DisplayName"] = "Granny",
		["Rarity"] = "Secret",
		["Price"] = 850000000,
		["Generation"] = 4000000,
		["SpawnVFX"] = "Granny",
		["SpawnDelay"] = 3
	},
	["Foxini Lanternini"] = {
		["DisplayName"] = "Foxini Lanternini",
		["Rarity"] = "Secret",
		["Price"] = 47500000000,
		["Generation"] = 115000000
	},
	["Buntteo"] = {
		["DisplayName"] = "Buntteo",
		["Rarity"] = "Secret",
		["Price"] = 225000000,
		["Generation"] = 850000,
		["SpawnVFX"] = "Easter",
		["SpawnDelay"] = 3
	},
	["Bunny Bunny Bunny Sahur"] = {
		["DisplayName"] = "Bunny Bunny Bunny Sahur",
		["Rarity"] = "Secret",
		["Price"] = 575000000,
		["Generation"] = 2250000,
		["SpawnVFX"] = "Easter",
		["SpawnDelay"] = 3
	},
	["Noo my Eggs"] = {
		["DisplayName"] = "Noo my Eggs",
		["Rarity"] = "Secret",
		["Price"] = 1200000000,
		["Generation"] = 7000000,
		["SpawnVFX"] = "Easter",
		["SpawnDelay"] = 3
	},
	["La Easter Grande"] = {
		["DisplayName"] = "La Easter Grande",
		["Rarity"] = "Secret",
		["Price"] = 12500000000,
		["Generation"] = 55000000,
		["SpawnVFX"] = "Easter",
		["SpawnDelay"] = 3,
		["IsEnabled"] = function()
			return Updates.Methods.IsEnabled("Update-03/31/2026")
		end
	},
	["Skibidi Toilet"] = {
		["DisplayName"] = "Skibidi Toilet",
		["Rarity"] = "OG",
		["Price"] = 450000000000,
		["Generation"] = 450000000,
		["SpawnVFX"] = "Skibidi Toilet",
		["SpawnDelay"] = 3,
		["IgnoreIndexCounter"] = true
	},	
	["Spyder Elephant"] = {
		["DisplayName"] = "Spyder Elephant",
		["Rarity"] = "OG",
		["Price"] = 750000000000,
		["Generation"] = 1750000000,
		["TriggerEvent"] = "Strawberry",
		["SpawnVFX"] = "Strawberry",
		["SpawnDelay"] = 3.5,
		["HideFromIndex"] = true
	},
	["Kaizou Elephant"] = {
		["DisplayName"] = "Kaizou Elephant",
		["Rarity"] = "OG",
		["Price"] = 750000000000,
		["Generation"] = 800000000,
		["TriggerEvent"] = "Strawberry",
		["SpawnVFX"] = "Strawberry",
		["SpawnDelay"] = 3.5,
		["HideFromIndex"] = true
	},
	["Rabbito Clockito"] = {
		["DisplayName"] = "Rabbito Clockito",
		["Rarity"] = "OG",
		["Price"] = 750000000000,
		["Generation"] = 3000000005,
		["TriggerEvent"] = "Strawberry",
		["SpawnVFX"] = "Strawberry",
		["SpawnDelay"] = 3.5,
		["HideFromIndex"] = true
	},	
	["Michaelini Jacksonsini"] = {
		["DisplayName"] = "Michaelini Jacksonsini",
		["Rarity"] = "OG",
		["Price"] = 750000000000,
		["Generation"] = 600000000
	},
	["Moby Bros"] = {
		["DisplayName"] = "Moby Bros",
		["Rarity"] = "Secret",
		["Price"] = 225000000000,
		["Generation"] = 225000000,
		["IgnoreIndexCounter"] = true
	},
	["Badr"] = {
		["DisplayName"] = "Badr",
		["Rarity"] = "OG",
		["Price"] = 750000000000,
		["Generation"] = 100000000,
		["HideFromIndex"] = true
	},
	["Zynna"] = {
		["DisplayName"] = "Zynna",
		["Rarity"] = "OG",
		["Price"] = 750000000000,
		["Generation"] = 120000000,
		["HideFromIndex"] = true
	},
	["Headless Horseman"] = {
		["DisplayName"] = "Headless Horseman",
		["Rarity"] = "OG",
		["Price"] = 1000000000,
		["Generation"] = 850000000
	},
	["Duo Bros"] = {
		["DisplayName"] = "Duo Bros",
		["Rarity"] = "OP",
		["Price"] = 500000000000,
		["Generation"] = 1000000000
	},
	["Meowl"] = {
		["DisplayName"] = "Meowl",
		["Rarity"] = "OG",
		["Price"] = 600000000000,
		["Generation"] = 400000000,
		["TriggerEvent"] = "Meowl",
		["SpawnVFX"] = "Meowl",
		["SpawnDelay"] = 3.5,
		["IgnoreIndexCounter"] = true
	},
	["John Pork"] = {
		["DisplayName"] = "John Pork",
		["Rarity"] = "OG",
		["Price"] = 500000000000,
		["Generation"] = 600000000,
		["TriggerEvent"] = "John Pork",
		["SpawnVFX"] = "John Pork",
		["SpawnDelay"] = 3.5,
		["IgnoreIndexCounter"] = true
	},
	["Mythic Lucky Block"] = {
		["DisplayName"] = "Lucky Block",
		["Rarity"] = "Mythic",
		["Price"] = 2500000,
		["Generation"] = 0,
		["RoadWeight"] = 0.05,
		["LuckyBlock"] = LuckyBlocks["Mythic Lucky Block"],
		["HideFromIndex"] = true
	},
	["Brainrot God Lucky Block"] = {
		["DisplayName"] = "Lucky Block",
		["Rarity"] = "Brainrot God",
		["Price"] = 25000000,
		["Generation"] = 0,
		["RoadWeight"] = 0.001,
		["LuckyBlock"] = LuckyBlocks["Brainrot God Lucky Block"],
		["HideFromIndex"] = true
	},
	["Secret Lucky Block"] = {
		["DisplayName"] = "Lucky Block",
		["Rarity"] = "Secret",
		["Price"] = 750000000,
		["Generation"] = 0,
		["RoadWeight"] = 7e-7,
		["LuckyBlock"] = LuckyBlocks["Secret Lucky Block"],
		["HideFromIndex"] = true
	},
	["Ultime Lucky Block"] = {
		["DisplayName"] = "Ultime Lucky Block",
		["Rarity"] = "OG",
		["Price"] = 750000000,
		["Generation"] = 0,
		["LuckyBlock"] = "Ultime Lucky Block",
		["HideFromIndex"] = true
	},
	["Admin Lucky Block"] = {
		["DisplayName"] = "Lucky Block",
		["Rarity"] = "Admin",
		["Price"] = 100000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["Admin Lucky Block"],
		["HideFromIndex"] = true
	},
	["Taco og Lucky Block"] = {
		["DisplayName"] = "Lucky Block",
		["Rarity"] = "Taco",
		["Price"] = 50000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["Taco og Lucky Block"],
		["HideFromIndex"] = true,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["OG Lucky Block"] = {
		["DisplayName"] = "Lucky Block",
		["Rarity"] = "OG",
		["Price"] = 10000000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["OG Lucky Block"],
		["HideFromIndex"] = true
	},
	["Los Lucky Blocks"] = {
		["DisplayName"] = "Los Lucky Blocks",
		["Rarity"] = "Admin",
		["Price"] = 250000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["Los Lucky Blocks"],
		["HideFromIndex"] = true
	},
	["Spooky Lucky Block"] = {
		["DisplayName"] = "Spooky Lucky Block",
		["Rarity"] = "Spooky",
		["Price"] = 350000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["Spooky Lucky Block"],
		["HideFromIndex"] = true,
		["SpawnVFX"] = "Spooky",
		["SpawnDelay"] = 3
	},
	["Los Taco Blocks"] = {
		["DisplayName"] = "Los Taco Blocks",
		["Rarity"] = "Taco",
		["Price"] = 300000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["Los Taco Blocks"],
		["HideFromIndex"] = true,
		["SpawnVFX"] = "Taco",
		["SpawnDelay"] = 3
	},
	["Festive Lucky Block"] = {
		["DisplayName"] = "Festive Lucky Block",
		["Rarity"] = "Festive",
		["Price"] = 400000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["Festive Lucky Block"],
		["HideFromIndex"] = true,
		["SpawnVFX"] = "Christmas",
		["SpawnDelay"] = 3
	},
	["Premium Festive Lucky Block"] = {
		["DisplayName"] = "Premium Festive Lucky Block",
		["Rarity"] = "Festive",
		["Price"] = 400000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["Premium Festive Lucky Block"],
		["HideFromIndex"] = true,
		["SpawnVFX"] = "Christmas",
		["SpawnDelay"] = 3
	},
	["Heart Lucky Block"] = {
		["DisplayName"] = "Heart Lucky Block",
		["Rarity"] = "Valentines",
		["Price"] = 350000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["Heart Lucky Block"],
		["HideFromIndex"] = true,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Premium Heart Lucky Block"] = {
		["DisplayName"] = "Premium Heart Lucky Block",
		["Rarity"] = "Valentines",
		["Price"] = 350000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["Premium Heart Lucky Block"],
		["HideFromIndex"] = true,
		["SpawnVFX"] = "Valentines",
		["SpawnDelay"] = 3
	},
	["Leprechaun Lucky Block"] = {
		["DisplayName"] = "Leprechaun Lucky Block",
		["Rarity"] = "St Patrick\'s",
		["Price"] = 400000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["Leprechaun Lucky Block"],
		["HideFromIndex"] = true,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["Premium Leprechaun Lucky Block"] = {
		["DisplayName"] = "Premium Leprechaun Lucky Block",
		["Rarity"] = "St Patrick\'s",
		["Price"] = 400000000,
		["Generation"] = 0,
		["LuckyBlock"] = LuckyBlocks["Premium Leprechaun Lucky Block"],
		["HideFromIndex"] = true,
		["SpawnVFX"] = "Clover",
		["SpawnDelay"] = 3
	},
	["Gold Elf"] = {
		["DisplayName"] = "Gold Elf",
		["Rarity"] = "Secret",
		["Price"] = 0,
		["Generation"] = 0,
		["HideFromIndex"] = true,
		["HideOverhead"] = true,
		["SpawnVFX"] = "Gold Elf",
		["SpawnDelay"] = 3
	},
	["Wheelchair Granny"] = {
		["DisplayName"] = "Wheelchair Granny",
		["Rarity"] = "Secret",
		["TriggerEvent"] = "Rip My Granny",
		["TriggerEventDelay"] = 7,
		["TriggerEventOptions"] = { "RunIntro" },
		["SpawnVFX"] = "Granny",
		["SpawnDelay"] = 3,
		["IgnoreIndexCounter"] = true,
		["Price"] = 0,
		["Generation"] = 0,
		["HideFromIndex"] = true,
		["HideOverhead"] = true
	}
}

if RunService:IsServer() then
	local ServerStorage = game:GetService("ServerStorage")
	local ServerRoadWeights = require(ServerStorage.Modules.ServerRoadWeights)

	for AnimalName, roadWeight in pairs(ServerRoadWeights) do
		if Animals[AnimalName] then
			Animals[AnimalName].RoadWeight = roadWeight
		end
	end
end

return Animals