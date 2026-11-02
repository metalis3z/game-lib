local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)

local TIMEOUT_DURATION = 5

local pendingRequests = {}


local function resolveUsernameToId(username)
	local success, result = pcall(function()
		return Players:GetUserIdFromNameAsync(username)
	end)
	if success and result then
		return result
	end
	return nil, string.format("Could not find a player with the username \"%s\".", username)
end


MessagingService:SubscribeAsync("PlayerLookupRequest", function(data)
	if type(data) ~= "table" or not data.UserId1 or not data.UserId2 then
		return
	end

	local player1 = Players:GetPlayerByUserId(data.UserId1)
	local player2 = Players:GetPlayerByUserId(data.UserId2)

	local foundPlayers = {}

	if player1 then
		table.insert(foundPlayers, {
			Name   = player1.Name,
			UserId = data.UserId1,
		})
	end

	if player2 then
		table.insert(foundPlayers, {
			Name   = player2.Name,
			UserId = data.UserId2,
		})
	end

	if #foundPlayers > 0 then
		MessagingService:PublishAsync("PlayerLookupResponse", {
			RequestId = data.RequestId,
			JobId     = game.JobId,
			Players   = foundPlayers,
		})
	end
end)

MessagingService:SubscribeAsync("ExecuteTeleport", function(data)
	if type(data) ~= "table" then return end
	if data.TargetJobId ~= game.JobId then return end

	local players = {}
	for _, userId in ipairs(data.UserIds or {}) do
		local player = Players:GetPlayerByUserId(userId)
		if player then
			table.insert(players, player)
		end
	end

	if #players == 0 then return end

	local success, err = pcall(function()
		TeleportService:TeleportToPrivateServer(
			data.PlaceId,
			data.URID,
			players
		)
	end)

	if success then
		print(string.format(
			"[TeleportLog] Teleported %d player(s) to URID: %s",
			#players,
			data.URID
			))
	else
		warn("[TeleportLog] Teleport failed: " .. tostring(err))
	end
end)

MessagingService:SubscribeAsync("PlayerLookupResponse", function(data)
	if type(data) ~= "table" or not data.RequestId then return end

	local request = pendingRequests[data.RequestId]
	if request then
		table.insert(request.responses, data)
	end
end)

MessagingService:SubscribeAsync("TeleportCommand", function(data)
	if type(data) ~= "table" then return end

	if data.Action == "TeleportToReserved" then
		local name1 = (data.Players and data.Players[1] and data.Players[1].Name) or "Unknown"
		local name2 = (data.Players and data.Players[2] and data.Players[2].Name) or "Unknown"

		print(string.format(
			"[TeleportLog] %s teleported %s and %s to URID: %s at %s",
			tostring(data.Executor),
			name1,
			name2,
			tostring(data.URID),
			os.date("%X", data.Timestamp)
			))

	elseif data.Action == "TeleportFailed" then
		local name1 = (data.Players and tostring(data.Players[1])) or "Unknown"
		local name2 = (data.Players and tostring(data.Players[2])) or "Unknown"

		warn(string.format(
			"[TeleportLog] Failed teleport by %s for players %s, %s: %s",
			tostring(data.Executor),
			name1,
			name2,
			tostring(data.Error)
			))
	end
end)


local function findPlayersAcrossServers(userId1, userId2)
	local requestId = HttpService:GenerateGUID(false)

	pendingRequests[requestId] = {
		responses = {},
	}

	MessagingService:PublishAsync("PlayerLookupRequest", {
		RequestId = requestId,
		UserId1   = userId1,
		UserId2   = userId2,
	})

	local startTime = tick()

	while tick() - startTime < TIMEOUT_DURATION do
		task.wait(0.1)

		local request = pendingRequests[requestId]
		if not request then break end

		if #request.responses > 0 then
			local foundJobIds = {}

			for _, response in ipairs(request.responses) do
				for _, playerData in ipairs(response.Players or {}) do
					foundJobIds[playerData.UserId] = response.JobId
				end
			end

			if foundJobIds[userId1] and foundJobIds[userId2] then
				local responses = request.responses
				pendingRequests[requestId] = nil
				return true, responses
			end
		end
	end

	local request = pendingRequests[requestId]
	pendingRequests[requestId] = nil

	if request and #request.responses > 0 then
		return false, request.responses
	end
	return false, nil
end


return function(context, username1, username2)
	local executor = context.Executor
	local placeId  = game.PlaceId

	local userId1, err1 = resolveUsernameToId(username1)
	if not userId1 then
		return err1
	end

	local userId2
	if username2 and username2 ~= "" then
		local err2
		userId2, err2 = resolveUsernameToId(username2)
		if not userId2 then
			return err2
		end
	else
		userId2 = executor.UserId
	end

	if userId1 == userId2 then
		return "Both players resolved to the same user. Please provide two different players."
	end

	local foundBoth, responses = findPlayersAcrossServers(userId1, userId2)

	if not responses or #responses == 0 then
		return string.format(
			"Could not find players \"%s\" and \"%s\" in any server.",
			username1,
			username2 or executor.Name
		)
	end

	local foundPlayers  = {}
	local playersByJobId = {}

	for _, response in ipairs(responses) do
		for _, playerData in ipairs(response.Players or {}) do
			if not foundPlayers[playerData.UserId] then
				foundPlayers[playerData.UserId] = playerData

				if not playersByJobId[response.JobId] then
					playersByJobId[response.JobId] = {}
				end
				table.insert(playersByJobId[response.JobId], playerData.UserId)
			end
		end
	end

	if not foundPlayers[userId1] then
		return string.format("Player \"%s\" is not in any active server.", username1)
	end

	if not foundPlayers[userId2] then
		local displayName2 = username2 and username2 ~= "" and username2 or executor.Name
		return string.format("Player \"%s\" is not in any active server.", displayName2)
	end

	local URID
	local reserveSuccess, reserveResult = pcall(function()
		return TeleportService:ReserveServer(placeId)
	end)

	if not reserveSuccess then
		MessagingService:PublishAsync("TeleportCommand", {
			Action   = "TeleportFailed",
			Executor = executor.Name,
			Players  = {
				foundPlayers[userId1].Name,
				foundPlayers[userId2].Name,
			},
			Error    = "Failed to reserve server: " .. tostring(reserveResult),
		})
		return "Failed to reserve server: " .. tostring(reserveResult)
	end

	URID = reserveResult

	for jobId, userIds in pairs(playersByJobId) do
		MessagingService:PublishAsync("ExecuteTeleport", {
			TargetJobId = jobId,
			PlaceId     = placeId,
			URID        = URID,
			UserIds     = userIds,
		})
	end

	MessagingService:PublishAsync("TeleportCommand", {
		Action    = "TeleportToReserved",
		Executor  = executor.Name,
		Players   = {
			{ Name = foundPlayers[userId1].Name, UserId = userId1 },
			{ Name = foundPlayers[userId2].Name, UserId = userId2 },
		},
		URID      = URID,
		Timestamp = os.time(),
	})

	return string.format(
		"Teleporting %s and %s to a new reserved server (Code: %s)",
		foundPlayers[userId1].Name,
		foundPlayers[userId2].Name,
		URID
	)
end