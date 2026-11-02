local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local PlotService = require(ServerScriptService.Source.Services.PlotService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local RebirthService = require(ServerScriptService.Source.Services.RebirthService)
local LeaderboardService = require(ServerScriptService.Source.Services.LeaderboardService)
local MutationService = require(ServerScriptService.Source.Services.MutationService)
local CashBoostService = require(ServerScriptService.Source.Services.CashBoostService)
local LuckyBlockService = require(ServerScriptService.Source.Services.LuckyBlockService)

local PodiumService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local PodiumRemotes = Remotes:WaitForChild("PodiumService")
local PlaceBrainrotFunc = PodiumRemotes:WaitForChild("PlaceBrainrot")
local RemoveBrainrotFunc = PodiumRemotes:WaitForChild("RemoveBrainrot")
local SwapBrainrotFunc = PodiumRemotes:WaitForChild("SwapBrainrot")
local EquipBestFunc = PodiumRemotes:FindFirstChild("EquipBest")
if not EquipBestFunc then
	EquipBestFunc = Instance.new("RemoteFunction")
	EquipBestFunc.Name = "EquipBest"
	EquipBestFunc.Parent = PodiumRemotes
end
local UpgradeBrainrotFunc = PodiumRemotes:WaitForChild("UpgradeBrainrot")
local CollectCashFunc = PodiumRemotes:WaitForChild("CollectCash")
local RequestPodiumDataFunc = PodiumRemotes:WaitForChild("RequestPodiumData")
local PodiumUpdateEvent = PodiumRemotes:WaitForChild("PodiumUpdate")
local CashAccumulateEvent = PodiumRemotes:WaitForChild("CashAccumulateUpdate")
local RequestAllPlotsDataFunc = PodiumRemotes:WaitForChild("RequestAllPlotsData")
local CollectOfflineCashFunc = PodiumRemotes:WaitForChild("CollectOfflineCash")
local OfflineCashEvent = PodiumRemotes:WaitForChild("OfflineCashUpdate")
-- Created lazily in Init() so the remote is guaranteed to exist even if a
-- fresh place doesn't yet have it placed under PodiumRemotes.
local OfflineRewardReadyEvent
local NotEnoughCashEvent = Remotes:WaitForChild("NotEnoughCash")

-- Steal feature. StealBrainrot is the action; StealNotification is the
-- thief-side toast hook (created lazily so older snapshots without it still
-- boot). RequestStealInfo is a stub for future use -- the client currently
-- reads display name straight off the cached visual payload it already has.
local StealBrainrotFunc = PodiumRemotes:WaitForChild("StealBrainrot")
local RequestStealInfoFunc = PodiumRemotes:FindFirstChild("RequestStealInfo")
local StealNotificationEvent = PodiumRemotes:FindFirstChild("StealNotification")
if not StealNotificationEvent then
	StealNotificationEvent = Instance.new("RemoteEvent")
	StealNotificationEvent.Name = "StealNotification"
	StealNotificationEvent.Parent = PodiumRemotes
end

-- PlayerDataService.DataChanged is a server-only BindableEvent. The client's
-- IslandBrainrotClient.syncLuckyBlockSlotsFromInventory listens to the
-- DataUpdate RemoteEvent on PlayerDataService -- so when we mutate Inventory
-- here (lucky-block place / remove paths) we have to fire that remote too,
-- otherwise the hotbar slot for the placed lucky block stays visible with
-- the old count.
local PlayerDataRemotes = Remotes:WaitForChild("PlayerDataService")
local DataUpdateEvent = PlayerDataRemotes:WaitForChild("DataUpdate")

-- Placed-lucky-block open invoke. Created lazily so existing deployments without
-- the remote don't break Init; client mirrors the lookup with WaitForChild.
local OpenPlacedLuckyBlockFunc = PodiumRemotes:FindFirstChild("OpenPlacedLuckyBlock")
if not OpenPlacedLuckyBlockFunc then
	OpenPlacedLuckyBlockFunc = Instance.new("RemoteFunction")
	OpenPlacedLuckyBlockFunc.Name = "OpenPlacedLuckyBlock"
	OpenPlacedLuckyBlockFunc.Parent = PodiumRemotes
end

local PLOTS_FOLDER = Workspace:WaitForChild("Assets"):WaitForChild("Plots")

local accumulatedCash = {}
local offlineCashPending = {}
-- [player] = offline strength computed from their offline time; shown by the
-- Earnings popup and claimed by the same Claim as the cash
-- (see onCollectAllOfflineCash).
local offlineStrengthPending = {}
-- [player] = offline cash the AutoCollect gamepass already credited at join.
-- The Earnings popup still SHOWS it (the player did earn it offline); the
-- Claim just doesn't grant it a second time.
local offlineCashAutoCredited = {}
-- Flat offline cash from the player's own measured earning pace (see
-- GameConfig.OfflineCash): the podium path can't pay in this map (no plots
-- in Workspace.Assets.Plots), so this is what the popup's money row shows.
local offlineFlatCashPending = {}
-- [player] = { totalCash = TotalCash at load, clock = os.clock() at load };
-- turned into playerData.OfflineCashRate on leave.
local sessionEarnStart = {}
-- [thief] = os.clock() of last successful steal. Used as a per-player
-- spam guard so a click-spamming player can't drain a pad on the same
-- frame the server fires PodiumUpdate, before victims/observers see it.
local stealCooldowns = {}
local STEAL_COOLDOWN_SECONDS = 0.5

local TICK_INTERVAL = 1.0
local tickTimer = 0
local AUTO_COLLECT_INTERVAL = 2.0
local autoCollectElapsed = {}

local UPGRADE_COST_EXPONENT = 1.65
local UPGRADE_CASH_MULTIPLIER = 1.5
local BASE_COST_FACTOR = 1.5

local CPS_BONUS_PERCENT = 0.5
-- Cost mult re-tuned for MAX_BRAINROT_LEVEL = 100. 1.18^99 ~= 4.5M, which on
-- a Mythic ($1400 base) would put the final upgrade at ~$6.3B -- unspendable.
-- 1.09^99 ~= 4400, so the final upgrade on a Mythic costs ~$6.2M, full max
-- for one slot ~$70M; 30 podiums = ~$2.1B total -- a big but reachable
-- endgame sink that takes well into the long tail to cap every slot.
local COST_MULTIPLIER = 1.09
-- Cap brainrot per-instance levels at 100 (was 50). Level 100 = baseCps * 50.5
-- (1 + 0.5*99), so a fully-leveled Exclusive brainrot pulls 252.5K cps,
-- multiplied by the +25% Prismatic mutation = ~316K cps -- the headline
-- per-slot income the long endgame revolves around.
local MAX_BRAINROT_LEVEL = 100

local function getBestOwnedCps(playerData)
	local best = 0
	for _, entry in pairs(playerData.BrainrotInventory or {}) do
		local cfg = GameConfig.Items[entry.BrainrotId]
		if cfg and not cfg.IsPercentBrainrot then
			local cps = cfg.CashPerSec or 0
			if cps > best then best = cps end
		end
	end
	for _, entry in pairs(playerData.PlacedBrainrot or {}) do
		local cfg = GameConfig.Items[entry.BrainrotId]
		if cfg and not cfg.IsPercentBrainrot then
			local base = cfg.CashPerSec or 0
			local level = entry.Level or 1
			local cps = level > 1 and (base + base * CPS_BONUS_PERCENT * (level - 1)) or base
			if cps > best then best = cps end
		end
	end
	return best
end

local function getBaseCashPerSec(brainrotId, mutation, bestCps)
	local cfg = GameConfig.Items[brainrotId]
	if not cfg then return 1 end
	local baseCps
	if cfg.IsPercentBrainrot then
		baseCps = cfg.PercentBoost * (bestCps or 0)
	else
		baseCps = cfg.CashPerSec or 1
	end
	if mutation and MutationService.IsValidMutation(mutation) then
		return baseCps * MutationService.GetCashBoost(mutation)
	end
	return baseCps
end

-- Piecewise growth curve (user-tuned for clear progression breakpoints):
--   L 2-10:  +20% per level  -- gentle start, the first 9 upgrades are
--                              affordable from base pad income alone.
--   L 11-20: +40% per level  -- mid-game ramp; doubling roughly every 2 levels.
--   L 21+:   +70% per level  -- aggressive late game; near-doubling per level,
--                              so high-tier upgrades demand a real cash sink.
-- The fixed COST_MULTIPLIER constant above is intentionally retained as the
-- legacy single-rate value for any external reference; the live curve below
-- is the source of truth.
local COST_MULT_EARLY = 1.20
local COST_MULT_MID   = 1.40
local COST_MULT_LATE  = 1.70

local function getUpgradeCost(brainrotId, currentLevel, mutation)
	local base = getBaseCashPerSec(brainrotId, mutation, 0)
	local targetLevel = currentLevel + 1

	if targetLevel <= 1 then return 0 end

	local cost
	if targetLevel <= 10 then
		cost = base * (COST_MULT_EARLY ^ (targetLevel - 1))
	elseif targetLevel <= 20 then
		local pivotL10 = base * (COST_MULT_EARLY ^ 9)
		cost = pivotL10 * (COST_MULT_MID ^ (targetLevel - 10))
	else
		local pivotL10 = base * (COST_MULT_EARLY ^ 9)
		local pivotL20 = pivotL10 * (COST_MULT_MID ^ 10)
		cost = pivotL20 * (COST_MULT_LATE ^ (targetLevel - 20))
	end

	return math.floor(cost)
end

local function getCashPerSec(baseCashPerSec, level)
	if level <= 1 then return baseCashPerSec end

	local levelIndex = level - 1

	return baseCashPerSec + (baseCashPerSec * CPS_BONUS_PERCENT * levelIndex)
end

local function calcBaseIncomePerSec(playerData)
	if not playerData or not playerData.PlacedBrainrot then return 0 end
	local best = getBestOwnedCps(playerData)
	local total = 0
	for _, entry in pairs(playerData.PlacedBrainrot) do
		local baseCps = getBaseCashPerSec(entry.BrainrotId, entry.Mutation, best)
		total = total + getCashPerSec(baseCps, entry.Level or 1)
	end
	return total
