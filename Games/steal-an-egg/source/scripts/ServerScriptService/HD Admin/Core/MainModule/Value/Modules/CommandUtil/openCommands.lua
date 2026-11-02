--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local openCommandsRemote = require(modules.References.openCommandsRemote)
local boosterDisplay = require(modules.CommandUtil.boosterDisplay)

return function(player: Player?)
	if not player then
		return
	end
	openCommandsRemote:fireClient(player, boosterDisplay.getAll())
end
