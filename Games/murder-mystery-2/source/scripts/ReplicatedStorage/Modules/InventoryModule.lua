local function CreateBlankInventoryTable()
	return {
		Weapons = {
			Current = {},
			Classic = {},
			Christmas = {},
			Halloween = {}
		},
		Effects = {
			Current = {}
		},
		Perks = {
			Current = {}
		},
		Emotes = {
			Current = {}
		},
		Radios = {
			Current = {}
		},
		Pets = {
			Current = {}
		}
	}
end

local function CreateBlankTradeInventoryTable()
	return {
		Weapons = {
			Current = {}
		},
		Pets = {
			Current = {}
		}
	}
end

local function CreateBlankInventorySort(data)
	local sort = {}
	for key, value in pairs(data) do
		sort[key] = {}
		for k, v in pairs(data[key]) do
			sort[key][k] = {}
		end
	end
	return sort
end

local function CreateNewItemData(itemID, amount, dataType)
	local item = _G.Database[dataType][itemID]
	if item == nil then
		print("ERROR LOADING ITEM: " .. itemID)
		return
	end
	local newItem = {}
	for key, value in pairs(item) do
		newItem[key] = value
	end
	newItem.Name = item.ItemName or item.Name
	newItem.Amount = amount
	newItem.DataID = itemID
	newItem.DataType = dataType
	newItem.Rarity = newItem.Rarity or "Common"
	newItem.Frame = nil
	newItem.LayoutOrder = 0
	return newItem
end

local function GenerateInventoryTables(playerInventory, inventoryType)
	local inventoryData = CreateBlankInventoryTable()
	for category, items in pairs(inventoryData) do
		for itemID, amount in pairs(playerInventory[category].Owned) do
			local newItem = CreateNewItemData(itemID, tonumber(amount) and 1, category)
			local event = newItem.Event
			local season = newItem.Season
			local itemType = newItem.ItemType
			local itemName = newItem.ItemName
			local section = inventoryType == "Trading" and "Current" or (event and season and "Current") or (category == "Weapons" and "Classic") or "Current"
			items[section][itemID] = newItem
			table.insert(inventoryData[category][section], itemID)
		end
	end
	local uniques = playerInventory.Uniques or {}
	for _, uniqueItem in pairs(uniques) do
		local baseItemID = uniqueItem.BaseItem
		local baseItem = _G.Database.Weapons[baseItemID]
		local evolution = uniqueItem.EvoEquipped and baseItem.Evo
		local evolutionLevel = 1
		if evolution then
			if evolution[1].XPRequired <= uniqueItem.XP then
				evolutionLevel = 1
			elseif evolution[2].XPRequired <= uniqueItem.XP then
				evolutionLevel = 2
			elseif evolution[3].XPRequired <= uniqueItem.XP then
				evolutionLevel = 3
			elseif evolution[4].XPRequired <= uniqueItem.XP then
				evolutionLevel = 4
			end
		end
		local itemName = evolution and evolution[evolutionLevel].ItemName or baseItem.ItemName
		local newItem = CreateNewItemData(itemName, 1, "Weapons")
		newItem.Signature = uniqueItem.Signature and ""
		newItem.Rank = uniqueItem.Rank
		newItem.EvoXP = uniqueItem.XP
		newItem.EvoEquipped = uniqueItem.EvoEquipped
		local section = inventoryType == "Trading" and "Current" or "Classic"
		inventoryData.Weapons[section][itemName] = newItem
		table.insert(inventoryData.Weapons[section], itemName)
	end
	return inventoryData, CreateBlankInventorySort(inventoryData)
end

local function SortTab(tab, inventorySort)
	table.sort(tab, function(a, b)
		if inventorySort[a].Rarity == inventorySort[b].Rarity then
			return a < b
		else
			return inventorySort[a].Rarity > inventorySort[b].Rarity
		end
	end)
end

local function SortInventory(inventoryData, inventorySort)
	for category, items in pairs(inventoryData) do
		for section, tab in pairs(items) do
			SortTab(tab, inventorySort[category][section])
		end
	end
end

local function GenerateNewInventoryFrames(inventoryData, inventorySort)
	for category, items in pairs(inventoryData) do
		for section, tab in pairs(items) do
			for index, itemID in ipairs(tab) do
				local itemData = inventorySort[category][section][itemID]
				local frame = itemData.Frame or {}
				frame.LayoutOrder = index
				frame.ItemName = itemData.ItemName
				frame.Amount = itemData.Amount
				frame.Image = itemData.Image
				frame.Rarity = itemData.Rarity
				frame.DataID = itemID
				frame.DataType = category
				frame.Signature = itemData.Signature
				frame.Rank = itemData.Rank
				frame.EvoXP = itemData.EvoXP
				frame.EvoEquipped = itemData.EvoEquipped
				inventorySort[category][section][itemID].Frame = frame
			end
		end
	end
end

local function ConnectEquipButtons(inventorySort)
	for category, items in pairs(inventorySort) do
		for section, tab in pairs(items) do
			for _, itemData in pairs(tab) do
				local frame = itemData.Frame
				if frame then
					local equipButton = frame:FindFirstChild("EquipButton")
					if equipButton then
						equipButton.MouseButton1Click:Connect(function()
							-- Handle equip button click here
							print("Equip button clicked for item:", frame.ItemName)
						end)
					end
				end
			end
		end
	end
end

local inventory = CreateBlankInventoryTable()
local tradeInventory = CreateBlankTradeInventoryTable()

local playerInventory = {
	Weapons = {
		Owned = {
			[1234] = 1,
			[5678] = 2
		}
	},
	Effects = {
		Owned = {}
	},
	Perks = {
		Owned = {}
	},
	Emotes = {
		Owned = {}
	},
	Radios = {
		Owned = {}
	},
	Pets = {
		Owned = {}
	},
	Uniques = {}
}

inventory, inventorySort = GenerateInventoryTables(playerInventory, "Normal")
SortInventory(inventory, inventorySort)
GenerateNewInventoryFrames(inventory, inventorySort)
ConnectEquipButtons(inventorySort)
