-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Types.AreaEggResetCycle)
require(ReplicatedStorage.Shared.Types.AreaEggs)
local t = require(ReplicatedStorage.Packages.t)
local Assets = require(ReplicatedStorage.Data.Assets)
local CaptureTheEgg = require(ReplicatedStorage.Data.CaptureTheEgg)
local EggState = require(ReplicatedStorage.Client.EggState)
local Log = require(ReplicatedStorage.Packages.Log)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local WorkspaceEggVisibility = require(script.Parent.WorkspaceEggVisibility)
local RarityNumber = Rarity.Rarities.Secret.RarityNumber
local v1 = Log.new()
local v2 = {}
local v3 = {}
local v4 = {}
local v5
local v6 = false
local v7 = (-1/0)
local v8 = false
local v9 = {}

local function getOutlineColor(v10, v11) -- line 27 | captures: Workspace, Assets, CaptureTheEgg, RarityNumber
    if Workspace:GetAttribute(CaptureTheEgg.EggUidAttribute) == v10 then
        return CaptureTheEgg.EggHighlightColor
    end
    local v12 = Assets.Directory[v11]
    local v13 = v12 ~= nil
    local v14 = ("Missing asset config %*"):format(v11)
    assert(v13, v14)
    local Rarity = v12.Rarity
    if Rarity.RarityNumber < RarityNumber then
        return nil
    end
    return Rarity.Color
end

local function clearBinding(v15) -- line 40 | captures: v3
    local v16 = v3[v15]
    if v16 == nil then
        return
    end
    v3[v15] = nil
    local DestroyConnection = v16.DestroyConnection
    if DestroyConnection ~= nil then
        DestroyConnection:Disconnect()
    end
    if v16.Highlight.Parent ~= nil then
        v16.Highlight:Destroy()
    end
end

local function clearAllBindings() -- line 54 | captures: v3
    for v17 in pairs(v3) do
        local v18 = v3[v17]
        if v18 ~= nil then
            v3[v17] = nil
            local DestroyConnection = v18.DestroyConnection
            if DestroyConnection ~= nil then
                DestroyConnection:Disconnect()
            end
            if v18.Highlight.Parent ~= nil then
                v18.Highlight:Destroy()
            end
        end
    end
end

local function bindModel(v19, v20, v21) -- line 70 | captures: v3
    local v22 = v3[v19]
    if v22 == nil then
        local v23 = v3[v19]
        if v23 ~= nil then
            v3[v19] = nil
            local DestroyConnection = v23.DestroyConnection
            if DestroyConnection ~= nil then
                DestroyConnection:Disconnect()
            end
            if v23.Highlight.Parent ~= nil then
                v23.Highlight:Destroy()
            end
        end
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "RareAreaEggHighlight"
        Highlight.Adornee = v20
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.FillTransparency = 1
        Highlight.OutlineTransparency = 0.25
        Highlight.OutlineColor = v21
        Highlight.Parent = v20
        local v24 = {
            Model = v20,
            Highlight = Highlight
        }
        v3[v19] = v24
        local Destroying = v20.Destroying
        v24.DestroyConnection = Destroying:Connect(function() -- line 95 | captures: v19, v24, v3
            if v3[v19] == v24 then
                v3[v19] = nil
            end
        end)
    elseif v22.Model == v20 then
        v22.Highlight.OutlineColor = v21
    end
end

