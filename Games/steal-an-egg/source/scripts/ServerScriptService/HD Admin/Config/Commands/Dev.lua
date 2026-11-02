--!strict
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local Internal = require(modules.Internal)
return Internal.loadCommands({
	modules = {"DevPack"},
	tag = script.Name,
	tagOrder = 2,
	exclude = {},
	onlyInclude = {},
	modify = {
		insert = function(command)
			command.config.DenyList = {} -- AssetIds to block (e.g. ``{000, 111, 222}``)
			command.config.AllowList = {} -- If more than 0 items, only these AssetIds can be inserted  (e.g. ``{000, 111, 222}``)
			command.config.ReplaceList = {} -- [IdA] = IdB, where IdA is replaced with IdB (e.g. ``{000 = 111, 222 = 333}``)
		end,
	},
})
