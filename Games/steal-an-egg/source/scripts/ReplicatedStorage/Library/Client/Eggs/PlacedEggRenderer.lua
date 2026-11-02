-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Types.AreaEggResetCycle)

local AreaEggResetTimeUtil = require(ReplicatedStorage.Library.Util.AreaEggResetTimeUtil)
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local EggHatchAnimation = require(script.Parent.EggHatchAnimation)
local EggGrowthAnimation = require(script.Parent.EggGrowthAnimation)
local EggItemUtil = require(ReplicatedStorage.Library.Util.EggItemUtil)
local EggRenderer = require(script.Parent.EggRenderer)
local EggSkipAnimation = require(script.Parent.EggSkipAnimation)

require(ReplicatedStorage.Library.Types.Eggs)

local Lock = require(ReplicatedStorage.Library.Functions.Lock)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local NightEggTimeSkipAnimation = require(script.Parent.NightEggTimeSkipAnimation)
local PlacedEggBillboard = require(script.Parent.PlacedEggBillboard)
local PlacedEggGrowthPresentationPolicy = require(script.Parent.PlacedEggGrowthPresentationPolicy)
local PlacedEggReadyPulse = require(script.Parent.PlacedEggReadyPulse)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local Products = require(ReplicatedStorage.Directory.Products)
local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local SmartProximityPrompt = require(ReplicatedStorage.Library.Client.SmartProximityPrompt)
local ModelCameraOcclusionController = require(ReplicatedStorage.Library.Client.ModelCameraOcclusionController)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(script.Parent.Types)

local EggPlaceAnimation = require(script.Parent.EggPlaceAnimation)

require(ReplicatedStorage.Library.Types.Plots)

local v1 = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local t = {}
local v3 = 0
local v4 = Random.new()
local v5 = Random.new()
local v6 = nil
local v7 = false
local PlacedEggRenders = Instance.new("Folder")

PlacedEggRenders.Name = "PlacedEggRenders"
PlacedEggRenders.Parent = workspace

local v8 = Log.new()
local t2 = {
	LocalEggHatchStarted = Signal.new()
}
local GetDirectGrowthTweenRemainingSeconds = PlacedEggGrowthPresentationPolicy.GetDirectGrowthTweenRemainingSeconds
local GetStartScale = PlacedEggGrowthPresentationPolicy.GetStartScale
local GetTargetScale = PlacedEggGrowthPresentationPolicy.GetTargetScale
local GetVisualScale = PlacedEggGrowthPresentationPolicy.GetVisualScale
local IsReady = PlacedEggGrowthPresentationPolicy.IsReady
local GetRemainingGrowthSeconds = PlacedEggGrowthPresentationPolicy.GetRemainingGrowthSeconds

local function getKey(p1, p2) --[[ getKey | Line: 112 ]]
	return ("%*:%*"):format(p1, p2)
end

local function getOwnerPlayer(p1) --[[ getOwnerPlayer | Line: 116 | Upvalues: Players (copy) ]]
	return Players:GetPlayerByUserId(p1)
end

local function readOwnerPlotData(p1) --[[ readOwnerPlotData | Line: 120 | Upvalues: Players (copy), PlotCmds (copy) ]]
	local v1 = Players:GetPlayerByUserId(p1)

	if v1 == nil then
		return nil
	end

	return PlotCmds.GetPlotData(v1)
end

local function isLocalOwner(p1) --[[ isLocalOwner | Line: 129 | Upvalues: Players (copy) ]]
	return p1 == Players.LocalPlayer.UserId
end

local function getNextReadyPulseAt(p1) --[[ getNextReadyPulseAt | Line: 133 | Upvalues: v4 (copy) ]]
	return p1 + v4:NextNumber(5, 10)
end

local function getNextGrowthPulseAt(p1) --[[ getNextGrowthPulseAt | Line: 137 | Upvalues: v5 (copy) ]]
	return p1 + v5:NextNumber(27, 65)
end

local function getInitialGrowthUpdateAt(p1) --[[ getInitialGrowthUpdateAt | Line: 141 | Upvalues: v3 (ref) ]]
	local v1 = p1 + v3 * 0.2

	v3 = (v3 + 1) % 25

	return v1
end

local function getNightTimeSkipSecondsValue(p1) --[[ getNightTimeSkipSecondsValue | Line: 147 ]]
	local NightTimeSkipAnimation = p1.NightTimeSkipAnimation

	if NightTimeSkipAnimation == nil then
		return nil
	end

	return NightTimeSkipAnimation:GetAppliedSecondsValue()
end

local function getNightTimeSkipSeconds(p1) --[[ getNightTimeSkipSeconds | Line: 152 ]]
	local NightTimeSkipAnimation = p1.NightTimeSkipAnimation
	local v1 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()

	if v1 == nil then
		return 0
	end

	return v1.Value
end

local function isNightTimeSkipControllingPresentation(p1) --[[ isNightTimeSkipControllingPresentation | Line: 157 ]]
	local NightTimeSkipAnimation = p1.NightTimeSkipAnimation

	return if NightTimeSkipAnimation == nil then false else not NightTimeSkipAnimation:IsComplete()
