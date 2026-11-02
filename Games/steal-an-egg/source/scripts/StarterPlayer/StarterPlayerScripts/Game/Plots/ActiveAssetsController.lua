-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActiveAssetIncomePopup = require(script.Parent.Parent.Parent.GUI.ActiveAssetIncomePopup)
local ActiveAssetPerformanceTest = require(script.ActiveAssetPerformanceTest)
local ActiveAssetPerformanceTestConfig = require(script.ActiveAssetPerformanceTestConfig)
local AssetHoverDataDisplay = require(script.Parent.Parent.Parent.GUI.AssetHoverDataDisplay)
local AssetBillboardController = require(script.AssetBillboardController)
local AssetChatBubbleComponent = require(ReplicatedStorage.Library.Client.UI.AssetChatBubbleComponent)
local AssetCmds = require(ReplicatedStorage.Library.Client.AssetCmds)
local AssetComponent = require(script.AssetComponent)
local AssetMovementBatch = require(script.AssetMovementBatch)
local AssetPlacementHints = require(script.AssetPlacementHints)

require(ReplicatedStorage.Library.Types.AssetRuntime)

local ActiveAssets = require(ReplicatedStorage.Library.Types.ActiveAssets)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Products = require(ReplicatedStorage.Directory.Products)
local SettingsCmds = require(ReplicatedStorage.Library.Client.SettingsCmds)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local ModelCameraOcclusionController = require(ReplicatedStorage.Library.Client.ModelCameraOcclusionController)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local ActiveAssets2 = Network.NET_MAP.ActiveAssets
local v1 = AssetMovementBatch.new()
local v2 = AssetBillboardController.new()
local v3 = SettingsCmds.IsEnabled("HideOtherPets")
local ClientRenderedAssets = Instance.new("Folder")

ClientRenderedAssets.Name = "ClientRenderedAssets"
ClientRenderedAssets.Parent = workspace

local t = {}
local v4 = false
local t2 = {}
local t3 = {}

for k, v in pairs(Products.Directory) do
	if typeof(v.StealRarity) == "string" then
		t[v.ProductId] = true
	end
end

local t4 = {
	ItemAdded = Signal.new(),
	ItemRemoved = Signal.new(),
	CashCollected = Signal.new(),
	InitialLoadCompleted = Signal.new()
}

local function makeKey(p1, p2) --[[ makeKey | Line: 71 ]]
	return ("%*:%*"):format(p1, p2)
end

local function recordForComponent(p1, p2) --[[ recordForComponent | Line: 75 | Upvalues: t3 (copy) ]]
	if p2.IsFirstPlacement ~= true then
		return p2
	end

	if t3[p1] == true then
		local v1 = table.clone(p2)
		local v2 = table.clone(p2.ItemData)

		v2.Mutations = table.clone(p2.ItemData.Mutations)
		v1.ItemData = v2
		v1.IsFirstPlacement = nil

		return v1
	end

	t3[p1] = true

	return p2
end

local function syncHoverEntry(p1) --[[ syncHoverEntry | Line: 94 | Upvalues: v3 (ref), Players (copy), AssetHoverDataDisplay (copy) ]]
	local v1 = p1:GetOwnerUserId()
	local v2 = p1:GetUid()

	if v3 and v1 ~= Players.LocalPlayer.UserId then
		AssetHoverDataDisplay.RemoveEntry(v1, v2)

		return
	end

	local v32 = p1:GetRuntimeRecord()
	local t = {
		Record = v32,
		Model = p1:GetModel()
	}

	t.ActivateSteal = if v1 == Players.LocalPlayer.UserId then nil else function() --[[ Line: 108 | Upvalues: p1 (copy) ]]
	p1:ActivateDnaSteal()
end
	AssetHoverDataDisplay.SetEntry(t)
end

local function applyComponentHiddenState(p1) --[[ applyComponentHiddenState | Line: 114 | Upvalues: Players (copy), v3 (ref), ModelCameraOcclusionController (copy), v2 (copy) ]]
	if p1:GetOwnerUserId() == Players.LocalPlayer.UserId then
		return
	end

	local v1 = v3

	if p1:IsHidden() == v1 then
		return
	end

	local v22 = p1:GetModel()

	if v1 then
		ModelCameraOcclusionController.SetModelSuppressed(v22, true)
		p1:SetHidden(true)
		v2:SetSuppressed(v22, true)
	else
		p1:SetHidden(false)
		v2:SetSuppressed(v22, false)
		ModelCameraOcclusionController.SetModelSuppressed(v22, false)
	end
