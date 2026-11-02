local module = function(Conch, Config)
	local Players = game:GetService("Players")
	local DataStoreService = game:GetService("DataStoreService")
	local SS = game:GetService("ServerScriptService")

	Conch.register("lbreset", {
		description = "Reset le score d'un joueur dans un leaderboard spécifique (Generation ou Steals). Fonctionne hors ligne.",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument", type = "string", name = "Player",
			},
			{
				kind = "argument", type = "string", name = "Board",
				-- "Generation" ou "Steals"
			}
		end,
		callback = function(targetName, board)
			board = board or "Generation"
			if board ~= "Generation" and board ~= "Steals" then
				return false, "Board invalide. Utilise 'Generation' ou 'Steals'."
			end
			local ok, userId = pcall(function()
				return Players:GetUserIdFromNameAsync(targetName)
			end)
			if not ok or not userId then
				return false, ("Joueur '%s' introuvable."):format(tostring(targetName))
			end
			-- Reset dans le DataStore du leaderboard
			local store = DataStoreService:GetOrderedDataStore(board .. "Leaderboard_V4")
			local success, err = pcall(function()
				store:RemoveAsync(tostring(userId))
			end)
			-- Si en ligne, reset aussi en mémoire
			local target = Players:GetPlayerByUserId(userId)
			if target then
				local LeaderboardService = require(SS.Services.LeaderboardService)
				pcall(function() LeaderboardService:UpdatePlayerStat(target, board, 0) end)
			end
			if success then
				return string.format("✅ Score '%s' reset → %s (ID:%d)", board, targetName, userId)
			else
				return false, "Erreur: " .. tostring(err)
			end
		end,
	})
end
return module