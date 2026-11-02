-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggNearbyPulse = require(script.AreaEggNearbyPulse)
local AreaEggSlotIdentity = require(ReplicatedStorage.Shared.Util.AreaEggSlotIdentity)
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local CarryRunBackEffects = require(script.CarryRunBackEffects)
local EggRenderer = require(ReplicatedStorage.Shared.Eggs.EggRenderer)
local EggState = require(ReplicatedStorage.Client.EggState)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local HoverHighlight = require(script.HoverHighlight)
local Log = require(ReplicatedStorage.Packages.Log)
local NestResolver = require(script.NestResolver)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local Player = require(ReplicatedStorage.Shared.Player)
local RareEggHighlight = require(script.RareEggHighlight)
local RenderBudget = require(ReplicatedStorage.Client.Modules.RenderBudget)
local RewardScreenTransition = require(ReplicatedStorage.Client.UI.VFX.RewardScreenTransition)
local SafeZoneBarriers = require(ReplicatedStorage.Shared.Util.SafeZoneBarriers)
local SmartProximityPrompt = require(ReplicatedStorage.Client.SmartProximityPrompt)
local Trove = require(ReplicatedStorage.Packages.Trove)
local WorkspaceEggVisibility = require(script.WorkspaceEggVisibility)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local States = AreaEggs.States
local LocalPlayer = Players.LocalPlayer
local v1 = Log.new()
local v2 = AreaEggNearbyPulse.new(LocalPlayer)
local v3 = RenderBudget.new({
    Name = "AreaEggRenderBudget",
    MaxJobsPerStep = 1,
    MaxStepTime = 0.004166666666666667,
    StepInterval = 0.03333333333333333,
    TargetSpreadSeconds = 3,
    SpreadMinJobs = 10
})
local v4 = RenderBudget.new({
    Name = "InitialAreaEggRenderBudget",
    MaxJobsPerStep = 8,
    MaxStepTime = 0.008333333333333333,
    StepInterval = 0.03333333333333333,
    TargetSpreadSeconds = 0.35,
    SpreadMinJobs = 10
})
local __OBJECTS = Workspace.__OBJECTS
local Folder = __OBJECTS:IsA("Folder")
assert(Folder, "Workspace.__OBJECTS must be a Folder")
local Areas = __OBJECTS.Areas
local Folder_2 = Areas:IsA("Folder")
assert(Folder_2, "Workspace.__OBJECTS.Areas must be a Folder")
local SeparationLine = Areas.SeparationLine
local BasePart = SeparationLine:IsA("BasePart")
assert(BasePart, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")
local v5 = WorkspaceEggVisibility.Container()
local v6 = {}
local v7 = {}
local v8

local function isLocalPlayerInGameplay() -- line 66 | captures: GuardAreaGeometry, Player, LocalPlayer, SeparationLine
    local v9 = Player.Optional.HumanoidRootPart(LocalPlayer)
    if v9 == nil then
        return false
    end
    return (GuardAreaGeometry.IsPastLine(SeparationLine, v9.Position))
end

local function isLocalPlayerTrapLocked() -- line 71 | captures: Player, LocalPlayer
    local v10 = Player.Optional.Character(LocalPlayer)
    if v10 == nil then
        return false
    end
    return v10:GetAttribute("IsTrapped") == true
end

local function isEggReachable(v11) -- line 76 | captures: Player, SafeZoneBarriers, LocalPlayer
    local v12 = Player.Optional.HumanoidRootPart(LocalPlayer)
    if v12 == nil then
        return false
    end
    local Position = v11.Record.BoundsCFrame.Position
    if (Position - v12.Position).Magnitude > 12 then
        return true
    end
    return not SafeZoneBarriers.Separates(v12.Position, Position, SafeZoneBarriers.IsFencedUid(v11.Record.Uid))
end

local function updatePromptEnabled(v13) -- line 87 | captures: GuardAreaGeometry, Player, LocalPlayer, SeparationLine, isEggReachable
    local Prompt = v13.Prompt
    local v14 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local v15
    if v14 == nil then
        v15 = false
    else
        v15 = GuardAreaGeometry.IsPastLine(SeparationLine, v14.Position)
    end
    if v15 then
        local v16 = Player.Optional.Character(LocalPlayer)
        local v17 = if v16 == nil then false else v16:GetAttribute("IsTrapped") == true
        Prompt.Enabled = not v17 and isEggReachable(v13)
    else
        Prompt.Enabled = v15
    end
end

local function cleanupRendered(v18) -- line 101 | captures: TryCall, v3, v4, v6, v7
    v7[v18] = nil
    v3:Drop(v18)
    v4:Drop(v18)
    local v19 = v6[v18]
    if v19 == nil then
        return
    end
    v6[v18] = nil
    v19.Trove:Destroy()
    if v19.OwnsModel and v19.Model.Parent ~= nil then
        TryCall(v19.Model.Destroy, v19.Model)
    end
end

local function scaleNestForRecord(v20) -- line 115 | captures: NestResolver
    local v21 = NestResolver.Resolve(v20)
    v21:ScaleTo(v20.NestScale)
    return v21
end

local function renderClientEgg(v22) -- line 128 | captures: EggRenderer, v5
    local Model = EggRenderer.RenderVisual({
            OwnerUserId = 0,
            ScaleAlpha = 1,
            UID = v22.Uid,
            ModelName = v22.Uid .. "_ClientVisual",
            Record = {
                AssetCategory = v22.AssetCategory,
                AssetScale = v22.AssetScale,
                AssetEyeColor = v22.AssetEyeColor,
                AssetColorSeed = v22.AssetColorSeed,
                AssetColorIndex = v22.AssetColorIndex,
                Mutations = table.clone(v22.Mutations),
                BaseMutation = v22.BaseMutation,
                HasParasite = v22.HasParasite
            }
        }, v5, false).Model
    Model:PivotTo(v22.BottomCFrame)
    local PrimaryPart = Model.PrimaryPart
    local v23 = assert(PrimaryPart, "Rendered area egg needs a PrimaryPart")
    for v24, v25 in Model:GetDescendants() do
        if v25:IsA("BasePart") and v25 ~= v23 then
            v25.Anchored = false
            local WeldConstraint = Instance.new("WeldConstraint")
            WeldConstraint.Name = "AreaEggVisualWeld"
            WeldConstraint.Part0 = v23
            WeldConstraint.Part1 = v25
            WeldConstraint.Parent = v23
        end
    end
    return Model
end

local function bindPrompt(v26, v27, v28) -- line 160 | captures: Workspace, AreaEggSlotIdentity, EggState, GuardAreaGeometry, HoverHighlight, Player, RareEggHighlight, SmartProximityPrompt, Trove, WorkspaceEggVisibility, States, LocalPlayer, v1, v2, SeparationLine, v6, isEggReachable, cleanupRendered
    RareEggHighlight.BindRenderedModel(v26, v27)
    local ProximityPrompt = Instance.new("ProximityPrompt")
    ProximityPrompt.Name = "CarryAreaEgg"
    ProximityPrompt.ActionText = "Steal"
    ProximityPrompt.ObjectText = "Egg"
    ProximityPrompt.MaxActivationDistance = 8
    if Workspace:GetAttribute("FastEggPickupTime") then
        ProximityPrompt.HoldDuration = 0.25
    else
        ProximityPrompt.HoldDuration = 1.2
    end
    ProximityPrompt.RequiresLineOfSight = false
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
    local v29 = SmartProximityPrompt.AttachToModel(ProximityPrompt, v27, {
        MaxActivationDistance = 8,
        TrackDistance = 8,
        SurfaceOffset = 0.75
    })
    local v30 = Trove.new()
    v30:Add(v29)
    v30:Add(ProximityPrompt)
    local v31 = {
        Record = v26,
        Model = v27,
        OwnsModel = v28,
        Prompt = ProximityPrompt,
        Trove = v30
    }
    v6[v26.Uid] = v31
    if v26.State == States.Slot then
        v30:Add(v2:Bind(v26.Uid, v27, Workspace:GetServerTimeNow()))
    end
    HoverHighlight.Bind(v27, ProximityPrompt, v30)
    v30:Connect(ProximityPrompt.Triggered, function(v32) -- line 194 | captures: v26, AreaEggSlotIdentity, EggState, WorkspaceEggVisibility, LocalPlayer, v1, cleanupRendered
        if v32 ~= LocalPlayer then
            return
        end
        local v33
        if AreaEggSlotIdentity.LooksLikeFirstAreaUid(v26.Uid) then
            v33 = AreaEggSlotIdentity.SlotKey(v26.AreaId, v26.NestId)
        end
        local v34, v35 = EggState.CarryFieldEgg(v26.Uid, v33)
        if v34 then
            if v33 ~= nil then
                cleanupRendered(v26.Uid)
                WorkspaceEggVisibility.SetHidden(v26.Uid, false)
            end
        elseif v35 ~= nil then
            v1:AtDebug():Log((("Area egg carry denied for %*: %*"):format(v26.Uid, v35)))
        end
    end)
    local Prompt = v31.Prompt
    local v36 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local v37
    if v36 == nil then
        v37 = false
    else
        v37 = GuardAreaGeometry.IsPastLine(SeparationLine, v36.Position)
    end
    if v37 then
        local v38 = Player.Optional.Character(LocalPlayer)
        local v39 = if v38 == nil then false else v38:GetAttribute("IsTrapped") == true
        Prompt.Enabled = not v39 and isEggReachable(v31)
    else
        Prompt.Enabled = v37
    end
end

local function renderSlot(v40) -- line 226 | captures: AreaEggSlotIdentity, NestResolver, WorkspaceEggVisibility, cleanupRendered, renderClientEgg, bindPrompt
    cleanupRendered(v40.Uid)
    local v41 = NestResolver.Resolve(v40)
    v41:ScaleTo(v40.NestScale)
    v41:PivotTo(v41:GetPivot())
    if AreaEggSlotIdentity.LooksLikeFirstAreaUid(v40.Uid) then
        WorkspaceEggVisibility.SetHidden(v40.Uid, true)
        local v42 = renderClientEgg(v40)
        bindPrompt(v40, v42, true)
    else
        local v43 = WorkspaceEggVisibility.ResolveModel(v40.Uid)
        if v43 == nil then
            local v44 = renderClientEgg(v40)
            bindPrompt(v40, v44, true)
        else
            WorkspaceEggVisibility.SetHidden(v40.Uid, false)
            bindPrompt(v40, v43, false)
        end
    end
end

local function renderDropped(v45) -- line 248 | captures: AreaEggSlotIdentity, WorkspaceEggVisibility, v1, cleanupRendered, renderClientEgg, bindPrompt
    cleanupRendered(v45.Uid)
    if AreaEggSlotIdentity.LooksLikeFirstAreaUid(v45.Uid) then
        WorkspaceEggVisibility.SetHidden(v45.Uid, true)
        local v46 = renderClientEgg(v45)
        bindPrompt(v45, v46, true)
    else
        WorkspaceEggVisibility.SetHidden(v45.Uid, false)
        local v47 = WorkspaceEggVisibility.ResolveModel(v45.Uid)
        if v47 == nil then
            v1:AtDebug():Log((("Dropped area egg %* skipped because its Workspace model is not parented"):format(v45.Uid)))
        else
            bindPrompt(v45, v47, false)
        end
    end
end

local function applyRecordNow(v48) -- line 264 | captures: WorkspaceEggVisibility, States, cleanupRendered, renderSlot, renderDropped
    WorkspaceEggVisibility.SetHidden(v48.Uid, false)
    if v48.State == States.Dropped then
        renderDropped(v48)
    elseif v48.State == States.Slot then
        renderSlot(v48)
    else
        cleanupRendered(v48.Uid)
    end
end

local function shouldQueueRender(v49) -- line 276 | captures: v6, v7
    if v7[v49.Uid] == v49.Version then
        return false
    end
    local v50 = v6[v49.Uid]
    if v50 ~= nil and v50.Record.Version == v49.Version then
        return v50.Record.State ~= v49.State
    end
    return true
end

local function queueApplyRecord(v51, v52) -- line 285 | captures: EggState, WorkspaceEggVisibility, States, v6, v7, cleanupRendered, renderSlot, renderDropped
    local v53
    if v7[v51.Uid] == v51.Version then
        v53 = false
    else
        local v54 = v6[v51.Uid]
        if v54 == nil then
            v53 = true
        elseif v54.Record.Version == v51.Version then
            v53 = v54.Record.State ~= v51.State
        else
            v53 = true
        end
    end
    if not v53 then
        return
    end
    v7[v51.Uid] = v51.Version
    v52:Submit(v51.Uid, function() -- line 298 | captures: v51, EggState, WorkspaceEggVisibility, States, v7, cleanupRendered, renderSlot, renderDropped
        local v55 = EggState.ReadFieldEgg(v51.Uid)
        if not (v55 ~= nil and v55.Version == v51.Version) then
            return
        end
        v7[v51.Uid] = nil
        WorkspaceEggVisibility.SetHidden(v55.Uid, false)
        if v55.State == States.Dropped then
            renderDropped(v55)
        elseif v55.State == States.Slot then
            renderSlot(v55)
        else
            cleanupRendered(v55.Uid)
        end
    end)
end

local function applySnapshot(v56, v57) -- line 316 | captures: EggState, WorkspaceEggVisibility, States, v6, v7, cleanupRendered, renderSlot, renderDropped
    local v58 = {}
    local v59 = {}
    for v60, v61 in ipairs(v56.Records) do
        v58[v61.Uid] = true
        WorkspaceEggVisibility.SetHidden(v61.Uid, false)
        if v61.State == States.Slot or v61.State == States.Dropped then
            table.insert(v59, v61)
        else
            cleanupRendered(v61.Uid)
        end
    end
    for v62 in pairs(v6) do
        if not v58[v62] then
            cleanupRendered(v62)
        end
    end
    for v63, v64 in ipairs(v59) do
        local v65
        if v7[v64.Uid] == v64.Version then
            v65 = false
        else
            local v66 = v6[v64.Uid]
            if v66 == nil then
                v65 = true
            elseif v66.Record.Version == v64.Version then
                v65 = v66.Record.State ~= v64.State
            else
                v65 = true
            end
        end
        if v65 then
            v7[v64.Uid] = v64.Version
            local Uid = v64.Uid
            local v67 = v64
            v57:Submit(Uid, function() -- line 345 | captures: v67, EggState, WorkspaceEggVisibility, States, v7, cleanupRendered, renderSlot, renderDropped
                local v68 = EggState.ReadFieldEgg(v67.Uid)
                if not (v68 ~= nil and v68.Version == v67.Version) then
                    return
                end
                v7[v67.Uid] = nil
                WorkspaceEggVisibility.SetHidden(v68.Uid, false)
                if v68.State == States.Dropped then
                    renderDropped(v68)
                elseif v68.State == States.Slot then
                    renderSlot(v68)
                else
                    cleanupRendered(v68.Uid)
                end
            end)
        end
    end
end

EggState.FieldClaimed:Connect(function(v69) -- line 365 | captures: Message, RewardScreenTransition
    RewardScreenTransition()
    Message.Bottom({
        Time = 2.5,
        Message = ("You stole an <font color=\"#%*\">EGG</font>!"):format((v69.Color:ToHex())),
        Color = Color3.new(1, 1, 1)
    })
end)
EggState.FieldRefreshed:Connect(function(v70) -- line 369 | captures: v3, applySnapshot
    applySnapshot(v70, v3)
end)
EggState.FieldShifted:Connect(function(v71) -- line 372 | captures: EggState, WorkspaceEggVisibility, States, v3, v4, v6, v7, cleanupRendered, renderSlot, renderDropped
    WorkspaceEggVisibility.SetHidden(v71.Uid, false)
    if v71.State == States.Slot then
        v3:Drop(v71.Uid)
        v4:Drop(v71.Uid)
        v7[v71.Uid] = nil
        local v72
        if v7[v71.Uid] == v71.Version then
            v72 = false
        else
            local v73 = v6[v71.Uid]
            if v73 == nil then
                v72 = true
            elseif v73.Record.Version == v71.Version then
                v72 = v73.Record.State ~= v71.State
            else
                v72 = true
            end
        end
        if v72 then
            v7[v71.Uid] = v71.Version
            local Uid = v71.Uid
            v3:Submit(Uid, function() -- line 390 | captures: v71, EggState, WorkspaceEggVisibility, States, v7, cleanupRendered, renderSlot, renderDropped
                local v74 = EggState.ReadFieldEgg(v71.Uid)
                if not (v74 ~= nil and v74.Version == v71.Version) then
                    return
                end
                v7[v71.Uid] = nil
                WorkspaceEggVisibility.SetHidden(v74.Uid, false)
                if v74.State == States.Dropped then
                    renderDropped(v74)
                elseif v74.State == States.Slot then
                    renderSlot(v74)
                else
                    cleanupRendered(v74.Uid)
                end
            end)
        end
    elseif v71.State == States.Dropped then
        v3:Drop(v71.Uid)
        v4:Drop(v71.Uid)
        v7[v71.Uid] = nil
        renderDropped(v71)
    else
        cleanupRendered(v71.Uid)
    end
end)
EggState.CarryChanged:Connect(function(v75) -- line 419 | captures: v8, AreaEggSlotIdentity, WorkspaceEggVisibility, cleanupRendered
    v8 = v75
    if v75.IsCarrying and v75.Uid ~= nil then
        if AreaEggSlotIdentity.LooksLikeFirstAreaUid(v75.Uid) then
            cleanupRendered(v75.Uid)
        end
        WorkspaceEggVisibility.SetHidden(v75.Uid, false)
    end
end)
EggState.FieldGone:Connect(function(v76) -- line 431 | captures: v8, WorkspaceEggVisibility, cleanupRendered
    cleanupRendered(v76)
    local v77 = v8
    local v78 = if v77 == nil then false else v77.IsCarrying and v77.Uid == v76
    WorkspaceEggVisibility.SetHidden(v76, not v78)
end)
WorkspaceEggVisibility.ModelAdded:Connect(function(v79) -- line 443 | captures: AreaEggSlotIdentity, EggState, WorkspaceEggVisibility, States, v3, v6, v7, cleanupRendered, renderSlot, renderDropped
    local v80 = EggState.ReadFieldEgg(v79.Name)
    local v81, v82
    if v80 == nil then
        v82 = true
    elseif v80.State == States.Dropped then
        if AreaEggSlotIdentity.LooksLikeFirstAreaUid(v80.Uid) then
            v82 = true
        else
            if v7[v80.Uid] == v80.Version then
                v81 = false
            else
                local v83 = v6[v80.Uid]
                if v83 == nil then
                    v81 = true
                elseif v83.Record.Version == v80.Version then
                    v81 = v83.Record.State ~= v80.State
                else
                    v81 = true
                end
            end
            v82 = false
        end
    else
        v82 = true
    end
    if v82 then
        return
    end
    if not v81 then
        return
    end
    v7[v80.Uid] = v80.Version
    local Uid = v80.Uid
    v3:Submit(Uid, function() -- line 460 | captures: v80, EggState, WorkspaceEggVisibility, States, v7, cleanupRendered, renderSlot, renderDropped
        local v84 = EggState.ReadFieldEgg(v80.Uid)
        if not (v84 ~= nil and v84.Version == v80.Version) then
            return
        end
        v7[v80.Uid] = nil
        WorkspaceEggVisibility.SetHidden(v84.Uid, false)
        if v84.State == States.Dropped then
            renderDropped(v84)
        elseif v84.State == States.Slot then
            renderSlot(v84)
        else
            cleanupRendered(v84.Uid)
        end
    end)
end)
CarryRunBackEffects.Start()
WorkspaceEggVisibility.Start()
RareEggHighlight.Start()
RunService.Heartbeat:Connect(function() -- line 481 | captures: Workspace, GuardAreaGeometry, Player, LocalPlayer, v2, SeparationLine, v6, isEggReachable
    v2:Step(Workspace:GetServerTimeNow())
    for v85, v86 in pairs(v6) do
        local Prompt = v86.Prompt
        local v87 = Player.Optional.HumanoidRootPart(LocalPlayer)
        local v88
        if v87 == nil then
            v88 = false
        else
            v88 = GuardAreaGeometry.IsPastLine(SeparationLine, v87.Position)
        end
        if v88 then
            local v89 = Player.Optional.Character(LocalPlayer)
            local v90 = if v89 == nil then false else v89:GetAttribute("IsTrapped") == true
            v88 = not v90 and isEggReachable(v86)
        end
        Prompt.Enabled = v88
    end
end)
local FieldShifted = EggState.SyncFieldEggs()
local v91 = {}
local v92 = {}
local v93 = {}
for v94, v95 in ipairs(FieldShifted.Records) do
    v91[v95.Uid] = true
    WorkspaceEggVisibility.SetHidden(v95.Uid, false)
    if v95.State == States.Slot or v95.State == States.Dropped then
        if AreaEggSlotIdentity.LooksLikeFirstAreaUid(v95.Uid) then
            table.insert(v92, v95)
        else
            table.insert(v93, v95)
        end
    else
        cleanupRendered(v95.Uid)
    end
end
for v96 in pairs(v6) do
    if not v91[v96] then
        cleanupRendered(v96)
    end
end
for v97, v98 in ipairs(v92) do
    v7[v98.Uid] = nil
    WorkspaceEggVisibility.SetHidden(v98.Uid, false)
    if v98.State == States.Dropped then
        renderDropped(v98)
    elseif v98.State == States.Slot then
        renderSlot(v98)
    else
        cleanupRendered(v98.Uid)
    end
end
for v99, v100 in ipairs(v93) do
    local v101
    if v7[v100.Uid] == v100.Version then
        v101 = false
    else
        local v102 = v6[v100.Uid]
        if v102 == nil then
            v101 = true
        elseif v102.Record.Version == v100.Version then
            v101 = v102.Record.State ~= v100.State
        else
            v101 = true
        end
    end
    if v101 then
        v7[v100.Uid] = v100.Version
        local Uid = v100.Uid
        local v103 = v100
        v4:Submit(Uid, function() -- line 543 | captures: EggState, WorkspaceEggVisibility, States, v7, cleanupRendered, renderSlot, renderDropped, v103
            local v104 = EggState.ReadFieldEgg(v103.Uid)
            if not (v104 ~= nil and v104.Version == v103.Version) then
                return
            end
            v7[v103.Uid] = nil
            WorkspaceEggVisibility.SetHidden(v104.Uid, false)
            if v104.State == States.Dropped then
                renderDropped(v104)
            elseif v104.State == States.Slot then
                renderSlot(v104)
            else
                cleanupRendered(v104.Uid)
            end
        end)
    end
end