local function syncUid(v25) -- line 107 | captures: v6, Workspace, Assets, CaptureTheEgg, WorkspaceEggVisibility, RarityNumber, v2, v3, v4, bindModel
    local v26 = v2[v25]
    if v26 == nil then
        v4[v25] = nil
        local v27 = v3[v25]
        if v27 ~= nil then
            v3[v25] = nil
            local DestroyConnection = v27.DestroyConnection
            if DestroyConnection ~= nil then
                DestroyConnection:Disconnect()
            end
            if v27.Highlight.Parent ~= nil then
                v27.Highlight:Destroy()
            end
        end
    elseif v6 then
        local v28 = v3[v25]
        if v28 ~= nil then
            v3[v25] = nil
            local DestroyConnection = v28.DestroyConnection
            if DestroyConnection ~= nil then
                DestroyConnection:Disconnect()
            end
            if v28.Highlight.Parent ~= nil then
                v28.Highlight:Destroy()
            end
        end
    else
        local v29
        if Workspace:GetAttribute(CaptureTheEgg.EggUidAttribute) == v25 then
            v29 = CaptureTheEgg.EggHighlightColor
        else
            local v30 = Assets.Directory[v26]
            local v31 = v30 ~= nil
            local v32 = ("Missing asset config %*"):format(v26)
            assert(v31, v32)
            local Rarity = v30.Rarity
            local RarityNumber_2 = Rarity.RarityNumber
            if RarityNumber <= RarityNumber_2 then
                v29 = Rarity.Color
            end
        end
        if v29 == nil then
            v4[v25] = nil
            local v33 = v3[v25]
            if v33 ~= nil then
                v3[v25] = nil
                local DestroyConnection = v33.DestroyConnection
                if DestroyConnection ~= nil then
                    DestroyConnection:Disconnect()
                end
                if v33.Highlight.Parent ~= nil then
                    v33.Highlight:Destroy()
                end
            end
        else
            local v34 = v4[v25]
            v4[v25] = nil
            if v34 == nil then
                local v35 = v3[v25]
                if v35 == nil then
                    local v36 = WorkspaceEggVisibility.ResolveModel(v25)
                    if v36 ~= nil then
                        bindModel(v25, v36, v29)
                    end
                elseif v35.Model.Parent == nil then
                    local v37 = WorkspaceEggVisibility.ResolveModel(v25)
                    if v37 ~= nil then
                        bindModel(v25, v37, v29)
                    end
                else
                    v35.Highlight.OutlineColor = v29
                end
            elseif v34.Parent ~= nil then
                bindModel(v25, v34, v29)
            end
        end
    end
end

local function beginResetReveal(v38) -- line 195 | captures: v6, v7, v3, v4
    if v38.DayStartsAt <= v7 then
        return
    end
    v7 = v38.DayStartsAt
    v6 = true
    table.clear(v4)
    for v39 in pairs(v3) do
        local v40 = v3[v39]
        if v40 ~= nil then
            v3[v39] = nil
            local DestroyConnection = v40.DestroyConnection
            if DestroyConnection ~= nil then
                DestroyConnection:Disconnect()
            end
            if v40.Highlight.Parent ~= nil then
                v40.Highlight:Destroy()
            end
        end
    end
end

local function completeResetReveal() -- line 217 | captures: v6, v2, syncUid
    v6 = false
    for v41 in pairs(v2) do
        syncUid(v41)
    end
end

local function applyRecord(v42) -- line 223 | captures: v2, syncUid
    v2[v42.Uid] = v42.AssetCategory
    syncUid(v42.Uid)
end

local function applySnapshot(v43) -- line 227 | captures: v5, v2, v3, v4, syncUid
    local v44 = {}
    for v45, v46 in ipairs(v43.Records) do
        v44[v46.Uid] = true
        v2[v46.Uid] = v46.AssetCategory
    end
    for v47 in pairs(v2) do
        if v44[v47] ~= true and v47 ~= v5 then
            v2[v47] = nil
            v4[v47] = nil
            local v48 = v3[v47]
            if v48 ~= nil then
                v3[v47] = nil
                local DestroyConnection = v48.DestroyConnection
                if DestroyConnection ~= nil then
                    DestroyConnection:Disconnect()
                end
                if v48.Highlight.Parent ~= nil then
                    v48.Highlight:Destroy()
                end
            end
        end
    end
    for v49 in pairs(v44) do
        syncUid(v49)
    end
end

local function applyCarryState(v50) -- line 255 | captures: v5, EggState, v2, v3, v4, syncUid
    local v51 = v5
    if v50.IsCarrying then
        local Uid = v50.Uid
        local v52 = assert(Uid, "Carried area egg state must include Uid")
        local AssetCategory = v50.AssetCategory
        local v53 = assert(AssetCategory, "Carried area egg state must include AssetCategory")
        v5 = v52
        v2[v52] = v53
        syncUid(v52)
    else
        v5 = nil
        if v51 ~= nil then
            local v54 = EggState.ReadFieldEgg(v51)
            if v54 == nil then
                v2[v51] = nil
                v4[v51] = nil
                local v55 = v3[v51]
                if v55 ~= nil then
                    v3[v51] = nil
                    local DestroyConnection = v55.DestroyConnection
                    if DestroyConnection ~= nil then
                        DestroyConnection:Disconnect()
                    end
                    if v55.Highlight.Parent ~= nil then
                        v55.Highlight:Destroy()
                    end
                end
            else
                v2[v54.Uid] = v54.AssetCategory
                syncUid(v54.Uid)
            end
        end
    end
end

