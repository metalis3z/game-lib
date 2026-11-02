-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Slimes, time of decompilation: Sun May  3 10:12:40 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Recipes = require(ReplicatedStorage.Source.Features.Crafting.Recipes)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local t1 = {
	goopy = {
		name = "Goopy",
		weight = 1000000000000,
		damage = 4,
		health = 10,
		image = "rbxassetid://125014847814930",
		minZone = 0,
		invertedIcon = "rbxassetid://85906060374520",
		invertedTexture = "rbxassetid://79837892186578",
		colors = {
			Color3.fromRGB(139, 255, 44),
			Color3.fromRGB(0, 201, 124)
		}
	},
	sunset = {
		name = "Sunset",
		weight = 500000000000,
		damage = 5,
		health = 15,
		image = "rbxassetid://121554969636389",
		minZone = 0,
		invertedIcon = "rbxassetid://127474402104672",
		invertedTexture = "rbxassetid://121678853060004",
		colors = {
			Color3.fromRGB(255, 93, 168),
			Color3.fromRGB(255, 117, 107)
		}
	},
	fin = {
		name = "Fin",
		weight = 300000000000,
		damage = 6,
		health = 20,
		image = "rbxassetid://87279507965562",
		minZone = 0,
		invertedIcon = "rbxassetid://129625732691594",
		invertedTexture = "rbxassetid://112760530020068",
		colors = {
			Color3.fromRGB(93, 158, 255),
			Color3.fromRGB(107, 233, 255)
		}
	},
	leafy = {
		name = "Leafy",
		weight = 200000000000,
		damage = 7,
		health = 22,
		image = "rbxassetid://110387483496665",
		invertedIcon = "rbxassetid://108360820555238",
		invertedTexture = "rbxassetid://118524160689284",
		minZone = 0,
		colors = {
			Color3.fromRGB(93, 255, 161),
			Color3.fromRGB(18, 212, 0)
		}
	},
	cat = {
		name = "Meow",
		weight = 62000000000,
		damage = 8,
		health = 27,
		image = "rbxassetid://90044737038788",
		invertedIcon = "rbxassetid://128060204890132",
		invertedTexture = "rbxassetid://132812756290035",
		minZone = 0,
		colors = {
			Color3.fromRGB(189, 156, 107),
			Color3.fromRGB(119, 92, 73)
		}
	},
	glo = {
		name = "Glo",
		weight = 38000000000,
		damage = 10,
		health = 30,
		image = "rbxassetid://71398008901155",
		invertedIcon = "rbxassetid://81249348733318",
		invertedTexture = "rbxassetid://140250012094592",
		minZone = 0
	},
	buggy = {
		name = "Buggy",
		weight = 21000000000,
		damage = 13,
		health = 36,
		image = "rbxassetid://127031604553936",
		invertedIcon = "rbxassetid://88228259754645",
		invertedTexture = "rbxassetid://97660993793456",
		minZone = 0
	},
	boomy = {
		name = "Boomy",
		weight = 13500000000,
		damage = 15,
		health = 43,
		image = "rbxassetid://122256067182359",
		invertedIcon = "rbxassetid://104307038380040",
		invertedTexture = "rbxassetid://140200884877752",
		minZone = 0
	},
	brutis = {
		name = "Brutis",
		weight = 8200000000,
		damage = 18,
		health = 50,
		image = "rbxassetid://96141106213410",
		invertedIcon = "rbxassetid://119274072453430",
		invertedTexture = "rbxassetid://100258609853570",
		minZone = 0
	},
	frankenSlime = {
		name = "Frankenslime",
		weight = 5200000000,
		damage = 20,
		health = 60,
		image = "rbxassetid://101295677521483",
		invertedIcon = "rbxassetid://115607458747725",
		invertedTexture = "rbxassetid://78835996001653",
		minZone = 0
	},
	orca = {
		name = "Orca",
		weight = 3000000000,
		damage = 25,
		health = 72,
		iconSize = 1.3,
		image = "rbxassetid://81818054985491",
		invertedIcon = "rbxassetid://106483258231131",
		invertedTexture = "rbxassetid://118557011227562",
		minZone = 0,
		iconPosition = UDim2.fromScale(0.5, 0.54)
	},
	spike = {
		name = "Spike",
		weight = 1700000000,
		damage = 29,
		health = 88,
		image = "rbxassetid://121766812104264",
		invertedIcon = "rbxassetid://80080440209259",
		invertedTexture = "rbxassetid://102166619223485",
		minZone = 0
	},
	axolotl = {
		name = "Axolotl",
		weight = 900000000,
		damage = 36,
		health = 105,
		iconSize = 1.26,
		image = "rbxassetid://138568829545430",
		invertedIcon = "rbxassetid://98795565302798",
		invertedTexture = "rbxassetid://136323963468290",
		minZone = 1,
		iconPosition = UDim2.fromScale(0.5, 0.55)
	},
	spidey = {
		name = "Spidey",
		weight = 504000000,
		damage = 43,
		health = 121,
		image = "rbxassetid://110453196439519",
		invertedIcon = "rbxassetid://140302511372352",
		invertedTexture = "rbxassetid://125693396113039",
		minZone = 1
	},
	mushy = {
		name = "Mushy",
		weight = 277000000,
		damage = 50,
		health = 148,
		iconSize = 1.26,
		image = "rbxassetid://132119790080032",
		invertedIcon = "rbxassetid://107640014368924",
		invertedTexture = "rbxassetid://82657568780091",
		minZone = 2,
		iconPosition = UDim2.fromScale(0.5, 0.5)
	},
	rocky = {
		name = "Rocky",
		weight = 155000000,
		damage = 58,
		health = 176,
		image = "rbxassetid://119389913033936",
		invertedIcon = "rbxassetid://79865000080086",
		invertedTexture = "rbxassetid://117138055594724",
		minZone = 3
	},
	lucky = {
		name = "Lucky",
		weight = 100000000,
		damage = 67,
		health = 200,
		image = "rbxassetid://88659965344315",
		invertedIcon = "rbxassetid://99807835263719",
		invertedTexture = "rbxassetid://123293380905111",
		minZone = 3
	},
	stump = {
		name = "Stump",
		weight = 60000000,
		damage = 75,
		health = 232,
		image = "rbxassetid://104526065478721",
		invertedIcon = "rbxassetid://121036958160211",
		invertedTexture = "rbxassetid://84459008141209",
		minZone = 4
	},
	lily = {
		name = "Lily",
		weight = 40000000,
		damage = 85,
		health = 256,
		image = "rbxassetid://129955402880609",
		invertedIcon = "rbxassetid://72593899369526",
		invertedTexture = "rbxassetid://103497194039595",
		minZone = 4
	},
	icy = {
		name = "Icy",
		weight = 25000000,
		damage = 96,
		health = 290,
		image = "rbxassetid://107549341119743",
		invertedIcon = "rbxassetid://109775863929944",
		invertedTexture = "rbxassetid://134224310942680",
		minZone = 5
	},
	orbit = {
		name = "Orbit",
		weight = 17000000,
		damage = 115,
		health = 344,
		iconSize = 1.15,
		image = "rbxassetid://134237961759276",
		invertedIcon = "rbxassetid://125314529469682",
		invertedTexture = "rbxassetid://75748661466616",
		minZone = 5
	},
	aegis = {
		name = "Aegis",
		weight = 10000000,
		damage = 138,
		health = 414,
		iconSize = 1.45,
		image = "rbxassetid://129596888311355",
		invertedIcon = "rbxassetid://108085324756765",
		invertedTexture = "rbxassetid://134753168360710",
		minZone = 6,
		iconPosition = UDim2.fromScale(0.5, 0.55)
	},
	wicked = {
		name = "Wicked",
		weight = 6600000,
		damage = 166,
		health = 496,
		iconSize = 1.05,
		image = "rbxassetid://90719636941813",
		invertedIcon = "rbxassetid://103420791517756",
		invertedTexture = "rbxassetid://121613615106947",
		minZone = 6,
		iconPosition = UDim2.fromScale(0.5, 0.45)
	},
	king = {
		name = "King",
		weight = 4000000,
		damage = 189,
		health = 567,
		image = "rbxassetid://136394505623341",
		invertedIcon = "rbxassetid://136111504461042",
		invertedTexture = "rbxassetid://127034402275248",
		minZone = 7
	},
	guest = {
		name = "Guest",
		weight = 2500000,
		damage = 208,
		health = 624,
		image = "rbxassetid://106886986086246",
		invertedIcon = "rbxassetid://121021946951601",
		invertedTexture = "rbxassetid://85390874982371",
		minZone = 7
	},
	ninja = {
		name = "Ninja",
		weight = 1700000,
		damage = 230,
		health = 690,
		image = "rbxassetid://71329585399252",
		invertedIcon = "rbxassetid://111800035489128",
		invertedTexture = "rbxassetid://133639753100907",
		minZone = 8
	},
	buzz = {
		name = "Buzz",
		weight = 1000000,
		damage = 270,
		health = 810,
		iconSize = 1.1,
		image = "rbxassetid://91579123196118",
		invertedIcon = "rbxassetid://77369424956128",
		invertedTexture = "rbxassetid://90804668049911",
		minZone = 8,
		iconPosition = UDim2.fromScale(0.5, 0.55)
	},
	stormy = {
		name = "Stormy",
		weight = 700000,
		damage = 291,
		health = 870,
		iconSize = 1.4,
		image = "rbxassetid://138295134331622",
		invertedIcon = "rbxassetid://104384217949600",
		invertedTexture = "rbxassetid://90194956104587",
		minZone = 9,
		iconPosition = UDim2.fromScale(0.5, 0.45)
	},
	bucky = {
		name = "Bucky",
		weight = 450000,
		damage = 333,
		health = 999,
		iconSize = 1.35,
		image = "rbxassetid://120383542839889",
		invertedIcon = "rbxassetid://111037484001791",
		invertedTexture = "rbxassetid://107611046047904",
		minZone = 9,
		iconPosition = UDim2.fromScale(0.5, 0.35)
	},
	pokey = {
		name = "Pokey",
		weight = 300000,
		damage = 371,
		health = 1111,
		iconSize = 1.15,
		image = "rbxassetid://101200748535156",
		invertedIcon = "rbxassetid://73243943479555",
		invertedTexture = "rbxassetid://78586241879885",
		minZone = 10,
		iconPosition = UDim2.fromScale(0.5, 0.54)
	},
	slimeSlime = {
		name = "SlimeSlime",
		weight = 200000,
		damage = 419,
		health = 1256,
		image = "rbxassetid://83334448391499",
		invertedIcon = "rbxassetid://83233891233271",
		invertedTexture = "rbxassetid://134766812443908",
		minZone = 10
	},
	unicorn = {
		name = "Unicorn",
		weight = 120000,
		damage = 508,
		health = 1524,
		iconSize = 1.1,
		image = "rbxassetid://82469966827101",
		invertedIcon = "rbxassetid://103087954899923",
		invertedTexture = "rbxassetid://89744338964620",
		minZone = 11,
		iconPosition = UDim2.fromScale(0.5, 0.475)
	},
	wizzy = {
		name = "Wizzy",
		weight = 80000,
		damage = 612,
		health = 1836,
		iconSize = 1.35,
		image = "rbxassetid://84211538001633",
		invertedIcon = "rbxassetid://81154618851526",
		invertedTexture = "rbxassetid://84818163570523",
		minZone = 11,
		iconPosition = UDim2.fromScale(0.5, 0.35)
	},
	flour = {
		name = "Petal",
		weight = 55000,
		damage = 734,
		health = 2300,
		iconSize = 1.05,
		image = "rbxassetid://124937734770442",
		invertedIcon = "rbxassetid://123934345186686",
		invertedTexture = "rbxassetid://80699920458811",
		minZone = 12
	},
	shelly = {
		name = "Shelly",
		weight = 35000,
		damage = 880,
		health = 2640,
		iconSize = 1.05,
		image = "rbxassetid://113644834208086",
		invertedIcon = "rbxassetid://117384577731612",
		invertedTexture = "rbxassetid://87801106525511",
		minZone = 12
	},
	derpy = {
		name = "Derpy",
		weight = 24000,
		damage = 1050,
		health = 3150,
		image = "rbxassetid://107448058521795",
		invertedIcon = "rbxassetid://118269206109875",
		invertedTexture = "rbxassetid://104165550003115",
		minZone = 13
	},
	otto = {
		name = "Octo",
		weight = 16000,
		damage = 1260,
		health = 3780,
		iconSize = 1.45,
		image = "rbxassetid://139658326612671",
		invertedIcon = "rbxassetid://80824078516810",
		invertedTexture = "rbxassetid://137270347918433",
		minZone = 13,
		iconPosition = UDim2.fromScale(0.5, 0.55)
	},
	halo = {
		name = "Halo",
		weight = 11000,
		damage = 1512,
		health = 4500,
		image = "rbxassetid://119632823896702",
		invertedIcon = "rbxassetid://116301649192056",
		invertedTexture = "rbxassetid://136537219938383",
		minZone = 14,
		iconPosition = UDim2.fromScale(0.5, 0.525)
	},
	bomber = {
		name = "Bomber",
		weight = 7000,
		damage = 1810,
		health = 5430,
		iconSize = 1.1,
		image = "rbxassetid://118802012619593",
		invertedIcon = "rbxassetid://128169607644497",
		invertedTexture = "rbxassetid://136052037168788",
		minZone = 14,
		iconPosition = UDim2.fromScale(0.5, 0.5)
	},
	ufo = {
		name = "UFO",
		weight = 4500,
		damage = 2172,
		health = 6516,
		iconSize = 1.2,
		image = "rbxassetid://84571567979840",
		invertedIcon = "rbxassetid://131818577610664",
		invertedTexture = "rbxassetid://131605086573440",
		minZone = 15
	},
	witchy = {
		name = "Witchy",
		weight = 3000,
		damage = 2600,
		health = 7800,
		iconSize = 1.2,
		image = "rbxassetid://95792608661411",
		invertedIcon = "rbxassetid://77134371127216",
		invertedTexture = "rbxassetid://98963911847904",
		minZone = 15,
		iconPosition = UDim2.fromScale(0.5, 0.45)
	},
	blackhole = {
		name = "Blackhole",
		weight = 2000,
		damage = 3120,
		health = 9360,
		iconSize = 1.3,
		image = "rbxassetid://75291163669132",
		invertedIcon = "rbxassetid://78662914683659",
		invertedTexture = "rbxassetid://97489249438818",
		minZone = 16
	},
	ember = {
		name = "Ember",
		weight = 1250,
		damage = 3744,
		health = 11200,
		iconSize = 1.1,
		image = "rbxassetid://109587061202149",
		invertedIcon = "rbxassetid://78268245668127",
		invertedTexture = "rbxassetid://93495902116081",
		minZone = 16,
		iconPosition = UDim2.fromScale(0.5, 0.45)
	},
	pumpkin = {
		name = "Pumpkin",
		weight = 777,
		damage = 4492,
		health = 13500,
		image = "rbxassetid://73520789212019",
		invertedIcon = "rbxassetid://81347277376028",
		invertedTexture = "rbxassetid://101241458373121",
		minZone = 17
	},
	ouchy = {
		name = "Ouchy",
		weight = 490,
		damage = 5400,
		health = 16200,
		iconSize = 1.4,
		image = "rbxassetid://71018813544154",
		invertedIcon = "rbxassetid://99664972820849",
		invertedTexture = "rbxassetid://124608713708355",
		minZone = 17,
		iconPosition = UDim2.fromScale(0.5, 0.55)
	},
	sharky = {
		name = "Sharky",
		weight = 333,
		damage = 6500,
		health = 19400,
		iconSize = 1.4,
		image = "rbxassetid://110042731614016",
		invertedIcon = "rbxassetid://131010934888645",
		invertedTexture = "rbxassetid://85519072747675",
		minZone = 18,
		iconPosition = UDim2.fromScale(0.5, 0.55)
	},
	dino = {
		name = "Dino",
		weight = 212,
		damage = 7800,
		health = 23400,
		iconSize = 1.15,
		image = "rbxassetid://136570963279793",
		invertedIcon = "rbxassetid://111474302944756",
		invertedTexture = "rbxassetid://93694449081240",
		minZone = 18
	},
	monke = {
		name = "Monke",
		weight = 140,
		damage = 9360,
		health = 28000,
		iconSize = 1.35,
		image = "rbxassetid://77496763719646",
		invertedIcon = "rbxassetid://71142248382272",
		invertedTexture = "rbxassetid://91170950659629",
		minZone = 19
	},
	prickly = {
		name = "Prickly",
		weight = 90,
		damage = 11200,
		health = 33700,
		iconSize = 1.54,
		image = "rbxassetid://84926848454541",
		invertedIcon = "rbxassetid://103392891003029",
		invertedTexture = "rbxassetid://70595106591814",
		minZone = 19,
		iconPosition = UDim2.fromScale(0.5, 0.57)
	},
	zoomy = {
		name = "Zoomy",
		weight = 63,
		damage = 13400,
		health = 40300,
		iconSize = 0.95,
		image = "rbxassetid://140487313117811",
		invertedIcon = "rbxassetid://113799765252765",
		invertedTexture = "rbxassetid://75173544886247",
		minZone = 20,
		iconPosition = UDim2.fromScale(0.5, 0.5)
	},
	waxie = {
		name = "Waxie",
		weight = 43,
		damage = 16100,
		health = 48200,
		iconSize = 1.375,
		image = "rbxassetid://124352884305657",
		invertedIcon = "rbxassetid://130060090039849",
		invertedTexture = "rbxassetid://83900194606525",
		minZone = 20,
		iconPosition = UDim2.fromScale(0.5, 0.4)
	},
	drakey = {
		name = "Drakey",
		weight = 29,
		damage = 19300,
		health = 58000,
		iconSize = 1.75,
		image = "rbxassetid://89226334072502",
		invertedIcon = "rbxassetid://105776660853713",
		invertedTexture = "rbxassetid://140321709355784",
		minZone = 21,
		iconPosition = UDim2.fromScale(0.5, 0.6)
	},
	germy = {
		name = "Germy",
		weight = 19,
		damage = 23100,
		health = 70000,
		iconSize = 1.15,
		image = "rbxassetid://114695028781494",
		invertedIcon = "rbxassetid://127254366989034",
		invertedTexture = "rbxassetid://137750089857030",
		minZone = 21
	},
	palmy = {
		name = "Palmy",
		weight = 12.5,
		damage = 27700,
		health = 83000,
		iconSize = 1.5,
		image = "rbxassetid://117868893544144",
		invertedIcon = "rbxassetid://103058250774761",
		invertedTexture = "rbxassetid://100327177328759",
		minZone = 22,
		iconPosition = UDim2.fromScale(0.5, 0.55)
	},
	snazzy = {
		name = "Snazzy",
		weight = 8,
		damage = 33200,
		health = 100000,
		iconSize = 1.3,
		image = "rbxassetid://72729644483167",
		invertedIcon = "rbxassetid://106538903658787",
		invertedTexture = "rbxassetid://86132807277687",
		minZone = 22,
		iconPosition = UDim2.fromScale(0.5, 0.475)
	},
	bemmy = {
		name = "Bemmy",
		weight = 5.2,
		damage = 40000,
		health = 120000,
		iconSize = 1.1,
		image = "rbxassetid://127485383568253",
		invertedIcon = "rbxassetid://74161793377993",
		invertedTexture = "rbxassetid://82572123950555",
		minZone = 23
	},
	mato = {
		name = "Mato",
		weight = 3.2,
		damage = 48000,
		health = 144000,
		iconSize = 1.1,
		image = "rbxassetid://113995789351545",
		invertedIcon = "rbxassetid://81949748399211",
		invertedTexture = "rbxassetid://114421800349557",
		minZone = 23
	},
	frosty = {
		name = "Frosty",
		weight = 2,
		damage = 57600,
		health = 172000,
		iconSize = 1.3,
		image = "rbxassetid://128497431011038",
		invertedIcon = "rbxassetid://95313794147006",
		invertedTexture = "rbxassetid://109237026593958",
		minZone = 24,
		iconPosition = UDim2.fromScale(0.5, 0.525)
	},
	crafty = {
		name = "Crafty",
		weight = 0,
		damage = 90,
		health = 270,
		image = "rbxassetid://80275578334225",
		invertedIcon = "rbxassetid://130069906362907",
		invertedTexture = "rbxassetid://132381989688989",
		craftable = true,
		minZone = 0
	},
	thorn = {
		name = "Thorn",
		weight = 0,
		damage = 167,
		health = 500,
		iconSize = 1.1,
		image = "rbxassetid://132737359040574",
		invertedIcon = "rbxassetid://85895000047007",
		invertedTexture = "rbxassetid://94150373762674",
		craftable = true,
		minZone = 0,
		iconPosition = UDim2.fromScale(0.5, 0.55)
	},
	geode = {
		name = "Geode",
		weight = 0,
		damage = 300,
		health = 900,
		iconSize = 1.3,
		image = "rbxassetid://120112215527315",
		invertedIcon = "rbxassetid://137662541184204",
		invertedTexture = "rbxassetid://130856696489606",
		craftable = true,
		minZone = 0,
		iconPosition = UDim2.fromScale(0.5, 0.35)
	},
	slimeSlimeSlime = {
		name = "SlimeSlimeSlime",
		weight = 0,
		damage = 676,
		health = 2028,
		iconSize = 1.3,
		image = "rbxassetid://116751290384627",
		invertedIcon = "rbxassetid://125371371093254",
		invertedTexture = "rbxassetid://99880092316508",
		craftable = true,
		minZone = 0,
		iconPosition = UDim2.fromScale(0.5, 0.4)
	},
	puffy = {
		name = "Puffy",
		weight = 0,
		damage = 1400,
		health = 4200,
		iconSize = 1.2,
		image = "rbxassetid://126480065415699",
		invertedIcon = "rbxassetid://83877809238490",
		invertedTexture = "rbxassetid://77417044589941",
		craftable = true,
		minZone = 0,
		iconPosition = UDim2.fromScale(0.5, 0.55)
	},
	astro = {
		name = "Astro",
		weight = 0,
		damage = 4100,
		health = 12300,
		iconSize = 1.1,
		image = "rbxassetid://84474255602247",
		invertedIcon = "rbxassetid://107242808504661",
		invertedTexture = "rbxassetid://97895890304137",
		craftable = true,
		minZone = 0
	},
	sunny = {
		name = "Sunny",
		weight = 0,
		damage = 8100,
		health = 24300,
		iconSize = 1.3,
		image = "rbxassetid://124866647020868",
		invertedIcon = "rbxassetid://127425348993954",
		invertedTexture = "rbxassetid://129395265805262",
		craftable = true,
		minZone = 0,
		iconPosition = UDim2.fromScale(0.5, 0.55)
	},
	melly = {
		name = "Melly",
		weight = 0,
		damage = 31000,
		health = 93000,
		iconSize = 1.2,
		image = "rbxassetid://105418599267634",
		invertedIcon = "rbxassetid://70774822832676",
		invertedTexture = "rbxassetid://73333798478762",
		craftable = true,
		minZone = 0,
		iconPosition = UDim2.fromScale(0.5, 0.475)
	}
}
local n1 = 0
local t2 = {}
local t3 = {}
local resolveDisplayOdds = nil

