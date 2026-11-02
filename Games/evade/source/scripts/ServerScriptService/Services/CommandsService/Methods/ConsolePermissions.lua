local Config = require(script.Parent.Parent.Config)

local ConsolePermissions = {}

function ConsolePermissions.hasPermission(player)
	if table.find(Config.AllowedUserIds, player.UserId) then
		return true
	end

	if Config.GroupId and Config.MinGroupRank then
		local ok, rank = pcall(player.GetRankInGroup, player, Config.GroupId)
		if ok and rank >= Config.MinGroupRank then
			return true
		end
	end

	return false
end

return ConsolePermissions 