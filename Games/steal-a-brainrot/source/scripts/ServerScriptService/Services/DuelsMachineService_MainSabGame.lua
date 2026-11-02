--!native

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local Net = require(ReplicatedStorage.Packages.Net)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Updates = require(ReplicatedStorage.Shared.Updates)
local GlobalEventBus = require(ReplicatedStorage.Utils.GlobalEventBus)

local ReconnectWarn = Net:RemoteEvent("DuelsMachineService/ReconnectWarn")
local CreateInvite = Net:RemoteEvent("DuelsMachineService/CreateInvite")
local Reconnect = Net:RemoteEvent("DuelsMachineService/Reconnect")
local AcceptInvite = Net:RemoteFunction("DuelsMachineService/AcceptInvite")
local SearchUser = Net:RemoteFunction("DuelsMachineService/SearchUser")
local Invite = Net:RemoteFunction("DuelsMachineService/Invite")

local INVITE_DURATION = 60
local RECONNECT_TIMEOUT = 600
local MAX_INVITES_PER_PLAYER = 5

local ActiveInvites = {}
local ActiveDuels = {}
local PendingReconnects = {}

local DuelsMachineService = {}

local function generateInviteId()
	return game:GetService("HttpService"):GenerateGUID(false)
end

function DuelsMachineService.IsEnabled()
	local disabled = FFlags:GetInstant("DuelsMachineService/Disabled")
	if disabled then return false end

	if ServerData.IsNewPlayersServer and ServerData.IsNewPlayersServer() then return false end

	if not ServerData.IsDuelsServer or not ServerData.IsDuelsServer() then
		if Updates.Methods and Updates.Methods.IsEnabled then
			return Updates.Methods.IsEnabled("Update-04/04/2026")
		end
		return false
	end

	return true
end

function DuelsMachineService.SendInvite(_, targetUserId)
	return Invite:InvokeServer(targetUserId)
end

local function getPlayerInviteCount(userId)
	local count = 0
	for _, invite in pairs(ActiveInvites) do
		if invite.from == userId then count = count + 1 end
	end
	return count
end

local function cleanExpiredInvites()
	local currentTime = workspace:GetServerTimeNow()
	for inviteId, invite in pairs(ActiveInvites) do
		if currentTime >= invite.expires then ActiveInvites[inviteId] = nil end
	end
end

local function cleanExpiredReconnects()
	local currentTime = workspace:GetServerTimeNow()
	for userId, data in pairs(PendingReconnects) do
		if currentTime >= data.expires then PendingReconnects[userId] = nil end
	end
end

local function canPlayerInvite(fromUserId, toUserId)
	if not DuelsMachineService.IsEnabled() then return false, "Duels system is currently disabled" end
	if getPlayerInviteCount(fromUserId) >= MAX_INVITES_PER_PLAYER then return false, "You have too many active invites" end
	if ActiveDuels[toUserId] then return false, "This player is already in a duel" end
	if ActiveDuels[fromUserId] then return false, "You are already in a duel" end

	for _, invite in pairs(ActiveInvites) do
		if invite.from == fromUserId and invite.to == toUserId then
			return false, "You already have a pending invite to this player"
		end
	end

	return true
end

local function isPlayerInServer(userId)
	for _, player in ipairs(Players:GetPlayers()) do
		if player.UserId == userId then return true end
	end
	return false
end

local function isPlayerInGame(userId)
	local success, friendsOnline = pcall(function()
		for _, player in ipairs(Players:GetPlayers()) do
			local s, friends = pcall(function() return player:GetFriendsOnlineAsync(200) end)

			if s and friends then
				while true do
					local page = friends:GetCurrentPage()
					for _, friend in ipairs(page) do
						if friend.VisitorId == userId and friend.PlaceId then
							if ServerData.AllPlaces then
								for _, placeId in ipairs(ServerData.AllPlaces) do
									if placeId == friend.PlaceId then return true end
								end
							end
						end
					end

					if friends.IsFinished then break end
					friends:AdvanceToNextPageAsync()
				end
			end
		end
		return false
	end)

	return success and friendsOnline or false
end

local function getDuelsPlaceId()
	if ServerData.AllPlaces and #ServerData.AllPlaces > 0 then
		for _, placeId in ipairs(ServerData.AllPlaces) do
			if placeId ~= game.PlaceId then return placeId end
		end
	end
	return 18901161001
end

