-- Reference copy for study. Game: RCU (roll / mounts) (rcu-roller)
-- Original: ServerScriptService/Services/RewardService.lua  (337 lines)
-- What it does: Timed chests with cooldowns and weighted loot, one-time mini chests, playtime milestones checked against session time, tiered achievements (category+tier keys), ticket shop and a weighted wheel.

--[[ RewardService — Handles chest claims, mini chest claims, playtime rewards,
     daily rewards, achievements, ancient shop, ancient wheel, RCX rewards,
     and light switch activation ]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local Chests = require(ReplicatedStorage.Shared.List.Chests)
local MiniChests = require(ReplicatedStorage.Shared.List.MiniChests)
local PlaytimeRewards = require(ReplicatedStorage.Shared.List.PlaytimeRewards)
local DailyRewards = require(ReplicatedStorage.Shared.List.DailyRewards)
local Achievements = require(ReplicatedStorage.Shared.List.Achievements)
local AncientWheel = require(ReplicatedStorage.Shared.List.AncientWheel)
local AncientShop = require(ReplicatedStorage.Shared.List.AncientShop)

local RewardService = Knit.CreateService({
	Name = "RewardService",
	Client = {
		activateLightSwitch = Knit.CreateSignal(),
	},
})

local DataService
local InventoryService

------------------------------------------------------------------------
-- Weighted random pick from a {item, chance} table
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
-- Weighted random pick from AncientWheel dict {key={chance,item,rotation}}
------------------------------------------------------------------------
local function rollAncientWheel()
	local totalWeight = 0
	local entries = {}
	for key, entry in AncientWheel do
		totalWeight += entry.chance
		entries[#entries + 1] = {key = key, chance = entry.chance, item = entry.item}
	end
	local roll = math.random() * totalWeight
	local cumulative = 0
	for _, entry in entries do
		cumulative += entry.chance
		if roll <= cumulative then
			return entry.key, entry.item
		end
	end
	return entries[1].key, entries[1].item
end

------------------------------------------------------------------------
-- Find MiniChest config by name
------------------------------------------------------------------------
local function findMiniChestConfig(chestName)
	for _, group in MiniChests do
		for _, name in group.names do
			if name == chestName then
				return group
			end
		end
	end
	return nil
end

------------------------------------------------------------------------
-- Chest claims
------------------------------------------------------------------------

function RewardService.Client:claimChest(player, chestId)
	local data = DataService:GetData(player)
	if not data then return "fail" end

	local config = Chests[chestId]
	if not config then return "fail" end

	if data.chests[chestId] then
		if os.time() - data.chests[chestId] < config.cooldown then
			return "fail"
		end
	end

	local rewards = rollWeighted(config.rewards, config.rewardAmount or 3)
	for _, item in rewards do
		InventoryService:GiveReward(player, item)
	end

	DataService:Set(player, {"chests", chestId}, os.time())
	return "success"
end

function RewardService.Client:claimMiniChest(player, miniChestId, miniChestName)
	local data = DataService:GetData(player)
	if not data then return "fail" end

	if data.miniChests[miniChestName] then return "fail" end

	local config = findMiniChestConfig(miniChestName)
	if not config then return "fail" end

	if config.requiredMap and not data.maps[config.requiredMap] then
		return "fail"
	end

	local rewardItems = {}
	for _, item in config.rewards do
		InventoryService:GiveReward(player, item)
		rewardItems[#rewardItems + 1] = {
			cl = item:getClass(),
			nm = item:getName(),
			am = item:getAmount(),
		}
	end

	DataService:Set(player, {"miniChests", miniChestName}, true)
	return "success", rewardItems
end

------------------------------------------------------------------------
-- Playtime rewards
------------------------------------------------------------------------

function RewardService.Client:claimPlaytimeReward(player, rewardIndex)
	local data = DataService:GetData(player)
	if not data then return "fail" end

	if table.find(data.claimedPlaytimeRewards, rewardIndex) then return "fail" end

	local milestone = PlaytimeRewards[rewardIndex]
	if not milestone then return "fail" end

	-- Check session time meets requirement
	if (data.sessionTime or 0) < milestone.required then return "fail" end

	-- Roll and give rewards
	local rewards = rollWeighted(milestone.rewards, milestone.rewardAmount or 1)
	for _, item in rewards do
		InventoryService:GiveReward(player, item)
	end

	-- Mark claimed
	local claimed = data.claimedPlaytimeRewards or {}
	claimed[#claimed + 1] = rewardIndex
	DataService:Set(player, {"claimedPlaytimeRewards"}, claimed)

	-- Increment stat
	DataService:Set(player, {"stats", "playtimeRewards"}, (data.stats.playtimeRewards or 0) + 1)

	return "success"
end

------------------------------------------------------------------------
-- Daily rewards
------------------------------------------------------------------------

function RewardService.Client:claimDailyReward(player)
	local data = DataService:GetData(player)
	if not data then return "fail" end

	-- Determine which day reward to give (1-indexed, loops after 21)
	local day = (data.day or 0) + 1
	local rewardDay = ((day - 1) % #DailyRewards) + 1

	local item = DailyRewards[rewardDay]
	if item then
		InventoryService:GiveReward(player, item)
	end

	DataService:Set(player, {"day"}, day)
	DataService:Set(player, {"dayReset"}, os.time())

	return "success"
end

------------------------------------------------------------------------
-- Achievements
------------------------------------------------------------------------

function RewardService.Client:claimAchievement(player, achievementKey)
	local data = DataService:GetData(player)
	if not data then return "fail" end

	if data.claimedAchievements[achievementKey] then return "fail" end

	-- Find achievement category and tier from key (format: "categoryN" e.g. "rebirths3", "rebirths12")
	-- BUG FIX: Original pattern "^(.+)(%d+)$" is greedy — for "rebirths12" it captures
	-- category="rebirths1", tier=2 instead of category="rebirths", tier=12.
	-- All category names are purely alphabetical (camelCase, no digits), so use [%a]+ to
	-- match the full alphabetical prefix, leaving all trailing digits for the tier index.
	local category, tierStr = achievementKey:match("^([%a]+)(%d+)$")
	local tierIndex = tonumber(tierStr)

	if not category or not tierIndex then return "fail" end

	local achDef = Achievements[category]
	if not achDef then return "fail" end

	local tier = achDef.list[tierIndex]
	if not tier then return "fail" end

	-- Check player has reached the threshold
	local currentValue = achDef.getValue(data)
	if currentValue < tier.amount then return "fail" end

	-- Give all rewards for this tier
	for _, item in tier.rewards do
		InventoryService:GiveReward(player, item)
	end

	DataService:Set(player, {"claimedAchievements", achievementKey}, true)
	return "success"
end

------------------------------------------------------------------------
-- Ancient Shop
------------------------------------------------------------------------

function RewardService.Client:buyAncientShop(player, itemKey)
	local data = DataService:GetData(player)
	if not data then return "fail" end

	local cost = AncientShop[itemKey]
	if not cost then return "fail" end

	-- Check if already purchased (for one-time unlocks)
	if data.ancientShop and data.ancientShop[itemKey] then return "fail" end

	-- Check ancient tickets
	local tickets = InventoryService:GetItemAmount(player, 'exclusive', 'ancientTicket')
	if tickets < cost then return "fail" end

	-- Deduct tickets
	InventoryService:RemoveItem(player, 'exclusive', 'ancientTicket', cost)

	-- Mark purchased
	DataService:Set(player, {"ancientShop", itemKey}, true)

	return "success"
end

------------------------------------------------------------------------
-- Ancient Wheel
------------------------------------------------------------------------

function RewardService.Client:ancientWheelSpin(player)
	local data = DataService:GetData(player)
	if not data then return "fail" end

	-- Deduct an ancient ticket
	local tickets = InventoryService:GetItemAmount(player, 'exclusive', 'ancientTicket')
	if tickets < 1 then return "fail" end

	InventoryService:RemoveItem(player, 'exclusive', 'ancientTicket', 1)

	-- Weighted roll
	local slotKey, item = rollAncientWheel()

	-- Give the item
	InventoryService:GiveReward(player, item)

	-- Track stat
	DataService:Set(player, {"stats", "ancientWheelSpins"}, (data.stats.ancientWheelSpins or 0) + 1)

	return "success", slotKey
end

------------------------------------------------------------------------
-- RCX Rewards
------------------------------------------------------------------------

function RewardService.Client:claimRCXReward(player)
	local data = DataService:GetData(player)
	if not data then return "fail" end

	if data.hasClaimedRCXTier then return "fail" end
	if (data.rcxTier or 0) == 0 then return "fail" end

	local ok, RCXTiers = pcall(require, ReplicatedStorage.Shared.List.RCXTiers)
	if not ok or not RCXTiers then return "fail" end

	local tierData = RCXTiers[data.rcxTier]
	if not tierData or not tierData.rewards then return "fail" end

	for _, item in tierData.rewards do
		InventoryService:GiveReward(player, item)
	end

	DataService:Set(player, {"hasClaimedRCXTier"}, true)
	return "success"
end

------------------------------------------------------------------------
-- Light switch
------------------------------------------------------------------------

function RewardService:_handleLightSwitch(player, lightSwitchId)
	local data = DataService:GetData(player)
	if not data then return end
	if data.lightSwitches[lightSwitchId] then return end
	DataService:Set(player, {"lightSwitches", lightSwitchId}, true)
end

------------------------------------------------------------------------
-- Lifecycle
------------------------------------------------------------------------

function RewardService:KnitInit()
	DataService = Knit.GetService("DataService")
	InventoryService = Knit.GetService("InventoryService")
end

function RewardService:KnitStart()
	self.Client.activateLightSwitch:Connect(function(player, lightSwitchId)
		self:_handleLightSwitch(player, lightSwitchId)
	end)
	print("[RewardService] Started")
end

return RewardService
