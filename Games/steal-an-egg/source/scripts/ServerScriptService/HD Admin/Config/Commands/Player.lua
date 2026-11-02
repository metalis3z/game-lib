--!strict
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local Internal = require(modules.Internal)
return Internal.loadCommands({
	modules = {"PlayerPack"},
	tag = script.Name,
	tagOrder = 6,
	exclude = {},
	onlyInclude = {},
})
