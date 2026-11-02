--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Remotes = require(ReplicatedStorage.Shared.Remotes)
local DataService = require(game:GetService("ServerScriptService").DataService)
local PenService = require(game:GetService("ServerScriptService").PenService)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local AreaEggSlotIdentity = require(ReplicatedStorage.Shared.Util.AreaEggSlotIdentity)
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local Areas = require(ReplicatedStorage.Data.Areas)
local Assets = require(ReplicatedStorage.Data.Assets)
local NewUid = require(ReplicatedStorage.Shared.Utils.Codec).NewUid
local SkipHatchGamepassId = require(ReplicatedStorage.Data.MonetizationConfig).GamepassIds.SkipHatch

local EggWorld = Remotes.EggWorld

local States = AreaEggs.States
local DropReasons = AreaEggs.DropReasons

local GuardAreasFolder = Workspace:WaitForChild("__OBJECTS"):WaitForChild("Areas"):WaitForChild("GuardAreas")

local RESPAWN_DELAY_SECONDS = 20
local RARE_RARITY_MIN_NUMBER = 8
local RESET_POLL_SECONDS = 1
local CARRY_DENIED = "Egg not available"

local AreaEggService = {}

local records = {}
local nestOccupant = {}
local nestModelByUid = {}
local carryByPlayer = {}
local hatchingEggs = {}
local areaModelById = {}
local areaNests = {}
local areaBounds = {}
local version = 0

local function slotKey(areaId, nestId)
	return AreaEggSlotIdentity.SlotKey(areaId, nestId)
end

local function cacheArea(areaId)
	local model = GuardAreasFolder:FindFirstChild(areaId)
	if not model then
		return
	end
	areaModelById[areaId] = model
	local ok, nests = pcall(AreaEggSlotIdentity.SortedNests, model)
	if ok then
		areaNests[areaId] = nests
	else
		warn(("[AreaEggService] could not read nests for %s: %s"):format(areaId, tostring(nests)))
	end
	local bounds = model:FindFirstChild("Bounds")
	if bounds and bounds:IsA("BasePart") then
		areaBounds[areaId] = bounds
	end
end

for areaId in pairs(Areas.Directory) do
	cacheArea(areaId)
end

