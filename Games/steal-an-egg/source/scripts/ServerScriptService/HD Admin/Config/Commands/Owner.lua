--!strict
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local Internal = require(modules.Internal)
return Internal.loadCommands({
	modules = {"OwnerPack"},
	tag = script.Name,
	tagOrder = 1,
	exclude = {},
	onlyInclude = {},
})
