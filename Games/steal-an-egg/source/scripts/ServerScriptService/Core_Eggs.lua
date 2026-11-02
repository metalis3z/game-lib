--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")

local Network = require(script.Parent.Core_Network)
local AreaDirectory = require(ReplicatedStorage.Directory.Areas)
local AssetDirectory = require(ReplicatedStorage.Directory.Assets)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
local AssetColorUtil = require(ReplicatedStorage.Library.Util.AssetColorUtil)
local RecoveryEvent = require(ReplicatedStorage.Directory.RecoveryEvent)
local AreaEggResetTimeUtil = require(ReplicatedStorage.Library.Util.AreaEggResetTimeUtil)
local AreaEggResetCycle = require(ReplicatedStorage.Directory.AreaEggResetCycle)
local ProductDirectory = require(ReplicatedStorage.Directory.Products)

local Eggs = {}
Eggs.AreaChanged = Instance.new("BindableEvent")

local Data
local Plots
local ActiveAssets
local rng = Random.new()
local areaRecords: {[string]: any} = {}
local originalSlots: {[string]: any} = {}
local carriedByPlayer: {[Player]: string} = {}
local carrySlotKey: {[Player]: string?} = {}
local hatching: {[Player]: {[string]: boolean}} = {}
local selectedSkipUid: {[Player]: string} = {}
local areaGeneration = 0
local currentRareSpawns = {}
local currentResetSequence = nil
local activeNightDayStartsAt: number? = nil
local lastNightPeriodIndex: number? = nil
local lastNightCommitAt = -math.huge
local wallGuardStartsAt = math.huge
local wallGuardEndsAt = -math.huge
local separationLine: BasePart? = nil
local lastSafeCFrame: {[Player]: CFrame} = {}
local teleportCooldownUntil: {[Player]: number} = {}
local nextAreaRecoveryAt = 0
local resetWallCollisionEnabled: boolean? = nil
local manualNightCommandCooldown: {[Player]: number} = {}

-- Special-spawn alerts are sent for every rarity outside the five standard tiers.
-- This sound is already preloaded by the reset presentation controller.
local SPECIAL_EGG_ANNOUNCEMENT_SOUND_ID = 136029417452204
local STANDARD_EGG_RARITIES = {
	common = true,
	uncommon = true,
	rare = true,
	epic = true,
	legendary = true,
	mythic = true,
}

local function copy(value)
	if typeof(value) ~= "table" then
		return value
	end
	local result = {}
	for key, child in pairs(value) do
		result[key] = copy(child)
	end
	return result
end

local function getBaseEggRemaining(egg, now: number): number
	local placement = egg and egg.Placement
	if typeof(placement) ~= "table" then
		return math.huge
	end
	local placedAt = tonumber(placement.PlacedAt) or now
	local duration = math.max(0, tonumber(placement.GrowthDuration) or 0)
	local growthCredit = math.max(0, tonumber(placement.GrowthCreditSeconds) or 0)
	local recoveryCredit = RecoveryEvent.GetGrowthBonusSeconds(placedAt, now)
	return math.max(0, duration - (now - placedAt) - growthCredit - recoveryCredit)
end

local function getCurrentNightGrowthCredit(egg, now: number): number
	if not AreaEggResetTimeUtil.IsNight(now) then
		return 0
	end
	local placement = egg and egg.Placement
	if typeof(placement) ~= "table" or placement.ReadyAt ~= nil then
		return 0
	end
	local nightStartsAt = AreaEggResetTimeUtil.GetNightStartsAt(now)
	local placedAt = tonumber(placement.PlacedAt) or now
	if nightStartsAt < placedAt then
		return 0
	end
	local dayStartsAt = AreaEggResetTimeUtil.GetNextResetAt(now)
	local periodIndex = AreaEggResetTimeUtil.GetPeriodIndex(dayStartsAt)
	local committed = 0
	if placement.NightGrowthPeriodIndex == periodIndex then
		committed = math.max(0, tonumber(placement.NightGrowthCreditSeconds) or 0)
	end
	local remainingAtNightfall = getBaseEggRemaining(egg, nightStartsAt) + committed
	local targetCredit = math.min(AreaEggResetTimeUtil.NightGrowthSkipSeconds, remainingAtNightfall)
	local totalCredit = math.min(
		targetCredit,
		AreaEggResetTimeUtil.GetNightGrowthSecondsAt(now, nightStartsAt)
	)
	return math.max(0, totalCredit - committed)
end

local function getEggRemaining(egg, now: number): number
	local placement = egg and egg.Placement
	if typeof(placement) ~= "table" then
		return math.huge
	end
	local explicitReadyAt = tonumber(placement.ReadyAt)
	if explicitReadyAt then
		return math.max(0, explicitReadyAt - now)
	end
	return math.max(0, getBaseEggRemaining(egg, now) - getCurrentNightGrowthCredit(egg, now))
end

local function toRuntimeEgg(saved)
	local result = copy(saved)
	if result.Placement and typeof(result.Placement.LocalCFrame) == "table" then
		local values = result.Placement.LocalCFrame
		if #values >= 12 then
			result.Placement.LocalCFrame = CFrame.new(table.unpack(values, 1, 12))
		else
			result.Placement = nil
		end
	end
	if result.Placement and getEggRemaining(result, Workspace:GetServerTimeNow()) > 0 then
		-- Client egg utilities use ReadyAt as an already-ready marker. Hide legacy future timestamps.
		result.Placement.ReadyAt = nil
	end
	result.GrowthSpeedMultiplier = 1
	return result
end

local function runtimeUpdate(player: Player)
	local profile = Data.Get(player)
	local records = {}
	if profile then
		for uid, egg in pairs(profile.EggInventory or {}) do
			if typeof(egg) == "table" and egg.Placement then
				records[uid] = toRuntimeEgg(egg)
			end
		end
	end
	return {
		OwnerUserId = player.UserId,
		Records = records,
	}
end

local function publishRuntime(player: Player)
	Network.FireAll("Eggs: RuntimeOwnerUpdated", runtimeUpdate(player))
end

local function makeEggTool(player: Player, uid: string, egg)
	for _, container in ipairs({player:FindFirstChild("Backpack"), player.Character}) do
		if container then
			for _, child in ipairs(container:GetChildren()) do
				if child:IsA("Tool") and child:GetAttribute("ItemType") == "AssetEgg" then
					child:Destroy()
				end
			end
		end
	end
	local backpack = player:FindFirstChildOfClass("Backpack")
	if not backpack then
		return false
	end
	local config = AssetDirectory.Directory[egg.AssetCategory]
	local tool = Instance.new("Tool")
	tool.Name = (if config and config.DisplayName then config.DisplayName else egg.AssetCategory) .. " Egg"
	tool.CanBeDropped = false
	tool.RequiresHandle = true
	tool:SetAttribute("ItemType", "AssetEgg")
	tool:SetAttribute("UID", uid)
	tool:SetAttribute("Category", egg.AssetCategory)

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(1.2, 1.2, 1.2)
	handle.Transparency = 1
	handle.CanCollide = false
	handle.CanTouch = false
	handle.CanQuery = false
	handle.Massless = true
	handle.Parent = tool
	tool.Parent = backpack
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:EquipTool(tool)
	end
	return true
