local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataService = require(ReplicatedStorage.Packages.DataService).server
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local InventoryItemUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryItemUtils)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local TutorialServiceUtils = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceUtils)
local MonetizationServiceUtils = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)

local Food = nil
do
	local ok, result = pcall(function()
		return require(ReplicatedStorage.Source.Game.Items.Food)
	end)
	if ok then
		Food = result
		print("[InventoryService] Food module loaded")
	else
		warn("[InventoryService] Food module not found:", result)
	end
end

local BoostService = nil

local InventoryService = {}

local feedLocks = {}
local FEED_COOLDOWN = 0.5

local function acquireFeedLock(userId: number, slimeId: string): boolean
	local key = tostring(userId) .. "_" .. slimeId
	if feedLocks[key] then return false end
	feedLocks[key] = true
	task.delay(FEED_COOLDOWN, function()
		feedLocks[key] = nil
	end)
	return true
end

local function getEquippedCount(equipped)
	if type(equipped) ~= "table" then return 0 end
	local count = 0
	for k, v in pairs(equipped) do
		if (type(k) == "number" and type(v) == "string") or
			(type(k) == "string" and v == true) then
			count += 1
		end
	end
	return count
end

local function getEquippedSet(equipped)
	local set = {}
	for k, v in pairs(equipped) do
		if type(k) == "number" and type(v) == "string" then
			set[v] = true
		elseif type(k) == "string" and v == true then
			set[k] = true
		end
	end
	return set
end

local function getMaxSlots(upgrades, extraSlots)
	return InventoryServiceUtils.getOwnedSlotCount(upgrades, extraSlots or 0)
end

function InventoryService:init()
	task.defer(function()
		local ok, result = pcall(function()
			return require(script.Parent.BoostService)
		end)
		if ok and result then
			BoostService = result
			print("[InventoryService] BoostService linked")
		else
			warn("[InventoryService] Could not link BoostService:", result,
				"- boost items will still deduct stock but won't activate the boost effect.")
		end
	end)

	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[InventoryService] Could not find _remotes")
		return
	end

	local inventoryRemotes = remotes:WaitForChild("InventoryService", 10)
	if not inventoryRemotes then
		warn("[InventoryService] Could not find InventoryService remotes")
		return
	end

	local remoteFunction = inventoryRemotes:FindFirstChild("RemoteFunction")
	if remoteFunction then
		remoteFunction.OnServerInvoke = function(player: Player, method: string, ...)
			print("[InventoryService] Invoked - method:", method, "player:", player.Name)
			if method == "requestEquip" then
				return self:requestEquip(player, ...)
			elseif method == "requestEquipIfSpace" then
				return self:requestEquipIfSpace(player, ...)
			elseif method == "requestUnequip" then
				return self:requestUnequip(player, ...)
			elseif method == "requestEquipBest" then
				return self:requestEquipBest(player)
			elseif method == "requestUseItem" then
				return self:requestUseItem(player, ...)
			elseif method == "requestUnarmSpecialDice" then
				return self:requestUnarmSpecialDice(player, ...)
			elseif method == "requestUseFood" then
				return self:requestUseFood(player, ...)
			end
			warn("[InventoryService] Unknown method:", method)
			return false, "unknown"
		end
		print("[InventoryService] OnServerInvoke set successfully")
	else
		warn("[InventoryService] RemoteFunction not found")
	end

	local remoteEvent = inventoryRemotes:FindFirstChild("RemoteEvent")
	if remoteEvent then
		remoteEvent.OnServerEvent:Connect(function(player: Player, method: string, ...)
			if method == "requestEquip" then self:requestEquip(player, ...)
			elseif method == "requestEquipIfSpace" then self:requestEquipIfSpace(player, ...)
			elseif method == "requestUnequip" then self:requestUnequip(player, ...)
			elseif method == "requestEquipBest" then self:requestEquipBest(player)
			end
		end)
	end

	print("[InventoryService] Initialized")
end

