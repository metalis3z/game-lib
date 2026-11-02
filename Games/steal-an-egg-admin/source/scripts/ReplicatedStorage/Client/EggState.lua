-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local Log = require(ReplicatedStorage.Packages.Log)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local AreaEggResetCycle = require(ReplicatedStorage.Shared.Types.AreaEggResetCycle)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local t = require(ReplicatedStorage.Packages.t)
local SkipHatch = require(ReplicatedStorage.Data.MonetizationConfig).GamepassIds.SkipHatch
local EggWorld = Remotes.EggWorld
local v1 = {
    SnapshotRefreshed = Signal.new(),
    OwnerRefreshed = Signal.new(),
    OwnerCleared = Signal.new(),
    FieldRefreshed = Signal.new(),
    FieldShifted = Signal.new(),
    FieldGone = Signal.new(),
    CarryChanged = Signal.new(),
    FieldClaimed = Signal.new(),
    ResetCountdown = Signal.new(),
    RarityRevealed = Signal.new(),
    RarityPresented = Signal.new(),
    ResetFade = Signal.new()
}
local v2 = t.strict(t.string)
local v3 = t.strict(t.number)
local v4 = t.strict(t.boolean)
local v5 = t.strict(t.optional(t.string))
local v6 = t.strict(t.CFrame)
local v7 = Log.new()
local LocalPlayer = Players.LocalPlayer
local v8 = {}
local v9 = {}
local v10 = {}
local v11 = {}
local v12 = 0
local v13 = 0
local v14
local v15 = {}

local function twin(v16) -- line 50 | captures: TableUtil
    return TableUtil.Copy(v16, true)
end

local function stampOwner(v17) -- line 53 | captures: v12, v10
    v12 += 1
    v10[v17] = v12
end

local function stampField(v18) -- line 57 | captures: v13, v11
    v13 += 1
    v11[v18] = v13
end

local function ownedRows() -- line 61 | captures: v8, TableUtil
    local v19 = {}
    for v20, v21 in v8 do
        local v22 = {
            OwnerUserId = v20,
            Records = TableUtil.Copy(v21, true)
        }
        table.insert(v19, v22)
    end
    return v19
end

local function fieldRows() -- line 71 | captures: v9, Workspace, twin
    local function v23(v24, ...)
        table.insert(v24, ...)
    end

    local v25 = {}
    for v26, v27 in v9 do
        v23(v25, twin(v27))
    end
    return {
        Records = v25,
        ServerTime = Workspace:GetServerTimeNow()
    }
end

local function tellOwned() -- line 81 | captures: v1, ownedRows
    v1.SnapshotRefreshed:Fire((ownedRows()))
end

local function tellField() -- line 84 | captures: v1, fieldRows
    v1.FieldRefreshed:Fire((fieldRows()))
end

local function dropOwner(v28) -- line 87 | captures: v8, v1, ownedRows
    v8[v28] = nil
    v1.OwnerCleared:Fire(v28)
    v1.SnapshotRefreshed:Fire((ownedRows()))
end

local function adoptOwned(v29, v30) -- line 92 | captures: v8, TableUtil, v1, v10, ownedRows
    local v31 = {}
    for v32, v33 in pairs(v8) do
        if v30 < (v10[v32] or 0) then
            v31[v32] = TableUtil.Copy(v33, true)
        end
    end
    for v34, v35 in ipairs(v29) do
        local OwnerUserId = v35.OwnerUserId
        if (v10[OwnerUserId] or 0) <= v30 then
            v31[OwnerUserId] = TableUtil.Copy(v35.Records, true)
        end
    end
    v8 = v31
    v1.SnapshotRefreshed:Fire((ownedRows()))
end

local function adoptField(v36, v37) -- line 108 | captures: v9, TableUtil, v1, v11, fieldRows
    local v38 = {}
    for v39, v40 in pairs(v9) do
        if v37 < (v11[v39] or 0) then
            v38[v39] = TableUtil.Copy(v40, true)
        end
    end
    for v41, v42 in ipairs(v36.Records) do
        if (v11[v42.Uid] or 0) <= v37 then
            v38[v42.Uid] = TableUtil.Copy(v42, true)
        end
    end
    v9 = v38
    v1.FieldRefreshed:Fire((fieldRows()))
end

local v43

function v43(v44, v45) -- line 123 | captures: v43, v7
    local v46, v47 = pcall(v45)
    if not v46 then
        v7:AtError():Log((("%* never landed, going round again: %*"):format(v44, v47)))
        task.delay(5, v43, v44, v45)
    end
end

local function outcome(v48, v49) -- line 132
    local v50 = v48 == true
    if typeof(v49) == "string" then
        return v50, v49
    end
    return v50, nil
end