Invite.OnServerInvoke = function(player, targetUserId)
	if not DuelsMachineService.IsEnabled() then return false, "Duels system is disabled" end

	cleanExpiredInvites()

	local canInvite, errorMsg = canPlayerInvite(player.UserId, targetUserId)
	if not canInvite then return false, errorMsg end

	local targetPlayer = Players:GetPlayerByUserId(targetUserId)

	if targetPlayer then
		local inviteId = generateInviteId()
		local currentTime = workspace:GetServerTimeNow()

		ActiveInvites[inviteId] = {
			from = player.UserId,
			to = targetUserId,
			expires = currentTime + INVITE_DURATION,
			placeId = game.PlaceId
		}

		CreateInvite:FireClient(targetPlayer, inviteId, { from = player.UserId, expires = currentTime + INVITE_DURATION })
		return true
	else
		local inGame = isPlayerInGame(targetUserId)

		if inGame then
			local inviteId = generateInviteId()
			local currentTime = workspace:GetServerTimeNow()

			ActiveInvites[inviteId] = {
				from = player.UserId,
				to = targetUserId,
				expires = currentTime + INVITE_DURATION,
				placeId = game.PlaceId,
				crossServer = true
			}

			GlobalEventBus:Publish("DuelsInvite", {
				inviteId = inviteId,
				from = player.UserId,
				to = targetUserId,
				expires = currentTime + INVITE_DURATION
			})
			return true
		else
			return false, "Player is not online in game"
		end
	end
end

AcceptInvite.OnServerInvoke = function(player, inviteId)
	if not DuelsMachineService.IsEnabled() then return false, "Duels system is disabled" end

	cleanExpiredInvites()

	local invite = ActiveInvites[inviteId]
	if not invite then return false, "Invite expired or not found" end

	local currentTime = workspace:GetServerTimeNow()
	if currentTime >= invite.expires then
		ActiveInvites[inviteId] = nil
		return false, "Invite expired"
	end

	if invite.to ~= player.UserId then return false, "This invite is not for you" end
	if ActiveDuels[player.UserId] then return false, "You are already in a duel" end

	if ActiveDuels[invite.from] then
		ActiveInvites[inviteId] = nil
		return false, "The other player is already in a duel"
	end

	local inviter = Players:GetPlayerByUserId(invite.from)
	if not inviter then
		ActiveInvites[inviteId] = nil
		return false, "Inviter left the game"
	end

	ActiveDuels[player.UserId] = { opponentId = invite.from, startTime = currentTime }
	ActiveDuels[invite.from] = { opponentId = player.UserId, startTime = currentTime }

	ActiveInvites[inviteId] = nil

	local success, result = pcall(function()
		local duelsPlaceId = getDuelsPlaceId()
		local code = TeleportService:ReserveServer(duelsPlaceId)

		local teleportData = { type = "Duel", player1 = player.UserId, player2 = invite.from }
		TeleportService:TeleportToPrivateServer(duelsPlaceId, code, {player, inviter}, nil, teleportData)
	end)

	if not success then
		ActiveDuels[player.UserId] = nil
		ActiveDuels[invite.from] = nil
		return false, "Failed to start duel"
	end

	return true
end

SearchUser.OnServerInvoke = function(player, targetUserId)
	if not DuelsMachineService.IsEnabled() then return false, "Duels system is disabled" end

	local isInThisServer = isPlayerInServer(targetUserId)
	local canInvite = false
	if isInThisServer then
		local canInv, _ = canPlayerInvite(player.UserId, targetUserId)
		canInvite = canInv
	end

	return true, isInThisServer, canInvite
end

ReconnectWarn.OnServerEvent:Connect(function(player)
	local duelData = ActiveDuels[player.UserId]
	if duelData then
		duelData.disconnected = true
		PendingReconnects[player.UserId] = {
			opponentId = duelData.opponentId,
			expires = workspace:GetServerTimeNow() + RECONNECT_TIMEOUT
		}
	end
end)

Reconnect.OnServerEvent:Connect(function(player, shouldReconnect)
	local reconnectData = PendingReconnects[player.UserId]
	if not reconnectData then return end

	cleanExpiredReconnects()

	if not shouldReconnect or workspace:GetServerTimeNow() >= reconnectData.expires then
		PendingReconnects[player.UserId] = nil
		ActiveDuels[player.UserId] = nil
		return
	end

	local success = pcall(function()
		local duelsPlaceId = getDuelsPlaceId()
		local code = TeleportService:ReserveServer(duelsPlaceId)
		local teleportData = { type = "DuelReconnect", userId = player.UserId, opponentId = reconnectData.opponentId }
		TeleportService:TeleportToPrivateServer(duelsPlaceId, code, {player}, nil, teleportData)
	end)

	if success then PendingReconnects[player.UserId] = nil end
end)

Players.PlayerRemoving:Connect(function(player)
	local duelData = ActiveDuels[player.UserId]
	if duelData and not duelData.disconnected then
		local opponent = Players:GetPlayerByUserId(duelData.opponentId)
		if opponent then Reconnect:FireClient(opponent, player.UserId) end
	end

	for inviteId, invite in pairs(ActiveInvites) do
		if invite.from == player.UserId or invite.to == player.UserId then
			ActiveInvites[inviteId] = nil
		end
	end
end)

GlobalEventBus:Subscribe("DuelsInvite", function(data)
	local targetPlayer = Players:GetPlayerByUserId(data.to)
	if targetPlayer then
		CreateInvite:FireClient(targetPlayer, data.inviteId, {
			from = data.from,
			expires = data.expires
		})
	end
end)

task.spawn(function()
	while true do
		task.wait(30)
		cleanExpiredInvites()
		cleanExpiredReconnects()
	end
end)

return DuelsMachineService