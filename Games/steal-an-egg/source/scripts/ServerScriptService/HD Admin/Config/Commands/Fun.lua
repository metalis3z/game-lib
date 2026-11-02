--!strict
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local Internal = require(modules.Internal)
return Internal.loadCommands({
	modules = {"FunPack"},
	tag = script.Name,
	tagOrder = 5,
	exclude = {"Fire", "Smoke", "Sparkles"},
	onlyInclude = {},
})
