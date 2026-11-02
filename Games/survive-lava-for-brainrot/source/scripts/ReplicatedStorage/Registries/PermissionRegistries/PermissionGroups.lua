-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("StarterPlayer")
local v3 = require(v2.StarterPlayerScripts.Controllers.ScopeController)
local v4 = require(v1.Registries.PermissionRegistries.PermissionGroupEnumsType)
local v5 = require(v1.Registries.PermissionRegistries.PermissionNodesEnumsType)
local v6 = {}
local v7 = v3.ScopeEnums.PRODUCTION
local v8 = {
	[v4.GlobalAdmin] = {
		["Priority"] = 1,
		["PermissionNodes"] = {
			v5.GLOBAL_COMMANDS_PERMISSION,
			v5.SERVER_COMMANDS_PERMISSION,
			v5.STAT_ADJUSTMENT_PERMISSION,
			v5.VIEW_COMMAND_BAR_PERMISSION,
			v5.SPAWN_ITEM_PERMISSION,
			v5.AFFECT_OTHER_PLAYERS_PERMISSION,
			v5.RUN_COMMANDS_PERMISSION
		}
	},
	[v4.Admin] = {
		["Priority"] = 2,
		["PermissionNodes"] = {}
	},
	[v4.TesterAdmin] = {
		["Priority"] = 3,
		["PermissionNodes"] = {}
	}
}
v6[v7] = v8
local v9 = v3.ScopeEnums.DEV
local v10 = {
	[v4.GlobalAdmin] = {
		["Priority"] = 1,
		["PermissionNodes"] = {
			v5.GLOBAL_COMMANDS_PERMISSION,
			v5.SERVER_COMMANDS_PERMISSION,
			v5.STAT_ADJUSTMENT_PERMISSION,
			v5.VIEW_COMMAND_BAR_PERMISSION,
			v5.SPAWN_ITEM_PERMISSION,
			v5.AFFECT_OTHER_PLAYERS_PERMISSION,
			v5.RUN_COMMANDS_PERMISSION,
			v5.UNLIMIT_SPAWN_ITEM_PERMISSION
		}
	},
	[v4.Admin] = {
		["Priority"] = 2,
		["PermissionNodes"] = {
			v5.SERVER_COMMANDS_PERMISSION,
			v5.STAT_ADJUSTMENT_PERMISSION,
			v5.VIEW_COMMAND_BAR_PERMISSION,
			v5.SPAWN_ITEM_PERMISSION,
			v5.AFFECT_OTHER_PLAYERS_PERMISSION,
			v5.RUN_COMMANDS_PERMISSION
		}
	},
	[v4.TesterAdmin] = {
		["Priority"] = 3,
		["PermissionNodes"] = {
			v5.STAT_ADJUSTMENT_PERMISSION,
			v5.VIEW_COMMAND_BAR_PERMISSION,
			v5.RUN_COMMANDS_PERMISSION,
			v5.SPAWN_ITEM_PERMISSION
		}
	}
}
v6[v9] = v10
local v11 = v3.ScopeEnums.STAGING
local v12 = {
	[v4.GlobalAdmin] = {
		["Priority"] = 1,
		["PermissionNodes"] = {
			v5.GLOBAL_COMMANDS_PERMISSION,
			v5.SERVER_COMMANDS_PERMISSION,
			v5.STAT_ADJUSTMENT_PERMISSION,
			v5.VIEW_COMMAND_BAR_PERMISSION,
			v5.SPAWN_ITEM_PERMISSION,
			v5.AFFECT_OTHER_PLAYERS_PERMISSION
		}
	},
	[v4.Admin] = {
		["Priority"] = 2,
		["PermissionNodes"] = {
			v5.SERVER_COMMANDS_PERMISSION,
			v5.STAT_ADJUSTMENT_PERMISSION,
			v5.VIEW_COMMAND_BAR_PERMISSION,
			v5.SPAWN_ITEM_PERMISSION,
			v5.AFFECT_OTHER_PLAYERS_PERMISSION
		}
	},
	[v4.TesterAdmin] = {
		["Priority"] = 3,
		["PermissionNodes"] = {
			v5.SERVER_COMMANDS_PERMISSION,
			v5.STAT_ADJUSTMENT_PERMISSION,
			v5.VIEW_COMMAND_BAR_PERMISSION,
			v5.SPAWN_ITEM_PERMISSION
		}
	}
}
v6[v11] = v12
return v6
