--[[ ShopService - Handles Robux purchases: gamepasses, developer products, exclusive items, gifting ]]
local Players = game:GetService('Players')
local MarketplaceService = game:GetService('MarketplaceService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Knit = require(ReplicatedStorage.Packages.Knit)

local IDs           = require(ReplicatedStorage.Shared.List.Shop.IDs)
local StarterPacks  = require(ReplicatedStorage.Shared.List.Shop.StarterPacks)
local ExclusiveItems= require(ReplicatedStorage.Shared.List.Shop.ExclusiveItems)
local Variables     = require(ReplicatedStorage.Shared.Variables)
local SupporterPack = require(ReplicatedStorage.Shared.List.Shop.SupporterPack)

-- Token pack amounts by productId
local TOKEN_PRODUCTS = {
  [3238404978] = 50,
  [3238405062] = 250,
  [3238405138] = 500,
  [3238405226] = 1000,
  [3238405336] = 5000,
  [3238405432] = 10000,
}

-- Cache for MarketplaceService:GetProductInfo results (productId -> PriceInRobux)
local _priceCache = {}

local ShopService = Knit.CreateService({
  Name = 'ShopService',
  Client = {
    purchaseSuccess         = Knit.CreateSignal(),
    purchaseFailed          = Knit.CreateSignal(),
    purchaseWithTokensSuccess = Knit.CreateSignal(),
    giftSuccess             = Knit.CreateSignal(),
    stockUpdated            = Knit.CreateSignal(),
    -- Signals expected by UIController
    purchaseCanceled        = Knit.CreateSignal(),
    purchaseConfirmed       = Knit.CreateSignal(),
    -- UI navigation signal (client fires, ignored server-side)
    setLocation             = Knit.CreateSignal(),
  },
  _ds = nil,
  _inv = nil,
})

------------------------------------------------------------------------
-- Internal: give a gamepass reward to a player
------------------------------------------------------------------------
local function grantGamepass(data, ds, player, passName)
  if data.passes[passName] then return end
  ds:Set(player, {'passes', passName}, true)
end

------------------------------------------------------------------------
-- Internal: grant items from a starter pack
------------------------------------------------------------------------
local function grantStarterPack(inv, player, packName)
  local pack = StarterPacks[packName]
  if not pack then return end
  for _, item in pack.rewards do
    inv:GiveItem(player, item)
  end
end

------------------------------------------------------------------------
-- Internal: grant exclusive shop item
------------------------------------------------------------------------
local function grantExclusiveItem(inv, player, idKey)
  local idx = tonumber((idKey:gsub('exclusiveItem', '')))
  if not idx then return end
  local entry = ExclusiveItems[idx]
  if not entry then return end
  for _, item in entry.rewards do
    inv:GiveItem(player, item)
  end
end

------------------------------------------------------------------------
-- ProcessReceipt: called for every developer product purchase
------------------------------------------------------------------------
function ShopService:_processReceipt(receiptInfo)
  local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
  if not player then
    return Enum.ProductPurchaseDecision.NotProcessedYet
  end

  local data = self._ds:WaitForData(player)
  if not data then
    return Enum.ProductPurchaseDecision.NotProcessedYet
  end

  local productId = receiptInfo.ProductId

  -- Token packs
  local tokenAmount = TOKEN_PRODUCTS[productId]
  if tokenAmount then
    self._inv:GiveItem(player, {category='exclusive', id='tradeTokens', amount=tokenAmount})
    self.Client.purchaseSuccess:Fire(player)
    return Enum.ProductPurchaseDecision.PurchaseGranted
  end

  -- Starter packs (match by productId in IDs table)
  for idKey, idData in IDs do
    if type(idData) == "table" and idData.productId == productId then
      -- Check if it's a starter pack
      if StarterPacks[idKey] then
        grantStarterPack(self._inv, player, idKey)
        self.Client.purchaseSuccess:Fire(player)
        return Enum.ProductPurchaseDecision.PurchaseGranted
      end
      -- releaseStockPack: same as starterPack rewards
      if idKey == "releaseStockPack" then
        grantStarterPack(self._inv, player, "starterPack")
        self.Client.purchaseSuccess:Fire(player)
        return Enum.ProductPurchaseDecision.PurchaseGranted
      end
    end
  end

  -- Exclusive eggs (1, 3, 10)
  local exclusiveEggAmounts = {
    [IDs.exclusiveEgg1  and IDs.exclusiveEgg1.productId]  = 1,
    [IDs.exclusiveEgg3  and IDs.exclusiveEgg3.productId]  = 3,
    [IDs.exclusiveEgg10 and IDs.exclusiveEgg10.productId] = 10,
  }
  local eggAmt = exclusiveEggAmounts[productId]
  if eggAmt then
    local eggName = Variables.currentExclusiveEgg.name
    self._inv:GiveItem(player, {category='exclusiveEgg', id=eggName, amount=eggAmt})
    self.Client.purchaseSuccess:Fire(player)
    return Enum.ProductPurchaseDecision.PurchaseGranted
  end

  -- Exclusive items (1, 2, 3)
  for idKey, idData in IDs do
    if idData.productId == productId and idKey:find('exclusiveItem') then
      grantExclusiveItem(self._inv, player, idKey)
      self.Client.purchaseSuccess:Fire(player)
      return Enum.ProductPurchaseDecision.PurchaseGranted
    end
  end

  -- buyAllPasses bundles
  local allPassTiers = {
    buyAllPassesBasic = {'autoClicker','petEquip2','fasterEggsOpen','magicEggs'},
    buyAllPassesTier3 = {'autoClicker','petEquip2','petEquip3','fasterEggsOpen','magicEggs','megaLuck'},
    buyAllPassesTier4 = {'autoClicker','petEquip2','petEquip3','fasterEggsOpen','magicEggs','megaLuck','ultraLuck','vip','insaneFarmer','shinyHunter'},
  }
  for bundleName, passes in allPassTiers do
    if IDs[bundleName] and IDs[bundleName].productId == productId then
      for _, passName in passes do
        grantGamepass(data, self._ds, player, passName)
      end
      self.Client.purchaseSuccess:Fire(player)
      return Enum.ProductPurchaseDecision.PurchaseGranted
    end
  end

  warn('[ShopService] Unhandled productId:', productId)
  return Enum.ProductPurchaseDecision.NotProcessedYet
end

------------------------------------------------------------------------
-- GamepassPurchased: called when a gamepass is purchased in-session
------------------------------------------------------------------------
function ShopService:_onGamepassPurchased(player, gamepassId, wasPurchased)
  if not wasPurchased then return end
  local data = self._ds:GetData(player)
  if not data then return end

  -- Map gamepassId -> passName
  for passName, idData in IDs do
    if idData.gamePassId == gamepassId then
      grantGamepass(data, self._ds, player, passName)
      self.Client.purchaseSuccess:Fire(player)
      return
    end
  end
end

-- RemoteFunction: client calls ShopService:getStock(itemName) → returns stock count or nil
function ShopService.Client:getStock(_player, _itemName)
  return nil -- Stock system not implemented (original game used external data)
end

------------------------------------------------------------------------
-- Client: buyWithTokens(productName) → "disabled" | "notEnough" | "success"
------------------------------------------------------------------------
function ShopService.Client:buyWithTokens(player, productName)
  local srv = self.Server
  local idData = IDs[productName]
  if not idData then
    warn('[ShopService] buyWithTokens: unknown productName', productName)
    return 'disabled'
  end

  -- Check if token purchase is disabled for this product
  if idData.tokenPurchaseDisabled then
    return 'disabled'
  end

  local productId = idData.productId
  if not productId then
    warn('[ShopService] buyWithTokens: no productId for', productName)
    return 'disabled'
  end

  -- Resolve token price (1 token = 1 Robux), cached per productId
  local priceInRobux = _priceCache[productId]
  if not priceInRobux then
    local ok, info = pcall(function()
      return MarketplaceService:GetProductInfo(productId, Enum.InfoType.Product)
    end)
    if ok and info and info.PriceInRobux then
      priceInRobux = info.PriceInRobux
      _priceCache[productId] = priceInRobux
    else
      warn('[ShopService] buyWithTokens: failed to get price for productId', productId)
      return 'disabled'
    end
  end

  local data = srv._ds:WaitForData(player)
  if not data then return 'disabled' end

  -- Check token balance
  local currentTokens = srv._inv:GetItemAmount(player, 'exclusive', 'tradeTokens')
  if currentTokens < priceInRobux then
    return 'notEnough'
  end

  -- Deduct tokens
  srv._inv:RemoveItem(player, 'exclusive', 'tradeTokens', priceInRobux)

  -- Grant the product using the same logic as ProcessReceipt
  -- Starter packs
  for packName, _ in StarterPacks do
    if packName == productName then
      grantStarterPack(srv._inv, player, packName)
      srv.Client.purchaseWithTokensSuccess:Fire(player)
      return 'success'
    end
  end

  -- Exclusive eggs
  local exclusiveEggAmounts = {
    exclusiveEgg1  = 1,
    exclusiveEgg3  = 3,
    exclusiveEgg10 = 10,
  }
  local eggAmt = exclusiveEggAmounts[productName]
  if eggAmt then
    local eggName = Variables.currentExclusiveEgg.name
    srv._inv:GiveItem(player, {category='exclusiveEgg', id=eggName, amount=eggAmt})
    srv.Client.purchaseWithTokensSuccess:Fire(player)
    return 'success'
  end

  -- Exclusive items
  if productName:find('exclusiveItem') then
    grantExclusiveItem(srv._inv, player, productName)
    srv.Client.purchaseWithTokensSuccess:Fire(player)
    return 'success'
  end

  -- buyAllPasses bundles
  local allPassTiers = {
    buyAllPassesBasic = {'autoClicker','petEquip2','fasterEggsOpen','magicEggs'},
    buyAllPassesTier3 = {'autoClicker','petEquip2','petEquip3','fasterEggsOpen','magicEggs','megaLuck'},
    buyAllPassesTier4 = {'autoClicker','petEquip2','petEquip3','fasterEggsOpen','magicEggs','megaLuck','ultraLuck','vip','insaneFarmer','shinyHunter'},
  }
  local bundlePasses = allPassTiers[productName]
  if bundlePasses then
    for _, passName in bundlePasses do
      grantGamepass(data, srv._ds, player, passName)
    end
    srv.Client.purchaseWithTokensSuccess:Fire(player)
    return 'success'
  end

  warn('[ShopService] buyWithTokens: unhandled productName', productName)
  -- Refund tokens since we couldn't grant
  srv._inv:GiveItem(player, {category='exclusive', id='tradeTokens', amount=priceInRobux})
  return 'disabled'
end

------------------------------------------------------------------------
-- Client: claimSupporterPack() → "noMore" | "notEnough" | "success"
------------------------------------------------------------------------
function ShopService.Client:claimSupporterPack(player)
  local srv = self.Server
  local data = srv._ds:WaitForData(player)
  if not data then return 'notEnough' end

  local robuxSpent       = data.stats.robuxSpent or 0
  local currentTier      = data.supporterPackTier or 0
  local nextTier         = currentTier + 1

  local tierData = SupporterPack[nextTier]
  if not tierData then
    return 'noMore'
  end

  if robuxSpent < tierData.required then
    return 'notEnough'
  end

  -- Grant the item and advance tier
  srv._inv:GiveItem(player, tierData.item)
  srv._ds:Set(player, {'supporterPackTier'}, nextTier)

  return 'success'
end

------------------------------------------------------------------------
-- Client: cancelGift() → "ok"  (gifting state managed client-side)
------------------------------------------------------------------------
function ShopService.Client:cancelGift(_player)
  return 'ok'
end

function ShopService:KnitInit()
  self._ds  = Knit.GetService('DataService')
  self._inv = Knit.GetService('InventoryService')
end

function ShopService:KnitStart()
  MarketplaceService.ProcessReceipt = function(receiptInfo)
    local result = self:_processReceipt(receiptInfo)
    if result == Enum.ProductPurchaseDecision.PurchaseGranted then
      local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
      if player then
        self.Client.purchaseConfirmed:Fire(player)
      end
    end
    return result
  end
  MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, id, purchased)
    self:_onGamepassPurchased(player, id, purchased)
    if purchased then
      self.Client.purchaseConfirmed:Fire(player)
    else
      self.Client.purchaseCanceled:Fire(player)
    end
  end)

  -- Verify gamepass ownership on player join
  Players.PlayerAdded:Connect(function(player)
    self:_verifyGamepasses(player)
  end)
  for _, player in Players:GetPlayers() do
    task.spawn(function()
      self:_verifyGamepasses(player)
    end)
  end

  print('[ShopService] Started')
end

------------------------------------------------------------------------
-- Verify gamepass ownership via MarketplaceService on join
-- Syncs Roblox ownership → data.passes so "Owned" shows correctly
------------------------------------------------------------------------
function ShopService:_verifyGamepasses(player)
  local data = self._ds:WaitForData(player)
  if not data then return end

  for passName, idData in IDs do
    if idData.gamePassId then
      local ok, owns = pcall(function()
        return MarketplaceService:UserOwnsGamePassAsync(player.UserId, idData.gamePassId)
      end)
      if ok and owns and not data.passes[passName] then
        self._ds:Set(player, {'passes', passName}, true)
      end
    end
  end
end

return ShopService