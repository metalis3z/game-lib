-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Enums.ItemTypes)
require(v1.Registries.BrainrotRegistry)
require(v1.Registries.LuckyBlocksRegistry)
require(v1.Registries.MutationRegistry)
require(v1.Registries.TraitsRegistry)
local v3 = {
	[v2.Brainrot] = {
		["Name"] = "PipiKiwi",
		["Mutation"] = "Normal",
		["Level"] = 1,
		["Traits"] = {},
		["IsFavorited"] = false,
		["Cash"] = 0
	},
	[v2.LuckyBlock] = {
		["Name"] = "LuckyBlock"
	}
}
return table.freeze(v3)