function InventoryService:requestEquip(player: Player, uniqueId: string)
	if type(uniqueId) ~= "string" then return false, "Invalid slot" end
	local data = DataService:waitForData(player)
	if not data then return false, "No data" end

	local inventory = data:get("inventory") or {}
	local equipped  = data:get("equipped")  or {}
	local upgrades  = data:get("upgrades")  or {}

	if type(inventory[uniqueId]) ~= "table" then
		return false, "Slime not found in inventory"
	end

	local equippedSet   = getEquippedSet(equipped)
	local maxSlots      = getMaxSlots(upgrades)
	local equippedCount = getEquippedCount(equipped)

	if equippedSet[uniqueId] then
		return false, "No available slime copies to equip"
	end

	local newEquipped = table.clone(equipped)

	if equippedCount < maxSlots then
		newEquipped[equippedCount + 1] = uniqueId
	else
		local worstSlot  = nil
		local worstScore = math.huge
		for k, v in pairs(newEquipped) do
			if type(k) == "number" and type(v) == "string" then
				local slimeData = inventory[v]
				if slimeData then
					local ok, stats = pcall(InventoryServiceUtils.getSlimeStatsFromData, slimeData)
					local score = ok and (stats.damage + stats.maxHealth) or 0
					if score < worstScore then
						worstScore = score
						worstSlot  = k
					end
				end
			end
		end
		if not worstSlot then
			return false, "No slime equipped to replace"
		end
		newEquipped[worstSlot] = uniqueId
	end

	DataService:set(player, "equipped", newEquipped)
	print("[InventoryService] Equipped", uniqueId, "for", player.Name)
	return true
end

-- ─── requestEquipIfSpace ──────────────────────────────────────────────────────
function InventoryService:requestEquipIfSpace(player: Player, uniqueId: string)
	if type(uniqueId) ~= "string" then return false, "Invalid slot" end
	local data = DataService:waitForData(player)
	if not data then return false, "No data" end

	local inventory = data:get("inventory") or {}
	local equipped  = data:get("equipped")  or {}
	local upgrades  = data:get("upgrades")  or {}

	if type(inventory[uniqueId]) ~= "table" then
		return false, "Slime not found in inventory"
	end

	local equippedSet   = getEquippedSet(equipped)
	local equippedCount = getEquippedCount(equipped)
	local maxSlots      = getMaxSlots(upgrades)

	if equippedSet[uniqueId] then
		return false, "No available slime copies to equip"
	end
	if equippedCount >= maxSlots then
		return false, "No empty slime slot available"
	end

	local newEquipped = table.clone(equipped)
	newEquipped[equippedCount + 1] = uniqueId

	DataService:set(player, "equipped", newEquipped)
	print("[InventoryService] Auto-equipped", uniqueId, "for", player.Name)
	return true
end

-- ─── requestUnequip ───────────────────────────────────────────────────────────
function InventoryService:requestUnequip(player: Player, slotOrUid)
	local data = DataService:waitForData(player)
	if not data then return false, "No data" end

	local equipped    = data:get("equipped") or {}
	local newEquipped = {}
	local removed     = false

	if type(slotOrUid) == "number" then
		for k, v in pairs(equipped) do
			if type(k) == "number" and type(v) == "string" then
				if k ~= slotOrUid then
					newEquipped[k] = v
				else
					removed = true
				end
			elseif type(k) == "string" and v == true then
				newEquipped[k] = v
			end
		end
	elseif type(slotOrUid) == "string" then
		for k, v in pairs(equipped) do
			if type(k) == "number" and type(v) == "string" then
				if v ~= slotOrUid then newEquipped[k] = v else removed = true end
			elseif type(k) == "string" and v == true then
				if k ~= slotOrUid then newEquipped[k] = v else removed = true end
			end
		end
	else
		return false, "Invalid slot"
	end

	if removed then
		local packed = {}
		local i = 1
		for k = 1, 10 do
			if newEquipped[k] then packed[i] = newEquipped[k]; i += 1 end
		end
		for k, v in pairs(newEquipped) do
			if type(k) == "string" then packed[k] = v end
		end
		newEquipped = packed
	end

	if not removed then
		return false, "No slime equipped in that slot"
	end

	DataService:set(player, "equipped", newEquipped)
	print("[InventoryService] Unequipped slot/uid:", slotOrUid, "for", player.Name)
	return true
end

