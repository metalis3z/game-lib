local module = function(Conch, Config)
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")
	local MessagingService = game:GetService("MessagingService")

	local LuckService = require(ServerScriptService.Services.LuckService)
	local NotificationService = require(ServerScriptService.Services.NotificationService)

	local function broadcastToAllServers(luckIndex, endTime)
		-- Envoie un message à tous les autres serveurs
		local success, err = pcall(function()
			MessagingService:PublishAsync("GlobalLuckActivated", {
				luckIndex = luckIndex,
				endTime = endTime,
				sender = game.JobId -- pour éviter de se renvoyer à soi-même
			})
		end)
		if not success then
			warn("Failed to publish global luck:", err)
		end
	end

	-- Écouter les messages des autres serveurs
if not _G._sub_cmd_addgloballuck then _G._sub_cmd_addgloballuck = true
pcall(function()
	MessagingService:SubscribeAsync("GlobalLuckActivated", function(message)
		local data = message.Data
		if data.sender == game.JobId then return end -- ignorer son propre message

		LuckService:StartLuck(data.luckIndex, data.endTime)

		-- Notifier les joueurs de ce serveur
		local text = ""
		if data.luckIndex == 1 then
			text = 'GYK Admin activated <font color="#79DD2F">2x Luck</font>!'
		elseif data.luckIndex == 2 then
			text = 'GYK Admin activated <font color="#F8DB14">4x Luck</font>!'
		end
		for _, player in ipairs(Players:GetPlayers()) do
			NotificationService.Notify(player, text, 5, "Sounds.Sfx.Success")
		end
	end)
end) end

	-- Commande globale
	Conch.register("addgloballuck", {
		permissions = { Config.RequiredRole or "admin" },
		arguments = function()
			return {
				kind = "argument",
				type = "ServerLuck",
				name = "Luck",
			}
		end,
		callback = function(luckIndex)
			local Index = tonumber(luckIndex)
			if not Index then
				return false, "Invalid luck index"
			end

			local EndTime = LuckService:GetEndTime()
			if EndTime ~= 0 then
				EndTime += 900
			else
				EndTime = workspace:GetServerTimeNow() + 900
			end

			-- Appliquer la chance sur le serveur courant
			LuckService:StartLuck(Index, EndTime)

			-- Notifier les joueurs du serveur courant
			local text = ""
			if Index == 1 then
				text = 'GYK Admin activated <font color="#79DD2F">2x Luck</font>!'
			elseif Index == 2 then
				text = 'GYK Admin activated <font color="#F8DB14">4x Luck</font>!'
			end
			for _, player in ipairs(Players:GetPlayers()) do
				NotificationService.Notify(player, text, 5, "Sounds.Sfx.Success")
			end

			-- Propager à tous les autres serveurs
			broadcastToAllServers(Index, EndTime)

			return "added globally"
		end
	})
end

return module