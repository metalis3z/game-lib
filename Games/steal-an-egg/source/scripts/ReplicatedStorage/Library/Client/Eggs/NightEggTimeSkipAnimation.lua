-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local AreaEggResetTimeUtil = require(ReplicatedStorage.Library.Util.AreaEggResetTimeUtil)
local Assets = require(ReplicatedStorage.Directory.Assets)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggItemUtil = require(ReplicatedStorage.Library.Util.EggItemUtil)
local Eggs = require(ReplicatedStorage.Library.Types.Eggs)
local FormatDurationSymbol = require(ReplicatedStorage.Library.Functions.FormatDurationSymbol)
local GradientSwap = require(ReplicatedStorage.Library.Functions.GradientSwap)
local PlacedEggGrowthPresentationPolicy = require(script.Parent.PlacedEggGrowthPresentationPolicy)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local Transparency = require(ReplicatedStorage.Library.Functions.Transparency)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = {}

t.__index = t
t.__class = "NightEggTimeSkipAnimation"

local v1 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local v3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local NightEggTimeSkip = ReplicatedStorage.Assets.Billboards.NightEggTimeSkip

assert(NightEggTimeSkip:IsA("BillboardGui"), "ReplicatedStorage.Assets.Billboards.NightEggTimeSkip must be a BillboardGui")
function t.new(p1, p2, p3, p4, p5, p6, p7, p8) --[[ new | Line: 112 | Upvalues: Asserts (copy), Eggs (copy), Assets (copy), AreaEggResetTimeUtil (copy), EggItemUtil (copy), t (copy), Transparency (copy), Trove (copy) ]]
	Asserts.Model(p1)
	Asserts.string(p2)
	assert(Eggs.SchemaValidation.RuntimeEggRecord(p3), "Invalid runtime egg record")
	Asserts.CFrame(p4)
	Asserts.finite(p5)
	Asserts.finite(p6)
	Asserts.finite(p7)
	Asserts.finite(p8)
	assert(if p5 > 0 then if p6 > 0 then true else false else false, "Egg time skip scales must be positive")
	assert(if p7 < p8 then true else false, "Egg time skip day start must follow night start")
	assert(p3.Placement, "Night egg time skip requires a placed egg")

	local v4 = Assets.Directory[p3.AssetCategory]

	assert(if v4 == nil then false else true, (("Missing asset config for category %*"):format(p3.AssetCategory)))

	local GrowthSpeedMultiplier = p3.GrowthSpeedMultiplier
	local v7 = AreaEggResetTimeUtil.GetPeriodIndex(p8)
	local v8 = EggItemUtil.GetCommittedNightGrowthCreditSeconds(p3, v7)
	local v9 = EggItemUtil.GetRemainingGrowthSeconds(p3, p7, GrowthSpeedMultiplier) + v8
	local v10 = math.min(AreaEggResetTimeUtil.NightGrowthSkipSeconds, v9)
	local v12 = setmetatable({}, t)

	v12._model = p1
	v12._uid = p2
	v12._record = p3
	v12._basePivot = p4
	v12._startScale = p5
	v12._targetScale = p6
	v12._growthSpeedMultiplier = GrowthSpeedMultiplier
	v12._nightStartsAt = p7
	v12._dayStartsAt = p8
	v12._nightPeriodIndex = v7
	v12._nightTargetCreditSeconds = v10
	v12._committedNightCreditSeconds = v8
	v12._skipSeconds = math.max(0, v10 - v8)
	v12._remainingAtNightfall = v9
	v12._nightScaleStart = p5
	v12._nightScaleEnd = p6
	v12._snappedGrowthScale = nil
	assert(if v12._skipSeconds > 0 then true else false, "Night egg time skip requires remaining growth time")
	v12._appliedSeconds = Instance.new("NumberValue")
	v12._billboardTransparency = Transparency()
	v12._lifecycleTrove = Trove.new()
	v12._visualTrove = Trove.new()
	v12._animation = nil
	v12._visualFinishing = false
	v12._visualFinished = false
	v12._billboardFadeFinished = false
	v12._pendingCommit = true
	v12._destroyed = false
	v12._lastTimerSecond = -1
	v12._lastShakeElapsed = 0
	v12._lastShakeAlpha = 0
	v12._lastShakePitch = 0
	v12._lastShakeRoll = 0
	v12._billboard = nil
	v12._timerLabel = nil
	v12._textScale = nil
	v12._originalTextColor = nil
	v12._rarityGradient = v4.Rarity.Gradient
	v12:_refreshNightScaleRange()
	v12._lifecycleTrove:Add(v12._appliedSeconds)
	v12:_init()

	return v12
