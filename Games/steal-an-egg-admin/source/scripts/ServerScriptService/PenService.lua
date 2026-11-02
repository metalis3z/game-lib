--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Remotes)
local DataService = require(game:GetService("ServerScriptService").DataService)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local Assets = require(ReplicatedStorage.Data.Assets)
local Bases = require(ReplicatedStorage.Data.Bases)

local PenRoster = Remotes.PenRoster
local Haul = Remotes.Haul

local PenService = {}

local wear_best_cooldown = 2

local function pushOwnerRecords(player)
	local profile = DataService.Get(player)
	if not profile then
		return
	end
	local inventory = profile.Inventory or {}
	local equipped = profile.EquippedAssets or {}
	local records = {}
	local any = false
	for _, uid in ipairs(equipped) do
		local item = type(uid) == "string" and inventory[uid] or nil
		if type(item) == "table" then
			local decoded = AssetItems.Decode(item)
			local ok, rate = pcall(function()
				return AssetEarnings.LiveRatePerSecond(decoded, profile.Gamepasses, profile.Products, player)
			end)
			records[uid] = {
				OwnerUserId = player.UserId,
				UID = uid,
				ItemData = decoded,
				MoneyPerSecond = if ok and type(rate) == "number" then rate else 0,
				Seed = tonumber(player.UserId) or 0,
			}
			any = true
		end
	end
	if any then
		PenRoster.OwnerShifted:FireClient(player, {
			OwnerUserId = player.UserId,
			Records = records,
		})
	else
		PenRoster.OwnerDropped:FireClient(player, { OwnerUserId = player.UserId })
	end
end

local function capacityFor(profile)
	local level = profile.BaseUpgradeLevel
	if typeof(level) ~= "number" then
		level = 0
	end
	return Bases.GetAssetEquipCapacity(level)
end

local function findAssetTool(player, uid)
	local backpack = player:FindFirstChildOfClass("Backpack")
	if backpack then
		for _, child in ipairs(backpack:GetChildren()) do
			if child:IsA("Tool") and child:GetAttribute("ItemType") == "Asset" and child:GetAttribute("UID") == uid then
				return child
			end
		end
	end
	local character = player.Character
	if character then
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") and child:GetAttribute("ItemType") == "Asset" and child:GetAttribute("UID") == uid then
				return child
			end
		end
	end
	return nil
end

local function joinMutations(mutations)
	if type(mutations) ~= "table" then
		return ""
	end
	local parts = {}
	for _, name in ipairs(mutations) do
		if type(name) == "string" and name ~= "" and name ~= "None" then
			table.insert(parts, name)
		end
	end
	return table.concat(parts, ", ")
end

local function applyAssetAttributes(tool, uid, itemData)
	tool:SetAttribute("ItemType", "Asset")
	tool:SetAttribute("UID", uid)
	tool:SetAttribute("Category", itemData.Category)
	tool:SetAttribute("Mutations", joinMutations(itemData.Mutations))
	tool:SetAttribute("BaseMutation", itemData.BaseMutation)
	tool:SetAttribute("Scale", itemData.Scale)
	if itemData.Gender ~= nil then
		tool:SetAttribute("Gender", itemData.Gender)
	end
	if itemData.EyeColor ~= nil then
		tool:SetAttribute("EyeColor", itemData.EyeColor)
	end
	if itemData.ColorSeed ~= nil then
		tool:SetAttribute("ColorSeed", itemData.ColorSeed)
	end
	if itemData.ColorIndex ~= nil then
		tool:SetAttribute("ColorIndex", itemData.ColorIndex)
	end
	local config = Assets.Directory[itemData.Category]
	if config and config.DisplayName and config.DisplayName ~= "" then
		tool:SetAttribute("DisplayName", config.DisplayName)
		tool.Name = config.DisplayName
	end
end

local function buildAssetTool(player, uid, itemData)
	local backpack = player:FindFirstChildOfClass("Backpack")
	if not backpack then
		return nil
	end
	local existing = findAssetTool(player, uid)
	if existing then
		applyAssetAttributes(existing, uid, itemData)
		return existing
	end

	local tool = Instance.new("Tool")
	tool.Name = "Pet_" .. uid
	tool.RequiresHandle = true
	tool.CanBeDropped = false
	applyAssetAttributes(tool, uid, itemData)

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(1, 1, 1)
	handle.Transparency = 1
	handle.CanCollide = false
	handle.Massless = true
	handle.Parent = tool

	tool.Parent = backpack
	return tool
