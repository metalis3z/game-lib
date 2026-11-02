local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Sync = require(ReplicatedStorage:WaitForChild("Database"):WaitForChild("Sync"))
local DataModule

local function getDataModule()
	if not DataModule then
		DataModule = require(ServerScriptService:WaitForChild("GameScript"):WaitForChild("DataModule"))
	end
	return DataModule
end

local function getDisplayName(itemKey, itemData)
	return tostring((itemData and itemData.ItemName) or itemKey)
end

local function normalize(text)
	return string.lower(tostring(text or ""))
end

local function findItem(itemName)
	local items = Sync.Item or {}
	local query = normalize(itemName)
	local partialMatches = {}

	for itemKey, itemData in pairs(items) do
		local keyLower = normalize(itemKey)
		local nameLower = normalize(itemData and itemData.ItemName)
		if keyLower == query or nameLower == query then
			return itemKey, itemData
		end
	end

	for itemKey, itemData in pairs(items) do
		local keyLower = normalize(itemKey)
		local nameLower = normalize(itemData and itemData.ItemName)
		if string.find(keyLower, query, 1, true) or string.find(nameLower, query, 1, true) then
			table.insert(partialMatches, {key = itemKey, data = itemData})
		end
	end

	if #partialMatches == 1 then
		return partialMatches[1].key, partialMatches[1].data
	end

	if #partialMatches > 1 then
		table.sort(partialMatches, function(a, b)
			return a.key < b.key
		end)

		local names = {}
		for index = 1, math.min(#partialMatches, 8) do
			local match = partialMatches[index]
			table.insert(names, match.key .. " (" .. getDisplayName(match.key, match.data) .. ")")
		end

		return nil, nil, "Multiple items matched: " .. table.concat(names, ", ")
	end

	return nil, nil, "Item '" .. tostring(itemName) .. "' was not found."
end

return function(context, targetPlayer, itemName)
	if not targetPlayer then
		return "Player not found."
	end

	if typeof(itemName) ~= "string" or not itemName:match("%S") then
		return "Usage: giveitem <player> <item name>"
	end

	itemName = itemName:match("^%s*(.-)%s*$")
	local itemKey, itemData, errorMessage = findItem(itemName)
	if not itemKey then
		return errorMessage
	end

	if not itemData.ItemName or itemData.ItemName == "" then
		return "Item '" .. itemKey .. "' has invalid item data."
	end

	if itemData.Rarity == "Unique" then
		return "Unique items cannot be given."
	end

	if itemData.EvoBaseID then
		return "Evo items cannot be given."
	end

	local dataModule = getDataModule()
	local dataTable = dataModule.GetDataTable()
	local playerData = dataTable[targetPlayer.Name]
	if not (playerData and playerData.Weapons and playerData.Weapons.Owned) then
		return "Player data is still loading for " .. targetPlayer.Name .. ". Try again in a moment."
	end

	local ok, err = pcall(function()
		dataModule.GiveItem(targetPlayer, itemKey, 1, "Weapons", true)
	end)
	if not ok then
		warn("Cmdr giveitem failed:", err)
		return "Failed to give item. Check the server output."
	end

	return ("Gave %s to %s."):format(getDisplayName(itemKey, itemData), targetPlayer.Name)
end
