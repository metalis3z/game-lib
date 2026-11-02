-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.numberMinExclusive((-1/0)), t.numberMaxExclusive((1/0)))
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local Assets = require(ReplicatedStorage.Data.Assets)
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local SwapGradient = require(ReplicatedStorage.Shared.Utils.Layout).SwapGradient
local VisualTransform = require(ReplicatedStorage.Shared.Utils.VisualTransform)
local PlacedEggGrowthPresentationPolicy = require(script.Parent.PlacedEggGrowthPresentationPolicy)
local FrameStepper = require(ReplicatedStorage.Shared.Utils.FrameStepper)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v2 = {}

v2.__index = v2
v2.__class = "NightEggTimeSkipAnimation"

local v3 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v4 = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local v5 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local NightEggTimeSkip = ReplicatedStorage.Assets.Billboards.NightEggTimeSkip
local BillboardGui = NightEggTimeSkip:IsA("BillboardGui")
assert(BillboardGui, "ReplicatedStorage.Assets.Billboards.NightEggTimeSkip must be a BillboardGui")

function v2.new(v6, v7, v8, v9, v10, v11, v12, v13) -- line 34 | captures: t, v1, AreaEggCycle, Assets, EggRecords, Eggs, VisualTransform, Trove, v2
    t.strict(t.instanceIsA("Model"))(v6)
    t.strict(t.string)(v7)
    local v14 = Eggs.SchemaValidation.RuntimeEggRecord(v8)
    assert(v14, "Invalid runtime egg record")
    t.strict(t.CFrame)(v9)
    t.strict(v1)(v10)
    t.strict(v1)(v11)
    t.strict(v1)(v12)
    t.strict(v1)(v13)
    local v15 = if v10 > 0 then v11 > 0 else false
    assert(v15, "Egg time skip scales must be positive")
    local v16 = v12 < v13
    assert(v16, "Egg time skip day start must follow night start")
    local Placement = v8.Placement
    assert(Placement, "Night egg time skip requires a placed egg")
    local v17 = Assets.Directory[v8.AssetCategory]
    local v18 = v17 ~= nil
    local v19 = ("Missing asset config for category %*"):format(v8.AssetCategory)
    assert(v18, v19)
    local GrowthSpeedMultiplier = v8.GrowthSpeedMultiplier
    local v20 = AreaEggCycle.PeriodIndexAt(v13)
    local v21 = EggRecords.CommittedNightCredit(v8, v20)
    local v22 = EggRecords.GrowthSecondsRemaining(v8, v12, GrowthSpeedMultiplier) + v21
    local NightGrowthSkipSeconds = AreaEggCycle.NightGrowthSkipSeconds
    local v23 = math.min(NightGrowthSkipSeconds, v22)
    local v24 = {}
    local v25 = setmetatable(v24, v2)
    v25._model = v6
    v25._uid = v7
    v25._record = v8
    v25._basePivot = v9
    v25._startScale = v10
    v25._targetScale = v11
    v25._growthSpeedMultiplier = GrowthSpeedMultiplier
    v25._nightStartsAt = v12
    v25._dayStartsAt = v13
    v25._nightPeriodIndex = v20
    v25._nightTargetCreditSeconds = v23
    v25._committedNightCreditSeconds = v21
    local v26 = v23 - v21
    v25._skipSeconds = math.max(0, v26)
    v25._remainingAtNightfall = v22
    v25._nightScaleStart = v10
    v25._nightScaleEnd = v11
    v25._snappedGrowthScale = nil
    local v27 = v25._skipSeconds > 0
    assert(v27, "Night egg time skip requires remaining growth time")
    v25._appliedSeconds = Instance.new("NumberValue")
    v25._billboardTransparency = VisualTransform.Fade()
    v25._lifecycleTrove = Trove.new()
    v25._visualTrove = Trove.new()
    v25._animation = nil
    v25._visualFinishing = false
    v25._visualFinished = false
    v25._billboardFadeFinished = false
    v25._pendingCommit = true
    v25._destroyed = false
    v25._lastTimerSecond = -1
    v25._lastShakeElapsed = 0
    v25._lastShakeAlpha = 0
    v25._lastShakePitch = 0
    v25._lastShakeRoll = 0
    v25._billboard = nil
    v25._timerLabel = nil
    v25._textScale = nil
    v25._originalTextColor = nil
    v25._rarityGradient = v17.Rarity.RarityGradient
    v25:_refreshNightScaleRange()
    v25._lifecycleTrove:Add(v25._appliedSeconds)
    v25:_init()
    return v25
