local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Asserts = require(ReplicatedStorage.Library.Asserts)
local AreaEggs = require(ReplicatedStorage.Library.Types.AreaEggs)
local AreaEggResetCycle = require(ReplicatedStorage.Library.Types.AreaEggResetCycle)
local AreaEggResetTimeUtil = require(ReplicatedStorage.Library.Util.AreaEggResetTimeUtil)
local EggItemUtil = require(ReplicatedStorage.Library.Util.EggItemUtil)
local Eggs = require(ReplicatedStorage.Library.Types.Eggs)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local TableUtil = require(ReplicatedStorage.Library.Modules.Packages.TableUtil)

local EggNetworkEvents = Network.NET_MAP.Eggs

local runtimeSnapshotData = {}
local runtimeSnapshotVersions = {}
local runtimeUpdateCounter = 0

local selectedSkipGrowthUid = nil

local areaEggSnapshotData = {}
local areaEggSnapshotVersions = {}
local areaEggUpdateCounter = 0

local pendingPlacementAnimations = {}
local logger = Log.new()

local EggCmds = {
	RuntimeSnapshotUpdated = Signal.new(),
	RuntimeOwnerUpdated = Signal.new(),
	RuntimeOwnerCleared = Signal.new(),
	AreaEggSnapshotUpdated = Signal.new(),
	AreaEggUpdated = Signal.new(),
	AreaEggRemoved = Signal.new(),
	AreaEggCarryStateChanged = Signal.new(),
	AreaEggClaimed = Signal.new(),
	AreaEggResetTeleportFade = Signal.new(),
	AreaEggResetStartCountdown = Signal.new(),
	AreaEggRareSpawnsPresented = Signal.new(),
	AreaEggCarryVisualUpdated = Signal.new()
}

local function buildRuntimeSnapshotPayload(dataMap)
	local payload = {}

	for userId, records in pairs(dataMap) do
		table.insert(payload, {
			OwnerUserId = userId,
			Records = TableUtil.Copy(records, true)
		})
	end

	return payload
end

local function applySnapshot(snapshotList, snapshotVersion)
	local newSnapshotData = {}

	for userId, records in pairs(runtimeSnapshotData) do
		if snapshotVersion < (runtimeSnapshotVersions[userId] or 0) then
			newSnapshotData[userId] = TableUtil.Copy(records, true)
		end
	end

	for _, snapshot in ipairs(snapshotList) do
		if (runtimeSnapshotVersions[snapshot.OwnerUserId] or 0) <= snapshotVersion then
			newSnapshotData[snapshot.OwnerUserId] = TableUtil.Copy(snapshot.Records, true)
		end
	end

	runtimeSnapshotData = newSnapshotData
	EggCmds.RuntimeSnapshotUpdated:Fire(EggCmds.GetRuntimeSnapshot())
end

local function applyOwnerUpdate(payload)
	runtimeSnapshotData[payload.OwnerUserId] = TableUtil.Copy(payload.Records, true)
	EggCmds.RuntimeOwnerUpdated:Fire(payload.OwnerUserId, EggCmds.GetOwnerRuntimeRecords(payload.OwnerUserId))
	EggCmds.RuntimeSnapshotUpdated:Fire(EggCmds.GetRuntimeSnapshot())
end

local function applyOwnerClear(payload)
	runtimeSnapshotData[payload.OwnerUserId] = nil
	EggCmds.RuntimeOwnerCleared:Fire(payload.OwnerUserId)
	EggCmds.RuntimeSnapshotUpdated:Fire(EggCmds.GetRuntimeSnapshot())
end

local function handleAreaEggCarryVisualUpdated(payload)
	EggCmds.AreaEggCarryVisualUpdated:Fire(TableUtil.Copy(payload, true))
end

local function buildAreaEggSnapshot(areaEggMap)
	local records = {}

	for _, record in pairs(areaEggMap) do
		table.insert(records, TableUtil.Copy(record, true))
	end

	return {
		Records = records,
		ServerTime = Workspace:GetServerTimeNow()
	}
end

