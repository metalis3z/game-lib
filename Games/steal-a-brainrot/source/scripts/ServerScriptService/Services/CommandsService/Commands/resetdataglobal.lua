local module = function(Conch, Config)
	local Players = game:GetService("Players")
	local DataStoreService = game:GetService("DataStoreService")
	local SS = game:GetService("ServerScriptService")
	local DataStore = DataStoreService:GetDataStore("DATA-FOR-EVERYONE_V4")
	local DefaultStats = require(SS.Components.DefaultStats)

	if _G.MessagingHub then
		_G.MessagingHub.Register("GLOBAL_RESET_DATA", function(data)
			local target = Players:GetPlayerByUserId(data.userId)
			if target then
				local DataService = require(SS.Services.DataService)
				pcall(function() DataService:ResetData(target) end)
			end
		end)
	end

	local function deepCopy(t)
		local new = {}
		for k, v in pairs(t) do new[k] = type(v)=="table" and deepCopy(v) or v end
		return new
	end

	Conch.register("resetdataglobal", {
		description = "Reset les données d'un joueur (fonctionne hors ligne et cross-serveur). Le joueur sera kick s'il est en ligne.",
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
			-- Joueur en ligne sur CE serveur
			local target = Players:GetPlayerByUserId(userId)
			if target then
				local DataService = require(SS.Services.DataService)
				pcall(function() DataService:ResetData(target) end)
				return string.format("✅ Data reset (en ligne) → %s", targetName)
			end
			-- Joueur hors ligne ou autre serveur : écrire directement dans le DataStore
			local newData = deepCopy(DefaultStats)
			local success = pcall(function()
				DataStore:SetAsync(tostring(userId), newData)
			end)
			-- Broadcaster aux autres serveurs
			if _G.MessagingHub then
				_G.MessagingHub.Publish("GLOBAL_RESET_DATA", { userId = userId })
			end
			if success then
				return string.format("✅ Data reset (hors ligne) → %s (ID:%d)", targetName, userId)
			else
				return false, "Erreur DataStore. Réessaie."
			end
		end,
	})
end
return module