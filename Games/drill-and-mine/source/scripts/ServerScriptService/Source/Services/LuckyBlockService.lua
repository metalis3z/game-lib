local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local LuckyBlockService = {}

-- Mutation roll wrapper: shared with island spawns, lives on GameConfig so the
-- rates can be retuned in one place. Returns a mutation id or nil for Normal.
-- The diagnostic print is intentionally cheap (string concat only when a mutation
-- actually fires) so it can stay in for live tuning; remove the `if mutation`
-- block below once we're confident the rates feel right.
local function rollMutation(player, brainrotId)
	if not GameConfig.RollIslandMutation then return nil end
	local mutation = GameConfig.RollIslandMutation()
	if mutation then
		print(string.format("[Mutation] %s rolled %s on %s",
			player and player.Name or "?",
			mutation,
			brainrotId or "?"))
	end
	return mutation
end

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local LuckyBlockRemotes = Remotes:WaitForChild("LuckyBlockService")
local RequestOpenFunc = LuckyBlockRemotes:WaitForChild("RequestOpen")
local OpenResultEvent = LuckyBlockRemotes:WaitForChild("OpenResult")
local ConfirmLuckyRevealEvent = LuckyBlockRemotes:WaitForChild("ConfirmLuckyReveal")
local DataUpdateEvent = Remotes:WaitForChild("PlayerDataService"):WaitForChild("DataUpdate")

local openCooldowns = {}
local pendingReveals = {}

local OPEN_COOLDOWN = 2.0
local REVEAL_TIMEOUT = 15

function LuckyBlockService.AddLuckyBlock(player, luckyBlockId, amount)
	if not GameConfig.LuckyBlocks[luckyBlockId] then return false end
	amount = (type(amount) == "number" and amount > 0) and math.floor(amount) or 1

	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return false end

	local inventory = playerData.Inventory
	inventory[luckyBlockId] = (inventory[luckyBlockId] or 0) + amount

	-- DataChanged is a server-only BindableEvent. The client's lucky-block
	-- hotbar slot updater (IslandBrainrotClient.syncLuckyBlockSlotsFromInventory)
	-- is bound to the DataUpdate RemoteEvent -- without firing the remote, the
	-- new block lands in player data but the player's UI never updates, so
	-- carrying one back from an island silently dropped it into the void.
	DataUpdateEvent:FireClient(player, "Inventory", inventory)
	PlayerDataService.DataChanged:Fire(player, "Inventory", inventory)
	return true
end

function LuckyBlockService.RemoveLuckyBlock(player, luckyBlockId, amount)
	amount = (type(amount) == "number" and amount > 0) and math.floor(amount) or 1

	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return false end

	local inventory = playerData.Inventory
	local current = inventory[luckyBlockId] or 0
	if current < amount then return false end

	inventory[luckyBlockId] = current - amount
	if inventory[luckyBlockId] <= 0 then
		inventory[luckyBlockId] = nil
		if playerData.EquippedItem == luckyBlockId then
			playerData.EquippedItem = ""
			PlayerDataService.DataChanged:Fire(player, "EquippedItem", playerData.EquippedItem)
		end
	end

	PlayerDataService.DataChanged:Fire(player, "Inventory", inventory)
	return true
end

-- Luck tier-up tuning. Per point of Luck above 1.0 each roll has
-- LUCK_TIERUP_PER_POINT chance (capped at LUCK_TIERUP_CAP) to climb one rarity
-- and roll from that higher tier's loot table. The check repeats each step,
-- but the total climb is hard-capped at MAX_TIER_CLIMB so a Common block can
-- at most yield Rare brainrots and never Mythic/Exclusive -- enforcing the
-- "you have to progress islands to access the good loot" expectation.
-- Luck = 1.00 still gives a 0% step chance (identical to a flat roll).
local LUCK_TIERUP_PER_POINT = 0.08
local LUCK_TIERUP_CAP = 0.65
local MAX_TIER_CLIMB = 2

