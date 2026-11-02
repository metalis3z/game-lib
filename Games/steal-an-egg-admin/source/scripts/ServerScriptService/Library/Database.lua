--!strict
local ServerScriptService = game:GetService("ServerScriptService")
local DataService = require(ServerScriptService.DataService)

local Database = {}

function Database.IsPlayerLoaded(player: Player): boolean
	return DataService.IsLoaded(player)
end

function Database.UnsafeGetProfileAwait(player: Player, timeout: number?): (boolean, any)
	local profile = DataService.WaitForProfile(player, timeout or 30)
	if profile == nil then
		return false, nil
	end
	return true, profile
end

return Database