local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local MutationService = require(ServerScriptService.Source.Services.MutationService)

local InventoryService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local InventoryRemotes = Remotes:WaitForChild("InventoryService")
local RequestInventoryFunc = InventoryRemotes:WaitForChild("RequestInventory")
local ToggleEquipFunc = InventoryRemotes:WaitForChild("ToggleEquip")
local DeleteItemFunc = InventoryRemotes:WaitForChild("DeleteItem")
local InventoryUpdateEvent = InventoryRemotes:WaitForChild("InventoryUpdate")
local InventorySummaryUpdateEvent = InventoryRemotes:FindFirstChild("InventorySummaryUpdate")
if not InventorySummaryUpdateEvent then
	InventorySummaryUpdateEvent = Instance.new("RemoteEvent")
	InventorySummaryUpdateEvent.Name = "InventorySummaryUpdate"
	InventorySummaryUpdateEvent.Parent = InventoryRemotes
end
local EquippedItemUpdateEvent = InventoryRemotes:FindFirstChild("EquippedItemUpdate")
if not EquippedItemUpdateEvent then
	EquippedItemUpdateEvent = Instance.new("RemoteEvent")
	EquippedItemUpdateEvent.Name = "EquippedItemUpdate"
	EquippedItemUpdateEvent.Parent = InventoryRemotes
end
local RequestEquippedItemFunc = InventoryRemotes:FindFirstChild("RequestEquippedItem")
if not RequestEquippedItemFunc then
	RequestEquippedItemFunc = Instance.new("RemoteFunction")
	RequestEquippedItemFunc.Name = "RequestEquippedItem"
	RequestEquippedItemFunc.Parent = InventoryRemotes
end

local MAX_HOTBAR = 9
local MAX_PAGE_SIZE = 400
local CPS_BONUS_PERCENT = 0.5

local function getCashPerSec(baseCashPerSec, level)
	if level <= 1 then return baseCashPerSec end
	local levelIndex = level - 1
	return baseCashPerSec + (baseCashPerSec * CPS_BONUS_PERCENT * levelIndex)
end

local function compareUnifiedItems(a, b)
	local aName = a.DisplayName or a.ItemId or ""
	local bName = b.DisplayName or b.ItemId or ""
	if a.ItemType == "Brainrot" and b.ItemType == "Brainrot" then
		local aCps = a.CashPerSec or 0
		local bCps = b.CashPerSec or 0
		if aCps ~= bCps then return aCps > bCps end
		return aName < bName
	end
	local aRarity = a.RarityOrder or 0
	local bRarity = b.RarityOrder or 0
	if aRarity ~= bRarity then
		return aRarity > bRarity
	end
	return aName < bName
end

local function insertTopItem(topItems, item, maxItems)
	local insertIndex = #topItems + 1
	for index, existingItem in ipairs(topItems) do
		if compareUnifiedItems(item, existingItem) then
			insertIndex = index
			break
		end
	end

	table.insert(topItems, insertIndex, item)
	if #topItems > maxItems then
		table.remove(topItems)
	end
end

local function updateBestNonPercentCps(bestNonPercentCps, entry)
	local brainrotId = entry and entry.BrainrotId
	local cfg = brainrotId and GameConfig.Items[brainrotId]
	if cfg and not cfg.IsPercentBrainrot then
		local level = entry.Level or 1
		local mutation = entry.Mutation
		local cashPerSec = getCashPerSec(cfg.CashPerSec or 0, level)
		if mutation and MutationService.IsValidMutation(mutation) then
			cashPerSec = getCashPerSec(MutationService.GetMutatedCashPerSec(brainrotId, mutation), level)
		end
		if cashPerSec > bestNonPercentCps then
			bestNonPercentCps = cashPerSec
		end
	end
	return bestNonPercentCps
end