end
function t._getAppliedSecondsAt(p1, p2) --[[ _getAppliedSecondsAt | Line: 192 | Upvalues: EggItemUtil (copy) ]]
	return EggItemUtil.GetNightGrowthCreditSecondsAt(p1._record, p2, p1._growthSpeedMultiplier, p1._nightStartsAt, p1._nightPeriodIndex)
end
function t._getGrowthScaleAt(p1, p2) --[[ _getGrowthScaleAt | Line: 202 | Upvalues: EggItemUtil (copy) ]]
	return math.lerp(p1._startScale, p1._targetScale, (EggItemUtil.GetGrowthAlpha(p1._record, p2, p1._growthSpeedMultiplier, p1:_getAppliedSecondsAt(p2))))
end
function t._refreshNightScaleRange(p1) --[[ _refreshNightScaleRange | Line: 208 ]]
	local v1 = p1:_getGrowthScaleAt(p1._nightStartsAt)
	local v2 = p1:_getGrowthScaleAt(p1._dayStartsAt)
	local v4 = if math.abs(p1._nightScaleStart - v1) > 0.001 then true elseif math.abs(p1._nightScaleEnd - v2) > 0.001 then true else false

	p1._nightScaleStart = v1
	p1._nightScaleEnd = v2

	if not v4 then
		return
	end

	p1._snappedGrowthScale = nil
end
function t._createPresentation(p1) --[[ _createPresentation | Line: 220 | Upvalues: Asserts (copy), NightEggTimeSkip (copy), GradientSwap (copy), FormatDurationSymbol (copy), AreaEggResetTimeUtil (copy) ]]
	local PrimaryPart = p1._model.PrimaryPart

	Asserts.BasePart(PrimaryPart)

	local v3 = math.min(5, (math.max(0.1, (PrimaryPart.Size.X / 6.388999938964844 * (PrimaryPart.Size.Y / 7.507999897003174) * (PrimaryPart.Size.Z / 6.367000102996826)) ^ 0.3333333333333333 * 0.9)))
	local NightEggTimeSkipAttachment = Instance.new("Attachment")

	NightEggTimeSkipAttachment.Name = "NightEggTimeSkipAttachment"
	NightEggTimeSkipAttachment.Parent = PrimaryPart
	p1._visualTrove:Add(NightEggTimeSkipAttachment)

	local v4 = NightEggTimeSkip:Clone()
	local Main = v4.Main

	assert(Main:IsA("Frame"), "NightEggTimeSkip.Main must be a Frame")

	local v6 = nil

	for v7, v8 in Main:GetChildren() do
		if v8:IsA("Frame") then
			assert(v6 == nil, "NightEggTimeSkip.Main must contain exactly one content Frame")
			v6 = v8
		end
	end

	local v10 = assert(v6, "NightEggTimeSkip.Main must contain a content Frame")
	local Timer = v10.Timer

	assert(Timer:IsA("Frame"), "NightEggTimeSkip.Main.Frame.Timer must be a Frame")

	local Timer2 = Timer.Timer

	assert(Timer2:IsA("TextLabel"), "NightEggTimeSkip.Main.Frame.Timer.Timer must be a TextLabel")

	local Multiplier = Timer.Multiplier

	assert(Multiplier:IsA("TextLabel"), "NightEggTimeSkip.Main.Frame.Timer.Multiplier must be a TextLabel")

	local DisplayName = v10.DisplayName

	assert(DisplayName:IsA("TextLabel"), "NightEggTimeSkip.Main.Frame.DisplayName must be a TextLabel")
	DisplayName.Text = "Egg"
	GradientSwap(DisplayName, p1._rarityGradient)

	local Size = v4.Size

	v4.Size = UDim2.new(Size.X.Scale * v3, Size.X.Offset * v3, Size.Y.Scale * v3, Size.Y.Offset * v3)
	v4.StudsOffsetWorldSpace = Vector3.new(0, -2, 0)
	v4.Adornee = NightEggTimeSkipAttachment
	v4.Parent = NightEggTimeSkipAttachment
	p1._billboard = v4
	p1._timerLabel = Timer2
	p1._originalTextColor = Timer2.TextColor3
	p1._visualTrove:Add(v4)

	local NightEggTimeSkipScale = Instance.new("UIScale")

	NightEggTimeSkipScale.Name = "NightEggTimeSkipScale"
	NightEggTimeSkipScale.Scale = 1
	NightEggTimeSkipScale.Parent = Timer2
	p1._textScale = NightEggTimeSkipScale

	local _billboardTransparency = p1._billboardTransparency

	p1._visualTrove:Add(function() --[[ Line: 282 | Upvalues: _billboardTransparency (copy), v4 (copy) ]]
		_billboardTransparency(v4, 1, 0)
	end)
	_billboardTransparency(v4, 1, 1)

	local v17 = math.max(0, (math.floor(p1._remainingAtNightfall - p1._committedNightCreditSeconds + 0.5)))

	Timer2.Text = if v17 == 0 then "READY!" else FormatDurationSymbol(v17)
	Multiplier.Text = ("(x%*)"):format(math.round(AreaEggResetTimeUtil.NightGrowthBonusRate * 10) / 10)
