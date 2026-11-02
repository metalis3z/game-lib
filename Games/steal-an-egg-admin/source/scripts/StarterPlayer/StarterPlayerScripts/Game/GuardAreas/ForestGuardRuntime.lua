-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggSlotIdentity = require(ReplicatedStorage.Shared.Util.AreaEggSlotIdentity)
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Globals.Constants)
local EggState = require(ReplicatedStorage.Client.EggState)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
require(ReplicatedStorage.Shared.Types.GuardAreas)
local Guards = require(ReplicatedStorage.Data.Guards)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local GuardComponent = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardComponent)
require(ReplicatedStorage.Shared.Modules.GuardAreas.Types.Interface)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = {}

v1.__index = v1
v1.__class = "ForestGuardRuntime"

local States = AreaEggs.States
local LocalPlayer = Players.LocalPlayer

local function suppressGuardVisuals(v2) -- line 29
    local v3 = {}
    local v4 = {}
    for v5, v6 in ipairs(v2:GetDescendants()) do
        if v6:IsA("BasePart") then
            v4[v6] = {
                CanCollide = v6.CanCollide,
                CanQuery = v6.CanQuery,
                CanTouch = v6.CanTouch,
                LocalTransparencyModifier = v6.LocalTransparencyModifier
            }
            v6.LocalTransparencyModifier = 1
            v6.CanCollide = false
            v6.CanQuery = false
            v6.CanTouch = false
        elseif v6:IsA("ParticleEmitter") then
            local Enabled = v6.Enabled
            local v7 = v6

            local function v8() -- line 41 | captures: Enabled, v7
                v7.Enabled = Enabled
            end

            table.insert(v3, v8)
            v6.Enabled = false
        elseif v6:IsA("Beam") or v6:IsA("Trail") or v6:IsA("BillboardGui") then
        end
    end
    return function() -- line 48 | captures: v3, v4
        for v9, v10 in pairs(v4) do
            v9.LocalTransparencyModifier = v10.LocalTransparencyModifier
            v9.CanCollide = v10.CanCollide
            v9.CanQuery = v10.CanQuery
            v9.CanTouch = v10.CanTouch
        end
        for v11, v12 in ipairs(v3) do
            v12()
        end
    end
end

local function stageGuardForConstruction(v13, v14) -- line 60 | captures: suppressGuardVisuals
    v13.Name = "ForestGuardStaging"
    v13.Parent = v14
    return (suppressGuardVisuals(v13))
end