end

function v2._getAppliedSecondsAt(v28, v29) -- line 109 | captures: EggRecords
    return EggRecords.NightCreditAt(v28._record, v29, v28._growthSpeedMultiplier, v28._nightStartsAt, v28._nightPeriodIndex)
end

function v2._getGrowthScaleAt(v30, v31) -- line 112 | captures: EggRecords
    local v32 = EggRecords.GrowthAlpha(v30._record, v31, v30._growthSpeedMultiplier, v30:_getAppliedSecondsAt(v31))
    local _startScale = v30._startScale
    local _targetScale = v30._targetScale
    return (math.lerp(_startScale, _targetScale, v32))
end

local function _refreshNightScaleRange(v33) -- line 116
    local v34 = v33:_getGrowthScaleAt(v33._nightStartsAt)
    local v35 = v33:_getGrowthScaleAt(v33._dayStartsAt)
    local v36 = v33._nightScaleStart - v34
    local v37
    if math.abs(v36) <= 0.001 then
        local v38 = v33._nightScaleEnd - v35
        v37 = math.abs(v38) > 0.001
    else
        v37 = true
    end
    v33._nightScaleStart = v34
    v33._nightScaleEnd = v35
    if v37 then
        v33._snappedGrowthScale = nil
    end
end

v2._refreshNightScaleRange = _refreshNightScaleRange

function v2._createPresentation(v39) -- line 131 | captures: t, AreaEggCycle, Elapsed, SwapGradient, NightEggTimeSkip
    local PrimaryPart = v39._model.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    local v40 = (PrimaryPart.Size.X / 6.388999938964844 * (PrimaryPart.Size.Y / 7.507999897003174) * (PrimaryPart.Size.Z / 6.367000102996826)) ^ 0.3333333333333333 * 0.9
    local v41 = math.max(0.1, v40)
    local v42 = math.min(5, v41)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "NightEggTimeSkipAttachment"
    Attachment.Parent = PrimaryPart
    v39._visualTrove:Add(Attachment)
    local v43 = NightEggTimeSkip:Clone()
    local Main = v43.Main
    local Frame = Main:IsA("Frame")
    assert(Frame, "NightEggTimeSkip.Main must be a Frame")
    local v44
    for v45, v46 in Main:GetChildren() do
        if v46:IsA("Frame") then
            local v47 = v44 == nil
            assert(v47, "NightEggTimeSkip.Main must contain exactly one content Frame")
            v44 = v46
        end
    end
    local v48 = assert(v44, "NightEggTimeSkip.Main must contain a content Frame")
    local Timer = v48.Timer
    local Frame_2 = Timer:IsA("Frame")
    assert(Frame_2, "NightEggTimeSkip.Main.Frame.Timer must be a Frame")
    local Timer_2 = Timer.Timer
    local TextLabel = Timer_2:IsA("TextLabel")
    assert(TextLabel, "NightEggTimeSkip.Main.Frame.Timer.Timer must be a TextLabel")
    local Multiplier = Timer.Multiplier
    local TextLabel_2 = Multiplier:IsA("TextLabel")
    assert(TextLabel_2, "NightEggTimeSkip.Main.Frame.Timer.Multiplier must be a TextLabel")
    local DisplayName = v48.DisplayName
    local TextLabel_3 = DisplayName:IsA("TextLabel")
    assert(TextLabel_3, "NightEggTimeSkip.Main.Frame.DisplayName must be a TextLabel")
    DisplayName.Text = "Egg"
    SwapGradient(DisplayName, v39._rarityGradient)
    local Size = v43.Size
    local v49 = Size.Y.Scale * v42
    v43.Size = UDim2.new(Size.X.Scale * v42, Size.X.Offset * v42, v49, Size.Y.Offset * v42)
    v43.StudsOffsetWorldSpace = Vector3.new(0, -2, 0)
    v43.Adornee = Attachment
    v43.Parent = Attachment
    v39._billboard = v43
    v39._timerLabel = Timer_2
    v39._originalTextColor = Timer_2.TextColor3
    v39._visualTrove:Add(v43)
    local UIScale = Instance.new("UIScale")
    UIScale.Name = "NightEggTimeSkipScale"
    UIScale.Scale = 1
    UIScale.Parent = Timer_2
    v39._textScale = UIScale
    local _billboardTransparency = v39._billboardTransparency
    v39._visualTrove:Add(function() -- line 186 | captures: v43, _billboardTransparency
        _billboardTransparency(v43, 1, 0)
    end)
    _billboardTransparency(v43, 1, 1)
    local v50 = v39._remainingAtNightfall - v39._committedNightCreditSeconds + 0.5
    local v51 = math.floor(v50)
    local v52 = math.max(0, v51)
    if v52 == 0 then
        Timer_2.Text = "READY!"
    else
        Timer_2.Text = Elapsed(v52)
    end
    local v53 = AreaEggCycle.NightGrowthRate() * 10
    Multiplier.Text = ("(x%*)"):format(math.round(v53) / 10)
