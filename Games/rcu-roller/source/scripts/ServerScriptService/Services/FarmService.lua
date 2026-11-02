--[[ FarmService - Farm system: buy, claim, upgrade farms using List/Farms config ]]
local RS = game:GetService('ReplicatedStorage')
local Knit = require(RS.Packages.Knit)
local FarmsConfig = require(RS.Shared.List.Farms)

-- Helper: get effective cooldown (base - cooldown upgrades)
local function getEffectiveCooldown(farmConfig, farmData)
  local base = farmConfig.cooldown or 3600
  local reduction = 0
  local stage = farmData.stage or 0
  for i, upg in farmConfig.upgrades do
    if i > stage then break end
    if upg.upgrade == 'cooldown' then
      reduction = math.max(reduction, upg.amount or 0)
    end
  end
  return math.max(base - reduction, 60)
end

-- Helper: get item count
local function getItemCount(farmConfig, farmData)
  local base = farmConfig.items or 1
  local stage = farmData.stage or 0
  for i = #farmConfig.upgrades, 1, -1 do
    if i <= stage and farmConfig.upgrades[i].upgrade == 'moreItems' then
      return farmConfig.upgrades[i].amount
    end
  end
  return base
end

-- Helper: get farmer extra items
local function getFarmerCount(farmerData)
  if not farmerData then return 0 end
  local stage = farmerData.stage or 0
  local FarmerConfig = FarmsConfig.farmer
  if not FarmerConfig then return 0 end
  for i = #FarmerConfig.upgrades, 1, -1 do
    if i <= stage and FarmerConfig.upgrades[i].upgrade == 'farmerItems' then
      return FarmerConfig.upgrades[i].amount
    end
  end
  return 0
end

-- Helper: golden luck %
local function getGoldenLuck(farmConfig, farmData)
  local total = 0
  local stage = farmData.stage or 0
  for i, upg in farmConfig.upgrades do
    if i > stage then break end
    if upg.upgrade == 'goldenLuck' then
      total = math.max(total, upg.amount or 0)
    end
  end
  return total
end

-- Helper: double chance
local function getDoubleChance(farmConfig, farmData)
  local stage = farmData.stage or 0
  for i, upg in farmConfig.upgrades do
    if i > stage then break end
    if upg.upgrade == 'doubleItems' then return 10 end
  end
  return 0
end

-- Helper: resolve item from Items object (supports Items.fruit style objects)
local function resolveItem(itemObj)
  if not itemObj then return nil end
  local cat = type(itemObj.getClass)=='function' and itemObj:getClass() or itemObj.category
  local id  = type(itemObj.getName)=='function'  and itemObj:getName()  or itemObj.id
  return cat, id
end

local FarmService = Knit.CreateService({
  Name = 'FarmService',
  Client = {},
  _ds = nil,
  _inv = nil,
})

------------------------------------------------------------------------
-- Buy a farm
------------------------------------------------------------------------
function FarmService.Client:buy(player, farmId)
  if type(farmId) ~= 'string' then return 'invalid' end
  local farmConfig = FarmsConfig[farmId]
  if not farmConfig then return 'invalid' end
  if farmConfig.isNotFarm then return 'invalid' end

  local data = self.Server._ds:GetData(player)
  if not data then return 'noData' end
  if data.farms and data.farms[farmId] then return 'alreadyOwned' end

  local price = farmConfig.price or 1000
  if (data.gems or 0) < price then return 'notEnoughGems' end

  self.Server._ds:Set(player, {'gems'}, (data.gems or 0) - price)
  self.Server._ds:Set(player, {'farms', farmId}, {
    stage = 0,
    lastClaim = 0,
    itemsClaimed = 0,
  })
  print('[FarmService] Player', player.Name, 'bought farm:', farmId)
  return 'success'
end

