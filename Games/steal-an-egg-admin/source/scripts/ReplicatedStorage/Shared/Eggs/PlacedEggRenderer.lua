-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
require(ReplicatedStorage.Shared.Types.AreaEggResetCycle)
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggGrowthAnimation = require(script.Parent.EggGrowthAnimation)
local EggHatchAnimation = require(script.Parent.EggHatchAnimation)
local EggMechaUpgradeAnimation = require(script.Parent.EggMechaUpgradeAnimation)
local EggPlaceAnimation = require(script.Parent.EggPlaceAnimation)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggRenderer = require(script.Parent.EggRenderer)
local EggSkipAnimation = require(script.Parent.EggSkipAnimation)
local EggState = require(ReplicatedStorage.Client.EggState)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Log = require(ReplicatedStorage.Packages.Log)
local ModelCameraOcclusion = require(ReplicatedStorage.Client.ModelCameraOcclusion)
local NightEggTimeSkipAnimation = require(script.Parent.NightEggTimeSkipAnimation)
local ParasiteVisual = require(script.Parent.ParasiteVisual)
local PlacedEggBillboard = require(script.Parent.PlacedEggBillboard)
local PlacedEggGrowthPresentationPolicy = require(script.Parent.PlacedEggGrowthPresentationPolicy)
local PlacedEggReadyPulse = require(script.Parent.PlacedEggReadyPulse)
local PlotState = require(ReplicatedStorage.Client.PlotState)
require(ReplicatedStorage.Shared.Types.Plots)
require(ReplicatedStorage.Data.Products)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Signal = require(ReplicatedStorage.Packages.Signal)
local SmartProximityPrompt = require(ReplicatedStorage.Client.SmartProximityPrompt)
local Trove = require(ReplicatedStorage.Packages.Trove)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types)
local v1 = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local v3 = {}
local v4 = 0
local v5 = Random.new()
local v6 = Random.new()
local DayStartsAt
local v7 = false
local Folder = Instance.new("Folder")

Folder.Name = "PlacedEggRenders"
Folder.Parent = workspace

local v8 = Log.new()
local v9 = { LocalEggHatchStarted = Signal.new() }
local GetDirectGrowthTweenRemainingSeconds = PlacedEggGrowthPresentationPolicy.GetDirectGrowthTweenRemainingSeconds
local GetStartScale = PlacedEggGrowthPresentationPolicy.GetStartScale
local GetTargetScale = PlacedEggGrowthPresentationPolicy.GetTargetScale
local GetVisualScale = PlacedEggGrowthPresentationPolicy.GetVisualScale
local IsReady = PlacedEggGrowthPresentationPolicy.IsReady
local GetRemainingGrowthSeconds = PlacedEggGrowthPresentationPolicy.GetRemainingGrowthSeconds

local function getKey(v10, v11) -- line 59
    return (("%*:%*"):format(v10, v11))
end

local function getOwnerPlayer(v12) -- line 62 | captures: Players
    return Players:GetPlayerByUserId(v12)
end

local function readOwnerPlotData(v13) -- line 65 | captures: Players, PlotState
    local v14 = Players:GetPlayerByUserId(v13)
    if v14 == nil then
        return nil
    end
    return PlotState.ResolvePlot(v14)
end

local function isLocalOwner(v15) -- line 72 | captures: Players
    return v15 == Players.LocalPlayer.UserId
end

local function getNextReadyPulseAt(v16) -- line 76 | captures: v5
    return v16 + v5:NextNumber(5, 10)
end

local function getNextGrowthPulseAt(v17) -- line 79 | captures: v6
    return v17 + v6:NextNumber(27, 65)
end

local function getInitialGrowthUpdateAt(v18) -- line 82 | captures: v4
    local v19 = v18 + v4 * 0.2
    v4 = (v4 + 1) % 25
    return v19
end

local function getNightTimeSkipSecondsValue(v20) -- line 87
    local NightTimeSkipAnimation = v20.NightTimeSkipAnimation
    if NightTimeSkipAnimation == nil then
        return nil
    end
    return (NightTimeSkipAnimation:GetAppliedSecondsValue())
end

local function getNightTimeSkipSeconds(v21) -- line 94
    local NightTimeSkipAnimation = v21.NightTimeSkipAnimation
    local v22
    if NightTimeSkipAnimation == nil then
    else
        v22 = NightTimeSkipAnimation:GetAppliedSecondsValue()
    end
    if v22 == nil then
        return 0
    end
    return v22.Value
end

local function isNightTimeSkipControllingPresentation(v23) -- line 107
    local NightTimeSkipAnimation = v23.NightTimeSkipAnimation
    if NightTimeSkipAnimation == nil then
        return false
    end
    return not NightTimeSkipAnimation:IsComplete()
end

