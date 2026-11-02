local module = function(Conch, Config, CommandsService)
	local Players = game:GetService("Players")
	local MessagingService = game:GetService("MessagingService")
	local TeleportService = game:GetService("TeleportService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RunService = game:GetService("RunService")
	local DataStoreService = game:GetService("DataStoreService")

	local Net = require(ReplicatedStorage.Packages.Net)

	-- Remote event for teleporting player
	local TeleportEvent = Net:RemoteEvent("TeleportTo/Teleport")

	-- Store pending teleport requests and their responses
	local pendingTeleports = {}

	-- DataStore for server tracking
	local ServerTracker = DataStoreService:GetDataStore("ServerTracker")

	-- Handle finding player across servers
	local function setupTeleportHandler()
		if RunService:IsStudio() then
			return
		end

		-- Listen for player location requests
		MessagingService:SubscribeAsync("TeleportToFindPlayer", function(message)
			local data = message.Data
			if not data then return end

			-- Check if the target player is in this server
			local targetPlayer = Players:FindFirstChild(data.TargetPlayerName)
			if targetPlayer then
				-- Get the private server code if this is a private server
				local privateServerCode = ""
				local isPrivateServer = game.PrivateServerId ~= nil and game.PrivateServerId ~= ""

				if isPrivateServer then
					-- Get the access code for this private server
					privateServerCode = game.PrivateServerId or ""
					
					-- Store the server info for this player
					pcall(function()
						ServerTracker:SetAsync("Player_" .. targetPlayer.UserId, {
							JobId = game.JobId,
							PrivateServerCode = privateServerCode,
							IsPrivateServer = true,
							Timestamp = os.time()
						})
					end)
				else
					-- Store the server info for public server
					pcall(function()
						ServerTracker:SetAsync("Player_" .. targetPlayer.UserId, {
							JobId = game.JobId,
							IsPrivateServer = false,
							Timestamp = os.time()
						})
					end)
				end

				-- Respond with this server's info
				MessagingService:PublishAsync("TeleportToPlayerFound", {
					RequestId = data.RequestId,
					TargetJobId = game.JobId,
					TargetPlayerName = data.TargetPlayerName,
					TargetUserId = targetPlayer.UserId,
					PrivateServerCode = privateServerCode,
					IsPrivateServer = isPrivateServer
				})
			end
		end)

		-- Listen for player found responses
		MessagingService:SubscribeAsync("TeleportToPlayerFound", function(message)
			local data = message.Data
			if not data then return end

			-- Check if we have a pending teleport for this request
			local pending = pendingTeleports[data.RequestId]
			if pending then
				local success, err

				if data.IsPrivateServer and data.PrivateServerCode ~= "" then
					-- Teleport to private server
					success, err = pcall(function()
						TeleportService:TeleportToPrivateServer(game.PlaceId, data.PrivateServerCode, {pending.Requester})
					end)
				else
					-- For public servers, we need to use a different approach
					-- Try to reserve a server and teleport there, then the target will be notified
					local reservedCode = TeleportService:ReserveServer(game.PlaceId)
					
					-- Store the teleport request for the target player
					pcall(function()
						ServerTracker:SetAsync("TeleportRequest_" .. data.TargetUserId, {
							RequesterName = pending.Requester.Name,
							RequesterUserId = pending.Requester.UserId,
							ReservedCode = reservedCode,
							Timestamp = os.time()
						})
					end)
					
					-- Notify the target player's server to teleport them to the reserved server
					MessagingService:PublishAsync("TeleportToReservedServer", {
						TargetUserId = data.TargetUserId,
						TargetJobId = data.TargetJobId,
						ReservedCode = reservedCode,
						RequesterName = pending.Requester.Name
					})
					
					-- Teleport the requester to the reserved server
					success, err = pcall(function()
						TeleportService:TeleportToPrivateServer(game.PlaceId, reservedCode, {pending.Requester})
					end)
				end

				if not success then
					TeleportEvent:FireClient(pending.Requester, {
						Error = "Échec de la téléportation: " .. tostring(err)
					})
				end

				-- Clean up
				pendingTeleports[data.RequestId] = nil
			end
		end)

		-- Listen for reserved server teleport requests
		MessagingService:SubscribeAsync("TeleportToReservedServer", function(message)
			local data = message.Data
			if not data then return end

			-- Find the target player in this server
			for _, player in ipairs(Players:GetPlayers()) do
				if player.UserId == data.TargetUserId then
					-- Teleport the target player to the reserved server
					local success, err = pcall(function()
						TeleportService:TeleportToPrivateServer(game.PlaceId, data.ReservedCode, {player})
					end)
					
					if not success then
						warn("[TeleportTo] Failed to teleport target player:", err)
					end
					break
				end
			end
		end)
	end

	setupTeleportHandler()

	Conch.register("TeleportTo", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "PlayerName",
				description = "Le nom du joueur à rejoindre (avec @)",
			}
		end,
		callback = function(playerName)
			-- Get the command context to find the executor
			local context = Conch.get_command_context()
			if not context or not context.executor then
				return false, "Impossible de trouver le joueur qui a exécuté la commande."
			end

			local requesterPlayer = context.executor.player
			if not requesterPlayer then
				return false, "Impossible de trouver le joueur qui a exécuté la commande."
			end

			-- Remove @ if present
			local targetName = playerName
			if string.sub(targetName, 1, 1) == "@" then
				targetName = string.sub(targetName, 2)
			end

			-- Check if target player is in the same server
			local targetPlayer = Players:FindFirstChild(targetName)
			if targetPlayer then
				return false, string.format("%s est déjà dans votre serveur!", targetName)
			end

			-- Generate a unique request ID
			local requestId = tostring(game:GetService("HttpService"):GenerateGUID(false))

			-- Store the pending teleport
			pendingTeleports[requestId] = {
				Requester = requesterPlayer,
				TargetName = targetName,
				Timestamp = os.time()
			}

			-- Publish the request to find the player across all servers
			if not RunService:IsStudio() then
				MessagingService:PublishAsync("TeleportToFindPlayer", {
					RequestId = requestId,
					TargetPlayerName = targetName
				})

				-- Set a timeout to clean up if player not found
				task.delay(10, function()
					if pendingTeleports[requestId] then
						pendingTeleports[requestId] = nil
						TeleportEvent:FireClient(requesterPlayer, {
							Error = string.format("%s n'a pas été trouvé dans les serveurs actifs.", targetName)
						})
					end
				end)
			else
				-- In Studio, show message
				pendingTeleports[requestId] = nil
				return string.format("[STUDIO] Recherche de %s... (Non fonctionnel en Studio)", targetName)
			end

			return string.format("Téléportation vers %s en cours...", targetName)
		end,
	})
end

return module