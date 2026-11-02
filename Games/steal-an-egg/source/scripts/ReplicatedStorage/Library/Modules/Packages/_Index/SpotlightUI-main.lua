-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

require(script.Types)

local GoodSignal = require(script.Packages.GoodSignal)
local Janitor = require(script.Packages.Janitor)
local t = {
	OVERLAY_ALPHA = 0.6,
	HINT_OFFSET = 20,
	HINT_PADDING = 10,
	WORLD_RADIUS_PADDING = 1.5,
	TWEEN_DURATION = 0.5,
	FADE_DURATION = 0.25,
	PULSE_DURATION = 1.2,
	SHAPE_TWEEN_DURATION = 0.4,
	HINT_CORNER_RADIUS = 8,
	HINT_TEXT_SIZE = 18,
	OVERLAY_ZINDEX = 5,
	HINT_ENABLED = false,
	HINT_ZINDEX = 11,
	DEFAULT_SPOTLIGHT_SIZE = Vector2.new(160, 160),
	HINT_SIZE = Vector2.new(300, 60),
	MOVE_EASING_STYLE = Enum.EasingStyle.Quint,
	MOVE_EASING_DIRECTION = Enum.EasingDirection.Out,
	FADE_EASING_STYLE = Enum.EasingStyle.Quad,
	FADE_EASING_DIRECTION = Enum.EasingDirection.Out,
	PULSE_EASING_STYLE = Enum.EasingStyle.Sine,
	SHAPE_EASING_STYLE = Enum.EasingStyle.Quint,
	SHAPE_EASING_DIRECTION = Enum.EasingDirection.Out,
	OVERLAY_COLOR = Color3.new(0/255, 0/255, 0/255),
	HINT_BACKGROUND_COLOR = Color3.fromRGB(20, 20, 20),
	HINT_TEXT_COLOR = Color3.new(255/255, 255/255, 255/255),
	CIRCLE_CORNER_RADIUS = UDim.new(1, 0),
	SQUARE_CORNER_RADIUS = UDim.new(0, 8),
	HINT_FONT = Enum.Font.GothamBold
}
local t2 = {
	ClampToScreen = function(p1, p2, p3) --[[ ClampToScreen | Line: 116 | Upvalues: t (copy) ]]
		return Vector2.new(math.clamp(p1.X, p2.X / 2, p3.X - p2.X / 2), (math.clamp(p1.Y, 0, p3.Y - p2.Y - t.HINT_PADDING)))
	end
}

function t2.GetHintPosition(p1, p2, p3, p4) --[[ GetHintPosition | Line: 122 | Upvalues: t (copy), t2 (copy) ]]
	return t2.ClampToScreen(Vector2.new(p1.X + p2.X / 2, p1.Y + p2.Y + t.HINT_OFFSET), p3, p4)
end