local function weightedPick(dropTable)
	local total = 0
	for _, entry in ipairs(dropTable) do
		total += entry[2]
	end
	if total <= 0 then
		return dropTable[1][1]
	end
	local roll = math.random() * total
	local acc = 0
	for _, entry in ipairs(dropTable) do
		acc += entry[2]
		if roll <= acc then
			return entry[1]
		end
	end
	return dropTable[#dropTable][1]
end

local function pickCategoryFor(areaId)
	local area = Areas.Directory[areaId]
	if area and area.DropTable and #area.DropTable > 0 then
		return weightedPick(area.DropTable)
	end
	return "Chicken"
end

local EggTemplatesFolder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Models"):WaitForChild("Eggs")
local NEST_TO_EGG_FOOTPRINT_RATIO = 1.2
local MIN_NEST_SCALE = 0.15
local MAX_NEST_SCALE = 3.0

local function resolveNestScale(nestModel, category, assetScale)
	local ok, result = pcall(function()
		local template = EggTemplatesFolder:FindFirstChild(category)
		if not template then
			return nil
		end
		local currentNestScale = nestModel:GetScale()
		local _, nestCurrentSize = nestModel:GetBoundingBox()
		local nestBaseFootprint = math.max(nestCurrentSize.X, nestCurrentSize.Z) / math.max(currentNestScale, 1e-4)
		if nestBaseFootprint <= 0 then
			return nil
		end
		local _, templateSize = template:GetBoundingBox()
		local eggFootprint = math.max(templateSize.X, templateSize.Z) * (assetScale or 1)
		return math.clamp((eggFootprint * NEST_TO_EGG_FOOTPRINT_RATIO) / nestBaseFootprint, MIN_NEST_SCALE, MAX_NEST_SCALE)
	end)
	if ok and result then
		return result
	end
	return math.clamp(assetScale or 1, MIN_NEST_SCALE, MAX_NEST_SCALE)
end

local function makeRecord(areaId, nestId, nestModel, uid, forcedCategory)
	local category = forcedCategory or pickCategoryFor(areaId)
	local ok, egg = pcall(EggRecords.NewEgg, category)
	if not ok then
		warn(("[AreaEggService] EggRecords.NewEgg failed for %s: %s"):format(tostring(category), tostring(egg)))
		return nil
	end

	local areaModel = areaModelById[areaId]
	local bounds = areaBounds[areaId]
	local eggSpotBottom = nestModel:FindFirstChild("EggSpotBottom", true)

	version += 1
	local record = {
		Uid = uid,
		AreaId = areaId,
		NestId = nestId,
		AssetCategory = egg.AssetCategory,
		AssetScale = egg.AssetScale,
		AssetEyeColor = egg.AssetEyeColor,
		AssetColorSeed = egg.AssetColorSeed,
		AssetColorIndex = egg.AssetColorIndex,
		Mutations = egg.Mutations or {},
		BaseMutation = egg.BaseMutation,
		NestScale = resolveNestScale(nestModel, egg.AssetCategory, egg.AssetScale),
		BottomCFrame = (eggSpotBottom and eggSpotBottom.CFrame) or nestModel:GetPivot(),
		BoundsCFrame = (bounds and bounds.CFrame) or (areaModel and areaModel:GetPivot()) or CFrame.new(),
		BoundsSize = (bounds and bounds.Size) or Vector3.new(0, 0, 0),
		State = States.Slot,
		CarrierUserId = nil,
		DroppedAt = nil,
		Version = version,
	}

	local valid = AreaEggs.SchemaValidation.AreaEggRecord(record)
	if not valid then
		warn("[AreaEggService] built an invalid area egg record; dropping it")
		return nil
	end

	records[uid] = record
	nestOccupant[slotKey(areaId, nestId)] = uid
	nestModelByUid[uid] = nestModel
	return record
end

local function broadcastRecord(record)
	EggWorld.FieldEggShifted:FireAllClients(record)
end

local function removeRecord(uid)
	local record = records[uid]
	if not record then
		return nil
	end
	records[uid] = nil
	nestModelByUid[uid] = nil
	local key = slotKey(record.AreaId, record.NestId)
	if nestOccupant[key] == uid then
		nestOccupant[key] = nil
	end
	EggWorld.FieldEggGone:FireAllClients(uid)
	return record
end

local function scheduleRespawn(areaId, nestModel, nestId)
	task.delay(RESPAWN_DELAY_SECONDS, function()
		if nestOccupant[slotKey(areaId, nestId)] == nil and areaNests[areaId] then
			AreaEggService.SpawnIntoNest(areaId, nestModel, nestId)
		end
	end)
end

function AreaEggService.SpawnIntoNest(areaId, nestModel, nestId, forcedCategory)
	local key = slotKey(areaId, nestId)
	if nestOccupant[key] ~= nil then
		return records[nestOccupant[key]]
	end
	local record = makeRecord(areaId, nestId, nestModel, NewUid(), forcedCategory)
	if record then
		broadcastRecord(record)
	end
	return record
end

-- Public helper used by the admin panel: drop an egg into a free nest in the given
-- area. Returns the record on success, or nil when the area has no free nest.
function AreaEggService.SpawnInArea(areaId, forcedCategory)
	local nests = areaNests[areaId]
	local model = areaModelById[areaId]
	if not nests or not model then
		return nil
	end
	for _, nestModel in ipairs(nests) do
		local ok, nestId = pcall(AreaEggSlotIdentity.NestIdFor, model, nestModel)
		if ok and nestOccupant[slotKey(areaId, nestId)] == nil then
			return AreaEggService.SpawnIntoNest(areaId, nestModel, nestId, forcedCategory)
		end
	end
	return nil
end

local function findCarriedBy(player)
	local uid = carryByPlayer[player]
	if uid == nil then
		return nil, nil
	end
	return records[uid], uid
end

local function setCarryState(player, payload)
	EggWorld.FieldEggCarry:FireClient(player, payload)
end

local function buildOwnedEgg(record)
	-- EggRecords.NewEgg already returns the SavedEgg shape; Encode normalises the
	-- palette fields (a stolen egg has no Placement to serialise).
	local egg = {
		AssetCategory = record.AssetCategory,
		AssetScale = record.AssetScale,
		AssetEyeColor = record.AssetEyeColor,
		AssetColorSeed = record.AssetColorSeed,
		AssetColorIndex = record.AssetColorIndex,
		Mutations = record.Mutations or {},
		BaseMutation = record.BaseMutation,
		IsStolenDNA = true,
	}
	return EggRecords.Encode(egg)
end

-- Puts the stolen egg into the player's real EggInventory (map uid -> egg) via
-- DataService, so it lands in the backpack and persists like any other egg.
-- Returns the new egg uid on success, or nil if it could not be granted.
local function grantCarriedEgg(player, record)
	local profile = DataService.WaitForProfile(player, 5)
	if not profile then
		warn(("[AreaEggService] refused to grant stolen egg %s: profile not loaded for %s"):format(record.Uid, player.Name))
		return nil
	end

	local egg = buildOwnedEgg(record)
	if not egg then
		return nil
	end

	local uid = NewUid()
	profile.EggInventory = profile.EggInventory or {}
	profile.EggInventory[uid] = egg

	-- SyncChange mirrors the whole EggInventory to the client through ProfileMirror.
	DataService.SyncChange(player, "EggInventory", profile.EggInventory)

	local config = Assets.Directory[record.AssetCategory]
	local rarity = config and config.Rarity
	EggWorld.FieldEggRedeemVerdict:FireClient(player, {
		AssetCategory = record.AssetCategory,
		DisplayName = (config and config.DisplayName and config.DisplayName ~= "" and config.DisplayName) or record.AssetCategory,
		Rarity = (rarity and rarity._id) or "Common",
		Color = (rarity and rarity.Color) or Color3.new(1, 1, 1),
		Position = record.BottomCFrame.Position,
	})
	return uid
end

local function claimRecord(player, record)
	carryByPlayer[player] = nil
	setCarryState(player, { IsCarrying = false, SpeedMultiplier = 1 })

	-- Grant first: if the profile is not ready we keep the egg on the field so the
	-- player can still claim it, rather than deleting it and giving nothing.
	local grantedUid = grantCarriedEgg(player, record)
	if not grantedUid then
		returnToNest(record)
		return
	end

	local nestModel = nestModelByUid[record.Uid]
	local areaId = record.AreaId
	local nestId = record.NestId
	removeRecord(record.Uid)
	if nestModel then
		scheduleRespawn(areaId, nestModel, nestId)
	end
end

local function returnToNest(record)
	version += 1
	record.State = States.Slot
	record.CarrierUserId = nil
	record.DroppedAt = nil
	record.Version = version
	nestOccupant[slotKey(record.AreaId, record.NestId)] = record.Uid
	broadcastRecord(record)
end

local function attemptCarry(player, uid, firstAreaSlotKey)
	if type(uid) ~= "string" then
		return false, "Invalid request"
	end
	if carryByPlayer[player] then
		return false, "Already carrying an egg"
	end
	local record = records[uid]
	if not record or (record.State ~= States.Slot and record.State ~= States.Dropped) then
		return false, CARRY_DENIED
	end

	version += 1
	record.State = States.Carried
	record.CarrierUserId = player.UserId
	record.Version = version

	local key = slotKey(record.AreaId, record.NestId)
	if nestOccupant[key] == uid then
		nestOccupant[key] = nil
	end
	carryByPlayer[player] = uid

	broadcastRecord(record)
	setCarryState(player, {
		IsCarrying = true,
		Uid = record.Uid,
		AreaId = record.AreaId,
		AssetCategory = record.AssetCategory,
		RunBackWakeDelayRequired = false,
		SpeedMultiplier = 1,
	})
	return true
end

EggWorld.AskFieldEggSnapshot.OnServerInvoke = function(_player)
	local list = {}
	for _, record in pairs(records) do
		table.insert(list, record)
	end
	return { Records = list, ServerTime = Workspace:GetServerTimeNow() }
end

EggWorld.AskFieldEggCarry.OnServerInvoke = function(player, args)
	if type(args) ~= "table" then
		return false, "Invalid request"
	end
	local valid = AreaEggs.SchemaValidation.AreaEggCarryRequest(args)
	if not valid then
		return false, "Invalid request"
	end
	return attemptCarry(player, args.Uid, args.FirstAreaSlotKey)
end

EggWorld.AskFieldEggDrop.OnServerInvoke = function(player, _args)
	local uid = carryByPlayer[player]
	if uid == nil then
		return false, "Not carrying anything"
	end
	carryByPlayer[player] = nil
	local record = records[uid]
	if record then
		returnToNest(record)
	end
	setCarryState(player, { IsCarrying = false, SpeedMultiplier = 1 })
	return true
end

EggWorld.AskFieldEggRarityShows.OnServerInvoke = function(_player)
	if os.clock() - AreaEggService._lastRevealAt <= 30 then
		return true, AreaEggService._lastReveal
	end
	return false, nil
end

-- ------------------------------------------------------------------
-- Owned-egg side (placing an egg from the backpack)
--
-- The client (PlacedEggRenderer / EggState) already renders, grows and hatches
-- placed eggs straight from the profile's EggInventory. The server only has to
-- write the Placement into the egg record and tell the owner it changed.
-- ------------------------------------------------------------------

-- RuntimeEggRecord (Eggs.SchemaValidation v9) = SerializedSavedEgg + Placement + GrowthSpeedMultiplier.
local function toRuntimeRecord(egg)
	-- Profile inventory stores placements in serialized form (12-number
	-- component arrays); runtime records must carry a real CFrame per the
	-- client's RuntimeEggOwnerUpdate schema, so decode instead of encode.
	local runtime = EggRecords.Decode(egg)
	runtime.GrowthSpeedMultiplier = 1
	return runtime
end

local function broadcastOwnerEggs(player)
	local profile = DataService.Get(player)
	if not profile then
		return
	end
	local records = {}
	for uid, egg in pairs(profile.EggInventory or {}) do
		if type(uid) == "string" and type(egg) == "table" then
			records[uid] = toRuntimeRecord(egg)
		end
	end
	EggWorld.OwnerShifted:FireClient(player, {
		OwnerUserId = player.UserId,
		Records = records,
	})
end

EggWorld.AskLiveSnapshot.OnServerInvoke = function(_player)
	local snapshot = {}
	for _, other in ipairs(Players:GetPlayers()) do
		local profile = DataService.Get(other)
		if profile then
			local records = {}
			for uid, egg in pairs(profile.EggInventory or {}) do
				if type(uid) == "string" and type(egg) == "table" then
					records[uid] = toRuntimeRecord(egg)
				end
			end
			table.insert(snapshot, { OwnerUserId = other.UserId, Records = records })
		end
	end
	return snapshot
end

EggWorld.AskEggRecord.OnServerInvoke = function(player, uid)
	if type(uid) ~= "string" then
		return nil
	end
	local profile = DataService.WaitForProfile(player, 30)
	if not profile then
		return nil
	end
	local egg = profile.EggInventory and profile.EggInventory[uid]
	if type(egg) ~= "table" then
		return nil
	end
	return EggRecords.Encode(egg)
end

-- Creates the Tool the client's EggToolDisplayController renders as the egg in hand.
local function buildEggTool(player, uid, egg)
	local backpack = player:FindFirstChildOfClass("Backpack")
	if not backpack then
		return nil
	end
	-- Reuse an existing tool for this egg if there is one.
	for _, existing in ipairs(backpack:GetChildren()) do
		if existing:IsA("Tool") and existing:GetAttribute("ItemType") == "AssetEgg" and existing:GetAttribute("UID") == uid then
			return existing
		end
	end

	local tool = Instance.new("Tool")
	tool.Name = "Egg_" .. uid
	tool.RequiresHandle = true
	tool.CanBeDropped = false
	tool:SetAttribute("ItemType", "AssetEgg")
	tool:SetAttribute("UID", uid)

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

local function findEggTool(player, uid)
	local backpack = player:FindFirstChildOfClass("Backpack")
	if backpack then
		for _, child in ipairs(backpack:GetChildren()) do
			if child:IsA("Tool") and child:GetAttribute("ItemType") == "AssetEgg" and child:GetAttribute("UID") == uid then
				return child
			end
		end
	end
	local character = player.Character
	if character then
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") and child:GetAttribute("ItemType") == "AssetEgg" and child:GetAttribute("UID") == uid then
				return child
			end
		end
	end
	return nil
end

EggWorld.AskWearTool.OnServerInvoke = function(player, uid)
	if type(uid) ~= "string" then
		return false, "Invalid request"
	end
	local profile = DataService.WaitForProfile(player, 30)
	if not profile then
		return false, "Data still loading"
	end
	local egg = profile.EggInventory and profile.EggInventory[uid]
	if type(egg) ~= "table" then
		return false, "Egg not found"
	end
	local tool = buildEggTool(player, uid, egg)
	if not tool then
		return false, "Could not equip egg"
	end
	local character = player.Character
	if character then
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") and child ~= tool and child:GetAttribute("ItemType") == "AssetEgg" then
				child.Parent = player:FindFirstChildOfClass("Backpack")
			end
		end
		tool.Parent = character
	end
	return true
end

EggWorld.AskDoffTool.OnServerInvoke = function(player, uid)
	if uid ~= nil and type(uid) ~= "string" then
		return false, "Invalid request"
	end
	if uid == nil then
		return true
	end
	local tool = findEggTool(player, uid)
	if tool then
		tool:Destroy()
	end
	return true
end

EggWorld.AskPlaceEgg.OnServerInvoke = function(player, args)
	if type(args) ~= "table" or type(args.Uid) ~= "string" or typeof(args.LocalCFrame) ~= "CFrame" then
		return false, "Invalid request"
	end

	local profile = DataService.WaitForProfile(player, 30)
	if not profile then
		return false, "Data still loading"
	end

	local egg = profile.EggInventory and profile.EggInventory[args.Uid]
	if type(egg) ~= "table" then
		return false, "Egg not found"
	end
	if egg.Placement ~= nil then
		return false, "Egg is already placed"
	end

	local placement = EggRecords.EncodePlacement({
		LocalCFrame = args.LocalCFrame,
		PlacedAt = Workspace:GetServerTimeNow(),
		ReadyAt = nil,
		GrowthDuration = nil,
		GrowthCreditSeconds = nil,
		NightGrowthPeriodIndex = nil,
		NightGrowthCreditSeconds = nil,
	})
	egg.Placement = placement

	DataService.SyncChange(player, "EggInventory", profile.EggInventory)
	broadcastOwnerEggs(player)
	return true
end

-- Hatch pipeline. The client drives it in two steps: BeginHatch (validate +
-- reserve the egg) then FinishHatch (grant the pet) after its animation lands.
local MAX_PET_INVENTORY = 250

local function isEggFullyGrown(egg, player)
	local decoded = EggRecords.Decode(egg)
	local now = Workspace:GetServerTimeNow()
	local nightCredit = EggRecords.CurrentNightCredit(decoded, now, 1)
	return EggRecords.IsGrown(decoded, now, 1, nightCredit, player)
end

EggWorld.AskHatch.OnServerInvoke = function(player, uid)
	if type(uid) ~= "string" then
		return false, "Invalid request"
	end
	local profile = DataService.WaitForProfile(player, 30)
	if not profile then
		return false, "Data still loading"
	end
	local egg = profile.EggInventory and profile.EggInventory[uid]
	if type(egg) ~= "table" then
		return false, "Egg not found"
	end
	if egg.Placement == nil then
		return false, "Egg is not placed"
	end
	if not isEggFullyGrown(egg, player) then
		return false, "Egg is not ready yet"
	end
	-- Re-asking is allowed: the marker only exists so FinishHatch can tell a
	-- legitimate completion apart from a forged request. Double grants stay
	-- impossible because FinishHatch removes the egg before responding.
	hatchingEggs[uid] = player.UserId
	return true
end

EggWorld.AskFinishHatch.OnServerInvoke = function(player, uid)
	if type(uid) ~= "string" then
		return false, "Invalid request", nil
	end
	local profile = DataService.WaitForProfile(player, 30)
	if not profile then
		return false, "Data still loading", nil
	end
	local egg = profile.EggInventory and profile.EggInventory[uid]
	if type(egg) ~= "table" then
		hatchingEggs[uid] = nil
		return false, "Egg not found", nil
	end
	if hatchingEggs[uid] ~= player.UserId then
		-- No reserve marker (client reconnected mid-hatch, etc.): fall back to
		-- validating the egg itself so the hatch can still complete.
		if egg.Placement == nil or not isEggFullyGrown(egg, player) then
			return false, "No hatch in progress", nil
		end
	end
	local petCount = 0
	for _ in pairs(profile.Inventory or {}) do
		petCount += 1
	end
	if petCount >= MAX_PET_INVENTORY then
		return false, "Inventory is full", nil
	end
	local decoded = EggRecords.Decode(egg)
	local ok, item = pcall(EggRecords.ToAssetItemData, decoded)
	if not ok then
		warn("[AreaEggService] hatch grant failed: " .. tostring(item))
		return false, "Hatch grant failed", nil
	end
	local grantedUid = NewUid()
	profile.Inventory = profile.Inventory or {}
	profile.Inventory[grantedUid] = item
	profile.EggInventory[uid] = nil
	hatchingEggs[uid] = nil
	DataService.SyncChange(player, "Inventory", profile.Inventory)
	DataService.SyncChange(player, "EggInventory", profile.EggInventory)
	broadcastOwnerEggs(player)
	PenService.SyncTools(player)
	return true, nil, grantedUid
end

EggWorld.AskSkipGrowth.OnServerInvoke = function(player, uid)
	if type(uid) ~= "string" then
		return false, "Invalid request", nil
	end
	local profile = DataService.WaitForProfile(player, 30)
	if not profile then
		return false, "Data still loading", nil
	end
	local egg = profile.EggInventory and profile.EggInventory[uid]
	if type(egg) ~= "table" then
		return false, "Egg not found", nil
	end
	if egg.Placement == nil then
		return false, "Egg is not placed", nil
	end
	if isEggFullyGrown(egg, player) then
		return false, "Egg is already ready", nil
	end
	if profile.Gamepasses and profile.Gamepasses.SkipHatch == true then
		egg.Placement.ReadyAt = Workspace:GetServerTimeNow()
		DataService.SyncChange(player, "EggInventory", profile.EggInventory)
		broadcastOwnerEggs(player)
		return true, nil, nil
	end
	-- Returning the gamepass id makes the client open the Skip Hatch purchase
	-- prompt (EggState.BeginSkipGrowth's contract).
	return false, nil, SkipHatchGamepassId
end

local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)

-- The gameplay side is everything PAST the SeparationLine (the same test the client
-- uses in AreaEggs.isLocalPlayerInGameplay). The safe hub is the opposite side, so a
-- carrying player is "home" once they are no longer past the line.
local function separationLine()
	local areas = Workspace:FindFirstChild("__OBJECTS")
	areas = areas and areas:FindFirstChild("Areas")
	local line = areas and areas:FindFirstChild("SeparationLine")
	if line and line:IsA("BasePart") then
		return line
	end
	return nil
end

local function isInSafeZone(position)
	local line = separationLine()
	if not line then
		return false
	end
	return not GuardAreaGeometry.IsPastLine(line, position)
end

task.spawn(function()
	while true do
		task.wait(RESET_POLL_SECONDS)
		for player, uid in pairs(carryByPlayer) do
			local record = records[uid]
			local character = player.Character
			local hrp = character and character:FindFirstChild("HumanoidRootPart")
			if record and hrp and isInSafeZone(hrp.Position) then
				claimRecord(player, record)
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	local uid = carryByPlayer[player]
	carryByPlayer[player] = nil
	if uid then
		local record = records[uid]
		if record then
			returnToNest(record)
		end
	end
	for eggUid, ownerUserId in pairs(hatchingEggs) do
		if ownerUserId == player.UserId then
			hatchingEggs[eggUid] = nil
		end
	end
end)

local function collectRareSpawns(areaId, record)
	local config = Assets.Directory[record.AssetCategory]
	local rarity = config and config.Rarity
	if not rarity or type(rarity.RarityNumber) ~= "number" or rarity.RarityNumber < RARE_RARITY_MIN_NUMBER then
		return nil
	end
	local displayName = (config.DisplayName and config.DisplayName ~= "" and config.DisplayName) or record.AssetCategory
	return {
		EggUid = record.Uid,
		Message = displayName .. " egg spawned in " .. areaId .. "!",
		RarityId = rarity._id or "Secret",
	}
end

local function resetAllNests(dayStartsAt)
	local rareSpawns = {}
	local updated = {}
	local removed = {}

	for areaId, nests in pairs(areaNests) do
		for _, nestModel in ipairs(nests) do
			local ok, nestId = pcall(AreaEggSlotIdentity.NestIdFor, areaModelById[areaId], nestModel)
			if ok then
				local key = slotKey(areaId, nestId)
				local uid = nestOccupant[key]
				local record = uid and records[uid]
				if not (record and record.State ~= States.Slot) then
					if record then
						records[uid] = nil
						nestModelByUid[uid] = nil
						nestOccupant[key] = nil
						table.insert(removed, uid)
					end
					local newRecord = AreaEggService.SpawnIntoNest(areaId, nestModel, nestId)
					if newRecord then
						table.insert(updated, newRecord)
						local rare = collectRareSpawns(areaId, newRecord)
						if rare then
							table.insert(rareSpawns, rare)
						end
					end
				end
			end
		end
	end

	if #removed > 0 or #updated > 0 then
		EggWorld.FieldEggBatchShifted:FireAllClients({
			UpdatedRecords = updated,
			RemovedUids = removed,
			ServerTime = Workspace:GetServerTimeNow(),
		})
	end

	local periodIndex = AreaEggCycle.ActivePeriodIndexAt(dayStartsAt)
	local reveal = {
		PeriodIndex = periodIndex,
		DayStartsAt = dayStartsAt,
		RareSpawns = rareSpawns,
	}
	AreaEggService._lastReveal = reveal
	AreaEggService._lastRevealAt = os.clock()
	EggWorld.FieldEggRaritiesShown:FireAllClients(reveal)
end

task.spawn(function()
	local lastCountdownPeriod = nil
	local lastResetPeriod = nil

	while true do
		task.wait(RESET_POLL_SECONDS)
		local ok, err = pcall(function()
			local now = Workspace:GetServerTimeNow()
			if not AreaEggCycle.IsRunning() then
				return
			end

			if AreaEggCycle.IsNightPhase(now) then
				local periodIndex = AreaEggCycle.ActivePeriodIndexAt(now)
				if lastCountdownPeriod ~= periodIndex then
					lastCountdownPeriod = periodIndex
					EggWorld.FieldEggCycleCountdown:FireAllClients({
						DayStartsAt = AreaEggCycle.NextResetTime(now),
					})
				end
			else
				local periodIndex = AreaEggCycle.ActivePeriodIndexAt(now)
				if lastCountdownPeriod ~= nil and lastResetPeriod ~= periodIndex then
					lastResetPeriod = periodIndex
					resetAllNests(now)
				end
			end
		end)
		if not ok then
			warn("[AreaEggService] night cycle watcher error: " .. tostring(err))
		end
	end
end)

function AreaEggService.Init()
	AreaEggService._lastReveal = nil
	AreaEggService._lastRevealAt = 0
end

function AreaEggService.Start()
	local delayIndex = 0
	for areaId, nests in pairs(areaNests) do
		for _, nestModel in ipairs(nests) do
			local ok, nestId = pcall(AreaEggSlotIdentity.NestIdFor, areaModelById[areaId], nestModel)
			if ok then
				delayIndex += 1
				task.delay(delayIndex * 0.05, function()
					AreaEggService.SpawnIntoNest(areaId, nestModel, nestId)
				end)
			else
				warn(("[AreaEggService] NestIdFor failed for %s: %s"):format(areaId, tostring(nestId)))
			end
		end
	end
end

return AreaEggService