for v8, v9 in t1 do
	v9.id = v8

	if not v9.craftable then
		local weight = v9.weight

		n1 += weight
	end
end

assert(n1 > 0, "Slime table must contain at least one rollable slime")

function resolveDisplayOdds(s1: string, t4: {[any]: any}) -- line: 861
	-- upvalues: t3 (copy), t1 (copy), n1 (ref), Recipes (copy), resolveDisplayOdds (copy), Mutations (copy)
	local v23 = t3[s1]

	if v23 ~= nil then
		return v23
	end

	local v24 = t1[s1]

	assert(v24 ~= nil, "Missing slime definition for derived odds: " .. s1)

	if not v24.craftable then
		local v25 = if not v24.craftable then v24.weight / n1 else 0

		t3[s1] = v25

		return v25
	end

	assert(not t4[s1], "Circular crafting recipe detected for slime: " .. s1)
	t4[s1] = true

	local v26 = Recipes.getRecipeByOutputId(s1)

	assert(v26 ~= nil, "Missing crafting recipe for craftable slime: " .. s1)

	local n2 = 0

	for _, v29 in v26.inputs do
		local v30 = resolveDisplayOdds(v29.id, t4) / Mutations.getVisualOddsMultiplier(v29.mutations)

		assert(v30 > 0, "Crafting ingredient odds must be positive: " .. v29.id)
		n2 += 1 / v30
	end

	assert(n2 > 0, "Crafting recipe must have positive combined rarity: " .. s1)

	local v31 = 1 / (n2 * 1.33)

	t4[s1] = nil
	t3[s1] = v31

	return v31