local function applyAreaEggSnapshot(snapshotPayload, snapshotVersion)
	local newSnapshotData = {}

	for uid, record in pairs(areaEggSnapshotData) do
		if snapshotVersion < (areaEggSnapshotVersions[uid] or 0) then
			newSnapshotData[uid] = TableUtil.Copy(record, true)
		end
	end

	for _, record in ipairs(snapshotPayload.Records) do
		if (areaEggSnapshotVersions[record.Uid] or 0) <= snapshotVersion then
			newSnapshotData[record.Uid] = TableUtil.Copy(record, true)
		end
	end

	areaEggSnapshotData = newSnapshotData
	EggCmds.AreaEggSnapshotUpdated:Fire(EggCmds.GetAreaEggSnapshot())
end

local function applyAreaEggUpdate(record)
	areaEggSnapshotData[record.Uid] = TableUtil.Copy(record, true)
	EggCmds.AreaEggUpdated:Fire((EggCmds.GetAreaEggRecord(record.Uid)))
end

local function applyAreaEggRemoved(uid)
	areaEggSnapshotData[uid] = nil
	EggCmds.AreaEggRemoved:Fire(uid)
end

local function applyAreaEggBatchUpdate(payload)
	for _, uid in ipairs(payload.RemovedUids) do
		areaEggSnapshotData[uid] = nil
	end

	for _, record in ipairs(payload.UpdatedRecords) do
		areaEggSnapshotData[record.Uid] = TableUtil.Copy(record, true)
	end

	EggCmds.AreaEggSnapshotUpdated:Fire(EggCmds.GetAreaEggSnapshot())
end

local function handleOwnerUpdated(payload)
	local isValid, errorMessage = Eggs.SchemaValidation.RuntimeEggOwnerUpdate(payload)

	if isValid then
		runtimeUpdateCounter += 1
		runtimeSnapshotVersions[payload.OwnerUserId] = runtimeUpdateCounter
		applyOwnerUpdate(payload)
	else
		logger:AtError():Log(("Ignored invalid egg runtime owner update: %s"):format(tostring(errorMessage)))
	end
end

local function handleOwnerCleared(payload)
	local isValid, errorMessage = Eggs.SchemaValidation.RuntimeEggOwnerClear(payload)

	if isValid then
		runtimeUpdateCounter += 1
		runtimeSnapshotVersions[payload.OwnerUserId] = runtimeUpdateCounter
		runtimeSnapshotData[payload.OwnerUserId] = nil

		EggCmds.RuntimeOwnerCleared:Fire(payload.OwnerUserId)
		EggCmds.RuntimeSnapshotUpdated:Fire(EggCmds.GetRuntimeSnapshot())
	else
		logger:AtError():Log(("Ignored invalid egg runtime owner clear: %s"):format(tostring(errorMessage)))
	end
end

local function handleAreaEggUpdated(payload)
	local isValid, errorMessage = AreaEggs.SchemaValidation.AreaEggRecord(payload)

	if isValid then
		areaEggUpdateCounter += 1
		areaEggSnapshotVersions[payload.Uid] = areaEggUpdateCounter
		areaEggSnapshotData[payload.Uid] = TableUtil.Copy(payload, true)
		EggCmds.AreaEggUpdated:Fire((EggCmds.GetAreaEggRecord(payload.Uid)))
	else
		logger:AtError():Log(("Ignored invalid area egg update: %s"):format(tostring(errorMessage)))
	end
end

local function handleAreaEggRemoved(uid)
	if type(uid) == "string" then
		areaEggUpdateCounter += 1
		areaEggSnapshotVersions[uid] = areaEggUpdateCounter
		areaEggSnapshotData[uid] = nil
		EggCmds.AreaEggRemoved:Fire(uid)
	else
		logger:AtError():Log("Ignored invalid area egg removal")
	end
end

local function handleAreaEggBatchUpdated(payload)
	local isValid, errorMessage = AreaEggs.SchemaValidation.AreaEggBatchUpdate(payload)

	if not isValid then
		logger:AtError():Log(("Ignored invalid area egg batch update: %s"):format(tostring(errorMessage)))
		return
	end

	for _, uid in ipairs(payload.RemovedUids) do
		areaEggUpdateCounter += 1
		areaEggSnapshotVersions[uid] = areaEggUpdateCounter
	end

	for _, record in ipairs(payload.UpdatedRecords) do
		areaEggUpdateCounter += 1
		areaEggSnapshotVersions[record.Uid] = areaEggUpdateCounter
	end

	applyAreaEggBatchUpdate(payload)
end