local function clearNightTimeSkipAnimation(v24) -- line 112 | captures: PlacedEggBillboard
    local NightTimeSkipAnimation = v24.NightTimeSkipAnimation
    if NightTimeSkipAnimation == nil then
        return
    end
    v24.NightTimeSkipAnimation = nil
    if v24.NightBillboardSuppressed then
        v24.NightBillboardSuppressed = false
        PlacedEggBillboard.SetNightPresentationActive(v24.OwnerUserId, v24.Uid, false)
    end
    NightTimeSkipAnimation:Destroy()
    local ScaleValue = v24.ScaleValue
    if ScaleValue ~= nil and v24.Result.Model.Parent ~= nil then
        ScaleValue.Value = v24.Result.Model:GetScale()
    end
end

local function startNightTimeSkipForState(v25, v26) -- line 128 | captures: Players, Workspace, AreaEggCycle, EggRecords, NightEggTimeSkipAnimation, PlacedEggBillboard
    if not (v25.OwnerUserId == Players.LocalPlayer.UserId) or v25.IsHatching or not (v25.Result.Model.Parent ~= nil) or not (v25.NightTimeSkipAnimation == nil) then
        return
    end
    local Placement = v25.Record.Placement
    local v27 = v26 - AreaEggCycle.NightLengthSeconds()
    local v28
    if Placement == nil then
        v28 = true
    elseif Placement.ReadyAt == nil then
        if v27 < Placement.PlacedAt or EggRecords.IsGrown(v25.Record, v27, v25.Record.GrowthSpeedMultiplier, nil, Players:GetPlayerByUserId(v25.OwnerUserId)) or v26 <= Workspace:GetServerTimeNow() then
            v28 = true
        else
            local GrowthAnimation = v25.GrowthAnimation
            if GrowthAnimation ~= nil then
                GrowthAnimation:Cancel()
            end
            v28 = false
        end
    else
        v28 = true
    end
    if v28 then
        return
    end
    local ReadyPulse = v25.ReadyPulse
    if ReadyPulse ~= nil then
        ReadyPulse:Cancel()
    end
    local ScaleTween = v25.ScaleTween
    if ScaleTween ~= nil then
        ScaleTween:Cancel()
        v25.ScaleTween = nil
        v25.DirectGrowthTweenActive = false
    end
    local v29 = NightEggTimeSkipAnimation.new(v25.Result.Model, v25.Uid, v25.Record, v25.BasePivot, v25.StartScale, v25.TargetScale, v27, v26)
    v25.NightTimeSkipAnimation = v29
    PlacedEggBillboard.SetEntry({
        OwnerUserId = v25.OwnerUserId,
        Uid = v25.Uid,
        Record = v25.Record,
        Model = v25.Result.Model,
        TimeSkipSeconds = v29:GetAppliedSecondsValue()
    })
    v25.NightBillboardSuppressed = true
    PlacedEggBillboard.SetNightPresentationActive(v25.OwnerUserId, v25.Uid, true)
end

local function setStateScale(v30, v31, v32, v33, v34) -- line 164 | captures: Players, TweenService, EggRenderer, v1
    if v30.OwnerUserId == Players.LocalPlayer.UserId then
        local ScaleValue = v30.ScaleValue
        if ScaleValue == nil then
            v30.Result.Model:ScaleTo(v31)
            EggRenderer.DisableCollisions(v30.Result.Model)
        else
            local ScaleTween = v30.ScaleTween
            local v35 = ScaleTween ~= nil
            if ScaleTween ~= nil then
                ScaleTween:Cancel()
                v30.ScaleTween = nil
                v30.DirectGrowthTweenActive = false
            end
            if v33 == false then
                if v34 == true then
                    v30.DirectGrowthTweenActive = true
                end
                local v36 = ScaleValue.Value - v31
                local v37 = math.abs(v36) > 0.001
                if v37 then
                    ScaleValue.Value = v31
                end
                return v35 or v37
            end
            local v38 = ScaleValue.Value - v31
            if math.abs(v38) <= 0.001 then
                if v34 == true then
                    v30.DirectGrowthTweenActive = true
                end
            else
                local v39 = v32 or v1
                local v40 = TweenService:Create(ScaleValue, v39, { Value = v31 })
                v30.ScaleTween = v40
                v30.DirectGrowthTweenActive = v34 == true
                v40.Completed:Once(function() -- line 211 | captures: v30, v34, v40
                    if v30.ScaleTween == v40 then
                        v30.ScaleTween = nil
                        if v34 == true then
                            v30.DirectGrowthTweenActive = false
                        end
                    end
                end)
                v40:Play()
            end
        end
    else
        v30.Result.Model:ScaleTo(v31)
        EggRenderer.DisableCollisions(v30.Result.Model)
    end
    return false
end

