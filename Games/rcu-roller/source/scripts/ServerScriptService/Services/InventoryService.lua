--[[ InventoryService - Manages player inventory + item notifications ]]
local RS = game:GetService('ReplicatedStorage')
local HttpService = game:GetService('HttpService')
local Knit = require(RS.Packages.Knit)

local InventoryService = Knit.CreateService({
  Name = 'InventoryService',
  Client = {newItem = Knit.CreateSignal()},
  _ds = nil,
})

local function generateId()
  return HttpService:GenerateGUID(false):gsub('-', '')
end

------------------------------------------------------------------------
-- findExistingEntry: find inventory entry matching cl+nm in a category
------------------------------------------------------------------------
local function findExistingEntry(categoryItems, cat, name)
  if not categoryItems then return nil, nil end
  for id, itemData in categoryItems do
    if type(itemData) == 'table' and itemData.cl == cat and itemData.nm == name then
      return id, itemData
    end
  end
  return nil, nil
end

------------------------------------------------------------------------
-- GiveItem: add item to inventory and fire newItem signal
-- item: Items object OR plain table {category, id, amount}
------------------------------------------------------------------------
function InventoryService:GiveItem(player, item)
  if not item then return end
  local data = self._ds:GetData(player)
  if not data then return end

  -- Support both Items objects and plain tables
  local cat = type(item.getClass)=='function' and item:getClass() or item.category
  local name = type(item.getName)=='function' and item:getName() or item.id
  local amt = type(item.getAmount)=='function' and item:getAmount() or item.amount or 1

  if not cat or not name then
    warn('[InventoryService] GiveItem: missing category or name')
    return
  end

  -- Ensure inventory table exists
  if not data.inventory then
    self._ds:Set(player, {'inventory'}, {})
    data = self._ds:GetData(player)
    if not data then return end
  end

  -- Ensure category exists
  if not data.inventory[cat] then
    self._ds:Set(player, {'inventory', cat}, {})
  end

  -- Try to find existing item with same cl+nm to merge amounts
  local existingId = findExistingEntry(data.inventory[cat], cat, name)
  local inventoryId

  if existingId then
    -- Merge: increment amount
    local currentAmt = data.inventory[cat][existingId].am or 1
    self._ds:Set(player, {'inventory', cat, existingId, 'am'}, currentAmt + amt)
    inventoryId = existingId
  else
    -- Create new entry with unique ID
    inventoryId = generateId()
    self._ds:Set(player, {'inventory', cat, inventoryId}, {cl=cat, nm=name, am=amt})
  end

  -- Fire notification with the actual inventory key
  self.Client.newItem:Fire(player, inventoryId, amt, {category=cat})
end

------------------------------------------------------------------------
-- GiveReward: used by services that have Items objects
------------------------------------------------------------------------
function InventoryService:GiveReward(player, reward)
  if not reward then return end
  local class = type(reward.getClass)=='function' and reward:getClass() or reward.category
  local name  = type(reward.getName)=='function'  and reward:getName()  or reward.id
  local amt   = type(reward.getAmount)=='function' and reward:getAmount() or reward.amount or 1

  if class == 'clicks' or class == 'click' then
    local data = self._ds:GetData(player)
    if data then self._ds:Set(player, {'clicks'}, (data.clicks or 0) + amt) end
  elseif class == 'gems' or class == 'gem' then
    local data = self._ds:GetData(player)
    if data then self._ds:Set(player, {'gems'}, (data.gems or 0) + amt) end
  elseif class == 'upgrade' then
    local data = self._ds:GetData(player)
    if data then
      local cur = data.upgrades and data.upgrades[name] or 0
      if type(cur) == 'number' then
        self._ds:Set(player, {'upgrades', name}, cur + amt)
      end
    end
  else
    self:GiveItem(player, reward)
  end
end

------------------------------------------------------------------------
-- RemoveItem: remove amount from item, delete entry if 0
------------------------------------------------------------------------
function InventoryService:RemoveItem(player, category, itemName, amount)
  local data = self._ds:GetData(player)
  if not data then return false end
  amount = amount or 1

  local catItems = data.inventory and data.inventory[category]
  if not catItems then return false end

  local existingId, existingData = findExistingEntry(catItems, category, itemName)
  if not existingId then return false end

  local current = existingData.am or 1
  if current < amount then return false end

  local remaining = current - amount
  if remaining <= 0 then
    -- Remove the entry entirely
    self._ds:Set(player, {'inventory', category, existingId}, nil)
  else
    self._ds:Set(player, {'inventory', category, existingId, 'am'}, remaining)
  end
  return true
