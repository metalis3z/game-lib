



local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__GetAnimalBoundingBox__2 = require(l__ReplicatedStorage__1.Shared.GetAnimalBoundingBox);
return {
	Taco = {
		Display = "Taco",
		DisplayWithRichText = "<font color=\"#FFDE59\">Taco</font>",
		Icon = "rbxassetid://89041930759464",
		MultiplierModifier = 2,
		Color = Color3.fromRGB(255, 222, 89)
	},
	Burger = {
		Display = "Burger",
		DisplayWithRichText = "<font color=\"#E8A33D\">Burger</font>",
		Icon = "rbxassetid://137182370107419",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(232, 163, 61)
	},
	Nyan = {
		Display = "Nyan",
		DisplayWithRichText = "<font color=\"#EE59FF\">Nyan</font>",
		Icon = "rbxassetid://104229924295526",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(238, 89, 255)
	},
	Galactic = {
		Display = "Galactic",
		DisplayWithRichText = "<font color=\"#7D59FF\">Galactic</font>",
		Icon = "rbxassetid://99181785766598",
		MultiplierModifier = 3,
		Color = Color3.fromRGB(125, 89, 255)
	},
	Fireworks = {
		Display = "Fireworks",
		DisplayWithRichText = "<font color=\"#FF2828\">Fireworks</font>",
		Icon = "rbxassetid://121100427764858",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(255, 40, 40)
	},
	Zombie = {
		Display = "Zombie",
		DisplayWithRichText = "<font color=\"#4aff47\">Zombie</font>",
		Icon = "rbxassetid://110723387483939",
		MultiplierModifier = 4,
		Color = Color3.fromRGB(74, 255, 71)
	},
	Claws = {
		Display = "Claws",
		DisplayWithRichText = "<font color=\"#eb391a\">Crab Claws</font>",
		Icon = "rbxassetid://104964195846833",
		MultiplierModifier = 4,
		Color = Color3.fromRGB(235, 57, 26),
		Modify = function(p1, _, p2) 
			p1.Size = p2:GetAttribute("Size") or p1.Size;
		end
	},
	Glitched = {
		Display = "Glitched",
		DisplayWithRichText = "<font color=\"#a75edf\">Glitch</font>",
		Icon = "rbxassetid://121332433272976",
		MultiplierModifier = 4,
		Color = Color3.fromRGB(167, 94, 223)
	},
	Bubblegum = {
		Display = "Bubblegum",
		DisplayWithRichText = "<font color=\"#f058fe\">Bubblegum</font>",
		Icon = "rbxassetid://100601425541874",
		MultiplierModifier = 3,
		Color = Color3.fromRGB(240, 88, 254)
	},
	Fire = {
		Display = "Fire",
		DisplayWithRichText = "<font color=\"#ffaa00\">Fire</font>",
		Icon = "rbxassetid://118283346037788",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(255, 170, 0)
	},
	Wet = {
		Display = "Wet",
		DisplayWithRichText = "<font color=\"#1F85DE\">Wet</font>",
		Icon = "rbxassetid://78474194088770",
		MultiplierModifier = 1.5,
		Color = Color3.fromRGB(30, 130, 220)
	},
	Snowy = {
		Display = "Snowy",
		DisplayWithRichText = "<font color=\"#FFFFFF\">Snowy</font>",
		Icon = "rbxassetid://83627475909869",
		MultiplierModifier = 2,
		Color = Color3.fromRGB(255, 255, 255)
	},
	Cometstruck = {
		Display = "Comet-struck",
		DisplayWithRichText = "<font color=\"#ae1fde\">Comet-struck</font>",
		Icon = "rbxassetid://127455440418221",
		MultiplierModifier = 2.5,
		Color = Color3.fromRGB(175, 30, 220)
	},
	Explosive = {
		Display = "Explosive",
		DisplayWithRichText = "<font color=\"#ff9d26\">Explosive</font>",
		Icon = "rbxassetid://97725744252608",
		MultiplierModifier = 3,
		Color = Color3.fromRGB(255, 170, 0),
		ModifyVFX = function(p3)
			require(l__ReplicatedStorage__1.Shared.VFX).emitLoop(p3, 4);
		end
	},
	Disco = {
		Display = "Disco",
		DisplayWithRichText = "<font color=\"#e863ff\">Disco</font>",
		Icon = "rbxassetid://82620342632406",
		MultiplierModifier = 4,
		Color = Color3.fromRGB(232, 99, 255)
	},
	["10B"] = {
		Display = "10B",
		DisplayWithRichText = "<font color=\"#FF2828\">10B</font>",
		Icon = "rbxassetid://134655415681926",
		MultiplierModifier = 3,
		Color = Color3.fromRGB(255, 40, 40)
	},
	["Shark Fin"] = {
		Display = "Shark Fin",
		DisplayWithRichText = "<font color=\"#1F85DE\">Shark Fin</font>",
		Icon = "rbxassetid://104985313532149",
		MultiplierModifier = 3,
		Color = Color3.fromRGB(30, 130, 220)
	},
	["Matteo Hat"] = {
		Display = "Matteo Hat",
		DisplayWithRichText = "<font color=\"#ff961d\">Matteo Hat</font>",
		Icon = "rbxassetid://115664804212096",
		MultiplierModifier = 3.5,
		Color = Color3.fromRGB(255, 150, 29)
	},
	Brazil = {
		Display = "Brazil",
		DisplayWithRichText = "<font color=\"#00ff00\">Brazil</font>",
		Icon = "rbxassetid://75650816341229",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(0, 255, 0)
	},
	Sleepy = {
		Display = "Sleepy",
		DisplayWithRichText = "<font color=\"#2747ff\">Sleepy</font>",
		Icon = "rbxassetid://115001117876534",
		MultiplierModifier = 0,
		Color = Color3.fromRGB(39, 71, 255)
	},
	Lightning = {
		Display = "Lightning",
		DisplayWithRichText = "<font color=\"#2747ff\">Lightning</font>",
		Icon = "rbxassetid://139729696247144",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(0, 229, 255)
	},
	UFO = {
		Display = "UFO",
		DisplayWithRichText = "<font color=\"#00ff00\">UFO</font>",
		Icon = "rbxassetid://110910518481052",
		MultiplierModifier = 2,
		Color = Color3.fromRGB(0, 255, 0)
	},
	Spider = {
		Display = "Spider",
		DisplayWithRichText = "<font color=\"#fff\">Spider</font>",
		Icon = "rbxassetid://117478971325696",
		MultiplierModifier = 3.5,
		Color = Color3.fromRGB(255, 255, 255)
	},
	Strawberry = {
		Display = "Strawberry",
		DisplayWithRichText = "<font color=\"#e82638\">Strawberry</font>",
		Icon = "rbxassetid://84731118566493",
		MultiplierModifier = 8,
		Color = Color3.fromRGB(232, 38, 56)
	},
	Paint = {
		Display = "Paint",
		DisplayWithRichText = "<font color=\"#ffc800\">Paint</font>",
		Icon = "rbxassetid://119591742504251",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(255, 200, 0),
		ModifyVFX = function(p4, p5)
			p4.Attachment.WorldPosition = p5.Parent:GetPivot().Position;
		end
	},
	Skeleton = {
		Display = "Skeleton",
		DisplayWithRichText = "<font color=\"#fff\">Skeleton</font>",
		Icon = "rbxassetid://89591838221335",
		MultiplierModifier = 3,
		Color = Color3.fromRGB(255, 255, 255)
	},
	Sombrero = {
		Display = "Sombrero",
		DisplayWithRichText = "<font color=\"#fac711\">Sombrero</font>",
		Icon = "rbxassetid://95128039793845",
		MultiplierModifier = 4,
		Color = Color3.fromRGB(250, 199, 17)
	},
	Tie = {
		Display = "Tie",
		DisplayWithRichText = "<font color=\"#f00\">Tie</font>",
		Icon = "rbxassetid://103610037004911",
		MultiplierModifier = 3.75,
		Color = Color3.fromRGB(255, 0, 0)
	},
	["Witch Hat"] = {
		Display = "Witch Hat",
		DisplayWithRichText = "<font color=\"#7f51cf\">Witch Hat</font>",
		Icon = "rbxassetid://123964048606874",
		MultiplierModifier = 3,
		Color = Color3.fromRGB(127, 81, 207)
	},
	Sun = {
		Display = "Sun",
		DisplayWithRichText = "<font color=\"#ffc800\">Sun</font>",
		Icon = "rbxassetid://129835149959879",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(255, 200, 0)
	},
	Indonesia = {
		Display = "Indonesia",
		DisplayWithRichText = "<font color=\"#fb3d29\">Indonesia</font>",
		Icon = "rbxassetid://93350414974589",
		MultiplierModifier = 4,
		Color = Color3.fromRGB(251, 61, 41)
	},
	Meowl = {
		Display = "Meowl",
		DisplayWithRichText = "<font color=\"#ffffff\">Meowl</font>",
		Icon = "rbxassetid://114748221761549",
		MultiplierModifier = 7,
		Color = Color3.fromRGB(255, 255, 255)
	},
	["RIP Gravestone"] = {
		Display = "RIP Gravestone",
		DisplayWithRichText = "<font color=\"#ffffff\">RIP Gravestone</font>",
		Icon = "rbxassetid://123115843719383",
		MultiplierModifier = 3.5,
		Color = Color3.fromRGB(255, 255, 255)
	},
	["Jackolantern Pet"] = {
		Display = "Jackolantern Pet",
		DisplayWithRichText = "<font color=\"#ff9d26\">Jackolantern Pet</font>",
		Icon = "rbxassetid://97054765273857",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(255, 170, 0)
	},
	["Santa Hat"] = {
		Display = "Santa Hat",
		DisplayWithRichText = "<font color=\"#ce4d4c\">Santa Hat</font>",
		Icon = "rbxassetid://88375043733582",
		MultiplierModifier = 4,
		Color = Color3.fromRGB(206, 77, 76)
	},
	["Reindeer Pet"] = {
		Display = "Reindeer Pet",
		DisplayWithRichText = "<font color=\"#ffffff\">Reindeer Pet</font>",
		Icon = "rbxassetid://70894779883038",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(255, 255, 255)
	},
	Skibidi = {
		Display = "Skibidi",
		DisplayWithRichText = "<font color=\"#ffffff\">Skibidi</font>",
		Icon = "rbxassetid://83384385019272",
		MultiplierModifier = 6,
		Color = Color3.fromRGB(255, 255, 255)
	},
	["26"] = {
		Display = "26",
		DisplayWithRichText = "<font color=\"#ffed2c\">26</font>",
		Icon = "rbxassetid://80468035315420",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(255, 237, 44)
	},
	["1 Year"] = {
		Display = "1 Year",
		DisplayWithRichText = "<font color=\"#ffd700\">1 Year</font>",
		Icon = "rbxassetid://139663830647832",
		MultiplierModifier = 5.5,
		Color = Color3.fromRGB(255, 215, 0)
	},
	Rose = {
		Display = "Rose",
		DisplayWithRichText = "<font color=\"#d95050\">Rose</font>",
		Icon = "rbxassetid://135489065859287",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(217, 80, 80)
	},
	Mango = {
		Display = "Mango",
		DisplayWithRichText = "<font color=\"##D1A939\">Mango</font>",
		Icon = "rbxassetid://79294008051790",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(217, 175, 6)
	},
	[":3"] = {
		Display = ":3",
		DisplayWithRichText = "<font color=\"#fff\">:3</font>",
		Icon = "rbxassetid://108293878529172",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(255, 255, 255)
	},
	Chocolate = {
		Display = "Chocolate",
		DisplayWithRichText = "<font color=\"#713600\">Chocolate</font>",
		Icon = "rbxassetid://81641382604997",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(113, 54, 0),
		ModifyVFX = function(p6, p7) 
			p6.Attachment.WorldPosition = p7.Parent:GetPivot().Position;
		end
	},
	Halo = {
		Display = "Halo",
		DisplayWithRichText = "<font color=\"#ffd13b\">Halo</font>",
		Icon = "rbxassetid://98316436141359",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(255, 209, 59)
	},
	Lucky = {
		Display = "Lucky",
		DisplayWithRichText = "<font color=\"#8ee33f\">Lucky</font>",
		Icon = "rbxassetid://124098467754457",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(142, 227, 63),
		ModifyVFX = function(p8, p9, p10) 
			local _, v11 = l__GetAnimalBoundingBox__2(p10, p9.Parent);
			p8.Attachment.WorldPosition = p9.Parent:GetPivot().Position + Vector3.new(0, v11.Y, 0);
		end
	},
	["Orange Balloon"] = {
		Display = "Orange Balloon",
		DisplayWithRichText = "<font color=\'#fc781c\'>Orange Balloon</font>",
		Icon = "rbxassetid://83111173051279",
		MultiplierModifier = 3,
		Color = Color3.fromRGB(252, 120, 28)
	},
	["Green Balloon"] = {
		Display = "Green Balloon",
		DisplayWithRichText = "<font color=\'#38e953\'>Green Balloon</font>",
		Icon = "rbxassetid://75222826429094",
		MultiplierModifier = 3.5,
		Color = Color3.fromRGB(56, 233, 83)
	},
	["Blue Balloon"] = {
		Display = "Blue Balloon",
		DisplayWithRichText = "<font color=\'#3b80ef\'>Blue Balloon</font>",
		Icon = "rbxassetid://128841931686463",
		MultiplierModifier = 4,
		Color = Color3.fromRGB(59, 128, 239)
	},
	["Red Balloon"] = {
		Display = "Red Balloon",
		DisplayWithRichText = "<font color=\'#e22a2a\'>Red Balloon</font>",
		Icon = "rbxassetid://119661964026012",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(226, 42, 42)
	},
	["Pink Balloon"] = {
		Display = "Pink Balloon",
		DisplayWithRichText = "<font color=\'#f83d92\'>Pink Balloon</font>",
		Icon = "rbxassetid://114128099162490",
		MultiplierModifier = 5.5,
		Color = Color3.fromRGB(248, 61, 146)
	},
	["Rainbow Balloon"] = {
		Display = "Rainbow Balloon",
		DisplayWithRichText = "<rainbow>Rainbow Balloon</rainbow>",
		Icon = "rbxassetid://112821854659961",
		MultiplierModifier = 6.5,
		Color = Color3.fromRGB(255, 255, 255)
	},
	Granny = {
		Display = "Granny",
		DisplayWithRichText = "<font color=\"#ffffff\">Granny</font>",
		Icon = "rbxassetid://73467619616299",
		MultiplierModifier = 5.5,
		Color = Color3.fromRGB(255, 255, 255)
	},
	["Bunny Ears"] = {
		Display = "Bunny Ears",
		DisplayWithRichText = "<font color=\"#ff6086\">Bunny Ears</font>",
		Icon = "rbxassetid://118516289496954",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(244, 92, 129)
	},
	["Orange Egg"] = {
		Display = "Orange Egg",
		DisplayWithRichText = "<font color=\'#fc781c\'>Orange Egg</font>",
		Icon = "rbxassetid://76307362192037",
		MultiplierModifier = 3,
		Color = Color3.fromRGB(252, 120, 28)
	},
	["Green Egg"] = {
		Display = "Green Egg",
		DisplayWithRichText = "<font color=\'#38e953\'>Green Egg</font>",
		Icon = "rbxassetid://94602857440295",
		MultiplierModifier = 4,
		Color = Color3.fromRGB(56, 233, 83)
	},
	["Blue Egg"] = {
		Display = "Blue Egg",
		DisplayWithRichText = "<font color=\'#3b80ef\'>Blue Egg</font>",
		Icon = "rbxassetid://109212886335786",
		MultiplierModifier = 5,
		Color = Color3.fromRGB(59, 128, 239)
	},
	["Pink Egg"] = {
		Display = "Pink Egg",
		DisplayWithRichText = "<font color=\'#f83d92\'>Pink Egg</font>",
		Icon = "rbxassetid://133939661230277",
		MultiplierModifier = 6.5,
		Color = Color3.fromRGB(248, 61, 146)
	},
	["John Pork"] = {
		Display = "John Pork",
		DisplayWithRichText = "<font color=\"#ea8a83\">John Pork</font>",
		Icon = "rbxassetid://117176397136731",
		MultiplierModifier = 6.5,
		Color = Color3.fromRGB(234, 138, 131),
		OverheadDisplayName = function(p12)
			return `{p12} is Calling...`;
		end
	},
	["Aura Shades"] = {
		Display = "Aura Shades",
		DisplayWithRichText = "<font color=\'#fff\'>Aura Shades</font>",
		Icon = "rbxassetid://89908570233459",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(255, 255, 255)
	},
	Algeria = {
		Display = "Algeria",
		DisplayWithRichText = "<font color=\"#006233\">Algeria</font>",
		Icon = "rbxassetid://126645378937712",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 98, 51)
	},
	Argentina = {
		Display = "Argentina",
		DisplayWithRichText = "<font color=\"#74ACDF\">Argentina</font>",
		Icon = "rbxassetid://79796660874224",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(116, 172, 223)
	},
	Australia = {
		Display = "Australia",
		DisplayWithRichText = "<font color=\"#012169\">Australia</font>",
		Icon = "rbxassetid://94936867305620",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(1, 33, 105)
	},
	Austria = {
		Display = "Austria",
		DisplayWithRichText = "<font color=\"#ED2939\">Austria</font>",
		Icon = "rbxassetid://102600837969356",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(237, 41, 57)
	},
	Belgium = {
		Display = "Belgium",
		DisplayWithRichText = "<font color=\"#FDDA24\">Belgium</font>",
		Icon = "rbxassetid://113264720821551",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(253, 218, 36)
	},
	["Bosnia and Herzegovina"] = {
		Display = "Bosnia and Herzegovina",
		DisplayWithRichText = "<font color=\"#0038A8\">Bosnia and Herzegovina</font>",
		Icon = "rbxassetid://72934644401407",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 56, 168)
	},
	Canada = {
		Display = "Canada",
		DisplayWithRichText = "<font color=\"#FF0000\">Canada</font>",
		Icon = "rbxassetid://133805277922190",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(255, 0, 0)
	},
	["Cape Verde"] = {
		Display = "Cape Verde",
		DisplayWithRichText = "<font color=\"#003893\">Cape Verde</font>",
		Icon = "rbxassetid://89265279654526",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 56, 147)
	},
	Colombia = {
		Display = "Colombia",
		DisplayWithRichText = "<font color=\"#FCD116\">Colombia</font>",
		Icon = "rbxassetid://77527478867878",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(252, 209, 22)
	},
	Croatia = {
		Display = "Croatia",
		DisplayWithRichText = "<font color=\"#FF0000\">Croatia</font>",
		Icon = "rbxassetid://81727700273645",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(255, 0, 0)
	},
	Curacao = {
		Display = "Curacao",
		DisplayWithRichText = "<font color=\"#0038A8\">Curacao</font>",
		Icon = "rbxassetid://135407688815556",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 56, 168)
	},
	Czechia = {
		Display = "Czechia",
		DisplayWithRichText = "<font color=\"#11457E\">Czechia</font>",
		Icon = "rbxassetid://116629639484837",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(17, 69, 126)
	},
	["DR Congo"] = {
		Display = "DR Congo",
		DisplayWithRichText = "<font color=\"#007FFF\">DR Congo</font>",
		Icon = "rbxassetid://131131447033897",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 127, 255)
	},
	Ecuador = {
		Display = "Ecuador",
		DisplayWithRichText = "<font color=\"#FFDD00\">Ecuador</font>",
		Icon = "rbxassetid://91374775921195",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(255, 221, 0)
	},
	Egypt = {
		Display = "Egypt",
		DisplayWithRichText = "<font color=\"#CE1126\">Egypt</font>",
		Icon = "rbxassetid://118941157278248",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(206, 17, 38)
	},
	England = {
		Display = "England",
		DisplayWithRichText = "<font color=\"#C8102E\">England</font>",
		Icon = "rbxassetid://70728023584718",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(200, 16, 46)
	},
	France = {
		Display = "France",
		DisplayWithRichText = "<font color=\"#0055A4\">France</font>",
		Icon = "rbxassetid://139926928202319",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 85, 164)
	},
	Germany = {
		Display = "Germany",
		DisplayWithRichText = "<font color=\"#FFCE00\">Germany</font>",
		Icon = "rbxassetid://119225017636613",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(255, 206, 0)
	},
	Ghana = {
		Display = "Ghana",
		DisplayWithRichText = "<font color=\"#CE1126\">Ghana</font>",
		Icon = "rbxassetid://122390908548402",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(206, 17, 38)
	},
	Haiti = {
		Display = "Haiti",
		DisplayWithRichText = "<font color=\"#00209F\">Haiti</font>",
		Icon = "rbxassetid://84305039147128",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 32, 159)
	},
	Iran = {
		Display = "Iran",
		DisplayWithRichText = "<font color=\"#239F40\">Iran</font>",
		Icon = "rbxassetid://89785490933486",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(35, 159, 64)
	},
	Iraq = {
		Display = "Iraq",
		DisplayWithRichText = "<font color=\"#CE1126\">Iraq</font>",
		Icon = "rbxassetid://74578622541535",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(206, 17, 38)
	},
	["Ivory Coast"] = {
		Display = "Ivory Coast",
		DisplayWithRichText = "<font color=\"#FF8200\">Ivory Coast</font>",
		Icon = "rbxassetid://84590645227432",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(255, 130, 0)
	},
	Japan = {
		Display = "Japan",
		DisplayWithRichText = "<font color=\"#BC002D\">Japan</font>",
		Icon = "rbxassetid://93737073361391",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(188, 0, 45)
	},
	Jordan = {
		Display = "Jordan",
		DisplayWithRichText = "<font color=\"#CE1126\">Jordan</font>",
		Icon = "rbxassetid://97466255701928",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(206, 17, 38)
	},
	Mexico = {
		Display = "Mexico",
		DisplayWithRichText = "<font color=\"#006847\">Mexico</font>",
		Icon = "rbxassetid://89360098281385",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 104, 71)
	},
	Morocco = {
		Display = "Morocco",
		DisplayWithRichText = "<font color=\"#C1272D\">Morocco</font>",
		Icon = "rbxassetid://94977806542548",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(193, 39, 45)
	},
	Netherlands = {
		Display = "Netherlands",
		DisplayWithRichText = "<font color=\"#AE1C28\">Netherlands</font>",
		Icon = "rbxassetid://81971617885521",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(174, 28, 40)
	},
	["New Zealand"] = {
		Display = "New Zealand",
		DisplayWithRichText = "<font color=\"#002269\">New Zealand</font>",
		Icon = "rbxassetid://136057500217480",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 34, 105)
	},
	Norway = {
		Display = "Norway",
		DisplayWithRichText = "<font color=\"#BA0C2F\">Norway</font>",
		Icon = "rbxassetid://97010965749109",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(186, 12, 47)
	},
	Panama = {
		Display = "Panama",
		DisplayWithRichText = "<font color=\"#00205B\">Panama</font>",
		Icon = "rbxassetid://90138376478527",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 32, 91)
	},
	Paraguay = {
		Display = "Paraguay",
		DisplayWithRichText = "<font color=\"#D52B1E\">Paraguay</font>",
		Icon = "rbxassetid://139994983531343",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(213, 43, 30)
	},
	Portugal = {
		Display = "Portugal",
		DisplayWithRichText = "<font color=\"#006600\">Portugal</font>",
		Icon = "rbxassetid://71132525336687",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 102, 0)
	},
	Qatar = {
		Display = "Qatar",
		DisplayWithRichText = "<font color=\"#8B1538\">Qatar</font>",
		Icon = "rbxassetid://139731424483232",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(139, 21, 56)
	},
	["Saudi Arabia"] = {
		Display = "Saudi Arabia",
		DisplayWithRichText = "<font color=\"#006C35\">Saudi Arabia</font>",
		Icon = "rbxassetid://97076334125382",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 108, 53)
	},
	Scotland = {
		Display = "Scotland",
		DisplayWithRichText = "<font color=\"#005EB8\">Scotland</font>",
		Icon = "rbxassetid://97401954626323",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 94, 184)
	},
	Senegal = {
		Display = "Senegal",
		DisplayWithRichText = "<font color=\"#00853F\">Senegal</font>",
		Icon = "rbxassetid://114894433972350",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 133, 63)
	},
	["South Africa"] = {
		Display = "South Africa",
		DisplayWithRichText = "<font color=\"#007749\">South Africa</font>",
		Icon = "rbxassetid://88634993180325",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 119, 73)
	},
	["South Korea"] = {
		Display = "South Korea",
		DisplayWithRichText = "<font color=\"#CD2E3A\">South Korea</font>",
		Icon = "rbxassetid://136456304313107",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(205, 46, 58)
	},
	Spain = {
		Display = "Spain",
		DisplayWithRichText = "<font color=\"#C6002B\">Spain</font>",
		Icon = "rbxassetid://125927208337856",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(198, 0, 43)
	},
	Sweden = {
		Display = "Sweden",
		DisplayWithRichText = "<font color=\"#006AA7\">Sweden</font>",
		Icon = "rbxassetid://108275156059907",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 106, 167)
	},
	Switzerland = {
		Display = "Switzerland",
		DisplayWithRichText = "<font color=\"#FF0000\">Switzerland</font>",
		Icon = "rbxassetid://122360641367339",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(255, 0, 0)
	},
	Tunisia = {
		Display = "Tunisia",
		DisplayWithRichText = "<font color=\"#E70013\">Tunisia</font>",
		Icon = "rbxassetid://125638572659205",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(231, 0, 19)
	},
	Turkey = {
		Display = "Turkey",
		DisplayWithRichText = "<font color=\"#E30A17\">Turkey</font>",
		Icon = "rbxassetid://71740682353857",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(227, 10, 23)
	},
	["United States"] = {
		Display = "United States",
		DisplayWithRichText = "<font color=\"#0a3161\">United States</font>",
		Icon = "rbxassetid://92441507391370",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(10, 49, 97)
	},
	Uruguay = {
		Display = "Uruguay",
		DisplayWithRichText = "<font color=\"#0038A8\">Uruguay</font>",
		Icon = "rbxassetid://102848070326629",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 56, 168)
	},
	Uzbekistan = {
		Display = "Uzbekistan",
		DisplayWithRichText = "<font color=\"#0099B5\">Uzbekistan</font>",
		Icon = "rbxassetid://116936548725229",
		MultiplierModifier = 4.5,
		Color = Color3.fromRGB(0, 153, 181)
	}
};