end

for _, v13 in Recipes.getRecipes() do
	local v14 = t1[v13.outputId]

	assert(v14 ~= nil, "Crafting recipe output slime is missing: " .. v13.outputId)
	assert(v14.craftable == true, "Crafting recipe output must be marked craftable: " .. v13.outputId)
end

for v15, v16 in t1 do
	v16.rollOdds = if not v16.craftable then v16.weight / n1 else 0
	v16.odds = resolveDisplayOdds(v15, {})
	table.insert(t2, v16)
end

table.sort(t2, function(p1, p2) -- line: 909
	if p1.odds == p2.odds then
		return p1.id < p2.id
	end

	return p1.odds > p2.odds
end)

for v17, v18 in t2 do
	v18.layout = v17
end

local t5 = {
	getSlime = function(s2: string) --[[ getSlime ]] -- line: 945
		-- upvalues: t1 (copy)
		assert(s2 ~= nil, "Slime ID is nil")
		assert(t1[s2] ~= nil, "Slime not found: " .. s2)

		return t1[s2]
	end,
	getSortedSlimes = function() --[[ getSortedSlimes ]] -- line: 951
		-- upvalues: t2 (copy)
		return t2
	end
}

function t5.getImage(s3: string, p3) -- line: 955
	-- upvalues: t5 (copy)
	local v42 = t5.getSlime(s3)

	if p3 ~= nil and p3.inverted == true and v42.invertedIcon ~= "" then
		return v42.invertedIcon
	end

	return v42.image
