-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActiveAssetIncomePopup = require(script.Parent.Parent.Parent.GUI.ActiveAssetIncomePopup)
local ActiveAssetPerformanceTest = require(script.ActiveAssetPerformanceTest)
local ActiveAssetPerformanceTestConfig = require(script.ActiveAssetPerformanceTestConfig)
local AssetBillboardController = require(script.AssetBillboardController)
local AssetChatBubble = require(ReplicatedStorage.Client.UI.AssetChatBubble)
local AssetComponent = require(script.AssetComponent)
local AssetHoverDataDisplay = require(script.Parent.Parent.Parent.GUI.AssetHoverDataDisplay)
local AssetMovementBatch = require(script.AssetMovementBatch)
local AssetPlacementHints = require(script.AssetPlacementHints)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
require(ReplicatedStorage.Shared.Types.AssetRuntime)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local ModelCameraOcclusion = require(ReplicatedStorage.Client.ModelCameraOcclusion)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local SettingsCmds = require(ReplicatedStorage.Shared.SettingsCmds)
local Signal = require(ReplicatedStorage.Packages.Signal)
local v1 = AssetMovementBatch.new()
local v2 = AssetBillboardController.new()
local v3 = {}
local v4 = {}
local v5 = false
local v6 = SettingsCmds.Allows("HideOtherPets")
local v7 = SettingsCmds.Allows("HideSelfPets")
local v8 = false
local Folder = Instance.new("Folder")

Folder.Name = "ClientRenderedAssets"
Folder.Parent = workspace

local v9 = {
    ItemAdded = Signal.new(),
    ItemRemoved = Signal.new(),
    CashCollected = Signal.new(),
    InitialLoadCompleted = Signal.new()
}

local function makeKey(v10, v11) -- line 36
    return (("%*:%*"):format(v10, v11))
end

local function recordForComponent(v12, v13) -- line 39 | captures: v4
    if v13.IsFirstPlacement == true then
        if v4[v12] == true then
            local v14 = table.clone(v13)
            local v15 = table.clone(v13.ItemData)
            v15.Mutations = table.clone(v13.ItemData.Mutations)
            v14.ItemData = v15
            v14.IsFirstPlacement = nil
            return v14
        end
        v4[v12] = true
    end
    return v13
end

local function isOwnerHidden(v16) -- line 54 | captures: v6, v7, Players
    if v16 == Players.LocalPlayer.UserId then
        return v7
    end
    return v6
end

local function syncHoverEntry(v17) -- line 60 | captures: v6, v7, Players, AssetHoverDataDisplay
    local v18 = v17:GetOwnerUserId()
    local v19 = v17:GetUid()
    local v20 = if v18 == Players.LocalPlayer.UserId then v7 else v6
    if v20 then
        AssetHoverDataDisplay.RemoveEntry(v18, v19)
    else
        local v21 = v17:GetRuntimeRecord()
        AssetHoverDataDisplay.SetEntry({
            Record = v21,
            Model = v17:GetModel()
        })
    end
end

local function applyComponentHiddenState(v22) -- line 76 | captures: v6, v7, v8, Players, ModelCameraOcclusion, v2
    local v23 = v8
    if not v23 then
        if v22:GetOwnerUserId() == Players.LocalPlayer.UserId then
            v23 = v7
        else
            v23 = v6
        end
    end
    if v22:IsHidden() ~= v23 then
        local v24 = v22:GetModel()
        if v23 then
            ModelCameraOcclusion.SetIgnored(v24, true)
            v22:SetHidden(true)
            v2:SetSuppressed(v24, true)
        else
            v22:SetHidden(false)
            v2:SetSuppressed(v24, false)
            ModelCameraOcclusion.SetIgnored(v24, false)
        end
    end
end

local function setHideOtherPets(v25) -- line 100 | captures: v6, v1, v3, syncHoverEntry, applyComponentHiddenState
    if v6 == v25 then
        return
    end
    v6 = v25
    if v25 then
        v1:SetForeignPresentationSuppressed(true)
    end
    for v26, v27 in pairs(v3) do
        if v27 ~= nil then
            applyComponentHiddenState(v27)
            syncHoverEntry(v27)
        end
    end
    if not v25 then
        v1:SetForeignPresentationSuppressed(false)
    end
end

local function setHideSelfPets(v28) -- line 118 | captures: v7, v3, syncHoverEntry, applyComponentHiddenState
    if v7 ~= v28 then
        v7 = v28
        for v29, v30 in pairs(v3) do
            if v30 ~= nil then
                applyComponentHiddenState(v30)
                syncHoverEntry(v30)
            end
        end
    end
end

function v9.SetAllPetsHidden(v31) -- line 130 | captures: v8, v3, syncHoverEntry, applyComponentHiddenState
    if v8 ~= v31 then
        v8 = v31
        for v32, v33 in pairs(v3) do
            if v33 ~= nil then
                applyComponentHiddenState(v33)
                syncHoverEntry(v33)
            end
        end
    end
end

local function destroyComponent(v34) -- line 142 | captures: AssetHoverDataDisplay, v2, v3, v9
    local v35 = v3[v34]
    if v35 == nil then
        return
    end
    local v36 = v35:GetModel()
    v2:Remove(v36)
    local v37 = v35:GetOwnerUserId()
    AssetHoverDataDisplay.RemoveEntry(v37, v35:GetUid())
    v35:Destroy()
    v3[v34] = nil
    v9.ItemRemoved:Fire(v36)
end

local function clearOwner(v38) -- line 155 | captures: v3, destroyComponent
    for v39, v40 in pairs(v3) do
        if v40 ~= nil and v40:GetOwnerUserId() == v38 then
            destroyComponent(v39)
        end
    end
end

