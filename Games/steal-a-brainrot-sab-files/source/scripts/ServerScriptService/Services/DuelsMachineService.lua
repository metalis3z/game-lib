local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local activeInvites = {}
local inviteIdCounter = 0
local activeDuels = {}
local playerReconnectData = {}

local INVITE_DURATION = 30
local RECONNECT_DATA_EXPIRY = 120

return {
	Start = function()
		local Net = require(ReplicatedStorage.Packages.Net)
		local ServerData = require(ReplicatedStorage.Datas.ServerData)

		local ReconnectWarn = Net:RemoteEvent("DuelsMachineService/ReconnectWarn")
		local CreateInvite = Net:RemoteEvent("DuelsMachineService/CreateInvite")
		local Reconnect = Net:RemoteEvent("DuelsMachineService/Reconnect")
		local AcceptInvite = Net:RemoteFunction("DuelsMachineService/AcceptInvite")
		local SearchUser = Net:RemoteFunction("DuelsMachineService/SearchUser")
		local Invite = Net:RemoteFunction("DuelsMachineService/Invite")
		local Notify = Net:RemoteEvent("NotificationService/Notify")

		task.spawn(function()
			while true do
				task.wait(60)
				local now = workspace:GetServerTimeNow()
				for userId, data in pairs(playerReconnectData) do
					if now - data.warnedAt > RECONNECT_DATA_EXPIRY then
						playerReconnectData[userId] = nil
					end
				end
			end
		end)

		Invite.OnServerInvoke = function(player, targetUserId)
			if not player or not player.Parent then
				return false, "Invalid player"
			end
			if activeDuels[player.UserId] then
				return false, "You are already in a duel"
			end

			local targetPlayer = Players:GetPlayerByUserId(targetUserId)
			if not targetPlayer then
				return false, "User is not in this server"
			end
			if activeDuels[targetUserId] then
				return false, "User is already in a duel"
			end

			inviteIdCounter += 1
			local inviteId = "invite_" .. tostring(inviteIdCounter)

			local inviteData = {
				from     = player.UserId,
				to       = targetUserId,
				expires  = workspace:GetServerTimeNow() + INVITE_DURATION,
				serverId = game.JobId,
			}

			activeInvites[inviteId] = inviteData

			task.spawn(function()
				local ok, err = pcall(function()
					CreateInvite:FireClient(targetPlayer, inviteId, inviteData)
				end)
				if not ok then
					warn("Failed to send invite to client:", err)
				end
			end)

			task.delay(INVITE_DURATION, function()
				activeInvites[inviteId] = nil
			end)

			return true, "Invite sent!"
		end

		AcceptInvite.OnServerInvoke = function(player, inviteId)
			if not player or not player.Parent then
				return false, "Invalid player"
			end

			local invite = activeInvites[inviteId]
			if not invite then
				return false, "Invite expired or invalid"
			end
			if invite.to ~= player.UserId then
				return false, "This invite is not for you"
			end

			local fromPlayer = Players:GetPlayerByUserId(invite.from)
			if not fromPlayer then
				activeInvites[inviteId] = nil
				return false, "User is not in game"
			end

			if activeDuels[player.UserId] or activeDuels[invite.from] then
				activeInvites[inviteId] = nil
				return false, "One of the players is already in a duel"
			end

			activeInvites[inviteId] = nil

			activeDuels[player.UserId] = {
				opponent  = invite.from,
				startTime = workspace:GetServerTimeNow(),
			}
			activeDuels[invite.from] = {
				opponent  = player.UserId,
				startTime = workspace:GetServerTimeNow(),
			}

			task.spawn(function()
				Notify:FireClient(player, "Teleporting to duel server...", 5, "Sounds.Sfx.Success")
				Notify:FireClient(fromPlayer, ("<font color='#1e801c'>@%s accepted your duel invite! Teleporting to duel server...</font>"):format(player.Name), 5, "Sounds.Sfx.Success")

				local duelsPlaceId = ServerData.DuelsPlaceId or game.PlaceId

				local teleportOptions = Instance.new("TeleportOptions")
				teleportOptions:SetTeleportData({
					type      = "Duel",
					players   = {player.UserId, invite.from},
					timestamp = workspace:GetServerTimeNow(),
				})

				local ok, errorMsg = pcall(function()
					TeleportService:TeleportAsync(duelsPlaceId, {player, fromPlayer}, teleportOptions)
				end)

				if not ok then
					activeDuels[player.UserId] = nil
					activeDuels[invite.from] = nil
					Notify:FireClient(player, "Failed to start duel: " .. tostring(errorMsg), 5, "Sounds.Sfx.Error")
					Notify:FireClient(fromPlayer, "Failed to start duel: " .. tostring(errorMsg), 5, "Sounds.Sfx.Error")
				else
					task.delay(5, function()
						activeDuels[player.UserId] = nil
						activeDuels[invite.from] = nil
					end)
				end
			end)

			return true, "Duel accepted!"
		end

		SearchUser.OnServerInvoke = function(player, userId)
			if not player or not player.Parent then
				return false, false, false
			end

			local targetPlayer = Players:GetPlayerByUserId(userId)
			if targetPlayer then
				local canInvite = not activeDuels[userId]
				return true, true, canInvite
			end

			return true, false, false
		end

		ReconnectWarn.OnServerEvent:Connect(function(player)
			if not player or not player.Parent then return end

			if activeDuels[player.UserId] then
				playerReconnectData[player.UserId] = {
					opponent = activeDuels[player.UserId].opponent,
					warnedAt = workspace:GetServerTimeNow(),
				}
			end
		end)

		Reconnect.OnServerEvent:Connect(function(player, shouldReconnect)
			if not player or not player.Parent then return end

			local reconnectData = playerReconnectData[player.UserId]
			if not reconnectData then return end

			if shouldReconnect then
				local opponent = Players:GetPlayerByUserId(reconnectData.opponent)
				if opponent and activeDuels[reconnectData.opponent] then
					activeDuels[player.UserId] = {
						opponent  = reconnectData.opponent,
						startTime = workspace:GetServerTimeNow(),
					}
					task.spawn(function()
						Notify:FireClient(player, "Reconnected to duel!", 5, "Sounds.Sfx.Success")
						Notify:FireClient(opponent, ("<font color='#e9944c'>@%s</font> reconnected to the duel!"):format(player.Name), 5, "Sounds.Sfx.Success")
					end)
				else
					task.spawn(function()
						Notify:FireClient(player, "Duel has ended, cannot reconnect", 5, "Sounds.Sfx.Error")
					end)
				end
			else
				if activeDuels[player.UserId] then
					local opponentId = activeDuels[player.UserId].opponent
					local opponent = Players:GetPlayerByUserId(opponentId)

					activeDuels[player.UserId] = nil
					activeDuels[opponentId] = nil

					if opponent then
						task.spawn(function()
							Notify:FireClient(opponent, ("<font color='#e9944c'>@%s</font> forfeited the duel!"):format(player.Name), 5, "Sounds.Sfx.Error")
						end)
					end
				end
			end

			playerReconnectData[player.UserId] = nil
		end)

		Players.PlayerRemoving:Connect(function(player)
			if activeDuels[player.UserId] then
				local opponentId = activeDuels[player.UserId].opponent
				local opponent = Players:GetPlayerByUserId(opponentId)

				if opponent then
					task.spawn(function()
						Reconnect:FireClient(opponent, player.UserId)
					end)
				end

				activeDuels[player.UserId] = nil
			end

			for inviteId, invite in pairs(activeInvites) do
				if invite.from == player.UserId or invite.to == player.UserId then
					activeInvites[inviteId] = nil
				end
			end

			playerReconnectData[player.UserId] = nil
		end)
	end,
}