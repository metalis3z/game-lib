-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("StarterPlayer")
local v3 = require(v1.Registries.PermissionRegistries.PermissionGroupEnumsType)
require(v1.Registries.PermissionRegistries.PermissionNodesEnumsType)
local v4 = require(v2.StarterPlayerScripts.Controllers.ScopeController)
local v5 = {}
local v6 = v4.ScopeEnums.PRODUCTION
local v7 = {
	["Users"] = {
		["10916243"] = v3.GlobalAdmin,
		["327423121"] = v3.GlobalAdmin,
		["425901043"] = v3.GlobalAdmin,
		["1966448091"] = v3.GlobalAdmin,
		["1355035903"] = v3.GlobalAdmin,
		["-1"] = v3.GlobalAdmin,
		["-2"] = v3.GlobalAdmin,
		["-3"] = v3.GlobalAdmin,
		["-4"] = v3.GlobalAdmin,
		["-5"] = v3.GlobalAdmin,
		["-6"] = v3.GlobalAdmin,
		["-7"] = v3.GlobalAdmin,
		["-8"] = v3.GlobalAdmin,
		["-9"] = v3.GlobalAdmin,
		["-10"] = v3.GlobalAdmin
	},
	["Roles"] = {
		["200"] = v3.GlobalAdmin
	}
}
v5[v6] = v7
local v8 = v4.ScopeEnums.DEV
local v9 = {
	["Users"] = {
		["10916243"] = v3.GlobalAdmin,
		["327423121"] = v3.GlobalAdmin,
		["425901043"] = v3.GlobalAdmin,
		["92896663"] = v3.GlobalAdmin,
		["224410"] = v3.GlobalAdmin,
		["69326238"] = v3.GlobalAdmin,
		["9971579724"] = v3.GlobalAdmin,
		["1966448091"] = v3.GlobalAdmin,
		["885530"] = v3.GlobalAdmin,
		["1355035903"] = v3.GlobalAdmin,
		["-1"] = v3.GlobalAdmin,
		["-2"] = v3.GlobalAdmin,
		["-3"] = v3.GlobalAdmin,
		["-4"] = v3.GlobalAdmin,
		["-5"] = v3.GlobalAdmin,
		["-6"] = v3.GlobalAdmin,
		["-7"] = v3.GlobalAdmin,
		["-8"] = v3.GlobalAdmin,
		["-9"] = v3.GlobalAdmin,
		["-10"] = v3.GlobalAdmin
	},
	["Roles"] = {
		["200"] = v3.GlobalAdmin
	}
}
v5[v8] = v9
local v10 = v4.ScopeEnums.STAGING
local v11 = {
	["Users"] = {
		["1966448091"] = v3.GlobalAdmin
	},
	["Roles"] = {
		["253"] = v3.GlobalAdmin
	}
}
v5[v10] = v11
return v5
