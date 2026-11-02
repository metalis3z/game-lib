local module = function(Conch, Config)
	local Players = game:GetService("Players")
	local BanService = require(game.ServerScriptService.Services.BanService)

	Conch.register("unbanglobal", {
		description = "Débannit un joueur. Fonctionne même si le joueur est hors ligne.",
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
			BanService:UnbanUser(userId)
			return string.format("✅ %s (ID:%d) débanni.", targetName, userId)
		end,
	})
end
return module