end

local function clearNightTimeSkipAnimation(p1) --[[ clearNightTimeSkipAnimation | Line: 162 | Upvalues: PlacedEggBillboard (copy) ]]
	local NightTimeSkipAnimation = p1.NightTimeSkipAnimation

	if NightTimeSkipAnimation == nil then
		return
	end

	p1.NightTimeSkipAnimation = nil

	if p1.NightBillboardSuppressed then
		p1.NightBillboardSuppressed = false
		PlacedEggBillboard.SetNightPresentationActive(p1.OwnerUserId, p1.Uid, false)
	end

	NightTimeSkipAnimation:Destroy()

	local ScaleValue = p1.ScaleValue

	if ScaleValue == nil or p1.Result.Model.Parent == nil then
		return
	end

	ScaleValue.Value = p1.Result.Model:GetScale()
end

local function startNightTimeSkipForState(p1, p2) --[[ startNightTimeSkipForState | Line: 180 | Upvalues: Players (copy), AreaEggResetTimeUtil (copy), EggItemUtil (copy), Workspace (copy), NightEggTimeSkipAnimation (copy), PlacedEggBillboard (copy) ]]
	if not (if p1.OwnerUserId == Players.LocalPlayer.UserId then true else false) or (p1.IsHatching or (p1.Result.Model.Parent == nil or p1.NightTimeSkipAnimation ~= nil)) then
		return
	end

	local Placement = p1.Record.Placement
	local v2 = p2 - AreaEggResetTimeUtil.NightDurationSeconds

	if Placement == nil or (Placement.ReadyAt ~= nil or v2 < Placement.PlacedAt) then
		return
	end

	if EggItemUtil.IsGrowthReady(p1.Record, v2, p1.Record.GrowthSpeedMultiplier) then
		return
	end

	if p2 <= Workspace:GetServerTimeNow() then
		return
	end

	local GrowthAnimation = p1.GrowthAnimation

	if GrowthAnimation ~= nil then
		GrowthAnimation:Cancel()
	end

	local ReadyPulse = p1.ReadyPulse

	if ReadyPulse ~= nil then
		ReadyPulse:Cancel()
	end

	local ScaleTween = p1.ScaleTween

	if ScaleTween ~= nil then
		ScaleTween:Cancel()
		p1.ScaleTween = nil
		p1.DirectGrowthTweenActive = false
	end

	local v3 = NightEggTimeSkipAnimation.new(p1.Result.Model, p1.Uid, p1.Record, p1.BasePivot, p1.StartScale, p1.TargetScale, v2, p2)

	p1.NightTimeSkipAnimation = v3
	PlacedEggBillboard.SetEntry({
		OwnerUserId = p1.OwnerUserId,
		Uid = p1.Uid,
		Record = p1.Record,
		Model = p1.Result.Model,
		TimeSkipSeconds = v3:GetAppliedSecondsValue()
	})
	p1.NightBillboardSuppressed = true
	PlacedEggBillboard.SetNightPresentationActive(p1.OwnerUserId, p1.Uid, true)
end

local function startNightTimeSkip(p1) --[[ startNightTimeSkip | Line: 239 | Upvalues: v6 (ref), t (copy), startNightTimeSkipForState (copy) ]]
	v6 = p1.DayStartsAt

	for k, v in pairs(t) do
		startNightTimeSkipForState(v, p1.DayStartsAt)
	end
end

local function setStateScale(p1, p2, p3, p4, p5) --[[ setStateScale | Line: 246 | Upvalues: Players (copy), EggRenderer (copy), TweenService (copy), v1 (copy) ]]
	if not (if p1.OwnerUserId == Players.LocalPlayer.UserId then true else false) then
		p1.Result.Model:ScaleTo(p2)
		EggRenderer.ApplyPlacedCollisionPolicy(p1.Result.Model)

		return false
	end

	local ScaleValue = p1.ScaleValue

	if ScaleValue == nil then
		p1.Result.Model:ScaleTo(p2)
		EggRenderer.ApplyPlacedCollisionPolicy(p1.Result.Model)

		return false
	end

	local ScaleTween = p1.ScaleTween
	local v2 = if ScaleTween == nil then false else true

	if ScaleTween ~= nil then
		ScaleTween:Cancel()
		p1.ScaleTween = nil
		p1.DirectGrowthTweenActive = false
	end

	if p4 == false then
		if p5 == true then
			p1.DirectGrowthTweenActive = true
		end

		local v4 = if math.abs(ScaleValue.Value - p2) > 0.001 then true else false

		if not v4 then
			return v2 or v4
		end

		ScaleValue.Value = p2

		return v2 or v4
	end

	if math.abs(ScaleValue.Value - p2) <= 0.001 then
		if p5 ~= true then
			return false
		end

		p1.DirectGrowthTweenActive = true
	else
		local v8 = TweenService:Create(ScaleValue, if p3 then p3 else v1, {
			Value = p2
		})

		p1.ScaleTween = v8
		p1.DirectGrowthTweenActive = p5 == true
		v8.Completed:Once(function() --[[ Line: 297 | Upvalues: p1 (copy), v8 (copy), p5 (copy) ]]
			if p1.ScaleTween ~= v8 then
				return
			end

			p1.ScaleTween = nil

			if p5 ~= true then
				return
			end

			p1.DirectGrowthTweenActive = false
		end)
		v8:Play()
	end

	return false