local function getBestNonPercentOwnedCps(brainrotInventory, placedBrainrot)
	local bestNonPercentCps = 0
	for _, entry in pairs(brainrotInventory or {}) do
		bestNonPercentCps = updateBestNonPercentCps(bestNonPercentCps, entry)
	end
	for _, entry in pairs(placedBrainrot or {}) do
		bestNonPercentCps = updateBestNonPercentCps(bestNonPercentCps, entry)
	end
	return bestNonPercentCps
end

local function getSellAllTotalPrice(playerData, bestNonPercentCps)
	local totalPrice = 0

	local placedUniqueIds = {}
	for _, entry in pairs(playerData.PlacedBrainrot or {}) do
		if entry.UniqueId then
			placedUniqueIds[entry.UniqueId] = true
		end
	end

	for uniqueId, entry in pairs(playerData.BrainrotInventory or {}) do
		if not placedUniqueIds[uniqueId] then
			local cfg = entry.BrainrotId and GameConfig.Items[entry.BrainrotId]
			if cfg then
				local baseCps = cfg.CashPerSec or 0
				if cfg.IsPercentBrainrot then
					baseCps = (cfg.PercentBoost or 0) * bestNonPercentCps
				end
				if entry.Mutation and MutationService.IsValidMutation(entry.Mutation) then
					baseCps = baseCps * MutationService.GetCashBoost(entry.Mutation)
				end
				local actualCps = getCashPerSec(baseCps, entry.Level or 1)
				totalPrice += math.floor(actualCps * 10)
			end
		end
	end

	return totalPrice
end

local function buildUnifiedItemList(inventory, brainrotInventory, equippedItem)
	local list = {}

	for itemId, amount in pairs(inventory) do
		if amount > 0 then
			local lbCfg = GameConfig.LuckyBlocks[itemId]
			if lbCfg then
				table.insert(list, {
					ItemId = itemId,
					Amount = amount,
					DisplayName = lbCfg.DisplayName,
					Rarity = lbCfg.Rarity,
					ImageId = lbCfg.ImageId or "",
					RarityOrder = (GameConfig.Rarity[lbCfg.Rarity] or 0) + 50,
					ItemType = "LuckyBlock",
					CashPerSec = 0,
					ModelName = lbCfg.ModelName or "",
					IsEquipped = itemId == equippedItem,
				})
			end
		end
	end

	for uniqueId, entry in pairs(brainrotInventory) do
		local brainrotId = entry.BrainrotId
		local cfg = GameConfig.Items[brainrotId]
		if cfg then
			local baseCps = cfg.CashPerSec or 0
			local level = entry.Level or 1
			local mutation = entry.Mutation

			local displayName = cfg.DisplayName or brainrotId
			local imageId = GameConfig.GetItemImage(brainrotId, mutation)
			local modelName = cfg.ModelName or brainrotId
			local cashPerSec = getCashPerSec(baseCps, level)
			local imageColor = nil

			if mutation and MutationService.IsValidMutation(mutation) then
				local mutDisplayName = MutationService.GetDisplayName(mutation)
				displayName = mutDisplayName .. " " .. displayName
				modelName = MutationService.GetModelName(mutation, brainrotId) or modelName
				cashPerSec = getCashPerSec(MutationService.GetMutatedCashPerSec(brainrotId, mutation), level)
				imageColor = MutationService.GetImageColor(mutation)
			end

			table.insert(list, {
				ItemId = uniqueId,
				BrainrotId = brainrotId,
				Amount = 1,
				DisplayName = displayName,
				Rarity = "Brainrot",
				ImageId = imageId,
				ImageColor = imageColor,
				RarityOrder = (cfg.RarityOrder or 0) + 100,
				ItemType = "Brainrot",
				CashPerSec = cashPerSec,
				Level = level,
				ModelName = modelName,
				IsEquipped = uniqueId == equippedItem,
				Mutation = mutation,
				MutationIconImageId = mutation and GameConfig.Mutations[mutation] and GameConfig.Mutations[mutation].ImageId or nil,
			})
		end
	end

	local bestNonPercentCps = 0
	for _, item in ipairs(list) do
		if item.ItemType == "Brainrot" and item.BrainrotId then
			local cfg = GameConfig.Items[item.BrainrotId]
			if cfg and not cfg.IsPercentBrainrot and item.CashPerSec > bestNonPercentCps then
				bestNonPercentCps = item.CashPerSec
			end
		end
	end

	for _, item in ipairs(list) do
		if item.ItemType == "Brainrot" and item.BrainrotId then
			local cfg = GameConfig.Items[item.BrainrotId]
			if cfg and cfg.IsPercentBrainrot then
				item.CashPerSec = (cfg.PercentBoost or 0) * bestNonPercentCps
			end
		end
	end

	table.sort(list, compareUnifiedItems)

	return list
