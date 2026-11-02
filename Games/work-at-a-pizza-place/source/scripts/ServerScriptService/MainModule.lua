local MainModule = {}
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))


MainModule.AssetLibrary = {
	
	------PET HATS
	["860395229"] = {Price = 0, Name = "No Hat",Category = "PetHats",Unsellable = true,Discontinued = true,},
	
	["10911990"] = {Price = 40, Name = "Propeller Beanie",Category = "PetHats",Unsellable = true},
	["860339357"] = {Price = 50, Name = "Chef's Hat",Category = "PetHats",Unsellable = true},
	["860293883"] = {Price = 70, Name = "Animal Hoodie",Category = "PetHats",Unsellable = true},
	["273967011"] = {Price = 90, Name = "Pizza Face",Category = "PetHats",Unsellable = true},
	["860355820"] = {Price = 100, Name = "Whipped cream",Category = "PetHats",Unsellable = true},
	["860358597"] = {Price = 110, Name = "Narwhal Face",Category = "PetHats",Unsellable = true},

	["89615321"] = {Price = 130, Name = "Hungry Dino",Category = "PetHats",Unsellable = true},
	["553892446"] = {Price = 150, Name = "Mint Hair",Category = "PetHats",Unsellable = true},
	["158066137"] = {Price = 160, Name = "Beard",Category = "PetHats",Unsellable = true},
	["244159564"] = {Price = 170, Name = "Cat Headphones",Category = "PetHats",Unsellable = true},
	["321570597"] = {Price = 181, Name = "Rainbow Hair",Category = "PetHats",Unsellable = true},
	["860294537"] = {Price = 195, Name = "Doge Face",Category = "PetHats",Unsellable = true},

	["11884330"] = {Price = 180, Name = "Glasses",Category = "PetHats",Unsellable = true},
	["14128456"] = {Price = 185, Name = "Lei",Category = "PetHats",Unsellable = true},

	["20642008"] = {Price = 200, Name = "Bandit",Category = "PetHats",Unsellable = true},	
	["1029025"] = {Price = 210, Name = "Fedora",Category = "PetHats",Unsellable = true},
	["280658439"] = {Price = 215, Name = "Pink Hair",Category = "PetHats",Unsellable = true},
	["51245241"] = {Price = 230, Name = "Sleek Shades",Category = "PetHats",Unsellable = true},
	["4765718"] = {Price = 260, Name = "Skull",Category = "PetHats",Unsellable = true},

	["6552812"] = {Price = 350, Name = "Bling Bling",Category = "PetHats",Unsellable = true},	
	["215719598"] = {Price = 450, Name = "Dark Wings",Category = "PetHats",Unsellable = true},
	["860359815"] = {Price = 450, Name = "Light Wings",Category = "PetHats",Unsellable = true},
	["323419219"] = {Price = 680, Name = "Crazy Blue Hair",Category = "PetHats",Unsellable = true},
	["204162039"] = {Price = 1800, Name = "King's Crown",Category = "PetHats",Unsellable = true},

	

	
	
	
	
	
	--
	["495886176"] = {Price = 0, Name = "PaintBucket",Category = "Gear", Discontinued = true,Unsellable = true},
	["495315981"] = {Price = 0, Name = "MoneyBag",Category = "Gear", Discontinued = true,Unsellable = true},
	["497501382"] = {Price = 0, Name = "HangGlider",Category = "Gear", Discontinued = true,Unsellable = true},
	["497502431"] = {Price = 0, Name = "DeliveryBike",Category = "Gear", Discontinued = true,Unsellable = true},

	["499900783"] = {Price = 1, Name = "Chef Hat",Category = "Hats", Discontinued = true, Unsellable = true},
	["499900058"] = {Price = 1, Name = "Work Visor",Category = "Hats", Discontinued = true, Unsellable = true},


	
	["197236349"] = {Price = 23, Name = "Medieval Spikes",Category = "Entertainment"},
	["197233903"] = {Price = 55, Name = "Medieval Fountain",Category = "Decoration"},
	["197232814"] = {Price = 50, Name = "Medieval Pillar",Category = "Decoration"},
	["197232634"] = {Price = 200, Name = "Medieval Throne",Category = "Seats"},
	["197231399"] = {Price = 45, Name = "Medieval Lantern",Category = "Lights"},
	
	["676560376"] = {Price = 50, Name = "Scarf Kid",Category = "Decoration",Discontinued = true,TableTopItem = true,Unsellable = true},
	["677459420"] = {Price = 50, Name = "Blink Poster",Category = "Decoration",Discontinued = true,TableTopItem = true,Unsellable = true},
	["677578722"] = {Price = 50, Name = "Cannon",Category = "Entertainment",Discontinued = true,Unsellable = true},
	["677615092"] = {Price = 50, Name = "Blink Lantern",Category = "Lights",Discontinued = true,TableTopItem = true,Unsellable = true},


	["392734001"] = {Price = 9, Name = "Prison Bars",Category = "Decoration"},
	["197235278"] = {Price = 320, Name = "Workout Treadmill",Category = "Entertainment"},
	["197235123"] = {Price = 65, Name = "Workout Dumbells",Category = "Decoration"},
	["197234892"] = {Price = 15, Name = "Convayor",Category = "Entertainment"},
	["197234296"] = {Price = 30, Name = "Bleachers",Category = "Seats"},
	["197233764"] = {Price = 210, Name = "Disco Floor",Category = "Entertainment"},
	["197233066"] = {Price = 17, Name = "Stainglass Window",Category = "Decoration"},
	["197231751"] = {Price = 13, Name = "Fence",Category = "Decoration"},
	["197232238"] = {Price = 14, Name = "Fence Corner",Category = "Decoration"},
	["197231156"] = {Price = 52, Name = "Floor Lamp",Category = "Lights"},
	["197230959"] = {Price = 82, Name = "Office Chair",Category = "Seats"},
	["197230649"] = {Price = 61, Name = "Small Plant",Category = "Decoration"},
	["197230496"] = {Price = 73, Name = "Workout Barbell Bench",Category = "Beds"},
	["200224096"] = {Price =21 , Name = "Truss",Category = "Decoration"},
	["200220390"] = {Price =98 , Name = "IMac",Category = "Entertainment",TableTopItem = true},
	["200219980"] = {Price =85 , Name = "MacBook",Category = "Entertainment",TableTopItem = true},
	["200219323"] = {Price =320 ,Name = "DJ Set",Category = "Music Players"},
	["200586032"] = {Price =120, Name = "Microphone",Category = "Entertainment"},
	["143933181"] = {Price = 20, Name = "Ham Table",Category = "Tables"},
	["143958490"] = {Price = 20, Name = "Spotlight",Category = "Lights",TableTopItem = true},
	

	["143094882"] = {Price = 30, Name = "Antler Armchair",Category = "Seats"},
	["143094653"] = {Price = 28, Name = "Antler Couch",Category = "Seats"},
	["143095936"] = {Price = 44, Name = "Antler Fireplace",Category = "Lights"},
	["143095437"] = {Price = 31, Name = "Antler TV",Category = "Entertainment"},
	["143093384"] = {Price = 37, Name = "Antler Table",Category = "Tables"},
	["143093157"] = {Price = 20, Name = "Antler Chair",Category = "Seats"},
	["143095252"] = {Price = 35, Name = "Antler Shelf",Category = "Tables"},
	["141793584"] = {Price = 35, Name = "Antler Bed",Category = "Beds"},
	["142181882"] = {Price = 25, Name = "Antler Lamp",Category = "Lights",TableTopItem = true},
	["392735993"] = {Price = 55, Name = "Antler Bunk Bed",Category = "Beds"},
	["392736620"] = {Price = 50, Name = "Antler Chanelier",Category = "Lights"},


	["143386594"] = {Price = 35, Name = "Outdoors Tent",Category = "Beds"},
	["143385042"] = {Price = 26, Name = "Outdoors Log Table",Category = "Tables"},
	["143385613"] = {Price = 28, Name = "Outdoors Log Bench",Category = "Seats"},
	["143385166"] = {Price = 26, Name = "Outdoors Campfire",Category = "Lights"},
	["143386529"] = {Price = 20, Name = "Outdoors Kayak",Category = "Decoration"},
	["143386703"] = {Price = 32, Name = "Outdoors Tree",Category = "Decoration"},


	["143664531"] = {Price = 12, Name = "Cloud",Category = "Decoration"},
	["143665860"] = {Price = 14, Name = "Cloud Rug",Category = "Decoration"},
	["143664453"] = {Price = 22, Name = "Cloud Seat",Category = "Seats"},
	["143671199"] = {Price = 23, Name = "Cloud Table",Category = "Tables"},
	["143664240"] = {Price = 26, Name = "Cloud Bed",Category = "Beds"},
	["143669382"] = {Price = 18, Name = "Cloud TV",Category = "Entertainment"},
	["143666014"] = {Price = 14, Name = "Cloud Chair",Category = "Seats"},
	
	["143665462"] = {Price = 48, Name = "Model Plane",Category = "Decoration"},
	["143667331"] = {Price = 29, Name = "Sun Light",Category = "Lights"},

	["143838201"] = {Price = 20, Name = "Church Podium",Category = "Decoration"},
	["143838333"] = {Price = 32, Name = "Church Window",Category = "Lights"},
	["143838524"] = {Price = 26, Name = "Church Pew",Category = "Seats"},

	
													-- 20
	["143761910"] = {Price = 38, Name = "Tot Slide",Category = "Entertainment"},
	["143761687"] = {Price = 56, Name = "Tot Swing",Category = "Entertainment"},
	["143761495"] = {Price = 25, Name = "Tot Ceiling Light",Category = "Lights"},
	["143761064"] = {Price = 20, Name = "Tot Bed",Category = "Beds"},
	["143760789"] = {Price = 16, Name = "Tot Lamp",Category = "Lights"},
	["143760560"] = {Price = 22, Name = "Tot Couch",Category = "Seats"},
	["143760415"] = {Price = 12, Name = "Tot Chair",Category = "Seats"},
	["143760169"] = {Price = 19, Name = "Tot Table",Category = "Tables"},
	["143759884"] = {Price = 17, Name = "Tot TV",Category = "Entertainment"},
	["143768047"] = {Price = 12, Name = "Tot Dresser",Category = "Decoration"},
	["143759133"] = {Price = 20, Name = "Tot Bookshelf",Category = "Decoration"},
	["143758961"] = {Price = 44, Name = "Tot Trampoline",Category = "Entertainment"},
	["179717188"] = {Price = 123, Name = "Tot Bounce Castle",Category = "Backyard only"},

	
	
	["143758655"] = {Price = 60, Name = "Modern TV",Category = "Entertainment"},
	["143758332"] = {Price = 68, Name = "Modern Bed",Category = "Beds"},
	["143758189"] = {Price = 60, Name = "Modern Sculpture",Category = "Decoration"},
	["143758058"] = {Price = 61, Name = "Modern Art",Category = "Decoration"},
	["143757684"] = {Price = 58, Name = "Modern Table",Category = "Tables"},
	["143757629"] = {Price = 42, Name = "Modern Coffee Table",Category = "Tables"},
	["143757426"] = {Price = 33, Name = "Modern Chair",Category = "Seats"},
	["143757061"] = {Price = 75, Name = "Modern Couch",Category = "Seats"},
	["143842715"] = {Price = 41, Name = "Modern Ceiling Light",Category = "Lights"},
	["142182087"] = {Price = 56, Name = "Modern Lamp",Category = "Lights"},
	["282210538"] = {Price = 60, Name = "Modern Dresser",Category = "Decoration"},
	["282212547"] = {Price = 58, Name = "Modern Clock",Category = "Decoration"},
	["282204753"] = {Price = 62, Name = "Modern Bookshelf",Category = "Decoration"},
	["282209821"] = {Price = 72, Name = "Modern Armchair",Category = "Seats"},
	["282207719"] = {Price = 79, Name = "Modern Fireplace",Category = "Lights"},


	["198159778"] = {Price = 31, Name = "Patio Chair",Category = "Seats"},
	["198152370"] = {Price = 88, Name = "Patio End Table",Category = "Tables"},
	["198152010"] = {Price = 85, Name = "Patio Table",Category = "Tables"},
	["198151722"] = {Price = 89, Name = "Patio Couch",Category = "Seats"},
	["198151516"] = {Price = 82, Name = "Patio Armchair",Category = "Seats"},
	["198150881"] = {Price = 78, Name = "Patio Coffee Table",Category = "Tables"},
	["198150519"] = {Price = 85, Name = "Patio Chaise",Category = "Seats"},
	["197228065"] = {Price = 270, Name = "Patio Jacuzzi",Category = "Entertainment"},
	["200221440"] = {Price = 340, Name = "Patio Pool",Category = "Entertainment"},
	["392747929"] = {Price = 87, Name = "Patio Umbrella",Category = "Decoration", Discontinued = true},
	
	
	
	["143835312"] = {Price = 189, Name = "Varknox Bed",Category = "Beds"},
	["143835421"] = {Price = 154, Name = "Varknox Wall",Category = "Decoration"},
	["143835549"] = {Price = 193, Name = "Varknox Bubble",Category = "Decoration"},
	["143835664"] = {Price = 110, Name = "Varknox Chair",Category = "Seats"},
	["143835997"] = {Price = 199, Name = "Varknox Couch",Category = "Seats"},
	["143836165"] = {Price = 167, Name = "Varknox Table",Category = "Tables"},
	["143836314"] = {Price = 155, Name = "Varknox Lamp",Category = "Lights"},
	["143836512"] = {Price = 186, Name = "Varknox TV",Category = "Entertainment"},
	

	["143839223"] = {Price = 26, Name = "Princess Ceiling Light",Category = "Lights"},
	["143836854"] = {Price = 46, Name = "Princess Vanity",Category = "Decoration"},
	["143836956"] = {Price = 19, Name = "Princess Chair",Category = "Seats"},
	["143837111"] = {Price = 30, Name = "Princess Bed",Category = "Beds"},
	["143837372"] = {Price = 29, Name = "Princess Tea Set",Category = "Decoration", TableTopItem=true},
	["143837463"] = {Price = 26, Name = "Princess Table",Category = "Tables"},
	["143837994"] = {Price = 32, Name = "Princess Lamp",Category = "Lights"},
	
	
	
	["179723976"] = {Price = 35, Name = "Sky World Table",Category = "Tables"},
	["179724975"] = {Price = 37, Name = "Sky World Couch",Category = "Seats"},
	["179726887"] = {Price = 30, Name = "Sky World Lamp",Category = "Lights"},
	["179727070"] = {Price = 34, Name = "Sky World Coffee Table",Category = "Tables"},
	["179727161"] = {Price = 20, Name = "Sky World Chair",Category = "Seats"},
	["179727311"] = {Price = 42, Name = "Sky World TV",Category = "Entertainment"},
	["179727375"] = {Price = 19, Name = "Sky World Pillar",Category = "Decoration"},
	["179727470"] = {Price = 36, Name = "Sky World Bed",Category = "Beds"},
	["179727700"] = {Price = 30, Name = "Sky World Armchair",Category = "Seats"},

	


	--entertainment
	["143929921"] = {Price = 52, Name = "Gumball Machine",Category = "Entertainment"},
	["143930650"] = {Price = 64, Name = "Cotton Candy Machine",Category = "Entertainment"},	
	["143932424"] = {Price = 64, Name = "Popcorn Machine",Category = "Entertainment"},
	
	["143920685"] = {Price = 61, Name = "Mariachi Guitar",Category = "Entertainment"},
	["143920846"] = {Price = 61, Name = "Banjo",Category = "Entertainment"},
	["143920987"] = {Price = 70, Name = "Grand Piano",Category = "Entertainment"},
	["143921098"] = {Price = 66, Name = "Bass Drum",Category = "Entertainment"},
	["143921200"] = {Price = 90, Name = "Drum Set",Category = "Entertainment"},
	["282205443"] = {Price = 123, Name = "Floor Piano",Category = "Entertainment"},

	["143927276"] = {Price = 100, Name = "Turtle",Category = "Entertainment"},
	["143927375"] = {Price = 95, Name = "Snake",Category = "Entertainment"},
	["143836647"] = {Price = 120, Name = "Princess Pony",Category = "Entertainment"},
	
	["143958301"] = {Price = 46, Name = "Soccer Goal",Category = "Entertainment"},
	["143958391"] = {Price = 89, Name = "Soccer Ball",Category = "Entertainment"},
	["143927780"] = {Price = 58, Name = "Putt-Putt Golf Hole #1",Category = "Entertainment"},
	["143927941"] = {Price = 58, Name = "Putt-Putt Golf Hole #2",Category = "Entertainment"},
	["143928424"] = {Price = 87, Name = "Bowling",Category = "Entertainment"},
	["143927564"] = {Price = 99, Name = "Billiards",Category = "Entertainment"},
	["316671452"] = {Price = 175, Name = "Soda Machine",Category = "Entertainment"},

	
	
	
	--Garden
	["282209168"] = {Price = 5, Name = "Bush",Category = "Decoration"},
	["282208723"] = {Price = 4, Name = "Cobblestone Path",Category = "Decoration"},
	["282211423"] = {Price = 8, Name = "Blue Flowers",Category = "Decoration"},
	["282211900"] = {Price = 8, Name = "Pink Flowers",Category = "Decoration"},

	
	--kitchen/bath
	["143932326"] = {Price = 64, Name = "Stainless Sink",Category = "Kitchen/Bath"},	
	["143932184"] = {Price = 48, Name = "Stainless Microwave",Category = "Kitchen/Bath", TableTopItem=true},	
	["143931927"] = {Price = 51, Name = "Stainless Toaster",Category = "Kitchen/Bath",  TableTopItem=true},	
	["143932047"] = {Price = 76, Name = "Stainless Counter",Category = "Kitchen/Bath"},	
	["143931829"] = {Price = 72, Name = "Stainless Refrigerator",Category = "Kitchen/Bath"},	
	["282211079"] = {Price = 72, Name = "Stainless Cabinet",Category = "Kitchen/Bath"},	
	["282210212"] = {Price = 85, Name = "Stainless Stove",Category = "Kitchen/Bath"},	


	["143930784"] = {Price = 45, Name = "Pink Stove",Category = "Kitchen/Bath"},	
	["143930920"] = {Price = 54, Name = "Pink Sink",Category = "Kitchen/Bath"},	
	["143931023"] = {Price = 48, Name = "Pink Microwave",Category = "Kitchen/Bath", TableTopItem=true},	
	["143931189"] = {Price = 51, Name = "Pink Toaster",Category = "Kitchen/Bath", TableTopItem=true},	
	["143931316"] = {Price = 56, Name = "Pink Counter",Category = "Kitchen/Bath"},	
	["143931593"] = {Price = 72, Name = "Pink Refrigerator",Category = "Kitchen/Bath"},	

	
	["143932557"] = {Price = 120, Name = "Bathroom Shower",Category = "Kitchen/Bath"},	
	["143932883"] = {Price = 110, Name = "Bathroom Toilet",Category = "Kitchen/Bath"},	
	["143932985"] = {Price = 105, Name = "Bathroom Sink",Category = "Kitchen/Bath"},
	
	
	
	
	
	
	----collectables
	["143933513"] = {Price = 45, Name = "Robot",Category = "Collectables"},	
	["143933635"] = {Price = 45, Name = "Stuffed Dragon",Category = "Collectables"},	
	["143933708"] = {Price = 45, Name = "Stuffed Lion",Category = "Collectables"},	
	["143933816"] = {Price = 45, Name = "Stuffed Tiger",Category = "Collectables"},	
	["143933983"] = {Price = 45, Name = "Stuffed Polar Bear",Category = "Collectables"},	
	["141601229"] = {Price = 750, Name = "The Scream",Category = "Collectables"},
	["141601189"] = {Price = 750, Name = "The Persistance of Memory",Category = "Collectables"},
	["141601156"] = {Price = 750, Name = "The Ninth Wave",Category = "Collectables"},
	["141601110"] = {Price = 750, Name = "Sunday Afternoon",Category = "Collectables"},
	["141601045"] = {Price = 750, Name = "Starry Night",Category = "Collectables"},
	["141601017"] = {Price = 750, Name = "Nympheaus",Category = "Collectables"},
	["141600992"] = {Price = 750, Name = "Mona Lisa",Category = "Collectables"},
	["141600523"] = {Price = 750, Name = "Cypresses",Category = "Collectables"},
	["141600508"] = {Price = 750, Name = "Cafe Terrance at Night",Category = "Collectables"},
	["141599507"] = {Price = 750, Name = "American Gothic",Category = "Collectables"},




----WALLS----
	["142751224"] = {Price = 5, Name = "None",Category = "Walls", CategoryId = 1,Discontinued = true, Unsellable = true},
	["188774338"] = {Price = 45, Name = "Candy Cane Wall",Category = "Walls"},
	["188735389"] = {Price = 45, Name = "Snowflake Wall",Category = "Walls"},
	["142981160"] = {Price = 48, Name = "Aquarium Wall",Category = "Walls"},
	["142981503"] = {Price = 71, Name = "Polka Wall",Category = "Walls"},
	["142988390"] = {Price = 60, Name = "Marble Wall",Category = "Walls"},
	["142981169"] = {Price = 63, Name = "Fruity Wall",Category = "Walls"},
	["187726462"] = {Price = 53, Name = "Acorn Wall",Category = "Walls"},
	["142985767"] = {Price = 70, Name = "Turkey Leg Wall",Category = "Walls"},
	["140915921"] = {Price = 51, Name = "Tot Wall",Category = "Walls"},
	["3501220"]   = {Price = 89, Name = "Rock Wall",Category = "Walls"},
	["140127298"] = {Price = 77, Name = "Antler Wall",Category = "Walls"},
	["141535417"] = {Price = 61, Name = "Princess Wall",Category = "Walls"},
	["140191658"] = {Price = 60, Name = "Modern Wall",Category = "Walls"},
	["141561887"] = {Price = 162, Name = "Varknox Wall",Category = "Walls"},
	["142995302"] = {Price = 50, Name = "Void Wall",Category = "Walls"},
	["305574531"] = {Price = 30, Name = "Halloween Wall",Category = "Walls"},
	["304316862"] = {Price = 30, Name = "Jack Wall",Category = "Walls"},
	["304316868"] = {Price = 64, Name = "Aquascape Wall",Category = "Walls"},
	["305594019"] = {Price = 70, Name = "Forest Wall",Category = "Walls"},
	["316654528"] = {Price = 47, Name = "Library Wall",Category = "Walls"},
	["316654495"] = {Price = 69, Name = "Bamboo Wall",Category = "Walls"},
	["316650821"] = {Price = 72, Name = "Traditional Wall",Category = "Walls"},
	["316646023"] = {Price = 61, Name = "Palm Tree Wall",Category = "Walls"},
	["316645953"] = {Price = 56, Name = "Monster Wall",Category = "Walls"},





---FLOORS-----

	["142263417"] = {Price = 10, Name = "Hardwood",Category = "Floors",  Discontinued = true,Unsellable = true},
	["142999362"] = {Price = 30, Name = "Blue Carpet",Category = "Floors"},
	["142998844"] = {Price = 32, Name = "Yellow Carpet",Category = "Floors"},
	["142998003"] = {Price = 38, Name = "Red Carpet",Category = "Floors"},
	["142995520"] = {Price = 20, Name = "Green Carpet",Category = "Floors"},
	["142995494"] = {Price = 20, Name = "Brown Carpet",Category = "Floors"},
	["142995534"] = {Price = 48, Name = "Ice Floor",Category = "Floors"},
	["142995484"] = {Price = 26, Name = "Sand Floor",Category = "Floors"},
	["142996420"] = {Price = 49, Name = "Marble Floor",Category = "Floors"},
	["142998324"] = {Price = 28, Name = "Uhglay Floor",Category = "Floors"},
	["142995736"] = {Price = 16, Name = "Industrial Floor",Category = "Floors"},
	["190244134"] = {Price = 68, Name = "Overlay Floor",Category = "Floors"},
	["190245059"] = {Price = 68, Name = "Inlaid Parquet Floor",Category = "Floors"},
	["142985807"] = {Price = 57, Name = "Aquarium Carpet",Category = "Floors"},	
	["142985797"] = {Price = 44, Name = "Lilly Carpet",Category = "Floors"},
	["142981133"] = {Price = 67, Name = "Stitch Carpet",Category = "Floors"},
	["142956350"] = {Price = 58, Name = "Polka Carpet",Category = "Floors"},
	["142956286"] = {Price = 56, Name = "Jig Floor",Category = "Floors"},
	["142956243"] = {Price = 45, Name = "Plainsawn Floor",Category = "Floors"},
	["142998479"] = {Price = 50, Name = "Void Floor",Category = "Floors"},
	["140913922"] = {Price = 57, Name = "Tot Carpet",Category = "Floors"},
	["141568602"] = {Price = 40, Name = "Outdoors Floor",Category = "Floors"},
	["140107853"] = {Price = 30, Name = "Antler Rug",Category = "Floors"},
	["140191046"] = {Price = 78, Name = "Modern Tile",Category = "Floors"},
	["141535632"] = {Price = 52, Name = "Princess Carpet",Category = "Floors"},
	["179728796"] = {Price = 95, Name = "Sky World Floor",Category = "Floors"},
	["190231424"] = {Price = 98, Name = "Gold Floor",Category = "Floors"},
	["142998700"] = {Price = 100, Name = "Varknox Floor",Category = "Floors"},
	
	["305573676"] = {Price = 25, Name = "Jack Floor",Category = "Floors"},
	["304307028"] = {Price = 46, Name = "X Tile Floor",Category = "Floors"},
	["304313444"] = {Price = 62, Name = "Blue Polly Floor",Category = "Floors"},
	
	["316654650"] = {Price = 44, Name = "Wood Parquet Floor",Category = "Floors"},
	["316645814"] = {Price = 61, Name = "Pinwheel Stone Floor",Category = "Floors"},
	["316645741"] = {Price = 71, Name = "Blackwood Floor",Category = "Floors"},
	["316645696"] = {Price = 57, Name = "Groovy Rug",Category = "Floors"},
	["316645804"] = {Price = 50, Name = "Tile",Category = "Floors"},

	
	
	
	
	
	

	--customizable
	["142269326"] = {Price = 6, Name = "Small Wall",Category = "Customization"},
	["318876288"] = {Price = 6, Name = "Plateform Wall",Category = "Customization"},
	["198245133"] = {Price = 25, Name = "Fake Small Wall",Category = "Customization"},
	["142269444"] = {Price = 12, Name = "Large Wall",Category = "Customization"},
	["142269399"] = {Price = 15, Name = "Stairs",Category = "Customization"},
	["157751266"] = {Price = 29, Name = "Door",Category = "Customization"},
	["157751189"] = {Price = 45, Name = "Friend Door",Category = "Customization"},
	["240481988"] = {Price = 40, Name = "Owner Door",Category = "Customization"},
	["157744805"] = {Price = 180, Name = "Music Player",Category = "Music Players"},
	["157972883"] = {Price = 25, Name = "Multi Light",Category = "Customization"},
	["157972955"] = {Price = 25, Name = "Sign",Category = "Customization",TableTopItem = true},
	["157973341"] = {Price = 40, Name = "Poster",Category = "Customization",TableTopItem = true},
	["157978401"] = {Price = 90, Name = "Shirt Display",Category = "Customization"},
	["157978740"] = {Price = 90, Name = "Pants Display",Category = "Customization"},
	["912780197"] = {Price = 90, Name = "Accessory Display",Category = "Customization",New = 1499861009},

	["240481814"] = {Price = 250, Name = "Kick Button",Category = "Customization"},
	["157973470"] = {Price = 200, Name = "Place Portal",Category = "Customization",TableTopItem = true},
	["282231144"] = {Price = 60, Name = "Robloxian Poster",Category = "Customization",TableTopItem = true},
	["637813231"] = {Price = 19, Name = "Pixel Art Canvas",Category = "Customization",New = 1486140585,DisabledOnConsole = true,TableTopItem = true},
	



--holiday
	["187792383"] = {Price = 45, Name = "Turkey",Category = "Holiday"},
	["187792286"] = {Price = 40, Name = "Thanksgiving Table",Category = "Holiday"},
	["187792204"] = {Price = 36, Name = "Cooked Turkey",Category = "Holiday"},
	["190221433"] = {Price = 20, Name = "Wreath",Category = "Holiday"},
	["190221245"] = {Price = 29, Name = "Snowman",Category = "Holiday"},
	["190220906"] = {Price = 27, Name = "Hanukkah Candles",Category = "Holiday"},
	["190220698"] = {Price = 30, Name = "Christmas Tree",Category = "Holiday"},
	
	["305587034"] = {Price = 15, Name = "Treat Bowl",Category = "Holiday"},
	["305586703"] = {Price = 24, Name = "Jack-O-Lantern",Category = "Holiday"},


	
	
--hats'

	["16630147"] = {Price = 95, Name = "Beautiful Hair for Beautiful People",Category = "Hats"},
	["30331986"] = {Price = 150, Name = "Midnight Shades",Category = "Hats"},	
	["1374269"] = {Price = 140, Name = "Kitty Ears",Category = "Hats"},	
	["151784320"] = {Price = 250, Name = "Doge",Category = "Hats"},	
	["29952810"] = {Price = 120, Name = "America's Sweetheart",Category = "Hats"},	
	["19398258"] = {Price = 90, Name = "Sword Pack",Category = "Hats"},	
	["1309911"] = {Price = 70, Name = "Ninja Mask of Shadows",Category = "Hats"},
	["64444871"] = {Price = 600, Name = "Dominus Messor",Category = "Hats"},
	["19027209"] = {Price = 180, Name = "Perfectly Legitimate Business Hat",Category = "Hats"},
	["13476917"] = {Price = 100, Name = "Goldren Hair",Category = "Hats"},
	["60674565"] = {Price = 80, Name = "8-Ball Headphones",Category = "Hats"},
	["1073690"] = {Price = 200, Name = "JJ5x5's White Top Hat",Category = "Hats"},
	["52554739"] = {Price = 90, Name = "Kuddly Kraken",Category = "Hats"},
	["16412796"] = {Price =170 , Name = "Sk9r Boi",Category = "Hats"},
	["41852455"] = {Price = 110, Name = "Holly Hair",Category = "Hats"},
	["164482409"] = {Price = 90, Name = "Blue Anime Girl Hair",Category = "Hats"},
	["72082328"] = {Price = 210, Name = "Red Sparkle Time Fedora",Category = "Hats"},
	["51352983"] = {Price = 100, Name = "Umadbro?",Category = "Hats"},
	["13745548"] = {Price = 160, Name = "Cinnamon Hair",Category = "Hats"},
	["13477162"] = {Price = 150, Name = "Star Princess Hair",Category = "Hats"},
	["17877340"] = {Price = 60, Name = "Beautiful Brown Hair for Beautiful People",Category = "Hats"},
	["17424092"] = {Price = 60, Name = "Beautiful Hair for Purple People",Category = "Hats"},
	["20372960"] = {Price = 60, Name = "Bed Hair",Category = "Hats"},
	["192565417"] = {Price = 100, Name = "Black Winter Cap",Category = "Hats"},
	["14815761"] = {Price = 90, Name = "Black and Red",Category = "Hats"},
	["170892848"] = {Price = 150, Name = "Grey Cat Tail",Category = "Hats"},
	["1028859"] = {Price = 300, Name = "Pirate Captain's Hat",Category = "Hats"},
	["9254521"] = {Price = 100, Name = "Black Paintball Mask",Category = "Hats"},
	["6379764"] = {Price = 110, Name = "Racing Helmet",Category = "Hats"},
	["151786902"] = {Price = 190, Name = "Neon Green Beautiful Hair",Category = "Hats"},
	["65941351"] = {Price = 200, Name = "Fiery Princess Hair",Category = "Hats"},
	["37208731"] = {Price = 95, Name = "FaBLUElous hair",Category = "Hats"},
	["83013207"] = {Price = 75, Name = "Charming Brown-haired Fellow",Category = "Hats"},
	["1098271"] = {Price = 50, Name = "Mouse Ears",Category = "Hats"},
	["186958188"] = {Price = 200, Name = "Dexter the Monkey",Category = "Hats"},
	["111902832"] = {Price = 50, Name = "Red Animal Hoodie",Category = "Hats"},
	["68259961"] = {Price = 60, Name = "Buddy Baseball Cap",Category = "Hats"},
	["119085797"] = {Price = 90 , Name = "Endless Summer Shades",Category = "Hats"},
	["106709021"] = {Price = 90, Name = "Shoulder Crow",Category = "Hats"},
	["62745990"] = {Price = 95, Name = "Honey Blonde Ponytail",Category = "Hats"},
	["134822978"] = {Price = 150, Name = "Nice Red Bandana",Category = "Hats"},
	["173781209"] = {Price = 200, Name = "Golden Paintball Mask",Category = "Hats"},
	["118280267"] = {Price = 150, Name = "Narwhal",Category = "Hats"},
	["184743065"] = {Price =200 , Name = "Horse with Cowboy Hat",Category = "Hats"},
	["18757806"] = {Price = 400, Name = "W Inc. Designer Sunglasses",Category = "Hats"},
	["1223149"] = {Price = 70, Name = "Pilgrim Hat",Category = "Hats"},
	["42588770"] = {Price =125 , Name = "Gingerbread Man Head",Category = "Hats"},
	["98450218"] = {Price = 390, Name = "Korblox General",Category = "Hats"},
	["16179349"] = {Price = 30, Name = "Mr. Robot",Category = "Hats"},
	["202073256"] = {Price = 120, Name = "Crazy Styles Cap and Shades",Category = "Hats"},
	["202074520"] = {Price = 125, Name = "Camo Durags",Category = "Hats"},
	["106710727"] = {Price = 100, Name = "Whipped Cream Hat",Category = "Hats"},
	["74174927"] = {Price = 50, Name = "Panda Knit",Category = "Hats"},
	["129554183"] = {Price = 150, Name = "Adventure Time Jake Hat",Category = "Hats",DisabledOnConsole = true},
	["15967866"] = {Price = 140, Name = "Tokyokhaos Penguin",Category = "Hats"},
	["192557913"] = {Price = 300, Name = "Sparkling Angel Wings",Category = "Hats"},
	["19399858"] = {Price = 230, Name = "Bat Wings",Category = "Hats"},
	["124754102"] = {Price = 200, Name = "Butterfly Wings",Category = "Hats"},
	["32661648"] = {Price = 70, Name = "Jellyfish",Category = "Hats"},

	
	
	
	
	
	
	
	--GEAR------
	--[""] = {AssetId =, Price = , Name = "",Category = "Gear"},
	["80576967"] = {Price =50 , Name = "Spray Paint",Category = "Gear",DisabledOnConsole = true},
	["163350265"] = {Price =150 , Name = "Fire Breath",Category = "Gear"},
	["31314931"] = {Price =90 , Name = "Epic Sauce",Category = "Gear"},



	["27494652"] = {Price = 75 , Name = "Green Balloon",Category = "Gear"},
	["27133214"] = {Price = 90, Name = "Binoculray",Category = "Gear",DisabledOnConsole = true},
	["30393548"] = {Price = 380, Name = "Grapple Hook",Category = "Gear"},
	["116040770"] = {Price = 50, Name = "Flashlight",Category = "Gear"},
	["193771176"] = {Price =100, Name = "Rockin' Pink Guitar",Category = "Gear",DisabledOnConsole = true},
	["163348987"] = {Price = 100, Name = "Cymbals",Category = "Gear"},
	["20373160"] = {Price = 90, Name = "Cowbell",Category = "Gear"},
	["45094376"] = {Price =130 , Name = "Saxophone",Category = "Gear"},
	
	


	["16688968"] = {Price = 250, Name = "Gravity Coil",Category = "Gear"},
	["21392199"] = {Price = 45, Name = "Chocolate Milk",Category = "Gear"},
	["172248941"] = {Price = 300, Name = "Penguin Power Pet",Category = "Gear"},
	["84012460"] = {Price = 150, Name = "Fluffy Unicorn",Category = "Gear"},
	["58574445"] = {Price = 110, Name = "ROBLOX Portable Game System",Category = "Gear",DisabledOnConsole = true},
	["22596452"] = {Price = 45, Name = "Pepperoni Pizza",Category = "Gear"},
	["26419811"] = {Price = 50, Name = "BANG!",Category = "Gear"},
	["66426103"] = {Price = 120, Name = "Gamaboi",Category = "Gear",DisabledOnConsole = true},
	["12547976"] = {Price =45 , Name = "Space Sandwich",Category = "Gear"},
	["15177716"] = {Price = 55, Name = "Taco",Category = "Gear"},
	["60357989"] = {Price = 80, Name = "Silly Stilts",Category = "Gear"},
	["57229357"] = {Price = 80, Name = "Paper Sword",Category = "Gear"},
	["31839411"] = {Price = 60, Name = "Fire Extinguisher",Category = "Gear"},
	["78367424"] = {Price = 40, Name = "Tiger Friend",Category = "Gear"},

	
	["16726030"] = {Price = 50 , Name = "Cheezburger",Category = "Gear"},
	["46846115"] = {Price = 110, Name = "Ninja Jump Potion",Category = "Gear"},
	["90242059"] = {Price = 130, Name = "Adventure Island",Category = "Gear",DisabledOnConsole = true},	
	["29939404"] = {Price = 50, Name = "Hot Dog",Category = "Gear",DisabledOnConsole = true},
	["46846246"] = {Price = 45, Name = "Panda Friend",Category = "Gear"},
	["25974222"] = {Price = 20, Name = "Beach Ball",Category = "Gear"},
	["176087597"] = {Price = 25, Name = "ROBLOX U Frisbee",Category = "Gear"},
	["13477890"] = {Price = 60, Name = "Pirate Juice",Category = "Gear"},
	["85145662"] = {Price = 190, Name = "Lunar Lander 2D Game",Category = "Gear",DisabledOnConsole = true},
	["22960435"] = {Price = 40, Name = "Protest Sign: Noobs",Category = "Gear"},
	["73829202"] = {Price = 170 , Name = "RoMaze",Category = "Gear",DisabledOnConsole = true},
	["81330766"] = {Price = 400, Name = "Time Watch",Category = "Gear"},
	["99254437"] = {Price = 100, Name = "Ipad",Category = "Gear"},
	["76170545"] = {Price = 160, Name = "Race the Sunset",Category = "Gear",DisabledOnConsole = true},
	["22787248"] = {Price = 55, Name = "Watermelon",Category = "Gear"},
	["76170471"] = {Price = 75, Name = "Hedgehog Friend",Category = "Gear"},
	["28672001"] = {Price = 75, Name = "Goala Cola",Category = "Gear"},
	["18426536"] = {Price = 120, Name = "Apple Pie",Category = "Gear"},
	["12848902"] = {Price = 60, Name = "Teddy Bloxpin",Category = "Gear"},
	["19328185"] = {Price = 20, Name = "Snowball",Category = "Gear",DisabledOnConsole = true},
	["125013769"] = {Price = 75, Name = "Linked Sword",Category = "Gear"},
	--["11895536"] = {Price = 50, Name = "Bloxilicious Bubble Gum",Category = "Gear"},
	["27902303"] = {Price = 400, Name = "ROBLOX Skateboard",Category = "Gear",DisabledOnConsole = true},

	
	
	
	["27112438"] = {Price = 25, Name = "Robloxian 2.0",Category = "Packages"},
	["32336368"] = {Price =190 , Name = "Superhero",Category = "Packages"},
	["27123973"] = {Price = 65, Name = "Mr. Roboto",Category = "Packages"},
	["68539308"] = {Price = 430, Name = "Korblox General",Category = "Packages"},
	["55717536"] = {Price = 100, Name = "Agent 53",Category = "Packages"},
	["36781547"] = {Price = 160, Name = "Skeleton",Category = "Packages"},
	["81728054"] = {Price = 310, Name = "Darkest Assassin",Category = "Packages"},
	["81725506"] = {Price = 400, Name = "The Overseer",Category = "Packages"},
	["37754742"] = {Price = 150, Name = "Zombie",Category = "Packages"},
	["111819141"] = {Price = 175, Name = "PT-ST4 Mobile Armor Unit",Category = "Packages"},
	["101744863"] = {Price = 390, Name = "Alar Knight of Splintered Skies",Category = "Packages"},
	["37152980"] = {Price = 95, Name = "Mummy",Category = "Packages"},
	["54657028"] = {Price = 160, Name = "Bounty Hunter",Category = "Packages"},
	["28270115"] = {Price = 50, Name = "Spaceman",Category = "Packages"},
	["46359272"] = {Price = 200, Name = "Penguin",Category = "Packages"},
	["41851073"] = {Price = 140, Name = "Santa Claus",Category = "Packages"},
	["28676049"] = {Price = 170, Name = "Magnabot",Category = "Packages"},
	["101716993"] = {Price = 320, Name = "Redcliff Elite Commander",Category = "Packages"},
	["116791553"] = {Price = 160, Name = "The Crook",Category = "Packages"},
	["42264953"] = {Price = 75, Name = "Snowman",Category = "Packages"},
	["41797703"] = {Price = 100, Name = "Elf",Category = "Packages"},
	["136801384"] = {Price = 310, Name = "Bludroid: Ev1LR0b0t",Category = "Packages"},
	["150339976"] = {Price = 300, Name = "Sparkle Time Bundle",Category = "Packages"},
	["137715213"] = {Price = 190 , Name = "Polar Bear",Category = "Packages"},
	["139619549"] = {Price = 100, Name = "Wanwood Bundle",Category = "Packages"},
	["107451588"] = {Price = 150, Name = "Firefighter",Category = "Packages"},
	["187996626"] = {Price = 220, Name = "Snow Queen",Category = "Packages"},
	["98755232"] = {Price = 75, Name = "General Badblox",Category = "Packages"},
	["193700907"] = {Price = 250 , Name = "Circuit Breaker",Category = "Packages"},
	["133558623"] = {Price = 120, Name = "Walking Fred",Category = "Packages"},
	["66255196"] = {Price = 95, Name = "Pilgrim",Category = "Packages"},
	["146176898"] = {Price = 200, Name = "Blue Collar Cat",Category = "Packages"},
	["42588579"] = {Price = 210, Name = "Gingerbread Man",Category = "Packages"},
	["56475793"] = {Price = 150, Name = "The Finnster",Category = "Packages"},
	["54116460"] = {Price = 180, Name = "Mr. Robot",Category = "Packages"},
		


	["44116233"] = {Discontinued = true,Price = 300, Name = "Megaphone",Category = "Gear"},	

	["18479357"] = {Discontinued = true,Price = 220, Name = "Boomerang",Category = "Gear"},
	["55301897"] = {Discontinued = true, Price = 140, Name = "Baseball Bat",Category = "Gear"},
	["18210455"] = {Discontinued = true,Price = 190, Name = "Four-In-A-Row",Category = "Gear"},
	["16924676"] = {Discontinued = true,Price = 210, Name = "Tic Tac Toe Board",Category = "Gear"},

	["27471379"] = {Discontinued = true,Price = 200 , Name = "Battle Wagons!",Category = "Gear"},
	["29532138"] = {Discontinued = true,Price = 65, Name = "Bloxxy Radar",Category = "Gear"},
	["201756469"] = {Discontinued = true,Price = 120, Name = "Smashing Guitar",Category = "Gear"},
}

