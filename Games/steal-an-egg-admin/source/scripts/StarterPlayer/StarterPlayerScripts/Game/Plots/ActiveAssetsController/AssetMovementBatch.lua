-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local PlacedEggRenderer = require(ReplicatedStorage.Shared.Eggs.PlacedEggRenderer)
local PlotState = require(ReplicatedStorage.Client.PlotState)
require(script.Parent.Types)
local v1 = Log.new()
local v2 = {}

v2.__index = v2
v2.__class = "AssetMovementBatch"

local Folder = workspace.__DEBRIS:IsA("Folder")
assert(Folder, "Workspace.__DEBRIS must be a Folder")
local __OBJECTS = workspace.__OBJECTS
local Folder_2 = __OBJECTS:IsA("Folder")
assert(Folder_2, "Workspace.__OBJECTS must be a Folder")
local Areas = __OBJECTS.Areas
local Folder_3 = Areas:IsA("Folder")
assert(Folder_3, "Workspace.__OBJECTS.Areas must be a Folder")
local Ground = Areas.Ground
local BasePart = Ground:IsA("BasePart")
assert(BasePart, "Workspace.__OBJECTS.Areas.Ground must be a BasePart")

function v2.new() -- line 30 | captures: Trove, v1, v2
    local v3 = {}
    local v4 = setmetatable(v3, v2)
    v4._trove = Trove.new()
    v4._entries = {}
    v4._orderedModels = {}
    v4._partsBuffer = {}
    v4._cframeBuffer = {}
    v4._foreignEntryCount = 0
    v4._foreignPresentationSuppressed = false
    v4._foreignPresentationForcedSuppressed = false
    v4:_init()
    v1:AtDebug():Log("Created asset movement batch")
    return v4
end

function v2._createGroundingRaycastParams(v5) -- line 44 | captures: PlacedEggRenderer, Ground
    local v6 = RaycastParams.new()
    v6.FilterType = Enum.RaycastFilterType.Include
    v6.FilterDescendantsInstances = {
        PlacedEggRenderer.GetRenderFolder(),
        Ground,
        v5
    }
    v6.IgnoreWater = true
    return v6
end

local function _groundCFrame(v7, v8, v9) -- line 51
    local Position = v8.Position
    local v10 = Position + Vector3.new(0, 64, 0)
    local v11 = workspace:Raycast(v10, Vector3.new(0, -2000, 0), v9)
    if v11 == nil then
        return nil
    end
    local X = Position.X
    local v12 = v11.Position.Y - v7
    local Z = Position.Z
    local v13 = Vector3.new(X, v12, Z)
    return CFrame.new(v13) * v8.Rotation
end

v2._groundCFrame = _groundCFrame

function v2._groundTargetCFrame(v14) -- line 62 | captures: v2
    local v15 = v2._groundCFrame(v14.BottomLocalY, v14.TargetCFrame, v14.GroundingRaycastParams)
    if v15 == nil then
        local TargetCFrame = v14.TargetCFrame
        local Position = TargetCFrame.Position
        return CFrame.new(Position.X, v14.SimulationCFrame.Position.Y, Position.Z) * TargetCFrame.Rotation
    end
    return v15
end

local function _movementAlpha(v16) -- line 72
    local v17 = v16 * 8
    return (math.clamp(v17, 0, 1))
end

v2._movementAlpha = _movementAlpha

local function _airborneMovementAlpha(v18) -- line 75
    local v19 = v18 * 14
    return (math.clamp(v19, 0, 0.45))
end

v2._airborneMovementAlpha = _airborneMovementAlpha

local function _isPresentationEnabled(v20, v21) -- line 78
    return v20.IsLocalOwner or not v21
end

v2._isPresentationEnabled = _isPresentationEnabled

local function _advanceSuppressedSimulation(v22) -- line 85
    local TargetCFrame = v22.TargetCFrame
    local Position = TargetCFrame.Position
    v22.SimulationCFrame = CFrame.new(Position.X, v22.SimulationCFrame.Position.Y, Position.Z) * TargetCFrame.Rotation
end

v2._advanceSuppressedSimulation = _advanceSuppressedSimulation

local function _forgetEntry(v23, v24) -- line 91
    local v25 = v23._entries[v24]
    if v25 ~= nil then
        if not v25.IsLocalOwner then
            local v26 = v23._foreignEntryCount > 0
            local v27 = "Foreign movement entry count cannot underflow"
            assert(v26, v27)
            v23._foreignEntryCount -= 1
        end
        v23._entries[v24] = nil
    end
end

v2._forgetEntry = _forgetEntry