local function reconcileOwner(v41, v42) -- line 162 | captures: Players, AssetComponent, AssetPlacementHints, AssetRoster, v1, v2, v3, Folder, v9, recordForComponent, syncHoverEntry, applyComponentHiddenState, destroyComponent, clearOwner
    local v43 = Players:GetPlayerByUserId(v41)
    if v43 == nil then
        clearOwner(v41)
    else
        local v44 = AssetRoster.FindPenArea(v43)
        if v44 ~= nil then
            local v45 = {}
            for v46, v47 in pairs(v42) do
                local v48 = ("%*:%*"):format(v41, v46)
                v45[v48] = true
                local v49 = recordForComponent(v48, v47)
                local v50 = v3[v48]
                if v50 == nil then
                    local v51
                    if v43 == Players.LocalPlayer then
                        v51 = AssetPlacementHints.ConsumeFrontPlacement(v46, v44)
                    end
                    v50 = AssetComponent.new(v49, v43, v44, Folder, v2, v1, v51)
                    v3[v48] = v50
                    local v52 = v50:GetModel()
                    v2:Add(v52, v49.ItemData, v49.MoneyPerSecond)
                    v9.ItemAdded:Fire(v50:GetModel())
                else
                    if v43 == Players.LocalPlayer then
                        AssetPlacementHints.ClearFrontPlacement(v46)
                    end
                    v50:SetRuntimeRecord(v49)
                    v50:SetAssetArea(v44)
                    local v53 = v50:GetModel()
                    v2:UpdateMoneyPerSecond(v53, v49.MoneyPerSecond)
                end
                applyComponentHiddenState(v50)
                syncHoverEntry(v50)
            end
            for v54, v55 in pairs(v3) do
                if v55 ~= nil and v55:GetOwnerUserId() == v41 and v45[v54] ~= true then
                    destroyComponent(v54)
                end
            end
        end
    end
end

local function reconcileSnapshot(v56) -- line 211 | captures: v3, destroyComponent, reconcileOwner
    local v57 = {}
    for v58, v59 in ipairs(v56) do
        v57[v59.OwnerUserId] = true
        reconcileOwner(v59.OwnerUserId, v59.Records)
    end
    for v60, v61 in pairs(v3) do
        if v61 ~= nil and v57[v61:GetOwnerUserId()] ~= true then
            destroyComponent(v60)
        end
    end
end

function v9.GetModelByUID(v62) -- line 223 | captures: v3
    for v63, v64 in pairs(v3) do
        if v64 ~= nil and v64:GetUid() == v62 then
            return v64:GetModel()
        end
    end
    return nil
end

function v9.GetAll() -- line 231 | captures: v3
    local v65 = {}
    for v66, v67 in pairs(v3) do
        if v67 ~= nil then
            v65[v67:GetUid()] = v67:GetModel()
        end
    end
    return v65
end

function v9.GetActiveModels() -- line 242 | captures: v9
    local v68 = {}
    for v69, v70 in pairs(v9.GetAll()) do
        table.insert(v68, v70)
    end
    return v68
end

AssetRoster.SnapshotRefreshed:Connect(reconcileSnapshot)
AssetRoster.OwnerRefreshed:Connect(reconcileOwner)
AssetRoster.OwnerCleared:Connect(clearOwner)
v9.ItemAdded:Connect(function(v71) -- line 252 | captures: ModelCameraOcclusion
    ModelCameraOcclusion.Register(v71, 1)
end)
v9.ItemRemoved:Connect(ModelCameraOcclusion.Forget)
SettingsCmds.Changed:Connect(function(v72) -- line 256 | captures: SettingsCmds, setHideOtherPets, setHideSelfPets
    if v72 == "HideOtherPets" then
        setHideOtherPets(SettingsCmds.Allows("HideOtherPets"))
    elseif v72 == "HideSelfPets" then
        setHideSelfPets(SettingsCmds.Allows("HideSelfPets"))
    end
end)
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(v73) -- line 265 | captures: v5, AssetChatBubble, ModelCameraOcclusion
    v5 = v73 ~= nil
    ModelCameraOcclusion.SetEnabled(v5)
    AssetChatBubble.PinAbove(not v5)
end)
AssetRoster.PenAreaChanged:Connect(function(v74) -- line 271 | captures: AssetRoster, reconcileOwner
    reconcileOwner(v74.UserId, AssetRoster.ReadOwnerPen(v74.UserId))
end)
Players.PlayerRemoving:Connect(function(v75) -- line 274 | captures: clearOwner
    clearOwner(v75.UserId)
end)
Remotes.PenRoster.CoinsGathered.OnClientEvent:Connect(function(v76) -- line 277 | captures: v5, v8, ActiveAssetIncomePopup, v9
    for v77, v78 in ipairs(v76) do
        local uid = v78.uid
        if uid ~= nil then
            v9.CashCollected:Fire(uid)
            if not v8 then
                local v79 = v78.amount > 0
                local v80 = ("Active asset income popup requires positive amount for uid \"%*\""):format(uid)
                assert(v79, v80)
                local v81 = v9.GetModelByUID(uid)
                local v82 = ("Active asset income popup missing rendered model for uid \"%*\""):format(uid)
                local v83 = assert(v81, v82)
                ActiveAssetIncomePopup.Show(v83, v78.amount, { alwaysOnTop = not v5 })
            end
        end
    end
end)

if ActiveAssetPerformanceTestConfig.Enabled and Constants.IS_STUDIO then
    ActiveAssetPerformanceTest.Start(Folder, v2, v1)
end
v1:SetForeignPresentationSuppressed(v6)
reconcileSnapshot(AssetRoster.ReadSnapshot())
v9.InitialLoadCompleted:Fire()
return v9