function v1.FetchEggRecord(v51) -- line 139 | captures: Eggs, EggWorld, v2, v7, twin
    v2(v51)
    local v52 = EggWorld.AskEggRecord:InvokeServer(v51)
    if v52 ~= nil then
        local v53, v54 = Eggs.SchemaValidation.SavedEgg(v52)
        if v53 then
            return twin(v52)
        end
        v7:AtError():Log((("the egg record for %* came back malformed: %*"):format(v51, v54)))
    end
    return nil
end

function v1.SyncOwnedEggs() -- line 153 | captures: v12, Eggs, EggWorld, ownedRows, adoptOwned
    local v55 = EggWorld.AskLiveSnapshot:InvokeServer()
    local v56, v57 = Eggs.SchemaValidation.RuntimeEggSnapshot(v55)
    local v58 = ("the owned egg snapshot failed validation: %*"):format(v57)
    assert(v56, v58)
    adoptOwned(v55, v12)
    return (ownedRows())
end

function v1.SyncFieldEggs() -- line 161 | captures: v13, AreaEggs, EggWorld, fieldRows, adoptField
    local v59 = EggWorld.AskFieldEggSnapshot:InvokeServer()
    local v60, v61 = AreaEggs.SchemaValidation.AreaEggSnapshot(v59)
    local v62 = ("the field egg snapshot failed validation: %*"):format(v61)
    assert(v60, v62)
    adoptField(v59, v13)
    return (fieldRows())
end

function v1.FetchRarityShows() -- line 169 | captures: AreaEggResetCycle, EggWorld, v4
    local v63, v64 = EggWorld.AskFieldEggRarityShows:InvokeServer()
    v4(v63)
    if v63 ~= true or v64 == nil then
        return v63 == true, nil
    end
    local v65, v66 = AreaEggResetCycle.SchemaValidation.RevealPayload(v64)
    local v67 = ("the rare spawn reveal payload failed validation: %*"):format(v66)
    assert(v65, v67)
    return true, v64
end

function v1.WearEggTool(v68) -- line 181 | captures: EggWorld, v2, outcome
    v2(v68)
    return outcome(EggWorld.AskWearTool:InvokeServer(v68))
end

function v1.DoffEggTool(v69) -- line 185 | captures: EggWorld, v5, outcome
    v5(v69)
    return outcome(EggWorld.AskDoffTool:InvokeServer(v69))
end

function v1.CarryFieldEgg(v70, v71) -- line 189 | captures: EggWorld, v2, v5, outcome
    v2(v70)
    v5(v71)
    return outcome(EggWorld.AskFieldEggCarry:InvokeServer({
        Uid = v70,
        FirstAreaSlotKey = v71
    }))
end

function v1.DropFieldEgg(v72) -- line 194 | captures: AreaEggs, EggWorld, outcome
    local v73, v74 = AreaEggs.SchemaValidation.DropReason(v72)
    if v72 == nil then
        v73 = true
    end
    assert(v73, v74)
    return outcome(EggWorld.AskFieldEggDrop:InvokeServer({ Reason = v72 }))
end

function v1.PlantEgg(v75, v76) -- line 201 | captures: EggWorld, v2, v6, v15
    v2(v75)
    v6(v76)
    v15[v75] = true
    local v77, v78 = EggWorld.AskPlaceEgg:InvokeServer({
        Uid = v75,
        LocalCFrame = v76
    })
    local v79 = v77 == true
    if typeof(v78) ~= "string" then
        v78 = nil
    end
    if not v79 then
        v15[v75] = nil
    end
    return v79, v78
end

function v1.TakePlantCue(v80) -- line 218 | captures: v2, v15
    v2(v80)
    local v81 = v15[v80] == true
    v15[v80] = nil
    return v81
end

function v1.BeginSkipGrowth(v82) -- line 224 | captures: v14, ReplicatedStorage, SkipHatch, EggWorld, v2
    v2(v82)
    local v83, v84, v85 = EggWorld.AskSkipGrowth:InvokeServer(v82)
    if not (v83 ~= true and v85 == SkipHatch) then
        if v83 == true then
            if typeof(v85) ~= "number" then
                v85 = nil
            end
            if v85 == nil then
                v14 = nil
                return true, nil, nil
            end
            v14 = v82
            return true, nil, v85
        end
        if typeof(v84) ~= "string" then
            v84 = nil
        end
        return false, v84, nil
    end
    v14 = nil
    require(ReplicatedStorage.Client.Functions.PromptPurchase).Prompt(SkipHatch, false)
    return true, nil, nil
end