end

local function syncInventoryTools(player, profile)
	local backpack = player:FindFirstChildOfClass("Backpack")
	if not backpack then
		return
	end
	local inventory = profile.Inventory
	if type(inventory) ~= "table" then
		return
	end
	local equipped = {}
	if type(profile.EquippedAssets) == "table" then
		for _, uid in ipairs(profile.EquippedAssets) do
			if type(uid) == "string" then
				equipped[uid] = true
			end
		end
	end
	local valid = {}
	for uid, item in pairs(inventory) do
		if type(uid) == "string" and type(item) == "table" and item.InFuse ~= true then
			valid[uid] = true
			if findAssetTool(player, uid) == nil then
				local ok, decoded = pcall(function()
					return AssetItems.Decode(item)
				end)
				if ok and type(decoded) == "table" then
					local tool = buildAssetTool(player, uid, decoded)
					if tool ~= nil and equipped[uid] and player.Character ~= nil then
						tool.Parent = player.Character
					end
				end
			end
		end
	end
	for _, container in ipairs({ backpack, player.Character }) do
		if container ~= nil then
			for _, child in ipairs(container:GetChildren()) do
				if child:IsA("Tool") and child:GetAttribute("ItemType") == "Asset" then
					local uid = child:GetAttribute("UID")
					if type(uid) ~= "string" or valid[uid] == nil then
						child:Destroy()
					end
				end
			end
		end
	end
end

local function equippedCount(player)
	local profile = DataService.Get(player)
	if not profile or type(profile.EquippedAssets) ~= "table" then
		return 0
	end
	local n = 0
	for _, uid in ipairs(profile.EquippedAssets) do
		if type(uid) == "string" then
			n += 1
		end
	end
	return n
end

local function wearUid(player, profile, uid)
	profile.EquippedAssets = profile.EquippedAssets or {}
	if table.find(profile.EquippedAssets, uid) == nil then
		if equippedCount(player) >= capacityFor(profile) then
			return false, "Wear limit reached"
		end
		table.insert(profile.EquippedAssets, uid)
	end

	local item = profile.Inventory and profile.Inventory[uid]
	if type(item) ~= "table" then
		return false, "Asset is not available."
	end
	local decoded = AssetItems.Decode(item)
	local tool = buildAssetTool(player, uid, decoded)
	if not tool then
		return false, "Could not equip asset"
	end

	local character = player.Character
	if character then
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") and child ~= tool and child:GetAttribute("ItemType") == "Asset" then
				child.Parent = player:FindFirstChildOfClass("Backpack")
			end
		end
		tool.Parent = character
	end
	return true
end

PenRoster.AskWearLimit.OnServerInvoke = function(player)
	local profile = DataService.Get(player)
	if profile ~= nil then
		return capacityFor(profile)
	end
	return Bases.GetAssetEquipCapacity(0)
end

PenRoster.AskLiveSnapshot.OnServerInvoke = function(_player)
	return {}
end

PenRoster.AskWear.OnServerInvoke = function(player, uid)
	if type(uid) ~= "string" then
		return false, "Invalid request"
	end
	local profile = DataService.WaitForProfile(player, 30)
	if not profile then
		return false, "Data still loading"
	end
	local item = profile.Inventory and profile.Inventory[uid]
	if type(item) ~= "table" then
		return false, "Asset is not available."
	end
	if item.InFuse == true then
		return false, "Asset is in a fuse"
	end

	local ok, err = wearUid(player, profile, uid)
	if not ok then
		return false, err
	end

	DataService.SyncChange(player, "EquippedAssets", profile.EquippedAssets)
	pushOwnerRecords(player)
	return true
end

