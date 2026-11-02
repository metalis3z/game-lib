--!strict
-- LOCAL
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local getInternalCommands = require(modules.CommandUtil.getInternalCommands)(script)


-- COMMANDS
return {

	--------------------
	getInternalCommands("Troll"),
	getInternalCommands("Disasters"),

	--------------------

}