end

local OFFLINE_DEFAULT_MAX_SECONDS = 12 * 60 * 60
-- Offline earnings = 1/6 of the live online rate per user request "6x less".
-- Override per-place by setting GameConfig.OfflineCash.IncomeRate.
local OFFLINE_DEFAULT_INCOME_RATE = 1 / 6

local function calcOfflineCash(player, playerData)
	local lastLogin = playerData.LastLogin or 0
	if lastLogin <= 0 then return nil end

	local now = os.time()
	local offlineSeconds = now - lastLogin
	if offlineSeconds <= 60 then return nil end

	local offlineCfg = GameConfig.OfflineCash or {}
	local maxSeconds = offlineCfg.MaxOfflineSeconds or OFFLINE_DEFAULT_MAX_SECONDS
	offlineSeconds = math.min(offlineSeconds, maxSeconds)

	local rebirthMult = RebirthService.GetCashMultiplier(player)
	local boostMult = CashBoostService.GetMultiplier(player)
	local offlineRate = offlineCfg.IncomeRate or OFFLINE_DEFAULT_INCOME_RATE

	-- x5Offline gamepass: bonus multiplier applied only to offline accumulation.
	local offlinePassMult = 1
	local x5cfg = GameConfig.Shop and GameConfig.Shop.Passes and GameConfig.Shop.Passes.x5Offline
	if x5cfg and x5cfg.OfflineMultiplier and player:GetAttribute("OwnsGamepass_x5Offline") then
		offlinePassMult = x5cfg.OfflineMultiplier
	end

	local placed = playerData.PlacedBrainrot
	if not placed then return nil end

	local result = {}
	local hasAny = false
	local best = getBestOwnedCps(playerData)

	for key, entry in pairs(placed) do
		local podiumIndex = tonumber(key)
		if not podiumIndex then continue end

		local baseCps = getBaseCashPerSec(entry.BrainrotId, entry.Mutation, best)
		local cps = getCashPerSec(baseCps, entry.Level or 1)
		local amount = math.floor(cps * offlineSeconds * rebirthMult * boostMult * offlineRate * offlinePassMult)

		if amount > 0 then
			result[podiumIndex] = amount
			hasAny = true
		end
	end

	if not hasAny then return nil end
	return result
end

-- Offline strength for the Earnings popup: the player is treated as clicking
-- GameConfig.OfflineStrength.ClicksPerSecond times per second at their live
-- per-click value (same formula as StrengthClickServer: (1 + drill Power) *
-- trail boost * rebirth multiplier * x2 pass). Reads the mirrored attributes,
-- so it must run a beat AFTER ProfileLoaded (see the task.delay in Init).
local function calcOfflineStrength(player, offlineSeconds)
	local cfg = GameConfig.OfflineStrength or {}
	if offlineSeconds < (cfg.MinOfflineSeconds or 10) then return 0 end
	local clicksPerSec = cfg.ClicksPerSecond or 1
	local maxSeconds = cfg.MaxOfflineSeconds or OFFLINE_DEFAULT_MAX_SECONDS
	offlineSeconds = math.min(offlineSeconds, maxSeconds)

	local perClick = (1 + math.max(tonumber(player:GetAttribute("DrillPower")) or 0, 0))
		* math.max(tonumber(player:GetAttribute("TrailBoost")) or 1, 1)
		* math.max(tonumber(player:GetAttribute("StrengthMultiplier")) or 1, 1)
		* math.max(tonumber(player:GetAttribute("StrengthLadderMult")) or 1, 1)

	local offlinePassMult = 1
	local x5cfg = GameConfig.Shop and GameConfig.Shop.Passes and GameConfig.Shop.Passes.x5Offline
	if x5cfg and x5cfg.OfflineMultiplier and player:GetAttribute("OwnsGamepass_x5Offline") then
		offlinePassMult = x5cfg.OfflineMultiplier
	end

	return math.floor(perClick * clicksPerSec * offlineSeconds * offlinePassMult)
end

-- Flat offline cash: the player's measured earning pace (OfflineCashRate,
-- saved on leave from the session's TotalCash delta) * offline time *
-- RateFraction. The x5Offline gamepass multiplies it like podium cash.
local function calcOfflineFlatCash(player, playerData, offlineSeconds)
	local cfg = GameConfig.OfflineCash or {}
	if offlineSeconds < (cfg.MinOfflineSeconds or 10) then return 0 end
	local rate = tonumber(playerData.OfflineCashRate) or 0
	if rate <= 0 then
		-- No session-measured rate yet (fresh profile, or every prior session
		-- was too short to save one). Fall back to the LIFETIME average earning
		-- pace -- available on any profile that has earned cash and logged
		-- playtime, so the money row works on the very first rejoin. The
		-- MinSessionSeconds floor keeps a tiny playtime from spiking the rate.
		local totalCash = tonumber(playerData.TotalCash) or 0
		local playtime = math.max(tonumber(playerData.TotalPlaytime) or 0, cfg.MinSessionSeconds or 120)
		if totalCash > 0 then
			rate = totalCash / playtime
		end
	end
	if rate <= 0 then return 0 end
	local maxSeconds = cfg.MaxOfflineSeconds or OFFLINE_DEFAULT_MAX_SECONDS
	offlineSeconds = math.min(offlineSeconds, maxSeconds)

	local offlinePassMult = 1
	local x5cfg = GameConfig.Shop and GameConfig.Shop.Passes and GameConfig.Shop.Passes.x5Offline
	if x5cfg and x5cfg.OfflineMultiplier and player:GetAttribute("OwnsGamepass_x5Offline") then
		offlinePassMult = x5cfg.OfflineMultiplier
	end

	return math.floor(rate * offlineSeconds * (cfg.RateFraction or 1 / 100) * offlinePassMult)
end

local function getMaxPodiumIndex(plot)
	local max = 0
	local podiumsModel = plot:FindFirstChild("Podiums")
	local searchRoot = podiumsModel or plot
	for _, child in ipairs(searchRoot:GetChildren()) do
		local idx = tonumber(child.Name:match("^Podium(%d+)$"))
		if idx and idx > max then max = idx end
	end
	return max
end

local function podiumExists(plot, index)
	local podiumsModel = plot:FindFirstChild("Podiums")
	if podiumsModel and podiumsModel:FindFirstChild("Podium" .. index) then
		return true
	end
	return plot:FindFirstChild("Podium" .. index) ~= nil
end

local function getPlotForPlayer(player)
	return PlotService.GetPlot(player)
end

local function getPlayerData(player)
	return PlayerDataService.GetPlayerData(player)
end

local function getPlayerByUserId(userId)
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.UserId == userId then return plr end
	end
	return nil
end

local function getPlacedBrainrots(player)
	local data = getPlayerData(player)
	if not data then return {} end
	return data.PlacedBrainrot or {}
end

local function setPlacedBrainrot(player, podiumIndex, data)
	local playerData = getPlayerData(player)
	if not playerData then return false end
	if not playerData.PlacedBrainrot then
		playerData.PlacedBrainrot = {}
	end
	playerData.PlacedBrainrot[tostring(podiumIndex)] = data
	PlayerDataService.DataChanged:Fire(player, "PlacedBrainrot", playerData.PlacedBrainrot)
	PlayerDataService.ScheduleSave(player)
	return true
end

local function pushInventoryUpdate(player)
	local playerData = getPlayerData(player)
	if not playerData then return end
	PlayerDataService.SetStat(player, "BrainrotInventory", playerData.BrainrotInventory or {})
end

local function returnBrainrotToInventory(playerData, entry)
	if not playerData.BrainrotInventory then
		playerData.BrainrotInventory = {}
	end
	playerData.BrainrotInventory[entry.UniqueId] = {
		BrainrotId = entry.BrainrotId,
		Timestamp = os.time(),
		Level = entry.Level or 1,
		Mutation = entry.Mutation,
	}
end

local function validateEquippedBrainrot(playerData)
	local equippedItem = playerData.EquippedItem or ""
	if equippedItem == "" then return nil, nil, nil end

	local brainrotInv = playerData.BrainrotInventory or {}
	local brainrotEntry = brainrotInv[equippedItem]
	if not brainrotEntry then return nil, nil, nil end

	local brainrotId = brainrotEntry.BrainrotId
	if not GameConfig.Items[brainrotId] then return nil, nil, nil end

	return equippedItem, brainrotEntry, brainrotId
end

local function validateEquippedLuckyBlock(playerData)
	local equippedItem = playerData.EquippedItem or ""
	if equippedItem == "" then return nil end
	local cfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[equippedItem]
	if not cfg then return nil end
	-- Store loot blocks open IN-HAND (LootBlockService) and loot items are
	-- trophies -- neither may be placed on a pad.
	if cfg.IsLootBlock or cfg.IsLootItem then return nil end
	local inv = playerData.Inventory or {}
	if (inv[equippedItem] or 0) <= 0 then return nil end
	return equippedItem
end


