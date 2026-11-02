-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetRuntime = require(ReplicatedStorage.Shared.Types.AssetRuntime)
local Log = require(ReplicatedStorage.Packages.Log)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Signal = require(ReplicatedStorage.Packages.Signal)
local PenRoster = Remotes.PenRoster
local v1 = {
    SnapshotRefreshed = Signal.new(),
    OwnerRefreshed = Signal.new(),
    OwnerCleared = Signal.new(),
    PenAreaChanged = Signal.new()
}
local v2 = Log.new()
local v3 = {}
local v4 = {}
local v5 = 0

local function copyContents(v6) -- line 20
    local v7 = {}
    for v8, v9 in v6 do
        local v10 = table.clone(v9.ItemData)
        v10.Mutations = table.clone(v9.ItemData.Mutations)
        v7[v8] = {
            OwnerUserId = v9.OwnerUserId,
            UID = v9.UID,
            ItemData = v10,
            MoneyPerSecond = v9.MoneyPerSecond,
            Seed = v9.Seed,
            IsFirstPlacement = v9.IsFirstPlacement
        }
    end
    return v7
end

local function everyPen() -- line 40 | captures: v3, copyContents
    local v11 = {}
    for v12, v13 in v3 do
        local v14 = {
            OwnerUserId = v12,
            Records = copyContents(v13)
        }
        table.insert(v11, v14)
    end
    return v11
end

local function announce() -- line 50 | captures: v1, everyPen
    v1.SnapshotRefreshed:Fire((everyPen()))
end

local function adopt(v15, v16) -- line 53 | captures: v3, v1, v4, copyContents, everyPen
    local v17 = {}
    for v18, v19 in v3 do
        if v16 < v4[v18] then
        end
        v17[v18] = copyContents(v19)
    end
    for v20, v21 in ipairs(v15) do
        local v22
        if v4[v21.OwnerUserId] or v16 >= 0 then
            v22 = copyContents(v21.Records)
        else
            v22 = v17[v21.OwnerUserId]
        end
        v17[v21.OwnerUserId] = v22
    end
    v3 = v17
    v1.SnapshotRefreshed:Fire((everyPen()))
end

local v23

function v23() -- line 89 | captures: v23, v5, AssetRuntime, PenRoster, v2, adopt
    local v24, v25 = pcall(function() -- line 91 | captures: PenRoster
        return PenRoster.AskLiveSnapshot:InvokeServer()
    end)
    local v26, v27
    if v24 then
        v26, v27 = AssetRuntime.SchemaValidation.RuntimeAssetSnapshot(v25)
    else
        v27 = tostring(v25)
        v26 = false
    end
    if v26 then
        adopt(v25, v5)
    else
        v2:AtError():Log((("pen roster snapshot never landed, going round again: %*"):format(v27)))
        task.delay(5, v23)
    end
end

local function outcome(v28, v29) -- line 113
    local v30 = v28 == true
    if typeof(v29) == "string" then
        return v30, v29
    end
    return v30, nil
end

local function confirmed(v31) -- line 120
    return v31:InvokeServer() == true
end

function v1.WearAsset(v32) -- line 124 | captures: PenRoster
    local v33, v34, v35 = PenRoster.AskWear:InvokeServer(v32)
    local v36 = v33 == true
    if typeof(v34) ~= "string" then
        v34 = nil
    end
    if typeof(v35) == "string" then
        return v36, v34, v35
    end
    return v36, v34, nil
end

function v1.DoffAsset(v37) -- line 140 | captures: PenRoster, outcome
    return outcome(PenRoster.AskDoff:InvokeServer(v37))
end

function v1.ReadWearLimit() -- line 143 | captures: PenRoster
    local v38 = PenRoster.AskWearLimit:InvokeServer()
    if typeof(v38) == "number" then
        return v38
    end
    return 0
end

function v1.AckPetsBadge() -- line 150 | captures: PenRoster
    return PenRoster.ConfirmPetsBadge:InvokeServer() == true
end

function v1.AckEquipBestBadge() -- line 154 | captures: PenRoster
    return PenRoster.ConfirmEquipBestBadge:InvokeServer() == true
end

function v1.ReadSnapshot() -- line 158 | captures: everyPen
    return (everyPen())
end

function v1.ReadOwnerPen(v39) -- line 161 | captures: v3, copyContents
    local v40 = v3[v39]
    if v40 == nil then
        return {}
    end
    return (copyContents(v40))
end

function v1.FindPenArea(v41) -- line 168 | captures: PlotState
    local v42 = PlotState.ResolvePlot(v41)
    if v42 == nil then
        return nil
    end
    return v42.PetArea
end

local v43 = {}
local v44 = {
    complaint = "pen roster owner write turned away",
    feed = PenRoster.OwnerShifted,
    vet = AssetRuntime.SchemaValidation.RuntimeAssetOwnerUpdate
}

function v44.apply(v45) -- line 180 | captures: v3, v1, copyContents
    v3[v45.OwnerUserId] = copyContents(v45.Records)
    v1.OwnerRefreshed:Fire(v45.OwnerUserId, (copyContents(v45.Records)))
end

local v46 = {
    complaint = "pen roster owner erase turned away",
    feed = PenRoster.OwnerDropped,
    vet = AssetRuntime.SchemaValidation.RuntimeAssetOwnerClear
}

function v46.apply(v47) -- line 189 | captures: v3, v1
    v3[v47.OwnerUserId] = nil
    v1.OwnerCleared:Fire(v47.OwnerUserId)
end

v43[1] = v44
v43[2] = v46
for v48, v49 in ipairs(v43) do
    local OnClientEvent = v49.feed.OnClientEvent
    local v50 = v49
    OnClientEvent:Connect(function(v51) -- line 197 | captures: v5, v1, v2, v4, everyPen, v50
        local v52, v53 = v50.vet(v51)
        if v52 then
            v5 += 1
            v4[v51.OwnerUserId] = v5
            v50.apply(v51)
            v1.SnapshotRefreshed:Fire((everyPen()))
        else
            v2:AtError():Log((("%*: %*"):format(v50.complaint, v53)))
        end
    end)
end
PlotState.PlotChanged:Connect(function(v54, v55) -- line 210 | captures: Players, v1
    local v56
    if v55 == nil then
    else
        v56 = Players:GetPlayerByUserId(v55)
    end
    if v56 ~= nil then
        v1.PenAreaChanged:Fire(v56, v1.FindPenArea(v56))
    end
end)
task.spawn(v23)
return v1
