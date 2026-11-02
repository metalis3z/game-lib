-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ServerScriptService/Source/Services/DailyRewardService.lua  (219 lines)
-- What it does: 7-day login calendar: state resolved lazily on read (claimable / countdown / streak broken after 2 days), config-driven reward types, payload for the UI, and a paid 'skip all days' product.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local LuckyBlockService = require(ServerScriptService.Source.Services.LuckyBlockService)
local PurchaseService = require(ServerScriptService.Source.Services.PurchaseService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local DailyRewardService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local DailyRemotes = Remotes:WaitForChild("DailyRewardService")
local ClaimRewardFunc = DailyRemotes:WaitForChild("ClaimReward")
local SkipAllFunc = DailyRemotes:WaitForChild("SkipAll")
local RequestDataFunc = DailyRemotes:WaitForChild("RequestData")
local DataUpdateEvent = DailyRemotes:WaitForChild("DataUpdate")
local PlayerDataUpdateEvent = Remotes:WaitForChild("PlayerDataService"):WaitForChild("DataUpdate")

local function getCfg()
	return GameConfig.DailyRewards or {}
end

local function secondsPerDay()
	return getCfg().SecondsPerDay or 86400
end

local function streakResetWindow()
	return getCfg().StreakResetSeconds or (2 * secondsPerDay())
end

-- Apply offline state changes lazily on read.
-- If more than StreakResetSeconds elapsed since the last claim, the streak is broken and the
-- player goes back to Day 1. Otherwise we just compute the remaining countdown.
local function resolveState(data)
	local now = os.time()
	local lastClaim = data.DailyRewardLastClaim or 0

	if lastClaim == 0 then
		data.DailyRewardDay = data.DailyRewardDay or 1
		data.DailyRewardStreak = data.DailyRewardStreak or 0
		return true, 0
	end

	local elapsed = now - lastClaim
	local perDay = secondsPerDay()

	if elapsed >= streakResetWindow() then
		data.DailyRewardStreak = 0
		data.DailyRewardDay = 1
		return true, 0
	end

	if elapsed >= perDay then
		return true, 0
	end

	return false, math.max(0, perDay - elapsed)
end

local function buildPayload(player)
	local data = PlayerDataService.GetPlayerData(player)
	if not data then return nil end

	local canClaim, secondsUntilNext = resolveState(data)

	return {
		CurrentDay = data.DailyRewardDay or 1,
		CanClaim = canClaim,
		SecondsUntilNext = secondsUntilNext,
		Streak = data.DailyRewardStreak or 0,
	}
end

local function grantReward(player, dayIndex)
	local cfg = getCfg().Days and getCfg().Days[dayIndex]
	if not cfg then
		warn(string.format("[DailyRewardService] no reward config for day %d", dayIndex))
		return false
	end

	local data = PlayerDataService.GetPlayerData(player)
	if not data then return false end

	if cfg.Type == "Cash" then
		PlayerDataService.AddStat(player, "Cash", cfg.Amount or 0)
		local LeaderboardService = require(ServerScriptService.Source.Services.LeaderboardService)
		pcall(function() LeaderboardService.AddTotalCash(player, cfg.Amount or 0) end)

	elseif cfg.Type == "LuckyBlock" then
		-- BlockId lets a day grant a specific block (e.g. "LegendaryLootBlock"
		-- = the in-hand click-open store block); default = the generic block
		LuckyBlockService.AddLuckyBlock(player, cfg.BlockId or "LuckyBlock", cfg.Amount or 1)

	elseif cfg.Type == "LootItem" then
		-- Claimed copy of an underground loot item -- same path the loot
		-- pedestals use, so the grant marks index discovery, hands the loot
		-- tool and shows the claim toast.
		local spawner = ServerScriptService:FindFirstChild("RarityItemSpawner")
		local grantFunc = spawner and spawner:FindFirstChild("GrantClaimedLoot")
		if not grantFunc then
			warn(string.format("[DailyRewardService] GrantClaimedLoot unavailable for day %d", dayIndex))
			return false
		end
		local granted = grantFunc:Invoke(player, cfg.ItemName)
		if not granted then
			warn(string.format("[DailyRewardService] failed to grant loot item %q", tostring(cfg.ItemName)))
			return false
		end

	elseif cfg.Type == "Brainrot" then
		if not data.BrainrotInventory then
			data.BrainrotInventory = {}
		end
		if not data.BrainrotUnlocked then
			data.BrainrotUnlocked = {}
		end

		local ts = os.time()
		local uniqueId = cfg.BrainrotId .. "_daily_" .. tostring(ts) .. "_" .. tostring(math.random(1000, 9999))
		data.BrainrotInventory[uniqueId] = {
			BrainrotId = cfg.BrainrotId,
			Timestamp = ts,
		}
		data.BrainrotUnlocked[cfg.BrainrotId] = true

		PlayerDataService.DataChanged:Fire(player, "BrainrotInventory", data.BrainrotInventory)
		PlayerDataService.DataChanged:Fire(player, "BrainrotUnlocked", data.BrainrotUnlocked)
		PlayerDataUpdateEvent:FireClient(player, "BrainrotUnlocked", data.BrainrotUnlocked)
	end

	return true
end

local function advanceDay(data)
	data.DailyRewardLastClaim = os.time()
	data.DailyRewardStreak = (data.DailyRewardStreak or 0) + 1
	if (data.DailyRewardDay or 1) >= 7 then
		data.DailyRewardDay = 1
	else
		data.DailyRewardDay = (data.DailyRewardDay or 1) + 1
	end
end

local function onClaimReward(player)
	local data = PlayerDataService.GetPlayerData(player)
	if not data then return false end

	local canClaim = resolveState(data)
	if not canClaim then return false end

	local dayIndex = data.DailyRewardDay or 1
	local success = grantReward(player, dayIndex)
	if not success then return false end

	advanceDay(data)

	local payload = buildPayload(player)
	if payload then
		DataUpdateEvent:FireClient(player, payload)
	end

	return true
end

local function onSkipAll(player)
	local data = PlayerDataService.GetPlayerData(player)
	if not data then return false end

	local productId = GameConfig.DailyRewards.SkipAllProductId
	if not productId or productId == 0 then
		warn(string.format("[DailyRewardService] SkipAllProductId not configured for %s", player.Name))
		return false
	end

	PurchaseService.PromptProduct(player, productId, "DailyRewardSkipAll", function(purchaseSuccess)
		if not purchaseSuccess then return end

		local freshData = PlayerDataService.GetPlayerData(player)
		if not freshData then return end

		local startDay = freshData.DailyRewardDay or 1
		for i = startDay, 7 do
			grantReward(player, i)
		end

		freshData.DailyRewardStreak = (freshData.DailyRewardStreak or 0) + (7 - startDay + 1)
		freshData.DailyRewardDay = 1
		freshData.DailyRewardLastClaim = os.time()

		local payload = buildPayload(player)
		if payload then
			DataUpdateEvent:FireClient(player, payload)
		end
	end)

	return true
end

local function onRequestData(player)
	return buildPayload(player)
end

function DailyRewardService.Init()
	ClaimRewardFunc.OnServerInvoke = onClaimReward
	SkipAllFunc.OnServerInvoke = onSkipAll
	RequestDataFunc.OnServerInvoke = onRequestData

	PlayerDataService.ProfileLoaded.Event:Connect(function(player, _data)
		task.defer(function()
			local payload = buildPayload(player)
			if payload then
				DataUpdateEvent:FireClient(player, payload)
			end
		end)
	end)
end

return DailyRewardService