local function buildPodiumPayload(player, podiumIndex)
	local placed = getPlacedBrainrots(player)
	local entry = placed[tostring(podiumIndex)]
	if not entry then return nil end
	if entry.BrainrotId then
		print(string.format("[DBG_UPGRADE] SERVER buildPodiumPayload pod=%d brainrotId=%s entry.Level=%s", podiumIndex, tostring(entry.BrainrotId), tostring(entry.Level)))
	end

	-- Lucky-block payload: pads can hold a lucky block whose only mechanic is the
	-- rarity-scaled open timer. No CashPerSec, no leveling, no mutation. Client
	-- branches on ItemType="LuckyBlock".
	if entry.LuckyBlockId then
		local lbCfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[entry.LuckyBlockId]
		if not lbCfg then return nil end
		return {
			PodiumIndex = podiumIndex,
			ItemType = "LuckyBlock",
			LuckyBlockId = entry.LuckyBlockId,
			DisplayName = lbCfg.DisplayName or entry.LuckyBlockId,
			ModelName = lbCfg.ModelName or entry.LuckyBlockId,
			Rarity = lbCfg.Rarity or "Common",
			OpenAt = entry.OpenAt or 0,
			PlacedAt = entry.PlacedAt or 0,
			OwnerUserId = player.UserId,
		}
	end

	local brainrotCfg = GameConfig.Items[entry.BrainrotId]
	if not brainrotCfg then return nil end

	local level = entry.Level or 1
	local mutation = entry.Mutation
	local playerData = getPlayerData(player)
	local bestCps = playerData and getBestOwnedCps(playerData) or 0
	local baseCps = getBaseCashPerSec(entry.BrainrotId, mutation, bestCps)

	local accumulated = 0
	if accumulatedCash[player] then
		accumulated = accumulatedCash[player][podiumIndex] or 0
	end

	local displayName = brainrotCfg.DisplayName or entry.BrainrotId
	local modelName = brainrotCfg.ModelName or entry.BrainrotId
	if mutation and MutationService.IsValidMutation(mutation) then
		displayName = MutationService.GetDisplayName(mutation) .. " " .. displayName
		modelName = MutationService.GetModelName(mutation, entry.BrainrotId) or modelName
	end

	return {
		PodiumIndex = podiumIndex,
		UniqueId = entry.UniqueId,
		BrainrotId = entry.BrainrotId,
		Level = level,
		CashPerSec = getCashPerSec(baseCps, level),
		NextCashPerSec = getCashPerSec(baseCps, level + 1),
		-- nil cost = max level reached (client renders "MAX" instead of a price).
		UpgradeCost = (level >= MAX_BRAINROT_LEVEL) and nil or getUpgradeCost(entry.BrainrotId, level, mutation),
		MaxLevel = MAX_BRAINROT_LEVEL,
		DisplayName = displayName,
		ModelName = modelName,
		Rarity = GameConfig.GetItemRarity(entry.BrainrotId),
		AnimationId = brainrotCfg.AnimationId or "",
		AccumulatedCash = accumulated,
		OwnerUserId = player.UserId,
		Mutation = mutation,
	}
end

local function buildVisualPayload(player, podiumIndex)
	local placed = getPlacedBrainrots(player)
	local entry = placed[tostring(podiumIndex)]
	if not entry then return nil end

	-- Mirror the lucky-block branch from buildPodiumPayload so non-owner
	-- viewers also receive a payload when a pad holds a lucky block. Without
	-- this branch entry.BrainrotId is nil, GameConfig.Items[nil] is nil, and
	-- the function returned nil for everyone except the pad's owner -- which
	-- is why placed lucky blocks were only visible client-side to whoever
	-- placed them. OpenAt is included so the rarity-scaled countdown billboard
	-- renders consistently across all viewers (the open prompt itself is still
	-- gated to the owner on the client side, in PodiumController.ensurePrompt).
	if entry.LuckyBlockId then
		local lbCfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[entry.LuckyBlockId]
		if not lbCfg then return nil end
		return {
			PodiumIndex = podiumIndex,
			ItemType = "LuckyBlock",
			LuckyBlockId = entry.LuckyBlockId,
			DisplayName = lbCfg.DisplayName or entry.LuckyBlockId,
			ModelName = lbCfg.ModelName or entry.LuckyBlockId,
			Rarity = lbCfg.Rarity or "Common",
			OpenAt = entry.OpenAt or 0,
			PlacedAt = entry.PlacedAt or 0,
			OwnerUserId = player.UserId,
		}
	end

	local brainrotCfg = GameConfig.Items[entry.BrainrotId]
	if not brainrotCfg then return nil end

	local mutation = entry.Mutation
	local level = entry.Level or 1
	local playerData = getPlayerData(player)
	local bestCps = playerData and getBestOwnedCps(playerData) or 0
	local baseCps = getBaseCashPerSec(entry.BrainrotId, mutation, bestCps)
	local displayName = brainrotCfg.DisplayName or entry.BrainrotId
	local modelName = brainrotCfg.ModelName or entry.BrainrotId
	if mutation and MutationService.IsValidMutation(mutation) then
		displayName = MutationService.GetDisplayName(mutation) .. " " .. displayName
		modelName = MutationService.GetModelName(mutation, entry.BrainrotId) or modelName
	end

	return {
		PodiumIndex = podiumIndex,
		BrainrotId = entry.BrainrotId,
		Level = level,
		CashPerSec = getCashPerSec(baseCps, level),
		DisplayName = displayName,
		ModelName = modelName,
		Rarity = GameConfig.GetItemRarity(entry.BrainrotId),
		AnimationId = brainrotCfg.AnimationId or "",
		OwnerUserId = player.UserId,
		Mutation = mutation,
	}
end

-- IMPORTANT: Podiums and OfflineCash use STRING keys, never integers. Sparse
-- integer-keyed tables get truncated at the first nil hole when sent through
-- a RemoteFunction (Roblox serializes them as arrays via `#table`), so a
-- placement on Podium 6 alongside empty Podium 4/5 would silently vanish on
-- the wire. Client code uses `podiumAt(podiums, idx)` which already falls
-- through to `podiums[tostring(idx)]`, so this is safe to change.
local function buildFullPodiumState(player)
	local plot = getPlotForPlayer(player)
	if not plot then return { Podiums = {} } end

	local maxIdx = getMaxPodiumIndex(plot)
	local podiums = {}
	for i = 1, maxIdx do
		local payload = buildPodiumPayload(player, i)
		if payload then
			podiums[tostring(i)] = payload
		end
	end

	-- Also include any PlacedBrainrot entries whose podium index lies beyond the
	-- currently-visible max. This handles the rejoin race where BaseUpgradeService
	-- hasn't yet cloned the unlocked podiums (11-30) back into the plot when
	-- PodiumService builds the initial state. Without this, brainrots saved on
	-- those upper-floor podiums never render until the player removes + re-places.
	local playerData = getPlayerData(player)
	local placed = playerData and playerData.PlacedBrainrot or {}
	for key in pairs(placed) do
		local idx = tonumber(key)
		if idx and podiums[tostring(idx)] == nil then
			local payload = buildPodiumPayload(player, idx)
			if payload then
				podiums[tostring(idx)] = payload
			end
		end
	end

	local offlineCash = {}
	local playerOffline = offlineCashPending[player]
	if playerOffline then
		for podiumIndex, amount in pairs(playerOffline) do
			offlineCash[tostring(podiumIndex)] = amount
		end
	end

	return { Podiums = podiums, OfflineCash = offlineCash }
end

local function buildAllPlotsVisualState()
	local allPlots = {}
	for _, plr in ipairs(Players:GetPlayers()) do
		local plot = getPlotForPlayer(plr)
		if not plot then continue end
		local maxIdx = getMaxPodiumIndex(plot)
		local podiums = {}
		for i = 1, maxIdx do
			local payload = buildVisualPayload(plr, i)
			if payload then
				podiums[tostring(i)] = payload
			end
		end
		local playerData = getPlayerData(plr)
		local placed = playerData and playerData.PlacedBrainrot or {}
		for key in pairs(placed) do
			local idx = tonumber(key)
			if idx and podiums[tostring(idx)] == nil then
				local payload = buildVisualPayload(plr, idx)
				if payload then
					podiums[tostring(idx)] = payload
				end
			end
		end
		allPlots[tostring(plr.UserId)] = { Podiums = podiums }
	end
	return allPlots
end

local function recalcTotalCashPerSec(ownerPlayer)
	local plot = getPlotForPlayer(ownerPlayer)
	if not plot then return end

	local placed = getPlacedBrainrots(ownerPlayer)
	local playerData = getPlayerData(ownerPlayer)
	local best = playerData and getBestOwnedCps(playerData) or 0
	local total = 0
	for _, entry in pairs(placed) do
		local baseCps = getBaseCashPerSec(entry.BrainrotId, entry.Mutation, best)
		total = total + getCashPerSec(baseCps, entry.Level or 1)
	end

	plot:SetAttribute("TotalCashPerSec", total)
end

local function refreshPercentPodiums(ownerPlayer, excludeIndex)
	local placed = getPlacedBrainrots(ownerPlayer)
	local ownerUserId = ownerPlayer.UserId
	for key, entry in pairs(placed) do
		local podiumIndex = tonumber(key)
		if podiumIndex and podiumIndex ~= excludeIndex then
			local cfg = GameConfig.Items[entry.BrainrotId]
			if cfg and cfg.IsPercentBrainrot then
				local payload = buildPodiumPayload(ownerPlayer, podiumIndex)
				PodiumUpdateEvent:FireClient(ownerPlayer, podiumIndex, payload, ownerUserId)
			end
		end
	end
end

local function sendPodiumUpdate(ownerPlayer, podiumIndex)
	local fullPayload = buildPodiumPayload(ownerPlayer, podiumIndex)
	local visualPayload = buildVisualPayload(ownerPlayer, podiumIndex)
	local ownerUserId = ownerPlayer.UserId

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr == ownerPlayer then
			PodiumUpdateEvent:FireClient(plr, podiumIndex, fullPayload, ownerUserId)
		else
			PodiumUpdateEvent:FireClient(plr, podiumIndex, visualPayload, ownerUserId)
		end
	end

	recalcTotalCashPerSec(ownerPlayer)

	local cfg = fullPayload and GameConfig.Items[fullPayload.BrainrotId]
	if not (cfg and cfg.IsPercentBrainrot) then
		refreshPercentPodiums(ownerPlayer, podiumIndex)
	end
end