end

function v2._setAppliedSeconds(v54, v55) -- line 199 | captures: Elapsed
    local _skipSeconds = v54._skipSeconds
    local v56 = math.clamp(v55, 0, _skipSeconds)
    v54._appliedSeconds.Value = v56
    local v57 = v54._remainingAtNightfall - v54._committedNightCreditSeconds - v56 + 0.5
    local v58 = math.floor(v57)
    local v59 = math.max(0, v58)
    if v59 == v54._lastTimerSecond then
        return
    end
    v54._lastTimerSecond = v59
    local _timerLabel = v54._timerLabel
    if _timerLabel ~= nil then
        if v59 == 0 then
            _timerLabel.Text = "READY!"
        else
            _timerLabel.Text = Elapsed(v59)
        end
    end
end

function v2._applyShake(v60, v61, v62) -- line 218 | captures: EggActionMovement
    local v63 = v61 * 3.141592653589793 * 2 * 1.75
    local v64 = math.sin(v63) * 0.039269908169872414 * v62
    local v65 = v61 * 3.141592653589793 * 2 * 2.25
    local v66 = math.cos(v65) * 0.05672320068981571 * v62
    v60._lastShakeElapsed = v61
    v60._lastShakeAlpha = v62
    v60._lastShakePitch = v64
    v60._lastShakeRoll = v66
    EggActionMovement.SetPivot(v60._model, v60._basePivot * CFrame.Angles(v64, 0, v66))
end