local _ = {
	CreateMoveTween = function(p1, p2) --[[ CreateMoveTween | Line: 134 | Upvalues: t (copy), TweenService (copy) ]]
		return TweenService:Create(p1, TweenInfo.new(t.TWEEN_DURATION, t.MOVE_EASING_STYLE, t.MOVE_EASING_DIRECTION), p2)
	end,
	CreateFadeTween = function(p1, p2) --[[ CreateFadeTween | Line: 139 | Upvalues: t (copy), TweenService (copy) ]]
		return TweenService:Create(p1, TweenInfo.new(t.FADE_DURATION, t.FADE_EASING_STYLE, t.FADE_EASING_DIRECTION), p2)
	end,
	CreatePulseTween = function(p1, p2) --[[ CreatePulseTween | Line: 144 | Upvalues: t (copy), TweenService (copy) ]]
		return TweenService:Create(p1, TweenInfo.new(t.PULSE_DURATION, t.PULSE_EASING_STYLE), p2)
	end,
	CreateShapeTween = function(p1, p2) --[[ CreateShapeTween | Line: 148 | Upvalues: t (copy), TweenService (copy) ]]
		return TweenService:Create(p1, TweenInfo.new(t.SHAPE_TWEEN_DURATION, t.SHAPE_EASING_STYLE, t.SHAPE_EASING_DIRECTION), p2)
	end
}
local t3 = {
	CreateFrame = function(p1, p2) --[[ CreateFrame | Line: 159 | Upvalues: t (copy) ]]
		local Frame = Instance.new("Frame")

		Frame.BackgroundColor3 = t.OVERLAY_COLOR
		Frame.BackgroundTransparency = 1
		Frame.BorderSizePixel = 0
		Frame.Parent = p1

		if p2 then
			for v1, v2 in p2 do
				Frame[v1] = v2
			end
		end

		return Frame
	end,
	CreateHintLabel = function(p1) --[[ CreateHintLabel | Line: 174 | Upvalues: t (copy) ]]
		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.fromOffset(t.HINT_SIZE.X, t.HINT_SIZE.Y)
		TextLabel.BackgroundColor3 = t.HINT_BACKGROUND_COLOR
		TextLabel.BackgroundTransparency = 1
		TextLabel.TextColor3 = t.HINT_TEXT_COLOR
		TextLabel.Font = t.HINT_FONT
		TextLabel.TextSize = t.HINT_TEXT_SIZE
		TextLabel.TextWrapped = true
		TextLabel.BorderSizePixel = 0
		TextLabel.AnchorPoint = Vector2.new(0.5, 0)
		TextLabel.Text = ""
		TextLabel.ZIndex = t.HINT_ZINDEX
		TextLabel.Parent = p1

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(0, t.HINT_CORNER_RADIUS)
		UICorner.Parent = TextLabel

		return TextLabel
	end,
	CreateTriangle = function(p1) --[[ CreateTriangle | Line: 195 | Upvalues: t (copy) ]]
		local Frame = Instance.new("Frame")

		Frame.BackgroundTransparency = 1
		Frame.BorderSizePixel = 0
		Frame.Visible = false
		Frame.ZIndex = t.OVERLAY_ZINDEX
		Frame.Parent = p1

		local Frame2 = Instance.new("Frame")

		Frame2.Size = UDim2.fromScale(1.414, 1.414)
		Frame2.Position = UDim2.fromScale(0.5, 0.7)
		Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame2.BackgroundTransparency = 1
		Frame2.Rotation = 45
		Frame2.BorderSizePixel = 0
		Frame2.Parent = Frame

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(0, 8)
		UICorner.Parent = Frame2

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = t.OVERLAY_COLOR
		UIStroke.Thickness = 10000
		UIStroke.Transparency = 1
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Parent = Frame2

		local Frame3 = Instance.new("Frame")

		Frame3.Size = UDim2.fromScale(1, 0.5)
		Frame3.Position = UDim2.fromScale(0, 0)
		Frame3.BackgroundTransparency = 1
		Frame3.BorderSizePixel = 0
		Frame3.ClipsDescendants = true
		Frame3.Parent = Frame
		Frame2.Parent = Frame3

		return Frame, UIStroke
	end
}
local LocalPlayer = Players.LocalPlayer
local t4 = {}

t4.__index = t4
function t4.new() --[[ new | Line: 242 | Upvalues: Janitor (copy), GoodSignal (copy), t (copy), t4 (copy) ]]
	local CurrentCamera = workspace.CurrentCamera
	local v1 = Janitor.new()
	local v2 = GoodSignal.new()
	local v5 = setmetatable({
		_gui = nil,
		_container = nil,
		_circleMask = nil,
		_circleStroke = nil,
		_circleCorner = nil,
		_triangle = nil,
		_triangleStroke = nil,
		_hint = nil,
		_hintCorner = nil,
		_active = false,
		_pulseEnabled = false,
		_currentShape = "Circle",
		_stepIndex = 0,
		_positionDriver = nil,
		_sizeDriver = nil,
		_pulseDriver = nil,
		_spotlightPos = Vector2.zero,
		_spotlightSize = t.DEFAULT_SPOTLIGHT_SIZE,
		_steps = {},
		_camera = CurrentCamera,
		janitor = v1,
		stepCompleted = v2,
		sequenceCompleted = GoodSignal.new()
	}, t4)

	v5:_buildUI()
	v5:_setupDrivers()
	v5:_startUpdateLoop()

	return v5
