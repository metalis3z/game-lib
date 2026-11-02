
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)

local JumpscareEvent = Net:RemoteEvent("JumpscareService/TriggerJumpscare")

local FIND_PLAYER_TOPIC = "Jumpscare_FindPlayer"
local PLAYER_FOUND_TOPIC = "Jumpscare_PlayerFound"
local TRIGGER_TOPIC = "Jumpscare_Trigger"

local initialized = false

MessagingService:SubscribeAsync(FIND_PLAYER_TOPIC, function(payload)
	if payload.ResponseJobId == game.JobId then return end

	local player = Players:FindFirstChild(payload.PlayerName)
	if player then
		MessagingService:PublishAsync(
			PLAYER_FOUND_TOPIC,
			{
				PlayerName = payload.PlayerName,
				FoundInJobId = game.JobId,
				RequestId = payload.RequestId
			},
			payload.ResponseJobId
		)
	end
end)

MessagingService:SubscribeAsync(TRIGGER_TOPIC, function(payload)
	local player = Players:FindFirstChild(payload.PlayerName)
	if player then
		JumpscareEvent:FireClient(player, payload.AnimalName)
	end
end)

local function findLocalPlayer(playerName)
	local player = Players:FindFirstChild(playerName)
	if player then return player end

	playerName = playerName:lower()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower():find(playerName, 1, true) or 
			(p.DisplayName and p.DisplayName:lower():find(playerName, 1, true)) then
			return p
		end
	end

	return nil
end

local function findPlayerInUniverse(playerName, timeoutSeconds)
	timeoutSeconds = timeoutSeconds or 3

	local requestId = HttpService:GenerateGUID(false)
	local foundJobId = nil
	local responseReceived = false

	local responseConnection = MessagingService:SubscribeAsync(PLAYER_FOUND_TOPIC, function(payload)
		if payload.RequestId == requestId then
			foundJobId = payload.FoundInJobId
			responseReceived = true
			MessagingService:AddKnownJobId(payload.FoundInJobId, 60)
		end
	end)

	MessagingService:PublishAsync(FIND_PLAYER_TOPIC, {
		PlayerName = playerName,
		ResponseJobId = game.JobId,
		RequestId = requestId
	})

	local startTime = os.clock()
	while not responseReceived and (os.clock() - startTime) < timeoutSeconds do
		task.wait(0.1)
	end

	responseConnection:Disconnect()

	return foundJobId
end

return function(context, playerName, animalName)

	local localPlayer = findLocalPlayer(playerName)

	if localPlayer then
		JumpscareEvent:FireClient(localPlayer, animalName)
		return string.format("✅ Triggered '%s' jumpscare for %s (this server)", animalName, localPlayer.Name)
	end

	context:Reply(string.format("🔍 Player '%s' not in this server, searching universe...", playerName))

	local foundJobId = findPlayerInUniverse(playerName, 3)

	if foundJobId then
		MessagingService:PublishAsync(
			TRIGGER_TOPIC,
			{
				PlayerName = playerName,
				AnimalName = animalName
			},
			foundJobId
		)

		return string.format("✅ Triggered '%s' jumpscare for %s (found in another server)", animalName, playerName)
	else
		return string.format("❌ Player '%s' not found in any server (searched for 3s)", playerName)
	end
end