end

local function startDirectGrowthTween(p1, p2) --[[ startDirectGrowthTween | Line: 309 | Upvalues: setStateScale (copy) ]]
	setStateScale(p1, p1.TargetScale, TweenInfo.new(math.max(p2, 0.05), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), true, true)
end

local function updatePrompt(p1) --[[ updatePrompt | Line: 318 | Upvalues: IsReady (copy), Products (copy), GetRemainingGrowthSeconds (copy), v7 (ref) ]]
	local Prompt = p1.Prompt

	if Prompt == nil then
		return
	end

	local NightTimeSkipAnimation = p1.NightTimeSkipAnimation
	local v1 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()
	local v3 = if v1 == nil then 0 else v1.Value
	local v4 = IsReady(p1.Record, v3)
	local v5 = if v4 then "Hatch!" else "Skip Growth!"

	Prompt.Enabled = not v7 and (not p1.IsHatching and (if v4 then v4 elseif Products.GetEggSkipGrowthProduct(GetRemainingGrowthSeconds(p1.Record, v3)) == nil then false else true))
	Prompt.ActionText = v5
	Prompt.ObjectText = v5
end

local function trackOcclusion(p1) --[[ trackOcclusion | Line: 335 | Upvalues: ModelCameraOcclusionController (copy) ]]
	assert(not p1.OcclusionTracked, (("Placed egg %* occlusion is already tracked"):format(p1.Uid)))
	ModelCameraOcclusionController.TrackModel(p1.Result.Model, 1)
	p1.OcclusionTracked = true
end

local function untrackOcclusion(p1) --[[ untrackOcclusion | Line: 341 | Upvalues: ModelCameraOcclusionController (copy) ]]
	if p1.OcclusionTracked then
		ModelCameraOcclusionController.UntrackModel(p1.Result.Model)
		p1.OcclusionTracked = false
	end
end

local v9 = nil
local v10 = nil

local function activatePrompt(p1) --[[ activatePrompt | Line: 353 | Upvalues: IsReady (copy), ModelCameraOcclusionController (copy), updatePrompt (copy), EggCmds (copy), v8 (copy), Players (copy), t2 (copy), EggHatchAnimation (copy), v9 (ref), v10 (ref), PromptPurchase (copy) ]]
	local ReadyPulse = p1.ReadyPulse

	if ReadyPulse == nil then
		return false, "Egg is not owned by the local player"
	end

	local NightTimeSkipAnimation = p1.NightTimeSkipAnimation
	local v2 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()

	if IsReady(p1.Record, if v2 == nil then 0 else v2.Value) then
		if p1.HatchLock(function() --[[ Line: 361 | Upvalues: p1 (copy), ModelCameraOcclusionController (ref), ReadyPulse (copy), updatePrompt (ref), EggCmds (ref), v8 (ref), Players (ref), t2 (ref), EggHatchAnimation (ref), v9 (ref), v10 (ref) ]]
			p1.IsHatching = true

			local v1 = p1

			if v1.OcclusionTracked then
				ModelCameraOcclusionController.UntrackModel(v1.Result.Model)
				v1.OcclusionTracked = false
			end

			p1.NextReadyPulseAt = nil
			ReadyPulse:Cancel()
			updatePrompt(p1)

			local v2, v3 = EggCmds.RequestHatchEgg(p1.Uid)

			if not v2 then
				p1.IsHatching = false

				local v4 = p1

				assert(not v4.OcclusionTracked, (("Placed egg %* occlusion is already tracked"):format(v4.Uid)))
				ModelCameraOcclusionController.TrackModel(v4.Result.Model, 1)
				v4.OcclusionTracked = true
				updatePrompt(p1)
				v8:AtWarning():Log((("Failed to hatch egg %*: %*"):format(p1.Uid, v3 or "unknown")))

				return
			end

			if p1.OwnerUserId == Players.LocalPlayer.UserId then
				t2.LocalEggHatchStarted:Fire(p1.Uid)
			end

			local v7 = EggHatchAnimation.Play(p1.OwnerUserId, p1.Uid, p1.Record, p1.Result.Model)
			local v82, v92, v102 = EggCmds.RequestCompleteHatchEgg(p1.Uid)

			if not v82 then
				v8:AtWarning():Log((("Failed to complete hatch for egg %*: %*"):format(p1.Uid, v92 or "unknown")))
				v9((("%*:%*"):format(p1.OwnerUserId, p1.Uid)))
				v10(p1.OwnerUserId)

				return
			end

			if v7 == nil then
				return
			end

			EggHatchAnimation.FadeSoundWhenGrantedToolUnequips(v7, (assert(v102, "Successful hatch completion must return the granted asset UID")))
		end) then
			return true
		end

		v8:AtDebug():Log((("Ignored duplicate hatch prompt for egg %*"):format(p1.Uid)))

		return false, "Egg is already hatching"
	end

	local v5, v6, v7 = EggCmds.RequestSkipGrowth(p1.Uid)

	if v5 and v7 then
		PromptPurchase.Prompt(v7, true)

		return true
	end

	v8:AtWarning():Log((("Failed to request skip growth for egg %*: %*"):format(p1.Uid, v6 or "unknown")))

	return false, v6