local _rarityIndex
local function rarityIndex()
	if not _rarityIndex then
		_rarityIndex = {}
		for i, r in ipairs(GameConfig.LuckyBlockRarityOrder or {}) do
			_rarityIndex[r] = i
		end
	end
	return _rarityIndex
end

-- Picks one entry's BrainrotId from `pool` (weighted by Chance). Entries whose
-- BrainrotId isn't a real GameConfig.Items entry are skipped -- a stale config
-- with phantom ids would otherwise let the roll "succeed" with an unrenderable
-- id, which broke the at-the-pad unbox animation (the reel cloned no models).
local function weightedPick(pool)
	if not pool or #pool == 0 then return nil end
	local validPool = {}
	for _, e in ipairs(pool) do
		if e.BrainrotId and GameConfig.Items[e.BrainrotId] then
			validPool[#validPool + 1] = e
		end
	end
	if #validPool == 0 then return nil end
	local total = 0
	for _, e in ipairs(validPool) do total = total + (e.Chance or 0) end
	if total <= 0 then return validPool[math.random(1, #validPool)].BrainrotId end
	local roll = math.random() * total
	local cumulative = 0
	for _, e in ipairs(validPool) do
		cumulative = cumulative + (e.Chance or 0)
		if roll <= cumulative then return e.BrainrotId end
	end
	return validPool[#validPool].BrainrotId
end

-- Returns a non-empty pool from LuckyBlockLootByRarity at `rarity` whose ids
-- all resolve in GameConfig.Items, or nil if none of that rarity's entries are
-- live. Used as a fallback when a block's own PossibleBrainrots ends up empty
-- (e.g. its config references ids that no longer exist in the pack).
local function getLiveRarityPool(rarity)
	local pool = GameConfig.LuckyBlockLootByRarity and GameConfig.LuckyBlockLootByRarity[rarity]
	if not pool then return nil end
	for _, e in ipairs(pool) do
		if e.BrainrotId and GameConfig.Items[e.BrainrotId] then
			return pool
		end
	end
	return nil
end

local function rollBrainrot(luckyBlockId)
	local cfg = GameConfig.LuckyBlocks[luckyBlockId]
	if not cfg or not cfg.PossibleBrainrots then return nil end

	local pool = cfg.PossibleBrainrots
	local order = GameConfig.LuckyBlockRarityOrder
	local startIdx = order and rarityIndex()[cfg.Rarity or ""]
	local luck = tonumber(cfg.Luck) or 1

	-- Luck-driven tier-up: roll a chance per step to climb one rarity and pull
	-- the loot table from that higher tier instead. Hard-capped at
	-- startIdx + MAX_TIER_CLIMB so high-luck stacking can't punch past the
	-- intended ceiling.
	if order and startIdx and luck > 1 then
		local stepChance = math.clamp((luck - 1) * LUCK_TIERUP_PER_POINT, 0, LUCK_TIERUP_CAP)
		local maxIdx = math.min(#order, startIdx + MAX_TIER_CLIMB)
		local idx = startIdx
		while idx < maxIdx and math.random() < stepChance do
			idx = idx + 1
		end
		if idx ~= startIdx then
			local upgraded = GameConfig.LuckyBlockLootByRarity
				and GameConfig.LuckyBlockLootByRarity[order[idx]]
			if upgraded and #upgraded > 0 then
				pool = upgraded
			end
		end
	end

	local picked = weightedPick(pool)
	if picked then return picked end

	-- Pool was unusable (empty, or every id missing from GameConfig.Items). Walk
	-- the rarity ladder looking for a live fallback so a stale config can’t
	-- consume the player’s lucky block with no reward.
	if order and startIdx then
		for i = startIdx, #order do
			local fallback = getLiveRarityPool(order[i])
			if fallback then
				local id = weightedPick(fallback)
				if id then return id end
			end
		end
		for i = startIdx - 1, 1, -1 do
			local fallback = getLiveRarityPool(order[i])
			if fallback then
				local id = weightedPick(fallback)
				if id then return id end
			end
		end
	end
	return nil
end

local function getOpenCount(currentAmount)
	if currentAmount >= 8 then
		return 8
	elseif currentAmount >= 3 then
		return 3
	else
		return math.min(1, currentAmount)
	end
end

local function applyPendingBrainrots(player, pendingData)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return end

	local brainrotInv = playerData.BrainrotInventory
	if not brainrotInv then
		playerData.BrainrotInventory = {}
		brainrotInv = playerData.BrainrotInventory
	end

	for _, entry in ipairs(pendingData) do
		brainrotInv[entry.UniqueId] = {
			BrainrotId = entry.BrainrotId,
			Mutation = entry.Mutation,
			Timestamp = entry.Timestamp,
		}
		playerData.BrainrotUnlocked[entry.BrainrotId] = true
	end

	PlayerDataService.DataChanged:Fire(player, "BrainrotInventory", brainrotInv)
	PlayerDataService.DataChanged:Fire(player, "BrainrotUnlocked", playerData.BrainrotUnlocked)
	DataUpdateEvent:FireClient(player, "BrainrotInventory", brainrotInv)
	DataUpdateEvent:FireClient(player, "BrainrotUnlocked", playerData.BrainrotUnlocked)
end

-- Shop instant-open: bypasses inventory + equipped checks, but DOES use the
-- same pendingReveals+confirm flow as the inventory path so the brainrot only
-- lands in the player's hotbar when the reveal animation finishes (otherwise
-- the inventory would flash the new item before the unbox plays).
-- Safety nets so a paid purchase is never lost:
--   * REVEAL_TIMEOUT task.delay auto-applies if confirm never arrives.
--   * Players.PlayerRemoving handler (Init) drains every pendingReveals entry.
function LuckyBlockService.InstantOpenForShop(player, luckyBlockId, count)
	if type(luckyBlockId) ~= "string" then return false end
	if type(count) ~= "number" then return false end

	count = math.max(1, math.min(20, math.floor(count)))

	local cfg = GameConfig.LuckyBlocks[luckyBlockId]
	if not cfg then return false end
	if cfg.IsLootBlock or cfg.IsLootItem then return false end

	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return false end

	local results = {}
	local pendingBrainrots = {}
	local ts = os.time()

	for i = 1, count do
		local brainrotId = rollBrainrot(luckyBlockId)
		if brainrotId then
			local mutation = rollMutation(player, brainrotId)
			local isNewDiscovery = not playerData.BrainrotUnlocked[brainrotId]
			local uniqueId = brainrotId .. "_" .. tostring(ts) .. "_" .. tostring(i) .. "_" .. tostring(math.random(1000, 9999))

			table.insert(pendingBrainrots, {
				UniqueId = uniqueId,
				BrainrotId = brainrotId,
				Mutation = mutation,
				Timestamp = ts,
			})

			table.insert(results, {
				BrainrotId = brainrotId,
				Mutation = mutation,
				IsNewDiscovery = isNewDiscovery,
			})
		end
	end

	if #results == 0 then return false end

	local revealKey = luckyBlockId .. "_shop_" .. tostring(os.clock()) .. "_" .. tostring(math.random(1000, 9999))
	if not pendingReveals[player] then pendingReveals[player] = {} end
	pendingReveals[player][revealKey] = pendingBrainrots

	task.delay(REVEAL_TIMEOUT, function()
		if pendingReveals[player] and pendingReveals[player][revealKey] then
			local data = pendingReveals[player][revealKey]
			pendingReveals[player][revealKey] = nil
			applyPendingBrainrots(player, data)
			PlayerDataService.ScheduleSave(player)
		end
	end)

	local possibleIds = {}
	for _, entry in ipairs(cfg.PossibleBrainrots) do
		table.insert(possibleIds, entry.BrainrotId)
	end

	OpenResultEvent:FireClient(player, {
		LuckyBlockId = luckyBlockId,
		OpenCount = #results,
		Results = results,
		PossibleBrainrots = possibleIds,
		RevealKey = revealKey,
	})

	return true
end

local function onRequestOpen(player, luckyBlockId)
	if type(luckyBlockId) ~= "string" then return false end

	local now = os.clock()
	if openCooldowns[player] and (now - openCooldowns[player]) < OPEN_COOLDOWN then
		return false
	end
	openCooldowns[player] = now

	local cfg = GameConfig.LuckyBlocks[luckyBlockId]
	if not cfg then return false end
	-- Store loot blocks / loot items never roll brainrots -- their open path
	-- is LootBlockService.RequestLootOpen. Guarding BEFORE the decrement so a
	-- stray request can't consume blocks with no payout.
	if cfg.IsLootBlock or cfg.IsLootItem then return false end

	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return false end

	local inventory = playerData.Inventory or {}
	local current = inventory[luckyBlockId] or 0
	if current <= 0 then return false end
	if playerData.EquippedItem ~= luckyBlockId then return false end

	local openCount = getOpenCount(current)

	inventory[luckyBlockId] = current - openCount
	if inventory[luckyBlockId] <= 0 then
		inventory[luckyBlockId] = nil
		if playerData.EquippedItem == luckyBlockId then
			playerData.EquippedItem = ""
			PlayerDataService.DataChanged:Fire(player, "EquippedItem", playerData.EquippedItem)
		end
	end

	local results = {}
	local pendingBrainrots = {}
	local ts = os.time()

	for _ = 1, openCount do
		local brainrotId = rollBrainrot(luckyBlockId)
		if not brainrotId then continue end

		local mutation = rollMutation(player, brainrotId)
		local isNewDiscovery = not playerData.BrainrotUnlocked[brainrotId]

		local uniqueId = brainrotId .. "_" .. tostring(ts) .. "_" .. tostring(math.random(1000, 9999))

		table.insert(pendingBrainrots, {
			UniqueId = uniqueId,
			BrainrotId = brainrotId,
			Mutation = mutation,
			Timestamp = ts,
		})

		table.insert(results, {
			BrainrotId = brainrotId,
			Mutation = mutation,
			IsNewDiscovery = isNewDiscovery,
		})
	end

	if #results == 0 then return false end

	PlayerDataService.DataChanged:Fire(player, "Inventory", inventory)

	local possibleIds = {}
	for _, entry in ipairs(cfg.PossibleBrainrots) do
		table.insert(possibleIds, entry.BrainrotId)
	end

	local revealKey = luckyBlockId .. "_" .. tostring(os.clock()) .. "_" .. tostring(math.random(1000, 9999))
	if not pendingReveals[player] then pendingReveals[player] = {} end
	pendingReveals[player][revealKey] = pendingBrainrots

	task.delay(REVEAL_TIMEOUT, function()
		if pendingReveals[player] and pendingReveals[player][revealKey] then
			local data = pendingReveals[player][revealKey]
			pendingReveals[player][revealKey] = nil
			applyPendingBrainrots(player, data)
		end
	end)

	OpenResultEvent:FireClient(player, {
		LuckyBlockId = luckyBlockId,
		OpenCount = openCount,
		Results = results,
		PossibleBrainrots = possibleIds,
		RevealKey = revealKey,
	})

	return true
end

-- Pad-placement open path: PodiumService calls this when the player presses E
-- on a placed lucky block. Rolls one brainrot, writes it directly into the
-- player's PlacedBrainrot[podiumIndex] (replacing the lucky-block entry) so
-- the brainrot stays on the pad. The reveal animation runs on the client via
-- OpenResult; it's a visual flourish only — the placement is the source of
-- truth and persists across sessions.
function LuckyBlockService.OpenPlacedBlock(player, luckyBlockId, podiumIndex)
	if type(luckyBlockId) ~= "string" then return false end
	local cfg = GameConfig.LuckyBlocks[luckyBlockId]
	if not cfg then return false end

	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return false end

	local brainrotId = rollBrainrot(luckyBlockId)
	if not brainrotId then return false end

	local mutation = rollMutation(player, brainrotId)

	local ts = os.time()
	local uniqueId = brainrotId .. "_" .. tostring(ts) .. "_pad_" .. tostring(math.random(1000, 9999))

	playerData.PlacedBrainrot = playerData.PlacedBrainrot or {}
	-- UniqueId has to be the *unique* id we just built (line above), not the
	-- brainrotId -- otherwise two lucky-blocks rolling the same brainrot kind
	-- collide on the BrainrotInventory map when removed from their pads, and
	-- the returnBrainrotToInventory call overwrites whichever entry already
	-- lives there. This was making removed-from-pad brainrots silently
	-- replace existing inventory entries instead of stacking next to them.
	playerData.PlacedBrainrot[tostring(podiumIndex)] = {
		UniqueId = uniqueId,
		BrainrotId = brainrotId,
		Level = 1,
		Mutation = mutation,
	}
	playerData.BrainrotUnlocked = playerData.BrainrotUnlocked or {}
	playerData.BrainrotUnlocked[brainrotId] = true

	PlayerDataService.DataChanged:Fire(player, "PlacedBrainrot", playerData.PlacedBrainrot)
	PlayerDataService.DataChanged:Fire(player, "BrainrotUnlocked", playerData.BrainrotUnlocked)
	-- IndexController listens to DataUpdate (the *client-facing* remote) for
	-- BrainrotUnlocked; without this fire the pad-open path was the only unbox
	-- route that never refreshed the index, so the silhouette card stayed black
	-- until the next data round-trip.
	DataUpdateEvent:FireClient(player, "BrainrotUnlocked", playerData.BrainrotUnlocked)
	DataUpdateEvent:FireClient(player, "PlacedBrainrot", playerData.PlacedBrainrot)
	PlayerDataService.ScheduleSave(player)

	local possibleIds = {}
	for _, e in ipairs(cfg.PossibleBrainrots or {}) do
		table.insert(possibleIds, e.BrainrotId)
	end

	OpenResultEvent:FireClient(player, {
		LuckyBlockId = luckyBlockId,
		OpenCount = 1,
		Results = { { BrainrotId = brainrotId, Mutation = mutation, IsNewDiscovery = false } },
		PossibleBrainrots = possibleIds,
		RevealKey = "",
		SkipInventoryAdd = true,
		-- PodiumController keys the pad unboxing animation off this so the
		-- roll/reveal plays above the correct slot.
		PodiumIndex = podiumIndex,
	})
	return true
end

local function onConfirmLuckyReveal(player, revealKey)
	if type(revealKey) ~= "string" then return end
	if not pendingReveals[player] then return end
	if not pendingReveals[player][revealKey] then return end

	local data = pendingReveals[player][revealKey]
	pendingReveals[player][revealKey] = nil
	applyPendingBrainrots(player, data)
	PlayerDataService.ScheduleSave(player)
end

function LuckyBlockService.Init()
	RequestOpenFunc.OnServerInvoke = onRequestOpen
	ConfirmLuckyRevealEvent.OnServerEvent:Connect(onConfirmLuckyReveal)

	Players.PlayerRemoving:Connect(function(player)
		openCooldowns[player] = nil

		if pendingReveals[player] then
			for _, data in pairs(pendingReveals[player]) do
				applyPendingBrainrots(player, data)
			end
			pendingReveals[player] = nil
		end
	end)
end

return LuckyBlockService