function v1.BeginHatch(v86) -- line 258 | captures: EggWorld, v2
    v2(v86)
    local v87, v88, v89 = EggWorld.AskHatch:InvokeServer(v86)
    local v90 = v87 == true
    if typeof(v88) ~= "string" then
        v88 = nil
    end
    if typeof(v89) == "string" then
        return v90, v88, v89
    end
    return v90, v88, nil
end

function v1.FinishHatch(v91) -- line 273 | captures: EggWorld, v2, v7
    v2(v91)
    local v92, v93, v94 = EggWorld.AskFinishHatch:InvokeServer(v91)
    if v92 == true then
        if typeof(v94) ~= "string" then
            v94 = nil
        end
        if v94 == nil then
            v7:AtError():Log("the hatch finished but the granted asset uid was not a string")
            return false, "Invalid granted asset UID", nil
        end
        return true, nil, v94
    end
    if typeof(v93) ~= "string" then
        v93 = nil
    end
    return false, v93, nil
end

function v1.ReadChosenSkipUid() -- line 297 | captures: v14
    return v14
end

function v1.ForgetChosenSkip() -- line 300 | captures: v14
    v14 = nil
end

function v1.ReadOwnedEggs() -- line 303 | captures: ownedRows
    return (ownedRows())
end

function v1.ReadFieldEggs() -- line 306 | captures: fieldRows
    return (fieldRows())
end

function v1.ReadOwnerEggs(v95) -- line 309 | captures: v8, TableUtil, v3
    v3(v95)
    local v96 = v8[v95]
    if v96 == nil then
        return {}
    end
    return (TableUtil.Copy(v96, true))
end

function v1.ReadOwnedEgg(v97, v98) -- line 317 | captures: v8, TableUtil, v2, v3
    v3(v97)
    v2(v98)
    local v99 = v8[v97]
    local v100
    if v99 == nil then
    else
        v100 = v99[v98]
    end
    if v100 == nil then
        return nil
    end
    return (TableUtil.Copy(v100, true))
end

function v1.ReadFieldEgg(v101) -- line 332 | captures: v9, TableUtil, v2
    v2(v101)
    local v102 = v9[v101]
    if v102 == nil then
        return nil
    end
    return (TableUtil.Copy(v102, true))
end

function v1.IsReadyToHatch(v103) -- line 340 | captures: Workspace, EggRecords, v1, v2, LocalPlayer
    v2(v103)
    local v104 = v1.ReadOwnedEgg(LocalPlayer.UserId, v103)
    if v104 == nil or v104.Placement == nil then
        return false
    end
    local v105 = Workspace:GetServerTimeNow()
    local GrowthSpeedMultiplier = v104.GrowthSpeedMultiplier
    local v106 = EggRecords.CurrentNightCredit(v104, v105, GrowthSpeedMultiplier)
    return EggRecords.IsGrown(v104, v105, GrowthSpeedMultiplier, v106, LocalPlayer)
end

function v1.MayBuyChosenSkip() -- line 351 | captures: v14, v1, LocalPlayer
    local v107 = v14
    if v107 then
        local v108 = v1.ReadOwnedEgg(LocalPlayer.UserId, v107)
        if v108 ~= nil and v108.Placement ~= nil then
            if v1.IsReadyToHatch(v107) then
                return false, "Egg is already ready"
            end
            return true
        end
        return false, "Egg not placed"
    end
    return false, "No egg selected"
end

function v1.MayBuyGrowAll() -- line 366 | captures: v8, v1, LocalPlayer
    for v109, v110 in v8[LocalPlayer.UserId] or {} do
        if v110.Placement ~= nil and not v1.IsReadyToHatch(v109) then
            return true
        end
    end
    return false, "You have no growing eggs!"
end

local v111 = {}
local v112 = {
    complaint = "an owned egg write turned up malformed",
    feed = EggWorld.OwnerShifted,
    vet = Eggs.SchemaValidation.RuntimeEggOwnerUpdate
}

function v112.apply(v113) -- line 386 | captures: v8, v12, TableUtil, v1, v10, ownedRows
    v12 += 1
    v10[v113.OwnerUserId] = v12
    v8[v113.OwnerUserId] = TableUtil.Copy(v113.Records, true)
    v1.OwnerRefreshed:Fire(v113.OwnerUserId, v1.ReadOwnerEggs(v113.OwnerUserId))
    v1.SnapshotRefreshed:Fire((ownedRows()))
end

local v114 = {
    complaint = "an owned egg erase turned up malformed",
    feed = EggWorld.OwnerDropped,
    vet = Eggs.SchemaValidation.RuntimeEggOwnerClear
}

function v114.apply(v115) -- line 398 | captures: v8, v12, v1, v10, ownedRows
    v12 += 1
    v10[v115.OwnerUserId] = v12
    local OwnerUserId = v115.OwnerUserId
    v8[OwnerUserId] = nil
    v1.OwnerCleared:Fire(OwnerUserId)
    v1.SnapshotRefreshed:Fire((ownedRows()))