------------------------------------------------------------------------
-- Claim a farm
------------------------------------------------------------------------
function FarmService.Client:claim(player, farmId)
  if type(farmId) ~= 'string' then return 'invalid' end
  local farmConfig = FarmsConfig[farmId]
  if not farmConfig or farmConfig.isNotFarm then return 'invalid' end

  local data = self.Server._ds:GetData(player)
  if not data then return 'noData' end
  local farmData = data.farms and data.farms[farmId]
  if not farmData then return 'notOwned' end

  local now = os.time()
  local lastClaim = farmData.lastClaim or 0
  local cooldown = getEffectiveCooldown(farmConfig, farmData)
  if now - lastClaim < cooldown then return 'onCooldown' end

  -- Calculate item count
  local itemCount = getItemCount(farmConfig, farmData)

  -- Add farmer bonus items (from farmer upgrades)
  local farmerData = data.farms and data.farms.farmer
  itemCount = itemCount + getFarmerCount(farmerData)

  -- insaneFarmer gamepass: double total farm output
  if data.passes and data.passes.insaneFarmer then
    itemCount = itemCount * 2
  end

  if getDoubleChance(farmConfig, farmData) > 0 and math.random(100) <= 10 then
    itemCount = itemCount * 2
  end

  -- Determine golden or normal
  local goldenLuck = getGoldenLuck(farmConfig, farmData)
  local isGolden = goldenLuck > 0 and math.random(100) <= goldenLuck
  local itemObj = isGolden and farmConfig.goldenItem or farmConfig.item

  -- Resolve category and id from Items object
  local cat, id = resolveItem(itemObj)
  if cat and id then
    for _ = 1, itemCount do
      self.Server._inv:GiveItem(player, {category = cat, id = id, amount = 1})
    end
  else
    warn('[FarmService] Could not resolve item for farm:', farmId)
  end

  -- Update state
  self.Server._ds:Set(player, {'farms', farmId, 'lastClaim'}, now)
  self.Server._ds:Set(player, {'farms', farmId, 'itemsClaimed'}, (farmData.itemsClaimed or 0) + itemCount)
  self.Server._ds:Set(player, {'stats', 'fruitsCollected'}, ((data.stats and data.stats.fruitsCollected or 0) + itemCount))
  local QuestService = Knit.GetService("QuestService")
  QuestService:IncrementQuest(player, "collectFruits", itemCount)

  return 'success'
end

------------------------------------------------------------------------
-- Upgrade a farm (works for both regular farms AND farmer)
------------------------------------------------------------------------
function FarmService.Client:upgrade(player, farmId)
  if type(farmId) ~= 'string' then return 'invalid' end
  local farmConfig = FarmsConfig[farmId]
  if not farmConfig then return 'invalid' end

  local data = self.Server._ds:GetData(player)
  if not data then return 'noData' end

  -- For farmer: auto-create entry if not exists (farmer is "bought" via upgrade)
  local farmData = data.farms and data.farms[farmId]
  if not farmData then
    if farmConfig.isNotFarm then
      -- Farmer: create entry on first upgrade purchase
      self.Server._ds:Set(player, {'farms', farmId}, {
        stage = 0,
        lastClaim = 0,
        itemsClaimed = 0,
      })
      farmData = { stage = 0, lastClaim = 0, itemsClaimed = 0 }
    else
      return 'notOwned'
    end
  end

  -- Next unowned upgrade
  local currentStage = farmData.stage or 0
  local nextUpgrade = farmConfig.upgrades and farmConfig.upgrades[currentStage + 1]
  if not nextUpgrade then return 'maxUpgrade' end

  local price = nextUpgrade.price or 0
  if (data.gems or 0) < price then return 'notEnoughGems' end

  self.Server._ds:Set(player, {'gems'}, (data.gems or 0) - price)
  self.Server._ds:Set(player, {'farms', farmId, 'stage'}, currentStage + 1)

  return 'success'
end

------------------------------------------------------------------------
-- Get farm info for UI
------------------------------------------------------------------------
function FarmService.Client:getInfo(player, farmId)
  if type(farmId) ~= 'string' then return nil end
  local farmConfig = FarmsConfig[farmId]
  if not farmConfig then return nil end

  local data = self.Server._ds:GetData(player)
  if not data then return nil end
  local farmData = data.farms and data.farms[farmId]

  return {
    owned     = farmData ~= nil,
    cooldown  = farmData and getEffectiveCooldown(farmConfig, farmData) or farmConfig.cooldown,
    items     = farmData and getItemCount(farmConfig, farmData) or farmConfig.items,
    lastClaim = farmData and farmData.lastClaim or 0,
  }
end

function FarmService:KnitInit()
  self._ds  = Knit.GetService('DataService')
  self._inv = Knit.GetService('InventoryService')
end

function FarmService:KnitStart()
  print('[FarmService] Started')
end

return FarmService