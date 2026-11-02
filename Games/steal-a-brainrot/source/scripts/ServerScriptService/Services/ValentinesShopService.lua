local ValentinesShopService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")

local NotificationService = require(ServerScriptService.Services.NotificationService)
local PlotService = require(ServerScriptService.Services.PlotService)
local AnimalService = require(ServerScriptService.Services:WaitForChild("AnimalService"))

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local ValentinesShopData = require(ReplicatedStorage.Datas.ValentinesShop)
local Shop = require(ReplicatedStorage.Datas.Shop)

local SearchUserRemote = Net:RemoteFunction("ValentinesShopService/SearchUser")
local OpenGiftRemote = Net:RemoteFunction("ValentinesShopService/OpenGift")
local GiftRemote = Net:RemoteFunction("ValentinesShopService/Gift")
local GiftNotifyEvent = Net:RemoteEvent("ValentinesShopService/GiftNotify")

local VALENTINES_EVENT_ENABLED = false
local MAX_GIFT_MESSAGE_LENGTH = 60
local GIFT_COOLDOWN = 2

local PendingGifts = {}
local LastGiftTime = {}

local function getRawFromDiscounted(discountedId)
	for rawId, prod in ValentinesShopData.Products do
		if prod.discountedProductId == discountedId then
			return rawId, prod
		end
	end
	return nil, nil
end

local function getFailedGiftKey(rawProductId)
	local prod = ValentinesShopData.Products[rawProductId]
	if prod then
		return prod.failedGiftKey or tostring(prod.discountedProductId or rawProductId)
	end
	return tostring(rawProductId)
end

local function addGiftToInventory(channel, giftData)
	channel:InsertOnArray("ValentinesEvent.GiftInventory", giftData)
end

local function removeGiftFromInventory(channel, index)
	channel:RemoveFromArray("ValentinesEvent.GiftInventory", index)
end

local function deliverGift(senderPlayer, targetUserId, rawProductId, message, mutation)
	local productData = ValentinesShopData.Products[rawProductId]
	if not productData then return false end

	local discountedProductId = productData.discountedProductId or rawProductId

	local targetPlayer = Players:GetPlayerByUserId(targetUserId)
	if not targetPlayer then
		local senderChannel = Synchronizer:Get(senderPlayer)
		if senderChannel then
			local key = getFailedGiftKey(rawProductId)
			local failedGifts = senderChannel:Get({"ValentinesEvent", "FailedGifts", key}) or {}
			table.insert(failedGifts, {
				ProductId = rawProductId,
				TargetUserId = targetUserId,
				Time = workspace:GetServerTimeNow(),
			})
			senderChannel:Set({"ValentinesEvent", "FailedGifts", key}, failedGifts)
			NotificationService.Error(senderPlayer, "Target player is offline! Gift saved – you can resend for free.")
		end
		return false
	end

	local targetChannel = Synchronizer:Get(targetPlayer)
	if not targetChannel then return false end

	local giftData = {
		Id              = HttpService:GenerateGUID(false),
		ProductId       = discountedProductId,
		Sender          = senderPlayer.UserId,
		SenderUsername   = senderPlayer.Name,
		Message         = message,
		Mutation        = mutation,
		Timestamp       = workspace:GetServerTimeNow(),
		GiftType        = "purchased",
	}

	addGiftToInventory(targetChannel, giftData)
	GiftNotifyEvent:FireClient(targetPlayer, giftData)

	NotificationService.Success(senderPlayer,
		string.format("Gift sent to %s!", targetPlayer.Name))
	return true
end

function ValentinesShopService:GiveAdminGift(targetPlayer, senderPlayer, brainrotName, mutation, message)
	if not targetPlayer or not senderPlayer then
		return false, "Invalid player"
	end

	local targetChannel = Synchronizer:Get(targetPlayer)
	if not targetChannel then
		return false, "Could not get data for target"
	end

	if not targetChannel:Get("ValentinesEvent") then
		targetChannel:Set("ValentinesEvent", {
			ReceivedPoolGift = false,
			GiftHistory = {
				Received = {},
				Sent = {},
			},
			GiftInventory = {},
			FailedGifts = {},
		})
	end
	if not targetChannel:Get({"ValentinesEvent", "GiftInventory"}) then
		targetChannel:Set({"ValentinesEvent", "GiftInventory"}, {})
	end

	local cleanMessage = nil
	if message and typeof(message) == "string" then
		local trimmed = message:match("^%s*(.-)%s*$") or ""
		if #trimmed > 0 then
			cleanMessage = trimmed:sub(1, 60)
		end
	end

	local cleanMutation = nil
	if mutation and mutation ~= "" and mutation ~= "Default" and mutation ~= "Normal" then
		cleanMutation = mutation
	end

	local giftData = {
		Id             = HttpService:GenerateGUID(false),
		ProductId      = nil,
		Sender         = senderPlayer.UserId,
		SenderUsername  = senderPlayer.Name,
		Message        = cleanMessage,
		Mutation       = cleanMutation,
		Timestamp      = workspace:GetServerTimeNow(),
		GiftType       = "brainrot",
		RewardName     = brainrotName,
		BrainrotName   = brainrotName,
		AdminBrainrot  = brainrotName,
	}

	addGiftToInventory(targetChannel, giftData)
	GiftNotifyEvent:FireClient(targetPlayer, giftData)

	return true
end

SearchUserRemote.OnServerInvoke = function(player, productId, targetUserId)
	if not VALENTINES_EVENT_ENABLED then
		return false, "Valentines event is not active"
	end

	local ok, _ = pcall(function()
		return Players:GetNameFromUserIdAsync(targetUserId)
	end)
	if not ok then
		return false, "User not found"
	end

	local isInGame = Players:GetPlayerByUserId(targetUserId) ~= nil
	return true, nil, isInGame
