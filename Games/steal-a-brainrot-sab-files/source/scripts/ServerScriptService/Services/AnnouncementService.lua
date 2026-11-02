local TextService = game:GetService("TextService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)
local SERVER_ID = game.JobId ~= "" and game.JobId or HttpService:GenerateGUID(false)

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local RobuxShopData = require(ReplicatedStorage.Datas.RobuxShopData)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local IsAdmin = require(ReplicatedStorage.Shared.IsAdmin)

local GLOBAL_PRODUCT_ID = RobuxShopData.GetId("GlobalMessage")
local GAMEPASS_ID = RobuxShopData.GetId("Cooldown")
local SERVER_COOLDOWN_TIME = 5
local PENDING_EXPIRY = 300
local CLEANUP_INTERVAL = 60
local MAX_MESSAGE_LENGTH = 250

local ADMIN_IDS = {
	[0] = true,
	[9834833917] = true,
	[4515418871] = true,
	[1127963269] = true,
}

local serverCooldowns = {}
local pendingGlobalMessages = {}
local isStarted = false

local AnnouncementService = {}

local function getUserIdFromName(name)
	if type(name) ~= "string" or name == "" then
		return nil
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p.DisplayName == name or p.Name == name then
			return p.UserId
		end
	end
	local ok, userId = pcall(Players.GetUserIdFromNameAsync, Players, name)
	return ok and userId or nil
end

local function filterMessage(text, fromUserId)
	if ADMIN_IDS[fromUserId] then
		return text
	end
	local success, result = pcall(function()
		local filtered = TextService:FilterStringAsync(text, fromUserId)
		return filtered:GetNonChatStringForBroadcastAsync()
	end)
	return success and result or "[Content Deleted]"
end

local function displayNotification(data, includeName)
	local textToDisplay = data.Text
	local avatarUserId = data.AvatarUserId

	local formatted
	if includeName and data.FromDisplayName then
		formatted = string.format(
			'<font color="#FFD700"><b>%s</b></font>: %s',
			data.FromDisplayName,
			textToDisplay
		)
	else
		formatted = textToDisplay
	end

	NotificationEvent:FireAllClients(formatted, 5, "Sounds.Sfx.Blop", "Top", avatarUserId)
end

function AnnouncementService:Start()
	if isStarted then
		warn("AnnouncementService already started")
		return
	end
	isStarted = true

	task.spawn(function()
		while true do
			task.wait(CLEANUP_INTERVAL)
			local now = os.time()
			for userId, data in pairs(pendingGlobalMessages) do
				if now - data.Timestamp > PENDING_EXPIRY then
					pendingGlobalMessages[userId] = nil
				end
			end
		end
	end)

	task.spawn(function()
		MessagingService:SubscribeAsync("GlobalAnnouncement", function(data)
			if not data or data.SourceServer == SERVER_ID then
				return
			end

			local isPrivateServer = game.PrivateServerId ~= ""
			if isPrivateServer then
				local senderInThisServer = Players:GetPlayerByUserId(data.FromUserId) ~= nil
				if not ADMIN_IDS[data.FromUserId] and not senderInThisServer then
					return
				end
			end

			displayNotification(data, true)
		end)
	end)

	_G.PendingGlobalMessages = pendingGlobalMessages
	_G.BroadcastGlobalAnnouncement = AnnouncementService.BroadcastGlobal

	print("✓ AnnouncementService started")
end

function AnnouncementService.BroadcastGlobal(player, messageToFilter, gradient, jobid)
	local filteredText = filterMessage(messageToFilter, player.UserId)

	local payload = {
		Text = filteredText,
		FromDisplayName = player.DisplayName,
		FromUserId = player.UserId,
		AvatarUserId = player.UserId,
		GradientTag = gradient or "default",
		IsGlobal = true,
		SourceServer = SERVER_ID,
	}

	MessagingService:PublishAsync("GlobalAnnouncement", payload, jobid)

	if not jobid or jobid == game.JobId then
		displayNotification(payload, false)
	end
end

function AnnouncementService.AnnounceToServer(player, message, customName)
	if type(message) ~= "string" or #message == 0 then
		return false
	end
	if #message > MAX_MESSAGE_LENGTH then
		return false, "Message too long"
	end

	local now = os.time()
	local hasPass = false

	local ok, res = pcall(RobuxShopData.OwnsGamepass, player, "Cooldown")
	if ok then
		hasPass = res
	end

	if not hasPass then
		local lastUsed = serverCooldowns[player.UserId]
		if lastUsed and (now - lastUsed) < SERVER_COOLDOWN_TIME then
			return false, "Cooldown"
		end
	end

	serverCooldowns[player.UserId] = now

	local filteredText = filterMessage(message, player.UserId)
	local avatarUserId = getUserIdFromName(customName)

	displayNotification({
		Text = filteredText,
		FromUserId = player.UserId,
		AvatarUserId = avatarUserId,
	}, false)

	return true
end

function AnnouncementService.PromptGlobalPurchase(player, message, gradient)
	if type(message) ~= "string" or #message == 0 then
		return false
	end
	if #message > MAX_MESSAGE_LENGTH then
		return false, "Message too long"
	end

	if IsAdmin(player.UserId) then
		AnnouncementService.BroadcastGlobal(player, message, gradient)
		return "admin"
	end

	pendingGlobalMessages[player.UserId] = {
		text = message,
		gradient = gradient,
		Timestamp = os.time(),
	}

	MarketplaceService:PromptProductPurchase(player, GLOBAL_PRODUCT_ID)
	return true
end

function AnnouncementService.GetPendingMessage(userId)
	return pendingGlobalMessages[userId]
end

function AnnouncementService.ClearPendingMessage(userId)
	pendingGlobalMessages[userId] = nil
end

function AnnouncementService.IsAdmin(userId)
	return ADMIN_IDS[userId] == true
end

return AnnouncementService