end

------------------------------------------------------------------------
-- HasItem: check if player has enough of an item by name
------------------------------------------------------------------------
function InventoryService:HasItem(player, category, itemName, amount)
  local data = self._ds:GetData(player)
  if not data then return false end
  amount = amount or 1

  local catItems = data.inventory and data.inventory[category]
  if not catItems then return false end

  local existingId, existingData = findExistingEntry(catItems, category, itemName)
  if not existingId then return false end

  return (existingData.am or 1) >= amount
end

------------------------------------------------------------------------
-- GetItemAmount: get how many of an item the player has
------------------------------------------------------------------------
function InventoryService:GetItemAmount(player, category, itemName)
  local data = self._ds:GetData(player)
  if not data then return 0 end

  local catItems = data.inventory and data.inventory[category]
  if not catItems then return 0 end

  local existingId, existingData = findExistingEntry(catItems, category, itemName)
  if not existingId then return 0 end

  return existingData.am or 1
end

------------------------------------------------------------------------
-- rollWeighted: pick `amount` items from a {item, chance} rewards table
------------------------------------------------------------------------
local function rollWeighted(rewardsList, amount)
  local totalWeight = 0
  for _, entry in rewardsList do
    totalWeight += entry.chance
  end
  local picked = {}
  for _ = 1, amount do
    local roll = math.random() * totalWeight
    local cumulative = 0
    for _, entry in rewardsList do
      cumulative += entry.chance
      if roll <= cumulative then
        picked[#picked + 1] = entry.item
        break
      end
    end
  end
  return picked
end

------------------------------------------------------------------------
-- useItem - client fires to use a consumable (potion, box, etc.)
-- itemId: inventory GUID  |  category: item class string (e.g. \"box\")
------------------------------------------------------------------------
function InventoryService.Client:useItem(player, itemId, category, options)
  local srv = self.Server
  local data = srv._ds:GetData(player)
  if not data then return 'error', 'No data' end

  -- Resolve itemName from the inventory GUID
  local itemName = itemId
  local catItems = data.inventory and category and data.inventory[category]
  if catItems then
    local itemData = catItems[itemId]
    if type(itemData) == 'table' and itemData.nm then
      itemName = itemData.nm
    end
  end

  if not srv:HasItem(player, category, itemName, 1) then
    return 'error', 'You do not have that item'
  end

  -----------------------------------------------------------------------
  -- BOX opening
  -----------------------------------------------------------------------
  if category == 'box' then
    -- Load box config
    local ok, Boxes = pcall(require, RS.Shared.List.Items.Boxes)
    if not ok or not Boxes then
      return 'error', 'Box data unavailable'
    end
    local boxConfig = Boxes[itemName]
    if not boxConfig then
      return 'error', 'Unknown box type: ' .. tostring(itemName)
    end

    -- Remove one box from inventory first
    local removed = srv:RemoveItem(player, category, itemName, 1)
    if not removed then
      return 'error', 'Could not remove box from inventory'
    end

    -- Determine extra items bonus (from ancientShop extraItemBox upgrade)
    local extraItems = 0
    if data.ancientShop and data.ancientShop.extraItemBox then
      extraItems = 1
    end

    local rewardCount = (boxConfig.rewardAmount or 1) + extraItems
    local rewards = rollWeighted(boxConfig.rewards, rewardCount)

    -- Give each reward to the player
    local rewardData = {}
    for _, item in rewards do
      srv:GiveItem(player, item)
      rewardData[#rewardData + 1] = {
        cl = item:getClass(),
        nm = item:getName(),
        am = item:getAmount(),
      }
    end

    return 'success', rewardData
  end

  -----------------------------------------------------------------------
  -- POTION usage
  -----------------------------------------------------------------------
  if category == 'potion' then
    local ok2, Potions = pcall(require, RS.Shared.List.Items.Potions)
    if ok2 and Potions and Potions[itemName] then
      local cfg = Potions[itemName]
      local seconds = cfg.seconds or 300
      srv:RemoveItem(player, category, itemName, 1)
      srv._ds:Set(player, {'activeBoosts', itemName}, seconds)
      local QuestService = Knit.GetService("QuestService")
      QuestService:IncrementQuest(player, "usePotions", 1)
      return 'success', {cl=category, nm=itemName, am=srv:GetItemAmount(player, category, itemName)}
    end
  end

  -----------------------------------------------------------------------
  -- FRUIT usage (apple, carrot, grape, strawberry, pineapple + golden variants)
  -----------------------------------------------------------------------
  if category == 'fruit' then
    local ok2, Fruits = pcall(require, RS.Shared.List.Items.Fruits)
    if ok2 and Fruits and Fruits[itemName] then
      local cfg = Fruits[itemName]
      local seconds = cfg.seconds or 300
      srv:RemoveItem(player, category, itemName, 1)
      srv._ds:Set(player, {'activeBoosts', itemName}, seconds)
      return 'success', {cl=category, nm=itemName, am=srv:GetItemAmount(player, category, itemName)}
    end
  end

  -----------------------------------------------------------------------
  -- EXCLUSIVE item usage (globalLuck, globalLuckyEgg, globalStarEvent, epicLuck)
  -----------------------------------------------------------------------
  if category == 'exclusive' then
    -- epicLuck: personal luck buff via activeBoosts
    if itemName == 'epicLuck' then
      local ok2, Exclusive = pcall(require, RS.Shared.List.Items.Exclusive)
      local cfg = ok2 and Exclusive and Exclusive[itemName]
      local seconds = cfg and cfg.seconds or 10800
      srv:RemoveItem(player, category, itemName, 1)
      srv._ds:Set(player, {'activeBoosts', itemName}, seconds)
      return 'success', {cl=category, nm=itemName, am=srv:GetItemAmount(player, category, itemName)}
    end

    -- globalLuck: broadcast +25% luck to all servers via MessagingService
    if itemName == 'globalLuck' then
      srv:RemoveItem(player, category, itemName, 1)
      local expiresAt = os.time() + 1800 -- 30 minutes
      local ok2, ms = pcall(function() return game:GetService('MessagingService') end)
      if ok2 and ms then
        pcall(function()
          ms:PublishAsync('globalLuck', {
            playerName = player.Name, expiresAt = expiresAt
          })
        end)
      end
      return 'success', {cl=category, nm=itemName, am=srv:GetItemAmount(player, category, itemName)}
    end

    -- globalLuckyEgg: spawn best egg globally with +250% luck
    if itemName == 'globalLuckyEgg' then
      options = type(options) == 'table' and options or {}
      local mapId = options.mapId
      srv:RemoveItem(player, category, itemName, 1)
      local expiresAt = os.time() + 900 -- 15 minutes
      local ok2, ms = pcall(function() return game:GetService('MessagingService') end)
      if ok2 and ms then
        pcall(function()
          ms:PublishAsync('globalLuckyEgg', {
            playerName = player.Name, mapId = mapId, expiresAt = expiresAt
          })
        end)
      end
      return 'success', {cl=category, nm=itemName, am=srv:GetItemAmount(player, category, itemName)}
    end

    -- globalStarEvent: spawn star event on all servers
    if itemName == 'globalStarEvent' then
      srv:RemoveItem(player, category, itemName, 1)
      local expiresAt = os.time() + 300 -- 5 minutes
      local ok2, ms = pcall(function() return game:GetService('MessagingService') end)
      if ok2 and ms then
        pcall(function()
          ms:PublishAsync('globalStarEvent', {
            playerName = player.Name, expiresAt = expiresAt
          })
        end)
      end
      return 'success', {cl=category, nm=itemName, am=srv:GetItemAmount(player, category, itemName)}
    end
  end

  warn('[InventoryService] Unhandled useItem:', category, itemName)
  return 'error', 'Cannot use that item'
end

function InventoryService:KnitInit()
  self._ds = Knit.GetService('DataService')
end

function InventoryService:KnitStart()
  print('[InventoryService] Started')
end

return InventoryService