end
function t._setAppliedSeconds(p1, p2) --[[ _setAppliedSeconds | Line: 292 | Upvalues: FormatDurationSymbol (copy) ]]
	local v1 = math.clamp(p2, 0, p1._skipSeconds)

	p1._appliedSeconds.Value = v1

	local v4 = math.max(0, (math.floor(p1._remainingAtNightfall - p1._committedNightCreditSeconds - v1 + 0.5)))

	if v4 == p1._lastTimerSecond then
		return
	end

	p1._lastTimerSecond = v4

	local _timerLabel = p1._timerLabel

	if _timerLabel == nil then
		return
	end

	_timerLabel.Text = if v4 == 0 then "READY!" else FormatDurationSymbol(v4)
end
function t._applyShake(p1, p2, p3) --[[ _applyShake | Line: 308 | Upvalues: EggActionMovement (copy) ]]
	local v1 = math.sin(p2 * math.pi * 2 * 1.75) * 0.039269908169872414 * p3
	local v2 = math.cos(p2 * math.pi * 2 * 2.25) * 0.05672320068981571 * p3

	p1._lastShakeElapsed = p2
	p1._lastShakeAlpha = p3
	p1._lastShakePitch = v1
	p1._lastShakeRoll = v2
	EggActionMovement.SetPivot(p1._model, p1._basePivot * CFrame.Angles(v1, 0, v2))