end

OpenGiftRemote.OnServerInvoke = function(player, giftId)
	if not VALENTINES_EVENT_ENABLED then return false end

	local channel = Synchronizer:Get(player)
	if not channel then return false end

	local inventory = channel:Get({"ValentinesEvent", "GiftInventory"}) or {}

	local idx, gift
	for i, g in ipairs(inventory) do
		if g.Id == giftId then
			idx = i
			gift = g
			break
		end
	end
	if not gift then return false end

	if gift.AdminBrainrot then
		local ok, err = pcall(function()
			PlotService.AddAnimalOnPlotOrQueue(
				player,
				gift.AdminBrainrot,
				gift.Mutation,
				nil
			)
		end)

		if not ok then
			warn("[ValentinesShopService] Admin gift grant failed:", err)
			NotificationService.Error(
				player,
				"Base may be full – could not place " .. tostring(gift.AdminBrainrot)
			)
		end

		removeGiftFromInventory(channel, idx)
		return true, gift
	end

	local rawId, productData = getRawFromDiscounted(gift.ProductId)
	if not productData then
		rawId = gift.ProductId
		productData = rawId and ValentinesShopData.Products[rawId]
	end

	if productData and productData.give then
		local ok, result = pcall(productData.give, player, gift.Mutation)
		if ok then
			if result == "___GIVE_BACK" then
				local key = getFailedGiftKey(rawId)
				local failedGifts = channel:Get({"ValentinesEvent", "FailedGifts", key}) or {}
				table.insert(failedGifts, {
					ProductId = rawId,
					Time = workspace:GetServerTimeNow(),
					Sender = gift.Sender,
				})
				channel:Set({"ValentinesEvent", "FailedGifts", key}, failedGifts)
			end
		else
			warn("[ValentinesShopService] productData.give failed:", result)
		end
	end

	removeGiftFromInventory(channel, idx)
	return true, gift
end

GiftRemote.OnServerInvoke = function(player, rawProductId, targetUserId, message)
	if not VALENTINES_EVENT_ENABLED then
		NotificationService.Error(player, "Valentines event is not active!")
		return false
	end

	local now = tick()
	if now - (LastGiftTime[player.UserId] or 0) < GIFT_COOLDOWN then
		NotificationService.Error(player, "Please wait before sending another gift!")
		return false
	end

	local channel = Synchronizer:Get(player)
	if not channel then return false end

	local productData = ValentinesShopData.Products[rawProductId]
	if not productData then
		NotificationService.Error(player, "Invalid product!")
		return false
	end

	if message and #message > MAX_GIFT_MESSAGE_LENGTH then
		NotificationService.Error(player, "Message is too long!")
		return false
	end

	LastGiftTime[player.UserId] = now

	local discountedId = productData.discountedProductId or rawProductId

	local key = getFailedGiftKey(rawProductId)
	local failedGifts = channel:Get({"ValentinesEvent", "FailedGifts", key}) or {}

	if #failedGifts > 0 then
		table.remove(failedGifts, 1)
		channel:Set({"ValentinesEvent", "FailedGifts", key}, failedGifts)
		deliverGift(player, targetUserId, rawProductId, message, nil)
		return true
	end

	PendingGifts[player.UserId] = {
		player             = player,
		targetUserId       = targetUserId,
		rawProductId       = rawProductId,
		discountedProductId = discountedId,
		message            = message,
		mutation           = nil,
	}

	MarketplaceService:PromptProductPurchase(player, discountedId)
	return true
end

function ValentinesShopService:ProcessPurchase(player, receiptProductId)
	local pending = PendingGifts[player.UserId]
	if not pending then return false end
	if pending.discountedProductId ~= receiptProductId then return false end
	if pending.player ~= player then return false end

	PendingGifts[player.UserId] = nil

	return deliverGift(
		player,
		pending.targetUserId,
		pending.rawProductId,
		pending.message,
		pending.mutation
	)
end

function ValentinesShopService:GetGiftInventory(player)
	local channel = Synchronizer:Get(player)
	if not channel then return {} end
	return channel:Get({"ValentinesEvent", "GiftInventory"}) or {}
end

function ValentinesShopService:ClearGiftInventory(player)
	local channel = Synchronizer:Get(player)
	if not channel then return end
	channel:Set({"ValentinesEvent", "GiftInventory"}, {})
end

function ValentinesShopService:GetFailedGifts(player)
	local channel = Synchronizer:Get(player)
	if not channel then return {} end
	return channel:Get({"ValentinesEvent", "FailedGifts"}) or {}
end

function ValentinesShopService:Start()
	MarketplaceService.PromptProductPurchaseFinished:Connect(function(userId, productId, isPurchased)
		if not isPurchased then return end

		local player = Players:GetPlayerByUserId(userId)
		if not player then return end

		local pending = PendingGifts[player.UserId]
		if not pending then return end
		if pending.discountedProductId ~= productId then return end

		ValentinesShopService:ProcessPurchase(player, productId)
	end)
end

Players.PlayerAdded:Connect(function(player)
	local channel = Synchronizer:Wait(player)
	if not channel then return end

	if not channel:Get("ValentinesEvent") then
		channel:Set("ValentinesEvent", {
			ReceivedPoolGift = false,
			GiftHistory = {
				Received = {},
				Sent = {},
			},
			GiftInventory = {},
			FailedGifts = {},
		})
	end
end)

Players.PlayerRemoving:Connect(function(player)
	PendingGifts[player.UserId] = nil
	LastGiftTime[player.UserId] = nil
end)

return ValentinesShopService