end
function t4._buildUI(p1) --[[ _buildUI | Line: 285 | Upvalues: LocalPlayer (copy), t (copy), t3 (copy) ]]
	local SpotlightGui = Instance.new("ScreenGui")

	SpotlightGui.Name = "SpotlightGui"
	SpotlightGui.IgnoreGuiInset = true
	SpotlightGui.ResetOnSpawn = false
	SpotlightGui.Enabled = false
	SpotlightGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	SpotlightGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	p1._gui = SpotlightGui
	p1.janitor:Add(SpotlightGui, "Destroy")

	local t2 = {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1)
	}
	local Frame = Instance.new("Frame")

	Frame.BackgroundColor3 = t.OVERLAY_COLOR
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.Parent = SpotlightGui

	if t2 then
		for v1, v2 in t2 do
			Frame[v1] = v2
		end
	end

	p1._container = Frame

	local t4 = {
		Name = "CircleMask",
		BackgroundTransparency = 1,
		ZIndex = t.OVERLAY_ZINDEX
	}
	local Frame2 = Instance.new("Frame")

	Frame2.BackgroundColor3 = t.OVERLAY_COLOR
	Frame2.BackgroundTransparency = 1
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Frame

	if t4 then
		for v4, v5 in t4 do
			Frame2[v4] = v5
		end
	end

	p1._circleMask = Frame2

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

	UIAspectRatioConstraint.AspectRatio = 1
	UIAspectRatioConstraint.Parent = Frame2

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = t.CIRCLE_CORNER_RADIUS
	UICorner.Parent = Frame2
	p1._circleCorner = UICorner

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = t.OVERLAY_COLOR
	UIStroke.Thickness = 10000
	UIStroke.Transparency = 1
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Parent = Frame2
	p1._circleStroke = UIStroke

	local Frame3 = Instance.new("Frame")

	Frame3.BackgroundTransparency = 1
	Frame3.BorderSizePixel = 0
	Frame3.Visible = false
	Frame3.ZIndex = t.OVERLAY_ZINDEX
	Frame3.Parent = Frame
	p1._triangle = Frame3

	local Frame4 = Instance.new("Frame")

	Frame4.Size = UDim2.fromScale(1.414, 1.414)
	Frame4.Position = UDim2.fromScale(0.5, 0.65)
	Frame4.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame4.BackgroundTransparency = 1
	Frame4.Rotation = 45
	Frame4.BorderSizePixel = 0

	local UICorner2 = Instance.new("UICorner")

	UICorner2.CornerRadius = UDim.new(0, 8)
	UICorner2.Parent = Frame4

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = t.OVERLAY_COLOR
	UIStroke2.Thickness = 10000
	UIStroke2.Transparency = 1
	UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke2.Parent = Frame4
	p1._triangleStroke = UIStroke2

	local Frame5 = Instance.new("Frame")

	Frame5.Size = UDim2.fromScale(1, 0.55)
	Frame5.Position = UDim2.fromScale(0, 0)
	Frame5.BackgroundTransparency = 1
	Frame5.BorderSizePixel = 0
	Frame5.ClipsDescendants = true
	Frame5.Parent = Frame3
	Frame4.Parent = Frame5

	local v6 = t3.CreateHintLabel(Frame)

	v6.Visible = t.HINT_ENABLED
	p1._hint = v6
	p1._hintCorner = v6:FindFirstChildOfClass("UICorner")
