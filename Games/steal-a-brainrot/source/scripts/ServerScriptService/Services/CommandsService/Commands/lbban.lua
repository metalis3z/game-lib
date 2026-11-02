local module = function(Conch, Config)
	local Players = game:GetService("Players")
	local DataStoreService = game:GetService("DataStoreService")
	local LbBanStore = DataStoreService:GetDataStore("LeaderboardBans_v1")
	local SS = game:GetService("ServerScriptService")

	if _G.MessagingHub then
		_G.MessagingHub.Register("LB_BAN", function(data)
			local LeaderboardService = require(SS.Services.LeaderboardService)
			LeaderboardService.BannedUsers = LeaderboardService.BannedUsers or {}
			LeaderboardService.BannedUsers[data.userId] = true
		end)
	end

	Conch.register("lbban", {
		description = "Bannit un joueur du leaderboard. Il n'apparaîtra plus dans aucun classement jusqu'au lbunban.",
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
			-- Sauvegarder dans DataStore
			pcall(function() LbBanStore:SetAsync("lbban_"..userId, true) end)
			-- Appliquer en live
			local LeaderboardService = require(SS.Services.LeaderboardService)
			LeaderboardService.BannedUsers = LeaderboardService.BannedUsers or {}
			LeaderboardService.BannedUsers[userId] = true
			-- Broadcaster
			if _G.MessagingHub then
				_G.MessagingHub.Publish("LB_BAN", { userId = userId })
			end
			return string.format("✅ %s (ID:%d) banni du leaderboard.", targetName, userId)
		end,
	})
end
return module