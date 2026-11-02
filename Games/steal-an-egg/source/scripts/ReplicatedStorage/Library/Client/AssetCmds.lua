-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetRuntime = require(ReplicatedStorage.Library.Types.AssetRuntime)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local ActiveAssets = Network.NET_MAP.ActiveAssets
local v1 = Log.new()
local t = {
	RuntimeSnapshotUpdated = Signal.new(),
	RuntimeOwnerUpdated = Signal.new(),
	RuntimeOwnerCleared = Signal.new(),
	AssetAreaAvailabilityChanged = Signal.new()
}
local t2 = {}
local t3 = {}
local v2 = 0

local function cloneRecord(p1) --[[ cloneRecord | Line: 41 ]]
	local v1 = table.clone(p1.ItemData)

	v1.Mutations = table.clone(p1.ItemData.Mutations)

	return {
		OwnerUserId = p1.OwnerUserId,
		UID = p1.UID,
		ItemData = v1,
		MoneyPerSecond = p1.MoneyPerSecond,
		Seed = p1.Seed,
		IsFirstPlacement = p1.IsFirstPlacement
	}
end

local function materializeRuntimeRecords(p1) --[[ materializeRuntimeRecords | Line: 54 | Upvalues: cloneRecord (copy) ]]
	local t = {}

	for k, v in pairs(p1) do
		t[k] = cloneRecord(v)
	end

	return t
end

local function buildSnapshot() --[[ buildSnapshot | Line: 62 | Upvalues: t2 (ref), materializeRuntimeRecords (copy) ]]
	local t = {}

	for k, v in pairs(t2) do
		table.insert(t, {
			OwnerUserId = k,
			Records = materializeRuntimeRecords(v)
		})
	end

	return t
end

local function applySnapshot(p1, p2) --[[ applySnapshot | Line: 70 | Upvalues: t2 (ref), t3 (copy), materializeRuntimeRecords (copy), t (copy), buildSnapshot (copy) ]]
	local t4 = {}

	for k, v in pairs(t2) do
		if p2 < (t3[k] or 0) then
			t4[k] = materializeRuntimeRecords(v)
		end
	end

	for i, v in ipairs(p1) do
		if (t3[v.OwnerUserId] or 0) <= p2 then
			t4[v.OwnerUserId] = materializeRuntimeRecords(v.Records)
		end
	end

	t2 = t4
	t.RuntimeSnapshotUpdated:Fire((buildSnapshot()))
end

local function handleOwnerUpdated(p1) --[[ handleOwnerUpdated | Line: 87 | Upvalues: AssetRuntime (copy), v1 (copy), v2 (ref), t3 (copy), t2 (ref), materializeRuntimeRecords (copy), t (copy), buildSnapshot (copy) ]]
	local v12, v22 = AssetRuntime.SchemaValidation.RuntimeAssetOwnerUpdate(p1)

	if v12 then
		v2 = v2 + 1
		t3[p1.OwnerUserId] = v2
		t2[p1.OwnerUserId] = materializeRuntimeRecords(p1.Records)
		t.RuntimeOwnerUpdated:Fire(p1.OwnerUserId, (materializeRuntimeRecords(p1.Records)))
		t.RuntimeSnapshotUpdated:Fire((buildSnapshot()))
	else
		v1:AtError():Log((("Invalid asset runtime owner update: %*"):format(v22)))
	end
end

local function handleOwnerCleared(p1) --[[ handleOwnerCleared | Line: 101 | Upvalues: AssetRuntime (copy), v1 (copy), v2 (ref), t3 (copy), t2 (ref), t (copy), buildSnapshot (copy) ]]
	local v12, v22 = AssetRuntime.SchemaValidation.RuntimeAssetOwnerClear(p1)

	if v12 then
		v2 = v2 + 1
		t3[p1.OwnerUserId] = v2
		t2[p1.OwnerUserId] = nil
		t.RuntimeOwnerCleared:Fire(p1.OwnerUserId)
		t.RuntimeSnapshotUpdated:Fire((buildSnapshot()))
	else
		v1:AtError():Log((("Invalid asset runtime owner clear: %*"):format(v22)))
	end
end

local function handlePlotUpdated(p1, p2) --[[ handlePlotUpdated | Line: 115 | Upvalues: Players (copy), t (copy) ]]
	if p2 == nil then
		return
	end

	local v1 = Players:GetPlayerByUserId(p2)

	if v1 == nil then
		return
	end

	t.AssetAreaAvailabilityChanged:Fire(v1, t.ResolveAssetArea(v1))
