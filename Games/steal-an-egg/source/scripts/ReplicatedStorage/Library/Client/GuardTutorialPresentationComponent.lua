-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ArrowPointer3D = require(ReplicatedStorage.Library.Client.WorldFX.ArrowPointer3D)

require(ReplicatedStorage.Library.Client.WorldFX.ArrowPointer3D.Types.Interface)

local Asserts = require(ReplicatedStorage.Library.Asserts)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local TutorialBeam = require(ReplicatedStorage.Library.Client.WorldFX.TutorialBeam)
local TutorialHighlightOverlay = require(script.TutorialHighlightOverlay)
local TutorialMessageAnimator = require(ReplicatedStorage.Library.Client.UI.TutorialMessageAnimator)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local TutorialTapIndicator = require(script.TutorialTapIndicator)
local v1 = Log.new()
local t = {}

t.__index = t
t.__class = "GuardTutorialPresentationComponent"
function t.new() --[[ new | Line: 86 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2._arrow = nil
	v2._beamHandle = nil
	v2._billboardClick = nil
	v2._billboardClickTween = nil
	v2._createdReadyLabelScale = false
	v2._defaultMessageFramePosition = nil
	v2._defaultMessageStrokeTransparency = nil
	v2._defaultMessageTransparency = nil
	v2._highlightCleanup = nil
	v2._messageAnimator = nil
	v2._messageFrame = nil
	v2._messageGradient = nil
	v2._messageGui = nil
	v2._messageLabel = nil
	v2._messageLabelStroke = nil
	v2._messageTransitionId = 0
	v2._progressionFill = nil
	v2._progressionFillTween = nil
	v2._progressionFrame = nil
	v2._readyLabel = nil
	v2._readyLabelScale = nil
	v2._readyLabelScaleTween = nil
	v2._readyLabelWhite = nil
	v2._readyLabelWhiteTween = nil
	v2._tapCleanup = nil
	v2._screenClickGui = nil
	v2._screenClickTween = nil

	return v2
end

local function assertPresentationTarget(p1) --[[ assertPresentationTarget | Line: 124 ]]
	assert(if typeof(p1) == "Vector3" then true elseif typeof(p1) == "Instance" then p1:IsA("BasePart") else false, "Tutorial presentation target must be a BasePart or Vector3")
end

function t._getMessageAnimator(p1) --[[ _getMessageAnimator | Line: 129 | Upvalues: GUI (copy), TutorialMessageAnimator (copy) ]]
	if p1._messageGui ~= nil and (p1._messageFrame ~= nil and (p1._messageLabel ~= nil and (p1._messageGradient ~= nil and (p1._messageAnimator ~= nil and p1._messageLabelStroke ~= nil)))) then
		return p1._messageGui, p1._messageFrame, p1._messageLabel, p1._messageGradient, p1._messageAnimator, p1._messageLabelStroke
	end

	local v1 = GUI.TutorialInstructions()

	assert(v1:IsA("ScreenGui"), "TutorialInstructions must be a ScreenGui")

	local Frame = v1.Frame

	assert(Frame:IsA("Frame"), "TutorialInstructions.Frame must be a Frame")

	local TextLabel = Frame.TextLabel

	assert(TextLabel:IsA("TextLabel"), "TutorialInstructions.Frame.TextLabel must be a TextLabel")

	local UIStroke = Frame.TextLabel.UIStroke

	assert(UIStroke:IsA("UIStroke"), "TutorialInstructions.Frame.TextLabel.UIStroke must be a UIStroke")

	local UIGradient = TextLabel.UIGradient

	assert(UIGradient:IsA("UIGradient"), "TutorialInstructions.Frame.TextLabel.UIGradient must be a UIGradient")

	local v7 = TutorialMessageAnimator.new(TextLabel)

	p1._messageGui = v1
	p1._messageFrame = Frame
	p1._messageGradient = UIGradient
	p1._messageLabel = TextLabel
	p1._messageAnimator = v7
	p1._messageLabelStroke = UIStroke

	if p1._defaultMessageFramePosition == nil then
		p1._defaultMessageFramePosition = Frame.Position
	end

	if p1._defaultMessageTransparency == nil then
		p1._defaultMessageTransparency = TextLabel.TextTransparency
	end

	if p1._defaultMessageStrokeTransparency == nil then
		p1._defaultMessageStrokeTransparency = TextLabel.TextStrokeTransparency
	end

	return v1, Frame, TextLabel, UIGradient, v7, UIStroke
end
function t._getProgressionElements(p1) --[[ _getProgressionElements | Line: 187 ]]
	if p1._progressionFrame ~= nil and (p1._progressionFill ~= nil and (p1._readyLabel ~= nil and (p1._readyLabelScale ~= nil and p1._readyLabelWhite ~= nil))) then
		return p1._progressionFrame, p1._progressionFill, p1._readyLabel, p1._readyLabelScale, p1._readyLabelWhite
	end

	local _, v1 = p1:_getMessageAnimator()
	local Progression = v1.Progression

	assert(Progression:IsA("GuiObject"), "TutorialInstructions.Frame.Progression must be a GuiObject")

	local Fill = Progression.Fill

	assert(Fill:IsA("GuiObject"), "TutorialInstructions.Frame.Progression.Fill must be a GuiObject")

	local ReadyLabel = Progression.ReadyLabel

	assert(ReadyLabel:IsA("GuiObject"), "TutorialInstructions.Frame.Progression.ReadyLabel must be a GuiObject")

	local ReadyLabelWhite = ReadyLabel.ReadyLabelWhite

	assert(ReadyLabelWhite:IsA("TextLabel"), "TutorialInstructions.Frame.Progression.ReadyLabel.ReadyLabelWhite must be a TextLabel")

	local UIScale = ReadyLabel:FindFirstChildOfClass("UIScale")
	local v6

	if UIScale == nil then
		local UIScale2 = Instance.new("UIScale")

		UIScale2.Parent = ReadyLabel
		p1._createdReadyLabelScale = true
		v6 = UIScale2
	else
		v6 = UIScale
	end

	p1._progressionFrame = Progression
	p1._progressionFill = Fill
	p1._readyLabel = ReadyLabel
	p1._readyLabelScale = v6
	p1._readyLabelWhite = ReadyLabelWhite

	return Progression, Fill, ReadyLabel, v6, ReadyLabelWhite
end
function t._setMessageGradientEnabled(p1, p2) --[[ _setMessageGradientEnabled | Line: 245 ]]
	if p1._messageGradient ~= nil then
		p1._messageGradient.Enabled = p2
	end
end
function t._resetMessageFramePosition(p1) --[[ _resetMessageFramePosition | Line: 256 ]]
	if p1._messageFrame ~= nil and p1._defaultMessageFramePosition ~= nil then
		p1._messageFrame.Position = p1._defaultMessageFramePosition
	end
end
function t._resetMessageTransparency(p1) --[[ _resetMessageTransparency | Line: 264 ]]
	if p1._messageLabel ~= nil and p1._messageLabelStroke ~= nil then
		p1._messageLabel.TextTransparency = p1._defaultMessageTransparency or 0
		p1._messageLabelStroke.Transparency = 0
		p1._messageLabel.TextStrokeTransparency = p1._defaultMessageStrokeTransparency or 1
	end
end
function t._clearTap(p1) --[[ _clearTap | Line: 274 ]]
	if p1._tapCleanup ~= nil then
		local _tapCleanup = p1._tapCleanup

		p1._tapCleanup = nil
		_tapCleanup()
	end
end
function t._clearHighlight(p1) --[[ _clearHighlight | Line: 284 ]]
	if p1._highlightCleanup ~= nil then
		local _highlightCleanup = p1._highlightCleanup

		p1._highlightCleanup = nil
		_highlightCleanup()
	end
end
function t._clearArrow(p1) --[[ _clearArrow | Line: 294 ]]
	if p1._arrow ~= nil then
		local _arrow = p1._arrow

		p1._arrow = nil
		_arrow:Destroy()
	end
end
function t._clearBeam(p1) --[[ _clearBeam | Line: 304 | Upvalues: TutorialBeam (copy) ]]
	if p1._beamHandle ~= nil then
		local _beamHandle = p1._beamHandle

		p1._beamHandle = nil
		TutorialBeam.Destroy(_beamHandle)
	end
end
function t._clearBillboardClick(p1) --[[ _clearBillboardClick | Line: 314 ]]
	if p1._billboardClickTween ~= nil then
		p1._billboardClickTween:Cancel()
		p1._billboardClickTween = nil
	end

	if p1._billboardClick == nil then
		return
	end

	p1._billboardClick:Destroy()
	p1._billboardClick = nil
end
function t._clearScreenClick(p1) --[[ _clearScreenClick | Line: 326 ]]
	if p1._screenClickTween ~= nil then
		p1._screenClickTween:Cancel()
		p1._screenClickTween = nil
	end

	if p1._screenClickGui == nil then
		return
	end

	p1._screenClickGui.Enabled = false
end

local function playClickPulse(p1) --[[ playClickPulse | Line: 337 | Upvalues: TweenService (copy) ]]
	p1.Scale = 1

	local v1 = TweenService:Create(p1, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true), {
		Scale = 1.3
	})

	v1:Play()

	return v1
end

function t._clearProgressionTweens(p1) --[[ _clearProgressionTweens | Line: 348 ]]
	if p1._progressionFillTween ~= nil then
		p1._progressionFillTween:Cancel()
		p1._progressionFillTween = nil
	end

	if p1._readyLabelScaleTween ~= nil then
		p1._readyLabelScaleTween:Cancel()
		p1._readyLabelScaleTween = nil
	end

	if p1._readyLabelWhiteTween == nil then
		return
	end

	p1._readyLabelWhiteTween:Cancel()
	p1._readyLabelWhiteTween = nil
end
function t._setReadyProgressionVisible(p1, p2, p3, p4, p5) --[[ _setReadyProgressionVisible | Line: 365 | Upvalues: TweenService (copy) ]]
	if p5 then
		if p1._readyLabelScaleTween ~= nil and p1._readyLabelWhiteTween ~= nil then
			return
		end

		p2.Visible = true
		p3.Scale = 1
		p4.TextTransparency = 1

		local v1 = TweenService:Create(p3, TweenInfo.new(0.45, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true), {
			Scale = 1.2
		})
		local v2 = TweenService:Create(p4, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true), {
			TextTransparency = 0
		})

		p1._readyLabelScaleTween = v1
		p1._readyLabelWhiteTween = v2
		v1:Play()
		v2:Play()
	else
		if p1._readyLabelScaleTween ~= nil then
			p1._readyLabelScaleTween:Cancel()
			p1._readyLabelScaleTween = nil
		end

		if p1._readyLabelWhiteTween == nil then
			p2.Visible = false
			p3.Scale = 1
			p4.TextTransparency = 1

			return
		end

		p1._readyLabelWhiteTween:Cancel()
		p1._readyLabelWhiteTween = nil
		p2.Visible = false
		p3.Scale = 1
		p4.TextTransparency = 1
	end