--for testing furniture that is being developed -- creates temporary catalog item
if game.PlaceId == 0 then
	local tempAssetIds = {}
	for _,obj in ipairs(workspace:GetChildren()) do
		if obj:FindFirstChild("TestMode") and obj.TestMode.Value then
			local AssetId = math.random(100000,900000)
			local name =  "Testing" .. math.random(1,1000)
			local tableTopItem = obj:FindFirstChild("TableTopItem") ~= nil
			table.insert(tempAssetIds,AssetId)
			obj.Parent = script["Beds"]
			MainModule.AssetLibrary[tostring(AssetId)] = {Price = 1, Name = name,Category = "Beds", Object = obj,TableTopItem = tableTopItem}
		end
	end
	
	local function giveItem(player)
		while Global.Players[player] == nil do wait(.1) end
		for _,assetId in ipairs(tempAssetIds) do
			table.insert(Global.Players[player].Inventory,{AssetId = assetId, Quantity = 1})
		end
	end
	
	game.Players.PlayerAdded:connect(function(player)
		giveItem(player)		
	end)
	for _,player in ipairs(game.Players:GetChildren()) do
		giveItem(player)
	end
end



--add object field
for id,data in pairs(MainModule.AssetLibrary) do
	if script:FindFirstChild(data.Category) and script[data.Category]:FindFirstChild(data.Name) then
		pcall(function() --if a mistake was made, the enitre catalog wont break
			MainModule.AssetLibrary[id].Object = script[data.Category][data.Name] --object associated with data
			if data.TableTopItem then
				local tableTopItem = Instance.new("IntValue")
				tableTopItem.Name = "TableTopItem"
				tableTopItem.Parent = data.Object
			end
		end)
	end
	MainModule.AssetLibrary[id].Price = MainModule.AssetLibrary[id].Price * 15
