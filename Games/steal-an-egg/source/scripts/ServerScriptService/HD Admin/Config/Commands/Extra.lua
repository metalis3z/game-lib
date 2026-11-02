--!strict
-- These are extra commands, typically fun/abusive/troll commands. Most aren't added to any of
-- the default roles, though some are (the Fun role picks up "Troll" by tag). New drops land here
-- so you can easily connect them up to roles once they release.
-- Highly recommend keeping if you wanna stay up to date with new command releases!
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local Internal = require(modules.Internal)
return Internal.loadCommands({
	modules = {"ExtraPack"},
	tag = script.Name,
	tagOrder = 7,
	exclude = {},
	onlyInclude = {},
})