end

local function removeEggTool(player: Player, requestedUid: string?)
	for _, container in ipairs({player:FindFirstChild("Backpack"), player.Character}) do
		if container then
			for _, child in ipairs(container:GetChildren()) do
				if child:IsA("Tool") and child:GetAttribute("ItemType") == "AssetEgg" then
					if requestedUid == nil or child:GetAttribute("UID") == requestedUid then
						child:Destroy()
					end
				end
			end
		end
	end
end

local function equipFirstUnplacedEgg(player: Player)
	local profile = Data and Data.Get(player)
	if not profile then
		return false
	end
	for uid, egg in pairs(profile.EggInventory or {}) do
		if typeof(uid) == "string" and typeof(egg) == "table" and egg.Placement == nil then
			return makeEggTool(player, uid, egg)
		end
	end
	removeEggTool(player, nil)
	return false
end

-- Limited-time Robux-purchase egg odds
local LIMITED_TIME_EGG_DROP_TABLE = {
	{"Tung Tung Sahur", 39},
	{"Bananita Dolphinita", 25},
	{"Belula Beluga", 20},
	{"Mangolini Parrochini", 10},
	{"Bomboclat Crocolat", 5},
	{"Strawberry Elephant", 1},
}

local function chooseLimitedTimeCategory(): string
	local total = 0
	for _, entry in ipairs(LIMITED_TIME_EGG_DROP_TABLE) do
		total += entry[2]
	end
	local roll = rng:NextNumber(0, total)
	local cursor = 0
	for _, entry in ipairs(LIMITED_TIME_EGG_DROP_TABLE) do
		cursor += entry[2]
		if roll <= cursor then
			return entry[1]
		end
	end
	return LIMITED_TIME_EGG_DROP_TABLE[#LIMITED_TIME_EGG_DROP_TABLE][1]
end

local function chooseCategory(areaName: string): string
	local config = AreaDirectory.Directory[areaName]
	local dropTable = config and config.DropTable
	if typeof(dropTable) ~= "table" or #dropTable == 0 then
		return "Chicken"
	end
	local total = 0
	for _, entry in ipairs(dropTable) do
		total += math.max(0, tonumber(entry[2]) or 0)
	end
	local roll = rng:NextNumber(0, math.max(total, 0.001))
	local cursor = 0
	for _, entry in ipairs(dropTable) do
		cursor += math.max(0, tonumber(entry[2]) or 0)
		if roll <= cursor then
			return tostring(entry[1])
		end
	end
	return tostring(dropTable[#dropTable][1])
end

local function isForestUid(uid: string): number?
	return tonumber(string.match(uid, "^FirstAreaEgg_(-?%d+)_"))
end

local function splitRecordsByOwner(records)
	local shared, perPlayer = {}, {}
	for _, record in ipairs(records) do
		local ownerUserId = isForestUid(record.Uid)
		if ownerUserId then
			perPlayer[ownerUserId] = perPlayer[ownerUserId] or {}
			table.insert(perPlayer[ownerUserId], record)
		else
			table.insert(shared, record)
		end
	end
	return shared, perPlayer
end

local function splitUidsByOwner(uids)
	local shared, perPlayer = {}, {}
	for _, uid in ipairs(uids) do
		local ownerUserId = isForestUid(uid)
		if ownerUserId then
			perPlayer[ownerUserId] = perPlayer[ownerUserId] or {}
			table.insert(perPlayer[ownerUserId], uid)
		else
			table.insert(shared, uid)
		end
	end
	return shared, perPlayer
end

local function broadcastCarryVisual(player: Player, record)
	Network.FireAll("Eggs: AreaEggCarryVisualUpdated", {
		CarrierUserId = player.UserId,
		IsCarrying = record ~= nil,
		AssetCategory = record and record.AssetCategory or nil,
		AssetScale = record and record.AssetScale or nil,
		AssetEyeColor = record and record.AssetEyeColor or nil,
		AssetColorSeed = record and record.AssetColorSeed or nil,
		AssetColorIndex = record and record.AssetColorIndex or nil,
		Mutations = record and record.Mutations or nil,
		BaseMutation = record and record.BaseMutation or nil,
	})
end

local function carryState(player: Player, record)
	Network.FireClient("Eggs: AreaEggCarryState", player, {
		IsCarrying = record ~= nil,
		Uid = record and record.Uid or nil,
		AreaId = record and record.AreaId or nil,
		AssetCategory = record and record.AssetCategory or nil,
		RunBackWakeDelayRequired = false,
		SpeedMultiplier = if record then 0.8 else 1,
	})
	broadcastCarryVisual(player, record)
end

local function broadcastAreaEggBatch(updatedRecords, removedUids, now: number)
	local sharedUpdated, playerUpdated = splitRecordsByOwner(updatedRecords)
	local sharedRemoved, playerRemoved = splitUidsByOwner(removedUids)
	Network.FireAll("Eggs: AreaEggBatchUpdated", {
		UpdatedRecords = sharedUpdated,
		RemovedUids = sharedRemoved,
		ServerTime = now,
	})
	for _, player in ipairs(Players:GetPlayers()) do
		local mine, minedRemoved = playerUpdated[player.UserId], playerRemoved[player.UserId]
		if mine or minedRemoved then
			Network.FireClient("Eggs: AreaEggBatchUpdated", player, {
				UpdatedRecords = mine or {},
				RemovedUids = minedRemoved or {},
				ServerTime = now,
			})
		end
	end
end

local fireAreaUpdate

local function findPart(parent: Instance, name: string): BasePart?
	local found = parent:FindFirstChild(name, true)
	return if found and found:IsA("BasePart") then found else nil
end

local function setResetWallCollisionEnabled(enabled: boolean)
	local objects = Workspace:FindFirstChild("__OBJECTS")
	local areas = objects and objects:FindFirstChild("Areas")
	local collisionRoot = areas and areas:FindFirstChild("WallStartCollision")
	if not collisionRoot then
		resetWallCollisionEnabled = nil
		return
	end
	if resetWallCollisionEnabled == enabled then
		return
	end
	resetWallCollisionEnabled = enabled
	script:SetAttribute("ResetWallCollisionEnabled", enabled)
	if collisionRoot:IsA("BasePart") then
		collisionRoot.CanCollide = enabled
		if enabled == true then
			collisionRoot.Transparency = 0
		elseif enabled == false then
			collisionRoot.Transparency = 1
		end
	end
	for _, descendant in ipairs(collisionRoot:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.CanCollide = enabled
		end
	end
	local visual = areas:FindFirstChild("WallStartVisual")
	if visual and visual:IsA("BasePart") then
		visual.CanCollide = false
	end
end

local function createAreaRecord(area: Model, nest: Model, index: number, ownerUserId: number?)
	local bottom = findPart(nest, "EggSpotBottom")
	if not bottom then
		return
	end
	local bounds = findPart(nest, "EggFitBounds")
	local nestId = ("Slot_%03d"):format(index)
	local guid = HttpService:GenerateGUID(false)
	local uid = if ownerUserId then ("FirstAreaEgg_%d_%s_%s"):format(ownerUserId, nestId, guid) else guid
	local category = chooseCategory(area.Name)
	local colors = AssetColorUtil.RollFields(category, rng)
	local record = {
		Uid = uid,
		AreaId = area.Name,
		NestId = nestId,
		AssetCategory = category,
		AssetScale = rng:NextNumber(0.9, 1.1),
		AssetEyeColor = colors.EyeColor,
		AssetColorSeed = colors.ColorSeed,
		AssetColorIndex = colors.ColorIndex,
		Mutations = {},
		NestScale = nest:GetScale(),
		BottomCFrame = bottom.CFrame,
		BoundsCFrame = if bounds then bounds.CFrame else bottom.CFrame,
		BoundsSize = if bounds then bounds.Size else Vector3.new(4, 5, 4),
		State = "Slot",
		Version = 1,
	}
	areaRecords[uid] = record
	originalSlots[uid] = {
		Area = area,
		Nest = nest,
		Index = index,
		BottomCFrame = record.BottomCFrame,
		BoundsCFrame = record.BoundsCFrame,
		BoundsSize = record.BoundsSize,
		OwnerUserId = ownerUserId,
	}
	return record
end

local function spawnAllAreaEggs()
	table.clear(areaRecords)
	table.clear(originalSlots)
	local objects = Workspace:FindFirstChild("__OBJECTS")
	local areas = objects and objects:FindFirstChild("Areas")
	local guardAreas = areas and areas:FindFirstChild("GuardAreas")
	if not guardAreas then
		warn("[Eggs] GuardAreas folder was not found")
		return
	end
	for _, area in ipairs(guardAreas:GetChildren()) do
		if area:IsA("Model") and area.Name ~= "Forest" and AreaDirectory.Directory[area.Name] then
			local nestsFolder = area:FindFirstChild("Nests")
			local nests = {}
			if nestsFolder then
				for _, nest in ipairs(nestsFolder:GetChildren()) do
					if nest:IsA("Model") and findPart(nest, "EggSpotBottom") then
						table.insert(nests, nest)
					end
				end
			end
			table.sort(nests, function(a, b)
				local aPart = findPart(a, "EggSpotBottom") :: BasePart
				local bPart = findPart(b, "EggSpotBottom") :: BasePart
				if math.abs(aPart.Position.X - bPart.Position.X) > 0.01 then
					return aPart.Position.X < bPart.Position.X
				end
				return aPart.Position.Z < bPart.Position.Z
			end)
			for index, nest in ipairs(nests) do
				createAreaRecord(area, nest, index)
			end
		end
	end
end

local function spawnForestForPlayer(player: Player, shouldPublish: boolean?)
	local personalPrefix = "FirstAreaEgg_" .. player.UserId .. "_"
	for uid in pairs(areaRecords) do
		if string.find(uid, personalPrefix, 1, true) == 1 then
			return
		end
	end
	local objects = Workspace:FindFirstChild("__OBJECTS")
	local areas = objects and objects:FindFirstChild("Areas")
	local guardAreas = areas and areas:FindFirstChild("GuardAreas")
	local forest = guardAreas and guardAreas:FindFirstChild("Forest")
	local nestsFolder = forest and forest:FindFirstChild("Nests")
	if not forest or not forest:IsA("Model") or not nestsFolder then
		return
	end

	local nests = {}
	for _, nest in ipairs(nestsFolder:GetChildren()) do
		if nest:IsA("Model") and findPart(nest, "EggSpotBottom") then
			table.insert(nests, nest)
		end
	end
	table.sort(nests, function(a, b)
		local aPart = findPart(a, "EggSpotBottom") :: BasePart
		local bPart = findPart(b, "EggSpotBottom") :: BasePart
		if math.abs(aPart.Position.X - bPart.Position.X) > 0.01 then
			return aPart.Position.X < bPart.Position.X
		end
		if math.abs(aPart.Position.Z - bPart.Position.Z) > 0.01 then
			return aPart.Position.Z < bPart.Position.Z
		end
		return aPart.Position.Y < bPart.Position.Y
	end)
	for index, nest in ipairs(nests) do
		local record = createAreaRecord(forest, nest, index, player.UserId)
		if record and shouldPublish ~= false then
			fireAreaUpdate(record)
		end
	end
end

local function areaSnapshot()
	local records = {}
	for _, record in pairs(areaRecords) do
		table.insert(records, copy(record))
	end
	return {
		Records = records,
		ServerTime = Workspace:GetServerTimeNow(),
	}
end

fireAreaUpdate = function(record)
	local snapshot = copy(record)
	local ownerUserId = isForestUid(record.Uid)
	if ownerUserId then
		local owner = Players:GetPlayerByUserId(ownerUserId)
		if owner then
			Network.FireClient("Eggs: AreaEggUpdated", owner, snapshot)
		end
	else
		Network.FireAll("Eggs: AreaEggUpdated", snapshot)
	end
	Eggs.AreaChanged:Fire("Updated", snapshot)
end

local function resetCarried(player: Player, dropAtCharacter: boolean)
	local uid = carriedByPlayer[player]
	if not uid then
		carryState(player, nil)
		return
	end
	local record = areaRecords[uid]
	carriedByPlayer[player] = nil
	carrySlotKey[player] = nil
	if record then
		record.CarrierUserId = nil
		record.Version += 1
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if dropAtCharacter and root and root:IsA("BasePart") then
			record.State = "Dropped"
			record.DroppedAt = Workspace:GetServerTimeNow()
			record.BottomCFrame = root.CFrame * CFrame.new(0, -2, -3)
			record.BoundsCFrame = record.BottomCFrame
		else
			local original = originalSlots[uid]
			record.State = "Slot"
			record.DroppedAt = nil
			if original then
				record.BottomCFrame = original.BottomCFrame
				record.BoundsCFrame = original.BoundsCFrame
				record.BoundsSize = original.BoundsSize
			end
		end
		fireAreaUpdate(record)
	end
	carryState(player, nil)
end

function Eggs.GetAreaRecords()
	return areaSnapshot().Records
end

function Eggs.GetAreaRecord(uid: string)
	local record = areaRecords[uid]
	return if record then copy(record) else nil
end

function Eggs.GetCarriedUid(player: Player): string?
	return carriedByPlayer[player]
end

function Eggs.IsPlayerCarryingFromArea(player: Player, areaId: string): boolean
	local uid = carriedByPlayer[player]
	local record = uid and areaRecords[uid]
	return record ~= nil and record.AreaId == areaId and record.State == "Carried" and record.CarrierUserId == player.UserId
end

function Eggs.ResetAreaEgg(uid: string): boolean
	local record = areaRecords[uid]
	local original = originalSlots[uid]
	if not record or not original then
		return false
	end
	if record.CarrierUserId then
		local carrier = Players:GetPlayerByUserId(record.CarrierUserId)
		if carrier and carriedByPlayer[carrier] == uid then
			carriedByPlayer[carrier] = nil
			carrySlotKey[carrier] = nil
			carryState(carrier, nil)
		end
	end
	record.State = "Slot"
	record.CarrierUserId = nil
	record.DroppedAt = nil
	record.BottomCFrame = original.BottomCFrame
	record.BoundsCFrame = original.BoundsCFrame
	record.BoundsSize = original.BoundsSize
	record.Version += 1
	fireAreaUpdate(record)
	return true
end

function Eggs.MarkGuardCarried(uid: string): boolean
	local record = areaRecords[uid]
	if not record or record.State ~= "Dropped" then
		return false
	end
	record.State = "GuardCarried"
	record.CarrierUserId = nil
	record.DroppedAt = nil
	record.Version += 1
	fireAreaUpdate(record)
	return true
end

function Eggs.GuardHit(player: Player, uid: string, guardCFrame: CFrame?): boolean
	if carriedByPlayer[player] ~= uid then
		return false
	end
	local record = areaRecords[uid]
	if not record or record.CarrierUserId ~= player.UserId or record.State ~= "Carried" then
		return false
	end
	resetCarried(player, true)
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if root and root:IsA("BasePart") and guardCFrame then
		local away = root.Position - guardCFrame.Position
		away = if away.Magnitude > 0.01 then away.Unit else guardCFrame.LookVector
		root.AssemblyLinearVelocity = away * 42 + Vector3.new(0, 24, 0)
	end
	task.delay(6, function()
		local current = areaRecords[uid]
		if current and (current.State == "Dropped" or current.State == "GuardCarried") then
			Eggs.ResetAreaEgg(uid)
		end
	end)
	return true
end

local function feedbackFor(record, position: Vector3)
	local config = AssetDirectory.Directory[record.AssetCategory]
	local rarity = config and config.Rarity
	return {
		AssetCategory = record.AssetCategory,
		DisplayName = if config and config.DisplayName then config.DisplayName else record.AssetCategory,
		Rarity = if rarity and rarity.DisplayName then rarity.DisplayName else "Common",
		Color = if rarity and typeof(rarity.Color) == "Color3" then rarity.Color else Color3.fromRGB(255, 255, 255),
		Position = position,
	}
end

local function claimCarried(player: Player)
	local uid = carriedByPlayer[player]
	local record = uid and areaRecords[uid]
	local profile = Data.Get(player)
	if not uid or not record or not profile then
		return
	end
	local inventory = copy(profile.EggInventory or {})
	local count = 0
	for _ in pairs(inventory) do
		count += 1
	end
	if count >= 115 then
		resetCarried(player, true)
		return
	end

	local savedUid = HttpService:GenerateGUID(false)
	inventory[savedUid] = {
		AssetCategory = record.AssetCategory,
		AssetScale = record.AssetScale,
		AssetEyeColor = record.AssetEyeColor,
		AssetColorSeed = record.AssetColorSeed,
		AssetColorIndex = record.AssetColorIndex,
		Mutations = copy(record.Mutations),
		BaseMutation = record.BaseMutation,
		AssetGender = if rng:NextNumber() < 0.5 then "Male" else "Female",
	}
	local claims = copy(profile.CurrentAreaEggClaims or {Slots = {}})
	claims.Slots = claims.Slots or {}
	local slotKey = carrySlotKey[player] or (record.AreaId .. ":" .. record.NestId)
	claims.Slots[slotKey] = true
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local position = if root and root:IsA("BasePart") then root.Position else record.BottomCFrame.Position

	local original = originalSlots[uid]
	carriedByPlayer[player] = nil
	carrySlotKey[player] = nil
	areaRecords[uid] = nil
	originalSlots[uid] = nil
	Data.Update(player, {
		EggInventory = inventory,
		CurrentAreaEggClaims = claims,
		HasStolenFirstEgg = true,
	})
	if not makeEggTool(player, savedUid, inventory[savedUid]) then
		task.defer(equipFirstUnplacedEgg, player)
	end
	Network.FireAll("Eggs: AreaEggRemoved", uid)
	Eggs.AreaChanged:Fire("Removed", uid, copy(record))
	carryState(player, nil)
	Network.FireClient("Eggs: AreaEggClaimFeedback", player, feedbackFor(record, position))

	local claimGeneration = areaGeneration
	task.delay(15, function()
		if claimGeneration ~= areaGeneration then
			return
		end
		local objects = Workspace:FindFirstChild("__OBJECTS")
		local areas = objects and objects:FindFirstChild("Areas")
		local guardAreas = areas and areas:FindFirstChild("GuardAreas")
		local area = guardAreas and guardAreas:FindFirstChild(record.AreaId)
		local nestsFolder = area and area:FindFirstChild("Nests")
		if not area or not area:IsA("Model") or not nestsFolder then
			return
		end
		local nests = {}
		for _, nest in ipairs(nestsFolder:GetChildren()) do
			if nest:IsA("Model") and findPart(nest, "EggSpotBottom") then
				table.insert(nests, nest)
			end
		end
		table.sort(nests, function(a, b)
			local aPart = findPart(a, "EggSpotBottom") :: BasePart
			local bPart = findPart(b, "EggSpotBottom") :: BasePart
			if math.abs(aPart.Position.X - bPart.Position.X) > 0.01 then
				return aPart.Position.X < bPart.Position.X
			end
			return aPart.Position.Z < bPart.Position.Z
		end)
		local index = tonumber(string.match(record.NestId, "%d+")) or 1
		local newRecord = nests[index] and createAreaRecord(area, nests[index], index, original and original.OwnerUserId)
		if newRecord then
			fireAreaUpdate(newRecord)
		end
	end)
end

local function gradientText(text: string, startColor: Color3, endColor: Color3): string
	local result = {}
	local len = #text
	for i = 1, len do
		local t = len > 1 and (i - 1) / (len - 1) or 0
		local color = startColor:Lerp(endColor, t)
		local hex = string.format("#%02X%02X%02X", color.R * 255, color.G * 255, color.B * 255)
		local char = text:sub(i, i)
		table.insert(result, string.format('<font color="%s">%s</font>', hex, char))
	end
	return table.concat(result)
end

local function buildRareSpawnPresentations()
	local presentations = {}
	for uid, record in pairs(areaRecords) do
		local slot = originalSlots[uid]
		local assetConfig = AssetDirectory.Directory[record.AssetCategory]
		local rarity = assetConfig and assetConfig.Rarity
		if slot and slot.OwnerUserId == nil and rarity then
			local rarityName = tostring(rarity.DisplayName or rarity._id or "Common")
			local rarityId = tostring(rarity._id or rarityName)
			local isStandardRarity = STANDARD_EGG_RARITIES[string.lower(rarityId)] == true
				or STANDARD_EGG_RARITIES[string.lower(rarityName)] == true

			if not isStandardRarity then
				table.insert(presentations, {
					EggUid = uid,
					Message = ("A %s egg has spawned in %s!"):format(
						gradientText(rarityName, Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 0)),
						record.AreaId
					),
					RarityId = rarityId,
					SoundId = SPECIAL_EGG_ANNOUNCEMENT_SOUND_ID,
				})
			end
		end
	end
	table.sort(presentations, function(a, b)
		return a.EggUid < b.EggUid
	end)
	return presentations
end

local function getPlotSafeCFrame(player: Player): CFrame?
	local plot = Plots and Plots.GetPlot(player)
	local center = plot and plot:FindFirstChild("CenterPoint", true)
	if center and center:IsA("BasePart") then
		return center.CFrame * CFrame.new(0, 4, 0)
	end
	return lastSafeCFrame[player]
end

local function teleportPlayerToSafety(player: Player, now: number)
	if (teleportCooldownUntil[player] or 0) > now then
		return
	end
	local safeCFrame = getPlotSafeCFrame(player)
	if not safeCFrame then
		return
	end
	teleportCooldownUntil[player] = now + 2
	Network.FireClient("Eggs: AreaEggResetTeleportFade", player)
	task.delay(AreaEggResetCycle.TeleportFadeSeconds, function()
		if not player.Parent then
			return
		end
		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if character and root and root:IsA("BasePart") then
			character:PivotTo(safeCFrame)
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
			lastSafeCFrame[player] = safeCFrame
		end
	end)
end

local function commitNightGrowthForPlayer(player: Player, sampleTime: number, dayStartsAt: number)
	local profile = Data.Get(player)
	if not profile then
		return false
	end
	local nightStartsAt = dayStartsAt - AreaEggResetTimeUtil.NightDurationSeconds
	local periodIndex = AreaEggResetTimeUtil.GetPeriodIndex(dayStartsAt)
	local inventory = copy(profile.EggInventory or {})
	local changed = false

	for _, egg in pairs(inventory) do
		local placement = typeof(egg) == "table" and egg.Placement or nil
		if typeof(placement) == "table" and placement.ReadyAt == nil then
			local placedAt = tonumber(placement.PlacedAt) or sampleTime
			if placedAt <= nightStartsAt then
				local committed = 0
				if placement.NightGrowthPeriodIndex == periodIndex then
					committed = math.max(0, tonumber(placement.NightGrowthCreditSeconds) or 0)
				end
				local remainingAtNightfall = getBaseEggRemaining(egg, nightStartsAt) + committed
				local targetCredit = math.min(AreaEggResetTimeUtil.NightGrowthSkipSeconds, math.max(0, remainingAtNightfall))
				local desiredCredit = math.min(
					targetCredit,
					AreaEggResetTimeUtil.GetNightGrowthSecondsAt(sampleTime, nightStartsAt)
				)
				local delta = desiredCredit - committed
				if delta > 0.01 then
					placement.GrowthCreditSeconds = math.max(0, tonumber(placement.GrowthCreditSeconds) or 0) + delta
					placement.NightGrowthPeriodIndex = periodIndex
					placement.NightGrowthCreditSeconds = desiredCredit
					if getEggRemaining(egg, sampleTime) <= 0 then
						placement.ReadyAt = sampleTime
					end
					changed = true
				end
			end
		end
	end

	if changed then
		Data.Update(player, {EggInventory = inventory})
	end
	return changed
end

local function commitNightGrowthForAll(sampleTime: number, dayStartsAt: number)
	for _, player in ipairs(Players:GetPlayers()) do
		commitNightGrowthForPlayer(player, sampleTime, dayStartsAt)
	end
end

local function performAreaEggReset(now: number, dayStartsAt: number)
	for player in pairs(carriedByPlayer) do
		resetCarried(player, false)
	end

	local removedUids = {}
	local removedRecords = {}
	for uid, record in pairs(areaRecords) do
		table.insert(removedUids, uid)
		removedRecords[uid] = copy(record)
	end
	table.sort(removedUids)

	areaGeneration += 1
	for _, player in ipairs(Players:GetPlayers()) do
		if Data.Get(player) then
			Data.Update(player, {
				CurrentAreaEggClaims = {Slots = {}},
			})
		end
	end

	spawnAllAreaEggs()
	for _, player in ipairs(Players:GetPlayers()) do
		if Data.Get(player) then
			spawnForestForPlayer(player, false)
		end
	end

	local updatedRecords = areaSnapshot().Records
	table.sort(updatedRecords, function(a, b)
		return a.Uid < b.Uid
	end)
	currentRareSpawns = buildRareSpawnPresentations()
	currentResetSequence = {
		DayStartsAt = dayStartsAt,
		RareSpawns = copy(currentRareSpawns),
		IsManual = if AreaEggResetTimeUtil.IsManualNight(now) then true else nil,
	}
	wallGuardStartsAt = now + AreaEggResetCycle.WallServerEntryGuardStartDelaySeconds
	wallGuardEndsAt = dayStartsAt

	Network.FireAll("Eggs: AreaEggResetStartCountdown", copy(currentResetSequence))
	broadcastAreaEggBatch(updatedRecords, removedUids, now)

	for _, uid in ipairs(removedUids) do
		Eggs.AreaChanged:Fire("Removed", uid, removedRecords[uid])
	end
	for _, record in ipairs(updatedRecords) do
		Eggs.AreaChanged:Fire("Updated", copy(record))
	end
end

local function stepWallEntryGuard(now: number)
	if not separationLine then
		return
	end
	for _, player in ipairs(Players:GetPlayers()) do
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if root and root:IsA("BasePart") then
			local side = (root.Position - separationLine.Position):Dot(separationLine.CFrame.LookVector)
			if side <= 0 then
				lastSafeCFrame[player] = root.CFrame
			elseif now >= wallGuardStartsAt and now <= wallGuardEndsAt
				and side > AreaEggResetCycle.WallEntryPenetrationBufferStuds then
				teleportPlayerToSafety(player, now)
			end
		end
	end
end

local function recoverMissingAreaEggs(now: number)
	if next(areaRecords) ~= nil or now < nextAreaRecoveryAt then
		return
	end
	nextAreaRecoveryAt = now + 1
	spawnAllAreaEggs()
	if next(areaRecords) == nil then
		return
	end
	for _, player in ipairs(Players:GetPlayers()) do
		if Data.Get(player) then
			spawnForestForPlayer(player, false)
		end
	end
	currentRareSpawns = buildRareSpawnPresentations()
	broadcastAreaEggBatch(areaSnapshot().Records, {}, now)
end

local function stepNightCycle(now: number)
	recoverMissingAreaEggs(now)
	local isNight = AreaEggResetTimeUtil.IsNight(now)
	setResetWallCollisionEnabled(isNight)
	if isNight then
		local dayStartsAt = AreaEggResetTimeUtil.GetNextResetAt(now)
		local periodIndex = AreaEggResetTimeUtil.GetPeriodIndex(dayStartsAt)
		if lastNightPeriodIndex ~= periodIndex then
			lastNightPeriodIndex = periodIndex
			activeNightDayStartsAt = dayStartsAt
			lastNightCommitAt = -math.huge
			performAreaEggReset(now, dayStartsAt)
		end
		if now - lastNightCommitAt >= 0.5 then
			lastNightCommitAt = now
			commitNightGrowthForAll(now, dayStartsAt)
		end
	elseif activeNightDayStartsAt then
		commitNightGrowthForAll(activeNightDayStartsAt, activeNightDayStartsAt)
		activeNightDayStartsAt = nil
	end
	stepWallEntryGuard(now)
end

local function canUseNightTestCommand(player: Player): boolean
	if RunService:IsStudio() or game.PrivateServerOwnerId == player.UserId then
		return true
	end
	if game.CreatorType == Enum.CreatorType.User then
		return player.UserId == game.CreatorId
	end
	if game.CreatorType == Enum.CreatorType.Group then
		local ok, rank = pcall(player.GetRankInGroup, player, game.CreatorId)
		return ok and rank >= 255
	end
	return false
end

local function startManualNight(player: Player): boolean
	if not canUseNightTestCommand(player) then
		return false
	end
	local now = Workspace:GetServerTimeNow()
	if (manualNightCommandCooldown[player] or 0) > now then
		return false
	end
	manualNightCommandCooldown[player] = now + 0.5
	AreaEggResetTimeUtil.SetManualNightWindow(now, now + AreaEggResetTimeUtil.NightDurationSeconds)
	lastNightPeriodIndex = nil
	activeNightDayStartsAt = nil
	lastNightCommitAt = -math.huge
	stepNightCycle(now)
	return true
end

local function placeEgg(player: Player, request)
	if typeof(request) ~= "table" or typeof(request.Uid) ~= "string" or typeof(request.LocalCFrame) ~= "CFrame" then
		return false, "Invalid egg placement."
	end
	local profile = Data.Get(player)
	local plot = Plots.GetPlot(player)
	local egg = profile and profile.EggInventory and profile.EggInventory[request.Uid]
	if not profile or not plot or typeof(egg) ~= "table" then
		return false, "That egg is not in your inventory."
	end
	if egg.Placement then
		return false, "That egg is already placed."
	end
	local centerPoint = plot:FindFirstChild("CenterPoint", true)
	local toUpdate = plot:FindFirstChild("ToUpdate")
	local petArea = toUpdate and toUpdate:FindFirstChild("PetArea")
	if not centerPoint or not centerPoint:IsA("BasePart") or not petArea or not petArea:IsA("BasePart") then
		return false, "Your plot is missing its egg pen."
	end
	local worldCFrame = centerPoint.CFrame * request.LocalCFrame
	local localPoint = petArea.CFrame:PointToObjectSpace(worldCFrame.Position)
	local halfSize = petArea.Size * 0.5
	if math.abs(localPoint.X) > halfSize.X + 1 or math.abs(localPoint.Z) > halfSize.Z + 1 then
		return false, "Place the egg inside your pen."
	end
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not root or not root:IsA("BasePart") or (root.Position - worldCFrame.Position).Magnitude > 90 then
		return false, "Move closer to your pen before placing the egg."
	end
	local occupied = #(profile.EquippedAssets or {})
	for _, savedEgg in pairs(profile.EggInventory or {}) do
		if typeof(savedEgg) == "table" and savedEgg.Placement then
			occupied += 1
		end
	end
	local config = AssetDirectory.Directory[egg.AssetCategory]
	local growthDuration = if config and config.Egg then math.max(1, tonumber(config.Egg.GrowthTime) or 10) else 10
	local now = Workspace:GetServerTimeNow()
	local components = {request.LocalCFrame:GetComponents()}
	local inventory = copy(profile.EggInventory)
	inventory[request.Uid].Placement = {
		LocalCFrame = components,
		PlacedAt = now,
		GrowthDuration = growthDuration,
	}
	removeEggTool(player, request.Uid)
	Data.Update(player, {
		EggInventory = inventory,
		HasPlacedFirstEgg = true,
	})
	return true
end

local function createSavedEgg(category: string)
	local colors = AssetColorUtil.RollFields(category, rng)
	return {
		AssetCategory = category,
		AssetScale = rng:NextNumber(0.9, 1.1),
		AssetEyeColor = colors.EyeColor,
		AssetColorSeed = colors.ColorSeed,
		AssetColorIndex = colors.ColorIndex,
		Mutations = {},
		AssetGender = if rng:NextNumber() < 0.5 then "Male" else "Female",
	}
end

function Eggs.GrantEggs(player: Player, requestedCount: number, LimitedTimeEgg: boolean, category: string?): (boolean, number)
	local profile = Data.Get(player)
	if not profile then
		return false, 0
	end

	local pickCategory
	if LimitedTimeEgg == true then
		pickCategory = category and (function() return category end) or chooseLimitedTimeCategory
	elseif LimitedTimeEgg == false then
		pickCategory = category and (function() return category end) or function() return chooseCategory("Forest") end
	else
		return false, 0
	end

	local inventory = copy(profile.EggInventory or {})
	local count = 0
	for _ in pairs(inventory) do
		count += 1
	end
	local grantCount = math.clamp(math.floor(requestedCount), 0, 115 - count)
	local grantedAny = false
	for _ = 1, grantCount do
		local resolvedCategory = pickCategory()
		if AssetDirectory.Directory[resolvedCategory] then
			inventory[HttpService:GenerateGUID(false)] = createSavedEgg(resolvedCategory)
			grantedAny = true
		end
	end
	if grantedAny then
		Data.Update(player, {EggInventory = inventory})
	end
	return grantedAny, grantCount
end

function Eggs.GrantEggsByRarity(player: Player, requestedCount: number, rarityId: string): (boolean, number)
	local candidates = {}
	for category in pairs(AssetDirectory.ByRarity[rarityId] or {}) do
		table.insert(candidates, category)
	end
	if #candidates == 0 then
		return false, 0
	end
	return Eggs.GrantEggs(player, requestedCount, false, candidates[rng:NextInteger(1, #candidates)])
end

function Eggs.ApplySkipGrowthSelected(player: Player, maxRemainingSeconds: number): boolean
	local uid = selectedSkipUid[player]
	local profile = Data.Get(player)
	local egg = uid and profile and profile.EggInventory and profile.EggInventory[uid]
	if not uid or not profile or typeof(egg) ~= "table" or not egg.Placement then
		return false
	end
	local now = Workspace:GetServerTimeNow()
	local remaining = getEggRemaining(egg, now)
	if remaining > maxRemainingSeconds + 5 then
		return false
	end
	local inventory = copy(profile.EggInventory)
	inventory[uid].Placement.ReadyAt = now
	selectedSkipUid[player] = nil
	Data.Update(player, {EggInventory = inventory})
	return true
end

function Eggs.ReadyAllPlaced(player: Player): boolean
	local profile = Data.Get(player)
	if not profile then
		return false
	end
	local inventory = copy(profile.EggInventory or {})
	local changed = false
	local now = Workspace:GetServerTimeNow()
	for _, egg in pairs(inventory) do
		if typeof(egg) == "table" and egg.Placement and getEggRemaining(egg, now) > 0 then
			egg.Placement.ReadyAt = now
			changed = true
		end
	end
	if changed then
		Data.Update(player, {EggInventory = inventory})
	end
	return changed
end

function Eggs.Init(dataService, plotService, activeAssetService)
	Data = dataService
	Plots = plotService
	ActiveAssets = activeAssetService
	spawnAllAreaEggs()
	areaGeneration = 1
	currentRareSpawns = buildRareSpawnPresentations()
	Network.GetEvent("Eggs: AreaEggResetStartCountdown")
	Network.GetEvent("Eggs: AreaEggResetTeleportFade")
	Network.GetEvent("Eggs: AreaEggBatchUpdated")
	setResetWallCollisionEnabled(false)
	if next(areaRecords) == nil then
		task.spawn(function()
			for _ = 1, 40 do
				task.wait(0.25)
				spawnAllAreaEggs()
				if next(areaRecords) ~= nil then
					currentRareSpawns = buildRareSpawnPresentations()
					broadcastAreaEggBatch(areaSnapshot().Records, {}, Workspace:GetServerTimeNow())
					return
				end
			end
			warn("[Eggs] Area egg startup scan exhausted retries without finding any nests")
		end)
	end

	Network.BindFunction("Eggs: RequestManualNightTest", function(player)
		if startManualNight(player) then
			return true
		end
		return false, "You are not allowed to use /night right now."
	end)

	Network.BindFunction("Eggs: RequestEggRecord", function(player, uid)
		local profile = Data.Get(player)
		local egg = profile and profile.EggInventory and profile.EggInventory[uid]
		return if typeof(egg) == "table" then toRuntimeEgg(egg) else nil
	end)
	Network.BindFunction("Eggs: RequestRuntimeSnapshot", function()
		local snapshot = {}
		for _, player in ipairs(Players:GetPlayers()) do
			if Data.Get(player) then
				table.insert(snapshot, runtimeUpdate(player))
			end
		end
		return snapshot
	end)
	Network.BindFunction("Eggs: RequestAreaEggSnapshot", function(player)
		local snapshot = areaSnapshot()
		local filtered = {}
		for _, record in ipairs(snapshot.Records) do
			local ownerUserId = isForestUid(record.Uid)
			if not ownerUserId or ownerUserId == player.UserId then
				table.insert(filtered, record)
			end
		end
		return {Records = filtered, ServerTime = snapshot.ServerTime}
	end)
	Network.BindFunction("Eggs: RequestAreaEggRareSpawnPresentations", function(player)
		if not Data.Get(player) then
			return false, nil
		end
		return true, copy(currentRareSpawns)
	end)
	Network.BindFunction("Eggs: RequestEquipTool", function(player, uid)
		local profile = Data.Get(player)
		local egg = profile and profile.EggInventory and profile.EggInventory[uid]
		if typeof(egg) ~= "table" or egg.Placement then
			return false, "That egg cannot be equipped."
		end
		if not makeEggTool(player, uid, egg) then
			return false, "Your backpack is not ready."
		end
		return true
	end)
	Network.BindFunction("Eggs: RequestUnequipTool", function(player, uid)
		removeEggTool(player, if typeof(uid) == "string" then uid else nil)
		return true
	end)
	Network.BindFunction("Eggs: RequestPlaceEgg", placeEgg)
	Network.BindFunction("Eggs: RequestSkipGrowth", function(player, uid)
		local profile = Data.Get(player)
		local egg = profile and profile.EggInventory and profile.EggInventory[uid]
		if typeof(uid) ~= "string" or typeof(egg) ~= "table" or not egg.Placement then
			return false, "That egg is not growing.", nil
		end
		local now = Workspace:GetServerTimeNow()
		local remaining = getEggRemaining(egg, now)
		if remaining <= 0 then
			return false, "That egg is already ready.", nil
		end
		local product = ProductDirectory.GetEggSkipGrowthProduct(remaining)
		if not product then
			return false, "That egg is almost ready.", nil
		end
		selectedSkipUid[player] = uid
		return true, nil, product.ProductId
	end)
	Network.BindFunction("Eggs: RequestHatchEgg", function(player, uid)
		local profile = Data.Get(player)
		local egg = profile and profile.EggInventory and profile.EggInventory[uid]
		if typeof(egg) ~= "table" or not egg.Placement then
			return false, "That egg is not placed."
		end
		if getEggRemaining(egg, Workspace:GetServerTimeNow()) > 0 then
			return false, "That egg is still growing."
		end
		hatching[player] = hatching[player] or {}
		hatching[player][uid] = true
		return true
	end)
	Network.BindFunction("Eggs: RequestCompleteHatchEgg", function(player, uid)
		local profile = Data.Get(player)
		local egg = profile and profile.EggInventory and profile.EggInventory[uid]
		if not hatching[player] or not hatching[player][uid] or typeof(egg) ~= "table" then
			return false, "That hatch was not started.", nil
		end
		if not egg.Placement or getEggRemaining(egg, Workspace:GetServerTimeNow()) > 0 then
			return false, "That egg is still growing.", nil
		end
		hatching[player][uid] = nil
		local assetUid = HttpService:GenerateGUID(false)
		local inventory = copy(profile.Inventory or {})
		inventory[assetUid] = {
			Category = egg.AssetCategory,
			Mutations = copy(egg.Mutations or {}),
			BaseMutation = egg.BaseMutation,
			Scale = egg.AssetScale,
			Gender = egg.AssetGender,
			EyeColor = egg.AssetEyeColor,
			ColorSeed = egg.AssetColorSeed,
			ColorIndex = egg.AssetColorIndex,
			Personality = if typeof(egg.AssetPersonality) == "string" and Personalities.IsPersonality(egg.AssetPersonality)
				then egg.AssetPersonality
				else Personalities.Personalities.Normal,
			IsStolenDNA = egg.IsStolenDNA == true,
			HasBeenFirstPlaced = false,
			Seed = rng:NextInteger(1, 1_000_000_000),
		}
		local eggInventory = copy(profile.EggInventory)
		eggInventory[uid] = nil
		local equippedAssets = copy(profile.EquippedAssets or {})
		local occupied = #equippedAssets
		for _, savedEgg in pairs(eggInventory) do
			if typeof(savedEgg) == "table" and savedEgg.Placement then
				occupied += 1
			end
		end
		if occupied < Plots.GetCapacity(player) then
			table.insert(equippedAssets, assetUid)
			inventory[assetUid].HasBeenFirstPlaced = true
		end
		local index = copy(profile.Index or {})
		index[egg.AssetCategory] = true

		Data.Update(player, {
			Inventory = inventory,
			EggInventory = eggInventory,
			EquippedAssets = equippedAssets,
			Index = index,
		})
		ActiveAssets.Rebuild(player)
		return true, nil, assetUid
	end)
	Network.BindFunction("Eggs: RequestAreaEggCarry", function(player, request)
		if typeof(request) ~= "table" or typeof(request.Uid) ~= "string" then
			return false, "Invalid egg."
		end
		if carriedByPlayer[player] then
			return false, "You are already carrying an egg."
		end
		local record = areaRecords[request.Uid]
		if not record or (record.State ~= "Slot" and record.State ~= "Dropped") then
			return false, "That egg is unavailable."
		end
		local personalOwnerId = tonumber(string.match(request.Uid, "^FirstAreaEgg_(-?%d+)_"))
		if personalOwnerId and personalOwnerId ~= player.UserId then
			return false, "That Forest egg belongs to another player."
		end
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if not root or not root:IsA("BasePart") or (root.Position - record.BottomCFrame.Position).Magnitude > 28 then
			return false, "Move closer to the egg."
		end
		carriedByPlayer[player] = record.Uid
		carrySlotKey[player] = if typeof(request.FirstAreaSlotKey) == "string" then request.FirstAreaSlotKey else nil
		record.State = "Carried"
		record.CarrierUserId = player.UserId
		record.DroppedAt = nil
		record.Version += 1
		fireAreaUpdate(record)
		carryState(player, record)
		return true
	end)
	Network.BindFunction("Eggs: RequestAreaEggDrop", function(player)
		resetCarried(player, true)
		return true
	end)

	Data.Loaded.Event:Connect(function(player)
		spawnForestForPlayer(player)
		publishRuntime(player)
		local now = Workspace:GetServerTimeNow()
		if currentResetSequence and now <= wallGuardEndsAt then
			Network.FireClient("Eggs: AreaEggResetStartCountdown", player, copy(currentResetSequence))
		elseif AreaEggResetTimeUtil.IsNight(now) then
			local dayStartsAt = AreaEggResetTimeUtil.GetNextResetAt(now)
			Network.FireClient("Eggs: AreaEggResetStartCountdown", player, {
				DayStartsAt = dayStartsAt,
				RareSpawns = copy(currentRareSpawns),
			})
		end
		if AreaEggResetTimeUtil.IsNight(now) then
			commitNightGrowthForPlayer(player, now, AreaEggResetTimeUtil.GetNextResetAt(now))
		end
		task.defer(equipFirstUnplacedEgg, player)
		player.CharacterAdded:Connect(function()
			task.delay(0.5, equipFirstUnplacedEgg, player)
		end)
		player.CharacterRemoving:Connect(function()
			resetCarried(player, false)
		end)
	end)
	Data.Changed.Event:Connect(function(player, changes)
		if changes.EggInventory ~= nil then
			publishRuntime(player)
		end
	end)
	Players.PlayerRemoving:Connect(function(player)
		resetCarried(player, false)
		hatching[player] = nil
		selectedSkipUid[player] = nil
		lastSafeCFrame[player] = nil
		teleportCooldownUntil[player] = nil
		manualNightCommandCooldown[player] = nil
		local prefix = "FirstAreaEgg_" .. player.UserId .. "_"
		for uid, record in pairs(areaRecords) do
			if string.find(uid, prefix, 1, true) == 1 then
				areaRecords[uid] = nil
				originalSlots[uid] = nil
				Network.FireAll("Eggs: AreaEggRemoved", uid)
				Eggs.AreaChanged:Fire("Removed", uid, copy(record))
			end
		end
		Network.FireAll("Eggs: RuntimeOwnerCleared", {OwnerUserId = player.UserId})
	end)

	local objects = Workspace:FindFirstChild("__OBJECTS")
	local areas = objects and objects:FindFirstChild("Areas")
	local separation = areas and areas:FindFirstChild("SeparationLine")
	separationLine = if separation and separation:IsA("BasePart") then separation else nil
	RunService.Heartbeat:Connect(function()
		if not separationLine then
			return
		end
		for player in pairs(carriedByPlayer) do
			local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if root and root:IsA("BasePart") then
				local side = (root.Position - separationLine.Position):Dot(separationLine.CFrame.LookVector)
				if side <= 0 then
					claimCarried(player)
				end
			end
		end
	end)

	task.spawn(function()
		while true do
			local ok, err = xpcall(function()
				stepNightCycle(Workspace:GetServerTimeNow())
			end, debug.traceback)
			if not ok then
				warn("[Eggs] Night cycle step failed: " .. tostring(err))
				task.wait(1)
			else
				task.wait(0.1)
			end
		end
	end)
end

return Eggs
