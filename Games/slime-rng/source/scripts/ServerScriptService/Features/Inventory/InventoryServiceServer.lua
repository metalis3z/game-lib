local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local DataService = require(ReplicatedStorage.Packages.DataService).server
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)

local InventoryServiceServer = {}

function InventoryServiceServer:init()
	print("[InventoryServiceServer] Initialized")
end

-- Add an item to a player's inventory
-- @param player Player - The player to give the item to
-- @param itemId string - The item ID (e.g., "bigDice", "food_apple")
-- @param amount number - The amount to add (default: 1)
-- @return boolean - Whether the item was added successfully
function InventoryServiceServer:addItem(player, itemId, amount)
	if not player or not player:IsA("Player") then
		warn("[InventoryServiceServer] Invalid player passed to addItem")
		return false
	end

	if type(itemId) ~= "string" then
		warn("[InventoryServiceServer] Invalid itemId passed to addItem")
		return false
	end

	amount = math.max(math.floor(amount or 1), 1)

	local data = DataService:waitForData(player)
	if not data then
		warn("[InventoryServiceServer] Could not get data for player:", player.Name)
		return false
	end

	local items = data:get("items") or {}
	local newItems = table.clone(items)
	local current = newItems[itemId] or 0
	newItems[itemId] = current + amount

	DataService:set(player, "items", newItems)
	print(string.format("[InventoryServiceServer] Added %d x %s to %s's inventory", amount, itemId, player.Name))
	return true
end

-- Add a slime to a player's inventory
-- @param player Player - The player to give the slime to
-- @param slimeData table - The slime data { id, level, xp, mutations }
-- @return string - The unique ID of the added slime, or nil on failure
function InventoryServiceServer:addSlime(player, slimeData)
	if not player or not player:IsA("Player") then
		warn("[InventoryServiceServer] Invalid player passed to addSlime")
		return nil
	end

	if type(slimeData) ~= "table" or type(slimeData.id) ~= "string" then
		warn("[InventoryServiceServer] Invalid slimeData passed to addSlime")
		return nil
	end

	local data = DataService:waitForData(player)
	if not data then
		warn("[InventoryServiceServer] Could not get data for player:", player.Name)
		return nil
	end

	-- Ensure slime data has required fields
	local reconciledData = InventoryServiceUtils.reconcileSlimeData(slimeData)

	-- Generate a unique key for this slime
	local uniqueKey = InventoryServiceUtils.genKey(reconciledData)

	local inventory = data:get("inventory") or {}
	local newInventory = table.clone(inventory)
	newInventory[uniqueKey] = reconciledData

	DataService:set(player, "inventory", newInventory)
	print(string.format("[InventoryServiceServer] Added slime %s (level %d) to %s's inventory | key: %s", 
		reconciledData.id, reconciledData.level, player.Name, uniqueKey))
	return uniqueKey
end

return InventoryServiceServer