end

v9 = function(p1) --[[ Line: 409 | Upvalues: t (copy), ModelCameraOcclusionController (copy), clearNightTimeSkipAnimation (copy), PlacedEggBillboard (copy) ]]
	local v1 = t[p1]

	if v1 == nil then
		return
	end

	if v1.OcclusionTracked then
		ModelCameraOcclusionController.UntrackModel(v1.Result.Model)
		v1.OcclusionTracked = false
	end

	t[p1] = nil
	clearNightTimeSkipAnimation(v1)
	PlacedEggBillboard.RemoveEntry(v1.OwnerUserId, v1.Uid)
	v1.Trove:Destroy()
end

local function destroyOwnerStates(p1) --[[ destroyOwnerStates | Line: 422 | Upvalues: t (copy), v9 (ref) ]]
	for k, v in pairs(t) do
		if v.OwnerUserId == p1 then
			v9(k)
		end
	end
end

local function addPlacedEggRenderState(p1, p2, p3) --[[ addPlacedEggRenderState | Line: 430 | Upvalues: Players (copy), PlotCmds (copy), Trove (copy), GetStartScale (copy), GetTargetScale (copy), GetVisualScale (copy), EggRenderer (copy), PlacedEggRenders (copy), EggActionMovement (copy), EggCmds (copy), EggPlaceAnimation (copy), SmartProximityPrompt (copy), EggGrowthAnimation (copy), PlacedEggReadyPulse (copy), Workspace (copy), v3 (ref), Lock (copy), v6 (ref), startNightTimeSkipForState (copy), t (copy), ModelCameraOcclusionController (copy), PlacedEggBillboard (copy), updatePrompt (copy), activatePrompt (copy), GetDirectGrowthTweenRemainingSeconds (copy), setStateScale (copy), v8 (copy) ]]
	local Placement = p3.Placement

	if Placement == nil then
		return
	end

	local v1 = Players:GetPlayerByUserId(p1)
	local v2 = if v1 == nil then nil else PlotCmds.GetPlotData(v1)

	if v2 == nil then
		return
	end

	local v4 = Trove.new()
	local v5 = GetStartScale(p3)
	local v62 = GetTargetScale(p3)
	local v7 = GetVisualScale(p3, v5, v62)
	local v82 = v2.CenterPoint.CFrame * Placement.LocalCFrame
	local v9 = EggRenderer.RenderVisual({
		OwnerUserId = p1,
		UID = p2,
		ModelName = ("%*_%*"):format(p1, p2),
		Record = p3,
		ScaleMultiplier = v7
	}, PlacedEggRenders, true)

	v4:Add(v9.Model)
	EggActionMovement.SetPivot(v9.Model, v82)

	local isUserId = p1 == Players.LocalPlayer.UserId

	if isUserId and EggCmds.ConsumeLocalPlaceAnimation(p2) then
		EggPlaceAnimation.Play(v9.Model, v82, PlacedEggRenders)
	end

	local v10 = nil
	local v11 = if p1 == Players.LocalPlayer.UserId then true else false

	if v11 then
		local v12 = Instance.new("NumberValue")

		v12.Value = v7
		v4:Add(v12)
		v4:Add(v12.Changed:Connect(function(p1) --[[ Line: 465 | Upvalues: v9 (copy), EggRenderer (ref) ]]
			v9.Model:ScaleTo(p1)
			EggRenderer.ApplyPlacedCollisionPolicy(v9.Model)
		end))
		v10 = v12
	end

	local v13 = if p1 == Players.LocalPlayer.UserId then true else false
	local v14, v15, v16

	if v13 then
		local ProximityPrompt = Instance.new("ProximityPrompt")

		ProximityPrompt.RequiresLineOfSight = false
		ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
		ProximityPrompt.MaxActivationDistance = 7
		ProximityPrompt.HoldDuration = 0
		v4:Add(SmartProximityPrompt.AttachToModel(ProximityPrompt, v9.Model, {
			SurfaceOffset = 0.75,
			TrackDistance = 7,
			MaxActivationDistance = ProximityPrompt.MaxActivationDistance
		}))
		v14 = EggGrowthAnimation.new(v9.Model, v82, 1)
		v15 = PlacedEggReadyPulse.new(v9.Model, v82, v62)
		v16 = ProximityPrompt
	else
		v14 = nil
		v15 = nil
		v16 = nil
	end

	local t2 = {
		ScaleTween = nil,
		DirectGrowthTweenActive = false,
		NextGrowthPulseAt = nil,
		NightTimeSkipAnimation = nil,
		NightBillboardSuppressed = false,
		NextReadyPulseAt = nil,
		IsHatching = false,
		OcclusionTracked = false,
		OwnerUserId = p1,
		Uid = p2,
		Record = p3,
		Result = v9,
		BasePivot = v82,
		StartScale = v5,
		TargetScale = v62,
		ScaleValue = v10,
		GrowthAnimation = v14
	}
	local v17 = Workspace:GetServerTimeNow() + v3 * 0.2

	v3 = (v3 + 1) % 25
	t2.NextGrowthUpdateAt = v17
	t2.ReadyPulse = v15
	t2.Prompt = v16
	t2.Trove = v4
	t2.HatchLock = Lock()

	local v18 = v6

	if v18 ~= nil then
		startNightTimeSkipForState(t2, v18)
	end

	if v15 ~= nil then
		v4:Add(function() --[[ Line: 520 | Upvalues: v15 (ref) ]]
			v15:Destroy()
		end)
	end

	if v14 ~= nil then
		v4:Add(function() --[[ Line: 525 | Upvalues: v14 (ref) ]]
			v14:Destroy()
		end)
	end

	v4:Add(function() --[[ Line: 529 | Upvalues: t2 (copy) ]]
		local ScaleTween = t2.ScaleTween

		if ScaleTween == nil then
			return
		end

		ScaleTween:Cancel()
		t2.ScaleTween = nil
		t2.DirectGrowthTweenActive = false
	end)
	t[("%*:%*"):format(p1, p2)] = t2
	assert(not t2.OcclusionTracked, (("Placed egg %* occlusion is already tracked"):format(t2.Uid)))
	ModelCameraOcclusionController.TrackModel(t2.Result.Model, 1)
	t2.OcclusionTracked = true

	local t3 = {
		OwnerUserId = p1,
		Uid = p2,
		Record = p3,
		Model = v9.Model
	}
	local NightTimeSkipAnimation = t2.NightTimeSkipAnimation

	t3.TimeSkipSeconds = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()
	PlacedEggBillboard.SetEntry(t3)
	updatePrompt(t2)

	if v16 ~= nil then
		v4:Add(v16.Triggered:Connect(function(p1) --[[ Line: 548 | Upvalues: Players (ref), activatePrompt (ref), t2 (copy) ]]
			if p1 == Players.LocalPlayer then
				activatePrompt(t2)
			end
		end))
	end

	local v23 = GetDirectGrowthTweenRemainingSeconds(p3, (Workspace:GetServerTimeNow()))

	if v13 and v23 > 0 then
		local NightTimeSkipAnimation2 = t2.NightTimeSkipAnimation

		if not (if NightTimeSkipAnimation2 == nil then false else not NightTimeSkipAnimation2:IsComplete()) then
			setStateScale(t2, t2.TargetScale, TweenInfo.new(math.max(v23, 0.05), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), true, true)
		end
	end

	v8:AtDebug():Log((("Rendered placed egg %* for owner %*"):format(p2, p1)))