function v1.new(v15) -- line 65 | captures: Workspace, t, GuardAreaGeometry, Guards, Player, Remotes, GuardComponent, Trove, v1, LocalPlayer, suppressGuardVisuals
    local v16
    t.strict(t.instanceIsA("Model"))(v15)
    local v17 = v15.Name == "Forest"
    assert(v17, "ForestGuardRuntime requires area Forest")
    local Guard = v15.Guard
    local Bounds = v15.Bounds
    local v18 = v15:IsDescendantOf(Workspace)
    assert(v18, "Forest area must be in Workspace before guard construction")
    local v19 = Guard.Parent == v15
    assert(v19, "Forest authored guard must belong to its area before guard construction")
    local v20 = Guard:Clone()
    local v21 = {}
    local v22 = setmetatable(v21, v1)
    v22._areaModel = v15
    v22._authoredGuard = Guard
    v22._clientEggFolder = nil
    v22._droppedModelByUid = {}
    v22._droppedTroveByUid = {}
    v22._guardModel = v20
    v22._hiddenRestore = nil
    v22._registeredDroppedUids = {}
    v22._registeredStolenUids = {}
    v22._trove = Trove.new()
    v22._wake = nil
    local v23 = {
        ServerOwnsPhysics = false,
        Attack = function(v24) -- Attack | line 92 | captures: Remotes, LocalPlayer
            if v24.Player == LocalPlayer and v24.EggUid ~= nil then
                Remotes.GuardPatrol.ForestStrike:FireServer({
                    EggUid = v24.EggUid,
                    GuardCFrame = v24.GuardRoot.CFrame
                })
            end
        end
    }

    function v23.Wake(v25) -- line 98 | captures: v22
        local _wake = v22._wake
        if _wake ~= nil then
            _wake(v25)
        end
    end

    local v26
    local v27, v28 = xpcall(function() -- line 106 | captures: v16, v26, v15, Guard, Bounds, v20, v23, Workspace, GuardAreaGeometry, Guards, Player, GuardComponent, LocalPlayer, suppressGuardVisuals
        v20.Name = "ForestGuardStaging"
        v20.Parent = v15
        v16 = suppressGuardVisuals(v20)
        v26 = GuardComponent.new("Forest", v20, Bounds, Workspace.__OBJECTS.Areas.Ground, Guards.Directory.Forest, function(v29) -- line 111 | captures: Workspace, GuardAreaGeometry, Player, LocalPlayer
            if v29 == LocalPlayer then
                local v30 = Player.Optional.HumanoidRootPart(LocalPlayer)
                if v30 == nil then
                    return false
                end
                return (GuardAreaGeometry.IsPastLine(Workspace.__OBJECTS.Areas.SeparationLine, v30.Position))
            end
            return false
        end, v23)
        local v31 = v15:IsDescendantOf(Workspace)
        assert(v31, "Forest area was removed during guard construction")
        local v32 = Guard.Parent == v15
        assert(v32, "Forest authored guard was removed during guard construction")
    end, function(v33) -- line 123
        local v34 = tostring(v33)
        return debug.traceback(v34, 2)
    end)
    if not v27 then
        if v26 ~= nil then
            v26:Destroy()
        end
        v20:Destroy()
        v22._trove:Destroy()
        error(v28, 0)
    end
    local v35 = v26
    v22._component = assert(v35, "Forest shared guard component did not initialize")
    local v36 = v16
    local v37 = assert(v36, "Forest guard staging did not initialize")
    v22._trove:Add(v20)
    v22._trove:Add(function() -- line 138 | captures: Guard
        if Guard.Parent ~= nil then
            Guard.Name = "Guard"
        end
    end)
    Guard.Name = "ForestGuardAuthored"
    v20.Name = "Guard"
    for v38, v39 in ipairs(Guard:GetDescendants()) do
        if v39:IsA("BasePart") then
            local LocalTransparencyModifier = v39.LocalTransparencyModifier
            local _trove = v22._trove
            local v40 = v39
            _trove:Add(function() -- line 148 | captures: LocalTransparencyModifier, v40
                if v40.Parent ~= nil then
                    v40.LocalTransparencyModifier = LocalTransparencyModifier
                end
            end)
            v39.LocalTransparencyModifier = 1
        elseif v39:IsA("ParticleEmitter") then
            local Enabled = v39.Enabled
            local _trove = v22._trove
            local v41 = v39
            _trove:Add(function() -- line 156 | captures: Enabled, v41
                if v41.Parent ~= nil then
                    v41.Enabled = Enabled
                end
            end)
            v39.Enabled = false
        elseif v39:IsA("Beam") or v39:IsA("Trail") or v39:IsA("BillboardGui") then
        end
    end
    v37()
    v22._trove:Add(Guard:GetAttributeChangedSignal("Hidden"):Connect(function() -- line 168 | captures: v22
        v22:_applyHidden()
    end))
    v22:_applyHidden()
    return v22
end

function v1._isOwnedForestRecord(v42, v43) -- line 174 | captures: AreaEggSlotIdentity, LocalPlayer
    if v43.AreaId == "Forest" then
        return AreaEggSlotIdentity.FirstAreaOwnerUserId(v43.Uid) == LocalPlayer.UserId
    end
    return false
end

local function _clearStolen(v44, v45) -- line 182
    if v44._registeredStolenUids[v45] == true then
        v44._registeredStolenUids[v45] = nil
        v44._component:ClearStolenEgg(v45)
    end
end

v1._clearStolen = _clearStolen

function v1._registerStolen(v46, v47, v48) -- line 189 | captures: AssetItems, LocalPlayer
    if v46._registeredStolenUids[v47] == true then
        return
    end
    for v49 in pairs(v46._registeredStolenUids) do
        v46:_clearStolen(v49)
    end
    v46._registeredStolenUids[v47] = true
    v46._component:RegisterStolenEgg(LocalPlayer, v47, AssetItems.RarityRankForCategory(v48))
end

local function _clearDropped(v50, v51) -- line 199
    local v52 = v50._droppedTroveByUid[v51]
    if v52 ~= nil then
        v50._droppedTroveByUid[v51] = nil
        v52:Destroy()
    end
    v50._droppedModelByUid[v51] = nil
    if v50._registeredDroppedUids[v51] == true then
        v50._registeredDroppedUids[v51] = nil
        v50._component:ClearDroppedEgg(v51)
    end
