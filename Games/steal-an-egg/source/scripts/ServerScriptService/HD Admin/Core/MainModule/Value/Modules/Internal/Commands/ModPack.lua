--!strict
-- LOCAL
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local getInternalCommands = require(modules.CommandUtil.getInternalCommands)(script)


-- COMMANDS
return {

	--------------------
	getInternalCommands("ModUtility"),
	getInternalCommands("Moderate"),
	getInternalCommands("Movement"),
	getInternalCommands("Humanoid"),
	getInternalCommands("Tool"),
	getInternalCommands("World"),
	getInternalCommands("Display"),

	--------------------

}