end

v10 = function(p1) --[[ Line: 564 | Upvalues: EggCmds (copy), Players (copy), PlotCmds (copy), t (copy), IsReady (copy), GetStartScale (copy), GetTargetScale (copy), EggActionMovement (copy), clearNightTimeSkipAnimation (copy), PlacedEggBillboard (copy), setStateScale (copy), v2 (copy), EggSkipAnimation (copy), PlacedEggGrowthPresentationPolicy (copy), updatePrompt (copy), addPlacedEggRenderState (copy), v9 (ref) ]]
	local v1 = EggCmds.GetOwnerRuntimeRecords(p1)
	local v22 = Players:GetPlayerByUserId(p1)
	local v3 = if v22 == nil then nil else PlotCmds.GetPlotData(v22)

	if v3 == nil then
		return
	end

	local t2 = {}

	for k, v in pairs(v1) do
		local v5, v6

		if v.Placement ~= nil then
			local v7 = ("%*:%*"):format(p1, k)

			t2[v7] = true

			local v8 = t[v7]

			if v8 == nil then
				addPlacedEggRenderState(p1, k, v)

				continue
			end

			if not v8.IsHatching then
				local NightTimeSkipAnimation = v8.NightTimeSkipAnimation

				v5 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()

				local v10 = if v5 == nil then 0 else v5.Value
				local v11 = IsReady(v8.Record, v10)
				local v12 = IsReady(v, v10)

				v8.Record = v
				v8.StartScale = GetStartScale(v)
				v8.TargetScale = GetTargetScale(v)

				if v.Placement ~= nil then
					v8.BasePivot = v3.CenterPoint.CFrame * v.Placement.LocalCFrame

					local ReadyPulse = v8.ReadyPulse

					if ReadyPulse ~= nil then
						ReadyPulse:SetTransform(v8.BasePivot, v8.TargetScale)
					end

					local GrowthAnimation = v8.GrowthAnimation

					if GrowthAnimation ~= nil then
						GrowthAnimation:SetBasePivot(v8.BasePivot)
					end

					local NightTimeSkipAnimation2 = v8.NightTimeSkipAnimation

					if NightTimeSkipAnimation2 ~= nil then
						NightTimeSkipAnimation2:SetTransform(v8.BasePivot, v8.StartScale, v8.TargetScale)
						NightTimeSkipAnimation2:AcknowledgeRecord(v)

						if v12 then
							NightTimeSkipAnimation2:CancelVisual()
						end
					end

					local NightTimeSkipAnimation3 = v8.NightTimeSkipAnimation
					local v13 = if NightTimeSkipAnimation3 == nil then false else not NightTimeSkipAnimation3:IsComplete()

					if not v13 and (ReadyPulse == nil or not ReadyPulse:IsPlaying()) and (GrowthAnimation == nil or not GrowthAnimation:IsPlaying()) then
						EggActionMovement.SetPivot(v8.Result.Model, v8.BasePivot)
					end
				end

				local NightTimeSkipAnimation2 = v8.NightTimeSkipAnimation

				if NightTimeSkipAnimation2 ~= nil and NightTimeSkipAnimation2:IsComplete() then
					clearNightTimeSkipAnimation(v8)
				end

				local t3 = {
					OwnerUserId = p1,
					Uid = k,
					Record = v,
					Model = v8.Result.Model
				}
				local NightTimeSkipAnimation3 = v8.NightTimeSkipAnimation

				v6 = if NightTimeSkipAnimation3 == nil then nil else NightTimeSkipAnimation3:GetAppliedSecondsValue()
				t3.TimeSkipSeconds = v6
				PlacedEggBillboard.SetEntry(t3)

				if p1 == Players.LocalPlayer.UserId and (not v11 and (v12 and v8.NightTimeSkipAnimation == nil)) then
					if EggCmds.GetSelectedSkipGrowthUid() == k then
						setStateScale(v8, v8.TargetScale, v2)
						task.spawn(EggSkipAnimation.Play, v8.Result.Model)
					else
						local v15 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v8.Result.Model)

						if setStateScale(v8, v8.TargetScale, nil, v15 == nil) then
							PlacedEggGrowthPresentationPolicy.LogSkipped(v8.Uid, "natural completion", (assert(v15, "Skipped natural completion requires a presentation reason")))
						end
					end
				end

				updatePrompt(v8)
			end
		end
	end

	for k, v in pairs(t) do
		if v.OwnerUserId == p1 and not t2[k] then
			v9(k)
		end
	end