local function handleAreaEggCarryState(payload)
	local isValid, errorMessage = AreaEggs.SchemaValidation.AreaEggCarryState(payload)

	if isValid then
		EggCmds.AreaEggCarryStateChanged:Fire(TableUtil.Copy(payload, true))
	else
		logger:AtError():Log(("Ignored invalid area egg carry state: %s"):format(tostring(errorMessage)))
	end
end

local function handleAreaEggClaimFeedback(payload)
	local isValid, errorMessage = AreaEggs.SchemaValidation.AreaEggClaimFeedback(payload)

	if isValid then
		logger:AtInfo():Log("Area egg claim latency trace", {
			Stage = "CLIENT_FEEDBACK_RECEIVED",
			UserId = Players.LocalPlayer.UserId,
			ServerTime = Workspace:GetServerTimeNow(),
			AssetCategory = payload.AssetCategory,
			DisplayName = payload.DisplayName
		})
		EggCmds.AreaEggClaimed:Fire(payload)
	else
		logger:AtError():Log(("Ignored invalid area egg claim feedback: %s"):format(tostring(errorMessage)))
	end
end

local function handleAreaEggResetStartCountdown(payload)
	local isValid, errorMessage = AreaEggResetCycle.SchemaValidation.SequencePayload(payload)

	if isValid then
		if payload.IsManual == true then
			AreaEggResetTimeUtil.SetManualNightWindow(
				payload.DayStartsAt - AreaEggResetTimeUtil.NightDurationSeconds,
				payload.DayStartsAt
			)
		end
		EggCmds.AreaEggResetStartCountdown:Fire(payload)
	else
		logger:AtError():Log(("Ignored invalid area egg reset sequence: %s"):format(tostring(errorMessage)))
	end
end

local function handleAreaEggResetTeleportFade()
	EggCmds.AreaEggResetTeleportFade:Fire()
end

function EggCmds.RequestLocalEggRecord(uid)
	Asserts.string(uid)

	local result = Network.Invoke(EggNetworkEvents.REQUEST_EGG_RECORD, uid)

	if result == nil then
		return nil
	end

	local isValid, errorMessage = Eggs.SchemaValidation.SavedEgg(result)

	if isValid then
		return TableUtil.Copy(result, true)
	end

	logger:AtError():Log(("Ignored invalid local egg record for %s: %s"):format(uid, tostring(errorMessage)))
	return nil
end

function EggCmds.RequestRuntimeSnapshot()
	local snapshot = Network.Invoke(EggNetworkEvents.REQUEST_RUNTIME_SNAPSHOT)
	local isValid, errorMessage = Eggs.SchemaValidation.RuntimeEggSnapshot(snapshot)

	assert(isValid, ("Invalid egg runtime snapshot: %s"):format(tostring(errorMessage)))
	applySnapshot(snapshot, runtimeUpdateCounter)

	return EggCmds.GetRuntimeSnapshot()
end

function EggCmds.RequestAreaEggSnapshot()
	local snapshot = Network.Invoke(EggNetworkEvents.REQUEST_AREA_EGG_SNAPSHOT)
	local isValid, errorMessage = AreaEggs.SchemaValidation.AreaEggSnapshot(snapshot)

	assert(isValid, ("Invalid area egg snapshot: %s"):format(tostring(errorMessage)))
	applyAreaEggSnapshot(snapshot, areaEggUpdateCounter)

	return EggCmds.GetAreaEggSnapshot()
end

function EggCmds.RequestAreaEggRareSpawnPresentations()
	local success, response = Network.Invoke(EggNetworkEvents.REQUEST_AREA_EGG_RARE_SPAWN_PRESENTATIONS)

	Asserts.boolean(success)

	if success then
		local isValid, errorMessage = AreaEggResetCycle.SchemaValidation.RareSpawnPresentations(response)
		assert(isValid, ("Invalid area egg rare spawn presentations: %s"):format(tostring(errorMessage)))

		return true, response
	end

	return false, nil
end

function EggCmds.RequestEquipTool(uid)
	Asserts.string(uid)

	local success, errorMsg = Network.Invoke(EggNetworkEvents.REQUEST_EQUIP_TOOL, uid)
	local isSuccess = success == true

	if type(errorMsg) == "string" then
		return isSuccess, errorMsg
	end

	return isSuccess, nil
end

