-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
require(v1.Registries.BrainrotRegistry)
require(v1.Registries.RarityRegistry)
local v2 = {}
local v3 = {
	["Value"] = 1,
	["Price"] = 50000,
	["FuseDuration"] = 300
}
local v4 = {
	["SodiniBaffini"] = {
		["MinimumTier"] = 0,
		["MaximumTier"] = 2,
		["MaximumChance"] = 1
	}
}
v3.Brainrots = v4
v2.Common = v3
local v5 = {
	["Value"] = 2,
	["Price"] = 750000,
	["FuseDuration"] = 600
}
local v6 = {
	["CameroDocumentazione"] = {
		["MinimumTier"] = 0,
		["MaximumTier"] = 2,
		["MaximumChance"] = 1
	},
	["Bangello"] = {
		["MinimumTier"] = 1.5,
		["MaximumTier"] = 3,
		["MaximumChance"] = 1
	}
}
v5.Brainrots = v6
v2.Rare = v5
local v7 = {
	["Value"] = 3,
	["Price"] = 2000000,
	["FuseDuration"] = 1200
}
local v8 = {
	["MangocelloParatello"] = {
		["MinimumTier"] = 2,
		["MaximumTier"] = 4,
		["MaximumChance"] = 1
	}
}
v7.Brainrots = v8
v2.Epic = v7
local v9 = {
	["Value"] = 4,
	["Price"] = 8500000,
	["FuseDuration"] = 1800
}
local v10 = {
	["FireFireFireSahur"] = {
		["MinimumTier"] = 3,
		["MaximumTier"] = 5,
		["MaximumChance"] = 1
	}
}
v9.Brainrots = v10
v2.Legendary = v9
local v11 = {
	["Value"] = 5,
	["Price"] = 175000000,
	["FuseDuration"] = 2400
}
local v12 = {
	["BlackholeGoat"] = {
		["MinimumTier"] = 4,
		["MaximumTier"] = 6,
		["MaximumChance"] = 1
	}
}
v11.Brainrots = v12
v2.Mythic = v11
local v13 = {
	["Value"] = 6,
	["Price"] = 2000000000,
	["FuseDuration"] = 3000
}
local v14 = {
	["QuestiniExclamini"] = {
		["MinimumTier"] = 5,
		["MaximumTier"] = 7,
		["MaximumChance"] = 1
	},
	["PoppinPizza"] = {
		["MinimumTier"] = 5.5,
		["MaximumTier"] = 7,
		["MaximumChance"] = 1
	}
}
v13.Brainrots = v14
v2.Secret = v13
local v15 = {
	["Value"] = 7,
	["Price"] = 25000000000,
	["FuseDuration"] = 3600
}
local v16 = {
	["YessMyHotspot"] = {
		["MinimumTier"] = 6,
		["MaximumTier"] = 8,
		["MaximumChance"] = 1
	},
	["SpaghettiToiletti"] = {
		["MinimumTier"] = 6.5,
		["MaximumTier"] = 9,
		["MaximumChance"] = 1
	},
	["SodiniMachini"] = {
		["MinimumTier"] = 7,
		["MaximumTier"] = 9,
		["MaximumChance"] = 1
	}
}
v15.Brainrots = v16
v2.Celestial = v15
local v17 = {
	["Value"] = 8,
	["Price"] = 120000000000,
	["FuseDuration"] = 3600
}
local v18 = {
	["ElefanteCroissante"] = {
		["MinimumTier"] = 7.4,
		["MaximumTier"] = 10,
		["MaximumChance"] = 0.08,
		["LuckMaximumChance"] = 0.1
	}
}
v17.Brainrots = v18
v2.Godly = v17
return table.freeze(v2)