local function startDirectGrowthTween(v41, v42) -- line 222 | captures: setStateScale
    local v43 = math.max(v42, 0.05)
    local v44 = TweenInfo.new(v43, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    setStateScale(v41, v41.TargetScale, v44, true, true)
end

local function hasSkipGrowthCredit(v45) -- line 227 | captures: ReplicatedStorage
    local Save = require(ReplicatedStorage.Shared.Save)
    if Save.IsLocalDataLoaded() then
        local v46 = Save.Get()
        local ProductCredits
        if v46 == nil then
        else
            ProductCredits = v46.ProductCredits
        end
        if typeof(ProductCredits) == "table" then
            local v47 = ProductCredits[tostring(v45)]
            if typeof(v47) == "number" then
                return v47 > 0
            end
        end
    end
    return false
end

local function updatePrompt(v48) -- line 246 | captures: v7, IsReady
    local Prompt = v48.Prompt
    if Prompt == nil then
        return
    end
    local NightTimeSkipAnimation = v48.NightTimeSkipAnimation
    local v49
    if NightTimeSkipAnimation == nil then
    else
        v49 = NightTimeSkipAnimation:GetAppliedSecondsValue()
    end
    local v50 = if v49 == nil then 0 else v49.Value
    local v51 = if IsReady(v48.Record, v50) then "Hatch!" else "Skip Growth"
    Prompt.Enabled = not v7 and not v48.IsHatching and true
    Prompt.ActionText = v51
    Prompt.ObjectText = v51
end

local function trackOcclusion(v52) -- line 282 | captures: ModelCameraOcclusion
    local v53 = not v52.OcclusionTracked
    local v54 = ("Placed egg %* occlusion is already tracked"):format(v52.Uid)
    assert(v53, v54)
    ModelCameraOcclusion.Register(v52.Result.Model, 1)
    v52.OcclusionTracked = true
end

local function untrackOcclusion(v55) -- line 287 | captures: ModelCameraOcclusion
    if v55.OcclusionTracked then
        ModelCameraOcclusion.Forget(v55.Result.Model)
        v55.OcclusionTracked = false
    end
end

local v56, v57

local function runHatchPresentation(v58, v59) -- line 296 | captures: v56, v57, Players, EggHatchAnimation, EggState, v8, v9
    if v58.OwnerUserId == Players.LocalPlayer.UserId then
        v9.LocalEggHatchStarted:Fire(v58.Uid)
    end
    local v60 = EggHatchAnimation.Play(v58.OwnerUserId, v58.Uid, v58.Record, v58.Result.Model, v59)
    local v61, v62, v63 = EggState.FinishHatch(v58.Uid)
    if v61 then
        if v60 ~= nil then
            local v64 = assert(v63, "Successful hatch completion must return the granted asset UID")
            EggHatchAnimation.FadeSoundWhenGrantedToolUnequips(v60, v64)
        end
    else
        v8:AtWarning():Log((("Failed to complete hatch for egg %*: %*"):format(v58.Uid, v62 or "unknown")))
        v56((("%*:%*"):format(v58.OwnerUserId, v58.Uid)))
        v57(v58.OwnerUserId)
    end
end

local function activatePrompt(v65) -- line 315 | captures: v56, v57, EggMechaUpgradeAnimation, EggState, Eggs, ModelCameraOcclusion, PromptPurchase, v3, v8, IsReady, updatePrompt, runHatchPresentation
    local ReadyPulse = v65.ReadyPulse
    if ReadyPulse == nil then
        return false, "Egg is not owned by the local player"
    end
    local NightTimeSkipAnimation = v65.NightTimeSkipAnimation
    local v66
    if NightTimeSkipAnimation == nil then
    else
        v66 = NightTimeSkipAnimation:GetAppliedSecondsValue()
    end
    local v67 = if v66 == nil then 0 else v66.Value
    if IsReady(v65.Record, v67) then
        if v65.HatchLock(function() -- line 334 | captures: v65, ReadyPulse, v56, v57, EggMechaUpgradeAnimation, EggState, Eggs, ModelCameraOcclusion, v3, v8, updatePrompt, runHatchPresentation
                v65.IsHatching = true
                if v65.OcclusionTracked then
                    ModelCameraOcclusion.Forget(v65.Result.Model)
                    v65.OcclusionTracked = false
                end
                v65.NextReadyPulseAt = nil
                ReadyPulse:Cancel()
                updatePrompt(v65)
                local v68, v69, v70 = EggState.BeginHatch(v65.Uid)
                if v68 then
                    if v70 == Eggs.HATCH_RESULT_MECHA_UPGRADED then
                        local v71 = ("%*:%*"):format(v65.OwnerUserId, v65.Uid)
                        local OwnerUserId = v65.OwnerUserId
                        EggMechaUpgradeAnimation.Play(OwnerUserId, v65.Result.Model, function() -- line 353 | captures: v71, OwnerUserId, v56, v57, ModelCameraOcclusion, v3, updatePrompt
                            v56(v71)
                            v57(OwnerUserId)
                            local v72 = v3[v71]
                            if v72 == nil then
                                return nil
                            end
                            v72.IsHatching = true
                            if v72.OcclusionTracked then
                                ModelCameraOcclusion.Forget(v72.Result.Model)
                                v72.OcclusionTracked = false
                            end
                            v72.NextReadyPulseAt = nil
                            local ReadyPulse = v72.ReadyPulse
                            if ReadyPulse ~= nil then
                                ReadyPulse:Cancel()
                            end
                            updatePrompt(v72)
                            return v72.Result.Model
                        end)
                        local v73 = v3[v71]
                        if v73 == nil then
                            EggState.FinishHatch(v65.Uid)
                        else
                            runHatchPresentation(v73, true)
                        end
                    else
                        runHatchPresentation(v65, false)
                    end
                else
                    v65.IsHatching = false
                    local v74 = not v65.OcclusionTracked
                    local v75 = ("Placed egg %* occlusion is already tracked"):format(v65.Uid)
                    assert(v74, v75)
                    ModelCameraOcclusion.Register(v65.Result.Model, 1)
                    v65.OcclusionTracked = true
                    updatePrompt(v65)
                    v8:AtWarning():Log((("Failed to hatch egg %*: %*"):format(v65.Uid, v69 or "unknown")))
                end
            end) then
            return true
        end
        local Uid = v65.Uid
        v8:AtDebug():Log((("Ignored duplicate hatch prompt for egg %*"):format(Uid)))
        return false, "Egg is already hatching"
    end
    local v76, v77, v78 = EggState.BeginSkipGrowth(v65.Uid)
    if v76 then
        if v78 then
            PromptPurchase.Prompt(v78, true)
        end
        return true
    end
    local Uid = v65.Uid
    v8:AtWarning():Log((("Failed to request skip growth for egg %*: %*"):format(Uid, v77 or "unknown")))
    return false, v77
end

function v56(v79) -- line 416 | captures: ModelCameraOcclusion, PlacedEggBillboard, v3, clearNightTimeSkipAnimation
    local v80 = v3[v79]
    if v80 == nil then
        return
    end
    if v80.OcclusionTracked then
        ModelCameraOcclusion.Forget(v80.Result.Model)
        v80.OcclusionTracked = false
    end
    v3[v79] = nil
    clearNightTimeSkipAnimation(v80)
    PlacedEggBillboard.RemoveEntry(v80.OwnerUserId, v80.Uid)
    v80.Trove:Destroy()
end

local function destroyOwnerStates(v81) -- line 430 | captures: v56, v3
    for v82, v83 in pairs(v3) do
        if v83.OwnerUserId == v81 then
            v56(v82)
        end
    end
end

local function addPlacedEggRenderState(v84, v85, v86) -- line 437 | captures: v4, DayStartsAt, Players, Workspace, EggActionMovement, EggGrowthAnimation, EggPlaceAnimation, EggRenderer, EggState, ModelCameraOcclusion, PlacedEggBillboard, PlacedEggReadyPulse, PlotState, SmartProximityPrompt, Trove, TryLock, v3, Folder, v8, GetDirectGrowthTweenRemainingSeconds, GetStartScale, GetTargetScale, GetVisualScale, startNightTimeSkipForState, setStateScale, updatePrompt, activatePrompt
    local Placement = v86.Placement
    if Placement == nil then
        return
    end
    local v87 = Players:GetPlayerByUserId(v84)
    local v88
    if v87 == nil then
    else
        v88 = PlotState.ResolvePlot(v87)
    end
    if v88 == nil then
        return
    end
    local v89 = Trove.new()
    local v90 = GetStartScale(v86)
    local v91 = GetTargetScale(v86)
    local v92 = GetVisualScale(v86, v90, v91)
    local v93 = v88.CenterPoint.CFrame * Placement.LocalCFrame
    local v94 = EggRenderer.RenderVisual({
        OwnerUserId = v84,
        UID = v85,
        ModelName = ("%*_%*"):format(v84, v85),
        Record = v86,
        ScaleMultiplier = v92
    }, Folder, false)
    v89:Add(v94.Model)
    EggActionMovement.SetPivot(v94.Model, v93)
    if v84 == Players.LocalPlayer.UserId and EggState.TakePlantCue(v85) then
        EggPlaceAnimation.Play(v94.Model, v93, Folder)
    end
    local NumberValue
    if v84 == Players.LocalPlayer.UserId then
        NumberValue = Instance.new("NumberValue")
        NumberValue.Value = v92
        v89:Add(NumberValue)
        v89:Add(NumberValue.Changed:Connect(function(v95) -- line 479 | captures: v94, EggRenderer
            v94.Model:ScaleTo(v95)
            EggRenderer.DisableCollisions(v94.Model)
        end))
    end
    local v96 = v84 == Players.LocalPlayer.UserId
    local v97, v98, ProximityPrompt, v99, v100
    if v96 then
        ProximityPrompt = Instance.new("ProximityPrompt")
        ProximityPrompt.RequiresLineOfSight = false
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
        ProximityPrompt.MaxActivationDistance = 7
        ProximityPrompt.HoldDuration = 0
        v89:Add(SmartProximityPrompt.AttachToModel(ProximityPrompt, v94.Model, {
            SurfaceOffset = 0.75,
            TrackDistance = 7,
            MaxActivationDistance = ProximityPrompt.MaxActivationDistance
        }))
        local v101 = EggGrowthAnimation.new(v94.Model, v93, 1)
        v97 = v101
        local v102 = PlacedEggReadyPulse.new(v94.Model, v93, v91)
        v98 = v102
        v99 = v101
        v100 = v102
    end
    local v103 = {
        DirectGrowthTweenActive = false,
        NightBillboardSuppressed = false,
        IsHatching = false,
        OcclusionTracked = false,
        OwnerUserId = v84,
        Uid = v85,
        Record = v86,
        Result = v94,
        BasePivot = v93,
        StartScale = v90,
        TargetScale = v91,
        ScaleValue = NumberValue,
        GrowthAnimation = v99
    }
    local v104 = Workspace:GetServerTimeNow() + v4 * 0.2
    v4 = (v4 + 1) % 25
    v103.NextGrowthUpdateAt = v104
    v103.ReadyPulse = v100
    v103.Prompt = ProximityPrompt
    v103.Trove = v89
    v103.HatchLock = TryLock()
    local DayStartsAt_2 = DayStartsAt
    if DayStartsAt_2 ~= nil then
        startNightTimeSkipForState(v103, DayStartsAt_2)
    end
    if v100 ~= nil then
        v89:Add(function() -- line 526 | captures: v98
            v98:Destroy()
        end)
    end
    if v99 ~= nil then
        v89:Add(function() -- line 531 | captures: v97
            v97:Destroy()
        end)
    end
    v89:Add(function() -- line 535 | captures: v103
        local ScaleTween = v103.ScaleTween
        if ScaleTween == nil then
            return
        end
        ScaleTween:Cancel()
        v103.ScaleTween = nil
        v103.DirectGrowthTweenActive = false
    end)
    v3[("%*:%*"):format(v84, v85)] = v103
    local Uid = v103.Uid
    local v105 = not v103.OcclusionTracked
    local v106 = ("Placed egg %* occlusion is already tracked"):format(Uid)
    assert(v105, v106)
    ModelCameraOcclusion.Register(v103.Result.Model, 1)
    v103.OcclusionTracked = true
    local v107 = {
        OwnerUserId = v84,
        Uid = v85,
        Record = v86,
        Model = v94.Model
    }
    local NightTimeSkipAnimation = v103.NightTimeSkipAnimation
    if NightTimeSkipAnimation == nil then
        v107.TimeSkipSeconds = nil
    else
        v107.TimeSkipSeconds = NightTimeSkipAnimation:GetAppliedSecondsValue()
    end
    PlacedEggBillboard.SetEntry(v107)
    updatePrompt(v103)
    if ProximityPrompt ~= nil then
        v89:Add(ProximityPrompt.Triggered:Connect(function(v108) -- line 559 | captures: v103, Players, activatePrompt
            if v108 == Players.LocalPlayer then
                activatePrompt(v103)
            end
        end))
    end
    local v109 = Workspace:GetServerTimeNow()
    local v110 = GetDirectGrowthTweenRemainingSeconds(v86, v109)
    if v96 and v110 > 0 then
        local NightTimeSkipAnimation = v103.NightTimeSkipAnimation
        if not (NightTimeSkipAnimation ~= nil) or NightTimeSkipAnimation:IsComplete() then
            local v111 = math.max(v110, 0.05)
            local v112 = TweenInfo.new(v111, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            setStateScale(v103, v103.TargetScale, v112, true, true)
        end
    end
    v8:AtDebug():Log((("Rendered placed egg %* for owner %*"):format(v85, v84)))
end

function v57(v113) -- line 579 | captures: v56, Players, EggActionMovement, EggSkipAnimation, EggState, ParasiteVisual, PlacedEggBillboard, PlacedEggGrowthPresentationPolicy, PlotState, v2, v3, GetStartScale, GetTargetScale, IsReady, clearNightTimeSkipAnimation, setStateScale, updatePrompt, addPlacedEggRenderState
    local v114 = EggState.ReadOwnerEggs(v113)
    local v115 = Players:GetPlayerByUserId(v113)
    local v116
    if v115 == nil then
    else
        v116 = PlotState.ResolvePlot(v115)
    end
    if v116 == nil then
        return
    end
    local v117 = {}
    for v118, v119 in pairs(v114) do
        if v119.Placement ~= nil then
            local v120 = ("%*:%*"):format(v113, v118)
            v117[v120] = true
            local v121 = v3[v120]
            if not (v121 == nil or v121.IsHatching or v119.AssetCategory == v121.Record.AssetCategory) then
                v56(v120)
                v121 = nil
            end
            if v121 == nil then
                addPlacedEggRenderState(v113, v118, v119)
            else
                local NightTimeSkipAnimation = v121.NightTimeSkipAnimation
                local v122
                if NightTimeSkipAnimation == nil then
                else
                    v122 = NightTimeSkipAnimation:GetAppliedSecondsValue()
                end
                local v123 = if v122 == nil then 0 else v122.Value
                local v124 = IsReady(v121.Record, v123)
                local v125 = IsReady(v119, v123)
                v121.Record = v119
                if v119.HasParasite ~= v121.Record.HasParasite then
                    ParasiteVisual.Attach(v121.Result.Model, v119.HasParasite)
                end
                v121.StartScale = GetStartScale(v119)
                v121.TargetScale = GetTargetScale(v119)
                if v119.Placement ~= nil then
                    v121.BasePivot = v116.CenterPoint.CFrame * v119.Placement.LocalCFrame
                    local ReadyPulse = v121.ReadyPulse
                    if ReadyPulse ~= nil then
                        ReadyPulse:SetTransform(v121.BasePivot, v121.TargetScale)
                    end
                    local GrowthAnimation = v121.GrowthAnimation
                    if GrowthAnimation ~= nil then
                        GrowthAnimation:SetBasePivot(v121.BasePivot)
                    end
                    local NightTimeSkipAnimation = v121.NightTimeSkipAnimation
                    if NightTimeSkipAnimation ~= nil then
                        NightTimeSkipAnimation:SetTransform(v121.BasePivot, v121.StartScale, v121.TargetScale)
                        NightTimeSkipAnimation:AcknowledgeRecord(v119)
                        if v125 then
                            NightTimeSkipAnimation:CancelVisual()
                        end
                    end
                    local NightTimeSkipAnimation_2 = v121.NightTimeSkipAnimation
                    if not (NightTimeSkipAnimation_2 ~= nil) or NightTimeSkipAnimation_2:IsComplete() then
                        if ReadyPulse == nil then
                            if GrowthAnimation == nil then
                                EggActionMovement.SetPivot(v121.Result.Model, v121.BasePivot)
                            elseif GrowthAnimation:IsPlaying() then
                            end
                        elseif ReadyPulse:IsPlaying() then
                        end
                    end
                end
                local NightTimeSkipAnimation_2 = v121.NightTimeSkipAnimation
                if NightTimeSkipAnimation_2 ~= nil and NightTimeSkipAnimation_2:IsComplete() then
                    clearNightTimeSkipAnimation(v121)
                end
                local v126 = {
                    OwnerUserId = v113,
                    Uid = v118,
                    Record = v119,
                    Model = v121.Result.Model
                }
                local NightTimeSkipAnimation_3 = v121.NightTimeSkipAnimation
                if NightTimeSkipAnimation_3 == nil then
                    v126.TimeSkipSeconds = nil
                else
                    v126.TimeSkipSeconds = NightTimeSkipAnimation_3:GetAppliedSecondsValue()
                end
                PlacedEggBillboard.SetEntry(v126)
                if v113 == Players.LocalPlayer.UserId and not v124 and v125 and v121.NightTimeSkipAnimation == nil then
                    if EggState.ReadChosenSkipUid() == v118 then
                        setStateScale(v121, v121.TargetScale, v2)
                        task.spawn(EggSkipAnimation.Play, v121.Result.Model)
                    else
                        local v127 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v121.Result.Model)
                        local v128 = v127 == nil
                        if setStateScale(v121, v121.TargetScale, nil, v128) then
                            local v129 = assert(v127, "Skipped natural completion requires a presentation reason")
                            PlacedEggGrowthPresentationPolicy.LogSkipped(v121.Uid, "natural completion", v129)
                        end
                    end
                end
                updatePrompt(v121)
            end
        end
    end
    for v130, v131 in pairs(v3) do
        if v131.OwnerUserId == v113 and not v117[v130] then
            v56(v130)
        end
    end
end

local function refreshAll() -- line 690 | captures: v56, v57, EggState, v3
    local v132 = {}
    for v133, v134 in ipairs((EggState.ReadOwnedEggs())) do
        v132[v134.OwnerUserId] = true
        v57(v134.OwnerUserId)
    end
    for v135, v136 in pairs(v3) do
        if not v132[v136.OwnerUserId] then
            v56(v135)
        end
    end
end

local function updateReadyPulses(v137) -- line 702 | captures: PlacedEggGrowthPresentationPolicy, v3, v5, IsReady
    for v138, v139 in pairs(v3) do
        local ReadyPulse = v139.ReadyPulse
        if ReadyPulse ~= nil then
            if v139.IsHatching then
                v139.NextReadyPulseAt = nil
                ReadyPulse:Cancel()
            elseif v139.Result.Model.Parent ~= nil then
                local NightTimeSkipAnimation = v139.NightTimeSkipAnimation
                local v140
                if NightTimeSkipAnimation == nil then
                else
                    v140 = NightTimeSkipAnimation:GetAppliedSecondsValue()
                end
                local v141 = if v140 == nil then 0 else v140.Value
                if IsReady(v139.Record, v141) then
                    local NightTimeSkipAnimation = v139.NightTimeSkipAnimation
                    if not (NightTimeSkipAnimation ~= nil) or NightTimeSkipAnimation:IsComplete() then
                        local NextReadyPulseAt = v139.NextReadyPulseAt
                        if ReadyPulse:IsPlaying() then
                            local v142 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v139.Result.Model)
                            if v142 == nil then
                                if NextReadyPulseAt == nil then
                                    v139.NextReadyPulseAt = v137 + v5:NextNumber(5, 10)
                                end
                            else
                                ReadyPulse:Cancel()
                                v139.NextReadyPulseAt = v137 + v5:NextNumber(5, 10)
                                PlacedEggGrowthPresentationPolicy.LogSkipped(v139.Uid, "ready pulse cancellation", v142)
                            end
                        elseif NextReadyPulseAt == nil then
                            v139.NextReadyPulseAt = v137 + v5:NextNumber(5, 10)
                        elseif NextReadyPulseAt <= v137 then
                            local v143 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v139.Result.Model)
                            if v143 == nil then
                                if ReadyPulse:Play() then
                                    v139.NextReadyPulseAt = nil
                                end
                            else
                                v139.NextReadyPulseAt = v137 + v5:NextNumber(5, 10)
                                PlacedEggGrowthPresentationPolicy.LogSkipped(v139.Uid, "ready pulse", v143)
                            end
                        end
                    end
                end
            end
        end
    end