function EggCmds.RequestCarryAreaEgg(uid, slotKey)
	Asserts.string(uid)
	Asserts.optional.string(slotKey)

	local success, errorMsg = Network.Invoke(EggNetworkEvents.REQUEST_AREA_EGG_CARRY, {
		Uid = uid,
		FirstAreaSlotKey = slotKey
	})

	local isSuccess = success == true

	if type(errorMsg) == "string" then
		return isSuccess, errorMsg
	end

	return isSuccess, nil
end

function EggCmds.RequestDropHeldAreaEgg(reason)
	if reason ~= nil then
		local isValid, errorMessage = AreaEggs.SchemaValidation.DropReason(reason)
		assert(isValid, errorMessage)
	end

	local success, errorMsg = Network.Invoke(EggNetworkEvents.REQUEST_AREA_EGG_DROP, {
		Reason = reason
	})

	local isSuccess = success == true

	if type(errorMsg) == "string" then
		return isSuccess, errorMsg
	end

	return isSuccess, nil
end

function EggCmds.RequestUnequipTool(uid)
	Asserts.optional.string(uid)

	local success, errorMsg = Network.Invoke(EggNetworkEvents.REQUEST_UNEQUIP_TOOL, uid)
	local isSuccess = success == true

	if type(errorMsg) == "string" then
		return isSuccess, errorMsg
	end

	return isSuccess, nil
end

function EggCmds.RequestPlaceEgg(uid, localCFrame)
	Asserts.string(uid)
	Asserts.CFrame(localCFrame)

	pendingPlacementAnimations[uid] = true

	local success, errorMsg = Network.Invoke(EggNetworkEvents.REQUEST_PLACE_EGG, {
		Uid = uid,
		LocalCFrame = localCFrame
	})

	if success ~= true then
		pendingPlacementAnimations[uid] = nil
	end

	local isSuccess = success == true

	if type(errorMsg) == "string" then
		return isSuccess, errorMsg
	end

	return isSuccess, nil
end

function EggCmds.ConsumeLocalPlaceAnimation(uid)
	Asserts.string(uid)

	if pendingPlacementAnimations[uid] == true then
		pendingPlacementAnimations[uid] = nil
		return true
	end

	return false
end

function EggCmds.RequestSkipGrowth(uid)
	Asserts.string(uid)

	local success, errorMsg, productId = Network.Invoke(EggNetworkEvents.REQUEST_SKIP_GROWTH, uid)

	if success == true then
		if type(productId) == "number" then
			selectedSkipGrowthUid = uid
			return true, nil, productId
		end

		logger:AtError():Log("Successful skip-growth request returned an invalid product ID")
		return false, "Invalid skip growth product", nil
	end

	return false, type(errorMsg) == "string" and errorMsg or nil, nil
end

function EggCmds.RequestHatchEgg(uid)
	Asserts.string(uid)

	local success, errorMsg = Network.Invoke(EggNetworkEvents.REQUEST_HATCH_EGG, uid)
	local isSuccess = success == true

	if type(errorMsg) == "string" then
		return isSuccess, errorMsg
	end

	return isSuccess, nil
end

function EggCmds.RequestCompleteHatchEgg(uid)
	Asserts.string(uid)

	local success, errorMsg, grantedAssetUid = Network.Invoke(EggNetworkEvents.REQUEST_COMPLETE_HATCH_EGG, uid)

	if success == true then
		if type(grantedAssetUid) == "string" then
			return true, nil, grantedAssetUid
		end

		logger:AtError():Log("Successful hatch completion returned an invalid granted asset UID")
		return false, "Invalid granted asset UID", nil
	end

	return false, type(errorMsg) == "string" and errorMsg or nil, nil
end

function EggCmds.GetSelectedSkipGrowthUid()
	return selectedSkipGrowthUid
end

function EggCmds.ClearSelectedSkipGrowthUid()
	selectedSkipGrowthUid = nil
end

function EggCmds.IsLocalEggReady(uid)
	Asserts.string(uid)

	local record = EggCmds.GetRuntimeRecord(Players.LocalPlayer.UserId, uid)

	if record == nil or record.Placement == nil then
		return false
	end

	local serverTime = Workspace:GetServerTimeNow()

	return EggItemUtil.IsGrowthReady(
		record, 
		serverTime, 
		record.GrowthSpeedMultiplier, 
		EggItemUtil.GetCurrentNightGrowthCreditSeconds(record, serverTime, record.GrowthSpeedMultiplier)
	)
end