end

local function setHideOtherPets(p1) --[[ setHideOtherPets | Line: 137 | Upvalues: v3 (ref), v1 (copy), t2 (copy), applyComponentHiddenState (copy), syncHoverEntry (copy) ]]
	if v3 == p1 then
		return
	end

	v3 = p1

	if p1 then
		v1:SetForeignPresentationSuppressed(true)
	end

	for k, v in pairs(t2) do
		if v ~= nil then
			applyComponentHiddenState(v)
			syncHoverEntry(v)
		end
	end

	if p1 then
		return
	end

	v1:SetForeignPresentationSuppressed(false)
end

local function destroyComponent(p1) --[[ destroyComponent | Line: 157 | Upvalues: t2 (copy), v2 (copy), AssetHoverDataDisplay (copy), t4 (copy) ]]
	local v1 = t2[p1]

	if v1 ~= nil then
		local v22 = v1:GetModel()

		v2:Remove(v22)
		AssetHoverDataDisplay.RemoveEntry(v1:GetOwnerUserId(), v1:GetUid())
		v1:Destroy()
		t2[p1] = nil
		t4.ItemRemoved:Fire(v22)
	end
end

local function clearOwner(p1) --[[ clearOwner | Line: 170 | Upvalues: t2 (copy), destroyComponent (copy) ]]
	for k, v in pairs(t2) do
		if v ~= nil and v:GetOwnerUserId() == p1 then
			destroyComponent(k)
		end
	end
end

local function reconcileOwner(p1, p2) --[[ reconcileOwner | Line: 178 | Upvalues: Players (copy), clearOwner (copy), AssetCmds (copy), recordForComponent (copy), t2 (copy), AssetPlacementHints (copy), AssetComponent (copy), ClientRenderedAssets (copy), v2 (copy), v1 (copy), t4 (copy), applyComponentHiddenState (copy), syncHoverEntry (copy), destroyComponent (copy) ]]
	local v12 = Players:GetPlayerByUserId(p1)

	if v12 == nil then
		clearOwner(p1)

		return
	end

	local v22 = AssetCmds.ResolveAssetArea(v12)

	if v22 == nil then
		return
	end

	local t = {}

	for k, v in pairs(p2) do
		local v3 = ("%*:%*"):format(p1, k)

		t[v3] = true

		local v4 = recordForComponent(v3, v)
		local v5 = t2[v3]

		if v5 == nil then
			local v7 = AssetComponent.new(v4, v12, v22, ClientRenderedAssets, v2, v1, if v12 == Players.LocalPlayer then AssetPlacementHints.ConsumeFrontPlacement(k, v22) else nil)

			t2[v3] = v7
			v2:Add(v7:GetModel(), v4.ItemData, v4.MoneyPerSecond)
			t4.ItemAdded:Fire(v7:GetModel())
			v5 = v7
		else
			if v12 == Players.LocalPlayer then
				AssetPlacementHints.ClearFrontPlacement(k)
			end

			v5:SetRuntimeRecord(v4)
			v5:SetAssetArea(v22)
			v2:UpdateMoneyPerSecond(v5:GetModel(), v4.MoneyPerSecond)
		end

		applyComponentHiddenState(v5)
		syncHoverEntry(v5)
	end

	for k, v in pairs(t2) do
		if v ~= nil and (v:GetOwnerUserId() == p1 and t[k] ~= true) then
			destroyComponent(k)
		end
	end
end

local function reconcileSnapshot(p1) --[[ reconcileSnapshot | Line: 230 | Upvalues: reconcileOwner (copy), t2 (copy), destroyComponent (copy) ]]
	local t = {}

	for i, v in ipairs(p1) do
		t[v.OwnerUserId] = true
		reconcileOwner(v.OwnerUserId, v.Records)
	end

	for k, v in pairs(t2) do
		if v ~= nil and t[v:GetOwnerUserId()] ~= true then
			destroyComponent(k)
		end
	end
end

function t4.GetModelByUID(p1) --[[ GetModelByUID | Line: 247 | Upvalues: t2 (copy) ]]
	for k, v in pairs(t2) do
		if v ~= nil and v:GetUid() == p1 then
			return v:GetModel()
		end
	end

	return nil
