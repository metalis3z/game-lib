-- LootBlockService
-- Server side of the store loot blocks (GameConfig.Shop.LuckyBlockStore ->
-- GameConfig.LuckyBlocks[GrantBlockId] with IsLootBlock = true).
--
-- Two jobs:
--   1. DEV PRODUCT grants (user request 2026-07-16, was one-time
--      gamepasses): every purchase of a store card's product delivers ONE
--      GrantBlockId block into playerData.Inventory -- REPEATABLE.
--      PurchaseService routes the "LootBlock_<key>" receipt context to
--      GrantStoreBlock below.
--   2. In-hand opens: the client clicks while holding a loot block ->
--      RequestLootOpen rolls the block's weighted Loot table and answers with
--      the result, but the inventory mutation is DEFERRED until
--      ConfirmLootReveal (or a timeout / the player leaving) so the in-hand
--      open animation plays out with the block still equipped and the hotbar
--      doesn't spoil the reveal. Exactly one pending open per player.
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local LuckyBlockService = require(ServerScriptService.Source.Services.LuckyBlockService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local LootBlockService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local LuckyBlockRemotes = Remotes:WaitForChild("LuckyBlockService")
local RequestLootOpenFunc = LuckyBlockRemotes:WaitForChild("RequestLootOpen")
local ConfirmLootRevealEvent = LuckyBlockRemotes:WaitForChild("ConfirmLootReveal")
local RequestFreeLootBlockFunc = LuckyBlockRemotes:WaitForChild("RequestFreeLootBlock")

local OPEN_COOLDOWN = 1.0
local REVEAL_TIMEOUT = 20

local openCooldowns = {}
-- [player] = { Key, BlockId, LootId } -- at most one pending open each
local pendingOpens = {}

-- ---------------------------------------------------------------------
-- Dev product -> repeatable block grant
-- ---------------------------------------------------------------------

-- One block per purchase, as many purchases as the player wants. Called
-- by PurchaseService for the "LootBlock_<key>" receipt context.
function LootBlockService.GrantStoreBlock(player, storeKey)
	local storeCfg = (GameConfig.Shop.LuckyBlockStore or {})[storeKey]
	if not storeCfg then
		return false
	end
	local blockId = storeCfg.GrantBlockId
	if not blockId or not GameConfig.LuckyBlocks[blockId] then
		warn(string.format("[LootBlockService] %s has no valid GrantBlockId", storeKey))
		return false
	end
	if not LuckyBlockService.AddLuckyBlock(player, blockId, 1) then
		return false
	end
	PlayerDataService.ScheduleSave(player)
	print(string.format("[LootBlockService] granted %s to %s (product %s)", blockId, player.Name, storeKey))
	return true
end

-- Dev/testing hook (DevChatCommands): grants the block without touching the
-- one-time pass bookkeeping, so it can be re-run freely while tuning.
function LootBlockService.DevGrantBlock(player, storeKey, amount)
	local storeCfg = GameConfig.Shop.LuckyBlockStore[storeKey]
	if not storeCfg or not storeCfg.GrantBlockId then return false end
	return LuckyBlockService.AddLuckyBlock(player, storeCfg.GrantBlockId, amount or 1)
end

-- Pre-release path: while a store card has NO GamepassId configured, the buy
-- button grants the block directly (free) so the whole flow is testable. Dies
-- automatically the moment a real GamepassId is set on the entry.
local FREE_GRANT_COOLDOWN = 1.0
local freeGrantCooldowns = {}

local function onRequestFreeLootBlock(player, storeKey)
	if type(storeKey) ~= "string" then return false end
	local storeCfg = (GameConfig.Shop.LuckyBlockStore or {})[storeKey]
	if not storeCfg then return false end
	if storeCfg.ProductId and storeCfg.ProductId ~= 0 then return false end

	local now = os.clock()
	if freeGrantCooldowns[player] and (now - freeGrantCooldowns[player]) < FREE_GRANT_COOLDOWN then
		return false
	end
	freeGrantCooldowns[player] = now

	local blockId = storeCfg.GrantBlockId
	if not blockId or not GameConfig.LuckyBlocks[blockId] then return false end
	return LuckyBlockService.AddLuckyBlock(player, blockId, 1)
end

-- (The old gamepass flow -- one-time grantPassBlock, OwnsLootPass_<key>
-- attributes and the join-time UserOwnsGamePassAsync sweep -- was removed
-- 2026-07-16 with the switch to repeatable dev products. The three block
-- gamepasses are off-sale on the dashboard and were never sold; the
-- LuckyBlockPassGranted profile field stays untouched in old saves.)

-- ---------------------------------------------------------------------
-- In-hand open flow
-- ---------------------------------------------------------------------

local function rollLoot(cfg)
	local pool = cfg.Loot
	if not pool or #pool == 0 then return nil end
	local total = 0
	for _, e in ipairs(pool) do total += (e.Chance or 0) end
	if total <= 0 then return pool[math.random(1, #pool)].LootId end
	local roll = math.random() * total
	local cumulative = 0
	for _, e in ipairs(pool) do
		cumulative += (e.Chance or 0)
		if roll <= cumulative then return e.LootId end
	end
	return pool[#pool].LootId
end

-- Commits a rolled open: consume one block, deliver the loot item. The ITEM
-- is the whole reward -- its cash value is realized when it's sold at the
-- Sell Shop. Paying CashReward here too double-dipped (item + full value in
-- cash at open, then the value AGAIN at the sell counter).
local function applyPendingOpen(player, pending)
	local lootCfg = GameConfig.LuckyBlocks[pending.LootId]
	if not lootCfg then return end

	-- RemoveLuckyBlock handles the unequip-on-zero + Inventory change fires.
	if not LuckyBlockService.RemoveLuckyBlock(player, pending.BlockId, 1) then
		return -- block vanished (deleted mid-reveal); don't grant
	end
	LuckyBlockService.AddLuckyBlock(player, pending.LootId, 1)
	PlayerDataService.ScheduleSave(player)
end

local function onRequestLootOpen(player, blockId)
	if type(blockId) ~= "string" then return nil end
	if pendingOpens[player] then return nil end

	local now = os.clock()
	if openCooldowns[player] and (now - openCooldowns[player]) < OPEN_COOLDOWN then
		return nil
	end

	local cfg = GameConfig.LuckyBlocks[blockId]
	if not cfg or not cfg.IsLootBlock then return nil end

	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return nil end
	if playerData.EquippedItem ~= blockId then return nil end
	if ((playerData.Inventory or {})[blockId] or 0) <= 0 then return nil end

	local lootId = rollLoot(cfg)
	local lootCfg = lootId and GameConfig.LuckyBlocks[lootId]
	if not lootCfg then return nil end

	openCooldowns[player] = now

	local revealKey = blockId .. "_" .. tostring(now) .. "_" .. tostring(math.random(1000, 9999))
	local pending = {
		Key = revealKey,
		BlockId = blockId,
		LootId = lootId,
	}
	pendingOpens[player] = pending

	-- Safety net: a client that never confirms (crash, exploit, lag) still
	-- gets its paid-for loot committed.
	task.delay(REVEAL_TIMEOUT, function()
		if pendingOpens[player] == pending then
			pendingOpens[player] = nil
			applyPendingOpen(player, pending)
		end
	end)

	return {
		BlockId = blockId,
		LootId = lootId,
		LootName = lootCfg.DisplayName or lootId,
		LootRarity = lootCfg.Rarity or "Common",
		-- display-only sell value (nothing is paid at open)
		Cash = lootCfg.CashReward or 0,
		RevealKey = revealKey,
	}
end

local function onConfirmLootReveal(player, revealKey)
	local pending = pendingOpens[player]
	if not pending then return end
	if type(revealKey) ~= "string" or pending.Key ~= revealKey then return end
	pendingOpens[player] = nil
	applyPendingOpen(player, pending)
end

function LootBlockService.Init()
	RequestLootOpenFunc.OnServerInvoke = onRequestLootOpen
	RequestFreeLootBlockFunc.OnServerInvoke = onRequestFreeLootBlock
	ConfirmLootRevealEvent.OnServerEvent:Connect(onConfirmLootReveal)

	Players.PlayerRemoving:Connect(function(player)
		openCooldowns[player] = nil
		freeGrantCooldowns[player] = nil
		local pending = pendingOpens[player]
		if pending then
			pendingOpens[player] = nil
			applyPendingOpen(player, pending)
		end
	end)
end

return LootBlockService