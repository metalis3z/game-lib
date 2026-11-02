--!strict
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local Internal = require(modules.Internal)
return Internal.loadCommands({
	modules = {"ModPack"},
	tag = script.Name,
	tagOrder = 4,
	exclude = {},
	onlyInclude = {},
	modify = {
		gear = function(command)
			command.config.DenyList = {} -- -- GearIds to block (e.g. ``{000, 111, 222}``)
			command.config.AllowList = {} -- If more than 0 items, only these GearIds will be allowed  (e.g. ``{000, 111, 222}``)
			command.config.ReplaceList = {} -- [GearIdA] = GearIdB, where GearIdA is replaced with GearIdB (e.g. ``{000 = 111, 222 = 333}``)
		end,
	},
})
