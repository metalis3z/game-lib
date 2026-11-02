--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local openPageRemote = require(modules.References.openPageRemote)


return function(player: Player?, pageId: string, tabLabel: string?)
	if not player then
		return
	end
	openPageRemote:fireClient(player, pageId, tabLabel)
end
