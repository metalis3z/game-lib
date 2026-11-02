local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Updates = require(ReplicatedStorage.Shared.Updates)

return {
	Gold = {
		DisplayText = Mutations.Gold.DisplayText, 
		DisplayWithRichText = Mutations.Gold.DisplayWithRichText, 
		MainColor = Mutations.Gold.MainColor, 
		Palettes = Mutations.Gold.Palettes, 
		Order = 2, 
		ColorOrder = 2, 
		IsMutation = true, 
		CompletitionPercent = 0.75, 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(179, 107, 13), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(163, 98, 12), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(200, 150, 0), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(179, 107, 13)
		}
	}, 
	Diamond = {
		DisplayText = Mutations.Diamond.DisplayText, 
		DisplayWithRichText = Mutations.Diamond.DisplayWithRichText, 
		MainColor = Mutations.Diamond.MainColor, 
		Palettes = Mutations.Diamond.Palettes, 
		Order = 3, 
		ColorOrder = 3, 
		IsMutation = true, 
		CompletitionPercent = 0.75, 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(25, 138, 175), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(13, 105, 172), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(28, 150, 194), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(25, 138, 175)
		}
	}, 
	Smurf = {
		DisplayText = "Smurf",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#4287f5\">Smurf</font>",
		MainColor = Color3.fromRGB(66, 135, 245),
		Order = 19,
		ShowInSettings = false,
		Index = {},
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		BaseColors = {}
	},
	Bloodrot = {
		DisplayText = Mutations.Bloodrot.DisplayText, 
		DisplayWithRichText = Mutations.Bloodrot.DisplayWithRichText, 
		MainColor = Mutations.Bloodrot.MainColor, 
		Palettes = Mutations.Bloodrot.Palettes, 
		LimitedMutation = 0, 
		ShowInSettings = false, 
		Index = require(script.Index.Bloodrot), 
		DisableIndex = true, 
		IsMutation = true, 
		CompletitionPercent = 1
	}, 
	Rainbow = {
		DisplayText = Mutations.Rainbow.DisplayText, 
		DisplayWithRichText = Mutations.Rainbow.DisplayWithRichText, 
		MainColor = Mutations.Rainbow.MainColor, 
		Palettes = Mutations.Rainbow.Palettes, 
		Order = 4, 
		ColorOrder = 5, 
		IsMutation = true, 
		CompletitionPercent = 0.75, 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(99, 95, 98), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(69, 71, 80), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(27, 42, 53), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(91, 93, 105)
		}
	}, 
	Candy = {
		DisplayText = Mutations.Candy.DisplayText, 
		DisplayWithRichText = Mutations.Candy.DisplayWithRichText, 
		MainColor = Mutations.Candy.MainColor, 
		Palettes = Mutations.Candy.Palettes, 
		Order = 5, 
		ColorOrder = 4, 
		LimitedMutation = 1753477200, 
		ShowInSettings = false, 
		Index = require(script.Index.Candy), 
		IsMutation = true, 
		CompletitionPercent = 1, 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(255, 105, 180), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(177, 73, 125), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(99, 41, 70), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(255, 105, 180)
		}
	}, 
	Lava = {
		DisplayText = Mutations.Lava.DisplayText, 
		DisplayWithRichText = Mutations.Lava.DisplayWithRichText, 
		MainColor = Mutations.Lava.MainColor, 
		Palettes = Mutations.Lava.Palettes, 
		Order = 5, 
		ColorOrder = 4, 
		LimitedMutation = 1755957600, 
		ShowInSettings = false, 
		Index = require(script.Index.Lava), 
		IsMutation = true, 
		CompletitionPercent = 1, 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(62, 31, 15), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(230, 106, 17), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(120, 17, 8), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(255, 160, 0)
		}
	}, 
	Galaxy = {
		DisplayText = Mutations.Galaxy.DisplayText, 
		DisplayWithRichText = Mutations.Galaxy.DisplayWithRichText, 
		MainColor = Mutations.Galaxy.MainColor, 
		Palettes = Mutations.Galaxy.Palettes, 
		Order = 6, 
		ColorOrder = 4, 
		LimitedMutation = 1758999600, 
		ShowInSettings = false, 
		Index = require(script.Index.Galaxy), 
		IsMutation = true, 
		CompletitionPercent = 1, 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(167, 79, 255), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(87, 0, 186), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(32, 12, 48), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(113, 0, 243)
		}
	}, 
	YinYang = {
		DisplayText = Mutations.YinYang.DisplayText, 
		UseRichText = Mutations.YinYang.UseRichText, 
		DisplayWithRichText = Mutations.YinYang.DisplayWithRichText, 
		MainColor = Mutations.YinYang.MainColor, 
		Palettes = Mutations.YinYang.Palettes, 
		Order = 7, 
		ColorOrder = 5, 
		LimitedMutation = 1763236800, 
		ShowInSettings = false, 
		Index = require(script.Index.YinYang), 
		IsMutation = true, 
		CompletitionPercent = 0.75, 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(204, 204, 204), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(204, 204, 204), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(0, 0, 0), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(0, 0, 0), 
			[Vector3.new(196, 40, 28, 0)] = Color3.fromRGB(159, 161, 172), 
			Ground = Color3.fromRGB(159, 161, 172)
		}
	}, 
	Halloween = {
		DisplayText = "Halloween", 
		UseRichText = true, 
		DisplayWithRichText = "<font color=\"#ef7625\">Halloween</font>", 
		MainColor = Color3.fromRGB(239, 118, 37), 
		Order = 8, 
		ShowInSettings = false, 
		Index = require(script.Index.Halloween), 
		LimitedMutation = 1762012800, 
		CountAllMutations = true, 
		CompletitionPercent = 0.75, 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(220, 107, 21), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(199, 94, 20), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(161, 78, 16), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(220, 107, 21), 
			[Vector3.new(202, 203, 209, 0)] = Color3.fromRGB(198, 164, 61), 
			[Vector3.new(65, 67, 75, 0)] = Color3.fromRGB(161, 78, 16), 
			[Vector3.new(108, 88, 75, 0)] = Color3.fromRGB(198, 164, 61), 
			Ground = Color3.fromRGB(220, 107, 21)
		}
	}, 
	Radioactive = {
		DisplayText = Mutations.Radioactive.DisplayText, 
		UseRichText = Mutations.Radioactive.UseRichText, 
		DisplayWithRichText = Mutations.Radioactive.DisplayWithRichText, 
		MainColor = Mutations.Radioactive.MainColor, 
		Palettes = Mutations.Radioactive.Palettes, 
		Order = 9, 
		ColorOrder = 6, 
		LimitedMutation = 1767470400, 
		IsMutation = true, 
		CompletitionPercent = 0.75, 
		Index = require(script.Index.Radioactive), 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(114, 156, 0), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(156, 227, 50), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(31, 59, 19), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(156, 156, 156), 
			[Vector3.new(202, 203, 209, 0)] = Color3.fromRGB(255, 255, 255), 
			Ground = Color3.fromRGB(114, 156, 0)
		}
	}, 
	Cursed = {
		DisplayText = Mutations.Cursed.DisplayText, 
		UseRichText = Mutations.Cursed.UseRichText, 
		DisplayWithRichText = Mutations.Cursed.DisplayWithRichText, 
		MainColor = Mutations.Cursed.MainColor, 
		Palettes = Mutations.Cursed.Palettes, 
		Order = 9, 
		ColorOrder = 6, 
		LimitedMutation = 1771704000, 
		IsMutation = true, 
		CompletitionPercent = 0.6, 
		Index = require(script.Index.Cursed), 
		BaseColors = {}
	}, 
	Divine = {
		DisplayText = Mutations.Divine.DisplayText, 
		UseRichText = Mutations.Divine.UseRichText, 
		DisplayWithRichText = Mutations.Divine.DisplayWithRichText, 
		MainColor = Mutations.Divine.MainColor, 
		Palettes = Mutations.Divine.Palettes, 
		Order = 10, 
		ColorOrder = 7, 
		LimitedMutation = 1775937600, 
		IsMutation = true, 
		CompletitionPercent = 0.6, 
		BaseColors = {}
	}, 
	Cyber = {
		DisplayText = Mutations.Cyber.DisplayText, 
		UseRichText = Mutations.Cyber.UseRichText, 
		DisplayWithRichText = Mutations.Cyber.DisplayWithRichText, 
		MainColor = Mutations.Cyber.MainColor, 
		Palettes = Mutations.Cyber.Palettes, 
		Order = 18, 
		ColorOrder = 8, 
		LimitedMutation = 1780080000, 
		ShowInSettings = true, 
		Index = require(script.Index.Cyber), 
		IsMutation = true, 
		CompletitionPercent = 0.6, 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(0, 50, 65), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(0, 75, 90), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(0, 20, 30), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(100, 180, 210), 
			[Vector3.new(202, 203, 209, 0)] = Color3.fromRGB(121, 219, 255), 
			Ground = Color3.fromRGB(0, 30, 40)
		}
	},  
	Aquatic = {
		DisplayText = "Aquatic", 
		UseRichText = true, 
		DisplayWithRichText = "<font color=\"#0096ff\">Aquatic</font>", 
		MainColor = Color3.fromRGB(0, 150, 255), 
		Order = 11, 
		ShowInSettings = false, 
		Index = require(script.Index.Aquatic), 
		LimitedMutation = 1764446400, 
		CustomIndex = {
			Name = "Aquatic"
		}, 
		CountAllMutations = true, 
		CompletitionPercent = 0.9, 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(59, 121, 163), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(38, 77, 104), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(21, 35, 65), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(153, 106, 53), 
			[Vector3.new(202, 203, 209, 0)] = Color3.fromRGB(99, 159, 211), 
			Ground = Color3.fromRGB(176, 124, 61)
		}
	}, 
	Christmas = {
		DisplayText = "Christmas", 
		UseRichText = false, 
		DisplayWithRichText = "<font color=\"#ff4343\">Christmas</font>", 
		MainColor = Color3.fromRGB(255, 67, 67), 
		Order = 12, 
		ShowInSettings = false, 
		Index = require(script.Index.Christmas), 
		LimitedMutation = 1767286800, 
		CountAllMutations = true, 
		CompletitionPercent = 0.9, 
		CompletitionForcedAmount = 36, 
		BaseColors = {}
	}, 
	Taco = {
		DisplayText = "Taco", 
		UseRichText = false, 
		DisplayWithRichText = "<font color=\"#FFDE59\">Taco</font>", 
		MainColor = Color3.fromRGB(255, 222, 89), 
		Order = 13, 
		ShowInSettings = false, 
		Index = require(script.Index.Taco), 
		DisableAutomaticSkin = true, 
		CustomIndex = {
			Name = "Taco", 
			Filter = function(_, _)
				return ReplicatedStorage:GetAttribute("TacoBaseEvent") == true
			end
		}, 
		HideButton = true, 
		CountAllMutations = true, 
		CompletitionPercent = 0.9, 
		BaseColors = {}
	}, 
	Valentines = {
		DisplayText = "Valentine's", 
		UseRichText = false, 
		DisplayWithRichText = "<font color=\"#e364bb\">Valentine's</font>", 
		MainColor = Color3.fromRGB(227, 100, 187), 
		Order = 12, 
		ShowInSettings = false, 
		Index = require(script.Index.Valentines), 
		DisableAutomaticSkin = true, 
		LimitedMutation = 1771704000, 
		CustomIndex = {
			Name = "Valentines"
		}, 
		CountAllMutations = true, 
		CompletitionPercent = 0.9, 
		CompletitionForcedAmount = 8, 
		BaseColors = {}
	}, 
	Gingerbread = {
		DisplayText = "Gingerbread", 
		UseRichText = true, 
		DisplayWithRichText = "<font color=\"#ff7327\">Gingerbread</font>", 
		MainColor = Color3.fromRGB(255, 115, 39), 
		Order = 13, 
		ShowInSettings = false, 
		Index = {}, 
		DisableIndex = true, 
		CountAllMutations = false, 
		CompletitionPercent = 1, 
		BaseColors = {}
	}, 
	Rose = {
		DisplayText = "Rose", 
		UseRichText = true, 
		DisplayWithRichText = "<font color=\"#f42020\">Rose</font>", 
		MainColor = Color3.fromRGB(244, 32, 32), 
		Order = 14, 
		ShowInSettings = false, 
		Index = {}, 
		DisableIndex = true, 
		CountAllMutations = false, 
		CompletitionPercent = 1, 
		BaseColors = {}
	}, 
	Lucky = {
		DisplayText = "Lucky", 
		UseRichText = true, 
		DisplayWithRichText = "<font color=\"#4ee321\">Lucky</font>", 
		MainColor = Color3.fromRGB(78, 227, 3), 
		Order = 15, 
		ShowInSettings = false, 
		Index = require(script.Index.Lucky), 
		DisableAutomaticSkin = true, 
		CustomIndex = {
			Name = "Lucky", 
			Filter = function(_, _)
				return ReplicatedStorage:GetAttribute("LuckyBaseEvent") == true
			end
		}, 
		HideButton = true, 
		CountAllMutations = false, 
		CompletitionPercent = 0.8, 
		BaseColors = {}
	}, 
	["Pot of Gold"] = {
		DisplayText = "Pot of Gold", 
		UseRichText = true, 
		DisplayWithRichText = "<font color=\"#ffd015\">Pot of Gold</font>", 
		MainColor = Color3.fromRGB(255, 208, 21), 
		Order = 16, 
		ShowInSettings = false, 
		Index = {}, 
		DisableIndex = true, 
		CountAllMutations = false, 
		CompletitionPercent = 1, 
		BaseColors = {}
	}, 
	Skibidi = {
		DisplayText = "Skibidi", 
		UseRichText = false, 
		UseRichTextInSettings = true, 
		DisplayWithRichText = "<stroke thickness=\"2\" transparency=\"0.5\"><font color=\"#ffffff\">Skibidi</font></stroke>", 
		MainColor = Color3.fromRGB(255, 255, 255), 
		Order = 15, 
		ShowInSettings = false, 
		Index = {}, 
		DisableIndex = true, 
		CountAllMutations = false, 
		CompletitionPercent = 1, 
		BaseColors = {}
	}, 
	Meowl = {
		DisplayText = "Meowl", 
		UseRichText = true, 
		DisplayWithRichText = "<font color=\"#ffff14\">Meowl</font>", 
		MainColor = Color3.fromRGB(255, 255, 20), 
		Order = 16, 
		ShowInSettings = false, 
		Index = {}, 
		DisableIndex = true, 
		CountAllMutations = false, 
		CompletitionPercent = 1, 
		BaseColors = {}
	}, 
	Strawberry = {
		DisplayText = "Strawberry", 
		UseRichText = true, 
		DisplayWithRichText = "<font color=\"#cf3b3f\">Strawberry</font>", 
		MainColor = Color3.fromRGB(207, 59, 63), 
		Order = 17, 
		ShowInSettings = false, 
		Index = {}, 
		DisableIndex = true, 
		CountAllMutations = false, 
		CompletitionPercent = 1, 
		BaseColors = {
			[Vector3.new(99, 95, 98, 0)] = Color3.fromRGB(235, 235, 235), 
			[Vector3.new(69, 71, 80, 0)] = Color3.fromRGB(180, 180, 180), 
			[Vector3.new(27, 42, 53, 0)] = Color3.fromRGB(139, 139, 139), 
			[Vector3.new(91, 93, 105, 0)] = Color3.fromRGB(235, 235, 235), 
			[Vector3.new(202, 203, 209, 0)] = Color3.fromRGB(253, 213, 110), 
			Ground = Color3.fromRGB(196, 40, 28)
		}
	},
	Spyder = {
		DisplayText = "Spyder", 
		UseRichText = true, 
		DisplayWithRichText = "<font color=\"#7e44e3\">Spyder</font>", 
		MainColor = Color3.fromRGB(227, 227, 227), 
		Order = 19, 
		ShowInSettings = false, 
		Index = {}, 
		DisableIndex = true, 
		CountAllMutations = false, 
		CompletitionPercent = 1, 
		BaseColors = {}
	},
	Headless = {
		DisplayText = "Headless", 
		UseRichText = true, 
		DisplayWithRichText = "<font color=\"#7e44e3\">Headless</font>", 
		MainColor = Color3.fromRGB(126, 68, 227), 
		Order = 20, 
		ShowInSettings = false, 
		Index = {}, 
		DisableIndex = true, 
		CountAllMutations = false, 
		CompletitionPercent = 1, 
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
	Ibrx = {
		DisplayText = "Ibrx",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#00007f\">Ibrx</font>",
		MainColor = Color3.fromRGB(0, 0, 127),
		Order = 21,
		ShowInSettings = true,
		Index = {},
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		BaseColors = {}
	},
	Nerdify = {
		DisplayText = "Nerdify",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#d4a84b\">Nerdify</font>",
		MainColor = Color3.fromRGB(212, 0, 0),
		Order = 22,
		ShowInSettings = true,
		Index = {},
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		BaseColors = {}
	},
	Teykx = {
		DisplayText = "Teykx",
		UseRichText = true,
		DisplayWithRichText = "<font color=\"#d4a84b\">Teykx</font>",
		MainColor = Color3.fromRGB(212, 0, 0),
		Order = 22,
		ShowInSettings = true,
		Index = {},
		DisableIndex = true,
		CountAllMutations = false,
		CompletitionPercent = 1,
		BaseColors = {}
	}
}