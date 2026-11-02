

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Mutations = require(ReplicatedStorage.Datas.Mutations)

require(ReplicatedStorage.Shared.Updates)

return {
	Gold = {
		Order = 2,
		ColorOrder = 2,
		IsMutation = true,
		CompletitionPercent = 0.75,
		DisplayText = Mutations.Gold.DisplayText,
		DisplayWithRichText = Mutations.Gold.DisplayWithRichText,
		MainColor = Mutations.Gold.MainColor,
		Palettes = Mutations.Gold.Palettes,
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(179, 107, 13),
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(163, 98, 12),
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(200, 150, 0),
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(179, 107, 13)
		}
	},
	Diamond = {
		Order = 3,
		ColorOrder = 3,
		IsMutation = true,
		CompletitionPercent = 0.75,
		DisplayText = Mutations.Diamond.DisplayText,
		DisplayWithRichText = Mutations.Diamond.DisplayWithRichText,
		MainColor = Mutations.Diamond.MainColor,
		Palettes = Mutations.Diamond.Palettes,
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(25, 138, 175),
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(13, 105, 172),
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(28, 150, 194),
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(25, 138, 175)
		}
	},
	Bloodrot = {
		LimitedMutation = 0,
		ShowInSettings = false,
		DisableIndex = true,
		IsMutation = true,
		CompletitionPercent = 1,
		DisplayText = Mutations.Bloodrot.DisplayText,
		DisplayWithRichText = Mutations.Bloodrot.DisplayWithRichText,
		MainColor = Mutations.Bloodrot.MainColor,
		Palettes = Mutations.Bloodrot.Palettes,
		Index = require(script.Index.Bloodrot)
	},
	Rainbow = {
		Order = 4,
		ColorOrder = 5,
		IsMutation = true,
		CompletitionPercent = 0.75,
		DisplayText = Mutations.Rainbow.DisplayText,
		DisplayWithRichText = Mutations.Rainbow.DisplayWithRichText,
		MainColor = Mutations.Rainbow.MainColor,
		Palettes = Mutations.Rainbow.Palettes,
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(99, 95, 98),
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(69, 71, 80),
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(27, 42, 53),
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(91, 93, 105)
		}
	},
	Candy = {
		Order = 5,
		ColorOrder = 4,
		LimitedMutation = 1753477200,
		ShowInSettings = false,
		IsMutation = true,
		CompletitionPercent = 1,
		DisplayText = Mutations.Candy.DisplayText,
		DisplayWithRichText = Mutations.Candy.DisplayWithRichText,
		MainColor = Mutations.Candy.MainColor,
		Palettes = Mutations.Candy.Palettes,
		Index = require(script.Index.Candy),
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(255, 105, 180),
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(177, 73, 125),
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(99, 41, 70),
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(255, 105, 180)
		}
	},
	Lava = {
		Order = 5,
		ColorOrder = 4,
		LimitedMutation = 1755957600,
		ShowInSettings = false,
		IsMutation = true,
		CompletitionPercent = 1,
		DisplayText = Mutations.Lava.DisplayText,
		DisplayWithRichText = Mutations.Lava.DisplayWithRichText,
		MainColor = Mutations.Lava.MainColor,
		Palettes = Mutations.Lava.Palettes,
		Index = require(script.Index.Lava),
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(62, 31, 15),
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(230, 106, 17),
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(120, 17, 8),
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(255, 160, 0)
		}
	},
	Galaxy = {
		Order = 6,
		ColorOrder = 4,
		LimitedMutation = 1758999600,
		ShowInSettings = false,
		IsMutation = true,
		CompletitionPercent = 1,
		DisplayText = Mutations.Galaxy.DisplayText,
		DisplayWithRichText = Mutations.Galaxy.DisplayWithRichText,
		MainColor = Mutations.Galaxy.MainColor,
		Palettes = Mutations.Galaxy.Palettes,
		Index = require(script.Index.Galaxy),
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(167, 79, 255),
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(87, 0, 186),
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(32, 12, 48),
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(113, 0, 243)
		}
	},
	YinYang = {
		Order = 7,
		ColorOrder = 5,
		LimitedMutation = 1763236800,
		ShowInSettings = false,
		IsMutation = true,
		CompletitionPercent = 0.75,
		DisplayText = Mutations.YinYang.DisplayText,
		UseRichText = Mutations.YinYang.UseRichText,
		DisplayWithRichText = Mutations.YinYang.DisplayWithRichText,
		MainColor = Mutations.YinYang.MainColor,
		Palettes = Mutations.YinYang.Palettes,
		Index = require(script.Index.YinYang),
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(204, 204, 204),
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(204, 204, 204),
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(0, 0, 0),
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(0, 0, 0),
			[Vector3.new(196, 40, 28)] = Color3.fromRGB(159, 161, 172),
			Ground = Color3.fromRGB(159, 161, 172)
		}
	},
	Halloween = {
		DisplayText = "Halloween",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#ef7625\">Halloween</font>",
		Order = 8,
		ShowInSettings = false,
		LimitedMutation = 1762012800,
		CountAllMutations = true,
		CompletitionPercent = 0.75,
		MainColor = Color3.fromRGB(239, 118, 37),
		Index = require(script.Index.Halloween),
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(220, 107, 21),
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(199, 94, 20),
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(161, 78, 16),
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(220, 107, 21),
			[Vector3.new(202, 203, 209)] = Color3.fromRGB(198, 164, 61),
			[Vector3.new(65, 67, 75)] = Color3.fromRGB(161, 78, 16),
			[Vector3.new(108, 88, 75)] = Color3.fromRGB(198, 164, 61),
			Ground = Color3.fromRGB(220, 107, 21)
		}
	},
	Radioactive = {
		Order = 9,
		ColorOrder = 6,
		ShowInSettings = false,
		LimitedMutation = 1767470400,
		IsMutation = true,
		CompletitionPercent = 0.75,
		DisplayText = Mutations.Radioactive.DisplayText,
		UseRichText = Mutations.Radioactive.UseRichText,
		DisplayWithRichText = Mutations.Radioactive.DisplayWithRichText,
		MainColor = Mutations.Radioactive.MainColor,
		Palettes = Mutations.Radioactive.Palettes,
		Index = require(script.Index.Radioactive),
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(114, 156, 0),
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(156, 227, 50),
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(31, 59, 19),
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(156, 156, 156),
			[Vector3.new(202, 203, 209)] = Color3.fromRGB(255, 255, 255),
			Ground = Color3.fromRGB(114, 156, 0)
		}
	},
	Cursed = {
		Order = 9,
		ColorOrder = 6,
		LimitedMutation = 1771704000,
		ShowInSettings = false,
		IsMutation = true,
		CompletitionPercent = 0.6,
		DisplayText = Mutations.Cursed.DisplayText,
		UseRichText = Mutations.Cursed.UseRichText,
		DisplayWithRichText = Mutations.Cursed.DisplayWithRichText,
		MainColor = Mutations.Cursed.MainColor,
		Palettes = Mutations.Cursed.Palettes,
		Index = require(script.Index.Cursed),
		BaseColors = {}
	},
	Divine = {
		Order = 10,
		ColorOrder = 7,
		LimitedMutation = 1776542400,
		ShowInSettings = false,
		IsMutation = true,
		CompletitionPercent = 0.6,
		DisplayText = Mutations.Divine.DisplayText,
		UseRichText = Mutations.Divine.UseRichText,
		DisplayWithRichText = Mutations.Divine.DisplayWithRichText,
		MainColor = Mutations.Divine.MainColor,
		Palettes = Mutations.Divine.Palettes,
		Index = require(script.Index.Divine),
		BaseColors = {}
	},
	Cyber = {
		Order = 10,
		ColorOrder = 7,
		LimitedMutation = 1781377200,
		IsMutation = true,
		CompletitionPercent = 0.6,
		DisplayText = Mutations.Cyber.DisplayText,
		UseRichText = Mutations.Cyber.UseRichText,
		DisplayWithRichText = Mutations.Cyber.DisplayWithRichText,
		MainColor = Mutations.Cyber.MainColor,
		Palettes = Mutations.Cyber.Palettes,
		BaseColors = {}
	},
	Phantom = {
		Order = 10,
		ColorOrder = 7,
		LimitedMutation = 1785006000,
		Update = "Update-06/13/2026",
		IsMutation = true,
		CompletitionPercent = 0.6,
		DisplayText = Mutations.Phantom.DisplayText,
		UseRichText = Mutations.Phantom.UseRichText,
		DisplayWithRichText = Mutations.Phantom.DisplayWithRichText,
		MainColor = Mutations.Phantom.MainColor,
		Palettes = Mutations.Phantom.Palettes,
		BaseColors = {}
	},
	Aquatic = {
		DisplayText = "Aquatic",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#0096ff\">Aquatic</font>",
		Order = 11,
		ShowInSettings = false,
		LimitedMutation = 1764446400,
		CountAllMutations = true,
		CompletitionPercent = 0.9,
		MainColor = Color3.fromRGB(0, 150, 255),
		Index = require(script.Index.Aquatic),
		CustomIndex = {
			Name = "Aquatic"
		},
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(59, 121, 163),
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(38, 77, 104),
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(21, 35, 65),
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(153, 106, 53),
			[Vector3.new(202, 203, 209)] = Color3.fromRGB(99, 159, 211),
			Ground = Color3.fromRGB(176, 124, 61)
		}
	},
	Christmas = {
		DisplayText = "Christmas",
		UseRichText = false,
		DisplayWithRichText = "<font color=\"#ff4343\">Christmas</font>",
		Order = 12,
		ShowInSettings = false,
		LimitedMutation = 1767286800,
		CountAllMutations = true,
		CompletitionPercent = 0.9,
		CompletitionForcedAmount = 36,
		MainColor = Color3.fromRGB(255, 67, 67),
		Index = require(script.Index.Christmas),
		BaseColors = {}
	},
	Taco = {
		DisplayText = "Taco",
		UseRichText = false,
		DisplayWithRichText = "<font color=\"#FFDE59\">Taco</font>",
		Order = 13,
		ShowInSettings = false,
		DisableAutomaticSkin = true,
		HideButton = true,
		CountAllMutations = true,
		CompletitionPercent = 0.9,
		MainColor = Color3.fromRGB(255, 222, 89),
		Index = require(script.Index.Taco),
		CustomIndex = {
			Name = "Taco",
			Filter = function(_: string, _: string)
				return ReplicatedStorage:GetAttribute("TacoBaseEvent") == true
			end
		},
		BaseColors = {}
	},
	HPH = {
		DisplayText = "HPH",
		UseRichText = false,
		DisplayWithRichText = "<font color=\"#FFDE59\">HPH</font>",
		Order = 13,
		ShowInSettings = false,
		DisableAutomaticSkin = true,
		HideButton = true,
		CountAllMutations = true,
		CompletitionPercent = 0.9,
		MainColor = Color3.fromRGB(255, 222, 89),
		Index = require(script.Index.Taco),
		CustomIndex = {
			Name = "HPH",
			Filter = function(_: string, _: string)
				return ReplicatedStorage:GetAttribute("TacoBaseEvent") == true
			end
		},
		BaseColors = {}
	},
	Valentines = {
		DisplayText = "Valentine's",
		UseRichText = false,
		DisplayWithRichText = "<font color=\"#e364bb\">Valentine's</font>",
		Order = 12,
		ShowInSettings = false,
		DisableAutomaticSkin = true,
		LimitedMutation = 1771704000,
		CountAllMutations = true,
		CompletitionPercent = 0.9,
		CompletitionForcedAmount = 8,
		MainColor = Color3.fromRGB(227, 100, 187),
		Index = require(script.Index.Valentines),
		CustomIndex = {
			Name = "Valentines"
		},
		BaseColors = {}
	},
	Gingerbread = {
		DisplayText = "Gingerbread",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#ff7327\">Gingerbread</font>",
		Order = 13,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(255, 115, 39),
		Index = {},
		BaseColors = {}
	},
	Rose = {
		DisplayText = "Rose",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#f42020\">Rose</font>",
		Order = 14,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(244, 32, 32),
		Index = {},
		BaseColors = {}
	},
	Lucky = {
		DisplayText = "Lucky",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#4ee321\">Lucky</font>",
		Order = 15,
		ShowInSettings = false,
		DisableAutomaticSkin = true,
		HideButton = true,
		CountAllMutations = true,
		CompletitionPercent = 0.8,
		MainColor = Color3.fromRGB(78, 227, 3),
		Index = require(script.Index.Lucky),
		CustomIndex = {
			Name = "Lucky",
			Filter = function(_: string, _: string)
				return ReplicatedStorage:GetAttribute("LuckyBaseEvent") == true
			end
		},
		BaseColors = {}
	},
	Easter = {
		DisplayText = "Easter",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#a8e06c\">Easter</font>",
		Order = 16,
		ShowInSettings = false,
		DisableAutomaticSkin = true,
		HideButton = true,
		CountAllMutations = true,
		CompletitionPercent = 0.8,
		CompletitionForcedAmount = 10,
		MainColor = Color3.fromRGB(168, 224, 108),
		Index = require(script.Index.Easter),
		CustomIndex = {
			Name = "Easter"
		},
		BaseColors = {}
	},
	["Pot of Gold"] = {
		DisplayText = "Pot of Gold",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#ffd015\">Pot of Gold</font>",
		Order = 16,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(255, 208, 21),
		Index = {},
		BaseColors = {}
	},
	["Bunny Basket"] = {
		DisplayText = "Bunny Basket",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#a8e06c\">Bunny Basket</font>",
		Order = 16,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(168, 224, 108),
		Index = {},
		BaseColors = {}
	},
	Summer = {
		DisplayText = "Summer",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#ffbb33\">Summer</font>",
		Order = 16,
		ShowInSettings = false,
		DisableAutomaticSkin = true,
		HideButton = true,
		CountAllMutations = true,
		CompletitionPercent = 0.8,
		CompletitionForcedAmount = 18,
		MainColor = Color3.fromRGB(255, 187, 51),
		Index = require(script.Index.Summer),
		CustomIndex = {
			Name = "Summer",
			Filter = function(_: string, _: string)
				return ReplicatedStorage:GetAttribute("SummerBaseEvent") == true
			end
		},
		BaseColors = {}
	},
	Octo = {
		DisplayText = "Octo",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#f42020\">Octo</font>",
		Order = 16,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(244, 32, 32),
		Index = {},
		BaseColors = {}
	},
	Skibidi = {
		DisplayText = "Skibidi",
		UseRichText = false,
		UseRichTextInSettings = true,
		DisplayWithRichText = "<stroke thickness=\"2\" transparency=\"0.5\"><font color=\"#ffffff\">Skibidi</font></stroke>",
		Order = 17,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(255, 255, 255),
		Index = {},
		BaseColors = {}
	},
	Meowl = {
		DisplayText = "Meowl",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#ffff14\">Meowl</font>",
		Order = 18,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(255, 255, 20),
		Index = {},
		BaseColors = {}
	},
	Strawberry = {
		DisplayText = "Strawberry",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#cf3b3f\">Strawberry</font>",
		Order = 19,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(207, 59, 63),
		Index = {},
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(235, 235, 235),
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(180, 180, 180),
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(139, 139, 139),
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(235, 235, 235),
			[Vector3.new(202, 203, 209)] = Color3.fromRGB(253, 213, 110),
			Ground = Color3.fromRGB(196, 40, 28)
		}
	},
	Headless = {
		DisplayText = "Headless",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#7e44e3\">Headless</font>",
		Order = 21,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(126, 68, 227),
		Index = {},
		BaseColors = {}
	},
	FRENCH = {
		DisplayText = "FRENCH",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#7e44e3\">FRENCH</font>",
		Order = 21,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(0, 4, 255),
		Index = {},
		BaseColors = {}
	},
	DEV = {
		DisplayText = "DEV",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#7e44e3\">DEV</font>",
		Order = 21,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(185, 227, 213),
		Index = {},
		BaseColors = {}
	},
	VIP = {
		DisplayText = "VIP",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#7e44e3\">VIP</font>",
		Order = 21,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(0, 0, 0),
		Index = {},
		BaseColors = {}
	},
	hamburguer = {
		DisplayText = "hamburguer",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#7e44e3\">hamburguer</font>",
		Order = 21,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(227, 227, 227),
		Index = {},
		BaseColors = {}
	},
	OWNER = {
		DisplayText = "OWNER",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#7e44e3\">OWNER</font>",
		Order = 21,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(53, 227, 0),
		Index = {},
		BaseColors = {}
	},
	HARDER = {
		DisplayText = "HARDER",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#7e44e3\">HARDER</font>",
		Order = 21,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(255, 170, 255),
		Index = {},
		BaseColors = {}
	},
	["John Pork"] = {
		DisplayText = "John Pork",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#ff8fb3\">John Pork</font>",
		Order = 20,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(255, 143, 179),
		Index = {},
		BaseColors = {}
	},
	Spyder = {
		DisplayText = "Spyder",
		UseRichText = true,
		UseRichTextInSettings = true,
		DisplayWithRichText = "<stroke thickness=\"2\" transparency=\"0.5\"><font color=\"#ffffff\">Spyder</font></stroke>",
		Order = 22,
		ShowInSettings = false,
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		MainColor = Color3.fromRGB(255, 255, 255),
		Index = {},
		BaseColors = {}
	},
	["SmurfCat"] = {
		["DisplayText"] = "Smurf Cat",
		["UseRichText"] = true,
		["DisplayWithRichText"] = "<font color=\"#007FFF\">Smurf Cat</font>",
		["Order"] = 21,
		["ShowInSettings"] = false,
		["DisableIndex"] = true,
		["CountAllMutations"] = false,
		["CompletitionPercent"] = 1,
		["MainColor"] = Color3.fromRGB(0, 127, 255),
		["Index"] = {},
		["BaseColors"] = {}
	}
}
