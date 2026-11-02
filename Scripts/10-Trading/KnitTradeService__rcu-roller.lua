-- Game: rcu-roller
-- Original: ServerScriptService/Services/TradeService.lua  (517 lines)
-- What it does: Knit service for in-memory trades of stackable items plus a currency (trade tokens). Ready stage then Confirm stage, items counted per id, amount validated against owned stack, debounced and expiring requests.

--[[
	TradeService — In-memory player-to-player trading system
	No DataStore needed: all trade state is ephemeral.
	Uses InventoryService for item validation and DataService for final swap.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Knit = require(ReplicatedStorage.Packages.Knit)

local MAX_ITEMS_PER_SIDE = 50
local REQUEST_DEBOUNCE   = 3   -- seconds between trade requests to same target
local REQUEST_TIMEOUT    = 60  -- seconds before a pending request expires

------------------------------------------------------------------------
-- State
------------------------------------------------------------------------
local activeTrades   = {}  -- [tradeId] = tradeObj
local playerToTrade  = {}  -- [player]  = tradeId
local pendingRequests = {} -- [targetPlayer] = {fromPlayer, timestamp}
local tradeCounter   = 0

------------------------------------------------------------------------
-- Service definition
------------------------------------------------------------------------
local TradeService = Knit.CreateService({
	Name = "TradeService",
	Client = {
		-- Bidirectional signals
		acceptTrade        = Knit.CreateSignal(),
		sendTradeRequest   = Knit.CreateSignal(),
		declineTrade       = Knit.CreateSignal(),
		updatePlayerList   = Knit.CreateSignal(),
		confirmTrade       = Knit.CreateSignal(),
		readyTrade         = Knit.CreateSignal(),
		unreadyTrade       = Knit.CreateSignal(),
		cancelTrade        = Knit.CreateSignal(),
		unconfirmTrade     = Knit.CreateSignal(),
		-- Server-only signals (server fires to client)
		promptTradeRequest = Knit.CreateSignal(),
		tradeAccepted      = Knit.CreateSignal(),
		processTrade       = Knit.CreateSignal(),
		completedTrade     = Knit.CreateSignal(),
		itemInTradeUpdated = Knit.CreateSignal(),
		confirmStage       = Knit.CreateSignal(),
	},
})

------------------------------------------------------------------------
-- Helpers
------------------------------------------------------------------------
local function newTrade(p1, p2)
	tradeCounter += 1
	local id = tradeCounter
	activeTrades[id] = {
		id         = id,
		player1    = p1,
		player2    = p2,
		items1     = {},   -- [itemId] = amount
		items2     = {},
		tokens1    = 0,
		tokens2    = 0,
		ready1     = false,
		ready2     = false,
		confirmed1 = false,
		confirmed2 = false,
	}
	playerToTrade[p1] = id
	playerToTrade[p2] = id
	return id
end

local function getTrade(player)
	local id = playerToTrade[player]
	return id and activeTrades[id]
end

local function getSide(trade, player)
	if trade.player1 == player then
		return 1
	elseif trade.player2 == player then
		return 2
	end
	return nil
end

local function getOther(trade, player)
	if trade.player1 == player then return trade.player2 end
	return trade.player1
end

local function countItems(itemsTable)
	local n = 0
	for _, amt in itemsTable do
		n += amt
	end
	return n
end

local function cancelTrade(trade, reason)
	if not trade then return end
	activeTrades[trade.id] = nil
	if trade.player1 and trade.player1.Parent then
		playerToTrade[trade.player1] = nil
		TradeService.Client.cancelTrade:Fire(trade.player1, reason)
	end
	if trade.player2 and trade.player2.Parent then
		playerToTrade[trade.player2] = nil
		TradeService.Client.cancelTrade:Fire(trade.player2, reason)
	end
end

-- Reset ready/confirmed state on both sides (called when items change)
local function resetReady(trade)
	trade.ready1     = false
	trade.ready2     = false
	trade.confirmed1 = false
	trade.confirmed2 = false
end

-- Build the itemInTradeUpdated payload for one side
local function buildItemPayload(itemsTable, tokens)
	local items = {}
	for id, amt in itemsTable do
		items[id] = amt
	end
	return items, tokens
end

-- Fire itemInTradeUpdated to both players
local function fireItemUpdate(trade)
	local items1, tok1 = buildItemPayload(trade.items1, trade.tokens1)
	local items2, tok2 = buildItemPayload(trade.items2, trade.tokens2)
	-- player1 sees: mine=side1, theirs=side2
	TradeService.Client.itemInTradeUpdated:Fire(trade.player1, "mine",   items1, tok1)
	TradeService.Client.itemInTradeUpdated:Fire(trade.player1, "theirs", items2, tok2)
	-- player2 sees: mine=side2, theirs=side1
	TradeService.Client.itemInTradeUpdated:Fire(trade.player2, "mine",   items2, tok2)
	TradeService.Client.itemInTradeUpdated:Fire(trade.player2, "theirs", items1, tok1)
end

------------------------------------------------------------------------
-- RemoteFunctions (Client namespace)
------------------------------------------------------------------------

-- Returns {[playerName] = {displayName, userId, level}} for all players
function TradeService.Client:getPlayerInfos(player)
	local DataService = Knit.GetService("DataService")
	local result = {}
	for _, p in Players:GetPlayers() do
		if p == player then continue end
		local data = DataService:GetData(p)
		result[p.Name] = {
			displayName = p.DisplayName,
			userId      = p.UserId,
			level       = data and data.rebirths or 0,
		}
	end
	return result
end

-- Add one item to the active trade (amount = 1 per click)
function TradeService.Client:addItemToTrade(player, itemId)
	local DataService = Knit.GetService("DataService")
	local trade = getTrade(player)
	if not trade then return "noTrade", "You are not in a trade" end

	local side = getSide(trade, player)
	local itemsTable = side == 1 and trade.items1 or trade.items2

	-- Cap at 50 items total
	if countItems(itemsTable) >= MAX_ITEMS_PER_SIDE then
		return "tooManyItems", "Max 50 items per trade"
	end

	-- Validate item exists in inventory
	local data = DataService:GetData(player)
	if not data then return "error", "Data not loaded" end

	-- Find the item across all inventory categories (GUID-keyed: val = {cl, nm, am})
	local foundCat, foundAmt
	for cat, catTable in data.inventory do
		if type(catTable) == "table" and catTable[itemId] then
			local entry = catTable[itemId]
			foundCat = cat
			foundAmt = (type(entry) == "table" and entry.am) or 1
			break
		end
	end
	if not foundCat then return "notOwned", "Item not in inventory" end

	-- Count how many of this item are already committed to the trade
	local alreadyInTrade = itemsTable[itemId] or 0
	if alreadyInTrade >= foundAmt then
		return "notOwned", "Not enough of this item"
	end

	itemsTable[itemId] = alreadyInTrade + 1
	resetReady(trade)
	fireItemUpdate(trade)
	return "success", { id = itemId, amount = itemsTable[itemId], category = foundCat }
end

-- Remove one item from the active trade
function TradeService.Client:removeItemFromTrade(player, itemId)
	local DataService = Knit.GetService("DataService")
	local trade = getTrade(player)
	if not trade then return "noTrade", "You are not in a trade" end

	local side = getSide(trade, player)
	local itemsTable = side == 1 and trade.items1 or trade.items2

	if not itemsTable[itemId] or itemsTable[itemId] <= 0 then
		return "notInTrade", "Item not in trade"
	end

	itemsTable[itemId] -= 1
	if itemsTable[itemId] <= 0 then
		itemsTable[itemId] = nil
	end

	-- Find category for return payload
	local data = DataService:GetData(player)
	local foundCat = "exclusive"
	if data then
		for cat, catTable in data.inventory do
			if type(catTable) == "table" and catTable[itemId] then
				foundCat = cat
				break
			end
		end
	end

	resetReady(trade)
	fireItemUpdate(trade)
	return "success", { id = itemId, amount = itemsTable[itemId] or 0, category = foundCat }
end

-- Set exclusive tokens offered in trade
function TradeService.Client:setTokensInTrade(player, amount)
	local DataService = Knit.GetService("DataService")
	local trade = getTrade(player)
	if not trade then return "noTrade", "You are not in a trade" end

	amount = math.max(0, math.floor(tonumber(amount) or 0))

	-- Find tradeTokens item in inventory.exclusive
	local data = DataService:GetData(player)
	if not data then return "error", "Data not loaded" end

	local tokenItemId = nil
	local tokenAmt    = 0
	if data.inventory.exclusive then
		for id, val in data.inventory.exclusive do
			if type(val) == "table" and val.nm == "tradeTokens" then
				tokenItemId = id
				tokenAmt    = val.am or 0
				break
			end
		end
	end
	if not tokenItemId then return "notOwned", "No trade tokens in inventory" end
	if amount > tokenAmt then return "notEnough", "Not enough trade tokens" end

	local side = getSide(trade, player)
	if side == 1 then
		trade.tokens1 = amount
	else
		trade.tokens2 = amount
	end

	resetReady(trade)
	fireItemUpdate(trade)
	return "success", { id = tokenItemId, amount = amount, category = "exclusive" }
end

------------------------------------------------------------------------
-- Signal handlers
------------------------------------------------------------------------

function TradeService:_onSendTradeRequest(fromPlayer, targetName)
	if playerToTrade[fromPlayer] then return end  -- already in a trade

	local targetPlayer = Players:FindFirstChild(targetName)
	if not targetPlayer or targetPlayer == fromPlayer then return end
	if playerToTrade[targetPlayer] then return end  -- target already trading

	-- Debounce: don't allow spam requests
	local existing = pendingRequests[targetPlayer]
	if existing and existing.fromPlayer == fromPlayer then
		if os.clock() - existing.timestamp < REQUEST_DEBOUNCE then return end
	end

	pendingRequests[targetPlayer] = {
		fromPlayer = fromPlayer,
		timestamp  = os.clock(),
	}

	self.Client.promptTradeRequest:Fire(targetPlayer, fromPlayer.Name)
end

function TradeService:_onAcceptTrade(acceptingPlayer, fromName)
	local request = pendingRequests[acceptingPlayer]
	if not request then return end
	if request.fromPlayer.Name ~= fromName then return end
	if os.clock() - request.timestamp > REQUEST_TIMEOUT then
		pendingRequests[acceptingPlayer] = nil
		return
	end

	local fromPlayer = request.fromPlayer
	pendingRequests[acceptingPlayer] = nil

	if not fromPlayer.Parent then return end
	if playerToTrade[fromPlayer] or playerToTrade[acceptingPlayer] then return end

	newTrade(fromPlayer, acceptingPlayer)
	self.Client.tradeAccepted:Fire(fromPlayer)
	self.Client.tradeAccepted:Fire(acceptingPlayer)
end

function TradeService:_onDeclineTrade(decliningPlayer, fromName)
	pendingRequests[decliningPlayer] = nil
	local fromPlayer = Players:FindFirstChild(fromName)
	if fromPlayer then
		self.Client.declineTrade:Fire(fromPlayer, decliningPlayer.Name)
	end
end

function TradeService:_onReadyTrade(player)
	local trade = getTrade(player)
	if not trade then return end

	local side = getSide(trade, player)
	if side == 1 then trade.ready1 = true else trade.ready2 = true end

	self.Client.readyTrade:Fire(getOther(trade, player), player.Name, true)

	if trade.ready1 and trade.ready2 then
		self.Client.confirmStage:Fire(trade.player1)
		self.Client.confirmStage:Fire(trade.player2)
	end
end

function TradeService:_onUnreadyTrade(player)
	local trade = getTrade(player)
	if not trade then return end

	local side = getSide(trade, player)
	if side == 1 then trade.ready1 = false else trade.ready2 = false end
	trade.confirmed1 = false
	trade.confirmed2 = false

	self.Client.readyTrade:Fire(getOther(trade, player), player.Name, false)
end

function TradeService:_onConfirmTrade(player)
	local DataService = Knit.GetService("DataService")
	local InventoryService = Knit.GetService("InventoryService")
	local trade = getTrade(player)
	if not trade then return end
	if not (trade.ready1 and trade.ready2) then return end

	local side = getSide(trade, player)
	if side == 1 then trade.confirmed1 = true else trade.confirmed2 = true end

	if not (trade.confirmed1 and trade.confirmed2) then
		-- Notify other player that this player confirmed
		self.Client.confirmTrade:Fire(getOther(trade, player), player.Name)
		return
	end

	-- Both confirmed — execute the trade
	local p1, p2 = trade.player1, trade.player2
	local items1, items2 = trade.items1, trade.items2
	local tok1, tok2     = trade.tokens1, trade.tokens2

	-- Fire processTrade to both so UI shows loading screen
	self.Client.processTrade:Fire(p1, items1, items2, tok1, tok2)
	self.Client.processTrade:Fire(p2, items2, items1, tok2, tok1)

	-- Tear down trade state before data mutation
	activeTrades[trade.id] = nil
	playerToTrade[p1] = nil
	playerToTrade[p2] = nil

	-- Transfer items: remove from each player, give to the other
	-- Transfer items: remove from each player, give to the other
	local function transferItems(fromPlayer, toPlayer, itemsTable, tokens)
		local receivedItems = {}
		for itemId, amount in itemsTable do
			for cat, catTable in (DataService:GetData(fromPlayer) or {}).inventory or {} do
				if type(catTable) == "table" and catTable[itemId] then
					local entry = catTable[itemId]
					local itemName = (type(entry) == "table" and entry.nm) or itemId
					InventoryService:RemoveItem(fromPlayer, cat, itemName, amount)
					InventoryService:GiveItem(toPlayer, { category = cat, id = itemName, amount = amount })
					receivedItems[itemId] = { category = cat, amount = amount }
					break
				end
			end
		end
		-- Transfer tokens
		if tokens > 0 then
			InventoryService:RemoveItem(fromPlayer, "exclusive", "tradeTokens", tokens)
			InventoryService:GiveItem(toPlayer, { category = "exclusive", id = "tradeTokens", amount = tokens })
		end
		return receivedItems
	end

	local received2 = transferItems(p1, p2, items1, tok1)
	local received1 = transferItems(p2, p1, items2, tok2)

	-- Fire completedTrade to both
	if p1.Parent then
		self.Client.completedTrade:Fire(p1, received1, tok2)
	end
	if p2.Parent then
		self.Client.completedTrade:Fire(p2, received2, tok1)
	end
end

function TradeService:_onUnconfirmTrade(player)
	local trade = getTrade(player)
	if not trade then return end

	local side = getSide(trade, player)
	if side == 1 then trade.confirmed1 = false else trade.confirmed2 = false end

	self.Client.unconfirmTrade:Fire(getOther(trade, player), player.Name)
end

function TradeService:_onCancelTrade(player)
	local trade = getTrade(player)
	if not trade then return end
	-- Fire cancel to the other player, then tear down
	local other = getOther(trade, player)
	activeTrades[trade.id] = nil
	playerToTrade[trade.player1] = nil
	playerToTrade[trade.player2] = nil
	if other and other.Parent then
		self.Client.cancelTrade:Fire(other)
	end
end

function TradeService:_onUpdatePlayerList(player)
	local result = self.Client:getPlayerInfos(player)
	self.Client.updatePlayerList:Fire(player, result)
end

------------------------------------------------------------------------
-- Player cleanup
------------------------------------------------------------------------
function TradeService:_onPlayerRemoving(player)
	-- Cancel any active trade
	local trade = getTrade(player)
	if trade then
		cancelTrade(trade, "otherLeft")
	end
	-- Clean up any pending request targeted at this player
	pendingRequests[player] = nil
	playerToTrade[player]   = nil
end

------------------------------------------------------------------------
-- Knit lifecycle
------------------------------------------------------------------------
function TradeService:KnitInit()
end

function TradeService:KnitStart()
	-- Wire up client signals
	self.Client.sendTradeRequest:Connect(function(player, targetName)
		self:_onSendTradeRequest(player, targetName)
	end)

	self.Client.acceptTrade:Connect(function(player, fromName)
		self:_onAcceptTrade(player, fromName)
	end)

	self.Client.declineTrade:Connect(function(player, fromName)
		self:_onDeclineTrade(player, fromName)
	end)

	self.Client.readyTrade:Connect(function(player)
		self:_onReadyTrade(player)
	end)

	self.Client.unreadyTrade:Connect(function(player)
		self:_onUnreadyTrade(player)
	end)

	self.Client.confirmTrade:Connect(function(player)
		self:_onConfirmTrade(player)
	end)

	self.Client.unconfirmTrade:Connect(function(player)
		self:_onUnconfirmTrade(player)
	end)

	self.Client.cancelTrade:Connect(function(player)
		self:_onCancelTrade(player)
	end)

	self.Client.updatePlayerList:Connect(function(player)
		self:_onUpdatePlayerList(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		self:_onPlayerRemoving(player)
	end)

	print("[TradeService] Started")
end

return TradeService
