local Players = game:GetService("Players")

local module = function(Conch, Config)
	-- Enregistrer le handler au démarrage via MessagingHub
	if _G.MessagingHub then
		_G.MessagingHub.Register("GetServerCount_Request", function(data)
			_G.MessagingHub.Publish("GetServerCountResponse", { count = 1 })
		end)
	end

	Conch.register("gettotalservers", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {}
		end,

		callback = function()
			-- Attendre que MessagingHub soit prêt
			if not _G.MessagingHub then
				task.wait(2)
			end

			local totalServers = 1

			-- Enregistrer le handler pour la réponse
			_G.MessagingHub.Register("GetServerCountResponse", function(data)
				totalServers = totalServers + (tonumber(data.count) or 1)
			end)

			-- Demander à tous les serveurs de répondre
			_G.MessagingHub.Publish("GetServerCount_Request", { jobId = game.JobId })

			task.wait(1.5)

			return "Total server count across all active sessions: " .. totalServers
		end
	})

end

return module