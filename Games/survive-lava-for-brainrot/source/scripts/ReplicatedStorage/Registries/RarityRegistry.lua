-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = {
	["Common"] = {
		["Color"] = Color3.fromRGB(0, 200, 0),
		["Index"] = 1,
		["Rebirths"] = 0,
		["Weight"] = 150,
		["Luck"] = 1
	},
	["Rare"] = {
		["Color"] = Color3.fromRGB(0, 150, 255),
		["Index"] = 2,
		["Rebirths"] = 0,
		["Weight"] = 90,
		["Luck"] = 1.25
	},
	["Epic"] = {
		["Color"] = Color3.fromRGB(175, 100, 255),
		["Index"] = 3,
		["Rebirths"] = 0,
		["Weight"] = 60,
		["Luck"] = 1.5
	},
	["Legendary"] = {
		["Color"] = Color3.fromRGB(255, 255, 0),
		["Index"] = 4,
		["Rebirths"] = 0,
		["Weight"] = 30,
		["Luck"] = 2
	},
	["Mythic"] = {
		["Color"] = Color3.fromRGB(225, 0, 0),
		["Index"] = 5,
		["Rebirths"] = 2,
		["Weight"] = 13,
		["Luck"] = 2.25
	},
	["Secret"] = {
		["Color"] = Color3.fromRGB(255, 255, 255),
		["Index"] = 6,
		["Rebirths"] = 4,
		["Weight"] = 6,
		["Luck"] = 3,
		["Tag"] = "Secret"
	},
	["Celestial"] = {
		["Color"] = Color3.fromRGB(255, 255, 255),
		["Index"] = 7,
		["Rebirths"] = 9,
		["Weight"] = 0,
		["Tag"] = "Celestial"
	},
	["Godly"] = {
		["Color"] = Color3.fromRGB(255, 255, 255),
		["Index"] = 8,
		["Rebirths"] = 12,
		["Weight"] = 0,
		["Tag"] = "Godly"
	}
}
return table.freeze(v1)