local function _removeMissingModels(v28) -- line 102
    local v29 = #v28._orderedModels
    for v30 = v29, 1, -1 do
        local v31 = v28._orderedModels[v30]
        if v28._entries[v31] == nil then
            v28:_forgetEntry(v31)
            table.remove(v28._orderedModels, v30)
        elseif v31.Parent == nil then
        end
    end
end

v2._removeMissingModels = _removeMissingModels

function v2._flush(v32, v33, v34) -- line 116 | captures: v2
    table.clear(v32._partsBuffer)
    table.clear(v32._cframeBuffer)
    for v35, v36 in ipairs(v32._orderedModels) do
        local v37 = v32._entries[v36]
        if v37 ~= nil and v36.Parent ~= nil and v2._isPresentationEnabled(v37, v34) then
            local v38 = v2._groundTargetCFrame(v37)
            v37.SimulationCFrame = v38
            if not v37.GroundingEnabled then
                v38 = v37.TargetCFrame
            end
            local v39
            if v37.GroundingEnabled then
                v39 = v2._movementAlpha(v33)
            else
                v39 = v2._airborneMovementAlpha(v33)
            end
            if v37.CatchUpRemaining > 0 then
                local v40 = v33 / v37.CatchUpRemaining
                v39 = math.clamp(v40, 0, 1)
                local v41 = v37.CatchUpRemaining - v33
                v37.CatchUpRemaining = math.max(v41, 0)
            end
            local v42
            if v37.PresentationFrozen then
                v42 = v37.CurrentCFrame
            else
                v42 = v37.CurrentCFrame:Lerp(v38, v39)
            end
            local v43 = v36:GetPivot()
            v37.CurrentCFrame = v42
            for v44, v45 in ipairs(v37.VisibleParts) do
                if v45.Parent ~= nil then
                    local _partsBuffer = v32._partsBuffer
                    table.insert(_partsBuffer, v45)
                    local _cframeBuffer = v32._cframeBuffer
                    local v46 = v42 * v37.PresentationOffset * v43:ToObjectSpace(v45.CFrame)
                    table.insert(_cframeBuffer, v46)
                end
            end
        end
    end
    if #v32._partsBuffer > 0 then
        workspace:BulkMoveTo(v32._partsBuffer, v32._cframeBuffer, Enum.BulkMoveMode.FireCFrameChanged)
    end
end

function v2._step(v47, v48) -- line 160 | captures: v2
    v47:_removeMissingModels()
    local v49 = v47._foreignPresentationForcedSuppressed or v47._foreignEntryCount >= 30
    local v50 = v47._foreignPresentationSuppressed and not v49
    v47._foreignPresentationSuppressed = v49
    for v51, v52 in ipairs(v47._orderedModels) do
        local v53 = v47._entries[v52]
        if v53 ~= nil and v52.Parent ~= nil then
            v53.Step(v48, not v53.IsLocalOwner and v49)
            if not v53.IsLocalOwner then
                if v49 then
                    v2._advanceSuppressedSimulation(v53)
                elseif v50 then
                    local CatchUpRemaining = v53.CatchUpRemaining
                    v53.CatchUpRemaining = math.max(CatchUpRemaining, 0.25)
                end
            end
        end
    end
    v47:_flush(v48, v49)
end

function v2.Add(v54, v55, v56, v57, v58, v59, v60, v61) -- line 187 | captures: t, v2
    t.strict(t.instanceIsA("Model"))(v55)
    t.strict(t.array(t.instanceIsA("BasePart")))(v56)
    t.strict(t.CFrame)(v57)
    t.strict(t.number)(v58)
    t.strict(t.instanceIsA("BasePart"))(v59)
    t.strict(t.boolean)(v60)
    local v62 = v54._entries[v55] == nil
    local v63 = ("Asset model %* is already registered in the movement batch"):format(v55.Name)
    assert(v62, v63)
    local v64 = v2._createGroundingRaycastParams(v59)
    local v65 = v2._groundCFrame(v58, v57, v64) or v57
    v54._entries[v55] = {
        GroundingEnabled = true,
        PresentationFrozen = false,
        CatchUpRemaining = 0,
        Model = v55,
        VisibleParts = v56,
        AssetArea = v59,
        GroundingRaycastParams = v64,
        IsLocalOwner = v60,
        BottomLocalY = v58,
        TargetCFrame = v57,
        CurrentCFrame = v57,
        SimulationCFrame = v65,
        Step = v61,
        PresentationOffset = CFrame.identity
    }
    if not v60 then
        v54._foreignEntryCount += 1
    end
    local _orderedModels = v54._orderedModels
    table.insert(_orderedModels, v55)
end

function v2.GetSimulationCFrame(v66, v67) -- line 225 | captures: t
    t.strict(t.instanceIsA("Model"))(v67)
    local v68 = v66._entries[v67]
    local v69 = v68 ~= nil
    local v70 = ("Asset model %* is not registered in the movement batch"):format(v67.Name)
    assert(v69, v70)
    return v68.SimulationCFrame