local function onEquipBest(player)
	local plot = getPlotForPlayer(player)
	if not plot then return false end

	local playerData = getPlayerData(player)
	if not playerData then return false end

	local brainrotInv = playerData.BrainrotInventory or {}
	local placed = playerData.PlacedBrainrot or {}
	local maxIdx = getMaxPodiumIndex(plot)

	-- Lucky-block pads must be left ALONE by Equip Best -- they're unopened
	-- placements waiting on their open timer. Without this filter the
	-- subsequent "reset all podiums" step would silently delete them
	-- (lucky-block entries have no UniqueId, so returnBrainrotToInventory
	-- can't preserve them and `PlacedBrainrot = {}` permanently loses the
	-- save). Reserve their podium indices so the brainrot reshuffle skips
	-- those slots too.
	local luckyPlacements = {}    -- podiumIndex -> luckyEntry (preserved across reset)
	local reservedPodiums = {}    -- podiumIndex -> true (skip these in reshuffle)
	for key, entry in pairs(placed) do
		local idx = tonumber(key)
		if idx and entry and entry.LuckyBlockId then
			luckyPlacements[idx] = entry
			reservedPodiums[idx] = true
		end
	end

	-- Collect valid podium slots (excluding lucky-block pads).
	local validPodiums = {}
	for i = 1, maxIdx do
		if podiumExists(plot, i) and not reservedPodiums[i] then
			table.insert(validPodiums, i)
		end
	end
	if #validPodiums == 0 then return false end

	local bestCps = getBestOwnedCps(playerData)

	-- Build combined pool: all owned brainrots (placed + inventory). Lucky
	-- block entries are skipped via the `entry.BrainrotId` check (they have
	-- LuckyBlockId instead).
	local placedUniqueIds = {}
	for _, entry in pairs(placed) do
		if entry.UniqueId then
			placedUniqueIds[entry.UniqueId] = true
		end
	end

	local allBrainrots = {}

	for uniqueId, entry in pairs(brainrotInv) do
		if not placedUniqueIds[uniqueId] then
			local cfg = GameConfig.Items[entry.BrainrotId]
			if cfg then
				local baseCps = getBaseCashPerSec(entry.BrainrotId, entry.Mutation, bestCps)
				local cps = getCashPerSec(baseCps, entry.Level or 1)
				table.insert(allBrainrots, {
					UniqueId = uniqueId,
					BrainrotId = entry.BrainrotId,
					Level = entry.Level or 1,
					Mutation = entry.Mutation,
					Cps = cps,
				})
			end
		end
	end

	for _, entry in pairs(placed) do
		-- Skip lucky-block entries; they're not brainrots and stay on their pads.
		if entry.LuckyBlockId then continue end
		local cfg = GameConfig.Items[entry.BrainrotId]
		if cfg then
			local baseCps = getBaseCashPerSec(entry.BrainrotId, entry.Mutation, bestCps)
			local cps = getCashPerSec(baseCps, entry.Level or 1)
			table.insert(allBrainrots, {
				UniqueId = entry.UniqueId,
				BrainrotId = entry.BrainrotId,
				Level = entry.Level or 1,
				Mutation = entry.Mutation,
				Cps = cps,
			})
		end
	end

	if #allBrainrots == 0 then return false end

	-- Sort best first (stable by UniqueId)
	table.sort(allBrainrots, function(a, b)
		if a.Cps ~= b.Cps then return a.Cps > b.Cps end
		return a.UniqueId < b.UniqueId
	end)

	-- Determine optimal set
	local numPodiums = #validPodiums
	local shouldBePlaced = {}
	for i = 1, math.min(numPodiums, #allBrainrots) do
		shouldBePlaced[allBrainrots[i].UniqueId] = true
	end

	-- Check if already optimal (compare against the brainrot-only subset; lucky
	-- blocks aren't part of the swap pool).
	local currentlyPlaced = {}
	for _, entry in pairs(placed) do
		if entry.UniqueId and not entry.LuckyBlockId then
			currentlyPlaced[entry.UniqueId] = true
		end
	end

	local needsChange = false
	for id in pairs(shouldBePlaced) do
		if not currentlyPlaced[id] then needsChange = true break end
	end
	if not needsChange then
		for id in pairs(currentlyPlaced) do
			if not shouldBePlaced[id] then needsChange = true break end
		end
	end
	if not needsChange then return true end

	-- Save equipped state and clear it
	local prevEquipped = playerData.EquippedItem or ""
	playerData.EquippedItem = ""

	-- Pay out accumulated cash from BRAINROT-occupied podiums (skip lucky
	-- pads -- they have no accumulator).
	if accumulatedCash[player] then
		local totalCash = 0
		for key, entry in pairs(placed) do
			local podiumIndex = tonumber(key)
			if podiumIndex and not (entry and entry.LuckyBlockId) then
				local amount = math.floor(accumulatedCash[player][podiumIndex] or 0)
				if amount > 0 then
					totalCash = totalCash + amount
					accumulatedCash[player][podiumIndex] = 0
					CashAccumulateEvent:FireClient(player, podiumIndex, 0)
				end
			end
		end
		if totalCash > 0 then
			PlayerDataService.AddStat(player, "Cash", totalCash)
			LeaderboardService.AddTotalCash(player, totalCash)
		end
	end

	-- Return all BRAINROT entries to inventory. Lucky-block entries are skipped
	-- because (a) they don't belong in BrainrotInventory and (b) the nil
	-- UniqueId would error on the BrainrotInventory[nil] assignment.
	for _, entry in pairs(placed) do
		if not (entry and entry.LuckyBlockId) then
			returnBrainrotToInventory(playerData, entry)
		end
	end

	-- Reset only the brainrot slots; preserve placed lucky blocks by re-adding
	-- them after the wipe.
	playerData.PlacedBrainrot = {}
	for idx, luckyEntry in pairs(luckyPlacements) do
		playerData.PlacedBrainrot[tostring(idx)] = luckyEntry
	end
	if not accumulatedCash[player] then accumulatedCash[player] = {} end

	-- Place the best brainrots
	for i, podiumIndex in ipairs(validPodiums) do
		local item = allBrainrots[i]
		if not item then break end
		local invEntry = playerData.BrainrotInventory[item.UniqueId]
		if not invEntry then continue end
		playerData.PlacedBrainrot[tostring(podiumIndex)] = {
			UniqueId = item.UniqueId,
			BrainrotId = item.BrainrotId,
			Level = invEntry.Level or 1,
			Mutation = invEntry.Mutation,
		}
		playerData.BrainrotInventory[item.UniqueId] = nil
		accumulatedCash[player][podiumIndex] = 0
	end

	PlayerDataService.DataChanged:Fire(player, "PlacedBrainrot", playerData.PlacedBrainrot)
	PlayerDataService.ScheduleSave(player)

	-- Restore equipped item if still in inventory
	if prevEquipped ~= "" and playerData.BrainrotInventory[prevEquipped] then
		playerData.EquippedItem = prevEquipped
	end
	PlayerDataService.DataChanged:Fire(player, "EquippedItem", playerData.EquippedItem)

	-- Send podium updates to all clients
	for i = 1, maxIdx do
		sendPodiumUpdate(player, i)
	end

	pushInventoryUpdate(player)

	return true
end

local function onPlaceBrainrot(player, podiumIndex)
	if type(podiumIndex) ~= "number" then return false end
	podiumIndex = math.floor(podiumIndex)
	if podiumIndex < 1 then return false end

	local plot = getPlotForPlayer(player)
	if not plot or not podiumExists(plot, podiumIndex) then return false end

	local playerData = getPlayerData(player)
	if not playerData then return false end

	local placed = getPlacedBrainrots(player)
	if placed[tostring(podiumIndex)] then return false end

	-- Lucky-block place path: decrement Inventory[id] by 1, store OpenAt so the
	-- client can render the countdown billboard + gate the Open prompt.
	local luckyBlockId = validateEquippedLuckyBlock(playerData)
	if luckyBlockId then
		local inv = playerData.Inventory or {}
		inv[luckyBlockId] = (inv[luckyBlockId] or 0) - 1
		if inv[luckyBlockId] <= 0 then
			inv[luckyBlockId] = nil
		end
		-- Always clear EquippedItem after placing a lucky block (not only when
		-- count hits 0). Player perception was that the block "stays in
		-- inventory" because they were still holding/equipped to the remaining
		-- stack -- this drops the held visual so they're free to pick another.
		playerData.EquippedItem = ""
		PlayerDataService.DataChanged:Fire(player, "EquippedItem", playerData.EquippedItem)
		playerData.Inventory = inv
		DataUpdateEvent:FireClient(player, "Inventory", inv)
		PlayerDataService.DataChanged:Fire(player, "Inventory", inv)

		local now = os.time()
		setPlacedBrainrot(player, podiumIndex, {
			LuckyBlockId = luckyBlockId,
			PlacedAt = now,
			OpenAt = now,
		})

		sendPodiumUpdate(player, podiumIndex)
		return true, buildPodiumPayload(player, podiumIndex)
	end

	local equippedItem, brainrotEntry, brainrotId = validateEquippedBrainrot(playerData)
	if not equippedItem then return false end

	for _, existing in pairs(placed) do
		if existing.UniqueId == equippedItem then return false end
	end

	setPlacedBrainrot(player, podiumIndex, {
		UniqueId = equippedItem,
		BrainrotId = brainrotId,
		Level = brainrotEntry.Level or 1,
		Mutation = brainrotEntry.Mutation,
	})

	playerData.BrainrotInventory[equippedItem] = nil
	playerData.EquippedItem = ""
	PlayerDataService.DataChanged:Fire(player, "EquippedItem", playerData.EquippedItem)

	if not accumulatedCash[player] then accumulatedCash[player] = {} end
	accumulatedCash[player][podiumIndex] = 0

	sendPodiumUpdate(player, podiumIndex)
	pushInventoryUpdate(player)

	return true, buildPodiumPayload(player, podiumIndex)
end

-- Player presses E on a placed lucky block whose OpenAt has passed. We run
-- LuckyBlockService.OpenPlacedBlock (rolls loot + fires the unbox animation
-- via the same OpenResult remote the inventory open path uses) and clear the
-- pad. The block is consumed; it does NOT return to inventory.
local function onOpenPlacedLuckyBlock(player, podiumIndex)
	if type(podiumIndex) ~= "number" then return false end
	podiumIndex = math.floor(podiumIndex)

	local playerData = getPlayerData(player)
	if not playerData then return false end

	local placed = getPlacedBrainrots(player)
	local entry = placed[tostring(podiumIndex)]
	if not entry or not entry.LuckyBlockId then return false end

	-- Run the open + commit-brainrot-on-pad flow. LuckyBlockService writes the
	-- rolled brainrot directly into PlacedBrainrot[podiumIndex] (replacing the
	-- lucky-block entry), so the resulting brainrot stays on this pad.
	-- On failure we explicitly LEAVE the lucky block on the pad instead of
	-- clearing it -- previously a stale loot-table config could make rollBrainrot
	-- return nil, OpenPlacedBlock return false, and the player would lose the
	-- block silently (no animation, no reward, pad emptied). Resending the
	-- existing payload lets the client redraw the lucky block so it stays
	-- recoverable via the Remove (X) prompt.
	local ok = LuckyBlockService.OpenPlacedBlock(player, entry.LuckyBlockId, podiumIndex)
	if not ok then
		warn(string.format(
			"[PodiumService] OpenPlacedBlock failed for %s on podium %d; leaving the lucky block on the pad.",
			tostring(entry.LuckyBlockId), podiumIndex
		))
		sendPodiumUpdate(player, podiumIndex)
		return false
	end

	if not accumulatedCash[player] then accumulatedCash[player] = {} end
	accumulatedCash[player][podiumIndex] = 0

	sendPodiumUpdate(player, podiumIndex)
	return true
end

local function onRemoveBrainrot(player, podiumIndex)
	if type(podiumIndex) ~= "number" then return false end
	podiumIndex = math.floor(podiumIndex)

	local playerData = getPlayerData(player)
	if not playerData then return false end

	local placed = getPlacedBrainrots(player)
	local entry = placed[tostring(podiumIndex)]
	if not entry then return false end

	-- Lucky-block remove: hand the block back to inventory, no cash banking,
	-- no UniqueId restore. Works regardless of timer state so a misclick is
	-- recoverable.
	if entry.LuckyBlockId then
		local inv = playerData.Inventory or {}
		inv[entry.LuckyBlockId] = (inv[entry.LuckyBlockId] or 0) + 1
		playerData.Inventory = inv
		DataUpdateEvent:FireClient(player, "Inventory", inv)
		PlayerDataService.DataChanged:Fire(player, "Inventory", inv)
		setPlacedBrainrot(player, podiumIndex, nil)
		sendPodiumUpdate(player, podiumIndex)
		return true
	end

	if accumulatedCash[player] then
		local amount = math.floor(accumulatedCash[player][podiumIndex] or 0)
		if amount > 0 then
			PlayerDataService.AddStat(player, "Cash", amount)
			LeaderboardService.AddTotalCash(player, amount)
			CashAccumulateEvent:FireClient(player, podiumIndex, 0)
		end
		accumulatedCash[player][podiumIndex] = nil
	end

	local playerOffline = offlineCashPending[player]
	if playerOffline then
		local offlineAmount = math.floor(playerOffline[podiumIndex] or 0)
		if offlineAmount > 0 then
			playerOffline[podiumIndex] = nil
			PlayerDataService.AddStat(player, "Cash", offlineAmount)
			LeaderboardService.AddTotalCash(player, offlineAmount)
			OfflineCashEvent:FireClient(player, podiumIndex, 0)
		end
	end

	returnBrainrotToInventory(playerData, entry)
	setPlacedBrainrot(player, podiumIndex, nil)

	sendPodiumUpdate(player, podiumIndex)
	pushInventoryUpdate(player)

	return true
end

-- Steal: thief presses E on another player's occupied pad. Atomically removes
-- the placed item from the victim's PlacedBrainrot and adds it to the thief's
-- inventory using the same shape as a normal remove. Brainrots preserve
-- UniqueId / Level / Mutation so a stolen brainrot keeps its upgrades; lucky
-- blocks stack into the thief's count inventory. Victim's accumulated +
-- pending offline cash is paid out to the VICTIM, matching the
-- onRemoveBrainrot contract (the placed brainrot was working for them up to
-- the moment of the steal).
local function onStealBrainrot(thief, victimUserId, podiumIndex)
	if type(podiumIndex) ~= "number" then return false end
	podiumIndex = math.floor(podiumIndex)
	if type(victimUserId) ~= "number" then return false end
	if victimUserId == thief.UserId then return false end

	local now = os.clock()
	local last = stealCooldowns[thief]
	if last and (now - last) < STEAL_COOLDOWN_SECONDS then return false end

	local victim = Players:GetPlayerByUserId(victimUserId)
	if not victim then return false end

	local victimData = getPlayerData(victim)
	if not victimData then return false end

	local placed = getPlacedBrainrots(victim)
	local entry = placed[tostring(podiumIndex)]
	if not entry then return false end

	local thiefData = getPlayerData(thief)
	if not thiefData then return false end

	stealCooldowns[thief] = now

	-- Lucky-block steal: stack into the thief's count Inventory. Victim has no
	-- pending accumulated cash for lucky blocks (they don't generate income),
	-- and the block is consumed-from-pad regardless of timer state, mirroring
	-- the lucky-remove path in onRemoveBrainrot.
	if entry.LuckyBlockId then
		local thiefInv = thiefData.Inventory or {}
		thiefInv[entry.LuckyBlockId] = (thiefInv[entry.LuckyBlockId] or 0) + 1
		thiefData.Inventory = thiefInv
		DataUpdateEvent:FireClient(thief, "Inventory", thiefInv)
		PlayerDataService.DataChanged:Fire(thief, "Inventory", thiefInv)

		setPlacedBrainrot(victim, podiumIndex, nil)
		sendPodiumUpdate(victim, podiumIndex)

		local lbCfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[entry.LuckyBlockId]
		local stolenName = (lbCfg and lbCfg.DisplayName) or entry.LuckyBlockId
		StealNotificationEvent:FireClient(thief, stolenName, victim.Name)
		return true
	end

	-- Brainrot steal: pay victim their accumulated + pending offline cash for
	-- this pad (same accounting as onRemoveBrainrot), then move the brainrot
	-- entry to the thief's BrainrotInventory.
	if accumulatedCash[victim] then
		local amount = math.floor(accumulatedCash[victim][podiumIndex] or 0)
		if amount > 0 then
			PlayerDataService.AddStat(victim, "Cash", amount)
			LeaderboardService.AddTotalCash(victim, amount)
			CashAccumulateEvent:FireClient(victim, podiumIndex, 0)
		end
		accumulatedCash[victim][podiumIndex] = nil
	end

	local victimOffline = offlineCashPending[victim]
	if victimOffline then
		local offlineAmount = math.floor(victimOffline[podiumIndex] or 0)
		if offlineAmount > 0 then
			victimOffline[podiumIndex] = nil
			PlayerDataService.AddStat(victim, "Cash", offlineAmount)
			LeaderboardService.AddTotalCash(victim, offlineAmount)
			OfflineCashEvent:FireClient(victim, podiumIndex, 0)
		end
	end

	returnBrainrotToInventory(thiefData, entry)
	setPlacedBrainrot(victim, podiumIndex, nil)

	sendPodiumUpdate(victim, podiumIndex)
	pushInventoryUpdate(thief)

	local cfg = GameConfig.Items[entry.BrainrotId]
	local stolenName = (cfg and cfg.DisplayName) or entry.BrainrotId
	if entry.Mutation and MutationService.IsValidMutation(entry.Mutation) then
		stolenName = MutationService.GetDisplayName(entry.Mutation) .. " " .. stolenName
	end
	StealNotificationEvent:FireClient(thief, stolenName, victim.Name)

	return true
end

-- Stub: kept so the existing RemoteFunction has a server-side binding and
-- never errors clients that probe it. The client doesn't actually need a
-- round-trip -- it already has the visual payload (DisplayName, OwnerUserId)
-- cached from PodiumUpdate. Returning nil is a contract the client tolerates.
local function onRequestStealInfo(_player, _victimUserId, _podiumIndex)
	return nil
end

local function onSwapBrainrot(player, podiumIndex)
	if type(podiumIndex) ~= "number" then return false end
	podiumIndex = math.floor(podiumIndex)

	local plot = getPlotForPlayer(player)
	if not plot or not podiumExists(plot, podiumIndex) then return false end

	local playerData = getPlayerData(player)
	if not playerData then return false end

	local placed = getPlacedBrainrots(player)
	local oldEntry = placed[tostring(podiumIndex)]
	if not oldEntry then return false end
	-- Lucky-block pads have a dedicated Open/Remove flow; never swap them.
	if oldEntry.LuckyBlockId then return false end

	-- Brainrot-equipped swap (the original path).
	local equippedItem, brainrotEntry, brainrotId = validateEquippedBrainrot(playerData)
	if equippedItem then
		if oldEntry.UniqueId == equippedItem then return false end

		for key, existing in pairs(placed) do
			if existing.UniqueId == equippedItem and key ~= tostring(podiumIndex) then return false end
		end

		returnBrainrotToInventory(playerData, oldEntry)

		setPlacedBrainrot(player, podiumIndex, {
			UniqueId = equippedItem,
			BrainrotId = brainrotId,
			Level = brainrotEntry.Level or 1,
			Mutation = brainrotEntry.Mutation,
		})

		playerData.BrainrotInventory[equippedItem] = nil
		playerData.EquippedItem = oldEntry.UniqueId
		PlayerDataService.DataChanged:Fire(player, "EquippedItem", playerData.EquippedItem)

		if not accumulatedCash[player] then accumulatedCash[player] = {} end
		accumulatedCash[player][podiumIndex] = 0

		sendPodiumUpdate(player, podiumIndex)
		pushInventoryUpdate(player)

		return true, buildPodiumPayload(player, podiumIndex)
	end

	-- Lucky-block-equipped swap: brainrot goes back into inventory, the
	-- equipped lucky block lands on the pad and starts its open timer. Mirrors
	-- the lucky path in onPlaceBrainrot (clears EquippedItem, decrements
	-- Inventory, pushes both updates).
	local luckyBlockId = validateEquippedLuckyBlock(playerData)
	if luckyBlockId then
		returnBrainrotToInventory(playerData, oldEntry)

		local inv = playerData.Inventory or {}
		inv[luckyBlockId] = (inv[luckyBlockId] or 0) - 1
		if inv[luckyBlockId] <= 0 then
			inv[luckyBlockId] = nil
		end
		playerData.Inventory = inv

		playerData.EquippedItem = ""
		PlayerDataService.DataChanged:Fire(player, "EquippedItem", playerData.EquippedItem)
		DataUpdateEvent:FireClient(player, "Inventory", inv)
		PlayerDataService.DataChanged:Fire(player, "Inventory", inv)

		local now = os.time()
		setPlacedBrainrot(player, podiumIndex, {
			LuckyBlockId = luckyBlockId,
			PlacedAt = now,
			OpenAt = now,
		})

		if accumulatedCash[player] then
			accumulatedCash[player][podiumIndex] = nil
		end

		sendPodiumUpdate(player, podiumIndex)
		pushInventoryUpdate(player)

		return true, buildPodiumPayload(player, podiumIndex)
	end

	return false
end

local function onUpgradeBrainrot(player, podiumIndex)
	if type(podiumIndex) ~= "number" then return false end
	podiumIndex = math.floor(podiumIndex)

	local playerData = getPlayerData(player)
	if not playerData then return false end

	local placed = getPlacedBrainrots(player)
	local entry = placed[tostring(podiumIndex)]
	if not entry then return false end

	local brainrotCfg = GameConfig.Items[entry.BrainrotId]
	if brainrotCfg and brainrotCfg.IsPercentBrainrot then return false end

	local currentLevel = entry.Level or 1
	if currentLevel >= MAX_BRAINROT_LEVEL then
		return false  -- already maxed; ignore the click
	end
	local cost = getUpgradeCost(entry.BrainrotId, currentLevel, entry.Mutation)
	if playerData.Cash < cost then
		NotEnoughCashEvent:FireClient(player)
		return false
	end

	local success = PlayerDataService.AddStat(player, "Cash", -cost)
	if not success then return false end

	entry.Level = currentLevel + 1
	print(string.format("[DBG_UPGRADE] SERVER onUpgradeBrainrot pod=%d player=%s level %d -> %d brainrotId=%s mutation=%s", podiumIndex, player.Name, currentLevel, entry.Level, tostring(entry.BrainrotId), tostring(entry.Mutation)))
	setPlacedBrainrot(player, podiumIndex, entry)
	sendPodiumUpdate(player, podiumIndex)

	local finalPayload = buildPodiumPayload(player, podiumIndex)
	print(string.format("[DBG_UPGRADE] SERVER post-upgrade payload pod=%d Level=%s CashPerSec=%s NextCashPerSec=%s", podiumIndex, tostring(finalPayload and finalPayload.Level), tostring(finalPayload and finalPayload.CashPerSec), tostring(finalPayload and finalPayload.NextCashPerSec)))
	return true, finalPayload
end

-- AutoCollect gamepass: drain offlineCashPending and credit it directly. Called
-- on ProfileLoaded (if the attribute is already known) and on the attribute
-- flipping to true (covers both "GamepassService finishes async query after
-- ProfileLoaded" and "player buys AutoCollect mid-session").
local function autoCollectOfflineIfOwned(plr)
	if plr:GetAttribute("OwnsGamepass_AutoCollect") ~= true then return end
	local pending = offlineCashPending[plr]
	if not pending then return end

	local total = 0
	for podiumIndex, amount in pairs(pending) do
		local rounded = math.floor(amount or 0)
		if rounded > 0 then total = total + rounded end
		pending[podiumIndex] = nil
		OfflineCashEvent:FireClient(plr, podiumIndex, 0)
	end

	if total > 0 then
		PlayerDataService.AddStat(plr, "Cash", total)
		LeaderboardService.AddTotalCash(plr, total)
		offlineCashAutoCredited[plr] = (offlineCashAutoCredited[plr] or 0) + total
		-- keep auto-credited offline cash out of the session-rate measurement
		local rec = sessionEarnStart[plr]
		if rec then rec.totalCash = rec.totalCash + total end
	end
end

-- Aggregate query for the OfflineReward popup: sums every podium's pending
-- offline cash into one number for the "You earned $X while offline" UI.
local function onRequestOfflineTotal(player)
	local strength = math.floor(offlineStrengthPending[player] or 0)
	local total = (offlineFlatCashPending[player] or 0) + (offlineCashAutoCredited[player] or 0)
	local pending = offlineCashPending[player]
	if pending then
		for _, amount in pairs(pending) do
			total = total + (amount or 0)
		end
	end
	return math.floor(total), strength
end

-- Claim-all endpoint for the OfflineReward popup's single Claim button.
-- Credits every pending podium amount, zeroes the per-podium events so the
-- per-pad floating labels disappear, and returns the total credited.
local function onCollectAllOfflineCash(player)
	local strength = math.floor(offlineStrengthPending[player] or 0)
	offlineStrengthPending[player] = nil
	-- AutoCollect already credited this slice at join: it counts toward the
	-- returned/displayed cash but is never granted a second time.
	local auto = math.floor(offlineCashAutoCredited[player] or 0)
	offlineCashAutoCredited[player] = nil
	local flat = math.floor(offlineFlatCashPending[player] or 0)
	offlineFlatCashPending[player] = nil

	local pending = offlineCashPending[player]
	if not pending and strength <= 0 and auto <= 0 and flat <= 0 then return false, 0, 0 end

	local total = 0
	if pending then
		for podiumIndex, amount in pairs(pending) do
			total = total + (amount or 0)
			-- Tell every nearby client (and the owner) the per-pad amount is gone
			-- so PodiumController's OfflineRewardLabel hides cleanly.
			local idx = tonumber(podiumIndex) or podiumIndex
			OfflineCashEvent:FireClient(player, idx, 0)
		end
		offlineCashPending[player] = {}
	end
	local rounded = math.floor(total) + flat
	if rounded > 0 then
		PlayerDataService.AddStat(player, "Cash", rounded)
		LeaderboardService.AddTotalCash(player, rounded)
		-- Offline grants must not count as "earned this session": the next
		-- session's OfflineCashRate would otherwise include them and compound.
		local rec = sessionEarnStart[player]
		if rec then rec.totalCash = rec.totalCash + rounded end
	end

	-- Offline strength rides the same Claim: granted through StrengthClickServer's
	-- GrantStrength bindable so XP / levels / profile write-through behave exactly
	-- like the training pads' grants.
	if strength > 0 then
		local strengthScript = ServerScriptService:FindFirstChild("StrengthClickServer")
		local grant = strengthScript and strengthScript:FindFirstChild("GrantStrength")
		if grant then
			grant:Fire(player, strength)
		else
			strength = 0
		end
	end

	return true, rounded + auto, strength
end

local function onCollectOfflineCash(player, podiumIndex)
	if type(podiumIndex) ~= "number" then return false, 0 end
	podiumIndex = math.floor(podiumIndex)

	local playerOffline = offlineCashPending[player]
	if not playerOffline then return false, 0 end

	local amount = playerOffline[podiumIndex] or 0
	if amount <= 0 then return false, 0 end

	local rounded = math.floor(amount)
	playerOffline[podiumIndex] = nil

	PlayerDataService.AddStat(player, "Cash", rounded)
	LeaderboardService.AddTotalCash(player, rounded)
	OfflineCashEvent:FireClient(player, podiumIndex, 0)

	return true, rounded
end

local function onCollectCash(player, podiumIndex)
	if type(podiumIndex) ~= "number" then return false, 0 end
	podiumIndex = math.floor(podiumIndex)

	if not accumulatedCash[player] then return false, 0 end
	local amount = accumulatedCash[player][podiumIndex] or 0
	local rounded = math.floor(amount)
	if rounded <= 0 then return false, 0 end

	accumulatedCash[player][podiumIndex] = 0
	PlayerDataService.AddStat(player, "Cash", rounded)
	LeaderboardService.AddTotalCash(player, rounded)
	CashAccumulateEvent:FireClient(player, podiumIndex, 0)

	return true, rounded
end

local function tickCashAccumulation(dt)
	tickTimer = tickTimer + dt
	if tickTimer < TICK_INTERVAL then return end
	tickTimer = tickTimer - TICK_INTERVAL

	for _, plr in ipairs(Players:GetPlayers()) do
		local playerData = getPlayerData(plr)
		if not playerData or not playerData.PlacedBrainrot then continue end

		if not accumulatedCash[plr] then accumulatedCash[plr] = {} end
		local playerAcc = accumulatedCash[plr]

		local rebirthMult = RebirthService.GetCashMultiplier(plr)
		local boostMult = CashBoostService.GetMultiplier(plr)
		local best = getBestOwnedCps(playerData)
		local autoCollect = plr:GetAttribute("OwnsGamepass_AutoCollect") == true

		-- AutoCollect gamepass: previously this accumulated for 2 s then drained
		-- every pad to 0 at once -- which made every owned pad's billboard flicker
		-- 0 -> cps -> 0 -> cps forever (the player perceived this as the pad being
		-- "stuck on a number and resetting infinitely"). Now we credit cash directly
		-- each tick and leave the visible accumulator at 0, so the gamepass works
		-- silently in the background and the pads no longer flicker.
		local autoCreditTotal = 0

		for key, entry in pairs(playerData.PlacedBrainrot) do
			local podiumIndex = tonumber(key)
			if not podiumIndex then continue end

			local baseCps = getBaseCashPerSec(entry.BrainrotId, entry.Mutation, best)
			local cps = getCashPerSec(baseCps, entry.Level or 1)
			cps = cps * rebirthMult * boostMult

			if autoCollect then
				autoCreditTotal = autoCreditTotal + cps
				-- Sweep any residual from manual-collect-era accumulation so it
				-- doesn't sit on the pad forever when the player buys the gamepass
				-- mid-session.
				local residual = playerAcc[podiumIndex]
				if residual and residual > 0 then
					autoCreditTotal = autoCreditTotal + residual
					playerAcc[podiumIndex] = 0
					CashAccumulateEvent:FireClient(plr, podiumIndex, 0)
				end
			else
				playerAcc[podiumIndex] = (playerAcc[podiumIndex] or 0) + cps
				CashAccumulateEvent:FireClient(plr, podiumIndex, playerAcc[podiumIndex])
			end
		end

		if autoCollect then
			-- Carry the sub-integer remainder between ticks so low-cps pads still
			-- pay out over time instead of getting rounded to zero every tick.
			local carry = autoCollectElapsed[plr] or 0
			local pending = autoCreditTotal + carry
			local rounded = math.floor(pending)
			autoCollectElapsed[plr] = pending - rounded
			if rounded > 0 then
				PlayerDataService.AddStat(plr, "Cash", rounded)
				LeaderboardService.AddTotalCash(plr, rounded)
			end
		elseif autoCollectElapsed[plr] then
			autoCollectElapsed[plr] = nil
		end
	end
end


local function onRequestPodiumData(plr)
	local plot = getPlotForPlayer(plr)
	local attempts = 0
	while not plot and attempts < 50 do
		task.wait(0.2)
		if not plr.Parent then
			return nil
		end
		plot = getPlotForPlayer(plr)
		attempts = attempts + 1
	end

	if not plot then
		return nil
	end

	return buildFullPodiumState(plr)
end

local function onRequestAllPlotsData(requestingPlayer)
	local allPlots = {}
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr == requestingPlayer then continue end
		local plot = getPlotForPlayer(plr)
		if not plot then continue end
		local maxIdx = getMaxPodiumIndex(plot)
		local podiums = {}
		for i = 1, maxIdx do
			local payload = buildVisualPayload(plr, i)
			if payload then
				podiums[tostring(i)] = payload
			end
		end
		local playerData = getPlayerData(plr)
		local placed = playerData and playerData.PlacedBrainrot or {}
		for key in pairs(placed) do
			local idx = tonumber(key)
			if idx and podiums[tostring(idx)] == nil then
				local payload = buildVisualPayload(plr, idx)
				if payload then
					podiums[tostring(idx)] = payload
				end
			end
		end
		allPlots[tostring(plr.UserId)] = { Podiums = podiums }
	end
	return allPlots
end

-- Walk PlacedBrainrot and clean up any entries that can't be rendered or
-- interacted with — "ghosts" left over from races / interrupted placements.
-- For each invalid entry, the brainrot is moved back into BrainrotInventory.
-- An entry is considered a ghost if any of:
--   * the podium model isn't in the plot (locked floor / missing template)
--   * the BrainrotId isn't in GameConfig.Items (stale / renamed config)
--   * the UniqueId is empty / nil / non-string
--   * the same UniqueId already exists in BrainrotInventory (duplicate)
-- Returns true if it changed anything.
function PodiumService.ValidatePlacements(player)
	local plot = getPlotForPlayer(player)
	if not plot then return false end

	local playerData = getPlayerData(player)
	if not playerData then return false end

	local placed = playerData.PlacedBrainrot
	if type(placed) ~= "table" then return false end

	local inventory = playerData.BrainrotInventory
	if type(inventory) ~= "table" then
		inventory = {}
		playerData.BrainrotInventory = inventory
	end

	local changedPlacements = false
	local changedInventory = false
	local returnedIndices = {}

	for key, entry in pairs(placed) do
		local idx = tonumber(key)
		local reason = nil

		if not idx then
			reason = "bad-key"
		elseif type(entry) ~= "table" then
			reason = "bad-entry"
		elseif entry.LuckyBlockId then
			-- Lucky-block pad entry. These don't have UniqueId/BrainrotId by
			-- design — they're unopened placements waiting on the open timer.
			-- Only clear them if the LuckyBlockId is unknown or the podium is
			-- locked; otherwise leave the entry untouched (previously this
			-- fell through to the "missing-uid" branch and wiped every placed
			-- lucky block on every rejoin).
			if not (GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[entry.LuckyBlockId]) then
				reason = "unknown-luckyblock"
			elseif not podiumExists(plot, idx) then
				reason = "locked-podium"
			end
		elseif type(entry.UniqueId) ~= "string" or entry.UniqueId == "" then
			reason = "missing-uid"
		elseif type(entry.BrainrotId) ~= "string" or not GameConfig.Items[entry.BrainrotId] then
			reason = "unknown-brainrot"
		elseif not podiumExists(plot, idx) then
			reason = "locked-podium"
		elseif inventory[entry.UniqueId] ~= nil then
			reason = "duplicate-uid"
		end

		if reason then
			if type(entry) == "table" and type(entry.UniqueId) == "string" and entry.UniqueId ~= ""
				and type(entry.BrainrotId) == "string" and GameConfig.Items[entry.BrainrotId]
				and inventory[entry.UniqueId] == nil then
				inventory[entry.UniqueId] = {
					BrainrotId = entry.BrainrotId,
					Timestamp = os.time(),
					Level = entry.Level or 1,
					Mutation = entry.Mutation,
				}
				changedInventory = true
			end

			placed[key] = nil
			changedPlacements = true
			if accumulatedCash[player] and idx then
				accumulatedCash[player][idx] = nil
			end
			if idx then
				table.insert(returnedIndices, idx)
			end
			warn(string.format("[PodiumService] ghost cleanup for %s on podium %s (%s)", player.Name, tostring(idx or key), reason))
		end
	end

	if not (changedPlacements or changedInventory) then
		return false
	end

	if changedPlacements then
		PlayerDataService.DataChanged:Fire(player, "PlacedBrainrot", placed)
	end
	if changedInventory then
		PlayerDataService.DataChanged:Fire(player, "BrainrotInventory", inventory)
	end
	PlayerDataService.ScheduleSave(player)

	-- Push owner-facing empty payloads for the freed podiums so the client
	-- clears any visual / prompt-occupied state that may still be cached.
	for _, idx in ipairs(returnedIndices) do
		PodiumUpdateEvent:FireClient(player, idx, nil, player.UserId)
		for _, otherPlr in ipairs(Players:GetPlayers()) do
			if otherPlr ~= player then
				PodiumUpdateEvent:FireClient(otherPlr, idx, nil, player.UserId)
			end
		end
	end

	return true
end

-- Public refresh entry point. Called by BaseUpgradeService after cloning newly
-- unlocked podiums into the plot, so any PlacedBrainrot entries on the new
-- podiums get fresh PodiumUpdate events (owner + visual payloads for others).
function PodiumService.SendStateToPlayer(player)
	local plot = getPlotForPlayer(player)
	if not plot then return end

	recalcTotalCashPerSec(player)

	local state = buildFullPodiumState(player)
	if state and state.Podiums then
		-- buildFullPodiumState keys by tostring(i) to dodge sparse-array truncation
		-- through RemoteFunction. RemoteEvents preserve scalar types, so re-emitting
		-- those string keys would leak `podiumIndex` to the client as a string —
		-- `ensureCollectButton` would then capture the string in its onTouched
		-- closure and `CollectCashFunc:InvokeServer("30")` would be rejected by
		-- `onCollectCash` (type ~= "number"). Coerce back to number before firing.
		for key, payload in pairs(state.Podiums) do
			local idx = tonumber(key)
			if idx and payload then
				PodiumUpdateEvent:FireClient(player, idx, payload, player.UserId)
			end
		end
	end

	local playerData = getPlayerData(player)
	local placed = playerData and playerData.PlacedBrainrot or {}
	local allIndices = {}
	local maxIdx = getMaxPodiumIndex(plot)
	for i = 1, maxIdx do allIndices[i] = true end
	for key in pairs(placed) do
		local idx = tonumber(key)
		if idx then allIndices[idx] = true end
	end

	for idx in pairs(allIndices) do
		local visualPayload = buildVisualPayload(player, idx)
		if visualPayload then
			for _, otherPlr in ipairs(Players:GetPlayers()) do
				if otherPlr ~= player then
					PodiumUpdateEvent:FireClient(otherPlr, idx, visualPayload, player.UserId)
				end
			end
		end
	end
end

function PodiumService.AutoPlaceBrainrot(player, uniqueId, brainrotId, mutation)
	local plot = getPlotForPlayer(player)
	if not plot then return end

	local playerData = getPlayerData(player)
	if not playerData then return end

	local brainrotInv = playerData.BrainrotInventory or {}
	if not brainrotInv[uniqueId] then return end

	local placed = getPlacedBrainrots(player)
	for _, existing in pairs(placed) do
		if existing.UniqueId == uniqueId then return end
	end

	local maxIdx = getMaxPodiumIndex(plot)
	local freePodium = nil
	for i = 1, maxIdx do
		if not placed[tostring(i)] then
			freePodium = i
			break
		end
	end

	if not freePodium then return end

	local brainrotEntry = brainrotInv[uniqueId]
	setPlacedBrainrot(player, freePodium, {
		UniqueId = uniqueId,
		BrainrotId = brainrotId,
		Level = brainrotEntry.Level or 1,
		Mutation = mutation,
	})

	playerData.BrainrotInventory[uniqueId] = nil

	if not accumulatedCash[player] then accumulatedCash[player] = {} end
	accumulatedCash[player][freePodium] = 0

	sendPodiumUpdate(player, freePodium)
	pushInventoryUpdate(player)
end


function PodiumService.Init()
	-- Prevent Roblox content streaming from unloading plots / podiums when the
	-- player camera moves away. Client-spawned placed-brainrot models are
	-- parented to these podium models; if streaming kicks the podium out, the
	-- brainrot disappears with it and gets re-created on stream-in, producing a
	-- visible delete/restore flicker on camera shake. Persistent ModelStreamingMode
	-- pins them in memory regardless of camera distance.
	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		if plot:IsA("Model") then
			plot.ModelStreamingMode = Enum.ModelStreamingMode.Persistent
			for _, child in ipairs(plot:GetChildren()) do
				if child:IsA("Model") and child.Name:match("^Podium%d+$") then
					child.ModelStreamingMode = Enum.ModelStreamingMode.Persistent
				end
			end
		end
	end

	-- Same fix for trees. Workspace.Assets.Map.TreeLevel<n> are flat Parts (not
	-- Models) so they can't take ModelStreamingMode directly. Wrap each in a
	-- Persistent Model named TreeLevel<n>_Persistent. The five client controllers
	-- that lookup TreeLevel by name use FindFirstChild with the recursive flag
	-- to find the Part inside the wrapper (see TreeController, TreeAreaController,
	-- TutorialController).
	local mapFolder = Workspace:WaitForChild("Assets"):WaitForChild("Map")
	for _, child in ipairs(mapFolder:GetChildren()) do
		local levelNum = child.Name:match("^TreeLevel(%d+)$")
		if levelNum and child:IsA("BasePart") and not child.Parent:IsA("Model") then
			local wrapper = Instance.new("Model")
			wrapper.Name = "TreeLevel" .. levelNum .. "_Persistent"
			wrapper.ModelStreamingMode = Enum.ModelStreamingMode.Persistent
			wrapper.Parent = mapFolder
			child.Parent = wrapper
			wrapper.PrimaryPart = child
		end
		if child:IsA("Model") and child.ModelStreamingMode == Enum.ModelStreamingMode.Default then
			child.ModelStreamingMode = Enum.ModelStreamingMode.Persistent
		end
	end

	EquipBestFunc.OnServerInvoke = onEquipBest
	PlaceBrainrotFunc.OnServerInvoke = onPlaceBrainrot
	RemoveBrainrotFunc.OnServerInvoke = onRemoveBrainrot
	SwapBrainrotFunc.OnServerInvoke = onSwapBrainrot
	OpenPlacedLuckyBlockFunc.OnServerInvoke = onOpenPlacedLuckyBlock
	UpgradeBrainrotFunc.OnServerInvoke = onUpgradeBrainrot
	CollectCashFunc.OnServerInvoke = onCollectCash
	RequestPodiumDataFunc.OnServerInvoke = onRequestPodiumData
	RequestAllPlotsDataFunc.OnServerInvoke = onRequestAllPlotsData
	CollectOfflineCashFunc.OnServerInvoke = onCollectOfflineCash
	StealBrainrotFunc.OnServerInvoke = onStealBrainrot
	if RequestStealInfoFunc then
		RequestStealInfoFunc.OnServerInvoke = onRequestStealInfo
	end

	-- Lazily ensure the OfflineReward popup remotes exist. Created here at
	-- runtime instead of placed as Studio Instances so the place's git
	-- snapshot stays scriptless.
	local RequestOfflineTotalFunc = PodiumRemotes:FindFirstChild("RequestOfflineTotal")
	if not RequestOfflineTotalFunc then
		RequestOfflineTotalFunc = Instance.new("RemoteFunction")
		RequestOfflineTotalFunc.Name = "RequestOfflineTotal"
		RequestOfflineTotalFunc.Parent = PodiumRemotes
	end
	local CollectAllOfflineCashFunc = PodiumRemotes:FindFirstChild("CollectAllOfflineCash")
	if not CollectAllOfflineCashFunc then
		CollectAllOfflineCashFunc = Instance.new("RemoteFunction")
		CollectAllOfflineCashFunc.Name = "CollectAllOfflineCash"
		CollectAllOfflineCashFunc.Parent = PodiumRemotes
	end
	OfflineRewardReadyEvent = PodiumRemotes:FindFirstChild("OfflineRewardReady")
	if not OfflineRewardReadyEvent then
		OfflineRewardReadyEvent = Instance.new("RemoteEvent")
		OfflineRewardReadyEvent.Name = "OfflineRewardReady"
		OfflineRewardReadyEvent.Parent = PodiumRemotes
	end
	RequestOfflineTotalFunc.OnServerInvoke = onRequestOfflineTotal
	CollectAllOfflineCashFunc.OnServerInvoke = onCollectAllOfflineCash

	RunService.Heartbeat:Connect(tickCashAccumulation)

	-- Watch every player's AutoCollect attribute so offline cash auto-credits the
	-- moment ownership becomes known (async UserOwnsGamePassAsync race with
	-- ProfileLoaded) or the player buys the pass mid-session.
	local function watchAutoCollect(plr)
		plr:GetAttributeChangedSignal("OwnsGamepass_AutoCollect"):Connect(function()
			autoCollectOfflineIfOwned(plr)
		end)
	end
	for _, plr in ipairs(Players:GetPlayers()) do
		watchAutoCollect(plr)
	end
	Players.PlayerAdded:Connect(watchAutoCollect)

	PlayerDataService.ProfileLoaded.Event:Connect(function(plr)
		accumulatedCash[plr] = {}

		local playerData = PlayerDataService.GetPlayerData(plr)
		if playerData then
			playerData.EquippedItem = ""
			PlayerDataService.DataChanged:Fire(plr, "EquippedItem", "")

			-- Captured BEFORE LastLogin is overwritten below; the Earnings popup's
			-- strength amount is computed from it a beat later (see task.delay).
			local offlineSeconds = 0
			if (playerData.LastLogin or 0) > 0 then
				offlineSeconds = math.max(os.time() - playerData.LastLogin, 0)
			end

			-- Rejoin-only join popups: the daily-reward auto-open (client) keys
			-- off this attribute; a first-ever session shows NO popups on join.
			plr:SetAttribute("IsRejoin", (playerData.LastLogin or 0) > 0)
			sessionEarnStart[plr] = { totalCash = playerData.TotalCash or 0, clock = os.clock() }

			local okOffline, offlineTable = pcall(calcOfflineCash, plr, playerData)
			if okOffline and offlineTable then
				offlineCashPending[plr] = offlineTable
				-- The popup is the ONLY way to claim offline cash -- we intentionally
				-- do NOT call OfflineCashEvent:FireClient per podium here, so the
				-- per-pad "Offline Cash: $X" floating labels never appear and the
				-- player can't double-collect by walking onto each pad after using
				-- the popup. AutoCollect still works for that gamepass.
				autoCollectOfflineIfOwned(plr)
			elseif not okOffline then
				warn(string.format("[PodiumService] calcOfflineCash failed for %s: %s", plr.Name, tostring(offlineTable)))
			end
			playerData.LastLogin = os.time()

			-- Earnings popup: fire cash + strength together one beat later, so
			-- DrillShopService / TrailShopService / RebirthService have mirrored the
			-- attributes calcOfflineStrength reads (they hook the same ProfileLoaded
			-- event; 1s also covers most gamepass queries), and so an AutoCollect
			-- owner's already-credited cash shows as 0 instead of twice.
			task.delay(1, function()
				if not plr.Parent then return end
				local okStrength, strengthAmount = pcall(calcOfflineStrength, plr, offlineSeconds)
				if not okStrength then
					warn(string.format("[PodiumService] calcOfflineStrength failed for %s: %s", plr.Name, tostring(strengthAmount)))
					strengthAmount = 0
				end
				strengthAmount = math.floor(strengthAmount or 0)
				offlineStrengthPending[plr] = strengthAmount > 0 and strengthAmount or nil

				local okFlat, flatCash = pcall(calcOfflineFlatCash, plr, playerData, offlineSeconds)
				if not okFlat then
					warn(string.format("[PodiumService] calcOfflineFlatCash failed for %s: %s", plr.Name, tostring(flatCash)))
					flatCash = 0
				end
				flatCash = math.floor(flatCash or 0)
				offlineFlatCashPending[plr] = flatCash > 0 and flatCash or nil

				local total = flatCash + (offlineCashAutoCredited[plr] or 0)
				local pending = offlineCashPending[plr]
				if pending then
					for _, amt in pairs(pending) do total = total + (amt or 0) end
				end
				total = math.floor(total)
				if (total > 0 or strengthAmount > 0) and OfflineRewardReadyEvent then
					OfflineRewardReadyEvent:FireClient(plr, total, strengthAmount)
				end
			end)
		end

		task.defer(function()
			local plot = getPlotForPlayer(plr)
			if not plot then
				local attempts = 0
				while not plot and attempts < 50 do
					task.wait(0.2)
					plot = getPlotForPlayer(plr)
					attempts = attempts + 1
				end
			end
			if not plot then return end

			recalcTotalCashPerSec(plr)

			local state = buildFullPodiumState(plr)
			if state and state.Podiums then
				for i, payload in pairs(state.Podiums) do
					if payload then
						PodiumUpdateEvent:FireClient(plr, i, payload, plr.UserId)
					end
				end

				task.delay(2, function()
					if not plr.Parent then
						return
					end
					for i, payload in pairs(state.Podiums) do
						if payload then
							local refreshed = buildPodiumPayload(plr, i)
							if refreshed then
								PodiumUpdateEvent:FireClient(plr, i, refreshed, plr.UserId)
							end
						end
					end
				end)
			end

			local maxIdx = getMaxPodiumIndex(plot)
			for i = 1, maxIdx do
				local visualPayload = buildVisualPayload(plr, i)
				if visualPayload then
					for _, otherPlr in ipairs(Players:GetPlayers()) do
						if otherPlr ~= plr then
							PodiumUpdateEvent:FireClient(otherPlr, i, visualPayload, plr.UserId)
						end
					end
				end
			end
		end)

		task.defer(function()
			local pendingOffline = offlineCashPending[plr]
			if pendingOffline then
				for podiumIndex, amount in pairs(pendingOffline) do
					OfflineCashEvent:FireClient(plr, podiumIndex, amount)
				end
			end
		end)
	end)

	Players.PlayerRemoving:Connect(function(plr)

		local playerData = getPlayerData(plr)
		if playerData then
			playerData.LastLogin = os.time()
			-- Save this session's earning pace for the next join's offline cash
			-- (see GameConfig.OfflineCash). Short sessions keep the previous
			-- rate -- a 30s hop shouldn't wipe a real measurement.
			local rec = sessionEarnStart[plr]
			local cfg = GameConfig.OfflineCash or {}
			if rec then
				local seconds = os.clock() - rec.clock
				if seconds >= (cfg.MinSessionSeconds or 120) then
					local earned = math.max((playerData.TotalCash or 0) - rec.totalCash, 0)
					playerData.OfflineCashRate = earned / seconds
				end
			end
		end

		accumulatedCash[plr] = nil
		offlineCashPending[plr] = nil
		offlineStrengthPending[plr] = nil
		offlineCashAutoCredited[plr] = nil
		offlineFlatCashPending[plr] = nil
		sessionEarnStart[plr] = nil
		autoCollectElapsed[plr] = nil
		stealCooldowns[plr] = nil

		task.defer(function()
			for _, otherPlr in ipairs(Players:GetPlayers()) do
				PodiumUpdateEvent:FireClient(otherPlr, 0, nil, plr.UserId)
			end
		end)
	end)
end

return PodiumService