end
function t4._setupDrivers(p1) --[[ _setupDrivers | Line: 370 ]]
	local Vector3Value = Instance.new("Vector3Value")

	Vector3Value.Value = Vector3.new(p1._spotlightPos.X, p1._spotlightPos.Y, 0)
	p1._positionDriver = Vector3Value

	local Vector3Value2 = Instance.new("Vector3Value")

	Vector3Value2.Value = Vector3.new(p1._spotlightSize.X, p1._spotlightSize.Y, 0)
	p1._sizeDriver = Vector3Value2

	local v1 = Instance.new("NumberValue")

	v1.Value = 0
	p1._pulseDriver = v1
end
function t4._startUpdateLoop(p1) --[[ _startUpdateLoop | Line: 384 | Upvalues: RunService (copy) ]]
	p1.janitor:Add(RunService.RenderStepped:Connect(function() --[[ Line: 386 | Upvalues: p1 (copy) ]]
		if p1._active then
			local _positionDriver = p1._positionDriver.Value

			p1._spotlightPos = Vector2.new(_positionDriver.X, _positionDriver.Y)

			local _sizeDriver = p1._sizeDriver.Value
			local _pulseDriver = p1._pulseDriver.Value

			p1._spotlightSize = Vector2.new(_sizeDriver.X + _pulseDriver, _sizeDriver.Y + _pulseDriver)
			p1:_updateSpotlightLayout()
			p1:_updateHintPosition()
		end
	end), "Disconnect")
end
function t4._updateSpotlightLayout(p1) --[[ _updateSpotlightLayout | Line: 406 ]]
	local X = p1._spotlightPos.X
	local Y = p1._spotlightPos.Y
	local X2 = p1._spotlightSize.X
	local Y2 = p1._spotlightSize.Y

	if p1._currentShape == "Triangle" then
		p1._circleMask.Visible = false
		p1._triangle.Visible = true
		p1._triangle.Position = UDim2.fromOffset(X, Y)

		local v1 = math.max(X2, Y2)

		p1._triangle.Size = UDim2.fromOffset(v1, v1)
	else
		p1._circleMask.Visible = true
		p1._triangle.Visible = false

		local v2 = math.max(X2, Y2)

		p1._circleMask.Position = UDim2.fromOffset(X - (v2 - X2) / 2, Y - (v2 - Y2) / 2)
		p1._circleMask.Size = UDim2.fromOffset(v2, v2)
	end
end
function t4._updateHintPosition(p1) --[[ _updateHintPosition | Line: 429 | Upvalues: t2 (copy) ]]
	local v1 = t2.GetHintPosition(p1._spotlightPos, p1._spotlightSize, p1._hint.AbsoluteSize, p1._container.AbsoluteSize)

	p1._hint.Position = UDim2.fromOffset(v1.X, v1.Y)
end
function t4._fadeOverlay(p1, p2) --[[ _fadeOverlay | Line: 438 | Upvalues: t (copy), TweenService (copy) ]]
	local v1 = p2 and 1 - t.OVERLAY_ALPHA or 1

	TweenService:Create(p1._circleStroke, TweenInfo.new(t.FADE_DURATION, t.FADE_EASING_STYLE, t.FADE_EASING_DIRECTION), {
		Transparency = v1
	}):Play()
	TweenService:Create(p1._triangleStroke, TweenInfo.new(t.FADE_DURATION, t.FADE_EASING_STYLE, t.FADE_EASING_DIRECTION), {
		Transparency = v1
	}):Play()

	local t2 = {}

	t2.BackgroundTransparency = if p2 then 0.15 else 1
	t2.TextTransparency = if p2 then 0 else 1
	TweenService:Create(p1._hint, TweenInfo.new(t.FADE_DURATION, t.FADE_EASING_STYLE, t.FADE_EASING_DIRECTION), t2):Play()
end
function t4._disconnectFollow(p1) --[[ _disconnectFollow | Line: 455 ]]
	p1.janitor:Remove("FollowConnection")