function v2._updateModel(v67, v68) -- line 227 | captures: Ease, PlacedEggGrowthPresentationPolicy
    local _model = v67._model
    v67:_setAppliedSeconds((v67:_getAppliedSecondsAt(v68)))
    local v69 = PlacedEggGrowthPresentationPolicy.GetGrowthScaleDeltaSkipReason(v67._nightScaleStart, v67._nightScaleEnd)
    if v69 == nil then
        v67._snappedGrowthScale = nil
        _model:ScaleTo(v67:_getGrowthScaleAt(v68))
    elseif v67._snappedGrowthScale ~= v67._nightScaleEnd then
        _model:ScaleTo(v67._nightScaleEnd)
        v67._snappedGrowthScale = v67._nightScaleEnd
        PlacedEggGrowthPresentationPolicy.LogSkipped(v67._uid, "night growth scale channel", v69)
    end
    local v70 = v68 - v67._nightStartsAt
    local v71 = math.max(0, v70)
    local v72 = v71 / 5
    local v73 = math.clamp(v72, 0, 1)
    v67:_applyShake(v71, (Ease(v73, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))
    local _billboard = v67._billboard
    if _billboard == nil then
        v67._billboardFadeFinished = true
    else
        local v74 = v71 / 1
        local v75 = math.clamp(v74, 0, 1)
        local v76 = Ease(v75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        _billboard.StudsOffsetWorldSpace = Vector3.new(0, -2, 0):Lerp(Vector3.new(0, 0, 0), v76)
        v67._billboardTransparency(_billboard, 1, 1 - v76)
    end
end

function v2._fadeVisuals(v77) -- line 253 | captures: Ease, FrameStepper
    local _billboard = v77._billboard
    if _billboard == nil then
        v77._billboardFadeFinished = true
    else
        local _billboardTransparency = v77._billboardTransparency
        local _lastShakeElapsed = v77._lastShakeElapsed
        local _lastShakeAlpha = v77._lastShakeAlpha
        local v78 = FrameStepper.OnRender(function(v79, v80) -- line 263 | captures: v77, _billboard, _billboardTransparency, _lastShakeElapsed, _lastShakeAlpha, Ease
            if v77._destroyed then
                return true
            end
            local v81 = v80 * 5
            local v82 = v81 / 1
            local v83 = math.clamp(v82, 0, 1)
            local v84 = Ease(v83, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v85 = Ease(v80, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            _billboardTransparency(_billboard, 1, v84)
            if v83 >= 1 then
                v77._billboardFadeFinished = true
            end
            v77:_applyShake(_lastShakeElapsed + v81, _lastShakeAlpha * (1 - v85))
            return nil
        end, 5, true)
        v77._animation = v78
        v78:Wait()
        if v77._animation == v78 then
            v77._animation = nil
        end
    end
end

function v2._playTextFinish(v86) -- line 284 | captures: TweenService, v3, v4, v5
    local _timerLabel = v86._timerLabel
    local _textScale = v86._textScale
    local _originalTextColor = v86._originalTextColor
    if not (_timerLabel ~= nil and _textScale ~= nil and _originalTextColor ~= nil) then
        return
    end
    local v87 = TweenService:Create(_textScale, v3, { Scale = 1.5 })
    local v88 = TweenService:Create(_timerLabel, v5, { TextColor3 = Color3.new(1, 1, 1) })
    v86._visualTrove:Add(v87)
    v86._visualTrove:Add(v88)
    v87:Play()
    v88:Play()
    v87.Completed:Wait()
    if v86._destroyed then
        return
    end
    local v89 = TweenService:Create(_textScale, v4, { Scale = 1 })
    local v90 = TweenService:Create(_timerLabel, v5, { TextColor3 = _originalTextColor })
    v86._visualTrove:Add(v89)
    v86._visualTrove:Add(v90)
    v89:Play()
    v90:Play()
    v89.Completed:Wait()
    if not v86._destroyed then
        _timerLabel.TextColor3 = _originalTextColor
    end
end

function v2._finishVisuals(v91, v92) -- line 312 | captures: Workspace, EggActionMovement, FrameStepper
    if v91._visualFinishing or v91._visualFinished or v91._destroyed then
        return
    end
    v91._visualFinishing = true
    local _animation = v91._animation
    if _animation ~= nil then
        _animation:Cancel()
        v91._animation = nil
    end
    local v93
    if v92 then
        v93 = v91._skipSeconds
    else
        v93 = v91:_getAppliedSecondsAt(Workspace:GetServerTimeNow())
    end
    v91:_setAppliedSeconds(v93)
    if v92 then
        local _lastShakeElapsed = v91._lastShakeElapsed
        local _lastShakeAlpha = v91._lastShakeAlpha
        local v94 = FrameStepper.OnRender(function(v95, v96) -- line 332 | captures: v91, _lastShakeElapsed, _lastShakeAlpha
            if v91._destroyed then
                return true
            end
            v91:_applyShake(_lastShakeElapsed + v96, _lastShakeAlpha)
            return nil
        end)
        v91._animation = v94
        v91:_playTextFinish()
        v94:Cancel()
        if v91._animation == v94 then
            v91._animation = nil
        end
    end
    if not v91._destroyed then
        v91:_fadeVisuals()
    end
    if v91._destroyed then
        return
    end
    v91._lastShakeAlpha = 0
    v91._lastShakePitch = 0
    v91._lastShakeRoll = 0
    EggActionMovement.SetPivot(v91._model, v91._basePivot)
    v91._visualTrove:Clean()
    v91._billboard = nil
    v91._timerLabel = nil
    v91._textScale = nil
    v91._visualFinishing = false
    v91._visualFinished = true
end

function v2._start(v97) -- line 363 | captures: Workspace, EggRecords, FrameStepper
    v97:_createPresentation()
    local OnRender = FrameStepper.OnRender
    v97._animation = OnRender(function(v98, v99) -- line 365 | captures: v97, Workspace, EggRecords
        if not (v97._destroyed or v97._model.Parent == nil) then
            local v100 = Workspace:GetServerTimeNow()
            v97:_updateModel(v100)
            if EggRecords.GrowthSecondsRemaining(v97._record, v100, v97._growthSpeedMultiplier, v97._appliedSeconds.Value) > 0 then
                if v97._dayStartsAt <= v100 then
                    task.spawn(v97._finishVisuals, v97, true)
                    return true
                end
                return nil
            end
            if v100 < v97._dayStartsAt then
                task.spawn(v97._finishVisuals, v97, false)
            else
                if v100 < v97._dayStartsAt then
                    return nil
                end
                task.spawn(v97._finishVisuals, v97, true)
            end
        end
        return true
    end)
end

local function _init(v101) -- line 390
    v101:_start()
end

v2._init = _init

local function GetAppliedSecondsValue(v102) -- line 393
    return v102._appliedSeconds
end

v2.GetAppliedSecondsValue = GetAppliedSecondsValue

local function IsComplete(v103) -- line 396
    return v103._visualFinished and not v103._pendingCommit
end

v2.IsComplete = IsComplete

local function IsBillboardFadeFinished(v104) -- line 403
    return v104._billboardFadeFinished
end

v2.IsBillboardFadeFinished = IsBillboardFadeFinished

function v2.SetTransform(v105, v106, v107, v108) -- line 406 | captures: t, v1
    t.strict(t.CFrame)(v106)
    t.strict(v1)(v107)
    t.strict(v1)(v108)
    v105._basePivot = v106
    v105._startScale = v107
    v105._targetScale = v108
    v105:_refreshNightScaleRange()
end

function v2.AcknowledgeRecord(v109, v110) -- line 418 | captures: Workspace, AreaEggCycle, EggRecords, Eggs
    local v111 = Eggs.SchemaValidation.RuntimeEggRecord(v110)
    assert(v111, "Invalid runtime egg record")
    v109._record = v110
    v109._growthSpeedMultiplier = v110.GrowthSpeedMultiplier
    local Placement = v110.Placement
    local v112
    if Placement == nil then
        v112 = true
    elseif Placement.ReadyAt == nil then
        local v113 = EggRecords.CommittedNightCredit(v110, v109._nightPeriodIndex)
        v109._committedNightCreditSeconds = v113
        local v114 = EggRecords.GrowthSecondsRemaining(v110, v109._nightStartsAt, v109._growthSpeedMultiplier) + v113
        v109._remainingAtNightfall = v114
        local NightGrowthSkipSeconds = AreaEggCycle.NightGrowthSkipSeconds
        v109._nightTargetCreditSeconds = math.min(NightGrowthSkipSeconds, v114)
        local v115 = v109._nightTargetCreditSeconds - v113
        v109._skipSeconds = math.max(0, v115)
        v109:_refreshNightScaleRange()
        v109:_setAppliedSeconds(v109:_getAppliedSecondsAt(Workspace:GetServerTimeNow()))
        if v109._nightTargetCreditSeconds - 0.05 <= v113 then
            v109._pendingCommit = false
        end
        v112 = false
    else
        v112 = true
    end
    if not v112 then
        return
    end
    v109:_setAppliedSeconds(0)
    v109._pendingCommit = false
end

local function CancelVisual(v116) -- line 441
    if not (v116._visualFinished or v116._visualFinishing) then
        task.spawn(v116._finishVisuals, v116, false)
    end
end

v2.CancelVisual = CancelVisual

function v2.Destroy(v117) -- line 447 | captures: EggActionMovement
    if v117._destroyed then
        return
    end
    v117._destroyed = true
    local _animation = v117._animation
    if _animation ~= nil then
        _animation:Cancel()
        v117._animation = nil
    end
    v117._visualTrove:Destroy()
    v117._lifecycleTrove:Destroy()
    if v117._model.Parent ~= nil then
        EggActionMovement.SetPivot(v117._model, v117._basePivot)
    end
end

return v2