end
function t5.applyMutationVisuals(p4, s4: string, p5) -- line: 959
	-- upvalues: t5 (copy), ReplicatedStorage (copy)
	local v46 = t5.getSlime(s4)

	if p5 == nil or p5.inverted ~= true or v46.invertedTexture == "" then
		return
	end

	local SlimeBody = p4:FindFirstChild("SlimeBody", true)

	if SlimeBody == nil or not SlimeBody:IsA("MeshPart") then
		return
	end

	local SurfaceAppearance = SlimeBody:FindFirstChildWhichIsA("SurfaceAppearance")

	if SurfaceAppearance then
		local s4_2 = ReplicatedStorage.Assets.InvertedSurfaceApearances:FindFirstChild(s4)
		local v50 = if s4_2 ~= nil and s4_2:IsA("SurfaceAppearance") then s4_2 else nil

		if v50 == nil then
			return
		end

		local clone = v50:Clone()

		clone.Name = SurfaceAppearance.Name
		SurfaceAppearance:Destroy()
		clone.Parent = SlimeBody

		return
	end

	SlimeBody.TextureID = v46.invertedTexture
end
function t5.getModel(s5: string) -- line: 987
	-- upvalues: ReplicatedStorage (copy)
	local s5_2 = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Slimes"):FindFirstChild(s5)

	assert(s5_2 ~= nil, "Slime model not found: " .. s5)
	assert(s5_2:IsA("Model"), "Slime asset must be a Model: " .. s5)

	return s5_2
end

return t5
