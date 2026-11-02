local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local REMOTE_NAME = "BrainrotPurchaseRemote"
local WEBHOOK_URL = "https://discord.com/api/webhooks/REDACTED"
-- Enter the animal's name + pass value here
local PASSES = {
	["Strawberry Harder"] = 3611201993,
}

local NetFolder = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")

local Remote = NetFolder:FindFirstChild(REMOTE_NAME)
if not Remote then
	Remote = Instance.new("RemoteEvent")
	Remote.Name = REMOTE_NAME
	Remote.Parent = NetFolder
end

local cooldown = {}

local function checkOwnership(player, gamepassId)
	local ok, owns = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
	end)
	return ok and owns
end

local function sendWebhook(player, animalName)
	pcall(function()
		HttpService:PostAsync(
			WEBHOOK_URL,
			HttpService:JSONEncode({
				content = player.Name .. " He purchased " .. tostring(animalName)
			}),
			Enum.HttpContentType.ApplicationJson
		)
	end)
end

game.Players.PlayerAdded:Connect(function(player)
	task.wait(1)

	for animalName, gamepassId in pairs(PASSES) do
		local owns = checkOwnership(player, gamepassId)
		Remote:FireClient(player, "ui_state", animalName, owns)
	end
end)

Remote.OnServerEvent:Connect(function(player, animalName)
	if cooldown[player] then
		return
	end

	cooldown[player] = true
	task.delay(2, function()
		cooldown[player] = nil
	end)

	local gamepassId = PASSES[animalName]
	if not gamepassId then
		warn("There is no GamePass for the animal.:", animalName)
		return
	end

	local owns = checkOwnership(player, gamepassId)

	if not owns then
		Remote:FireClient(player, "fail", animalName)
		MarketplaceService:PromptGamePassPurchase(player, gamepassId)
		return
	end

	Remote:FireClient(player, "success", animalName)
	sendWebhook(player, animalName)
end)

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, passId, purchased)
	if not purchased then
		return
	end

	for animalName, gamepassId in pairs(PASSES) do
		if gamepassId == passId then
			Remote:FireClient(player, "success", animalName)
			sendWebhook(player, animalName)
			break
		end
	end
end)