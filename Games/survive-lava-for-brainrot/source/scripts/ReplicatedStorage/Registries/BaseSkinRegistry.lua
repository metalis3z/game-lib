-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
require(v1.Registries.MutationRegistry)
local v2 = {}
local v3 = {
	["Index"] = 1,
	["Completion"] = {
		["Mutation"] = "Normal",
		["Percentage"] = 0
	},
	["Icon"] = "rbxassetid://102314010496215"
}
v2.Default = v3
local v4 = {
	["Index"] = 2,
	["Completion"] = {
		["Mutation"] = "Gold",
		["Percentage"] = 80
	},
	["Icon"] = "rbxassetid://137498416525678"
}
v2.Gold = v4
local v5 = {
	["Index"] = 3,
	["Completion"] = {
		["Mutation"] = "Diamond",
		["Percentage"] = 80
	},
	["Icon"] = "rbxassetid://98202959433300"
}
v2.Diamond = v5
local v6 = {
	["Index"] = 4,
	["Completion"] = {
		["Mutation"] = "Emerald",
		["Percentage"] = 80
	},
	["Icon"] = "rbxassetid://105219886246734"
}
v2.Emerald = v6
local v7 = {
	["Index"] = 5,
	["Completion"] = {
		["Mutation"] = "Bloodmoon",
		["Percentage"] = 80
	},
	["Icon"] = "rbxassetid://76398974055001"
}
v2.Bloodmoon = v7
local v8 = {
	["Index"] = 6,
	["Completion"] = {
		["Mutation"] = "Rainbow",
		["Percentage"] = 80
	},
	["Icon"] = "rbxassetid://100250921368131"
}
v2.Rainbow = v8
v2.VIP = {
	["Index"] = 7,
	["GamePassId"] = 1694602214,
	["Icon"] = "rbxassetid://131932313423954"
}
return table.freeze(v2)
