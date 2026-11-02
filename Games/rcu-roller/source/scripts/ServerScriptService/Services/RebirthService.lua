--[[ RebirthService - Handles player rebirths with multi-rebirth support ]]
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Knit = require(ReplicatedStorage.Packages.Knit)
local Variables = require(ReplicatedStorage.Shared.Variables)
local RebirthsList = require(ReplicatedStorage.Shared.List.Rebirths)

local RESET_FIELDS = {
  clicks = 0,
  trees = {},
  buildings = {},
  farms = {},
  quests = {},
  activeEffects = {},
}

local RebirthService = Knit.CreateService({
  Name = 'RebirthService',
  Client = {
    rebirthSuccess = Knit.CreateSignal(),
    rebirthFailed  = Knit.CreateSignal(),
    setIsAutoRebirthing = Knit.CreateSignal(),
  },
  _ds = nil,
})

------------------------------------------------------------------------
-- Cost calculation for multiple rebirths at once
-- cost = (basePrice + currentRebirths * priceMult) * count + priceMult * count*(count-1)/2
------------------------------------------------------------------------
function RebirthService:GetMultiRebirthCost(data, count)
  local currentRebirths = data.rebirths or 0
  local basePrice = Variables.rebirthPrice
  local priceMult = Variables.rebirthPriceMultiplier
  return (basePrice + currentRebirths * priceMult) * count + priceMult * (count * (count - 1) / 2)
end

------------------------------------------------------------------------
-- Server API: Rebirth with count support
------------------------------------------------------------------------
function RebirthService:Rebirth(player, rebirthIndex)
  local data = self._ds:GetData(player)
  if not data then return "error" end

  -- Look up count from index (default to 1)
  local count = 1
  if rebirthIndex and RebirthsList[rebirthIndex] then
    count = RebirthsList[rebirthIndex]
  end

  local cost = self:GetMultiRebirthCost(data, count)
  local balance = data.clicks or 0

  if balance < cost then
    self.Client.rebirthFailed:Fire(player, 'notEnoughClicks')
    return "notEnoughClicks"
  end

  local currentRebirths = data.rebirths or 0

  -- Calculate total gems for all rebirths
  local gemsEarned = 0
  for i = 0, count - 1 do
    gemsEarned = gemsEarned + Variables.gemsFromRebirth * (currentRebirths + i + 1)
  end

  -- VIP gamepass: +25% gems from rebirth
  if data.passes and data.passes.vip then
    gemsEarned = math.floor(gemsEarned * 1.25)
  end

  local replica = self._ds:GetReplica(player)
  if not replica then return "error" end

  -- Deduct clicks
  replica:Set({"clicks"}, balance - cost)

  -- Increment rebirth counter
  replica:Set({"rebirths"}, currentRebirths + count)

  -- Grant gems
  replica:Set({"gems"}, (data.gems or 0) + gemsEarned)

  -- Update day counter
  replica:Set({"day"}, (data.day or 0) + 1)

  -- Reset progression fields
  for field, value in RESET_FIELDS do
    if type(value) == "table" then
      replica:Set({field}, {})
    else
      replica:Set({field}, value)
    end
  end

  -- Maps stay permanently unlocked — only reset quest progress
  replica:Set({"mapQuests"}, {})

  self.Client.rebirthSuccess:Fire(player, currentRebirths + count, gemsEarned)

  -- Quest progress: rebirths — use TOTAL rebirths, not just this batch.
  -- mapQuests was just reset to {} above, so IncrementQuest starts from 0.
  -- We need the full cumulative count so the "Rebirth X times" quest tracks correctly.
  local totalRebirths = currentRebirths + count
  local QuestService = Knit.GetService("QuestService")
  QuestService:IncrementQuest(player, "rebirths", totalRebirths)
  return "success"
end

------------------------------------------------------------------------
-- Client RemoteFunction: rebirth(rebirthIndex)
------------------------------------------------------------------------
function RebirthService.Client:rebirth(player, rebirthIndex)
  return self.Server:Rebirth(player, rebirthIndex)
end

------------------------------------------------------------------------
-- Client: get current rebirth cost for a given index
------------------------------------------------------------------------
function RebirthService.Client:getRebirthCost(player, rebirthIndex)
  local data = self.Server._ds:GetData(player)
  if not data then return 0 end
  local count = 1
  if rebirthIndex and RebirthsList[rebirthIndex] then
    count = RebirthsList[rebirthIndex]
  end
  return self.Server:GetMultiRebirthCost(data, count)
end

------------------------------------------------------------------------
-- Knit lifecycle
------------------------------------------------------------------------
function RebirthService:KnitInit()
  self._ds = Knit.GetService('DataService')
  
  -- Handle auto-rebirth state toggle (signal, not RemoteFunction)
  self.Client.setIsAutoRebirthing:Connect(function(player, isAutoRebirthing, selectedAutoRebirth)
    local data = self._ds:GetData(player)
    if not data then return end
    self._ds:Set(player, {"isAutoRebirthing"}, isAutoRebirthing == true)
    if selectedAutoRebirth then
      self._ds:Set(player, {"selectedAutoRebirth"}, selectedAutoRebirth)
    end
  end)
end

function RebirthService:KnitStart()
  print('[RebirthService] Started')
end

return RebirthService
