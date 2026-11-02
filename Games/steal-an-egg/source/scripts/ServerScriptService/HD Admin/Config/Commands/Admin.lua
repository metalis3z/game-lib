--!strict
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local Internal = require(modules.Internal)
return Internal.loadCommands({
	modules = {"AdminPack"},
	tag = script.Name,
	tagOrder = 3,
	exclude = {},
	onlyInclude = {},
	modify = {
		savemap = function(command)
			command.config.saveMapOnStart = false -- When true the map backs up at server start so ;loadMap works without ;saveMap
		end,
	},
})
