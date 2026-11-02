local RS = game:GetService("ReplicatedStorage")
local Rarities = require(RS.Shared.List.Items.Rarities)
local Items = require(RS.Shared.Items)

local module = {}

function module.getRarityId(rarityName)
	for i, v in Rarities do
		if v.name == rarityName then return i end
	end
	return 1
end

function module.getRarityData(rarityId)
	return Rarities[rarityId]
end

function module.isSame(item1, item2, options)
	if type(item1) ~= "table" or type(item2) ~= "table" then return false end
	options = options or {}
	local ignoreKeys = {am = true, lk = true}
	if options.ignoreKeys then
		for _, key in options.ignoreKeys do
			ignoreKeys[key] = true
		end
	end
	local checkExistence = options.checkExistence or {}

	local function deepCompare(a, b)
		for key, val in a do
			if ignoreKeys[key] then continue end
			local bVal = b[key]
			if table.find(checkExistence, key) then
				if (val ~= nil) ~= (bVal ~= nil) then return false end
				continue
			end
			if bVal == nil then return false end
			if type(val) == "table" and type(bVal) == "table" then
				if not deepCompare(val, bVal) then return false end
			elseif val ~= bVal then
				return false
			end
		end
		return true
	end

	return deepCompare(item1, item2) and deepCompare(item2, item1)
end

function module.getItemFromId(data, itemId, category)
	if typeof(data) ~= "table" then return nil end
	if not itemId or itemId == "" then return nil end

	local function findItem(items)
		for id, itemData in items do
			if id == itemId then
				return module.createItemFromData(itemData)
			end
		end
		return nil
	end

	if type(category) == "string" then
		local categoryItems = data.inventory and data.inventory[category]
		if categoryItems then
			return findItem(categoryItems)
		end
		return nil
	end

	if data.inventory then
		for _, categoryItems in data.inventory do
			if typeof(categoryItems) == "table" then
				local result = findItem(categoryItems)
				if result then return result end
			end
		end
	end
	return nil
end

function module.getExistingItem(data, item, searchIn)
	if searchIn then
		for i, v in searchIn do
			if type(v) == "table" and module.isSame(v, item) then
				return module.createItemFromData(v), i
			end
		end
	else
		if data.inventory then
		for _, categoryItems in data.inventory do
				if type(categoryItems) ~= "table" then continue end
				for id, itemData in categoryItems do
					if type(itemData) == "table" and module.isSame(itemData, item) then
						return module.createItemFromData(itemData), id
					end
				end
			end
		end
	end
end

function module.getIdFromClass(data, className)
	for _, category in pairs(data.inventory) do
		if type(category) ~= "table" then continue end
		for id, itemData in category do
			if type(itemData) == "table" and itemData.cl == className then return id end
		end
	end

end

function module.getItemFromName(data, itemName)
	if typeof(data) ~= "table" then return nil end
	if not data.inventory then return nil end
	for _, category in pairs(data.inventory) do
		if type(category) ~= "table" then continue end
		for id, itemData in category do
			if type(itemData) == "table" and itemData.nm == itemName then
				return module.createItemFromData(itemData), id
			end
		end
	end
end

function module.getTradeTokenItemId(data)
	if not data.inventory or not data.inventory.exclusive then return nil end
	for id, itemData in data.inventory.exclusive do
		if type(itemData) == "table" and module.createItemFromData(itemData):getName() == "tradeTokens" then
			return id
		end
	end
end

function module.getSamePetEquipped(data, pet)
	local count = 0
	if not data.equippedPets then return 0 end
	for petId, _ in data.equippedPets do
		local petData = data.inventory and data.inventory.pet and data.inventory.pet[petId]
		if petData and module.isSame(pet, module.createItemFromData(petData)) then
			count += 1
		end
	end
	return count
end

function module.getAmountOfSameItem(data, item, searchIn)
	local ids = {}
	local total = 0
	for id, itemData in searchIn do
		if type(itemData) ~= "table" then continue end
		if module.isSame(item, itemData) then
			total += module.createItemFromData(itemData):getAmount()
			ids[#ids + 1] = id
		end
	end
	return total, ids
end

function module.createItemFromData(itemData)
	if type(itemData) ~= "table" or not itemData.cl or not itemData.nm then return nil end
	return Items[itemData.cl](itemData.nm):setData(itemData)
end

return module