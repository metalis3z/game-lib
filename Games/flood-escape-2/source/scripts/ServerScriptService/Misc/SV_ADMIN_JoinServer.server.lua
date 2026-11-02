local rem = game.ReplicatedStorage.Remote
local placeId = game.PlaceId
local teleportService = game:GetService("TeleportService")
local memoryStoreService = game:GetService("MemoryStoreService")
local messagingService = game:GetService("MessagingService")
local privateServerId = game.PrivateServerId

if privateServerId == "" or privateServerId == nil then
	return
end

local memoryStoreQueueForThisServer = memoryStoreService:GetQueue(privateServerId, 120)
local success, result = pcall(function()
	return memoryStoreQueueForThisServer:ReadAsync(1)
end)

if not success or not result or #result == 0 then
	warn("Failed to read from queue: " .. tostring(result))
	return
end

local thisPrivateServerAccessCode = result[1]
local thisServerAccessCode = thisPrivateServerAccessCode:sub(1, 6)

messagingService:SubscribeAsync(thisServerAccessCode, function(message)
	message = message.Data
	if message.RequestedServerCode == thisServerAccessCode then
		messagingService:PublishAsync(message.GUID, thisPrivateServerAccessCode)
	end
end)
