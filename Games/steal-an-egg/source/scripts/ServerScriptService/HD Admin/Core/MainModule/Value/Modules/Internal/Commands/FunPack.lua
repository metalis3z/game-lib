--!strict
-- LOCAL
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local getInternalCommands = require(modules.CommandUtil.getInternalCommands)(script)


-- COMMANDS
return {

	--------------------
	getInternalCommands("Emote"),
	getInternalCommands("Ability"),
	getInternalCommands("Character"),

	--------------------

}