end

local function updateGrowthPulses(v144) -- line 754 | captures: PlacedEggGrowthPresentationPolicy, v3, v6, GetDirectGrowthTweenRemainingSeconds, IsReady
    for v145, v146 in pairs(v3) do
        local GrowthAnimation = v146.GrowthAnimation
        if GrowthAnimation ~= nil then
            local v147 = GetDirectGrowthTweenRemainingSeconds(v146.Record, v144)
            if v146.IsHatching then
                v146.NextGrowthPulseAt = nil
                GrowthAnimation:Cancel()
            elseif v146.Result.Model.Parent ~= nil then
                local NightTimeSkipAnimation = v146.NightTimeSkipAnimation
                local v148
                if NightTimeSkipAnimation == nil then
                else
                    v148 = NightTimeSkipAnimation:GetAppliedSecondsValue()
                end
                local v149 = if v148 == nil then 0 else v148.Value
                if not IsReady(v146.Record, v149) and v147 <= 0 then
                    local NightTimeSkipAnimation = v146.NightTimeSkipAnimation
                    if not (NightTimeSkipAnimation ~= nil) or NightTimeSkipAnimation:IsComplete() then
                        local NextGrowthPulseAt = v146.NextGrowthPulseAt
                        if GrowthAnimation:IsPlaying() then
                            local v150 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v146.Result.Model)
                            if v150 ~= nil then
                                GrowthAnimation:Cancel()
                                v146.NextGrowthPulseAt = v144 + v6:NextNumber(27, 65)
                                PlacedEggGrowthPresentationPolicy.LogSkipped(v146.Uid, "random growth jump cancellation", v150)
                            end
                        elseif NextGrowthPulseAt == nil then
                            v146.NextGrowthPulseAt = v144 + v6:NextNumber(27, 65)
                        elseif NextGrowthPulseAt <= v144 then
                            v146.NextGrowthPulseAt = v144 + v6:NextNumber(27, 65)
                            local v151 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v146.Result.Model)
                            if v151 == nil then
                                GrowthAnimation:Play()
                            else
                                PlacedEggGrowthPresentationPolicy.LogSkipped(v146.Uid, "random growth jump", v151)
                            end
                        end
                    end
                end
            end
        end
    end