end
function t4._worldRadiusToPixels(p1, p2, p3) --[[ _worldRadiusToPixels | Line: 459 ]]
	local _camera = p1._camera
	local v1, v2 = _camera:WorldToViewportPoint(p2)

	if v2 and not (v1.Z <= 0) then
		return p3 * (_camera.ViewportSize.Y / 2 / (math.tan(math.rad(_camera.FieldOfView) / 2) * v1.Z))
	end

	return 0
end
function t4._getWorldRadiusFromInstance(p1, p2) --[[ _getWorldRadiusFromInstance | Line: 473 | Upvalues: t (copy) ]]
	local v1 = nil

	if p2:IsA("BasePart") then
		v1 = math.max(p2.Size.X, p2.Size.Y, p2.Size.Z) / 2
	elseif p2:IsA("Model") then
		local _, v2 = p2:GetBoundingBox()

		v1 = math.max(v2.X, v2.Y, v2.Z) / 2
	else
		error("Unsupported instance type for spotlight sizing")
	end

	return v1 * t.WORLD_RADIUS_PADDING
end
function t4.Show(p1) --[[ Show | Line: 488 ]]
	p1._gui.Enabled = true
	p1._active = true
	p1:_fadeOverlay(true)

	return p1
end
function t4.Hide(p1) --[[ Hide | Line: 495 | Upvalues: t (copy) ]]
	p1._active = false
	p1:_disconnectFollow()
	p1:DisablePulse()
	p1:_fadeOverlay(false)
	task.delay(t.FADE_DURATION, function() --[[ Line: 501 | Upvalues: p1 (copy) ]]
		if not p1._gui then
			return
		end

		p1._gui.Enabled = false
	end)

	return p1
end
function t4.SetShape(p1, p2) --[[ SetShape | Line: 509 | Upvalues: t (copy), TweenService (copy) ]]
	local v1 = p2 or "Circle"

	p1._currentShape = v1

	if v1 == "Circle" then
		TweenService:Create(p1._circleCorner, TweenInfo.new(t.SHAPE_TWEEN_DURATION, t.SHAPE_EASING_STYLE, t.SHAPE_EASING_DIRECTION), {
			CornerRadius = t.CIRCLE_CORNER_RADIUS
		}):Play()

		return p1
	end

	if v1 == "Square" then
		TweenService:Create(p1._circleCorner, TweenInfo.new(t.SHAPE_TWEEN_DURATION, t.SHAPE_EASING_STYLE, t.SHAPE_EASING_DIRECTION), {
			CornerRadius = t.SQUARE_CORNER_RADIUS
		}):Play()
	end

	return p1
end
function t4.EnablePulse(p1, p2) --[[ EnablePulse | Line: 526 | Upvalues: t (copy), TweenService (copy) ]]
	if not p1._pulseEnabled then
		p1._pulseEnabled = true

		local v1 = task.spawn(function() --[[ Line: 532 | Upvalues: p1 (copy), p2 (copy), t (ref), TweenService (ref) ]]
			while p1._active and p1._pulseEnabled do
				TweenService:Create(p1._pulseDriver, TweenInfo.new(t.PULSE_DURATION, t.PULSE_EASING_STYLE), {
					Value = p2
				}):Play()
				task.wait(t.PULSE_DURATION)

				if not p1._pulseEnabled then
					break
				end

				TweenService:Create(p1._pulseDriver, TweenInfo.new(t.PULSE_DURATION, t.PULSE_EASING_STYLE), {
					Value = 0
				}):Play()
				task.wait(t.PULSE_DURATION)
			end
		end)

		p1.janitor:Add(function() --[[ Line: 551 | Upvalues: p1 (copy), v1 (copy) ]]
			p1._pulseEnabled = false
			task.cancel(v1)
		end, true, "PulseThread")
	end

	return p1
end
function t4.DisablePulse(p1) --[[ DisablePulse | Line: 558 ]]
	p1._pulseEnabled = false
	p1.janitor:Remove("PulseThread")
	p1._pulseDriver.Value = 0

	return p1
