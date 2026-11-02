-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.AssetBillboardController)
local AssetComponent = require(script.Parent.AssetComponent)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetGender = require(ReplicatedStorage.Shared.Util.AssetGender)
require(script.Parent.AssetMovementBatch)
local AssetRuntime = require(ReplicatedStorage.Shared.Types.AssetRuntime)
local Assets = require(ReplicatedStorage.Data.Assets)
local ActiveAssetPerformanceTestConfig = require(script.Parent.ActiveAssetPerformanceTestConfig)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Log = require(ReplicatedStorage.Packages.Log)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local v1 = Log.new()
local v2 = Random.new()
local v3 = {}
local v4 = {}
local v5, v6, v7
for v8 in pairs(Assets.Directory) do
    if v8 ~= "Frigo Camelo" then
        table.insert(v3, v8)
    end
end
table.sort(v3)
local v9 = #v3 > 0
assert(v9, "Active asset performance test requires at least one eligible category")
local v10 = {}

local function buildRuntimeRecord(v11, v12) -- line 35 | captures: Players, AssetEarnings, AssetGender, AssetRuntime, EggRecords, v2, v3
    local v13 = v3[v2:NextInteger(1, #v3)]
    local v14 = EggRecords.NewEgg(v13, v2)
    v14.AssetGender = AssetGender.Settle(v13, nil, v2)
    local v15 = EggRecords.ToAssetItemData(v14)
    v15.HasBeenFirstPlaced = true
    local v16 = ("PERFORMANCE_TEST_%*_%*"):format(v11, v12)
    local v17 = {
        OwnerUserId = Players.LocalPlayer.UserId,
        UID = v16,
        ItemData = v15,
        MoneyPerSecond = AssetEarnings.LiveRatePerSecond(v15),
        Seed = v2:NextInteger(1, 2147483647)
    }
    local v18 = AssetRuntime.SchemaValidation.RuntimeAssetRecord(v17)
    assert(v18, "Invalid performance-test asset record")
    return v17
end

local function destroySlot(v19) -- line 53 | captures: v5, v4
    local v20 = v4[v19]
    if v20 == nil then
        return
    end
    v4[v19] = nil
    for v21, v22 in ipairs(v20.Components) do
        v5:Remove(v22:GetModel())
        v22:Destroy()
    end
    v20.Container:Destroy()
end

local function activateSlot(v23, v24) -- line 65 | captures: v5, v6, v7, Players, AssetComponent, ActiveAssetPerformanceTestConfig, v1, v4, buildRuntimeRecord
    local Folder = Instance.new("Folder")
    Folder.Name = ("Plot%*"):format(v23)
    Folder.Parent = v7
    local v25 = {}
    local PetsPerPlot = ActiveAssetPerformanceTestConfig.PetsPerPlot
    for v26 = 1, PetsPerPlot do
        local v27 = buildRuntimeRecord(v23, v26)
        local v28 = AssetComponent.new(v27, Players.LocalPlayer, v24, Folder, v5, v6, nil)
        local v29 = v28:GetModel()
        v5:Add(v29, v27.ItemData, v27.MoneyPerSecond)
        table.insert(v25, v28)
    end
    v4[v23] = {
        Area = v24,
        Components = v25,
        Container = Folder
    }
    v1:AtInfo():Log((("Created %* performance-test pets for plot %*"):format(ActiveAssetPerformanceTestConfig.PetsPerPlot, v23)))
end

local function syncSlot(v30) -- line 83 | captures: PlotState, v4, destroySlot, activateSlot
    local v31 = PlotState.ResolveFolder()
    local v32, v33
    if v31 == nil then
        v33 = false
    else
        local v34 = v31:FindFirstChild((tostring(v30)))
        v33 = v34 ~= nil
        local v35
        if v34 == nil then
        else
            v35 = v34:FindFirstChild("ToUpdate")
        end
        if v35 == nil then
        elseif v35:IsA("Model") then
            v32 = v35:FindFirstChild("PetArea")
        end
        if v32 ~= nil and not v32:IsA("BasePart") then
            v32 = nil
        end
    end
    local v36 = v4[v30]
    if v33 then
        if v32 ~= nil then
            if v36 == nil then
                activateSlot(v30, v32)
            elseif v36.Area ~= v32 then
                v36.Area = v32
                for v37, v38 in ipairs(v36.Components) do
                    v38:SetAssetArea(v32)
                end
            end
        end
    else
        destroySlot(v30)
    end
end

local function syncAllSlots() -- line 126 | captures: PlotState, v4, destroySlot, syncSlot
    local v39 = PlotState.ResolveFolder()
    local v40 = {}
    if v39 ~= nil then
        for v41, v42 in ipairs(v39:GetChildren()) do
            local Name = v42.Name
            local v43 = tonumber(Name)
            if v43 ~= nil then
                v40[v43] = true
                syncSlot(v43)
            end
        end
    end
    for v44 in pairs(v4) do
        if v40[v44] ~= true then
            destroySlot(v44)
        end
    end
end

function v10.Start(v45, v46, v47) -- line 145 | captures: v5, v6, v7, ActiveAssetPerformanceTestConfig, PlotState, syncSlot, syncAllSlots
    local v48 = if ActiveAssetPerformanceTestConfig.PetsPerPlot > 0 then ActiveAssetPerformanceTestConfig.PetsPerPlot % 1 == 0 else false
    assert(v48, "PetsPerPlot must be a positive integer")
    v5 = v46
    v6 = v47
    v7 = Instance.new("Folder")
    v7.Name = "PerformanceTestAssets"
    v7.Parent = v45
    PlotState.PlotChanged:Connect(syncSlot)
    PlotState.FolderChanged:Connect(syncAllSlots)
    syncAllSlots()
end

return v10