end

local v116 = {
    complaint = "a field egg write turned up malformed",
    feed = EggWorld.FieldEggShifted,
    vet = AreaEggs.SchemaValidation.AreaEggRecord
}

function v116.apply(v117) -- line 411 | captures: v9, v13, TableUtil, v1, v11
    v13 += 1
    v11[v117.Uid] = v13
    v9[v117.Uid] = TableUtil.Copy(v117, true)
    v1.FieldShifted:Fire((v1.ReadFieldEgg(v117.Uid)))
end

local v118 = {
    complaint = "a field egg removal turned up malformed",
    feed = EggWorld.FieldEggGone,
    vet = function(v119) -- vet | line 421
        return typeof(v119) == "string", "expected a uid string"
    end
}

function v118.apply(v120) -- line 425 | captures: v9, v13, v1, v11
    v13 += 1
    v11[v120] = v13
    v9[v120] = nil
    v1.FieldGone:Fire(v120)
end

local v121 = {
    complaint = "a field egg batch turned up malformed",
    feed = EggWorld.FieldEggBatchShifted,
    vet = AreaEggs.SchemaValidation.AreaEggBatchUpdate
}

function v121.apply(v122) -- line 436 | captures: v9, v13, TableUtil, v1, v11, fieldRows
    for v123, v124 in ipairs(v122.RemovedUids) do
        v13 += 1
        v11[v124] = v13
        v9[v124] = nil
    end
    for v125, v126 in ipairs(v122.UpdatedRecords) do
        v13 += 1
        v11[v126.Uid] = v13
        v9[v126.Uid] = TableUtil.Copy(v126, true)
    end
    v1.FieldRefreshed:Fire((fieldRows()))
end

local v127 = {
    complaint = "a field egg carry state turned up malformed",
    feed = EggWorld.FieldEggCarry,
    vet = AreaEggs.SchemaValidation.AreaEggCarryState
}

function v127.apply(v128) -- line 454 | captures: v1, twin
    v1.CarryChanged:Fire(twin(v128))
end

local v129 = {
    complaint = "a field egg claim verdict turned up malformed",
    feed = EggWorld.FieldEggRedeemVerdict,
    vet = AreaEggs.SchemaValidation.AreaEggClaimFeedback
}

function v129.apply(v130) -- line 462 | captures: Workspace, v1, v7, LocalPlayer
    v7:AtInfo():Log("Area egg claim latency trace", {
        Stage = "CLIENT_FEEDBACK_RECEIVED",
        UserId = LocalPlayer.UserId,
        ServerTime = Workspace:GetServerTimeNow(),
        AssetCategory = v130.AssetCategory,
        DisplayName = v130.DisplayName
    })
    v1.FieldClaimed:Fire(v130)
end

local v131 = {
    complaint = "a field egg reset sequence turned up malformed",
    feed = EggWorld.FieldEggCycleCountdown,
    vet = AreaEggResetCycle.SchemaValidation.SequencePayload
}

function v131.apply(v132) -- line 477 | captures: v1
    v1.ResetCountdown:Fire(v132)
end

local v133 = {
    complaint = "a field egg rarity reveal turned up malformed",
    feed = EggWorld.FieldEggRaritiesShown,
    vet = AreaEggResetCycle.SchemaValidation.RevealPayload
}

function v133.apply(v134) -- line 485 | captures: v1
    v1.RarityRevealed:Fire(v134)
end

v111[1] = v112
v111[2] = v114
v111[3] = v116
v111[4] = v118
v111[5] = v121
v111[6] = v127
v111[7] = v129
v111[8] = v131
v111[9] = v133
for v135, v136 in ipairs(v111) do
    local OnClientEvent = v136.feed.OnClientEvent
    local v137 = v136
    OnClientEvent:Connect(function(v138) -- line 499 | captures: v7, v137
        local v139, v140 = v137.vet(v138)
        if v139 then
            v137.apply(v138)
        else
            v7:AtError():Log((("%*: %*"):format(v137.complaint, v140)))
        end
    end)
end
Players.PlayerRemoving:Connect(function(v141) -- line 509 | captures: v8, v12, v1, v10, ownedRows
    v12 += 1
    v10[v141.UserId] = v12
    local UserId = v141.UserId
    v8[UserId] = nil
    v1.OwnerCleared:Fire(UserId)
    v1.SnapshotRefreshed:Fire((ownedRows()))
end)
task.spawn(v43, "the owned egg snapshot", v1.SyncOwnedEggs)
task.spawn(v43, "the field egg snapshot", v1.SyncFieldEggs)
return v1