local function observeWorkspaceChild(v56) -- line 291 | captures: v6, Workspace, Assets, CaptureTheEgg, RarityNumber, v2, bindModel
    if v56:IsA("Model") then
        task.defer(function() -- line 295 | captures: v56, v6, Workspace, Assets, CaptureTheEgg, RarityNumber, v2, bindModel
            if v6 then
                return
            end
            local Name = v56.Name
            local v57 = v2[Name]
            local v58, v59
            if v56.Parent == Workspace then
                if v57 == nil then
                    v59 = true
                else
                    if Workspace:GetAttribute(CaptureTheEgg.EggUidAttribute) == Name then
                        v58 = CaptureTheEgg.EggHighlightColor
                    else
                        local v60 = Assets.Directory[v57]
                        local v61 = v60 ~= nil
                        local v62 = ("Missing asset config %*"):format(v57)
                        assert(v61, v62)
                        local Rarity = v60.Rarity
                        local RarityNumber_2 = Rarity.RarityNumber
                        if RarityNumber <= RarityNumber_2 then
                            v58 = Rarity.Color
                        end
                    end
                    v59 = false
                end
            else
                v59 = true
            end
            if v59 then
                return
            end
            if v58 ~= nil then
                bindModel(Name, v56, v58)
            end
        end)
    end
end

function v9.BindRenderedModel(v63, v64) -- line 323 | captures: v6, Workspace, t, Assets, CaptureTheEgg, RarityNumber, v2, v3, v4, bindModel
    t.strict(t.table)(v63)
    t.strict(t.instanceIsA("Model"))(v64)
    v2[v63.Uid] = v63.AssetCategory
    if v6 then
        v4[v63.Uid] = v64
        local Uid = v63.Uid
        local v65 = v3[Uid]
        if v65 ~= nil then
            v3[Uid] = nil
            local DestroyConnection = v65.DestroyConnection
            if DestroyConnection ~= nil then
                DestroyConnection:Disconnect()
            end
            if v65.Highlight.Parent ~= nil then
                v65.Highlight:Destroy()
            end
        end
    else
        local AssetCategory = v63.AssetCategory
        local v66
        if Workspace:GetAttribute(CaptureTheEgg.EggUidAttribute) == v63.Uid then
            v66 = CaptureTheEgg.EggHighlightColor
        else
            local v67 = Assets.Directory[AssetCategory]
            local v68 = v67 ~= nil
            local v69 = ("Missing asset config %*"):format(AssetCategory)
            assert(v68, v69)
            local Rarity = v67.Rarity
            local RarityNumber_2 = Rarity.RarityNumber
            if RarityNumber <= RarityNumber_2 then
                v66 = Rarity.Color
            end
        end
        if v66 == nil then
            local Uid = v63.Uid
            local v70 = v3[Uid]
            if v70 ~= nil then
                v3[Uid] = nil
                local DestroyConnection = v70.DestroyConnection
                if DestroyConnection ~= nil then
                    DestroyConnection:Disconnect()
                end
                if v70.Highlight.Parent ~= nil then
                    v70.Highlight:Destroy()
                end
            end
        else
            bindModel(v63.Uid, v64, v66)
        end
    end
end

function v9.Start() -- line 379 | captures: v5, v8, Workspace, CaptureTheEgg, EggState, v1, v2, v3, v4, syncUid, beginResetReveal, completeResetReveal, applyRecord, applySnapshot, applyCarryState, observeWorkspaceChild
    local v71 = not v8
    assert(v71, "RareEggHighlight.Start may only be called once")
    v8 = true
    EggState.ResetCountdown:Connect(beginResetReveal)
    EggState.RarityPresented:Connect(completeResetReveal)
    EggState.FieldRefreshed:Connect(applySnapshot)
    EggState.FieldShifted:Connect(applyRecord)
    EggState.FieldGone:Connect(function(v72) -- line 387 | captures: v5, v2, v3, v4, syncUid
        if v72 == v5 then
            syncUid(v72)
        else
            v2[v72] = nil
            v4[v72] = nil
            local v73 = v3[v72]
            if v73 ~= nil then
                v3[v72] = nil
                local DestroyConnection = v73.DestroyConnection
                if DestroyConnection ~= nil then
                    DestroyConnection:Disconnect()
                end
                if v73.Highlight.Parent ~= nil then
                    v73.Highlight:Destroy()
                end
            end
        end
    end)
    EggState.CarryChanged:Connect(applyCarryState)
    Workspace.ChildAdded:Connect(observeWorkspaceChild)
    Workspace:GetAttributeChangedSignal(CaptureTheEgg.EggUidAttribute):Connect(function() -- line 411 | captures: v2, syncUid
        for v74 in pairs(v2) do
            syncUid(v74)
        end
    end)
    applySnapshot(EggState.ReadFieldEggs())
    v1:AtDebug():Log("Rare area egg highlight lifecycle started")
end

return table.freeze(v9)