function InventoryService:requestEquipBest(player: Player)
	local data = DataService:waitForData(player)
	if not data then return false, "No data" end

	local inventory = data:get("inventory") or {}
	local upgrades  = data:get("upgrades")  or {}
	local maxSlots  = getMaxSlots(upgrades)

	local bestIds = InventoryServiceUtils.getBestEquippedUniqueIds(inventory, maxSlots)
	local newEquipped = {}
	for i, uid in ipairs(bestIds) do
		newEquipped[i] = uid
	end

	DataService:set(player, "equipped", newEquipped)
	print("[InventoryService] EquipBest for", player.Name, "- slots:", #bestIds)
	return true
end

function InventoryService:requestUseItem(player: Player, itemId: string)
	if type(itemId) ~= "string" then
		return false, "Item cannot be used"
	end

	local data = DataService:waitForData(player)
	if not data then return false, "No data" end

	local definition = InventoryItemUtils.getDefinition(itemId)
	if not definition then
		warn("[InventoryService] requestUseItem: unknown item:", itemId, "for", player.Name)
		return false, "Unknown item"
	end

	if definition.kind == "boost" then
		local items = data:get("items") or {}
		local owned = items[itemId] or 0

		if owned <= 0 then
			return false, "No food available" -- reuse client-friendly error key
		end

		local newItems = table.clone(items)
		local remaining = owned - 1
		if remaining <= 0 then
			newItems[itemId] = nil
		else
			newItems[itemId] = remaining
		end
		DataService:set(player, "items", newItems)

		local boostKind = definition.boostKind
		if BoostService and boostKind then
			local ok, err = pcall(function()
				BoostService:applyBoost(player, boostKind, 1)
			end)
			if not ok then
				warn("[InventoryService] BoostService:applyBoost failed:", err)
			end
		else
			if boostKind then
				local boosts = data:get("boosts") or {}
				local newBoosts = table.clone(boosts)
				local current = type(newBoosts[boostKind]) == "number" and newBoosts[boostKind] or 0
				newBoosts[boostKind] = current + 1
				DataService:set(player, "boosts", newBoosts)
				print(string.format(
					"[InventoryService] Applied boost '%s' to %s (fallback path, no BoostService)",
					boostKind, player.Name
					))
			end
		end

		print(string.format(
			"[InventoryService] Used boost item '%s' (boostKind=%s) for %s | remaining: %d",
			itemId, tostring(definition.boostKind), player.Name, remaining
			))
		return true, nil

	elseif definition.kind == "specialDice" then
		return false, "No armed special dice"

	else
		warn("[InventoryService] requestUseItem: unhandled kind:", definition.kind, "for", player.Name)
		return false, "Item cannot be used"
	end
end

function InventoryService:requestUnarmSpecialDice(player: Player, diceId: string)
	return false, "No armed special dice"
end

function InventoryService:requestUseFood(player: Player, foodId: string, slimeUniqueId: string, amount: number?)
	if type(foodId) ~= "string" then
		return false, "Invalid food", nil
	end
	if type(slimeUniqueId) ~= "string" then
		return false, "Invalid slime", nil
	end

	if not acquireFeedLock(player.UserId, slimeUniqueId) then
		warn("[InventoryService] Duplicate feed request dropped for", player.Name, "slime:", slimeUniqueId)
		return false, "Processing, please wait", nil
	end

	if not Food then
		warn("[InventoryService] Food module not loaded")
		return false, "Invalid food", nil
	end

	local foodDef = Food.getFood(foodId)
	if not foodDef then
		return false, "Invalid food", nil
	end

	local feedAmount = math.max(math.floor(amount or 1), 1)

	local data = DataService:waitForData(player)
	if not data then return false, "No data", nil end

	local items     = data:get("items")     or {}
	local inventory = data:get("inventory") or {}

	local slimeRawData = inventory[slimeUniqueId]
	if type(slimeRawData) ~= "table" then
		return false, "Invalid slime", nil
	end

	local ownedAmount = items[foodId] or 0
	if ownedAmount <= 0 then
		return false, "No food available", nil
	end
	if ownedAmount < feedAmount then
		feedAmount = ownedAmount
	end

	local xpPerFood = foodDef.xp or 0
	local totalXp   = xpPerFood * feedAmount
	if totalXp <= 0 then
		return false, "Invalid food", nil
	end

	local slimeData    = InventoryServiceUtils.getSlimeData(slimeUniqueId, slimeRawData)
	local newSlimeData = InventoryServiceUtils.addXp(slimeData, totalXp)

	local newInventory = table.clone(inventory)
	newInventory[slimeUniqueId] = newSlimeData

	local newItems = table.clone(items)
	local remaining = ownedAmount - feedAmount
	if remaining <= 0 then
		newItems[foodId] = nil
	else
		newItems[foodId] = remaining
	end

	DataService:set(player, "inventory", newInventory)
	DataService:set(player, "items",     newItems)

	print(string.format(
		"[InventoryService] Fed %d x %s (+%d xp) to slime %s | level: %d → %d | player: %s",
		feedAmount, foodId, totalXp,
		slimeUniqueId,
		slimeData.level, newSlimeData.level,
		player.Name
		))
	return true, nil, slimeUniqueId
end

return InventoryService