end

local function updateGrowth(v152) -- line 805 | captures: Players, PlacedEggGrowthPresentationPolicy, v3, GetDirectGrowthTweenRemainingSeconds, GetVisualScale, setStateScale, updatePrompt
    for v153, v154 in pairs(v3) do
        if not v154.IsHatching and v154.Result.Model.Parent ~= nil then
            local NightTimeSkipAnimation = v154.NightTimeSkipAnimation
            if not (NightTimeSkipAnimation ~= nil) or NightTimeSkipAnimation:IsComplete() then
                local v155 = GetDirectGrowthTweenRemainingSeconds(v154.Record, v152)
                if v154.OwnerUserId == Players.LocalPlayer.UserId and v155 > 0 then
                    if not v154.DirectGrowthTweenActive then
                        updatePrompt(v154)
                        local v156 = math.max(v155, 0.05)
                        local v157 = TweenInfo.new(v156, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                        setStateScale(v154, v154.TargetScale, v157, true, true)
                    end
                else
                    local NextGrowthUpdateAt = v154.NextGrowthUpdateAt
                    if NextGrowthUpdateAt <= v152 then
                        local v158 = (v152 - NextGrowthUpdateAt) / 5
                        v154.NextGrowthUpdateAt = NextGrowthUpdateAt + (math.floor(v158) + 1) * 5
                        updatePrompt(v154)
                        local v159 = GetVisualScale(v154.Record, v154.StartScale, v154.TargetScale)
                        local v160 = PlacedEggGrowthPresentationPolicy.GetNaturalGrowthSkipReason(v154.Result.Model, v159)
                        local v161 = v160 == nil
                        if setStateScale(v154, v159, nil, v161) then
                            local v162 = "Skipped natural growth requires a presentation reason"
                            local v163 = assert(v160, v162)
                            PlacedEggGrowthPresentationPolicy.LogSkipped(v154.Uid, "natural growth", v163)
                        end
                    end
                end
            end
        end
    end
end

local function updateNightTimeSkips() -- line 840 | captures: PlacedEggBillboard, v3, clearNightTimeSkipAnimation, updatePrompt
    for v164, v165 in pairs(v3) do
        local NightTimeSkipAnimation = v165.NightTimeSkipAnimation
        if NightTimeSkipAnimation ~= nil then
            if v165.IsHatching then
                clearNightTimeSkipAnimation(v165)
            elseif v165.Result.Model.Parent ~= nil then
                updatePrompt(v165)
                if v165.NightBillboardSuppressed and NightTimeSkipAnimation:IsBillboardFadeFinished() then
                    v165.NightBillboardSuppressed = false
                    PlacedEggBillboard.SetNightPresentationActive(v165.OwnerUserId, v165.Uid, false)
                end
                if NightTimeSkipAnimation:IsComplete() then
                    clearNightTimeSkipAnimation(v165)
                    PlacedEggBillboard.SetEntry({
                        OwnerUserId = v165.OwnerUserId,
                        Uid = v165.Uid,
                        Record = v165.Record,
                        Model = v165.Result.Model
                    })
                end
            end
        end
    end
end

function v9.GetRenderFolder() -- line 861 | captures: Folder
    return Folder
end

function v9.Refresh() -- line 864 | captures: refreshAll
    refreshAll()
end

function v9.SetPromptsSuppressed(v166) -- line 867 | captures: v7, t, v3, updatePrompt
    t.strict(t.boolean)(v166)
    v7 = v166
    for v167, v168 in pairs(v3) do
        updatePrompt(v168)
    end
end

function v9.ActivateLocalEgg(v169) -- line 875 | captures: Players, t, v3, activatePrompt
    t.strict(t.string)(v169)
    local v170 = v3[("%*:%*"):format(Players.LocalPlayer.UserId, v169)]
    if v170 == nil then
        return false, "Egg is not rendered"
    end
    return activatePrompt(v170)
end

function v9.RequestSkipGrowthForLocalEgg(v171) -- line 884 | captures: Players, t, v3, IsReady, activatePrompt
    t.strict(t.string)(v171)
    local v172 = v3[("%*:%*"):format(Players.LocalPlayer.UserId, v171)]
    if v172 == nil then
        return false, "Egg is not rendered"
    end
    local NightTimeSkipAnimation = v172.NightTimeSkipAnimation
    local v173
    if NightTimeSkipAnimation == nil then
    else
        v173 = NightTimeSkipAnimation:GetAppliedSecondsValue()
    end
    local v174 = if v173 == nil then 0 else v173.Value
    if IsReady(v172.Record, v174) then
        return false, "Egg is already ready"
    end
    return activatePrompt(v172)
end

function v9.AppendRaycastTargets(v175, v176) -- line 908 | captures: t, v3
    t.strict(t.number)(v176)
    for v177, v178 in pairs(v3) do
        if v178.OwnerUserId == v176 and v178.Result.Model.Parent ~= nil then
            local Model = v178.Result.Model
            table.insert(v175, Model)
        end
    end
end

function v9.DestroyOwner(v179) -- line 917 | captures: PlacedEggBillboard, t, destroyOwnerStates
    t.strict(t.number)(v179)
    destroyOwnerStates(v179)
    PlacedEggBillboard.DestroyOwner(v179)
end

function v9.SetAllHidden(v180) -- line 923 | captures: t, Folder, v9
    t.strict(t.boolean)(v180)
    local v181
    if v180 then
    else
        v181 = workspace
    end
    Folder.Parent = v181
    v9.SetPromptsSuppressed(v180)
end

EggState.SnapshotRefreshed:Connect(refreshAll)
EggState.OwnerRefreshed:Connect(v57)
EggState.OwnerCleared:Connect(v9.DestroyOwner)
EggState.ResetCountdown:Connect(function(v182) -- line 938 | captures: DayStartsAt, v3, startNightTimeSkipForState
    DayStartsAt = v182.DayStartsAt
    for v183, v184 in pairs(v3) do
        startNightTimeSkipForState(v184, v182.DayStartsAt)
    end
end)
PlotState.PlotChanged:Connect(refreshAll)
RunService.Heartbeat:Connect(function() -- line 945 | captures: Workspace, updateReadyPulses, updateGrowthPulses, updateGrowth, updateNightTimeSkips
    local v185 = Workspace:GetServerTimeNow()
    updateNightTimeSkips()
    updateGrowthPulses(v185)
    updateReadyPulses(v185)
    updateGrowth(v185)
end)
task.defer(function() -- line 952 | captures: DayStartsAt, Workspace, AreaEggCycle, v3, startNightTimeSkipForState, refreshAll
    refreshAll()
    local v186 = Workspace:GetServerTimeNow()
    if not AreaEggCycle.IsNightPhase(v186) then
        return
    end
    local v187 = { DayStartsAt = AreaEggCycle.NextResetTime(v186) }
    DayStartsAt = v187.DayStartsAt
    for v188, v189 in pairs(v3) do
        startNightTimeSkipForState(v189, v187.DayStartsAt)
    end
end)
return v9