function EggCmds.CanPurchaseSelectedSkipGrowth()
	local uid = selectedSkipGrowthUid

	if uid == nil then
		return false, "No egg selected"
	end

	local record = EggCmds.GetRuntimeRecord(Players.LocalPlayer.UserId, uid)

	if record == nil or record.Placement == nil then
		return false, "Egg not placed"
	end

	if EggCmds.IsLocalEggReady(uid) then
		return false, "Egg is already ready"
	end

	return true
end

function EggCmds.CanPurchaseGrowAll()
	local userRecords = runtimeSnapshotData[Players.LocalPlayer.UserId]

	if userRecords == nil then
		return false, "You have no growing eggs!"
	end

	for uid, record in pairs(userRecords) do
		if record.Placement ~= nil and not EggCmds.IsLocalEggReady(uid) then
			return true
		end
	end

	return false, "You have no growing eggs!"
end

function EggCmds.GetRuntimeSnapshot()
	return buildRuntimeSnapshotPayload(runtimeSnapshotData)
end

function EggCmds.GetOwnerRuntimeRecords(userId)
	Asserts.number(userId)

	local records = runtimeSnapshotData[userId]

	if records then
		return TableUtil.Copy(records, true)
	end

	return {}
end

function EggCmds.GetRuntimeRecord(userId, uid)
	Asserts.number(userId)
	Asserts.string(uid)

	local userRecords = runtimeSnapshotData[userId]
	local record = userRecords and userRecords[uid] or nil

	if record then
		return TableUtil.Copy(record, true)
	end

	return nil
end

function EggCmds.GetAreaEggSnapshot()
	return buildAreaEggSnapshot(areaEggSnapshotData)
end

function EggCmds.GetAreaEggRecord(uid)
	Asserts.string(uid)

	local record = areaEggSnapshotData[uid]

	if record then
		return TableUtil.Copy(record, true)
	end

	return nil
end

local function requestRuntimeSnapshotUntilReady()
	local success, result = pcall(EggCmds.RequestRuntimeSnapshot)

	if not success then
		logger:AtError():Log(("Failed to load egg runtime snapshot; retrying: %s"):format(tostring(result)))
		task.delay(5, requestRuntimeSnapshotUntilReady)
	end
end

local function requestAreaEggSnapshotUntilReady()
	local success, result = pcall(EggCmds.RequestAreaEggSnapshot)

	if not success then
		logger:AtError():Log(("Failed to load area egg snapshot; retrying: %s"):format(tostring(result)))
		task.delay(5, requestAreaEggSnapshotUntilReady)
	end
end

Network.Fired(EggNetworkEvents.RUNTIME_OWNER_UPDATED):Connect(handleOwnerUpdated)
Network.Fired(EggNetworkEvents.RUNTIME_OWNER_CLEARED):Connect(handleOwnerCleared)
Network.Fired(EggNetworkEvents.AREA_EGG_UPDATED):Connect(handleAreaEggUpdated)
Network.Fired(EggNetworkEvents.AREA_EGG_REMOVED):Connect(handleAreaEggRemoved)
Network.Fired(EggNetworkEvents.AREA_EGG_BATCH_UPDATED):Connect(handleAreaEggBatchUpdated)
Network.Fired(EggNetworkEvents.AREA_EGG_CARRY_STATE):Connect(handleAreaEggCarryState)
Network.Fired(EggNetworkEvents.AREA_EGG_CLAIM_FEEDBACK):Connect(handleAreaEggClaimFeedback)
Network.Fired(EggNetworkEvents.AREA_EGG_RESET_START_COUNTDOWN):Connect(handleAreaEggResetStartCountdown)
Network.Fired(EggNetworkEvents.AREA_EGG_RESET_TELEPORT_FADE):Connect(handleAreaEggResetTeleportFade)
Network.Fired(EggNetworkEvents.AREA_EGG_CARRY_VISUAL_UPDATED):Connect(handleAreaEggCarryVisualUpdated)

task.spawn(requestRuntimeSnapshotUntilReady)
task.spawn(requestAreaEggSnapshotUntilReady)

Players.PlayerRemoving:Connect(function(player)
	runtimeUpdateCounter += 1
	runtimeSnapshotVersions[player.UserId] = runtimeUpdateCounter
	runtimeSnapshotData[player.UserId] = nil

	EggCmds.RuntimeOwnerCleared:Fire(player.UserId)
	EggCmds.RuntimeSnapshotUpdated:Fire(EggCmds.GetRuntimeSnapshot())
end)

return EggCmds