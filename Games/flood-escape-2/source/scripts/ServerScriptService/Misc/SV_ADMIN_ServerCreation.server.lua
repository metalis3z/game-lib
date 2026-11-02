local rem = game.ReplicatedStorage.Remote
local placeId = game.PlaceId
local teleportService = game:GetService("TeleportService")
local memoryStoreService = game:GetService("MemoryStoreService")
local httpService = game:GetService("HttpService")
local messagingService = game:GetService("MessagingService")

rem.CreateNewServer.OnServerEvent:Connect(function(player)
	local success, reservedServerAccessCode, privateServerId = pcall(function()
		return teleportService:ReserveServer(placeId)
	end)

	if not success then
		error("Failed to reserve server: " .. tostring(reservedServerAccessCode))
		return
	end

	local memoryStoreQueue = memoryStoreService:GetQueue(privateServerId, 120)
	memoryStoreQueue:AddAsync(reservedServerAccessCode, 120)

	teleportService:TeleportToPrivateServer(placeId, reservedServerAccessCode, {player})
end)

rem.JoinServer.OnServerEvent:Connect(function(player, codeInputtedByPlayer)
	if codeInputtedByPlayer == "" or codeInputtedByPlayer == nil then
		error("JoinServer: codeInputtedByPlayer is empty or nil")
		return
	end

	local guid = httpService:GenerateGUID(false)
	local tempConnection

	tempConnection = messagingService:SubscribeAsync(guid, function(message)
		message = message.Data
		local success, err = pcall(function()
			teleportService:TeleportToPrivateServer(placeId, message, {player})
		end)
		if not success then
			error("Failed to teleport player: " .. tostring(err))
		end
		tempConnection:Disconnect()
	end)

	local success, err = pcall(function()
		messagingService:PublishAsync(codeInputtedByPlayer, {RequestedServerCode = codeInputtedByPlayer, GUID = guid})
	end)
	if not success then
		error("Failed to publish message: " .. tostring(err))
	end
end)