end

local function refreshAll() --[[ refreshAll | Line: 665 | Upvalues: EggCmds (copy), v10 (ref), t (copy), v9 (ref) ]]
	local t2 = {}

	for i, v in ipairs((EggCmds.GetRuntimeSnapshot())) do
		t2[v.OwnerUserId] = true
		v10(v.OwnerUserId)
	end

	for k, v in pairs(t) do
		if not t2[v.OwnerUserId] then
			v9(k)
		end
	end
end

local function updateReadyPulses(p1) --[[ updateReadyPulses | Line: 680 | Upvalues: t (copy), IsReady (copy), PlacedEggGrowthPresentationPolicy (copy), v4 (copy) ]]
	for k, v in pairs(t) do
		local v1
		local ReadyPulse = v.ReadyPulse

		if ReadyPulse ~= nil and (v.IsHatching or v.Result.Model.Parent == nil) then
			v.NextReadyPulseAt = nil
			ReadyPulse:Cancel()
		elseif ReadyPulse ~= nil then
			local NightTimeSkipAnimation = v.NightTimeSkipAnimation

			v1 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()

			if IsReady(v.Record, if v1 == nil then 0 else v1.Value) then
				local NightTimeSkipAnimation2 = v.NightTimeSkipAnimation

				if if NightTimeSkipAnimation2 == nil then false else not NightTimeSkipAnimation2:IsComplete() then
					v.NextReadyPulseAt = nil
					ReadyPulse:Cancel()

					continue
				end

				local NextReadyPulseAt = v.NextReadyPulseAt

				if ReadyPulse:IsPlaying() then
					local v6 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v.Result.Model)

					if v6 == nil then
						if NextReadyPulseAt == nil then
							v.NextReadyPulseAt = p1 + v4:NextNumber(5, 10)
						end

						continue
					end

					ReadyPulse:Cancel()
					v.NextReadyPulseAt = p1 + v4:NextNumber(5, 10)
					PlacedEggGrowthPresentationPolicy.LogSkipped(v.Uid, "ready pulse cancellation", v6)

					continue
				end

				if NextReadyPulseAt == nil then
					v.NextReadyPulseAt = p1 + v4:NextNumber(5, 10)

					continue
				end

				if NextReadyPulseAt <= p1 then
					local v7 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v.Result.Model)

					if v7 == nil then
						if ReadyPulse:Play() then
							v.NextReadyPulseAt = nil
						end

						continue
					end

					v.NextReadyPulseAt = p1 + v4:NextNumber(5, 10)
					PlacedEggGrowthPresentationPolicy.LogSkipped(v.Uid, "ready pulse", v7)
				end
			else
				v.NextReadyPulseAt = nil
				ReadyPulse:Cancel()
			end
		end
	end