end

local function buildSummaryPayload(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return nil end

	local inventory = playerData.Inventory or {}
	local brainrotInventory = playerData.BrainrotInventory or {}
	local placedBrainrot = playerData.PlacedBrainrot or {}
	local equippedItem = playerData.EquippedItem or ""
	local topItems = {}
	local totalItemCount = 0
	local bestNonPercentCps = getBestNonPercentOwnedCps(brainrotInventory, placedBrainrot)

	for itemId, amount in pairs(inventory) do
		if amount > 0 then
			local lbCfg = GameConfig.LuckyBlocks[itemId]
			if lbCfg then
				totalItemCount += 1
				insertTopItem(topItems, {
					ItemId = itemId,
					Amount = amount,
					DisplayName = lbCfg.DisplayName,
					ImageId = lbCfg.ImageId or "",
					RarityOrder = (GameConfig.Rarity[lbCfg.Rarity] or 0) + 50,
					IsEquipped = itemId == equippedItem,
					ItemType = "LuckyBlock",
					CashPerSec = 0,
				}, MAX_HOTBAR)
			end
		end
	end

	for uniqueId, entry in pairs(brainrotInventory) do
		local brainrotId = entry.BrainrotId
		local cfg = GameConfig.Items[brainrotId]
		if cfg then
			totalItemCount += 1
			local level = entry.Level or 1
			local mutation = entry.Mutation
			local displayName = cfg.DisplayName or brainrotId
			local modelName = cfg.ModelName or brainrotId
			local cashPerSec = getCashPerSec(cfg.CashPerSec or 0, level)
			local imageColor = nil

			if mutation and MutationService.IsValidMutation(mutation) then
				displayName = MutationService.GetDisplayName(mutation) .. " " .. displayName
				modelName = MutationService.GetModelName(mutation, brainrotId) or modelName
				cashPerSec = getCashPerSec(MutationService.GetMutatedCashPerSec(brainrotId, mutation), level)
				imageColor = MutationService.GetImageColor(mutation)
			end

			if cfg.IsPercentBrainrot then
				cashPerSec = (cfg.PercentBoost or 0) * bestNonPercentCps
			end

			insertTopItem(topItems, {
				ItemId = uniqueId,
				BrainrotId = brainrotId,
				Amount = 1,
				DisplayName = displayName,
				ImageId = GameConfig.GetItemImage(brainrotId, mutation),
				ImageColor = imageColor,
				RarityOrder = (cfg.RarityOrder or 0) + 100,
				IsEquipped = uniqueId == equippedItem,
				ItemType = "Brainrot",
				CashPerSec = cashPerSec,
				Mutation = mutation,
				ModelName = modelName,
				MutationIconImageId = mutation and GameConfig.Mutations[mutation] and GameConfig.Mutations[mutation].ImageId or nil,
			}, MAX_HOTBAR)
		end
	end

	local hotbar = {}
	for i, item in ipairs(topItems) do
		hotbar[i] = {
			ItemId = item.ItemId,
			BrainrotId = item.BrainrotId or nil,
			Amount = item.Amount,
			DisplayName = item.DisplayName,
			ImageId = item.ImageId,
			ImageColor = item.ImageColor,
			IsEquipped = item.IsEquipped,
			ItemType = item.ItemType,
			CashPerSec = item.CashPerSec,
			Mutation = item.Mutation,
			MutationIconImageId = item.MutationIconImageId,
		}
	end

	return {
		Hotbar = hotbar,
		EquippedItem = equippedItem,
		HasOverflowItems = totalItemCount > MAX_HOTBAR,
		TotalItemCount = totalItemCount,
		BestNonPercentCps = bestNonPercentCps,
		SellAllTotalPrice = getSellAllTotalPrice(playerData, bestNonPercentCps),
	}
end

local function buildPayload(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return nil end

	local inventory = playerData.Inventory or {}
	local brainrotInventory = playerData.BrainrotInventory or {}
	local placedBrainrot = playerData.PlacedBrainrot or {}
	local equippedItem = playerData.EquippedItem or ""
	local bestNonPercentCps = getBestNonPercentOwnedCps(brainrotInventory, placedBrainrot)

	local allItems = buildUnifiedItemList(inventory, brainrotInventory, equippedItem)

	local hotbar = {}
	for i = 1, math.min(MAX_HOTBAR, #allItems) do
		local item = allItems[i]
		hotbar[i] = {
			ItemId = item.ItemId,
			BrainrotId = item.BrainrotId or nil,
			Amount = item.Amount,
			DisplayName = item.DisplayName,
			ImageId = item.ImageId,
			ImageColor = item.ImageColor,
			IsEquipped = item.IsEquipped,
			ItemType = item.ItemType,
			CashPerSec = item.CashPerSec,
			Mutation = item.Mutation,
			MutationIconImageId = item.MutationIconImageId,
		}
	end

	local items = {}
	for idx, item in ipairs(allItems) do
		table.insert(items, {
			ItemId = item.ItemId,
			BrainrotId = item.BrainrotId or nil,
			Amount = item.Amount,
			DisplayName = item.DisplayName,
			Rarity = item.Rarity,
			ImageId = item.ImageId,
			ImageColor = item.ImageColor,
			RarityOrder = item.RarityOrder,
			IsEquipped = item.IsEquipped,
			InHotbar = idx <= MAX_HOTBAR,
			ItemType = item.ItemType,
			CashPerSec = item.CashPerSec,
			ModelName = item.ModelName,
			Mutation = item.Mutation,
			MutationIconImageId = item.MutationIconImageId,
		})
	end

	return {
		Hotbar = hotbar,
		Items = items,
		EquippedItem = equippedItem,
		HasOverflowItems = #allItems > MAX_HOTBAR,
		TotalItemCount = #allItems,
		BestNonPercentCps = bestNonPercentCps,
		SellAllTotalPrice = getSellAllTotalPrice(playerData, bestNonPercentCps),
	}
end

local pendingPushPlayers = {}
local pushScheduled = false
local payloadCache = {}
local summaryCache = {}
local dirtyPlayers = {}

local function invalidatePayload(player)
	if player then
		dirtyPlayers[player] = true
		payloadCache[player] = nil
		summaryCache[player] = nil
	end
end

local function getPayload(player)
	if not player or not player.Parent then return nil end
	if dirtyPlayers[player] or payloadCache[player] == nil then
		payloadCache[player] = buildPayload(player)
	end
	return payloadCache[player]
end

local function getSummaryPayload(player)
	if not player or not player.Parent then return nil end
	if dirtyPlayers[player] or summaryCache[player] == nil then
		summaryCache[player] = buildSummaryPayload(player)
		dirtyPlayers[player] = nil
	end
	return summaryCache[player]
end

local function pushUpdate(player)
	local payload = getSummaryPayload(player)
	if payload then
		InventorySummaryUpdateEvent:FireClient(player, payload)
	end
end

local function schedulePush(player)
	pendingPushPlayers[player] = true
	if not pushScheduled then
		pushScheduled = true
		task.defer(function()
			pushScheduled = false
			local players = pendingPushPlayers
			pendingPushPlayers = {}
			for plr, _ in pairs(players) do
				if plr and plr.Parent then
					pushUpdate(plr)
				end
			end
		end)
	end
end

local function onRequestInventory(player, startIndex, pageSize)
	if type(startIndex) == "number" and type(pageSize) == "number" then
		local payload = getPayload(player)
		if not payload then return nil end

		local normalizedStartIndex = math.max(1, math.floor(startIndex))
		local normalizedPageSize = math.clamp(math.floor(pageSize), 1, MAX_PAGE_SIZE)
		local pageItems = {}
		local finalIndex = math.min((payload.TotalItemCount or 0), normalizedStartIndex + normalizedPageSize - 1)
		for index = normalizedStartIndex, finalIndex do
			local item = payload.Items[index]
			if item then
				table.insert(pageItems, item)
			end
		end

		local response = {
			Items = pageItems,
			TotalItemCount = payload.TotalItemCount,
			BestNonPercentCps = payload.BestNonPercentCps,
			SellAllTotalPrice = payload.SellAllTotalPrice,
			PageStartIndex = normalizedStartIndex,
			PageItemCount = math.max(0, finalIndex - normalizedStartIndex + 1),
		}
		if normalizedStartIndex <= 1 then
			response.Hotbar = payload.Hotbar
			response.EquippedItem = payload.EquippedItem
			response.HasOverflowItems = payload.HasOverflowItems
		end
		return response
	end

	return getPayload(player)
end

local function buildEquippedItemSummary(playerData, itemId)
	if not itemId or itemId == "" then
		return {
			ItemId = "",
			ItemType = "",
			Amount = 0,
		}
	end

	local inventory = playerData.Inventory or {}
	if inventory[itemId] and inventory[itemId] > 0 and GameConfig.LuckyBlocks[itemId] then
		return {
			ItemId = itemId,
			ItemType = "LuckyBlock",
			Amount = inventory[itemId],
		}
	end

	local brainrotEntry = (playerData.BrainrotInventory or {})[itemId]
	if brainrotEntry then
		local modelName = nil
		local brainrotId = brainrotEntry.BrainrotId
		local cfg = GameConfig.Items[brainrotId]
		if cfg then
			modelName = cfg.ModelName
		end
		if brainrotEntry.Mutation and MutationService.IsValidMutation(brainrotEntry.Mutation) then
			modelName = MutationService.GetModelName(brainrotEntry.Mutation, brainrotId) or modelName
		end
		local baseCps = (cfg and cfg.CashPerSec) or 0
		if cfg and cfg.IsPercentBrainrot then
			local bestNonPercent = getBestNonPercentOwnedCps(playerData.BrainrotInventory or {}, playerData.PlacedBrainrot or {})
			baseCps = (cfg.PercentBoost or 0) * bestNonPercent
		end
		if brainrotEntry.Mutation and MutationService.IsValidMutation(brainrotEntry.Mutation) then
			baseCps = baseCps * MutationService.GetCashBoost(brainrotEntry.Mutation)
		end
		local level = brainrotEntry.Level or 1
		return {
			ItemId = itemId,
			ItemType = "Brainrot",
			Amount = 1,
			BrainrotId = brainrotId,
			Mutation = brainrotEntry.Mutation,
			ModelName = modelName,
			Level = level,
			CashPerSec = getCashPerSec(baseCps, level),
		}
	end

	return {
		ItemId = "",
		ItemType = "",
		Amount = 0,
	}
end

local function getEquippedItemSummaryForPlayer(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return {
			ItemId = "",
			ItemType = "",
			Amount = 0,
		}
	end

	return buildEquippedItemSummary(playerData, playerData.EquippedItem or "")
end

local function fireEquippedItemUpdate(player, playerData)
	EquippedItemUpdateEvent:FireClient(player, buildEquippedItemSummary(playerData, playerData.EquippedItem or ""))
end

function InventoryService.PushEquippedItemForPlayer(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if playerData then
		fireEquippedItemUpdate(player, playerData)
	end
end

local function onToggleEquip(player, itemId)
	if type(itemId) ~= "string" then return false end

	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return false end

	local inventory = playerData.Inventory or {}
	local isLuckyBlock = inventory[itemId] and inventory[itemId] > 0 and GameConfig.LuckyBlocks[itemId]

	local brainrotInv = playerData.BrainrotInventory or {}
	local isBrainrot = brainrotInv[itemId] ~= nil

	if not isBrainrot and not isLuckyBlock then return false end

	if playerData.EquippedItem == itemId then
		playerData.EquippedItem = ""
	else
		playerData.EquippedItem = itemId
	end

	invalidatePayload(player)
	fireEquippedItemUpdate(player, playerData)
	return true
end

local function onDeleteItem(player, itemId, amount)
	if type(itemId) ~= "string" then return false end
	amount = (type(amount) == "number" and amount > 0) and math.floor(amount) or 1

	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return false end

	local inventory = playerData.Inventory or {}
	local current = inventory[itemId] or 0
	if current > 0 then
		local toRemove = math.min(amount, current)
		inventory[itemId] = current - toRemove

		if inventory[itemId] <= 0 then
			inventory[itemId] = nil
			if playerData.EquippedItem == itemId then
				playerData.EquippedItem = ""
				PlayerDataService.DataChanged:Fire(player, "EquippedItem", playerData.EquippedItem)
			end
		end

		invalidatePayload(player)
		pushUpdate(player)
		return true
	end

	local brainrotInv = playerData.BrainrotInventory or {}
	if brainrotInv[itemId] then
		brainrotInv[itemId] = nil
		if playerData.EquippedItem == itemId then
			playerData.EquippedItem = ""
			PlayerDataService.DataChanged:Fire(player, "EquippedItem", playerData.EquippedItem)
		end

		PlayerDataService.DataChanged:Fire(player, "BrainrotInventory", brainrotInv)
		invalidatePayload(player)
		pushUpdate(player)
		return true
	end

	return false
end

function InventoryService.PushUpdateForPlayer(player)
	invalidatePayload(player)
	pushUpdate(player)
	InventoryService.PushEquippedItemForPlayer(player)
end

function InventoryService.Init()
	RequestInventoryFunc.OnServerInvoke = onRequestInventory
	RequestEquippedItemFunc.OnServerInvoke = getEquippedItemSummaryForPlayer
	ToggleEquipFunc.OnServerInvoke = onToggleEquip
	DeleteItemFunc.OnServerInvoke = onDeleteItem

	PlayerDataService.DataChanged.Event:Connect(function(player, statName, _value)
		if statName == "EquippedItem" then
			invalidatePayload(player)
			InventoryService.PushEquippedItemForPlayer(player)
			return
		end

		if statName == "Inventory" or statName == "BrainrotInventory" or statName == "BrainrotUnlocked" then
			invalidatePayload(player)
			schedulePush(player)
		end
	end)

	PlayerDataService.ProfileLoaded.Event:Connect(function(player, _data)
		invalidatePayload(player)
		task.defer(function()
			pushUpdate(player)
			local playerData = PlayerDataService.GetPlayerData(player)
			if playerData then
				fireEquippedItemUpdate(player, playerData)
			end
		end)
	end)

	Players.PlayerRemoving:Connect(function(player)
		payloadCache[player] = nil
		summaryCache[player] = nil
		dirtyPlayers[player] = nil
		pendingPushPlayers[player] = nil
	end)
end

return InventoryService