end
function t.ShowAnimatedMessage(p1, p2, p3) --[[ ShowAnimatedMessage | Line: 421 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)
	Asserts.Color3(p3)

	local v1, _, _2, _3, v2 = p1:_getMessageAnimator()

	p1._messageTransitionId = p1._messageTransitionId + 1
	p1:_resetMessageTransparency()
	v1.Enabled = true
	v2:SetAnimated(p2, p3)
end
function t.ShowInstantMessage(p1, p2, p3) --[[ ShowInstantMessage | Line: 436 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)
	Asserts.Color3(p3)

	local v1, _, _2, _3, v2 = p1:_getMessageAnimator()

	p1._messageTransitionId = p1._messageTransitionId + 1
	p1:_resetMessageTransparency()
	v1.Enabled = true
	v2:SetInstant(p2, p3)
end
function t.TransitionMessage(p1, p2, p3) --[[ TransitionMessage | Line: 451 | Upvalues: Asserts (copy), Tween (copy), TweenService (copy) ]]
	Asserts.string(p2)
	Asserts.Color3(p3)

	local v1, _, v2, _2, v3, v4 = p1:_getMessageAnimator()

	p1._messageTransitionId = p1._messageTransitionId + 1

	local _messageTransitionId = p1._messageTransitionId

	v1.Enabled = true
	v3:Stop()

	local function f5() --[[ Line: 466 | Upvalues: _messageTransitionId (copy), p1 (copy), v2 (copy), p2 (copy), p3 (copy), v4 (copy), Tween (ref), TweenService (ref) ]]
		if _messageTransitionId == p1._messageTransitionId then
			v2.RichText = true
			v2.Text = p2
			v2.TextColor3 = p3
			v2.MaxVisibleGraphemes = -1
			v2.TextTransparency = 1
			v2.TextStrokeTransparency = 1
			v4.Transparency = 1
			Tween(v4, {
				Transparency = 0
			}, { 0.02 })
			TweenService:Create(v2, TweenInfo.new(0.02), {
				TextTransparency = p1._defaultMessageTransparency or 0,
				TextStrokeTransparency = p1._defaultMessageStrokeTransparency or 1
			}):Play()
		end
	end

	if v2.Text == "" then
		f5()
	else
		local v6 = TweenService:Create(v2, TweenInfo.new(0.02), {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		})

		Tween(v4, {
			Transparency = 1
		}, { 0.02 })
		v6.Completed:Connect(f5)
		v6:Play()
	end
end
function t.SetMessageGradientEnabled(p1, p2) --[[ SetMessageGradientEnabled | Line: 502 | Upvalues: Asserts (copy) ]]
	Asserts.boolean(p2)

	local _, _2, _3, _4 = p1:_getMessageAnimator()

	p1:_setMessageGradientEnabled(p2)
end
function t.SetMessageFrameYScale(p1, p2) --[[ SetMessageFrameYScale | Line: 511 | Upvalues: Asserts (copy) ]]
	Asserts.optional.number(p2)

	local _, v1 = p1:_getMessageAnimator()
	local v2 = p1._defaultMessageFramePosition or v1.Position

	if p2 == nil then
		v1.Position = v2
	else
		v1.Position = UDim2.new(v2.X.Scale, v2.X.Offset, p2, v2.Y.Offset)
	end
end
function t.ClearMessage(p1) --[[ ClearMessage | Line: 527 ]]
	p1._messageTransitionId = p1._messageTransitionId + 1

	if p1._messageAnimator ~= nil then
		p1._messageAnimator:Clear()
	end

	if p1._messageLabel ~= nil then
		p1._messageLabel.Text = ""
		p1:_resetMessageTransparency()
	end

	p1:_resetMessageFramePosition()
	p1:_setMessageGradientEnabled(false)

	if p1._messageGui == nil then
		return
	end

	p1._messageGui.Enabled = false
end
function t.ShowSpeedProgression(p1, p2, p3) --[[ ShowSpeedProgression | Line: 546 | Upvalues: Asserts (copy), TweenService (copy) ]]
	Asserts.number(p2)
	Asserts.boolean(p3)

	local v1, v2, v3, v4, v5 = p1:_getProgressionElements()
	local v6 = math.clamp(p2, 0, 1)

	v1.Visible = true

	if p1._progressionFillTween ~= nil then
		p1._progressionFillTween:Cancel()
	end

	local Size = v2.Size
	local v7 = UDim2.new(v6, 0, Size.Y.Scale, Size.Y.Offset)
	local v8 = TweenService:Create(v2, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = v7
	})

	p1._progressionFillTween = v8
	v8:Play()
	p1:_setReadyProgressionVisible(v3, v4, v5, p3)
end
function t.ClearSpeedProgression(p1) --[[ ClearSpeedProgression | Line: 576 ]]
	p1:_clearProgressionTweens()

	local _progressionFrame = p1._progressionFrame
	local _progressionFill = p1._progressionFill
	local _readyLabel = p1._readyLabel
	local _readyLabelScale = p1._readyLabelScale
	local _readyLabelWhite = p1._readyLabelWhite

	if _progressionFrame ~= nil and (_progressionFill ~= nil and (_readyLabel ~= nil and (_readyLabelScale ~= nil and _readyLabelWhite ~= nil))) then
		local Size = _progressionFill.Size

		_progressionFill.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
		_readyLabel.Visible = false
		_readyLabelScale.Scale = 1
		_readyLabelWhite.TextTransparency = 1
		_progressionFrame.Visible = false
	end
end
function t.ShowBeam(p1, p2) --[[ ShowBeam | Line: 602 | Upvalues: TutorialBeam (copy) ]]
	assert(if typeof(p2) == "Vector3" then true elseif typeof(p2) == "Instance" then p2:IsA("BasePart") else false, "Tutorial presentation target must be a BasePart or Vector3")

	if p1._beamHandle == nil then
		p1._beamHandle = TutorialBeam.Create(p2)
	else
		TutorialBeam.UpdateTarget(p1._beamHandle, p2)
	end
end
function t.UpdateBeamTarget(p1, p2) --[[ UpdateBeamTarget | Line: 616 | Upvalues: TutorialBeam (copy) ]]
	assert(if typeof(p2) == "Vector3" then true elseif typeof(p2) == "Instance" then p2:IsA("BasePart") else false, "Tutorial presentation target must be a BasePart or Vector3")

	if p1._beamHandle == nil then
		p1._beamHandle = TutorialBeam.Create(p2)
	else
		TutorialBeam.UpdateTarget(p1._beamHandle, p2)
	end
end
function t.ClearBeam(p1) --[[ ClearBeam | Line: 630 ]]
	p1:_clearBeam()
end
function t.ShowTap(p1, p2, p3, p4, p5) --[[ ShowTap | Line: 634 | Upvalues: Asserts (copy), TutorialTapIndicator (copy) ]]
	Asserts.GuiButton(p2)
	Asserts.optional.boolean(p3)
	Asserts.optional.UDim(p4)
	Asserts.optional.UDim2(p5)
	p1:_clearTap()
	p1._tapCleanup = TutorialTapIndicator.Create(p2, p3, p4, p5)
end
function t.ShowTapOnSurfaceGuiButton(p1, p2, p3, p4, p5, p6) --[[ ShowTapOnSurfaceGuiButton | Line: 650 | Upvalues: Asserts (copy), TutorialTapIndicator (copy) ]]
	Asserts.BasePart(p2)
	Asserts.string(p3)
	Asserts.optional.boolean(p4)
	Asserts.optional.UDim(p5)
	Asserts.optional.UDim2(p6)

	local v1 = nil

	for i, v in ipairs(p2:GetChildren()) do
		if v:IsA("SurfaceGui") then
			local v2 = v:FindFirstChild(p3)

			if v2 ~= nil and v2:IsA("GuiButton") then
				v1 = v2

				break
			end
		end
	end

	if v1 == nil then
		p1:_clearTap()

		return false
	end

	p1:_clearTap()
	p1._tapCleanup = TutorialTapIndicator.Create(v1, p4, p5, p6)

	return true
end
function t.ClearTap(p1) --[[ ClearTap | Line: 687 ]]
	p1:_clearTap()
end
function t.ShowBillboardClick(p1, p2) --[[ ShowBillboardClick | Line: 691 | Upvalues: Asserts (copy), ReplicatedStorage (copy), playClickPulse (copy) ]]
	Asserts.CFrame(p2)

	if p1._billboardClick == nil then
		local BillboardTutorialClick = ReplicatedStorage.Assets.Billboards.BillboardTutorialClick

		assert(BillboardTutorialClick:IsA("BasePart"), "ReplicatedStorage.Assets.Billboards.BillboardTutorialClick must be a BasePart")

		local v2 = BillboardTutorialClick:Clone()

		v2.CFrame = p2
		v2.Parent = workspace

		local BillboardGui = v2.BillboardGui

		assert(BillboardGui:IsA("BillboardGui"), "BillboardTutorialClick.BillboardGui must be a BillboardGui")

		local Image = BillboardGui.Image

		assert(Image:IsA("ImageLabel"), "BillboardTutorialClick.BillboardGui.Image must be an ImageLabel")

		local UIScale = Image.UIScale

		assert(UIScale:IsA("UIScale"), "BillboardTutorialClick.BillboardGui.Image.UIScale must be a UIScale")
		p1._billboardClick = v2
		p1._billboardClickTween = playClickPulse(UIScale)
	else
		p1._billboardClick.CFrame = p2
	end
end
function t.ClearBillboardClick(p1) --[[ ClearBillboardClick | Line: 719 ]]
	p1:_clearBillboardClick()
end
function t.SetScreenClickVisible(p1, p2) --[[ SetScreenClickVisible | Line: 723 | Upvalues: Asserts (copy), Players (copy), playClickPulse (copy) ]]
	Asserts.boolean(p2)

	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

	assert(PlayerGui:IsA("PlayerGui"), "LocalPlayer.PlayerGui must be a PlayerGui")

	local TutorialClick = PlayerGui:WaitForChild("TutorialClick")

	assert(TutorialClick:IsA("ScreenGui"), "PlayerGui.TutorialClick must be a ScreenGui")

	local Image = TutorialClick.Image

	assert(Image:IsA("ImageLabel"), "TutorialClick.Image must be an ImageLabel")

	local UIScale = Image.UIScale

	assert(UIScale:IsA("UIScale"), "TutorialClick.Image.UIScale must be a UIScale")
	p1._screenClickGui = TutorialClick

	if not p2 then
		p1:_clearScreenClick()

		return
	end

	TutorialClick.Enabled = true

	if p1._screenClickTween ~= nil then
		return
	end

	p1._screenClickTween = playClickPulse(UIScale)
end
function t.ClearScreenClick(p1) --[[ ClearScreenClick | Line: 750 ]]
	p1:_clearScreenClick()
end
function t.ShowHighlight(p1, p2) --[[ ShowHighlight | Line: 754 | Upvalues: Asserts (copy), TutorialHighlightOverlay (copy) ]]
	Asserts.GuiObject(p2)
	p1:_clearHighlight()
	p1._highlightCleanup = TutorialHighlightOverlay.Create(p2)
end
function t.ClearHighlight(p1) --[[ ClearHighlight | Line: 761 ]]
	p1:_clearHighlight()
end
function t.ShowArrow(p1, p2, p3, p4) --[[ ShowArrow | Line: 765 | Upvalues: ArrowPointer3D (copy) ]]
	assert(if typeof(p2) == "Vector3" then true elseif typeof(p2) == "Instance" then p2:IsA("BasePart") else false, "Tutorial presentation target must be a BasePart or Vector3")
	assert(if typeof(p3) == "Vector3" then true elseif typeof(p3) == "Instance" then p3:IsA("BasePart") else false, "Tutorial presentation target must be a BasePart or Vector3")
	assert(ArrowPointer3D.__types.OptionalConfig(p4))
	p1:_clearArrow()

	local v3 = ArrowPointer3D.new(p2, p3, p4)

	v3:Start()
	p1._arrow = v3
end
function t.UpdateArrowTarget(p1, p2) --[[ UpdateArrowTarget | Line: 781 ]]
	assert(if typeof(p2) == "Vector3" then true elseif typeof(p2) == "Instance" then p2:IsA("BasePart") else false, "Tutorial presentation target must be a BasePart or Vector3")
	assert(if p1._arrow == nil then false else true, "Cannot update tutorial arrow target before showing an arrow")
	p1._arrow:ChangeTarget(p2)
end
function t.UpdateArrowOrigin(p1, p2) --[[ UpdateArrowOrigin | Line: 790 ]]
	assert(if typeof(p2) == "Vector3" then true elseif typeof(p2) == "Instance" then p2:IsA("BasePart") else false, "Tutorial presentation target must be a BasePart or Vector3")
	assert(if p1._arrow == nil then false else true, "Cannot update tutorial arrow origin before showing an arrow")
	p1._arrow:ChangeOrigin(p2)
end
function t.ClearArrow(p1) --[[ ClearArrow | Line: 799 ]]
	p1:_clearArrow()
end
function t.ClearAll(p1) --[[ ClearAll | Line: 803 ]]
	p1:_clearArrow()
	p1:_clearBeam()
	p1:_clearBillboardClick()
	p1:_clearHighlight()
	p1:_clearTap()
	p1:_clearScreenClick()
	p1:ClearSpeedProgression()
	p1:ClearMessage()
end
function t.Destroy(p1) --[[ Destroy | Line: 814 | Upvalues: v1 (copy) ]]
	v1:AtTrace():Log("[GuardTutorialPresentationComponent] Destroying tutorial presentation layer")
	p1:ClearAll()

	if not p1._createdReadyLabelScale or p1._readyLabelScale == nil then
		return
	end

	p1._readyLabelScale:Destroy()
	p1._readyLabelScale = nil
end

return t