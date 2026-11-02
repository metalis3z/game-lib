-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = {
	["Normal"] = {
		["Color"] = Color3.fromRGB(255, 255, 255),
		["Weight"] = 80,
		["Multiplier"] = 1
	},
	["Gold"] = {
		["Color"] = Color3.fromRGB(255, 255, 0),
		["Weight"] = 20,
		["Multiplier"] = 1.5
	},
	["Diamond"] = {
		["Color"] = Color3.fromRGB(0, 255, 255),
		["Weight"] = 10,
		["Multiplier"] = 2
	},
	["Emerald"] = {
		["Color"] = Color3.fromRGB(0, 255, 0),
		["Weight"] = 5,
		["Multiplier"] = 3
	},
	["Bloodmoon"] = {
		["Color"] = Color3.fromRGB(200, 0, 0),
		["Weight"] = 2,
		["Multiplier"] = 4
	},
	["Rainbow"] = {
		["Color"] = Color3.fromRGB(255, 0, 0),
		["Weight"] = 0.25,
		["Multiplier"] = 10
	},
	["Ice"] = {
		["Color"] = Color3.fromRGB(0, 255, 255),
		["Weight"] = 0,
		["Multiplier"] = 1,
		["Hide"] = true
	},
	["Slime"] = {
		["Color"] = Color3.fromRGB(64, 237, 0),
		["Weight"] = 0,
		["Multiplier"] = 1,
		["Hide"] = true
	}
}
return table.freeze(v1)
