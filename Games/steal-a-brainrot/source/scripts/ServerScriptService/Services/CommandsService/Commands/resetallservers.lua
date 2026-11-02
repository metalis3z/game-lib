local module = function(Conch, Config)
	local Players        = game:GetService("Players")
	local TeleportService = game:GetService("TeleportService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local THIS_JOB_ID = game.JobId
	local MSG_TYPE    = "RESET_ALL_SERVERS_V2"
	local SD          = require(ReplicatedStorage.Datas.ServerData)
	local PLACE_ID    = SD.RootPlaceId or game.PlaceId

	local function resetThisServer(delay)
		task.delay(delay or 0, function()
			local players = Players:GetPlayers()
			if #players == 0 then return end
			local ok, err = pcall(function()
				TeleportService:TeleportAsync(PLACE_ID, players)
			end)
			if not ok then
				warn("[resetallservers] TeleportAsync failed:", err)
				-- Fallback kick
				for _, p in ipairs(players) do
					pcall(function() p:Kick("🔄 Server restarting — please rejoin!") end)
				end
			end
		end)
	end

	-- Handler pour recevoir le signal des autres serveurs
	task.spawn(function()
		while not _G.MessagingHub do task.wait(0.5) end
		_G.MessagingHub.Register(MSG_TYPE, function(data)
			if data.senderJobId == THIS_JOB_ID then return end
			resetThisServer(data.delay or 0)
		end)
	end)

	Conch.register("resetallservers", {
		description = "Téléporte tous les joueurs de TOUS les serveurs vers un nouveau serveur (= restart global). Délai optionnel en secondes.",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument", type = "number", name = "Delay (secondes)", optional = true,
			}
		end,
		callback = function(delay)
			delay = tonumber(delay) or 0

			-- Reset ce serveur
			resetThisServer(delay)

			-- Broadcaster à tous les autres serveurs
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					delay       = delay,
					senderJobId = THIS_JOB_ID,
				})
			end

			if delay > 0 then
				return string.format("✅ Restart global dans %d secondes sur tous les serveurs.", delay)
			end
			return "✅ Restart global en cours sur tous les serveurs..."
		end,
	})
end
return module