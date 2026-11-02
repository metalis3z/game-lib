local CoinsShopService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local MoneyService = require(ServerScriptService.Services.MoneyService)
local Net = require(ReplicatedStorage.Packages.Net)
local ShopItems = require(ReplicatedStorage.Datas.ShopItems)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local RequestBuy = Net:RemoteFunction("CoinsShopService/RequestBuy")
local ToggleAutoBuy = Net:RemoteFunction("CoinsShopService/ToggleAutoBuy")

local TrapCounts = {}
local CakeTrapCounts = {}
local LastPurchaseTime = {}

local PURCHASE_COOLDOWN = 1.5

local function sanitizeAttributeName(name)
	return name:gsub("[^%w_]", "_")
end

Players.PlayerAdded:Connect(function(player)
	TrapCounts[player] = 0
	CakeTrapCounts[player] = 0
	LastPurchaseTime[player] = 0
	player:SetAttribute("TrapCount", 0)

	task.spawn(function()
		local playerChannel = Synchronizer:Wait(player)
		if not playerChannel then
			return
		end

		local items = playerChannel:Get("Items") or {}
		local autoBuyData = playerChannel:Get("AutoBuy") or {}

		local keepItems = {
			["Bat"] = true,
			["Blackhole Slap"] = true,
			["Flying Carpet"] = true,
			["Laser Gun"] = true,
			["Ban Hammer"] = true
		}

		local newItems = {}

		for itemName, _ in pairs(items) do
			local hasAutoBuy = autoBuyData[itemName] == true
			if keepItems[itemName] or hasAutoBuy then
				newItems[itemName] = true
			end
		end

		playerChannel:Set("Items", newItems)

		for itemName, enabled in pairs(autoBuyData) do
			player:SetAttribute("AutoBuy_" .. sanitizeAttributeName(itemName), enabled == true)
		end
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	TrapCounts[player] = nil
	CakeTrapCounts[player] = nil
	LastPurchaseTime[player] = nil
end)

local function isOnCooldown(player)
	local now = os.time()
	if LastPurchaseTime[player] and now - LastPurchaseTime[player] < PURCHASE_COOLDOWN then
		return true, "Hold on! You need to wait a bit before doing that again."
	end
	LastPurchaseTime[player] = now
	return false
end

RequestBuy.OnServerInvoke = function(player, item)
	assert(item)

	local onCooldown, cooldownMessage = isOnCooldown(player)
	if onCooldown then
		return false, cooldownMessage
	end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return false, "Data not ready yet, please wait a moment."
	end

	local productInfo = ShopItems[item]
	assert(productInfo)

	local requiredRebirths = productInfo.RebirthRequired or 0
	local playerRebirths = playerChannel:Get("Rebirth") or 0
	if playerRebirths < requiredRebirths then
		return false, string.format("Purchase failed! You don't have the required Rebirth to buy %s.", item)
	end

	if not MoneyService:CanAfford(player, productInfo.Price) then
		return false, string.format("Purchase failed! You don't have enough Coins to buy %s.", item)
	end

	if item == "Trap" then
		local currentCount = TrapCounts[player] or 0
		if currentCount >= 5 then
			return false, "Purchase failed! You can only own up to 5 traps."
		end
		MoneyService:Add(player, -productInfo.Price)
		local newCount = currentCount + 1
		TrapCounts[player] = newCount
		player:SetAttribute("TrapCount", newCount)
		playerChannel:InsertOnDictionary("SessionTraps", tostring(newCount), true)
		playerChannel:InsertOnDictionary("Items", item, true)

	elseif item == "Cake Trap" then
		local currentCount = CakeTrapCounts[player] or 0
		if currentCount >= 5 then
			return false, "Purchase failed! You can only own up to 5 Cake Traps."
		end
		MoneyService:Add(player, -productInfo.Price)
		CakeTrapCounts[player] = currentCount + 1

	else
		if playerChannel:Get(string.format("Items.%s", item)) then
			return false, string.format("Purchase failed! You already own %s.", item)
		end
		MoneyService:Add(player, -productInfo.Price)
		playerChannel:InsertOnDictionary("Items", item, true)
	end

	return true, string.format("Purchase successful! You bought %s.", item)
end

ToggleAutoBuy.OnServerInvoke = function(player, item)
	assert(item)

	local onCooldown, cooldownMessage = isOnCooldown(player)
	if onCooldown then
		return false, cooldownMessage
	end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return false, "Data not ready yet, please wait a moment."
	end

	local productInfo = ShopItems[item]
	assert(productInfo)

	local requiredRebirths = productInfo.RebirthRequired or 0
	local playerRebirths = playerChannel:Get("Rebirth") or 0
	if playerRebirths < requiredRebirths then
		return false, string.format("Purchase failed! You don't have the required Rebirth to buy %s.", item)
	end

	local path = string.format("AutoBuy.%s", item)
	local currentValue = playerChannel:Get(path)
	local newValue = not currentValue

	playerChannel:Set(path, newValue)
	player:SetAttribute("AutoBuy_" .. sanitizeAttributeName(item), newValue)

	return true, string.format("AutoBuy for %s is now %s.", item, newValue and "enabled" or "disabled")
end

return CoinsShopService