end


--thumbnail cameras might still be inside, also need to lock all the furniture
function FindAndDestroyCamera(dir)
	if dir:IsA("Camera") then
		dir:Destroy()
	else
		for _,obj in ipairs(dir:GetChildren()) do
			if obj:IsA("BasePart") and not(obj:IsA("VehicleSeat") or obj:IsA("Seat")) then
				obj.Locked = true
				--obj.Anchored = true
			end
			FindAndDestroyCamera(obj)
		end
	end
end
FindAndDestroyCamera(script)




function round(a,b)
	return math.floor((a/b)+0.5)*b
end 

function roundUp(a,b)
	if a - math.floor(a) < .1 then
		return round(a,b)
	end
	return math.ceil(a / b) * b
end


function AddBorder(furniture,data,gridSize)
	
	
	if furniture:FindFirstChild("Border")  then  
		furniture.PrimaryPart = furniture.Border 
		
		local pointer = Instance.new("ObjectValue")
		pointer.Name = "BorderPointer"
		pointer.Value = furniture.Border
		pointer.Parent = furniture
		
		local selectionBox = Instance.new("SelectionBox")
		selectionBox.Adornee =  furniture.Border
		selectionBox.LineThickness = 0.001
		selectionBox.Color3 = Color3.new(1,1,1)
		selectionBox.Parent = furniture.Border
		
		return 
	end

	local furnitureSize, furniturePosition = Utility:GetModelGlobalSizeAndPosition(furniture)

	
	local border = Instance.new("Part")
	border.Anchored = true
	border.Transparency = 1
	border.Name = "Border"
	border.CanCollide = false
	border.FormFactor = 0
	border.Locked = true
	border.Size = Vector3.new(roundUp(furnitureSize.x,gridSize),roundUp(furnitureSize.y,gridSize),roundUp(furnitureSize.z,gridSize))
	border.CFrame = CFrame.new(furniturePosition) + Vector3.new(0,(roundUp(furnitureSize.y,gridSize) - furnitureSize.y)/2,0)
	border.Parent = furniture
	furniture.PrimaryPart = border
	
	
	--[[local axis = nil
	if data.Offset == "x" then
		axis = furniture_size.x
	elseif data.Offset == "y" then
		axis = furniture_size.y
	else
		axis = furniture_size.z
	end
	border.CFrame = furniture_cframe + Vector3.new(0,(roundUp(axis,gridSize) - furniture_size.y)/2,0)

	]]


	local pointer = Instance.new("ObjectValue")
	pointer.Name = "BorderPointer"
	pointer.Value = border
	pointer.Parent = furniture
	
	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Adornee = border
	selectionBox.LineThickness = 0.001
	selectionBox.Color3 = Color3.new(1,1,1)
	selectionBox.Parent = border
	
end




for id,data in pairs(MainModule.AssetLibrary) do
	local object = data.Object
	if object and object:IsA("Model") then
		
		if data.TableTopItem then
			AddBorder(object,data,1)
		else
			AddBorder(object,data,4)
		end
		
		--lock all parts everything
		for _,obj in ipairs(object:GetChildren()) do
			if obj:IsA("BasePart") then
				obj.Locked = true
			end
		end
		
	end		
end



return MainModule