end

local function updateGrowthPulses(p1) --[[ updateGrowthPulses | Line: 723 | Upvalues: t (copy), GetDirectGrowthTweenRemainingSeconds (copy), IsReady (copy), PlacedEggGrowthPresentationPolicy (copy), v5 (copy) ]]
	for k, v in pairs(t) do
		local v1
		local GrowthAnimation = v.GrowthAnimation

		if GrowthAnimation ~= nil then
			local v2 = GetDirectGrowthTweenRemainingSeconds(v.Record, p1)

			if v.IsHatching or v.Result.Model.Parent == nil then
				v.NextGrowthPulseAt = nil
				GrowthAnimation:Cancel()
			else
				local NightTimeSkipAnimation = v.NightTimeSkipAnimation

				v1 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()

				if IsReady(v.Record, if v1 == nil then 0 else v1.Value) or v2 > 0 then
					v.NextGrowthPulseAt = nil
					GrowthAnimation:Cancel()
				else
					local NightTimeSkipAnimation2 = v.NightTimeSkipAnimation

					if if NightTimeSkipAnimation2 == nil then false else not NightTimeSkipAnimation2:IsComplete() then
						v.NextGrowthPulseAt = nil
						GrowthAnimation:Cancel()

						continue
					end

					local NextGrowthPulseAt = v.NextGrowthPulseAt

					if GrowthAnimation:IsPlaying() then
						local v7 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v.Result.Model)

						if v7 ~= nil then
							GrowthAnimation:Cancel()
							v.NextGrowthPulseAt = p1 + v5:NextNumber(27, 65)
							PlacedEggGrowthPresentationPolicy.LogSkipped(v.Uid, "random growth jump cancellation", v7)
						end

						continue
					end

					if NextGrowthPulseAt == nil then
						v.NextGrowthPulseAt = p1 + v5:NextNumber(27, 65)

						continue
					end

					if NextGrowthPulseAt <= p1 then
						v.NextGrowthPulseAt = p1 + v5:NextNumber(27, 65)

						local v8 = PlacedEggGrowthPresentationPolicy.GetSkipReason(v.Result.Model)

						if v8 == nil then
							GrowthAnimation:Play()

							continue
						end

						PlacedEggGrowthPresentationPolicy.LogSkipped(v.Uid, "random growth jump", v8)
					end
				end
			end
		end
	end
end

local function updateGrowth(p1) --[[ updateGrowth | Line: 764 | Upvalues: t (copy), GetDirectGrowthTweenRemainingSeconds (copy), Players (copy), updatePrompt (copy), setStateScale (copy), GetVisualScale (copy), PlacedEggGrowthPresentationPolicy (copy) ]]
	for k, v in pairs(t) do
		if not v.IsHatching and v.Result.Model.Parent ~= nil then
			local NightTimeSkipAnimation = v.NightTimeSkipAnimation

			if not (if NightTimeSkipAnimation == nil then false else not NightTimeSkipAnimation:IsComplete()) then
				local v2 = GetDirectGrowthTweenRemainingSeconds(v.Record, p1)

				if v.OwnerUserId == Players.LocalPlayer.UserId and v2 > 0 then
					if not v.DirectGrowthTweenActive then
						updatePrompt(v)
						setStateScale(v, v.TargetScale, TweenInfo.new(math.max(v2, 0.05), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), true, true)
					end

					continue
				end

				local NextGrowthUpdateAt = v.NextGrowthUpdateAt

				if not (p1 < NextGrowthUpdateAt) then
					v.NextGrowthUpdateAt = NextGrowthUpdateAt + (math.floor((p1 - NextGrowthUpdateAt) / 5) + 1) * 5
					updatePrompt(v)

					local v4 = GetVisualScale(v.Record, v.StartScale, v.TargetScale)
					local v5 = PlacedEggGrowthPresentationPolicy.GetNaturalGrowthSkipReason(v.Result.Model, v4)

					if setStateScale(v, v4, nil, v5 == nil) then
						PlacedEggGrowthPresentationPolicy.LogSkipped(v.Uid, "natural growth", (assert(v5, "Skipped natural growth requires a presentation reason")))
					end
				end
			end
		end
	end
end