end
function t._updateModel(p1, p2) --[[ _updateModel | Line: 318 | Upvalues: PlacedEggGrowthPresentationPolicy (copy), Easing (copy) ]]
	local _model = p1._model

	p1:_setAppliedSeconds((p1:_getAppliedSecondsAt(p2)))

	local v1 = PlacedEggGrowthPresentationPolicy.GetGrowthScaleDeltaSkipReason(p1._nightScaleStart, p1._nightScaleEnd)

	if v1 == nil then
		p1._snappedGrowthScale = nil
		_model:ScaleTo(p1:_getGrowthScaleAt(p2))
	elseif p1._snappedGrowthScale ~= p1._nightScaleEnd then
		_model:ScaleTo(p1._nightScaleEnd)
		p1._snappedGrowthScale = p1._nightScaleEnd
		PlacedEggGrowthPresentationPolicy.LogSkipped(p1._uid, "night growth scale channel", v1)
	end

	local v3 = math.max(0, p2 - p1._nightStartsAt)

	p1:_applyShake(v3, (Easing(math.clamp(v3 / 5, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))

	local _billboard = p1._billboard

	if _billboard == nil then
		p1._billboardFadeFinished = true
	else
		local v4 = Easing(math.clamp(v3 / 1, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		_billboard.StudsOffsetWorldSpace = (Vector3.new(0, -2, 0)):Lerp(Vector3.new(0, 0, 0), v4)
		p1._billboardTransparency(_billboard, 1, 1 - v4)
	end
end
function t._fadeVisuals(p1) --[[ _fadeVisuals | Line: 351 | Upvalues: RenderStepped (copy), Easing (copy) ]]
	local _billboard = p1._billboard

	if _billboard == nil then
		p1._billboardFadeFinished = true

		return
	end

	local _billboardTransparency = p1._billboardTransparency
	local _lastShakeElapsed = p1._lastShakeElapsed
	local _lastShakeAlpha = p1._lastShakeAlpha
	local v1 = RenderStepped(function(p12, p2) --[[ Line: 360 | Upvalues: p1 (copy), Easing (ref), _billboardTransparency (copy), _billboard (copy), _lastShakeElapsed (copy), _lastShakeAlpha (copy) ]]
		if p1._destroyed then
			return true
		end

		local v1 = p2 * 5
		local v2 = math.clamp(v1 / 1, 0, 1)
		local v3 = Easing(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v4 = Easing(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		_billboardTransparency(_billboard, 1, v3)

		if not (v2 >= 1) then
			p1:_applyShake(_lastShakeElapsed + v1, _lastShakeAlpha * (1 - v4))

			return nil
		end

		p1._billboardFadeFinished = true
		p1:_applyShake(_lastShakeElapsed + v1, _lastShakeAlpha * (1 - v4))

		return nil
	end, 5, true)

	p1._animation = v1
	v1:Wait()

	if p1._animation ~= v1 then
		return
	end

	p1._animation = nil
end
function t._playTextFinish(p1) --[[ _playTextFinish | Line: 382 | Upvalues: TweenService (copy), v1 (copy), v3 (copy), v2 (copy) ]]
	local _timerLabel = p1._timerLabel
	local _textScale = p1._textScale
	local _originalTextColor = p1._originalTextColor

	if _timerLabel == nil or (_textScale == nil or _originalTextColor == nil) then
		return
	end

	local v12 = TweenService:Create(_textScale, v1, {
		Scale = 1.5
	})
	local v22 = TweenService:Create(_timerLabel, v3, {
		TextColor3 = Color3.new(255/255, 255/255, 255/255)
	})

	p1._visualTrove:Add(v12)
	p1._visualTrove:Add(v22)
	v12:Play()
	v22:Play()
	v12.Completed:Wait()

	if p1._destroyed then
		return
	end

	local v32 = TweenService:Create(_textScale, v2, {
		Scale = 1
	})
	local v4 = TweenService:Create(_timerLabel, v3, {
		TextColor3 = _originalTextColor
	})

	p1._visualTrove:Add(v32)
	p1._visualTrove:Add(v4)
	v32:Play()
	v4:Play()
	v32.Completed:Wait()

	if p1._destroyed then
		return
	end

	_timerLabel.TextColor3 = _originalTextColor
end
function t._finishVisuals(p1, p2) --[[ _finishVisuals | Line: 413 | Upvalues: Workspace (copy), RenderStepped (copy), EggActionMovement (copy) ]]
	if p1._visualFinishing or (p1._visualFinished or p1._destroyed) then
		return
	end

	p1._visualFinishing = true

	local _animation = p1._animation

	if _animation ~= nil then
		_animation:Disconnect()
		p1._animation = nil
	end

	p1:_setAppliedSeconds(if p2 then p1._skipSeconds else p1:_getAppliedSecondsAt(Workspace:GetServerTimeNow()))

	if p2 then
		local _lastShakeElapsed = p1._lastShakeElapsed
		local _lastShakeAlpha = p1._lastShakeAlpha
		local v2 = RenderStepped(function(p12, p2) --[[ Line: 430 | Upvalues: p1 (copy), _lastShakeElapsed (copy), _lastShakeAlpha (copy) ]]
			if p1._destroyed then
				return true
			end

			p1:_applyShake(_lastShakeElapsed + p2, _lastShakeAlpha)

			return nil
		end)

		p1._animation = v2
		p1:_playTextFinish()
		v2:Disconnect()

		if p1._animation == v2 then
			p1._animation = nil
		end
	end

	if not p1._destroyed then
		p1:_fadeVisuals()
	end

	if not p1._destroyed then
		p1._lastShakeAlpha = 0
		p1._lastShakePitch = 0
		p1._lastShakeRoll = 0
		EggActionMovement.SetPivot(p1._model, p1._basePivot)
		p1._visualTrove:Clean()
		p1._billboard = nil
		p1._timerLabel = nil
		p1._textScale = nil
		p1._visualFinishing = false
		p1._visualFinished = true
	end
end
function t._start(p1) --[[ _start | Line: 463 | Upvalues: RenderStepped (copy), Workspace (copy), EggItemUtil (copy) ]]
	p1:_createPresentation()
	p1._animation = RenderStepped(function(p12, p2) --[[ Line: 465 | Upvalues: p1 (copy), Workspace (ref), EggItemUtil (ref) ]]
		if p1._destroyed or p1._model.Parent == nil then
			return true
		end

		local v1 = Workspace:GetServerTimeNow()

		p1:_updateModel(v1)

		if EggItemUtil.GetRemainingGrowthSeconds(p1._record, v1, p1._growthSpeedMultiplier, p1._appliedSeconds.Value) <= 0 and v1 < p1._dayStartsAt then
			task.spawn(p1._finishVisuals, p1, false)

			return true
		end

		if p1._dayStartsAt <= v1 then
			task.spawn(p1._finishVisuals, p1, true)

			return true
		end

		return nil
	end)
end
function t._init(p1) --[[ _init | Line: 490 ]]
	p1:_start()
end
function t.GetAppliedSecondsValue(p1) --[[ GetAppliedSecondsValue | Line: 498 ]]
	return p1._appliedSeconds
end
function t.IsComplete(p1) --[[ IsComplete | Line: 502 ]]
	return p1._visualFinished and not p1._pendingCommit
end
function t.IsBillboardFadeFinished(p1) --[[ IsBillboardFadeFinished | Line: 506 ]]
	return p1._billboardFadeFinished
end
function t.SetTransform(p1, p2, p3, p4) --[[ SetTransform | Line: 510 | Upvalues: Asserts (copy) ]]
	Asserts.CFrame(p2)
	Asserts.finite(p3)
	Asserts.finite(p4)
	p1._basePivot = p2
	p1._startScale = p3
	p1._targetScale = p4
	p1:_refreshNightScaleRange()
end
function t.AcknowledgeRecord(p1, p2) --[[ AcknowledgeRecord | Line: 525 | Upvalues: Eggs (copy), EggItemUtil (copy), AreaEggResetTimeUtil (copy), Workspace (copy) ]]
	assert(Eggs.SchemaValidation.RuntimeEggRecord(p2), "Invalid runtime egg record")
	p1._record = p2
	p1._growthSpeedMultiplier = p2.GrowthSpeedMultiplier

	local Placement = p2.Placement

	if Placement == nil or Placement.ReadyAt ~= nil then
		p1:_setAppliedSeconds(0)
		p1._pendingCommit = false

		return
	end

	local v2 = EggItemUtil.GetCommittedNightGrowthCreditSeconds(p2, p1._nightPeriodIndex)

	p1._committedNightCreditSeconds = v2

	local v3 = EggItemUtil.GetRemainingGrowthSeconds(p2, p1._nightStartsAt, p1._growthSpeedMultiplier) + v2

	p1._remainingAtNightfall = v3
	p1._nightTargetCreditSeconds = math.min(AreaEggResetTimeUtil.NightGrowthSkipSeconds, v3)
	p1._skipSeconds = math.max(0, p1._nightTargetCreditSeconds - v2)
	p1:_refreshNightScaleRange()
	p1:_setAppliedSeconds(p1:_getAppliedSecondsAt(Workspace:GetServerTimeNow()))

	if not (p1._nightTargetCreditSeconds - 0.05 <= v2) then
		return
	end

	p1._pendingCommit = false
end
function t.CancelVisual(p1) --[[ CancelVisual | Line: 553 ]]
	if not (p1._visualFinished or p1._visualFinishing) then
		task.spawn(p1._finishVisuals, p1, false)
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 560 | Upvalues: EggActionMovement (copy) ]]
	if p1._destroyed then
		return
	end

	p1._destroyed = true

	local _animation = p1._animation

	if _animation ~= nil then
		_animation:Disconnect()
		p1._animation = nil
	end

	p1._visualTrove:Destroy()
	p1._lifecycleTrove:Destroy()

	if p1._model.Parent == nil then
		return
	end

	EggActionMovement.SetPivot(p1._model, p1._basePivot)
end

return t