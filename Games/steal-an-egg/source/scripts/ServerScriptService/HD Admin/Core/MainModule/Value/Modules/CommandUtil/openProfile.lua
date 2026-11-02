--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local openProfileRemote = require(modules.References.openProfileRemote)


return function(player: Player?, userId: number)
	if not player then
		return
	end
	openProfileRemote:fireClient(player, userId)
end
