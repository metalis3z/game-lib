local module = function(Conch, Config)
	local Players = game:GetService("Players")
	local DataStoreService = game:GetService("DataStoreService")
	local BanStore = DataStoreService:GetDataStore("GlobalBans")
	local BanService = require(game.ServerScriptService.Services.BanService)

	if _G.MessagingHub then
		_G.MessagingHub.Register("GLOBAL_BAN", function(data)
			local target = Players:GetPlayerByUserId(data.userId)
			if target then
				target:Kick(data.reason and ("🚫 Banni : " .. data.reason) or "🚫 Vous avez été banni.")
			end
		end)
	end

	Conch.register("banglobal", {
		description = "Bannit un joueur de façon permanente (cross-serveur). Si le joueur est en ligne il est kick immédiatement. Le ban persiste au reconnect.",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument", type = "string", name = "Player",
			},
			{
				kind = "argument", type = "string", name = "Reason", optional = true,
			}
		end,
		callback = function(targetName, reason)
			reason = reason and reason ~= "" and reason or "Banni par un admin"
			local ok, userId = pcall(function()
				return Players:GetUserIdFromNameAsync(targetName)
			end)
			if not ok or not userId then
				return false, ("Joueur '%s' introuvable."):format(tostring(targetName))
			end
			-- Appliquer le ban
			BanService:BanUser(userId, nil, reason)
			-- Kick sur tous les serveurs
			if _G.MessagingHub then
				_G.MessagingHub.Publish("GLOBAL_BAN", {
					userId = userId,
					reason = reason,
				})
			end
			return string.format("✅ %s (ID:%d) banni — Raison: %s", targetName, userId, reason)
		end,
	})
end
return module