end

v1._clearDropped = _clearDropped

function v1._tryRegisterDropped(v53, v54) -- line 212 | captures: AreaEggSlotIdentity, AssetItems, EggState, GuardAreaGeometry, Trove, States
    if v53._registeredDroppedUids[v54.Uid] ~= true and GuardAreaGeometry.IsWithinFootprint(v53._areaModel.Bounds, v54.BoundsCFrame.Position) then
        local _clientEggFolder = v53._clientEggFolder
        if _clientEggFolder ~= nil then
            local v55 = _clientEggFolder:FindFirstChild(v54.Uid)
            if v55 ~= nil then
                local Model = v55:IsA("Model")
                local v56 = ("%*.%* must be a Model"):format(_clientEggFolder:GetFullName(), v54.Uid)
                assert(Model, v56)
                if v53._component:RegisterDroppedEgg({
                        EggUid = v54.Uid,
                        Model = v55,
                        DroppedPosition = v54.BottomCFrame.Position,
                        NestBottomCFrame = AreaEggSlotIdentity.NestFor(v53._areaModel, v54.NestId).EggSpotBottom.CFrame,
                        Priority = AssetItems.RarityRankForCategory(v54.AssetCategory)
                    }) then
                    v53._registeredDroppedUids[v54.Uid] = true
                    v53._droppedModelByUid[v54.Uid] = v55
                    local v57 = Trove.new()
                    v53._droppedTroveByUid[v54.Uid] = v57
                    v57:Connect(v55.AncestryChanged, function(v58, v59) -- line 244 | captures: v53, v54, v55, EggState, States
                        if not (v59 == nil and v53._droppedModelByUid[v54.Uid] == v55) then
                            return
                        end
                        v53:_clearDropped(v54.Uid)
                        local v60 = EggState.ReadFieldEgg(v54.Uid)
                        if v60 ~= nil and v60.State == States.Dropped then
                            v53:_tryRegisterDropped(v60)
                        end
                    end)
                end
            end
        end
    end
end

function v1._syncRecord(v61, v62) -- line 259 | captures: States, LocalPlayer
    if v61:_isOwnedForestRecord(v62) then
        if v62.State == States.Carried and v62.CarrierUserId == LocalPlayer.UserId then
            v61:_clearDropped(v62.Uid)
            v61:_registerStolen(v62.Uid, v62.AssetCategory)
        else
            v61:_clearStolen(v62.Uid)
            if v62.State == States.Dropped then
                v61:_tryRegisterDropped(v62)
            else
                v61:_clearDropped(v62.Uid)
            end
        end
    end
end

local function _syncSnapshot(v63, v64) -- line 284
    local v65 = {}
    for v66, v67 in ipairs(v64.Records) do
        if v63:_isOwnedForestRecord(v67) then
            v65[v67.Uid] = true
            v63:_syncRecord(v67)
        end
    end
    for v68 in pairs(v63._registeredStolenUids) do
        if v65[v68] ~= true then
            v63:_clearStolen(v68)
        end
    end
    for v69 in pairs(v63._registeredDroppedUids) do
        if v65[v69] ~= true then
            v63:_clearDropped(v69)
        end
    end
end

v1._syncSnapshot = _syncSnapshot

function v1._handleRetrievalEvent(v70, v71) -- line 303 | captures: Remotes
    if v71.Kind == "Attached" then
        local v72 = v70._droppedModelByUid[v71.EggUid]
        if v72 ~= nil then
            local v73 = v72:FindFirstChild("CarryAreaEgg", true)
            if v73 ~= nil then
                local ProximityPrompt = v73:IsA("ProximityPrompt")
                local v74 = ("%* must be a ProximityPrompt"):format((v73:GetFullName()))
                assert(ProximityPrompt, v74)
                v73:Destroy()
            end
        end
        Remotes.GuardPatrol.ForestHandoff:FireServer({
            Kind = "Attached",
            EggUid = v71.EggUid
        })
    else
        local v75 = {
            Kind = "Deposited",
            EggUid = v71.EggUid
        }
        v70._registeredDroppedUids[v71.EggUid] = nil
        v70._droppedModelByUid[v71.EggUid] = nil
        local v76 = v70._droppedTroveByUid[v71.EggUid]
        if v76 ~= nil then
            v70._droppedTroveByUid[v71.EggUid] = nil
            v76:Destroy()
        end
        Remotes.GuardPatrol.ForestHandoff:FireServer(v75)
    end