end

local function requestRuntimeSnapshot() --[[ requestRuntimeSnapshot | Line: 125 | Upvalues: v2 (ref), Network (copy), ActiveAssets (copy), AssetRuntime (copy), applySnapshot (copy) ]]
	local v1 = v2
	local ok, result = pcall(function() --[[ Line: 127 | Upvalues: Network (ref), ActiveAssets (ref) ]]
		return Network.Invoke(ActiveAssets.REQUEST_RUNTIME_SNAPSHOT)
	end)

	if not ok then
		return false, tostring(result)
	end

	local v22, v3 = AssetRuntime.SchemaValidation.RuntimeAssetSnapshot(result)

	if v22 then
		applySnapshot(result, v1)

		return true, nil
	end

	return false, ("Invalid asset runtime snapshot: %*"):format(v3)
end

local function v3() --[[ requestRuntimeSnapshotUntilReady | Line: 143 | Upvalues: requestRuntimeSnapshot (copy), v1 (copy), v3 (copy) ]]
	local v12, v2 = requestRuntimeSnapshot()

	if not v12 then
		v1:AtError():Log((("Failed to load asset runtime snapshot; retrying: %*"):format(v2)))
		task.delay(5, v3)
	end
end

function t.RequestEquipAsset(p1) --[[ RequestEquipAsset | Line: 157 | Upvalues: Network (copy), ActiveAssets (copy) ]]
	local v1, v2, v3 = Network.Invoke(ActiveAssets.REQUEST_EQUIP, p1)
	local v4 = v1 == true
	local v5 = if typeof(v2) == "string" then v2 else nil

	if typeof(v3) == "string" then
		return v4, v5, v3
	end

	return v4, v5, nil
end
function t.RequestUnequipAsset(p1) --[[ RequestUnequipAsset | Line: 164 | Upvalues: Network (copy), ActiveAssets (copy) ]]
	local v1, v2 = Network.Invoke(ActiveAssets.REQUEST_UNEQUIP, p1)
	local v3 = v1 == true

	if typeof(v2) == "string" then
		return v3, v2
	end

	return v3, nil
end
function t.RequestEquipLimit() --[[ RequestEquipLimit | Line: 169 | Upvalues: Network (copy), ActiveAssets (copy) ]]
	local v1 = Network.Invoke(ActiveAssets.REQUEST_EQUIP_LIMIT)

	if typeof(v1) == "number" then
		return v1
	end

	return 0
end
function t.AcknowledgePenFullPetsBadge() --[[ AcknowledgePenFullPetsBadge | Line: 174 | Upvalues: Network (copy), ActiveAssets (copy) ]]
	return Network.Invoke(ActiveAssets.ACKNOWLEDGE_PEN_FULL_PETS_BADGE) == true
end
function t.AcknowledgePenFullEquipBestBadge() --[[ AcknowledgePenFullEquipBestBadge | Line: 178 | Upvalues: Network (copy), ActiveAssets (copy) ]]
	return Network.Invoke(ActiveAssets.ACKNOWLEDGE_PEN_FULL_EQUIP_BEST_BADGE) == true
end
function t.GetRuntimeSnapshot() --[[ GetRuntimeSnapshot | Line: 182 | Upvalues: buildSnapshot (copy) ]]
	return buildSnapshot()
end
function t.GetOwnerRuntimeRecords(p1) --[[ GetOwnerRuntimeRecords | Line: 186 | Upvalues: t2 (ref), materializeRuntimeRecords (copy) ]]
	local v1 = t2[p1]

	if v1 == nil then
		return {}
	end

	return materializeRuntimeRecords(v1)
end
function t.ResolveAssetArea(p1) --[[ ResolveAssetArea | Line: 191 | Upvalues: PlotCmds (copy) ]]
	local v1 = PlotCmds.GetPlotData(p1)

	if v1 == nil then
		return nil
	end

	return v1.PetArea
end
Network.Fired(ActiveAssets.RUNTIME_OWNER_UPDATED):Connect(handleOwnerUpdated)
Network.Fired(ActiveAssets.RUNTIME_OWNER_CLEARED):Connect(handleOwnerCleared)
PlotCmds.OnAnyPlotUpdated:Connect(handlePlotUpdated)
task.spawn(v3)

return t