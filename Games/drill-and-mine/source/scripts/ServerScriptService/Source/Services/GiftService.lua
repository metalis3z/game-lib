-- GiftService
-- Server half of player-to-player gifting. GiftController puts a local-only
-- hold-3s "Gift" ProximityPrompt on every other player while the local player
-- is holding something giftable; triggering it fires GiftRequest with the
-- target player. The server re-derives what the giver is actually holding
-- (never trusts the client) and hands it over:
--   1. an equipped claimed rarity-loot Tool (RarityLootTool attribute) ->
--      moved between session claimed-lists via RarityItemSpawner's
--      GiftClaimedLoot BindableFunction (its state is script-local there)
--   2. else the equipped lucky block / loot item (playerData.EquippedItem
--      pointing at a GameConfig.LuckyBlocks entry) -> Remove/AddLuckyBlock
-- Drills are not part of either holding system, so they can never be gifted.
-- Both sides get a GiftResult payload their GiftController turns into toasts.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local LuckyBlockService = require(ServerScriptService.Source.Services.LuckyBlockService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local GiftService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local giftRemotes = Remotes:FindFirstChild("Gift")
if not giftRemotes then
	giftRemotes = Instance.new("Folder")
	giftRemotes.Name = "Gift"
	giftRemotes.Parent = Remotes
end
local function ensureEvent(name)
	local ev = giftRemotes:FindFirstChild(name)
	if not ev then
		ev = Instance.new("RemoteEvent")
		ev.Name = name
		ev.Parent = giftRemotes
	end
	return ev
end
local GiftRequestEvent = ensureEvent("GiftRequest") -- (targetPlayer) client -> server
local GiftResultEvent = ensureEvent("GiftResult")   -- (payload) -> giver and receiver

local DataUpdateEvent = Remotes:WaitForChild("PlayerDataService"):WaitForChild("DataUpdate")

-- Prompt shows at 8 studs; extra slack covers latency + both characters moving
-- during the 3s hold.
local GIFT_DISTANCE_LIMIT = 16
local GIFT_COOLDOWN = 1.0

local giftCooldowns = {}

-- RarityItemSpawner owns the claimed-loot session lists; it exposes gifting
-- through a BindableFunction child created at its startup. Resolved lazily --
-- gifting can't happen before both scripts are long done initializing.
local giftClaimedLootFunc = nil
local function getGiftClaimedLootFunc()
	if giftClaimedLootFunc and giftClaimedLootFunc.Parent then
		return giftClaimedLootFunc
	end
	local spawner = ServerScriptService:FindFirstChild("RarityItemSpawner")
	giftClaimedLootFunc = spawner and spawner:FindFirstChild("GiftClaimedLoot") or nil
	return giftClaimedLootFunc
end

local function findEquippedLootTool(character)
	for _, child in ipairs(character:GetChildren()) do
		if child:IsA("Tool") and child:GetAttribute("RarityLootTool") then
			return child
		end
	end
	return nil
end

local function fireSuccess(giver, receiver, itemName)
	GiftResultEvent:FireClient(giver, {
		Ok = true,
		Role = "Giver",
		ItemName = itemName,
		OtherName = receiver.DisplayName,
	})
	GiftResultEvent:FireClient(receiver, {
		Ok = true,
		Role = "Receiver",
		ItemName = itemName,
		OtherName = giver.DisplayName,
	})
end

local function onGiftRequest(giver, target)
	if typeof(target) ~= "Instance" or not target:IsA("Player") then return end
	if target == giver or target.Parent ~= Players then return end

	local now = os.clock()
	if giftCooldowns[giver] and (now - giftCooldowns[giver]) < GIFT_COOLDOWN then return end

	local giverChar = giver.Character
	local targetChar = target.Character
	local giverHrp = giverChar and giverChar:FindFirstChild("HumanoidRootPart")
	local targetHrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
	if not giverHrp or not targetHrp then return end
	if (giverHrp.Position - targetHrp.Position).Magnitude > GIFT_DISTANCE_LIMIT then
		GiftResultEvent:FireClient(giver, { Ok = false, Reason = "TooFar" })
		return
	end

	-- 1) equipped claimed-loot tool wins -- it's the thing visibly in hand
	-- (EquipVisualController hides the held-block visual while a Tool is out,
	-- so this priority matches what both players can see)
	local lootTool = findEquippedLootTool(giverChar)
	if lootTool then
		local uid = lootTool:GetAttribute("LootUid")
		local giftFunc = getGiftClaimedLootFunc()
		local entry = (type(uid) == "string" and giftFunc) and giftFunc:Invoke(giver, target, uid) or nil
		if entry then
			giftCooldowns[giver] = now
			fireSuccess(giver, target, entry.Item)
		end
		return
	end

	-- 2) equipped lucky block / loot item (one copy per gift)
	local giverData = PlayerDataService.GetPlayerData(giver)
	if not giverData or not PlayerDataService.GetPlayerData(target) then return end
	local itemId = giverData.EquippedItem or ""
	local cfg = itemId ~= "" and GameConfig.LuckyBlocks[itemId] or nil
	if not cfg then return end

	if not LuckyBlockService.RemoveLuckyBlock(giver, itemId, 1) then return end
	LuckyBlockService.AddLuckyBlock(target, itemId, 1)
	-- RemoveLuckyBlock only fires the server-side DataChanged; the giver's
	-- hotbar slot updater listens to the DataUpdate REMOTE (same reason
	-- AddLuckyBlock fires it for the receiver)
	DataUpdateEvent:FireClient(giver, "Inventory", giverData.Inventory)
	PlayerDataService.ScheduleSave(giver)
	PlayerDataService.ScheduleSave(target)

	giftCooldowns[giver] = now
	fireSuccess(giver, target, cfg.DisplayName or itemId)
end

function GiftService.Init()
	GiftRequestEvent.OnServerEvent:Connect(onGiftRequest)
	Players.PlayerRemoving:Connect(function(player)
		giftCooldowns[player] = nil
	end)
end

return GiftService