end
function t4.FocusUI(p1, p2, p3, p4) --[[ FocusUI | Line: 565 | Upvalues: t (copy), TweenService (copy) ]]
	p1:_disconnectFollow()

	local AbsolutePosition = p2.AbsolutePosition
	local AbsoluteSize = p2.AbsoluteSize
	local v1 = p3 or 0
	local v2 = Vector2.new(AbsolutePosition.X - v1, AbsolutePosition.Y - v1)
	local v3 = Vector2.new(AbsoluteSize.X + v1 * 2, AbsoluteSize.Y + v1 * 2)
	local t2 = {}

	t2.Value = Vector3.new(v2.X, v2.Y, 0)
	TweenService:Create(p1._positionDriver, TweenInfo.new(t.TWEEN_DURATION, t.MOVE_EASING_STYLE, t.MOVE_EASING_DIRECTION), t2):Play()

	local t3 = {}

	t3.Value = Vector3.new(v3.X, v3.Y, 0)
	TweenService:Create(p1._sizeDriver, TweenInfo.new(t.TWEEN_DURATION, t.MOVE_EASING_STYLE, t.MOVE_EASING_DIRECTION), t3):Play()
	p1._hint.Text = p4 or ""

	return p1
end
function t4.FocusWorld(p1, p2, p3, p4) --[[ FocusWorld | Line: 587 ]]
	local v1, v2 = p1._camera:WorldToViewportPoint(p2)

	if v2 and not (v1.Z <= 0) then
		p1._container.Visible = true

		local v3 = p1:_worldRadiusToPixels(p2, p3)
		local v4 = v3 * 2

		p1._positionDriver.Value = Vector3.new(v1.X - v3, v1.Y - v3, 0)
		p1._sizeDriver.Value = Vector3.new(v4, v4, 0)
		p1._hint.Text = p4 or ""
	else
		p1._container.Visible = false
	end

	return p1
end
function t4.FollowPart(p1, p2, p3) --[[ FollowPart | Line: 606 | Upvalues: RunService (copy) ]]
	p1:_disconnectFollow()
	p1._container.Visible = true
	p1.janitor:Add(RunService.RenderStepped:Connect(function() --[[ Line: 611 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		if p1._active and (p2 and p2.Parent) then
			p1:FocusWorld(p2.Position, p1:_getWorldRadiusFromInstance(p2), p3)
		end
	end), "Disconnect", "FollowConnection")

	return p1
end
function t4.SetSteps(p1, p2) --[[ SetSteps | Line: 625 ]]
	p1._steps = p2
	p1._stepIndex = 0

	return p1
end
function t4.Next(p1) --[[ Next | Line: 631 ]]
	p1._stepIndex = p1._stepIndex + 1

	local v1 = p1._steps[p1._stepIndex]

	if not v1 then
		p1:Hide()
		p1.sequenceCompleted:Fire()

		return p1
	end

	if v1.Shape then
		p1:SetShape(v1.Shape)
	end

	if v1.UI then
		p1:FocusUI(v1.UI, v1.Padding or 15, v1.Text)
	elseif v1.World then
		p1:FocusWorld(v1.World, v1.Radius or 80, v1.Text)
	elseif v1.Part then
		p1:FollowPart(v1.Part, v1.Text)
	end

	if v1.Pulse then
		p1:EnablePulse(v1.Pulse)
	else
		p1:DisablePulse()
	end

	p1.stepCompleted:Fire(p1._stepIndex)

	return p1
end
function t4.Start(p1) --[[ Start | Line: 663 ]]
	p1:Show()
	p1:Next()

	return p1
end
function t4.Skip(p1) --[[ Skip | Line: 669 ]]
	p1:Hide()

	return p1
end
function t4.Destroy(p1) --[[ Destroy | Line: 674 ]]
	p1.stepCompleted:DisconnectAll()
	p1.sequenceCompleted:DisconnectAll()
	p1.janitor:Destroy()
end
print("\240\159\148\142 Running SpotLightUI by @Vvshenok & Interactive Studios")

return t4