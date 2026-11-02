---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Datas.Mutations)
local v3 = {}
local v4 = {
	["DisplayText"] = v2.Gold.DisplayText,
	["DisplayWithRichText"] = v2.Gold.DisplayWithRichText,
	["MainColor"] = v2.Gold.MainColor,
	["Palettes"] = v2.Gold.Palettes,
	["Order"] = 2,
	["ColorOrder"] = 2,
	["IsMutation"] = true,
	["CompletitionPercent"] = 0.75,
	["BaseColors"] = {
		[Vector3.new(99, 95, 98)] = Color3.fromRGB(179, 107, 13),
		[Vector3.new(69, 71, 80)] = Color3.fromRGB(163, 98, 12),
		[Vector3.new(27, 42, 53)] = Color3.fromRGB(200, 150, 0),
		[Vector3.new(91, 93, 105)] = Color3.fromRGB(179, 107, 13)
	}
}
v3.Gold = v4
local v5 = {
	["DisplayText"] = v2.Diamond.DisplayText,
	["DisplayWithRichText"] = v2.Diamond.DisplayWithRichText,
	["MainColor"] = v2.Diamond.MainColor,
	["Palettes"] = v2.Diamond.Palettes,
	["Order"] = 3,
	["ColorOrder"] = 3,
	["IsMutation"] = true,
	["CompletitionPercent"] = 0.75,
	["BaseColors"] = {
		[Vector3.new(99, 95, 98)] = Color3.fromRGB(25, 138, 175),
		[Vector3.new(69, 71, 80)] = Color3.fromRGB(13, 105, 172),
		[Vector3.new(27, 42, 53)] = Color3.fromRGB(28, 150, 194),
		[Vector3.new(91, 93, 105)] = Color3.fromRGB(25, 138, 175)
	}
}
v3.Diamond = v5
v3.Bloodrot = {
	["DisplayText"] = v2.Bloodrot.DisplayText,
	["DisplayWithRichText"] = v2.Bloodrot.DisplayWithRichText,
	["MainColor"] = v2.Bloodrot.MainColor,
	["Palettes"] = v2.Bloodrot.Palettes,
	["LimitedMutation"] = 0,
	["ShowInSettings"] = false,
	["Index"] = require(script.Index.Bloodrot),
	["DisableIndex"] = true,
	["IsMutation"] = true,
	["CompletitionPercent"] = 1
}
local v6 = {
	["DisplayText"] = v2.Rainbow.DisplayText,
	["DisplayWithRichText"] = v2.Rainbow.DisplayWithRichText,
	["MainColor"] = v2.Rainbow.MainColor,
	["Palettes"] = v2.Rainbow.Palettes,
	["Order"] = 4,
	["ColorOrder"] = 5,
	["IsMutation"] = true,
	["CompletitionPercent"] = 0.75,
	["BaseColors"] = {
		[Vector3.new(99, 95, 98)] = Color3.fromRGB(99, 95, 98),
		[Vector3.new(69, 71, 80)] = Color3.fromRGB(69, 71, 80),
		[Vector3.new(27, 42, 53)] = Color3.fromRGB(27, 42, 53),
		[Vector3.new(91, 93, 105)] = Color3.fromRGB(91, 93, 105)
	}
}
v3.Rainbow = v6
local v7 = {
	["DisplayText"] = v2.Candy.DisplayText,
	["DisplayWithRichText"] = v2.Candy.DisplayWithRichText,
	["MainColor"] = v2.Candy.MainColor,
	["Palettes"] = v2.Candy.Palettes,
	["Order"] = 5,
	["ColorOrder"] = 4,
	["LimitedMutation"] = 1753477200,
	["ShowInSettings"] = false,
	["Index"] = require(script.Index.Candy),
	["IsMutation"] = true,
	["CompletitionPercent"] = 1,
	["BaseColors"] = {
		[Vector3.new(99, 95, 98)] = Color3.fromRGB(255, 105, 180),
		[Vector3.new(69, 71, 80)] = Color3.fromRGB(177, 73, 125),
		[Vector3.new(27, 42, 53)] = Color3.fromRGB(99, 41, 70),
		[Vector3.new(91, 93, 105)] = Color3.fromRGB(255, 105, 180)
	}
}
v3.Candy = v7
local v8 = {
	["DisplayText"] = v2.Lava.DisplayText,
	["DisplayWithRichText"] = v2.Lava.DisplayWithRichText,
	["MainColor"] = v2.Lava.MainColor,
	["Palettes"] = v2.Lava.Palettes,
	["Order"] = 5,
	["ColorOrder"] = 4,
	["LimitedMutation"] = 1755957600,
	["ShowInSettings"] = false,
	["Index"] = require(script.Index.Lava),
	["IsMutation"] = true,
	["CompletitionPercent"] = 1,
	["BaseColors"] = {
		[Vector3.new(99, 95, 98)] = Color3.fromRGB(62, 31, 15),
		[Vector3.new(69, 71, 80)] = Color3.fromRGB(230, 106, 17),
		[Vector3.new(27, 42, 53)] = Color3.fromRGB(120, 17, 8),
		[Vector3.new(91, 93, 105)] = Color3.fromRGB(255, 160, 0)
	}
}
v3.Lava = v8
local v9 = {
	["DisplayText"] = v2.Galaxy.DisplayText,
	["DisplayWithRichText"] = v2.Galaxy.DisplayWithRichText,
	["MainColor"] = v2.Galaxy.MainColor,
	["Palettes"] = v2.Galaxy.Palettes,
	["Order"] = 6,
	["ColorOrder"] = 4,
	["LimitedMutation"] = 1758999600,
	["ShowInSettings"] = false,
	["Index"] = require(script.Index.Galaxy),
	["IsMutation"] = true,
	["CompletitionPercent"] = 1,
	["BaseColors"] = {
		[Vector3.new(99, 95, 98)] = Color3.fromRGB(167, 79, 255),
		[Vector3.new(69, 71, 80)] = Color3.fromRGB(87, 0, 186),
		[Vector3.new(27, 42, 53)] = Color3.fromRGB(32, 12, 48),
		[Vector3.new(91, 93, 105)] = Color3.fromRGB(113, 0, 243)
	}
}
v3.Galaxy = v9
local v10 = {
	["DisplayText"] = v2.YinYang.DisplayText,
	["UseRichText"] = v2.YinYang.UseRichText,
	["DisplayWithRichText"] = v2.YinYang.DisplayWithRichText,
	["MainColor"] = v2.YinYang.MainColor,
	["Palettes"] = v2.YinYang.Palettes,
	["Order"] = 7,
	["ColorOrder"] = 5,
	["LimitedMutation"] = 1763236800,
	["Index"] = require(script.Index.YinYang),
	["IsMutation"] = true,
	["CompletitionPercent"] = 0.75,
	["BaseColors"] = {
		[Vector3.new(99, 95, 98)] = Color3.fromRGB(204, 204, 204),
		[Vector3.new(69, 71, 80)] = Color3.fromRGB(204, 204, 204),
		[Vector3.new(27, 42, 53)] = Color3.fromRGB(0, 0, 0),
		[Vector3.new(91, 93, 105)] = Color3.fromRGB(0, 0, 0),
		[Vector3.new(196, 40, 28)] = Color3.fromRGB(159, 161, 172),
		["Ground"] = Color3.fromRGB(159, 161, 172)
	}
}
v3.YinYang = v10
local v11 = {
	["DisplayText"] = "Halloween",
	["UseRichText"] = true,
	["DisplayWithRichText"] = "<font color=\"#ef7625\">Halloween</font>",
	["MainColor"] = Color3.fromRGB(239, 118, 37),
	["Order"] = 8,
	["ShowInSettings"] = false,
	["Index"] = require(script.Index.Halloween),
	["LimitedMutation"] = 1762012800,
	["CountAllMutations"] = true,
	["CompletitionPercent"] = 0.75,
	["BaseColors"] = {
		[Vector3.new(99, 95, 98)] = Color3.fromRGB(220, 107, 21),
		[Vector3.new(69, 71, 80)] = Color3.fromRGB(199, 94, 20),
		[Vector3.new(27, 42, 53)] = Color3.fromRGB(161, 78, 16),
		[Vector3.new(91, 93, 105)] = Color3.fromRGB(220, 107, 21),
		[Vector3.new(202, 203, 209)] = Color3.fromRGB(198, 164, 61),
		[Vector3.new(65, 67, 75)] = Color3.fromRGB(161, 78, 16),
		[Vector3.new(108, 88, 75)] = Color3.fromRGB(198, 164, 61),
		["Ground"] = Color3.fromRGB(220, 107, 21)
	}
}
v3.Halloween = v11
local v12 = {
	["DisplayText"] = v2.Radioactive.DisplayText,
	["UseRichText"] = v2.Radioactive.UseRichText,
	["DisplayWithRichText"] = v2.Radioactive.DisplayWithRichText,
	["MainColor"] = v2.Radioactive.MainColor,
	["Palettes"] = v2.Radioactive.Palettes,
	["Order"] = 9,
	["ColorOrder"] = 6,
	["IsMutation"] = true,
	["CompletitionPercent"] = 0.75,
	["BaseColors"] = {
		[Vector3.new(99, 95, 98)] = Color3.fromRGB(114, 156, 0),
		[Vector3.new(69, 71, 80)] = Color3.fromRGB(156, 227, 50),
		[Vector3.new(27, 42, 53)] = Color3.fromRGB(31, 59, 19),
		[Vector3.new(91, 93, 105)] = Color3.fromRGB(156, 156, 156),
		[Vector3.new(202, 203, 209)] = Color3.fromRGB(255, 255, 255),
		["Ground"] = Color3.fromRGB(114, 156, 0)
	}
}
v3.Radioactive = v12
v3.Cursed = {
	["DisplayText"] = v2.Cursed.DisplayText,
	["UseRichText"] = v2.Cursed.UseRichText,
	["DisplayWithRichText"] = v2.Cursed.DisplayWithRichText,
	["MainColor"] = v2.Cursed.MainColor,
	["Palettes"] = v2.Cursed.Palettes,
	["Order"] = 10,
	["ColorOrder"] = 7,
	["LimitedMutation"] = 1771704000,
	["IsMutation"] = true,
	["CompletitionPercent"] = 0.75,
	["BaseColors"] = {}
}
local v13 = {
	["DisplayText"] = "Aquatic",
	["UseRichText"] = true,
	["DisplayWithRichText"] = "<font color=\"#0096ff\">Aquatic</font>",
	["MainColor"] = Color3.fromRGB(0, 150, 255),
	["Order"] = 10,
	["ShowInSettings"] = false,
	["Index"] = require(script.Index.Aquatic),
	["LimitedMutation"] = 1764446400,
	["CustomIndex"] = {
		["Name"] = "Aquatic"
	},
	["CountAllMutations"] = true,
	["CompletitionPercent"] = 0.9,
	["BaseColors"] = {
		[Vector3.new(99, 95, 98)] = Color3.fromRGB(59, 121, 163),
		[Vector3.new(69, 71, 80)] = Color3.fromRGB(38, 77, 104),
		[Vector3.new(27, 42, 53)] = Color3.fromRGB(21, 35, 65),
		[Vector3.new(91, 93, 105)] = Color3.fromRGB(153, 106, 53),
		[Vector3.new(202, 203, 209)] = Color3.fromRGB(99, 159, 211),
		["Ground"] = Color3.fromRGB(176, 124, 61)
	}
}
v3.Aquatic = v13
local v14 = {
		DisplayText = "Strawberry";
		UseRichText = true;
		DisplayWithRichText = "<font color=\"#cf3b3f\">Strawberry</font>";
		MainColor = Color3.fromRGB(207, 59, 63);
		Order = 13;
	    LimitedMutation = 1764446400,
		ShowInSettings = false;
		Index = {};
		DisableIndex = true;
		CountAllMutations = false;
		CompletitionPercent = 1;
		BaseColors = {
			[Vector3.new(99, 95, 98)] = Color3.fromRGB(235, 235, 235);
			[Vector3.new(69, 71, 80)] = Color3.fromRGB(180, 180, 180);
			[Vector3.new(27, 42, 53)] = Color3.fromRGB(139, 139, 139);
			[Vector3.new(91, 93, 105)] = Color3.fromRGB(235, 235, 235);
			[Vector3.new(202, 203, 209)] = Color3.fromRGB(253, 213, 110);
			Ground = Color3.fromRGB(196, 40, 28);
	}
}
v3.Strawberry = v14
local v15 = {
	["DisplayText"] = "Gingerbread",
	["UseRichText"] = true,
	["DisplayWithRichText"] = "<font color=\"#ff7327\">Gingerbread</font>",
	["MainColor"] = Color3.fromRGB(255, 115, 39),
	["Order"] = 11,
	["ShowInSettings"] = false,
	["Index"] = {},
	["DisableIndex"] = true,
	["CountAllMutations"] = false,
	["CompletitionPercent"] = 1,
	["BaseColors"] = {
	}
}
v3.GingerBread = v15
local v16 = {
	["DisplayText"] = "Meowl",
	["UseRichText"] = true,
	["DisplayWithRichText"] = "<font color=\"#ffff14\">Meowl</font>",
	["MainColor"] = Color3.fromRGB(255, 255, 20),
	["Order"] = 14,
	["ShowInSettings"] = false,
	["Index"] = {},
	["DisableIndex"] = true,
	["CountAllMutations"] = false,
	["CompletitionPercent"] = 1,
	["BaseColors"] = {}
}
v3.Meowl = v16
return v3