end

function v2.ResolveGroundedCFrame(v71, v72) -- line 233 | captures: t, ModelBounds, PlacedEggRenderer, PlotState, v2, Ground
    t.strict(t.instanceIsA("Model"))(v71)
    t.strict(t.CFrame)(v72)
    local v73, v74 = ModelBounds(v71)
    local v75 = {
        PlacedEggRenderer.GetRenderFolder(),
        Ground
    }
    local v76 = PlotState.ResolvePlot()
    if v76 and v76.PetArea then
        local PetArea = v76.PetArea
        table.insert(v75, PetArea)
    end
    local v77 = RaycastParams.new()
    v77.FilterType = Enum.RaycastFilterType.Include
    v77.FilterDescendantsInstances = v75
    v77.IgnoreWater = true
    return v2._groundCFrame(v71:GetPivot():PointToObjectSpace(v73.Position).Y - v74.Y * 0.5, v72, v77) or v72
end

function v2.SetAssetArea(v78, v79, v80) -- line 251 | captures: t, v2
    t.strict(t.instanceIsA("Model"))(v79)
    t.strict(t.instanceIsA("BasePart"))(v80)
    local v81 = v78._entries[v79]
    local v82 = v81 ~= nil
    local v83 = ("Asset model %* is not registered in the movement batch"):format(v79.Name)
    assert(v82, v83)
    if v81.AssetArea ~= v80 then
        v81.AssetArea = v80
        v81.GroundingRaycastParams = v2._createGroundingRaycastParams(v80)
    end
end

function v2.SetTarget(v84, v85, v86) -- line 265 | captures: t
    t.strict(t.instanceIsA("Model"))(v85)
    t.strict(t.CFrame)(v86)
    local v87 = v84._entries[v85]
    local v88 = v87 ~= nil
    local v89 = ("Asset model %* is not registered in the movement batch"):format(v85.Name)
    assert(v88, v89)
    v87.TargetCFrame = v86
end

function v2.SetGroundingEnabled(v90, v91, v92) -- line 275 | captures: t
    t.strict(t.instanceIsA("Model"))(v91)
    t.strict(t.boolean)(v92)
    local v93 = v90._entries[v91]
    local v94 = v93 ~= nil
    local v95 = ("Asset model %* is not registered in the movement batch"):format(v91.Name)
    assert(v94, v95)
    v93.GroundingEnabled = v92
end

function v2.SetPresentationFrozen(v96, v97, v98, v99) -- line 285 | captures: t
    t.strict(t.instanceIsA("Model"))(v97)
    t.strict(t.boolean)(v98)
    t.strict(t.optional(t.number))(v99)
    local v100 = v96._entries[v97]
    local v101 = v100 ~= nil
    local v102 = ("Asset model %* is not registered in the movement batch"):format(v97.Name)
    assert(v101, v102)
    v100.PresentationFrozen = v98
    if v98 then
        v100.CatchUpRemaining = 0
    else
        local v103 = v99 or 0
        v100.CatchUpRemaining = math.max(v103, 0)
    end
end

function v2.SetPresentationOffset(v104, v105, v106) -- line 304 | captures: t
    t.strict(t.instanceIsA("Model"))(v105)
    t.strict(t.CFrame)(v106)
    local v107 = v104._entries[v105]
    local v108 = v107 ~= nil
    local v109 = ("Asset model %* is not registered in the movement batch"):format(v105.Name)
    assert(v108, v109)
    v107.PresentationOffset = v106
end

function v2.SetForeignPresentationSuppressed(v110, v111) -- line 314 | captures: t
    t.strict(t.boolean)(v111)
    v110._foreignPresentationForcedSuppressed = v111
end

function v2.Remove(v112, v113) -- line 319 | captures: t
    t.strict(t.instanceIsA("Model"))(v113)
    v112:_forgetEntry(v113)
    local v114 = #v112._orderedModels
    for v115 = v114, 1, -1 do
        if v112._orderedModels[v115] == v113 then
            table.remove(v112._orderedModels, v115)
            return
        end
    end
end

local function Destroy(v116) -- line 332
    v116._trove:Destroy()
    table.clear(v116._entries)
    table.clear(v116._orderedModels)
    table.clear(v116._partsBuffer)
    table.clear(v116._cframeBuffer)
    v116._foreignEntryCount = 0
    v116._foreignPresentationSuppressed = false
    v116._foreignPresentationForcedSuppressed = false
end

v2.Destroy = Destroy

function v2._init(v117) -- line 342 | captures: RunService
    v117._trove:Add(RunService.PreRender:Connect(function(v118) -- line 343 | captures: v117
        v117:_step(v118)
    end))
end

return v2