local function updateNightTimeSkips() --[[ updateNightTimeSkips | Line: 796 | Upvalues: t (copy), clearNightTimeSkipAnimation (copy), updatePrompt (copy), PlacedEggBillboard (copy) ]]
	for k, v in pairs(t) do
		local NightTimeSkipAnimation = v.NightTimeSkipAnimation

		if NightTimeSkipAnimation ~= nil then
			if v.IsHatching or v.Result.Model.Parent == nil then
				clearNightTimeSkipAnimation(v)

				continue
			end

			updatePrompt(v)

			if v.NightBillboardSuppressed and NightTimeSkipAnimation:IsBillboardFadeFinished() then
				v.NightBillboardSuppressed = false
				PlacedEggBillboard.SetNightPresentationActive(v.OwnerUserId, v.Uid, false)
			end

			if NightTimeSkipAnimation:IsComplete() then
				clearNightTimeSkipAnimation(v)
				PlacedEggBillboard.SetEntry({
					TimeSkipSeconds = nil,
					OwnerUserId = v.OwnerUserId,
					Uid = v.Uid,
					Record = v.Record,
					Model = v.Result.Model
				})
			end
		end
	end
end

local function stepPlacedEggs() --[[ stepPlacedEggs | Line: 825 | Upvalues: Workspace (copy), updateNightTimeSkips (copy), updateGrowthPulses (copy), updateReadyPulses (copy), updateGrowth (copy) ]]
	local v1 = Workspace:GetServerTimeNow()

	updateNightTimeSkips()
	updateGrowthPulses(v1)
	updateReadyPulses(v1)
	updateGrowth(v1)
end

function t2.GetRenderFolder() --[[ GetRenderFolder | Line: 837 | Upvalues: PlacedEggRenders (copy) ]]
	return PlacedEggRenders
end
function t2.Refresh() --[[ Refresh | Line: 841 | Upvalues: refreshAll (copy) ]]
	refreshAll()
end
function t2.SetPromptsSuppressed(p1) --[[ SetPromptsSuppressed | Line: 845 | Upvalues: Asserts (copy), v7 (ref), t (copy), updatePrompt (copy) ]]
	Asserts.boolean(p1)
	v7 = p1

	for k, v in pairs(t) do
		updatePrompt(v)
	end
end
function t2.ActivateLocalEgg(p1) --[[ ActivateLocalEgg | Line: 854 | Upvalues: Asserts (copy), t (copy), Players (copy), activatePrompt (copy) ]]
	Asserts.string(p1)

	local v1 = t[("%*:%*"):format(Players.LocalPlayer.UserId, p1)]

	if v1 == nil then
		return false, "Egg is not rendered"
	end

	return activatePrompt(v1)
end
function t2.RequestSkipGrowthForLocalEgg(p1) --[[ RequestSkipGrowthForLocalEgg | Line: 865 | Upvalues: Asserts (copy), t (copy), Players (copy), IsReady (copy), activatePrompt (copy) ]]
	Asserts.string(p1)

	local v1 = t[("%*:%*"):format(Players.LocalPlayer.UserId, p1)]

	if v1 == nil then
		return false, "Egg is not rendered"
	end

	local NightTimeSkipAnimation = v1.NightTimeSkipAnimation
	local v3 = if NightTimeSkipAnimation == nil then nil else NightTimeSkipAnimation:GetAppliedSecondsValue()

	if IsReady(v1.Record, if v3 == nil then 0 else v3.Value) then
		return false, "Egg is already ready"
	end

	return activatePrompt(v1)
end
function t2.AppendRaycastTargets(p1, p2) --[[ AppendRaycastTargets | Line: 879 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.number(p2)

	for k, v in pairs(t) do
		if v.OwnerUserId == p2 and v.Result.Model.Parent ~= nil then
			table.insert(p1, v.Result.Model)
		end
	end
end
function t2.DestroyOwner(p1) --[[ DestroyOwner | Line: 889 | Upvalues: Asserts (copy), destroyOwnerStates (copy), PlacedEggBillboard (copy) ]]
	Asserts.number(p1)
	destroyOwnerStates(p1)
	PlacedEggBillboard.DestroyOwner(p1)
end
EggCmds.RuntimeSnapshotUpdated:Connect(refreshAll)
EggCmds.RuntimeOwnerUpdated:Connect(v10)
EggCmds.RuntimeOwnerCleared:Connect(t2.DestroyOwner)
EggCmds.AreaEggResetStartCountdown:Connect(startNightTimeSkip)
PlotCmds.OnAnyPlotUpdated:Connect(refreshAll)
RunService.Heartbeat:Connect(stepPlacedEggs)
task.defer(function() --[[ Line: 906 | Upvalues: refreshAll (copy), Workspace (copy), AreaEggResetTimeUtil (copy), v6 (ref), t (copy), startNightTimeSkipForState (copy) ]]
	refreshAll()

	local v1 = Workspace:GetServerTimeNow()

	if not AreaEggResetTimeUtil.IsNight(v1) then
		return
	end

	local t2 = {
		DayStartsAt = AreaEggResetTimeUtil.GetNextResetAt(v1),
		RareSpawns = {}
	}

	v6 = t2.DayStartsAt

	for k, v in pairs(t) do
		startNightTimeSkipForState(v, t2.DayStartsAt)
	end
end)

return t2