--!strict
-- LOCAL 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local openEmotesRemote = require(modules.References.openEmotesRemote)


return function(player: Player?)
	if not player then
		return
	end
	openEmotesRemote:fireClient(player)
end