PenRoster.AskDoff.OnServerInvoke = function(player, uid)
	if uid ~= nil and type(uid) ~= "string" then
		return false, "Invalid request"
	end
	local profile = DataService.WaitForProfile(player, 30)
	if not profile then
		return false, "Data still loading"
	end

	if uid == nil then
		return true
	end

	local tool = findAssetTool(player, uid)
	if tool then
		local backpack = player:FindFirstChildOfClass("Backpack")
		if backpack then
			tool.Parent = backpack
		else
			tool:Destroy()
		end
	end

	local list = profile.EquippedAssets
	if type(list) == "table" then
		local index = table.find(list, uid)
		if index then
			table.remove(list, index)
			DataService.SyncChange(player, "EquippedAssets", list)
		end
	end
	pushOwnerRecords(player)
	return true
end

PenRoster.AskSale.OnServerInvoke = function(_player, _uid)
	return false, "Not available"
end

PenRoster.ConfirmPetsBadge.OnServerInvoke = function(_player)
	return true
end

PenRoster.ConfirmEquipBestBadge.OnServerInvoke = function(_player)
	return true
end

local function wearCandidates(profile)
	local inventory = profile.Inventory
	if type(inventory) ~= "table" then
		return {}
	end
	local candidates = {}
	for uid, item in pairs(inventory) do
		if type(uid) == "string" and type(item) == "table" and item.InFuse ~= true then
			local ok, decoded = pcall(function()
				return AssetItems.Decode(item)
			end)
			if ok and type(decoded) == "table" then
				local rateOk, rate = pcall(function()
					return AssetEarnings.LiveRatePerSecond(decoded, profile.Gamepasses, profile.Products, nil)
				end)
				table.insert(candidates, {
					UID = uid,
					Rate = (rateOk and type(rate) == "number") and rate or 0,
				})
			end
		end
	end
	table.sort(candidates, function(a, b)
		if a.Rate == b.Rate then
			return a.UID < b.UID
		end
		return a.Rate > b.Rate
	end)
	return candidates
end

local wearBestLastAt: {[number]: number} = {}

Haul.WearBest.OnServerInvoke = function(player)
	local profile = DataService.WaitForProfile(player, 30)
	if not profile then
		return false, "Data still loading"
	end

	local now = os.clock()
	if now - (wearBestLastAt[player.UserId] or 0) < wear_best_cooldown then
		return false, "DEBOUNCE"
	end
	wearBestLastAt[player.UserId] = now

	profile.EquippedAssets = profile.EquippedAssets or {}
	local equipped = {}
	for _, uid in ipairs(profile.EquippedAssets) do
		equipped[uid] = true
	end

	local capacity = capacityFor(profile)
	local equippedPets = 0
	local changed = false
	for _, candidate in ipairs(wearCandidates(profile)) do
		if equippedPets >= capacity then
			break
		end
		if not equipped[candidate.UID] then
			local ok = wearUid(player, profile, candidate.UID)
			if ok then
				equipped[candidate.UID] = true
				equippedPets += 1
				changed = true
			end
		else
			equippedPets += 1
		end
	end

	if not changed then
		return false, "No pets available to equip"
	end

	DataService.SyncChange(player, "EquippedAssets", profile.EquippedAssets)
	pushOwnerRecords(player)
	return true
end

Haul.FetchWearBestStatus.OnServerInvoke = function(player)
	local profile = DataService.Get(player)
	if profile == nil then
		return {false}
	end
	if equippedCount(player) >= capacityFor(profile) then
		return {false}
	end
	local equipped = {}
	if type(profile.EquippedAssets) == "table" then
		for _, uid in ipairs(profile.EquippedAssets) do
			equipped[uid] = true
		end
	end
	for _, candidate in ipairs(wearCandidates(profile)) do
		if not equipped[candidate.UID] then
			return {true}
		end
	end
	return {false}
end

function PenService.SyncTools(player)
	local profile = DataService.Get(player)
	if profile ~= nil then
		syncInventoryTools(player, profile)
	end
end

function PenService.Init()
end

function PenService.Start()
	local syncWhenReady = function(player)
		task.spawn(function()
			local profile = DataService.WaitForProfile(player, 30)
			if profile ~= nil then
				pushOwnerRecords(player)
				syncInventoryTools(player, profile)
			end
		end)
	end
	Players.PlayerAdded:Connect(syncWhenReady)
	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function()
			task.spawn(function()
				local profile = DataService.Get(player)
				if profile ~= nil then
					syncInventoryTools(player, profile)
				end
			end)
		end)
	end)
end

return PenService