end
function t4.GetAll() --[[ GetAll | Line: 256 | Upvalues: t2 (copy) ]]
	local t = {}

	for k, v in pairs(t2) do
		if v ~= nil then
			t[v:GetUid()] = v:GetModel()
		end
	end

	return t
end
function t4.GetActiveModels() --[[ GetActiveModels | Line: 266 | Upvalues: t4 (copy) ]]
	local t = {}

	for k, v in pairs(t4.GetAll()) do
		table.insert(t, v)
	end

	return t
end
AssetCmds.RuntimeSnapshotUpdated:Connect(reconcileSnapshot)
AssetCmds.RuntimeOwnerUpdated:Connect(reconcileOwner)
AssetCmds.RuntimeOwnerCleared:Connect(clearOwner)
t4.ItemAdded:Connect(function(p1) --[[ Line: 281 | Upvalues: ModelCameraOcclusionController (copy) ]]
	ModelCameraOcclusionController.TrackModel(p1, 1)
end)
t4.ItemRemoved:Connect(ModelCameraOcclusionController.UntrackModel)
SettingsCmds.Changed:Connect(function(p1) --[[ Line: 285 | Upvalues: setHideOtherPets (copy), SettingsCmds (copy) ]]
	if p1 ~= "HideOtherPets" then
		return
	end

	setHideOtherPets(SettingsCmds.IsEnabled("HideOtherPets"))
end)
Network.Fired(Network.NET_MAP.Treadmills.ACTIVE_TREADMILL_EVENT):Connect(function(p1) --[[ Line: 290 | Upvalues: v4 (ref), ModelCameraOcclusionController (copy), AssetChatBubbleComponent (copy) ]]
	v4 = p1 ~= nil
	ModelCameraOcclusionController.SetSessionActive(v4)
	AssetChatBubbleComponent.SetAlwaysOnTop(not v4)
end)
AssetCmds.AssetAreaAvailabilityChanged:Connect(function(p1) --[[ Line: 295 | Upvalues: reconcileOwner (copy), AssetCmds (copy) ]]
	reconcileOwner(p1.UserId, AssetCmds.GetOwnerRuntimeRecords(p1.UserId))
end)
Players.PlayerRemoving:Connect(function(p1) --[[ Line: 298 | Upvalues: clearOwner (copy) ]]
	clearOwner(p1.UserId)
end)
Network.Fired(ActiveAssets2.MONEY_COLLECTED_EVENT):Connect(function(p1) --[[ Line: 301 | Upvalues: t4 (copy), ActiveAssetIncomePopup (copy), v4 (ref) ]]
	for i, v in ipairs(p1) do
		local uid = v.uid

		if uid ~= nil then
			t4.CashCollected:Fire(uid)
			assert(v.amount > 0, (("Active asset income popup requires positive amount for uid \"%*\""):format(uid)))
		end
	end
end)
Network.Fired(ActiveAssets2.DNA_STEAL_ANIMATION):Connect(function(p1) --[[ Line: 317 | Upvalues: ActiveAssets (copy), t2 (copy) ]]
	assert(ActiveAssets.DnaStealAnimationPayload(p1), "Invalid DNA steal animation payload")

	local v2 = t2[("%*:%*"):format(p1.OwnerUserId, p1.UID)]

	assert(v2, (("DNA steal animation missing rendered asset %*:%*"):format(p1.OwnerUserId, p1.UID))):PlayDnaStealAnimation(p1)
end)
MarketplaceService.PromptProductPurchaseFinished:Connect(function(p1, p2, p3) --[[ Line: 325 | Upvalues: Players (copy), t (copy), Network (copy), ActiveAssets2 (copy) ]]
	if p1 ~= Players.LocalPlayer.UserId or (p3 or t[p2] ~= true) then
		return
	end

	Network.Fire(ActiveAssets2.STEAL_TARGET_EVENT, {
		Clear = true,
		ProductId = p2
	})
end)

if ActiveAssetPerformanceTestConfig.Enabled and Constants.IS_STUDIO then
	ActiveAssetPerformanceTest.Start(ClientRenderedAssets, v2, v1)
end

v1:SetForeignPresentationSuppressed(v3)
reconcileSnapshot(AssetCmds.GetRuntimeSnapshot())
t4.InitialLoadCompleted:Fire()

return t4