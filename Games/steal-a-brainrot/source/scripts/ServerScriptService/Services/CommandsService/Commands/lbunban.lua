local module = function(Conch, Config)
	local Players = game:GetService("Players")
	local DataStoreService = game:GetService("DataStoreService")
	local LbBanStore = DataStoreService:GetDataStore("LeaderboardBans_v1")
	local SS = game:GetService("ServerScriptService")

	if _G.MessagingHub then
		_G.MessagingHub.Register("LB_UNBAN", function(data)
			local LeaderboardService = require(SS.Services.LeaderboardService)
			if LeaderboardService.BannedUsers then
				LeaderboardService.BannedUsers[data.userId] = nil
			end
		end)
	end

	Conch.register("lbunban", {
		description = "Débannit un joueur du leaderboard. Il réapparaîtra dans les classements au prochain refresh.",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return { kind = "argument", type = "string", name = "Player" }
		end,
		callback = function(targetName)
			local ok, userId = pcall(function()
				return Players:GetUserIdFromNameAsync(targetName)
			end)
			if not ok or not userId then
				return false, ("Joueur '%s' introuvable."):format(tostring(targetName))
			end
			pcall(function() LbBanStore:RemoveAsync("lbban_"..userId) end)
			local LeaderboardService = require(SS.Services.LeaderboardService)
			if LeaderboardService.BannedUsers then
				LeaderboardService.BannedUsers[userId] = nil
			end
			if _G.MessagingHub then
				_G.MessagingHub.Publish("LB_UNBAN", { userId = userId })
			end
			return string.format("✅ %s (ID:%d) débanni du leaderboard.", targetName, userId)
		end,
	})
end
return module