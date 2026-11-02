local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GetAnimalBoundingBox = require(ReplicatedStorage.Shared.GetAnimalBoundingBox)

local Traits = {
	["Kinoshi"] = {
		["Display"] = "Kinoshi",
		["DisplayWithRichText"] = "<font color=\"#22D3B8\">Kinoshi</font>",
		["Icon"] = "rbxassetid://0",
		["Color"] = Color3.fromRGB(34, 211, 184),
		["MultiplierModifier"] = 3
	},
	["Zynna"] = {
		["Display"] = "Zynna",
		["DisplayWithRichText"] = "<font color=\"#FF6B35\">Zynna</font>",
		["Icon"] = "rbxassetid://104006381175015",
		["Color"] = Color3.fromRGB(255, 107, 53),
		["MultiplierModifier"] = 7
	},
	["Teykx Lazer"] = {
		["Display"] = "Teykx Lazer",
		["DisplayWithRichText"] = "<font color=\"#FF2E00\">Teykx Lazer</font>",
		["Icon"] = "rbxassetid://84320788301745",
		["Color"] = Color3.fromRGB(255, 46, 0),
		["MultiplierModifier"] = 4
	},
	["Ibrx"] = {
		["Display"] = "Ibrx",
		["DisplayWithRichText"] = "<font color=\"#FF3B3B\">Ibrx</font>",
		["Icon"] = "rbxassetid://0",
		["Color"] = Color3.fromRGB(255, 59, 59),
		["MultiplierModifier"] = 3
	},
	["Taco"] = {
		["Display"] = "Taco",
		["DisplayWithRichText"] = "<font color=\"#FFDE59\">Taco</font>",
		["Icon"] = "rbxassetid://89041930759464",
		["Color"] = Color3.fromRGB(255, 222, 89),
		["MultiplierModifier"] = 2
	},
	["Nyan"] = {
		["Display"] = "Nyan",
		["DisplayWithRichText"] = "<font color=\"#EE59FF\">Nyan</font>",
		["Icon"] = "rbxassetid://104229924295526",
		["Color"] = Color3.fromRGB(238, 89, 255),
		["MultiplierModifier"] = 5
	},
	["STBANCAL"] = {
		["Display"] = "STBANCAL",
		["DisplayWithRichText"] = "<font color=\"#fac711\">STBANCAL</font>",
		["Icon"] = "rbxassetid://110271462660027",
		["Color"] = Color3.fromRGB(250, 199, 17),
		["MultiplierModifier"] = 4
	},
	["Galactic"] = {
		["Display"] = "Galactic",
		["DisplayWithRichText"] = "<font color=\"#7D59FF\">Galactic</font>",
		["Icon"] = "rbxassetid://99181785766598",
		["Color"] = Color3.fromRGB(125, 89, 255),
		["MultiplierModifier"] = 3
	},
	["1 Year"] = {
		["Display"] = "1 Year",
		["DisplayWithRichText"] = "<font color=\"#ffd700\">1 Year</font>",
		["Icon"] = "rbxassetid://139663830647832",
		["MultiplierModifier"] = 5.5,
		["Color"] = Color3.fromRGB(255, 215, 0)
	},
	["1K Visits"] = {
		["Display"] = "1K Visits",
		["DisplayWithRichText"] = "<font color=\"#ffd700\">1K Visits</font>",
		["Icon"] = "rbxassetid://115946704048808",
		["MultiplierModifier"] = 5.5,
		["Color"] = Color3.fromRGB(255, 215, 0)
	},
	["Hacked"] = {
		["Display"] = "Hacked",
		["DisplayWithRichText"] = "<font color=\"#ffd700\">Hacked</font>",
		["Icon"] = "rbxassetid://95522207794336",
		["MultiplierModifier"] = 5.5,
		["Color"] = Color3.fromRGB(63, 157, 0)
	},
	["Fireworks"] = {
		["Display"] = "Fireworks",
		["DisplayWithRichText"] = "<font color=\"#FF2828\">Fireworks</font>",
		["Icon"] = "rbxassetid://121100427764858",
		["Color"] = Color3.fromRGB(255, 40, 40),
		["MultiplierModifier"] = 5
	},
	["John Pork"] = {
		["Display"] = "John Pork",
		["DisplayWithRichText"] = "<font color=\"#ea8a83\">John Pork</font>",
		["Icon"] = "rbxassetid://117176397136731",
		["MultiplierModifier"] = 5.5,
		["Color"] = Color3.fromRGB(234, 138, 131),
	},
	["Zombie"] = {
		["Display"] = "Zombie",
		["DisplayWithRichText"] = "<font color=\"#4aff47\">Zombie</font>",
		["Icon"] = "rbxassetid://110723387483939",
		["Color"] = Color3.fromRGB(74, 255, 71),
		["MultiplierModifier"] = 4
	},
	["Elexir"] = {
		["Display"] = "Elexir",
		["DisplayWithRichText"] = "<font color=\"#fff\">Elexir</font>",
		["Icon"] = "rbxassetid://125968291703122",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 3
	},
	["Claws"] = {
		["Display"] = "Claws",
		["DisplayWithRichText"] = "<font color=\"#eb391a\">Crab Claws</font>",
		["Icon"] = "rbxassetid://104964195846833",
		["Color"] = Color3.fromRGB(235, 57, 26),
		["MultiplierModifier"] = 4,
		["Modify"] = function(p3, _, p4)
			p3.Size = p4:GetAttribute("Size") or p3.Size
		end
	},
	["Mario"] = {
		["Display"] = "Mario",
		["DisplayWithRichText"] = "<font color=\"#7D59FF\">Mario</font>",
		["Icon"] = "rbxassetid://126322864419001",
		["Color"] = Color3.fromRGB(125, 89, 255),
		["MultiplierModifier"] = 3
	},
	["Glitched"] = {
		["Display"] = "Glitched",
		["DisplayWithRichText"] = "<font color=\"#a75edf\">Glitch</font>",
		["Icon"] = "rbxassetid://121332433272976",
		["Color"] = Color3.fromRGB(167, 94, 223),
		["MultiplierModifier"] = 4
	},
	["Bubblegum"] = {
		["Display"] = "Bubblegum",
		["DisplayWithRichText"] = "<font color=\"#f058fe\">Bubblegum</font>",
		["Icon"] = "rbxassetid://100601425541874",
		["Color"] = Color3.fromRGB(240, 88, 254),
		["MultiplierModifier"] = 3
	},
	["Fire"] = {
		["Display"] = "Fire",
		["DisplayWithRichText"] = "<font color=\"#ffaa00\">Fire</font>",
		["Icon"] = "rbxassetid://118283346037788",
		["Color"] = Color3.fromRGB(255, 170, 0),
		["MultiplierModifier"] = 5
	},
	["GUIGUI"] = {
		["Display"] = "GUIGUI",
		["DisplayWithRichText"] = "<font color=\"#fff\">:3</font>",
		["Icon"] = "rbxassetid://131697802157066",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 5.5
	},
	["Wet"] = {
		["Display"] = "Wet",
		["DisplayWithRichText"] = "<font color=\"#1F85DE\">Wet</font>",
		["Icon"] = "rbxassetid://78474194088770",
		["Color"] = Color3.fromRGB(30, 130, 220),
		["MultiplierModifier"] = 1.5
	},
	["Italy"] = {
		["Display"] = "Italy",
		["DisplayWithRichText"] = "<font color=\"#fff\">Italy</font>",
		["Icon"] = "rbxassetid://127778510443888",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 9
	},
	["Snowy"] = {
		["Display"] = "Snowy",
		["DisplayWithRichText"] = "<font color=\"#FFFFFF\">Snowy</font>",
		["Icon"] = "rbxassetid://83627475909869",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 2
	},
	["Cometstruck"] = {
		["Display"] = "Comet-struck",
		["DisplayWithRichText"] = "<font color=\"#ae1fde\">Comet-struck</font>",
		["Icon"] = "rbxassetid://127455440418221",
		["Color"] = Color3.fromRGB(175, 30, 220),
		["MultiplierModifier"] = 2.5
	},
	["Explosive"] = {
		["Display"] = "Explosive",
		["DisplayWithRichText"] = "<font color=\"#ff9d26\">Explosive</font>",
		["Icon"] = "rbxassetid://97725744252608",
		["Color"] = Color3.fromRGB(255, 170, 0),
		["MultiplierModifier"] = 3,
		["ModifyVFX"] = function(p5)
			require(ReplicatedStorage.Shared.VFX).emitLoop(p5, 4)
		end
	},
	["Disco"] = {
		["Display"] = "Disco",
		["DisplayWithRichText"] = "<font color=\"#e863ff\">Disco</font>",
		["Icon"] = "rbxassetid://82620342632406",
		["Color"] = Color3.fromRGB(232, 99, 255),
		["MultiplierModifier"] = 4
	},
	["10B"] = {
		["Display"] = "10B",
		["DisplayWithRichText"] = "<font color=\"#FF2828\">10B</font>",
		["Icon"] = "rbxassetid://134655415681926",
		["Color"] = Color3.fromRGB(255, 40, 40),
		["MultiplierModifier"] = 3
	},
	["Jul"] = {
		["Display"] = "Jul",
		["DisplayWithRichText"] = "<font color=\"#fff\">Jul</font>",
		["Icon"] = "rbxassetid://135345658692857",
		["Color"] = Color3.fromRGB(165, 255, 242),
		["MultiplierModifier"] = 4.
	},
	["Shark Fin"] = {
		["Display"] = "Shark Fin",
		["DisplayWithRichText"] = "<font color=\"#1F85DE\">Shark Fin</font>",
		["Icon"] = "rbxassetid://104985313532149",
		["Color"] = Color3.fromRGB(30, 130, 220),
		["MultiplierModifier"] = 3
	},
	["Matteo Hat"] = {
		["Display"] = "Matteo Hat",
		["DisplayWithRichText"] = "<font color=\"#ff961d\">Matteo Hat</font>",
		["Icon"] = "rbxassetid://115664804212096",
		["Color"] = Color3.fromRGB(255, 150, 29),
		["MultiplierModifier"] = 3.5
	},
	["Brazil"] = {
		["Display"] = "Brazil",
		["DisplayWithRichText"] = "<font color=\"#00ff00\">Brazil</font>",
		["Icon"] = "rbxassetid://75650816341229",
		["Color"] = Color3.fromRGB(0, 255, 0),
		["MultiplierModifier"] = 5
	},
	["Lightning"] = {
		["Display"] = "Lightning",
		["DisplayWithRichText"] = "<font color=\"#2747ff\">Lightning</font>",
		["Icon"] = "rbxassetid://139729696247144",
		["Color"] = Color3.fromRGB(0, 229, 255),
		["MultiplierModifier"] = 5
	},
	["UFO"] = {
		["Display"] = "UFO",
		["DisplayWithRichText"] = "<font color=\"#00ff00\">UFO</font>",
		["Icon"] = "rbxassetid://110910518481052",
		["Color"] = Color3.fromRGB(0, 255, 0),
		["MultiplierModifier"] = 2
	},
	["Spider"] = {
		["Display"] = "Spider",
		["DisplayWithRichText"] = "<font color=\"#fff\">Spider</font>",
		["Icon"] = "rbxassetid://117478971325696",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 3.5
	},
	["Strawberry"] = {
		["Display"] = "Strawberry",
		["DisplayWithRichText"] = "<font color=\"#e82638\">Strawberry</font>",
		["Icon"] = "rbxassetid://84731118566493",
		["Color"] = Color3.fromRGB(232, 38, 56),
		["MultiplierModifier"] = 7
	},
	["Paint"] = {
		["Display"] = "Paint",
		["DisplayWithRichText"] = "<font color=\"#ffc800\">Paint</font>",
		["Icon"] = "rbxassetid://119591742504251",
		["Color"] = Color3.fromRGB(255, 200, 0),
		["MultiplierModifier"] = 5,
		["ModifyVFX"] = function(p6, p7)
			p6.Attachment.WorldPosition = p7.Parent:GetPivot().Position
		end
	},
	["Skeleton"] = {
		["Display"] = "Skeleton",
		["DisplayWithRichText"] = "<font color=\"#fff\">Skeleton</font>",
		["Icon"] = "rbxassetid://89591838221335",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 3
	},
	["Sombrero"] = {
		["Display"] = "Sombrero",
		["DisplayWithRichText"] = "<font color=\"#fac711\">Sombrero</font>",
		["Icon"] = "rbxassetid://95128039793845",
		["Color"] = Color3.fromRGB(250, 199, 17),
		["MultiplierModifier"] = 4
	},
	["Tie"] = {
		["Display"] = "Tie",
		["DisplayWithRichText"] = "<font color=\"#f00\">Tie</font>",
		["Icon"] = "rbxassetid://103610037004911",
		["Color"] = Color3.fromRGB(255, 0, 0),
		["MultiplierModifier"] = 3.75
	},
	["Witch Hat"] = {
		["Display"] = "Witch Hat",
		["DisplayWithRichText"] = "<font color=\"#7f51cf\">Witch Hat</font>",
		["Icon"] = "rbxassetid://123964048606874",
		["Color"] = Color3.fromRGB(127, 81, 207),
		["MultiplierModifier"] = 3
	},
	["Headless"] = {
		["Display"] = "Headless",
		["DisplayWithRichText"] = "<font color=\"#7f51cf\">Headless</font>",
		["Icon"] = "rbxassetid://90165009413959",
		["Color"] = Color3.fromRGB(127, 81, 207),
		["MultiplierModifier"] = 3
	},
	["France"] = {
		["Display"] = "France",
		["DisplayWithRichText"] = "<font color=\"#002395\">France</font>",
		["Icon"] = "rbxassetid://106911992417567",
		["Color"] = Color3.fromRGB(0, 35, 149),
		["MultiplierModifier"] = 4
	},
	["Meowl"] = {
		["Display"] = "Meowl",
		["DisplayWithRichText"] = "<font color=\"#ffffff\">Meowl</font>",
		["Icon"] = "rbxassetid://114748221761549",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 6
	},
	["RIP Gravestone"] = {
		["Display"] = "RIP Gravestone",
		["DisplayWithRichText"] = "<font color=\"#ffffff\">RIP Gravestone</font>",
		["Icon"] = "rbxassetid://123115843719383",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 3.5
	},
	["Jackolantern Pet"] = {
		["Display"] = "Jackolantern Pet",
		["DisplayWithRichText"] = "<font color=\"#ff9d26\">Jackolantern Pet</font>",
		["Icon"] = "rbxassetid://97054765273857",
		["Color"] = Color3.fromRGB(255, 170, 0),
		["MultiplierModifier"] = 4.5
	},
	["Burger"] = {
		["Display"] = "Burger",
		["DisplayWithRichText"] = "<font color=\"#FFDE59\">Burger</font>",
		["Icon"] = "rbxassetid://77322633360169",
		["Color"] = Color3.fromRGB(255, 222, 89),
		["MultiplierModifier"] = 2
	},
	["Santa Hat"] = {
		["Display"] = "Santa Hat",
		["DisplayWithRichText"] = "<font color=\"#ce4d4c\">Santa Hat</font>",
		["Icon"] = "rbxassetid://88375043733582",
		["Color"] = Color3.fromRGB(206, 77, 76),
		["MultiplierModifier"] = 4
	},
	["Reindeer Pet"] = {
		["Display"] = "Reindeer Pet",
		["DisplayWithRichText"] = "<font color=\"#ffffff\">Reindeer Pet</font>",
		["Icon"] = "rbxassetid://70894779883038",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 5
	},
	["Indonesia"] = {
		["Display"] = "Indonesia",
		["DisplayWithRichText"] = "<font color=\"#fb3d29\">Indonesia</font>",
		["Icon"] = "rbxassetid://93350414974589",
		["Color"] = Color3.fromRGB(251, 61, 41),
		["MultiplierModifier"] = 4
	},
	["Skibidi"] = {
		["Display"] = "Skibidi",
		["DisplayWithRichText"] = "<font color=\"#ffffff\">Skibidi</font>",
		["Icon"] = "rbxassetid://83384385019272",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 5.5
	},
	["26"] = {
		["Display"] = "26",
		["DisplayWithRichText"] = "<font color=\"#ffed2c\">26</font>",
		["Icon"] = "rbxassetid://80468035315420",
		["Color"] = Color3.fromRGB(255, 237, 44),
		["MultiplierModifier"] = 5
	},
	["Rose"] = {
		["Display"] = "Rose",
		["DisplayWithRichText"] = "<font color=\"#d95050\">Rose</font>",
		["Icon"] = "rbxassetid://135489065859287",
		["Color"] = Color3.fromRGB(217, 80, 80),
		["MultiplierModifier"] = 5
	},
	[":3"] = {
		["Display"] = ":3",
		["DisplayWithRichText"] = "<font color=\"#fff\">:3</font>",
		["Icon"] = "rbxassetid://108293878529172",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 4.5
	},
	["Chocolate"] = {
		["Display"] = "Chocolate",
		["DisplayWithRichText"] = "<font color=\"#713600\">Chocolate</font>",
		["Icon"] = "rbxassetid://81641382604997",
		["Color"] = Color3.fromRGB(113, 54, 0),
		["MultiplierModifier"] = 4.5,
		["ModifyVFX"] = function(p8, p9)
			p8.Attachment.WorldPosition = p9.Parent:GetPivot().Position
		end
	},
	["Halo"] = {
		["Display"] = "Halo",
		["DisplayWithRichText"] = "<font color=\"#ffd13b\">Halo</font>",
		["Icon"] = "rbxassetid://98316436141359",
		["Color"] = Color3.fromRGB(255, 209, 59),
		["MultiplierModifier"] = 5
	},
	["Lucky"] = {
		["Display"] = "Lucky",
		["DisplayWithRichText"] = "<font color=\"#8ee33f\">Lucky</font>",
		["Icon"] = "rbxassetid://124098467754457",
		["Color"] = Color3.fromRGB(142, 227, 63),
		["MultiplierModifier"] = 5,
		["ModifyVFX"] = function(p10, p11, p12)
			local _, v13 = GetAnimalBoundingBox(p12, p11.Parent)
			local v14 = p10.Attachment
			local v15 = p11.Parent:GetPivot().Position
			local v16 = v13.Y
			v14.WorldPosition = v15 + Vector3.new(0, v16, 0)
		end
	},
	["Werenoi"] = {
		["Display"] = "Werenoi",
		["DisplayWithRichText"] = "<font color=\"#fff\">Werenoi</font>",
		["Icon"] = "rbxassetid://126534755073771",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 6
	},
	["Orange Balloon"] = {
		["Display"] = "Orange Balloon",
		["DisplayWithRichText"] = "<font color=\'#fc781c\'>Orange Balloon</font>",
		["Icon"] = "rbxassetid://83111173051279",
		["Color"] = Color3.fromRGB(252, 120, 28),
		["MultiplierModifier"] = 3
	},
	["Green Balloon"] = {
		["Display"] = "Green Balloon",
		["DisplayWithRichText"] = "<font color=\'#38e953\'>Green Balloon</font>",
		["Icon"] = "rbxassetid://75222826429094",
		["Color"] = Color3.fromRGB(56, 233, 83),
		["MultiplierModifier"] = 3.5
	},
	["Blue Balloon"] = {
		["Display"] = "Blue Balloon",
		["DisplayWithRichText"] = "<font color=\'#3b80ef\'>Blue Balloon</font>",
		["Icon"] = "rbxassetid://128841931686463",
		["Color"] = Color3.fromRGB(59, 128, 239),
		["MultiplierModifier"] = 4
	},
	["Red Balloon"] = {
		["Display"] = "Red Balloon",
		["DisplayWithRichText"] = "<font color=\'#e22a2a\'>Red Balloon</font>",
		["Icon"] = "rbxassetid://119661964026012",
		["Color"] = Color3.fromRGB(226, 42, 42),
		["MultiplierModifier"] = 5
	},
	["Pink Balloon"] = {
		["Display"] = "Pink Balloon",
		["DisplayWithRichText"] = "<font color=\'#f83d92\'>Pink Balloon</font>",
		["Icon"] = "rbxassetid://114128099162490",
		["Color"] = Color3.fromRGB(248, 61, 146),
		["MultiplierModifier"] = 5.5
	},
	["Rainbow Balloon"] = {
		["Display"] = "Rainbow Balloon",
		["DisplayWithRichText"] = "<rainbow>Rainbow Balloon</rainbow>",
		["Icon"] = "rbxassetid://112821854659961",
		["Color"] = Color3.fromRGB(255, 255, 255),
		["MultiplierModifier"] = 6.5
	},
	["Bunny Ears"] = {
		["Display"] = "Bunny Ears",
		["DisplayWithRichText"] = "<font color=\"#ff6086\">Bunny Ears</font>",
		["Icon"] = "rbxassetid://118516289496954",
		["Color"] = Color3.fromRGB(244, 92, 129),
		["MultiplierModifier"] = 4.5
	},

	["3K"] = {
		["Display"] = "3K",
		["DisplayWithRichText"] = "<font color=\"#FFD700\">3K</font>",
		["Icon"] = "rbxassetid://99653748686171",
		["Color"] = Color3.fromRGB(255, 215, 0),
		["MultiplierModifier"] = 13
	}
}

return Traits