end

function v1._applyHidden(v77) -- line 328 | captures: suppressGuardVisuals
    local v78 = v77._authoredGuard:GetAttribute("Hidden") == true
    v77._guardModel:SetAttribute("Hidden", v78 or nil)
    local _hiddenRestore = v77._hiddenRestore
    if v78 then
        if _hiddenRestore == nil then
            v77._hiddenRestore = suppressGuardVisuals(v77._guardModel)
        end
    elseif _hiddenRestore ~= nil then
        v77._hiddenRestore = nil
        _hiddenRestore()
    end
end

local function GetGuardModel(v79) -- line 343
    return v79._guardModel
end

v1.GetGuardModel = GetGuardModel

function v1.SetWakeHandler(v80, v81) -- line 346 | captures: t
    t.strict(t.callback)(v81)
    v80._wake = v81
end

function v1.SetEnabled(v82, v83) -- line 351 | captures: t
    t.strict(t.boolean)(v83)
    v82._component:SetEnabled(v83)
end

function v1.Start(v84) -- line 356 | captures: RunService, Workspace, EggState
    v84._trove:Add(EggState.FieldRefreshed:Connect(function(v85) -- line 357 | captures: v84
        v84:_syncSnapshot(v85)
    end))
    v84._trove:Add(EggState.FieldShifted:Connect(function(v86) -- line 360 | captures: v84
        v84:_syncRecord(v86)
    end))
    v84._trove:Add(EggState.FieldGone:Connect(function(v87) -- line 363 | captures: v84
        v84:_clearStolen(v87)
        v84:_clearDropped(v87)
    end))
    v84._trove:Add(EggState.CarryChanged:Connect(function(v88) -- line 367 | captures: v84
        if v88.IsCarrying then
            if v88.Uid ~= nil and v88.AssetCategory ~= nil and v88.AreaId == "Forest" then
                v84:_registerStolen(v88.Uid, v88.AssetCategory)
            end
        else
            for v89 in pairs(v84._registeredStolenUids) do
                v84:_clearStolen(v89)
            end
        end
    end))
    task.spawn(function() -- line 378 | captures: v84, Workspace, EggState
        local AreaEggSlotsClient = Workspace:WaitForChild("AreaEggSlotsClient")
        local Folder = AreaEggSlotsClient:IsA("Folder")
        assert(Folder, "Workspace.AreaEggSlotsClient must be a Folder")
        if v84._guardModel.Parent == nil then
            return
        end
        v84._clientEggFolder = AreaEggSlotsClient
        v84._trove:Connect(AreaEggSlotsClient.ChildAdded, function(v90) -- line 386 | captures: AreaEggSlotsClient, v84, EggState
            if not (v84._clientEggFolder == AreaEggSlotsClient and v90.Parent == AreaEggSlotsClient) then
                return
            end
            local v91 = EggState.ReadFieldEgg(v90.Name)
            if v91 ~= nil then
                v84:_syncRecord(v91)
            end
        end)
        v84:_syncSnapshot(EggState.ReadFieldEggs())
    end)
    local v92 = 0
    v84._trove:Connect(RunService.Heartbeat, function(v93) -- line 398 | captures: v92, v84
        v92 += v93
        if v92 < 0.03 then
            return
        end
        v92 = 0
        local v94 = v84._component:Step(os.clock())
        if v94 ~= nil then
            v84:_handleRetrievalEvent(v94)
        end
    end)
    v84:_syncSnapshot(EggState.ReadFieldEggs())
end

local function Destroy(v95) -- line 411
    v95._clientEggFolder = nil
    for v96 in pairs(v95._registeredDroppedUids) do
        v95:_clearDropped(v96)
    end
    for v97, v98 in pairs(v95._droppedTroveByUid) do
        if v98 ~= nil then
            v98:Destroy()
        end
    end
    v95._component:Destroy()
    v95._trove:Destroy()
    table.clear(v95._registeredDroppedUids)
    table.clear(v95._registeredStolenUids)
    table.clear(v95._droppedModelByUid)
    table.clear(v95._droppedTroveByUid)
end

v1.Destroy = Destroy
return v1
