-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = Color3.fromRGB(0, 162, 255)
local v2 = Color3.fromRGB(78, 84, 96)
local v3 = Color3.fromRGB(204, 204, 204)
local v4 = Color3.fromRGB(255, 255, 255)
local v5 = Color3.fromRGB(150, 150, 150)
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local PlayerGui = game.Players.LocalPlayer.PlayerGui

PlayerGui:WaitForChild("BackpackGui")

local ContextActionService = game:GetService("ContextActionService")
local VRService = game:GetService("VRService")
local ok, result = pcall(function() --[[ Line: 39 ]]
	return false
end)
local v6 = ok and result
local t = {
	Create = function(p1) --[[ Create | Line: 50 ]]
		return function(p12) --[[ Line: 51 | Upvalues: p1 (copy) ]]
			local v1 = Instance.new(p1)
			local v2 = nil

			for k, v in pairs(p12) do
				if type(k) == "number" then
					v.Parent = v1

					continue
				end

				if k == "Parent" then
					v2 = v

					continue
				end

				v1[k] = v
			end

			if v2 then
				v1.Parent = v2
			end

			return v1
		end
	end
}
local t2 = {}

setmetatable(t2, {
	__mode = "k"
})

local v7 = t.Create("ImageLabel")({
	Image = "",
	BackgroundTransparency = 1
})

function clamp(p1, p2, p3) --[[ clamp | Line: 81 ]]
	return math.max(p1, (math.min(p2, p3)))
end
function ClampVector2(p1, p2, p3) --[[ ClampVector2 | Line: 85 ]]
	return Vector2.new(clamp(p1.x, p2.x, p3.x), clamp(p1.y, p2.y, p3.y))
end

local function Linear(p1, p2, p3, p4) --[[ Linear | Line: 90 ]]
	if p4 <= p1 then
		return p2 + p3
	end

	return p3 * p1 / p4 + p2
end

local function EaseOutQuad(p1, p2, p3, p4) --[[ EaseOutQuad | Line: 98 ]]
	if p4 <= p1 then
		return p2 + p3
	end

	local v1 = p1 / p4

	return p2 - p3 * v1 * (v1 - 2)
end

local function EaseInOutQuad(p1, p2, p3, p4) --[[ EaseInOutQuad | Line: 107 ]]
	if p4 <= p1 then
		return p2 + p3
	end

	local v1 = p1 / p4

	if v1 < 0.5 then
		return 2 * p3 * v1 * v1 + p2
	end

	return p2 + p3 * (2 * (2 - v1) * v1 - 1)
end

function PropertyTweener(p1, p2, p3, p4, p5, p6, p7) --[[ PropertyTweener | Line: 119 | Upvalues: RunService (copy) ]]
	local t = {
		StartTime = tick()
	}

	t.EndTime = t.StartTime + p5
	t.Cancelled = false

	local v1 = false
	local v2 = 0

	local function finalize() --[[ finalize | Line: 128 | Upvalues: p1 (copy), p2 (copy), p6 (copy), p3 (copy), p4 (copy), v1 (ref), v2 (ref), p7 (copy) ]]
		if p1 then
			p1[p2] = p6(1, p3, p4 - p3, 1)
		end

		v1 = true
		v2 = 1

		if not p7 then
			return
		end

		p7()
	end

	p1[p2] = p6(0, p3, p4 - p3, p5)
	coroutine.wrap(function() --[[ Line: 141 | Upvalues: t (copy), p1 (copy), p2 (copy), p6 (copy), p3 (copy), p4 (copy), p5 (copy), v2 (ref), RunService (ref), v1 (ref), p7 (copy) ]]
		local v12 = tick()

		while v12 < t.EndTime and p1 do
			if t.Cancelled then
				return
			end

			p1[p2] = p6(v12 - t.StartTime, p3, p4 - p3, p5)
			v2 = clamp(0, 1, (v12 - t.StartTime) / p5)
			RunService.RenderStepped:wait()
			v12 = tick()
		end

		if t.Cancelled ~= false or not p1 then
			return
		end

		if p1 then
			p1[p2] = p6(1, p3, p4 - p3, 1)
		end

		v1 = true
		v2 = 1

		if not p7 then
			return
		end

		p7()
	end)()
	function t.GetFinal(p1) --[[ GetFinal | Line: 157 | Upvalues: p4 (copy) ]]
		return p4
	end
	function t.GetPercentComplete(p1) --[[ GetPercentComplete | Line: 161 | Upvalues: v2 (ref) ]]
		return v2
	end
	function t.IsFinished(p1) --[[ IsFinished | Line: 165 | Upvalues: v1 (ref) ]]
		return v1
	end
	function t.Finish(p12) --[[ Finish | Line: 169 | Upvalues: v1 (ref), p1 (copy), p2 (copy), p6 (copy), p3 (copy), p4 (copy), v2 (ref), p7 (copy) ]]
		if v1 then
			return
		end

		p12:Cancel()

		if p1 then
			p1[p2] = p6(1, p3, p4 - p3, 1)
		end

		v1 = true
		v2 = 1

		if not p7 then
			return
		end

		p7()
	end
	function t.Cancel(p1) --[[ Cancel | Line: 176 | Upvalues: t (copy) ]]
		t.Cancelled = true
	end

	return t
end

local function CreateSignal() --[[ CreateSignal | Line: 185 ]]
	local t = {}
	local v1 = Instance.new("BindableEvent")
	local v2 = nil
	local v3 = nil

	function t.fire(p1, ...) --[[ fire | Line: 193 | Upvalues: v2 (ref), v3 (ref), v1 (copy) ]]
		v2 = { ... }
		v3 = select("#", ...)
		v1:Fire()
	end
	function t.connect(p1, p2) --[[ connect | Line: 199 | Upvalues: v1 (copy), v2 (ref), v3 (ref) ]]
		if p2 then
			return v1.Event:Connect(function() --[[ Line: 203 | Upvalues: p2 (copy), v2 (ref), v3 (ref) ]]
				p2(unpack(v2, 1, v3))
			end)
		end

		error("connect(nil)", 2)
	end
	function t.wait(p1) --[[ wait | Line: 208 | Upvalues: v1 (copy), v2 (ref), v3 (ref) ]]
		v1.Event:wait()

		if v2 then
			local v12, v22

			v12 = v2
			v22 = v3

			return unpack(v2, 1, v3)
		end

		error("Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
	end

	return t
end

local function getViewportSize() --[[ getViewportSize | Line: 219 ]]
	while not workspace.CurrentCamera do
		workspace.Changed:wait()
	end

	while workspace.CurrentCamera.ViewportSize == Vector2.new(0, 0) or workspace.CurrentCamera.ViewportSize == Vector2.new(1, 1) do
		workspace.CurrentCamera.Changed:wait()
	end

	return workspace.CurrentCamera.ViewportSize
end

local function isSmallTouchScreen() --[[ isSmallTouchScreen | Line: 236 | Upvalues: getViewportSize (copy), UserInputService (copy) ]]
	local v1 = getViewportSize()

	return UserInputService.TouchEnabled and (if v1.Y < 500 then true else v1.X < 700)
end

local function isPortrait() --[[ isPortrait | Line: 241 | Upvalues: getViewportSize (copy) ]]
	local v1 = getViewportSize()

	return v1.Y > v1.X
end

local function isTenFootInterface() --[[ isTenFootInterface | Line: 246 ]]
	return false
end

local function usesSelectedObject() --[[ usesSelectedObject | Line: 250 | Upvalues: VRService (copy), UserInputService (copy) ]]
	if VRService.VREnabled then
		return false
	end

	return (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false
end

local function isPosOverGui(p1, p2, p3) --[[ isPosOverGui | Line: 263 ]]
	local x = p2.AbsolutePosition.x
	local y = p2.AbsolutePosition.y

	return if x < p1.x and (p1.x < x + p2.AbsoluteSize.x and y < p1.y) then p1.y < y + p2.AbsoluteSize.y else false
end

local function isPosOverGuiWithClipping(p1, p2) --[[ isPosOverGuiWithClipping | Line: 271 ]]
	local x = p2.AbsolutePosition.x
	local y = p2.AbsolutePosition.y

	if not (if x < p1.x and (p1.x < x + p2.AbsoluteSize.x and y < p1.y) then if p1.y < y + p2.AbsoluteSize.y then true else false else false) then
		return false
	end

	local v4 = p2
	local v5

	while v4 ~= nil and (v4:IsA("GuiObject") or v4:IsA("LayerCollector")) do
		if v4:IsA("GuiObject") and not v4.Visible then
			v5 = true

			return not v5
		end

		if v4:IsA("LayerCollector") or v4.ClipsDescendants then
			local x2 = v4.AbsolutePosition.x
			local y2 = v4.AbsolutePosition.y

			if not (if x2 < p1.x and (p1.x < x2 + v4.AbsoluteSize.x and y2 < p1.y) then if p1.y < y2 + v4.AbsoluteSize.y then true else false else false) then
				v5 = true

				return not v5
			end
		end

		v4 = v4.Parent
	end

	v5 = not (v4 and v4:IsA("CoreGui"))

	return not v5
end

local function areGuisIntersecting(p1, p2) --[[ areGuisIntersecting | Line: 304 ]]
	local x = p1.AbsolutePosition.x
	local y = p1.AbsolutePosition.y
	local x2 = p2.AbsolutePosition.x
	local y2 = p2.AbsolutePosition.y

	return (if x < x2 + p2.AbsoluteSize.x then x2 < x + p1.AbsoluteSize.x else false) and (if y < y2 + p2.AbsoluteSize.y then y2 < y + p1.AbsoluteSize.y else false)
end

local function isGuiVisible(p1, p2) --[[ isGuiVisible | Line: 319 ]]
	local v1 = p1
	local v2

	while v1 ~= nil and (v1:IsA("GuiObject") or v1:IsA("LayerCollector")) do
		if v1:IsA("GuiObject") and not v1.Visible then
			v2 = true

			return not v2
		end

		if v1:IsA("LayerCollector") or v1.ClipsDescendants then
			local x = v1.AbsolutePosition.x
			local y = v1.AbsolutePosition.y
			local x2 = p1.AbsolutePosition.x
			local y2 = p1.AbsolutePosition.y

			if not ((if x < x2 + p1.AbsoluteSize.x then x2 < x + v1.AbsoluteSize.x else false) and (if y < y2 + p1.AbsoluteSize.y then y2 < y + v1.AbsoluteSize.y else false)) then
				v2 = true

				return not v2
			end
		end

		v1 = v1.Parent
	end

	v2 = not (v1 and v1:IsA("CoreGui"))

	return not v2
end

local function addHoverState(p1, p2, p3, p4) --[[ addHoverState | Line: 348 ]]
	local function onNormalButtonStateCallback() --[[ onNormalButtonStateCallback | Line: 349 | Upvalues: p1 (copy), p3 (copy), p2 (copy) ]]
		if not p1.Active then
			return
		end

		p3(p2)
	end

	local function onHoverButtonStateCallback() --[[ onHoverButtonStateCallback | Line: 354 | Upvalues: p1 (copy), p4 (copy), p2 (copy) ]]
		if not p1.Active then
			return
		end

		p4(p2)
	end

	p1.MouseEnter:Connect(onHoverButtonStateCallback)
	p1.SelectionGained:Connect(onHoverButtonStateCallback)
	p1.MouseLeave:Connect(onNormalButtonStateCallback)
	p1.SelectionLost:Connect(onNormalButtonStateCallback)
	p3(p2)
end

local function addOnResizedCallback(p1, p2) --[[ addOnResizedCallback | Line: 368 | Upvalues: t2 (copy), getViewportSize (copy) ]]
	t2[p1] = p2

	local v1 = getViewportSize()
	local v2 = getViewportSize()

	p2(v1, v2.Y > v2.X)
end

local t3 = {
	[Enum.UserInputType.Gamepad1] = true,
	[Enum.UserInputType.Gamepad2] = true,
	[Enum.UserInputType.Gamepad3] = true,
	[Enum.UserInputType.Gamepad4] = true,
	[Enum.UserInputType.Gamepad5] = true,
	[Enum.UserInputType.Gamepad6] = true,
	[Enum.UserInputType.Gamepad7] = true,
	[Enum.UserInputType.Gamepad8] = true
}

local function MakeDefaultButton(p1, p2, p3, p4, p5) --[[ MakeDefaultButton | Line: 384 | Upvalues: t (copy), t3 (copy), UserInputService (copy), GuiService (copy), VRService (copy) ]]
	local v1 = t.Create("ImageLabel")({
		Image = "",
		BackgroundTransparency = 1
	})
	local v2 = t.Create("ImageButton")({
		Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		ZIndex = 2,
		Name = p1 .. "Button",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(8, 6, 46, 44),
		Size = p2,
		SelectionImageObject = v1
	})

	t.Create("BoolValue")({
		Name = "Enabled",
		Value = true,
		Parent = v2
	})

	if p3 then
		v2.MouseButton1Click:Connect(function() --[[ Line: 409 | Upvalues: p3 (copy), t3 (ref), UserInputService (ref) ]]
			p3(t3[UserInputService:GetLastInputType()] or false)
		end)
	end

	local function isPointerInput(p1) --[[ isPointerInput | Line: 414 ]]
		return if p1.UserInputType == Enum.UserInputType.MouseMovement then true else p1.UserInputType == Enum.UserInputType.Touch
	end

	local v3 = nil

	local function setRowRef(p1) --[[ setRowRef | Line: 420 | Upvalues: v3 (ref) ]]
		v3 = p1
	end

	local function selectButton() --[[ selectButton | Line: 424 | Upvalues: p5 (copy), p4 (copy), v2 (copy), v3 (ref) ]]
		local v1 = p5

		if v1 == nil and p4 then
			v1 = p4.HubRef
		end

		if not (v1 and v1.Active) and v1 ~= nil then
			return
		end

		v2.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"

		local v22 = v2

		if v3 then
			v22 = v3
		end

		if not v1 then
			return
		end

		v1:ScrollToFrame(v22)
	end

	local function deselectButton() --[[ deselectButton | Line: 445 | Upvalues: v2 (copy) ]]
		v2.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
	end

	v2.InputBegan:Connect(function(p1) --[[ Line: 449 | Upvalues: v2 (copy), p5 (copy), p4 (copy), v3 (ref) ]]
		if not v2.Selectable then
			return
		end

		if not (if p1.UserInputType == Enum.UserInputType.MouseMovement then true else p1.UserInputType == Enum.UserInputType.Touch) then
			return
		end

		local v22 = p5

		if v22 == nil and p4 then
			v22 = p4.HubRef
		end

		if not (v22 and v22.Active) and v22 ~= nil then
			return
		end

		v2.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"

		local v32 = v2

		if v3 then
			v32 = v3
		end

		if not v22 then
			return
		end

		v22:ScrollToFrame(v32)
	end)
	v2.InputEnded:Connect(function(p1) --[[ Line: 454 | Upvalues: v2 (copy), GuiService (ref) ]]
		if not v2.Selectable or GuiService.SelectedCoreObject == v2 then
			return
		end

		if not (if p1.UserInputType == Enum.UserInputType.MouseMovement then true else p1.UserInputType == Enum.UserInputType.Touch) then
			return
		end

		v2.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
	end)
	v2.SelectionGained:Connect(function() --[[ Line: 460 | Upvalues: p5 (copy), p4 (copy), v2 (copy), v3 (ref) ]]
		local v1 = p5

		if v1 == nil and p4 then
			v1 = p4.HubRef
		end

		if not (v1 and v1.Active) and v1 ~= nil then
			return
		end

		v2.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"

		local v22 = v2

		if v3 then
			v22 = v3
		end

		if not v1 then
			return
		end

		v1:ScrollToFrame(v22)
	end)
	v2.SelectionLost:Connect(function() --[[ Line: 463 | Upvalues: v2 (copy) ]]
		v2.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
	end)
	GuiService.Changed:Connect(function(p1) --[[ Line: 467 | Upvalues: VRService (ref), UserInputService (ref), GuiService (ref), v2 (copy), p5 (copy), p4 (copy), v3 (ref) ]]
		if p1 ~= "SelectedCoreObject" then
			return
		end

		if not (if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false) then
			return
		end

		if GuiService.SelectedCoreObject == nil or GuiService.SelectedCoreObject ~= v2 then
			v2.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"

			return
		end

		if not v2.Selectable then
			return
		end

		local v22 = p5

		if v22 == nil and p4 then
			v22 = p4.HubRef
		end

		if not (v22 and v22.Active) and v22 ~= nil then
			return
		end

		v2.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"

		local v32 = v2

		if v3 then
			v32 = v3
		end

		if not v22 then
			return
		end

		v22:ScrollToFrame(v32)
	end)

	return v2, setRowRef
end

local function MakeButton(p1, p2, p3, p4, p5, p6) --[[ MakeButton | Line: 488 | Upvalues: MakeDefaultButton (copy), t (copy), getViewportSize (copy), UserInputService (copy) ]]
	local v1, v2 = MakeDefaultButton(p1, p3, p4, p5, p6)
	local v3 = t.Create("TextLabel")({
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextSize = 24,
		TextScaled = true,
		TextWrapped = true,
		ZIndex = 2,
		Name = p1 .. "TextLabel",
		Size = UDim2.new(1, 0, 1, -8),
		Position = UDim2.new(0, 0, 0, 0),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextYAlignment = Enum.TextYAlignment.Center,
		Font = Enum.Font.SourceSansBold,
		Text = p2,
		Parent = v1
	})
	local UITextSizeConstraint = Instance.new("UITextSizeConstraint", v3)
	local v4 = getViewportSize()

	if UserInputService.TouchEnabled and (if v4.Y < 500 then true else v4.X < 700) then
		v3.TextSize = 18
	end

	UITextSizeConstraint.MaxTextSize = v3.TextSize

	return v1, v3, v2
end

local function MakeImageButton(p1, p2, p3, p4, p5, p6, p7) --[[ MakeImageButton | Line: 519 | Upvalues: MakeDefaultButton (copy), t (copy) ]]
	local v1, v2 = MakeDefaultButton(p1, p3, p5, p6, p7)

	return v1, t.Create("ImageLabel")({
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 2,
		Name = p1 .. "ImageLabel",
		Size = p4,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Image = p2,
		Parent = v1
	}), v2
end

local function AddButtonRow(p1, p2, p3, p4, p5, p6) --[[ AddButtonRow | Line: 537 | Upvalues: MakeButton (copy), t (copy) ]]
	local v1, v2, v3 = MakeButton(p2, p3, p4, p5, p1, p6)
	local v4 = t.Create("Frame")({
		BackgroundTransparency = 1,
		Name = p2 .. "Row",
		Size = UDim2.new(1, 0, p4.Y.Scale, p4.Y.Offset),
		Parent = p1.Page
	})

	v1.Parent = v4
	v1.AnchorPoint = Vector2.new(1, 0)
	v1.Position = UDim2.new(1, -20, 0, 0)

	return v4, v1, v2, v3
end

local function CreateDropDown(p1, p2, p3) --[[ CreateDropDown | Line: 551 | Upvalues: HttpService (copy), t (copy), PlayerGui (copy), VRService (copy), UserInputService (copy), GuiService (copy), ContextActionService (copy), MakeButton (copy) ]]
	local v1 = Color3.fromRGB(178, 178, 178)
	local v2 = Color3.fromRGB(229, 229, 229)
	local v3 = Color3.fromRGB(255, 255, 255)
	local v4 = nil
	local t2 = {
		CurrentIndex = nil
	}

	Instance.new("BindableEvent").Name = "IndexChanged"

	if type(p1) == "table" then
		local IndexChanged = Instance.new("BindableEvent")

		IndexChanged.Name = "IndexChanged"

		local v5 = true
		local v6 = HttpService:GenerateGUID(false)
		local v7 = nil
		local v8 = p1
		local v9 = t.Create("ImageButton")({
			Name = "DropDownFullscreenFrame",
			BackgroundTransparency = 0.2,
			BorderSizePixel = 0,
			ZIndex = 10,
			Active = true,
			Visible = false,
			Selectable = false,
			AutoButtonColor = false,
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			Parent = PlayerGui.RobloxGui
		})

		local function onVREnabled(p1) --[[ onVREnabled | Line: 597 | Upvalues: VRService (ref), PlayerGui (ref), v9 (copy), t2 (copy), v8 (ref) ]]
			if p1 ~= "VREnabled" then
				return
			end

			if VRService.VREnabled then
				v9.Parent = require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):GetGUI()
				v9.BackgroundTransparency = 1
			else
				v9.Parent = PlayerGui.RobloxGui
				v9.BackgroundTransparency = 0.2
			end

			if not t2.UpdateDropDownList then
				return
			end

			t2:UpdateDropDownList(v8)
		end

		VRService.Changed:Connect(onVREnabled)
		onVREnabled("VREnabled")

		local v10 = t.Create("ImageLabel")({
			Name = "DropDownSelectionFrame",
			Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
			BackgroundTransparency = 1,
			ZIndex = 10,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(8, 6, 46, 44),
			Size = UDim2.new(0.6, 0, 0.9, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Parent = v9
		})
		local v11 = t.Create("ScrollingFrame")({
			Name = "DropDownScrollingFrame",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 10,
			Size = UDim2.new(1, -20, 1, -25),
			Position = UDim2.new(0, 10, 0, 10),
			Parent = v10
		})
		local v12 = nil
		local v13 = false

		local function f14(p1, p2) --[[ Line: 643 | Upvalues: t2 (copy), v5 (ref), p3 (copy), v9 (copy), VRService (ref), UserInputService (ref), GuiService (ref), v4 (ref), v12 (ref), ContextActionService (ref), v6 (copy), v7 (ref), v13 (ref), PlayerGui (ref) ]]
			if p1 ~= nil and p2 ~= Enum.UserInputState.Begin then
				return
			end

			t2.DropDownFrame.Selectable = v5
			p3:SetActive(true)

			if v9.Visible and (if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false) then
				GuiService.SelectedCoreObject = v4
			end

			v9.Visible = false

			if v12 then
				v12:Disconnect()
			end

			ContextActionService:UnbindAction(v6 .. "Action")
			ContextActionService:UnbindAction(v6 .. "FreezeAction")
			v7.Value = v5
			v13 = false

			if not VRService.VREnabled then
				return
			end

			require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(v9, 0)
		end

		local function f15() --[[ Line: 671 ]] end

		local function f16() --[[ Line: 673 | Upvalues: v5 (ref), t2 (copy), v13 (ref), v9 (copy), VRService (ref), PlayerGui (ref), v4 (ref), GuiService (ref), v12 (ref), v3 (copy), v2 (copy), v1 (copy), ContextActionService (ref), v6 (copy), f15 (copy), f14 (copy), p3 (copy), v7 (ref) ]]
			if not v5 then
				return
			end

			t2.DropDownFrame.Selectable = false
			v13 = true
			v9.Visible = true

			if VRService.VREnabled then
				require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(v9, 0.5)
			end

			v4 = t2.DropDownFrame

			if t2.CurrentIndex and t2.CurrentIndex > 0 then
				GuiService.SelectedCoreObject = t2.Selections[t2.CurrentIndex]
			end

			v12 = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() --[[ Line: 692 | Upvalues: t2 (ref), GuiService (ref), v3 (ref), VRService (ref), v2 (ref), v1 (ref) ]]
				for i = 1, #t2.Selections do
					if GuiService.SelectedCoreObject == t2.Selections[i] then
						t2.Selections[i].TextColor3 = v3

						continue
					end

					t2.Selections[i].TextColor3 = VRService.VREnabled and v2 or v1
				end
			end)
			ContextActionService:BindActionAtPriority(v6 .. "FreezeAction", f15, false, Enum.ContextActionPriority.High.Value, Enum.UserInputType.Keyboard, Enum.UserInputType.Gamepad1)
			ContextActionService:BindActionAtPriority(v6 .. "Action", f14, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape)
			p3:SetActive(false)
			v7.Value = false
		end

		t2.DropDownFrame = MakeButton("DropDownFrame", "Choose One", UDim2.new(0.6, 0, 0, 50), f16, nil, p3)
		t2.DropDownFrame.Position = UDim2.new(1, 0, 0.5, 0)
		t2.DropDownFrame.AnchorPoint = Vector2.new(1, 0.5)
		v7 = t2.DropDownFrame.Enabled

		local DropDownFrameTextLabel = t2.DropDownFrame.DropDownFrameTextLabel

		DropDownFrameTextLabel.Position = UDim2.new(0, 15, 0, 0)
		DropDownFrameTextLabel.Size = UDim2.new(1, -50, 1, -8)
		DropDownFrameTextLabel.ClipsDescendants = true
		DropDownFrameTextLabel.TextXAlignment = Enum.TextXAlignment.Left

		local v17 = t.Create("ImageLabel")({
			Name = "DropDownImage",
			Image = "rbxasset://textures/ui/Settings/DropDown/DropDown.png",
			BackgroundTransparency = 1,
			ZIndex = 2,
			AnchorPoint = Vector2.new(1, 0.5),
			Size = UDim2.new(0, 15, 0, 10),
			Position = UDim2.new(1, -12, 0.5, 0),
			Parent = t2.DropDownFrame
		})

		t2.DropDownImage = v17

		local function setSelection(p1) --[[ setSelection | Line: 750 | Upvalues: t2 (copy), DropDownFrameTextLabel (copy), IndexChanged (copy) ]]
			local v1 = false

			for k, v in pairs(t2.Selections) do
				if k == p1 then
					DropDownFrameTextLabel.Text = v.Text
					t2.CurrentIndex = k
					v1 = true
				end
			end

			if not v1 then
				return
			end

			IndexChanged:Fire(p1)
		end

		local function setSelectionByValue(p1) --[[ setSelectionByValue | Line: 766 | Upvalues: t2 (copy), DropDownFrameTextLabel (copy), IndexChanged (copy) ]]
			local v1 = false

			for k, v in pairs(t2.Selections) do
				if v.Text == p1 then
					DropDownFrameTextLabel.Text = v.Text
					t2.CurrentIndex = k
					v1 = true
				end
			end

			if not v1 then
				return v1
			end

			IndexChanged:Fire(t2.CurrentIndex)

			return v1
		end

		local v18 = false

		local function processInput(p1) --[[ processInput | Line: 784 | Upvalues: GuiService (ref), t2 (copy), v18 (ref), f16 (copy) ]]
			if p1.UserInputState == Enum.UserInputState.Begin then
				if p1.KeyCode == Enum.KeyCode.Return and (GuiService.SelectedCoreObject == t2.DropDownFrame or t2.SelectionInfo and t2.SelectionInfo[GuiService.SelectedCoreObject]) then
					v18 = true
				end
			else
				if p1.UserInputState ~= Enum.UserInputState.End or (p1.KeyCode ~= Enum.KeyCode.Return or not v18) then
					return
				end

				v18 = false

				if GuiService.SelectedCoreObject == t2.DropDownFrame then
					f16()

					return
				end

				if not (t2.SelectionInfo and t2.SelectionInfo[GuiService.SelectedCoreObject]) then
					return
				end

				t2.SelectionInfo[GuiService.SelectedCoreObject].Clicked()
			end
		end

		local function setIsFaded(p1) --[[ setIsFaded | Line: 807 | Upvalues: t2 (copy) ]]
			if p1 then
				t2.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5
				t2.DropDownFrame.ImageTransparency = 0.5
				t2.DropDownImage.ImageTransparency = 0.5
			else
				t2.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0
				t2.DropDownFrame.ImageTransparency = 0
				t2.DropDownImage.ImageTransparency = 0
			end
		end

		t2.IndexChanged = IndexChanged.Event
		function t2.SetSelectionIndex(p1, p2) --[[ SetSelectionIndex | Line: 822 | Upvalues: setSelection (copy) ]]
			setSelection(p2)
		end
		function t2.SetSelectionByValue(p1, p2) --[[ SetSelectionByValue | Line: 826 | Upvalues: setSelectionByValue (copy) ]]
			return setSelectionByValue(p2)
		end
		function t2.ResetSelectionIndex(p1) --[[ ResetSelectionIndex | Line: 830 | Upvalues: t2 (copy), DropDownFrameTextLabel (copy), f14 (copy) ]]
			t2.CurrentIndex = nil
			DropDownFrameTextLabel.Text = "Choose One"
			f14()
		end
		function t2.GetSelectedIndex(p1) --[[ GetSelectedIndex | Line: 836 | Upvalues: t2 (copy) ]]
			return t2.CurrentIndex
		end
		function t2.SetZIndex(p1, p2) --[[ SetZIndex | Line: 840 | Upvalues: t2 (copy), v17 (copy), DropDownFrameTextLabel (copy) ]]
			t2.DropDownFrame.ZIndex = p2
			v17.ZIndex = p2
			DropDownFrameTextLabel.ZIndex = p2
		end
		function t2.SetInteractable(p1, p2) --[[ SetInteractable | Line: 846 | Upvalues: v5 (ref), t2 (copy), f14 (copy), VRService (ref), v7 (ref), v13 (ref) ]]
			v5 = p2
			t2.DropDownFrame.Selectable = p2

			if p2 then
				t2.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0
				t2.DropDownFrame.ImageTransparency = 0
				t2.DropDownImage.ImageTransparency = 0

				if not VRService.VREnabled then
					t2:SetZIndex(2)
				end
			else
				f14()

				if VRService.VREnabled then
					t2.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5
					t2.DropDownFrame.ImageTransparency = 0.5
					t2.DropDownImage.ImageTransparency = 0.5
				else
					t2.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0
					t2.DropDownFrame.ImageTransparency = 0
					t2.DropDownImage.ImageTransparency = 0
				end

				if not VRService.VREnabled then
					t2:SetZIndex(1)
				end
			end

			v7.Value = if p2 then not v13 else p2
		end
		function t2.UpdateDropDownList(p1, p22) --[[ UpdateDropDownList | Line: 866 | Upvalues: v8 (ref), t2 (copy), VRService (ref), t (ref), v2 (copy), v1 (copy), v11 (copy), p2 (copy), DropDownFrameTextLabel (copy), v3 (copy), f14 (copy), IndexChanged (copy), UserInputService (ref), GuiService (ref), v6 (copy), v9 (copy), v10 (copy) ]]
			v8 = p22

			if t2.Selections then
				for i = 1, #t2.Selections do
					t2.Selections[i]:Destroy()
				end
			end

			t2.Selections = {}
			t2.SelectionInfo = {}

			local VREnabled = VRService.VREnabled
			local v12 = VREnabled and Enum.Font.SourceSansBold or Enum.Font.SourceSans
			local v22 = if VREnabled then 36 else 24
			local v32 = if VREnabled then 70 else 50
			local v4 = v32 + 1
			local v5 = if VREnabled then 600 else 400

			for k, v in pairs(p22) do
				local v62 = t.Create("Frame")({
					BackgroundTransparency = 0.7,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0)
				})
				local v7 = t.Create("TextButton")
				local t3 = {
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					AutoButtonColor = false,
					ZIndex = 10,
					Name = "Selection" .. tostring(k),
					Size = UDim2.new(1, -28, 0, v32),
					Position = UDim2.new(0, 14, 0, (k - 1) * v4)
				}

				t3.TextColor3 = VRService.VREnabled and v2 or v1
				t3.Font = v12
				t3.TextSize = v22
				t3.Text = v
				t3.SelectionImageObject = v62
				t3.Parent = v11

				local v92 = v7(t3)

				if k == p2 then
					t2.CurrentIndex = k
					DropDownFrameTextLabel.Text = v
					v92.TextColor3 = v3
				elseif not p2 and k == 1 then
					v92.TextColor3 = v3
				end

				local function f10() --[[ Line: 918 | Upvalues: DropDownFrameTextLabel (ref), v92 (copy), f14 (ref), t2 (ref), k (copy), IndexChanged (ref) ]]
					DropDownFrameTextLabel.Text = v92.Text
					f14()
					t2.CurrentIndex = k
					IndexChanged:Fire(k)
				end

				v92.MouseButton1Click:Connect(f10)
				v92.MouseEnter:Connect(function() --[[ Line: 927 | Upvalues: VRService (ref), UserInputService (ref), GuiService (ref), v92 (copy) ]]
					if not (if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false) then
						return
					end

					GuiService.SelectedCoreObject = v92
				end)
				t2.Selections[k] = v92
				t2.SelectionInfo[v92] = {
					Clicked = f10
				}
			end

			GuiService:RemoveSelectionGroup(v6)

			local v112 = GuiService
			local Selections = t2.Selections

			v112:AddSelectionTuple(v6, unpack(Selections))
			v11.CanvasSize = UDim2.new(1, -20, 0, #p22 * v4)

			local function updateDropDownSize() --[[ updateDropDownSize | Line: 942 | Upvalues: v11 (ref), v9 (ref), v10 (ref), v5 (copy) ]]
				if v11.CanvasSize.Y.Offset < v9.AbsoluteSize.Y - 10 then
					v10.Size = UDim2.new(0, v5, 0, v11.CanvasSize.Y.Offset + 25)
				else
					v10.Size = UDim2.new(0, v5, 0.9, 0)
				end
			end

			v9.Changed:Connect(function(p1) --[[ Line: 955 | Upvalues: updateDropDownSize (copy) ]]
				if p1 == "AbsoluteSize" then
					updateDropDownSize()
				end
			end)
			updateDropDownSize()
		end
		t2:UpdateDropDownList(p1)
		v9.MouseButton1Click:Connect(f14)
		p3.PoppedMenu:Connect(function(p1) --[[ Line: 970 | Upvalues: v9 (copy), f14 (copy) ]]
			if p1 ~= v9 then
				return
			end

			f14()
		end)
	else
		error("CreateDropDown dropDownStringTable (first arg) is not a table", 2)
	end

	return t2
end

local function CreateSelector(p1, p2) --[[ CreateSelector | Line: 979 | Upvalues: t (copy), v7 (copy), v3 (copy), UserInputService (copy), v4 (copy), addHoverState (copy), VRService (copy), GuiService (copy), EaseOutQuad (copy), v5 (copy), t2 (copy), getViewportSize (copy) ]]
	local v1 = 0
	local t3 = {
		HubRef = nil
	}

	if type(p1) ~= "table" then
		error("CreateSelector selectionStringTable (first arg) is not a table", 2)
	end

	local IndexChanged = Instance.new("BindableEvent")

	IndexChanged.Name = "IndexChanged"

	local v2 = true

	t3.CurrentIndex = 0
	t3.SelectorFrame = t.Create("ImageButton")({
		Name = "Selector",
		Image = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		ZIndex = 2,
		NextSelectionLeft = t3.SelectorFrame,
		NextSelectionRight = t3.SelectorFrame,
		Size = UDim2.new(0.6, 0, 0, 50),
		Position = UDim2.new(1, 0, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		SelectionImageObject = v7
	})

	local v32 = t.Create("ImageButton")({
		Name = "LeftButton",
		BackgroundTransparency = 1,
		Image = "",
		ZIndex = 3,
		Selectable = false,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(0, 50, 0, 50),
		SelectionImageObject = v7,
		Parent = t3.SelectorFrame
	})
	local v42 = t.Create("ImageButton")({
		Name = "RightButton",
		BackgroundTransparency = 1,
		Image = "",
		ZIndex = 3,
		Selectable = false,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.new(0, 50, 0, 50),
		SelectionImageObject = v7,
		Parent = t3.SelectorFrame
	})
	local v52 = t.Create("ImageLabel")({
		Name = "LeftButton",
		BackgroundTransparency = 1,
		Image = "rbxasset://textures/ui/Settings/Slider/Left.png",
		ZIndex = 4,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 18, 0, 30),
		ImageColor3 = v3,
		Parent = v32
	})
	local v6 = t.Create("ImageLabel")({
		Name = "RightButton",
		BackgroundTransparency = 1,
		Image = "rbxasset://textures/ui/Settings/Slider/Right.png",
		ZIndex = 4,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 18, 0, 30),
		ImageColor3 = v3,
		Parent = v42
	})

	if not UserInputService.TouchEnabled then
		local function f7(p1) --[[ Line: 1064 | Upvalues: v3 (ref) ]]
			p1.ImageColor3 = v3
		end

		local function f8(p1) --[[ Line: 1066 | Upvalues: v4 (ref) ]]
			p1.ImageColor3 = v4
		end

		addHoverState(v32, v52, f7, f8)
		addHoverState(v42, v6, f7, f8)
	end

	t3.Selections = {}

	local t4 = {}
	local t5 = {}
	local v9 = t.Create("ImageButton")({
		Name = "AutoSelectButton",
		BackgroundTransparency = 1,
		Image = "",
		ZIndex = 2,
		Position = UDim2.new(0, v32.Size.X.Offset, 0, 0),
		Size = UDim2.new(1, v32.Size.X.Offset * -2, 1, 0),
		Parent = t3.SelectorFrame,
		SelectionImageObject = v7
	})

	v9.MouseButton1Click:Connect(function() --[[ Line: 1087 | Upvalues: v2 (ref), t3 (copy), VRService (ref), UserInputService (ref), GuiService (ref) ]]
		if not v2 then
			return
		end

		if #t3.Selections <= 1 then
			return
		end

		local v1 = t3.CurrentIndex + 1

		if #t3.Selections < v1 then
			v1 = 1
		end

		t3:SetSelectionIndex(v1)

		if not (if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false) then
			return
		end

		GuiService.SelectedCoreObject = t3.SelectorFrame
	end)
	t5[v9] = true

	local function setSelection(p1, p2) --[[ setSelection | Line: 1106 | Upvalues: t3 (copy), v32 (copy), t4 (ref), EaseOutQuad (ref), IndexChanged (copy) ]]
		for k, v in pairs(t3.Selections) do
			local v2 = UDim2.new(0, v32.Size.X.Offset, 0, 0)
			local v3 = UDim2.new(0, v32.Size.X.Offset * p2 * 3, 0, 0)

			if t4[v] then
				v3 = UDim2.new(0, v32.Size.X.Offset * -p2 * 3, 0, 0)
			end

			if v3.X.Offset < 0 then
				v3 = UDim2.new(0, v3.X.Offset + v.AbsoluteSize.X / 4, 0, 0)
			end

			if if k == p1 then true else false then
				t4[v] = true
				v.Position = v3
				v.Visible = true
				PropertyTweener(v, "TextTransparency", 1, 0, 0.165, EaseOutQuad)

				if v:IsDescendantOf(game) then
					v:TweenPosition(v2, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.15, true)
				else
					v.Position = v2
				end

				t3.CurrentIndex = k
				IndexChanged:Fire(p1)

				continue
			end

			if t4[v] then
				t4[v] = false
				PropertyTweener(v, "TextTransparency", 0, 1, 0.165, EaseOutQuad)

				if v:IsDescendantOf(game) then
					v:TweenPosition(v3, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.135, true)

					continue
				end

				v.Position = UDim2.new(v3)
			end
		end
	end

	local function stepFunc(p1, p2) --[[ stepFunc | Line: 1157 | Upvalues: v2 (ref), VRService (ref), UserInputService (ref), GuiService (ref), t3 (copy), setSelection (copy) ]]
		if not v2 then
			return
		end

		if p1 ~= nil and (p1.UserInputType ~= Enum.UserInputType.MouseButton1 and (p1.UserInputType ~= Enum.UserInputType.Gamepad1 and (p1.UserInputType ~= Enum.UserInputType.Gamepad2 and (p1.UserInputType ~= Enum.UserInputType.Gamepad3 and (p1.UserInputType ~= Enum.UserInputType.Gamepad4 and p1.UserInputType ~= Enum.UserInputType.Keyboard))))) then
			return
		end

		if if VRService.VREnabled then false elseif UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then false else true then
			GuiService.SelectedCoreObject = t3.SelectorFrame
		end

		local v22 = p2 + t3.CurrentIndex
		local v3 = if t3.CurrentIndex < v22 then 1 else -1

		if #t3.Selections < v22 then
			v22 = 1
		elseif v22 < 1 then
			v22 = #t3.Selections
		end

		setSelection(v22, v3)
	end

	local v10 = nil

	local function connectToGuiService() --[[ connectToGuiService | Line: 1197 | Upvalues: v10 (ref), GuiService (ref), t3 (copy), t5 (copy), VRService (ref) ]]
		v10 = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() --[[ Line: 1198 | Upvalues: t3 (ref), GuiService (ref), t5 (ref), VRService (ref) ]]
			if #t3.Selections <= 0 then
				return
			end

			if GuiService.SelectedCoreObject == t3.SelectorFrame then
				t3.Selections[t3.CurrentIndex].TextTransparency = 0

				return
			end

			if GuiService.SelectedCoreObject == nil or not t5[GuiService.SelectedCoreObject] then
				t3.Selections[t3.CurrentIndex].TextTransparency = 0.5

				return
			end

			if VRService.VREnabled then
				t3.Selections[t3.CurrentIndex].TextTransparency = 0
			else
				GuiService.SelectedCoreObject = t3.SelectorFrame
			end
		end)
	end

	t3.IndexChanged = IndexChanged.Event
	function t3.SetSelectionIndex(p1, p2) --[[ SetSelectionIndex | Line: 1222 | Upvalues: setSelection (copy) ]]
		setSelection(p2, 1)
	end
	function t3.GetSelectedIndex(p1) --[[ GetSelectedIndex | Line: 1226 | Upvalues: t3 (copy) ]]
		return t3.CurrentIndex
	end
	function t3.SetZIndex(p1, p2) --[[ SetZIndex | Line: 1230 | Upvalues: v32 (copy), v42 (copy), v52 (copy), v6 (copy), t3 (copy) ]]
		v32.ZIndex = p2
		v42.ZIndex = p2
		v52.ZIndex = p2
		v6.ZIndex = p2

		for i = 1, #t3.Selections do
			t3.Selections[i].ZIndex = p2
		end
	end
	function t3.SetInteractable(p1, p2) --[[ SetInteractable | Line: 1241 | Upvalues: v2 (ref), t3 (copy), v32 (copy), v42 (copy), v52 (copy), v5 (ref), v6 (copy), v3 (ref) ]]
		v2 = p2
		t3.SelectorFrame.Selectable = p2
		v32.Active = p2
		v42.Active = p2

		if p2 then
			for k, v in pairs(t3.Selections) do
				v.TextColor3 = Color3.fromRGB(255, 255, 255)
			end

			v52.ImageColor3 = v3
			v6.ImageColor3 = v3
		else
			for k, v in pairs(t3.Selections) do
				v.TextColor3 = Color3.fromRGB(49, 49, 49)
			end

			v52.ImageColor3 = v5
			v6.ImageColor3 = v5
		end
	end
	function t3.UpdateOptions(p1, p22) --[[ UpdateOptions | Line: 1263 | Upvalues: t3 (copy), t4 (ref), t (ref), v32 (copy), p2 (copy), v42 (copy) ]]
		for k, v in pairs(t3.Selections) do
			v:Destroy()
		end

		t4 = {}
		t3.Selections = {}

		for k, v in pairs(p22) do
			local v1 = t.Create("TextLabel")({
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				TextTransparency = 0.5,
				TextSize = 24,
				ZIndex = 2,
				Visible = false,
				Name = "Selection" .. tostring(k),
				Size = UDim2.new(1, v32.Size.X.Offset * -2, 1, 0),
				Position = UDim2.new(1, 0, 0, 0),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextYAlignment = Enum.TextYAlignment.Center,
				Font = Enum.Font.SourceSans,
				Text = v,
				Parent = t3.SelectorFrame
			})

			if k == p2 then
				t3.CurrentIndex = k
				v1.Position = UDim2.new(0, v32.Size.X.Offset, 0, 0)
				v1.Visible = true
				t4[v1] = true
			else
				t4[v1] = false
			end

			t3.Selections[k] = v1
		end

		local v2 = #t3.Selections > 1

		v32.Visible = v2
		v42.Visible = v2
	end

	local function onVREnabled(p1) --[[ onVREnabled | Line: 1311 | Upvalues: VRService (ref), v32 (copy), v42 (copy), v9 (copy) ]]
		if p1 == "VREnabled" then
			local VREnabled = VRService.VREnabled

			v32.Selectable = VREnabled
			v42.Selectable = VREnabled
			v9.Selectable = VREnabled
		end
	end

	VRService.Changed:Connect(onVREnabled)

	local VREnabled = VRService.VREnabled

	v32.Selectable = VREnabled
	v42.Selectable = VREnabled
	v9.Selectable = VREnabled
	v32.InputBegan:Connect(function(p1) --[[ Line: 1323 | Upvalues: v2 (ref), VRService (ref), UserInputService (ref), GuiService (ref), t3 (copy), setSelection (copy) ]]
		if p1.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		if not v2 then
			return
		end

		if if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false then
			GuiService.SelectedCoreObject = t3.SelectorFrame
		end

		local v22 = -1 + t3.CurrentIndex
		local v3 = if t3.CurrentIndex < v22 then 1 else -1

		if #t3.Selections < v22 then
			v22 = 1
		elseif v22 < 1 then
			v22 = #t3.Selections
		end

		setSelection(v22, v3)
	end)
	v32.MouseButton1Click:Connect(function() --[[ Line: 1328 | Upvalues: UserInputService (ref), v2 (ref), VRService (ref), GuiService (ref), t3 (copy), setSelection (copy) ]]
		if UserInputService.TouchEnabled then
			return
		end

		if not v2 then
			return
		end

		if if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false then
			GuiService.SelectedCoreObject = t3.SelectorFrame
		end

		local v22 = -1 + t3.CurrentIndex
		local v3 = if t3.CurrentIndex < v22 then 1 else -1

		if #t3.Selections < v22 then
			v22 = 1
		elseif v22 < 1 then
			v22 = #t3.Selections
		end

		setSelection(v22, v3)
	end)
	v42.InputBegan:Connect(function(p1) --[[ Line: 1333 | Upvalues: v2 (ref), VRService (ref), UserInputService (ref), GuiService (ref), t3 (copy), setSelection (copy) ]]
		if p1.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		if not v2 then
			return
		end

		if if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false then
			GuiService.SelectedCoreObject = t3.SelectorFrame
		end

		local v22 = 1 + t3.CurrentIndex
		local v3 = if t3.CurrentIndex < v22 then 1 else -1

		if #t3.Selections < v22 then
			v22 = 1
		elseif v22 < 1 then
			v22 = #t3.Selections
		end

		setSelection(v22, v3)
	end)
	v42.MouseButton1Click:Connect(function() --[[ Line: 1338 | Upvalues: UserInputService (ref), v2 (ref), VRService (ref), GuiService (ref), t3 (copy), setSelection (copy) ]]
		if UserInputService.TouchEnabled then
			return
		end

		if not v2 then
			return
		end

		if if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false then
			GuiService.SelectedCoreObject = t3.SelectorFrame
		end

		local v22 = 1 + t3.CurrentIndex
		local v3 = if t3.CurrentIndex < v22 then 1 else -1

		if #t3.Selections < v22 then
			v22 = 1
		elseif v22 < 1 then
			v22 = #t3.Selections
		end

		setSelection(v22, v3)
	end)

	local v11 = true

	t3:UpdateOptions(p1)
	UserInputService.InputBegan:Connect(function(p1) --[[ Line: 1347 | Upvalues: v2 (ref), v11 (ref), GuiService (ref), t3 (copy), VRService (ref), UserInputService (ref), setSelection (copy) ]]
		if not v2 then
			return
		end

		if not v11 then
			return
		end

		if p1.UserInputType ~= Enum.UserInputType.Gamepad1 and p1.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		if GuiService.SelectedCoreObject ~= t3.SelectorFrame then
			return
		end

		if p1.KeyCode == Enum.KeyCode.DPadLeft or (p1.KeyCode == Enum.KeyCode.Left or p1.KeyCode == Enum.KeyCode.A) then
			if not v2 then
				return
			end

			if p1 ~= nil and (p1.UserInputType ~= Enum.UserInputType.MouseButton1 and (p1.UserInputType ~= Enum.UserInputType.Gamepad1 and (p1.UserInputType ~= Enum.UserInputType.Gamepad2 and (p1.UserInputType ~= Enum.UserInputType.Gamepad3 and (p1.UserInputType ~= Enum.UserInputType.Gamepad4 and p1.UserInputType ~= Enum.UserInputType.Keyboard))))) then
				return
			end

			if if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false then
				GuiService.SelectedCoreObject = t3.SelectorFrame
			end

			local v22 = -1 + t3.CurrentIndex
			local v3 = if t3.CurrentIndex < v22 then 1 else -1

			if #t3.Selections < v22 then
				v22 = 1
			elseif v22 < 1 then
				v22 = #t3.Selections
			end

			setSelection(v22, v3)
		else
			if p1.KeyCode ~= Enum.KeyCode.DPadRight and (p1.KeyCode ~= Enum.KeyCode.Right and p1.KeyCode ~= Enum.KeyCode.D) then
				return
			end

			if not v2 then
				return
			end

			if p1 ~= nil and (p1.UserInputType ~= Enum.UserInputType.MouseButton1 and (p1.UserInputType ~= Enum.UserInputType.Gamepad1 and (p1.UserInputType ~= Enum.UserInputType.Gamepad2 and (p1.UserInputType ~= Enum.UserInputType.Gamepad3 and (p1.UserInputType ~= Enum.UserInputType.Gamepad4 and p1.UserInputType ~= Enum.UserInputType.Keyboard))))) then
				return
			end

			if if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false then
				GuiService.SelectedCoreObject = t3.SelectorFrame
			end

			local v5 = 1 + t3.CurrentIndex
			local v6 = if t3.CurrentIndex < v5 then 1 else -1

			if #t3.Selections < v5 then
				v5 = 1
			elseif v5 < 1 then
				v5 = #t3.Selections
			end

			setSelection(v5, v6)
		end
	end)
	UserInputService.InputChanged:Connect(function(p1) --[[ Line: 1380 | Upvalues: v2 (ref), v11 (ref), v1 (ref), GuiService (ref), t3 (copy), stepFunc (copy) ]]
		if not v2 then
			return
		end

		if v11 then
			if p1.UserInputType ~= Enum.UserInputType.Gamepad1 then
				return
			end

			local SelectedCoreObject = GuiService.SelectedCoreObject

			if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(t3.SelectorFrame.Parent)) then
				return
			end

			if p1.KeyCode ~= Enum.KeyCode.Thumbstick1 then
				return
			end

			if p1.Position.X > 0.8 and (p1.Delta.X > 0 and v1 ~= 1) then
				v1 = 1
				stepFunc(p1, v1)

				return
			end

			if p1.Position.X < -0.8 and (p1.Delta.X < 0 and v1 ~= -1) then
				v1 = -1
				stepFunc(p1, v1)

				return
			end

			if not (math.abs(p1.Position.X) < 0.8) then
				return
			end
		end

		v1 = 0
	end)
	t3.SelectorFrame.AncestryChanged:Connect(function(p1, p2) --[[ Line: 1421 | Upvalues: v11 (ref), v10 (ref), GuiService (ref), t3 (copy), t5 (copy), VRService (ref) ]]
		v11 = p2

		if p2 then
			v10 = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() --[[ Line: 1198 | Upvalues: t3 (ref), GuiService (ref), t5 (ref), VRService (ref) ]]
				if #t3.Selections <= 0 then
					return
				end

				if GuiService.SelectedCoreObject == t3.SelectorFrame then
					t3.Selections[t3.CurrentIndex].TextTransparency = 0

					return
				end

				if GuiService.SelectedCoreObject == nil or not t5[GuiService.SelectedCoreObject] then
					t3.Selections[t3.CurrentIndex].TextTransparency = 0.5

					return
				end

				if VRService.VREnabled then
					t3.Selections[t3.CurrentIndex].TextTransparency = 0
				else
					GuiService.SelectedCoreObject = t3.SelectorFrame
				end
			end)
		elseif v10 then
			v10:Disconnect()
		end
	end)

	local function onResized(p1, p2) --[[ onResized | Line: 1432 | Upvalues: t3 (copy) ]]
		local v1 = if p2 then 16 elseif false then 36 else 24

		for k, v in pairs(t3.Selections) do
			v.TextSize = v1
		end
	end

	t2[t3.SelectorFrame] = onResized
	getViewportSize()

	local v12 = getViewportSize()
	local v14 = if v12.Y > v12.X then 16 elseif false then 36 else 24

	for k, v in pairs(t3.Selections) do
		v.TextSize = v14
	end

	v10 = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() --[[ Line: 1198 | Upvalues: t3 (copy), GuiService (ref), t5 (copy), VRService (ref) ]]
		if #t3.Selections <= 0 then
			return
		end

		if GuiService.SelectedCoreObject == t3.SelectorFrame then
			t3.Selections[t3.CurrentIndex].TextTransparency = 0

			return
		end

		if GuiService.SelectedCoreObject == nil or not t5[GuiService.SelectedCoreObject] then
			t3.Selections[t3.CurrentIndex].TextTransparency = 0.5

			return
		end

		if VRService.VREnabled then
			t3.Selections[t3.CurrentIndex].TextTransparency = 0
		else
			GuiService.SelectedCoreObject = t3.SelectorFrame
		end
	end)

	return t3
end

local function ShowAlert(p1, p2, p3, p4, p5) --[[ ShowAlert | Line: 1451 | Upvalues: PlayerGui (copy), VRService (copy), t (copy), HttpService (copy), ContextActionService (copy), GuiService (copy), MakeButton (copy), UserInputService (copy) ]]
	local RobloxGui = PlayerGui.RobloxGui

	if not RobloxGui:FindFirstChild("AlertViewFullScreen") then
		local v1 = nil

		local function onVREnabled(p1) --[[ onVREnabled | Line: 1462 | Upvalues: VRService (ref), PlayerGui (ref), RobloxGui (ref), v1 (ref) ]]
			if p1 ~= "VREnabled" then
				return
			end

			local v12 = nil

			if VRService.VREnabled then
				local v2 = require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu")

				RobloxGui = v2:GetGUI()
				v12 = v2
			else
				RobloxGui = PlayerGui.RobloxGui
			end

			if not v1 or v1.Parent == nil then
				return
			end

			v1.Parent = RobloxGui

			if not VRService.VREnabled then
				return
			end

			v12:SetSubpanelDepth(v1, 0.5)
		end

		local v2 = VRService.Changed:Connect(onVREnabled)

		Color3.fromRGB(59, 166, 241)
		Color3.fromRGB(255, 255, 255)
		v1 = t.Create("ImageLabel")({
			Name = "AlertViewBacking",
			Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
			BackgroundTransparency = 1,
			ImageTransparency = 1,
			ZIndex = 9,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(8, 6, 46, 44),
			Size = UDim2.new(0, 400, 0, 350),
			Position = UDim2.new(0.5, -200, 0.5, -175),
			Parent = RobloxGui
		})
		onVREnabled("VREnabled")

		if p5 or VRService.VREnabled then
			v1.ImageTransparency = 0
		else
			v1.Size = UDim2.new(0.8, 0, 0, 350)
			v1.Position = UDim2.new(0.1, 0, 0.1, 0)
		end

		if PlayerGui.RobloxGui.AbsoluteSize.Y <= v1.Size.Y.Offset then
			v1.Size = UDim2.new(v1.Size.X.Scale, v1.Size.X.Offset, v1.Size.Y.Scale, PlayerGui.RobloxGui.AbsoluteSize.Y)
			v1.Position = UDim2.new(v1.Position.X.Scale, -v1.Size.X.Offset / 2, 0.5, -v1.Size.Y.Offset / 2)
		end

		t.Create("TextLabel")({
			Name = "AlertViewText",
			BackgroundTransparency = 1,
			TextSize = 36,
			TextWrapped = true,
			ZIndex = 10,
			Size = UDim2.new(0.95, 0, 0.6, 0),
			Position = UDim2.new(0.025, 0, 0.05, 0),
			Font = Enum.Font.SourceSansBold,
			Text = p1,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			Parent = v1
		})
		t.Create("ImageLabel")({
			Image = "",
			BackgroundTransparency = 1
		})

		local v3 = HttpService:GenerateGUID(false)

		local function f4(p1, p2) --[[ Line: 1545 | Upvalues: VRService (ref), v1 (ref), PlayerGui (ref), p4 (copy), ContextActionService (ref), v3 (copy), GuiService (ref), p3 (copy), v2 (copy) ]]
			if VRService.VREnabled and (p2 == Enum.UserInputState.Begin or p2 == Enum.UserInputState.Cancel) then
				return
			end

			if not v1 then
				return
			end

			if VRService.VREnabled then
				require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(v1, 0)
			end

			v1:Destroy()
			v1 = nil

			if p4 then
				p4()
			end

			ContextActionService:UnbindAction(v3)
			GuiService.SelectedCoreObject = nil

			if p3 then
				p3:ShowBar()
			end

			if not v2 then
				return
			end

			v2:Disconnect()
		end

		local v5 = UDim2.new(1, -20, 0, 60)
		local v6 = UDim2.new(0, 10, 0.65, 0)

		if not p5 then
			local v7 = UDim2.new(0, 200, 0, 50)

			v5, v6 = v7, UDim2.new(0.5, -100, 0.65, 0)
		end

		local v9, v10 = MakeButton("AlertViewButton", p2, v5, f4)

		v9.Position = v6
		v9.NextSelectionLeft = v9
		v9.NextSelectionRight = v9
		v9.NextSelectionUp = v9
		v9.NextSelectionDown = v9
		v9.ZIndex = 9
		v10.ZIndex = v9.ZIndex
		v9.Parent = v1

		local v11 = if VRService.VREnabled then false elseif UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then false else true

		if v11 then
			GuiService.SelectedCoreObject = v9
		end

		GuiService.SelectedCoreObject = v9
		ContextActionService:BindActionAtPriority(v3, f4, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Escape, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonA)

		if p3 and not VRService.VREnabled then
			p3:HideBar()
			p3.Pages.CurrentPage:Hide(1, 1)
		end
	end
end

local function CreateNewSlider(p1, p2, p3) --[[ CreateNewSlider | Line: 1614 | Upvalues: HttpService (copy), t (copy), v7 (copy), UserInputService (copy), v4 (copy), v3 (copy), v4 (copy), addHoverState (copy), getViewportSize (copy), v1 (copy), v2 (copy), VRService (copy), GuiService (copy), RunService (copy) ]]
	local t2 = {}
	local v12 = tonumber(p1)
	local v22 = p2
	local v32 = 0
	local v42 = nil
	local v5 = true
	local v6 = HttpService:GenerateGUID(false)

	if v12 <= 0 then
		error("CreateNewSlider failed because numOfSteps (first arg) is 0 or negative, please supply a positive integer", 2)
	end

	local ValueChanged = Instance.new("BindableEvent")

	ValueChanged.Name = "ValueChanged"
	t2.SliderFrame = t.Create("ImageButton")({
		Name = "Slider",
		Image = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		ZIndex = 2,
		NextSelectionLeft = t2.SliderFrame,
		NextSelectionRight = t2.SliderFrame,
		Size = UDim2.new(0.6, 0, 0, 50),
		Position = UDim2.new(1, 0, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		SelectionImageObject = v7
	})
	t2.StepsContainer = t.Create("Frame")({
		Name = "StepsContainer",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, -100, 1, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Parent = t2.SliderFrame
	})

	local v72 = t.Create("ImageButton")({
		Name = "LeftButton",
		BackgroundTransparency = 1,
		Image = "",
		ZIndex = 3,
		Selectable = false,
		Active = true,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(0, 50, 0, 50),
		SelectionImageObject = v7,
		Parent = t2.SliderFrame
	})
	local v8 = t.Create("ImageButton")({
		Name = "RightButton",
		BackgroundTransparency = 1,
		Image = "",
		ZIndex = 3,
		Selectable = false,
		Active = true,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.new(0, 50, 0, 50),
		SelectionImageObject = v7,
		Parent = t2.SliderFrame
	})
	local v9 = t.Create("ImageLabel")
	local t3 = {
		Name = "LeftButton",
		BackgroundTransparency = 1,
		Image = "rbxasset://textures/ui/Settings/Slider/Less.png",
		ZIndex = 4,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 30, 0, 30),
		Parent = v72
	}

	t3.ImageColor3 = UserInputService.TouchEnabled and v4 or v3

	local v11 = v9(t3)
	local v122 = t.Create("ImageLabel")
	local t4 = {
		Name = "RightButton",
		BackgroundTransparency = 1,
		Image = "rbxasset://textures/ui/Settings/Slider/More.png",
		ZIndex = 4,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 30, 0, 30),
		Parent = v8
	}

	t4.ImageColor3 = UserInputService.TouchEnabled and v4 or v3

	local v14 = v122(t4)

	if not UserInputService.TouchEnabled then
		local function f15(p1) --[[ Line: 1720 | Upvalues: v3 (ref) ]]
			p1.ImageColor3 = v3
		end

		local function f16(p1) --[[ Line: 1722 | Upvalues: v4 (ref) ]]
			p1.ImageColor3 = v4
		end

		addHoverState(v72, v11, f15, f16)
		addHoverState(v8, v14, f15, f16)
	end

	t2.Steps = {}

	local v17 = getViewportSize()
	local _ = UserInputService.TouchEnabled and (if v17.Y < 500 then true else v17.X < 700)
	local v18 = 1 / v12

	for i = 1, v12 do
		local v19 = t.Create("ImageButton")({
			BackgroundTransparency = 0.36,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Active = false,
			Image = "",
			ZIndex = 3,
			Selectable = false,
			ImageTransparency = 0.36,
			Name = "Step" .. tostring(i),
			BackgroundColor3 = v1,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new((i - 1) * v18, 2, 0.5, 0),
			Size = UDim2.new(v18, -4, 0.48, 0),
			Parent = t2.StepsContainer,
			SelectionImageObject = v7
		})

		if v22 < i then
			v19.BackgroundColor3 = v2
		end

		if i == 1 or i == v12 then
			v19.BackgroundTransparency = 1
			v19.ScaleType = Enum.ScaleType.Slice
			v19.SliceCenter = Rect.new(3, 3, 32, 21)

			if i <= v22 then
				if i == 1 then
					v19.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png"
				else
					v19.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png"
				end
			elseif i == 1 then
				v19.Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png"
			else
				v19.Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png"
			end
		end

		t2.Steps[#t2.Steps + 1] = v19
	end

	local function hideSelection() --[[ hideSelection | Line: 1786 | Upvalues: v12 (copy), t2 (copy), v2 (ref) ]]
		for i = 1, v12 do
			t2.Steps[i].BackgroundColor3 = v2

			if i == 1 then
				t2.Steps[i].Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png"

				continue
			end

			if i == v12 then
				t2.Steps[i].Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png"
			end
		end
	end

	local function showSelection() --[[ showSelection | Line: 1796 | Upvalues: v12 (copy), v22 (ref), t2 (copy), v1 (ref) ]]
		for i = 1, v12 do
			if v22 < i then
				break
			end

			t2.Steps[i].BackgroundColor3 = v1

			if i == 1 then
				t2.Steps[i].Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png"

				continue
			end

			if i == v12 then
				t2.Steps[i].Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png"
			end
		end
	end

	local function modifySelection(p1) --[[ modifySelection | Line: 1809 | Upvalues: v12 (copy), t2 (copy) ]]
		for i = 1, v12 do
			if i == 1 or i == v12 then
				t2.Steps[i].ImageTransparency = p1

				continue
			end

			t2.Steps[i].BackgroundTransparency = p1
		end
	end

	local function setCurrentStep(p1) --[[ setCurrentStep | Line: 1819 | Upvalues: p3 (ref), v72 (copy), v8 (copy), v12 (copy), v22 (ref), hideSelection (copy), showSelection (copy), v42 (ref), ValueChanged (copy) ]]
		if not p3 then
			p3 = 0
		end

		v72.Visible = true
		v8.Visible = true

		if p1 <= p3 then
			p1 = p3
			v72.Visible = false
		end

		if v12 <= p1 then
			p1 = v12
			v8.Visible = false
		end

		if v22 ~= p1 then
			v22 = p1
			hideSelection()
			showSelection()
			v42 = tick()
			ValueChanged:Fire(p1)
		end
	end

	local function isActivateEvent(p1) --[[ isActivateEvent | Line: 1849 ]]
		if not p1 then
			return false
		end

		return if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then true elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false
	end

	local function mouseDownFunc(p1, p2, p3) --[[ mouseDownFunc | Line: 1860 | Upvalues: v5 (ref), VRService (ref), UserInputService (ref), GuiService (ref), t2 (copy), v32 (ref), v22 (ref), v12 (copy), setCurrentStep (copy) ]]
		if not v5 then
			return
		end

		if p1 == nil then
			return
		end

		if not (if p1 then if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then true elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then if p1.KeyCode == Enum.KeyCode.ButtonA then true else false else false else false) then
			return
		end

		if (if VRService.VREnabled then false elseif UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then false else true) and not VRService.VREnabled then
			GuiService.SelectedCoreObject = t2.SliderFrame
		end

		if VRService.VREnabled then
			v32 = 0
		elseif p3 then
			v32 = p2 - v22
		else
			v32 = 0

			local v3 = nil
			local v4 = UserInputService.InputChanged:Connect(function(p1) --[[ Line: 1886 | Upvalues: v12 (ref), t2 (ref), setCurrentStep (ref) ]]
				if p1.UserInputType ~= Enum.UserInputType.MouseMovement then
					return
				end

				local X = p1.Position.X

				for i = 1, v12 do
					local X2 = t2.Steps[i].AbsolutePosition.X

					if X2 <= X and X <= X2 + t2.Steps[i].AbsoluteSize.X then
						setCurrentStep(i)

						return
					end

					if i == 1 and X < X2 then
						setCurrentStep(0)

						return
					end

					if i == v12 and X2 <= X then
						setCurrentStep(i)

						return
					end
				end
			end)

			v3 = UserInputService.InputEnded:Connect(function(p1) --[[ Line: 1907 | Upvalues: v32 (ref), v3 (ref), v4 (ref) ]]
				if if p1 then if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then true elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false else false then
					v32 = 0
					v3:Disconnect()
					v4:Disconnect()
				end
			end)
		end

		setCurrentStep(p2)
	end

	local function mouseUpFunc(p1) --[[ mouseUpFunc | Line: 1924 | Upvalues: v5 (ref), v32 (ref) ]]
		if not v5 then
			return
		end

		if if p1 then if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then true elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false else false then
			v32 = 0
		end
	end

	local function touchClickFunc(p1, p2, p3) --[[ touchClickFunc | Line: 1935 | Upvalues: mouseDownFunc (copy) ]]
		mouseDownFunc(p1, p2, p3)
	end

	t2.ValueChanged = ValueChanged.Event
	function t2.SetValue(p1, p2) --[[ SetValue | Line: 1942 | Upvalues: setCurrentStep (copy) ]]
		setCurrentStep(p2)
	end
	function t2.GetValue(p1) --[[ GetValue | Line: 1946 | Upvalues: v22 (ref) ]]
		return v22
	end
	function t2.SetInteractable(p1, p2) --[[ SetInteractable | Line: 1950 | Upvalues: v32 (ref), v5 (ref), t2 (copy), hideSelection (copy), showSelection (copy) ]]
		v32 = 0
		v5 = p2
		t2.SliderFrame.Selectable = p2

		if p2 then
			showSelection()
		else
			hideSelection()
		end
	end
	function t2.SetZIndex(p1, p2) --[[ SetZIndex | Line: 1961 | Upvalues: v72 (copy), v8 (copy), v11 (copy), v14 (copy), t2 (copy) ]]
		v72.ZIndex = p2
		v8.ZIndex = p2
		v11.ZIndex = p2
		v14.ZIndex = p2

		for i = 1, #t2.Steps do
			t2.Steps[i].ZIndex = p2
		end
	end
	function t2.SetMinStep(p1, p2) --[[ SetMinStep | Line: 1972 | Upvalues: v12 (copy), p3 (ref), v22 (ref), v72 (copy), v8 (copy) ]]
		if p2 >= 0 and p2 <= v12 then
			p3 = p2
		end

		if v22 <= p3 then
			v22 = p3
			v72.Visible = false
		end

		if not (v12 <= v22) then
			return
		end

		v22 = v12
		v8.Visible = false
	end
	v72.InputBegan:Connect(function(p1) --[[ Line: 1989 | Upvalues: v22 (ref), v5 (ref), VRService (ref), UserInputService (ref), GuiService (ref), t2 (copy), v32 (ref), setCurrentStep (copy) ]]
		local v1 = v22 - 1

		if not v5 then
			return
		end

		if p1 == nil then
			return
		end

		if not (if p1 then if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then true elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false else false) then
			return
		end

		if (if VRService.VREnabled then false elseif UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then false else true) and not VRService.VREnabled then
			GuiService.SelectedCoreObject = t2.SliderFrame
		end

		v32 = if VRService.VREnabled then 0 else v1 - v22
		setCurrentStep(v1)
	end)
	v72.InputEnded:Connect(function(p1) --[[ Line: 1992 | Upvalues: v5 (ref), v32 (ref) ]]
		if not v5 then
			return
		end

		if if p1 then if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then true elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false else false then
			v32 = 0
		end
	end)
	v8.InputBegan:Connect(function(p1) --[[ Line: 1995 | Upvalues: v22 (ref), v5 (ref), VRService (ref), UserInputService (ref), GuiService (ref), t2 (copy), v32 (ref), setCurrentStep (copy) ]]
		local v1 = v22 + 1

		if not v5 then
			return
		end

		if p1 == nil then
			return
		end

		if not (if p1 then if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then true elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false else false) then
			return
		end

		if (if VRService.VREnabled then false elseif UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then false else true) and not VRService.VREnabled then
			GuiService.SelectedCoreObject = t2.SliderFrame
		end

		v32 = if VRService.VREnabled then 0 else v1 - v22
		setCurrentStep(v1)
	end)
	v8.InputEnded:Connect(function(p1) --[[ Line: 1998 | Upvalues: v5 (ref), v32 (ref) ]]
		if not v5 then
			return
		end

		if if p1 then if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then true elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false else false then
			v32 = 0
		end
	end)

	local function onVREnabled(p1) --[[ onVREnabled | Line: 2002 | Upvalues: VRService (ref), v72 (copy), v5 (ref), v8 (copy), t2 (copy), v12 (copy) ]]
		if p1 ~= "VREnabled" then
			return
		end

		if VRService.VREnabled then
			v72.Selectable = v5
			v8.Selectable = v5
			t2.SliderFrame.Selectable = v5

			for i = 1, v12 do
				t2.Steps[i].Selectable = v5
				t2.Steps[i].Active = v5
			end
		else
			v72.Selectable = false
			v8.Selectable = false
			t2.SliderFrame.Selectable = v5

			for j = 1, v12 do
				t2.Steps[j].Selectable = false
				t2.Steps[j].Active = false
			end
		end
	end

	VRService.Changed:Connect(onVREnabled)
	onVREnabled("VREnabled")

	for j = 1, v12 do
		t2.Steps[j].InputBegan:Connect(function(p1) --[[ Line: 2029 | Upvalues: mouseDownFunc (copy), j (copy) ]]
			mouseDownFunc(p1, j)
		end)
		t2.Steps[j].InputEnded:Connect(function(p1) --[[ Line: 2032 | Upvalues: v5 (ref), v32 (ref) ]]
			if not v5 then
				return
			end

			if if p1 then if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then true elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false else false then
				v32 = 0
			end
		end)
	end

	t2.SliderFrame.InputBegan:Connect(function(p1) --[[ Line: 2037 | Upvalues: VRService (ref), GuiService (ref), t2 (copy), mouseDownFunc (copy), v22 (ref) ]]
		if not VRService.VREnabled then
			mouseDownFunc(p1, v22)

			return
		end

		local SelectedCoreObject = GuiService.SelectedCoreObject

		if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(t2.SliderFrame.Parent) then
			mouseDownFunc(p1, v22)
		end
	end)
	t2.SliderFrame.InputEnded:Connect(function(p1) --[[ Line: 2046 | Upvalues: VRService (ref), GuiService (ref), t2 (copy), v5 (ref), v32 (ref) ]]
		if VRService.VREnabled then
			local SelectedCoreObject = GuiService.SelectedCoreObject

			if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(t2.SliderFrame.Parent)) then
				return
			end
		end

		if not v5 then
			return
		end

		if if p1 then if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then true elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false else false then
			v32 = 0
		end
	end)

	local function f20() --[[ Line: 2056 | Upvalues: v42 (ref), setCurrentStep (copy), v22 (ref), v32 (ref) ]]
		if v42 == nil then
			return
		end

		if not (tick() - v42 >= 0.2) then
			return
		end

		setCurrentStep(v22 + v32)
	end

	local v21 = true
	local t5 = {
		[Enum.KeyCode.Thumbstick1] = true,
		[Enum.KeyCode.DPadLeft] = -1,
		[Enum.KeyCode.DPadRight] = 1,
		[Enum.KeyCode.Left] = -1,
		[Enum.KeyCode.Right] = 1,
		[Enum.KeyCode.A] = -1,
		[Enum.KeyCode.D] = 1,
		[Enum.KeyCode.ButtonA] = true
	}

	UserInputService.InputBegan:Connect(function(p1) --[[ Line: 2082 | Upvalues: v5 (ref), v21 (ref), GuiService (ref), t2 (copy), t5 (copy), v32 (ref), setCurrentStep (copy), v22 (ref) ]]
		if not v5 then
			return
		end

		if not v21 then
			return
		end

		if p1.UserInputType ~= Enum.UserInputType.Gamepad1 and p1.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		local SelectedCoreObject = GuiService.SelectedCoreObject

		if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(t2.SliderFrame.Parent)) then
			return
		end

		if t5[p1.KeyCode] == -1 then
			v32 = -1
			setCurrentStep(v22 - 1)

			return
		end

		if t5[p1.KeyCode] ~= 1 then
			return
		end

		v32 = 1
		setCurrentStep(v22 + 1)
	end)
	UserInputService.InputEnded:Connect(function(p1) --[[ Line: 2110 | Upvalues: v5 (ref), GuiService (ref), t2 (copy), t5 (copy), v32 (ref) ]]
		if not v5 then
			return
		end

		if p1.UserInputType ~= Enum.UserInputType.Gamepad1 and p1.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		local SelectedCoreObject = GuiService.SelectedCoreObject

		if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(t2.SliderFrame.Parent)) then
			return
		end

		if not t5[p1.KeyCode] then
			return
		end

		v32 = 0
	end)
	UserInputService.InputChanged:Connect(function(p1) --[[ Line: 2131 | Upvalues: v5 (ref), v32 (ref), v21 (ref), GuiService (ref), t2 (copy), setCurrentStep (copy), v22 (ref) ]]
		if v5 and v21 then
			if p1.UserInputType ~= Enum.UserInputType.Gamepad1 then
				return
			end

			local SelectedCoreObject = GuiService.SelectedCoreObject

			if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(t2.SliderFrame.Parent)) then
				return
			end

			if p1.KeyCode ~= Enum.KeyCode.Thumbstick1 then
				return
			end

			if p1.Position.X > 0.8 and (p1.Delta.X > 0 and v32 ~= 1) then
				v32 = 1
				setCurrentStep(v22 + 1)

				return
			end

			if p1.Position.X < -0.8 and (p1.Delta.X < 0 and v32 ~= -1) then
				v32 = -1
				setCurrentStep(v22 - 1)

				return
			end

			if not (math.abs(p1.Position.X) < 0.8) then
				return
			end
		end

		v32 = 0
	end)

	local v222 = false

	GuiService.Changed:Connect(function(p1) --[[ Line: 2172 | Upvalues: GuiService (ref), t2 (copy), modifySelection (copy), v222 (ref), v42 (ref), RunService (ref), v6 (copy), f20 (copy) ]]
		if p1 ~= "SelectedCoreObject" then
			return
		end

		local SelectedCoreObject = GuiService.SelectedCoreObject

		if if SelectedCoreObject then SelectedCoreObject:IsDescendantOf(t2.SliderFrame.Parent) else SelectedCoreObject then
			modifySelection(0)

			if not v222 then
				v222 = true
				v42 = tick()
				RunService:BindToRenderStep(v6, Enum.RenderPriority.Input.Value + 1, f20)
			end
		else
			modifySelection(0.36)

			if not v222 then
				return
			end

			v222 = false
			RunService:UnbindFromRenderStep(v6)
		end
	end)
	t2.SliderFrame.AncestryChanged:Connect(function(p1, p2) --[[ Line: 2195 | Upvalues: v21 (ref) ]]
		v21 = p2
	end)
	setCurrentStep(v22)

	return t2
end

local v8 = if false then 90 else 50
local t4 = {}

local function AddNewRow(p1, p2, p3, p4, p5, p6) --[[ AddNewRow | Line: 2210 | Upvalues: t4 (copy), t (copy), v8 (ref), v7 (copy), v6 (copy), getViewportSize (copy), t2 (copy), CreateNewSlider (copy), CreateSelector (copy), CreateDropDown (copy), VRService (copy), UserInputService (copy), GuiService (copy), PlayerGui (copy) ]]
	local v1 = 0
	local v2 = if p3 == "TextBox" then false else true

	if t4[p1] then
		v1 = t4[p1]
	end

	local v3 = t.Create("ImageButton")({
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
		ImageTransparency = 1,
		Active = false,
		AutoButtonColor = false,
		ZIndex = 2,
		Selectable = false,
		Name = p2 .. "Frame",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(2, 2, 18, 18),
		Size = UDim2.new(1, 0, 0, v8),
		Position = UDim2.new(0, 0, 0, v1),
		SelectionImageObject = v7,
		Parent = p1.Page
	})

	v3.ImageColor3 = v3.BackgroundColor3

	if v3 and p6 then
		v3.Position = UDim2.new(v3.Position.X.Scale, v3.Position.X.Offset, v3.Position.Y.Scale, v3.Position.Y.Offset + p6)
	end

	local v4 = t.Create("TextLabel")({
		TextSize = 16,
		BackgroundTransparency = 1,
		ZIndex = 2,
		Name = p2 .. "Label",
		Text = p2,
		Font = Enum.Font.SourceSansBold,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(0, 200, 1, 0),
		Position = UDim2.new(0, 10, 0, 0),
		Parent = v3
	})
	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

	if v6 then
		v4.Size = UDim2.new(0.35, 0, 1, 0)
		v4.TextScaled = true
		v4.TextWrapped = true
		UITextSizeConstraint.Parent = v4
		UITextSizeConstraint.MaxTextSize = 16
	end

	if not v2 then
		v4.Text = ""
	end

	local function onResized(p1, p2) --[[ onResized | Line: 2275 | Upvalues: v4 (ref), UITextSizeConstraint (copy) ]]
		if p2 then
			v4.TextSize = 16
		else
			v4.TextSize = if false then 36 else 24
		end

		UITextSizeConstraint.MaxTextSize = v4.TextSize
	end

	getViewportSize()

	local v5 = getViewportSize()

	if if v5.Y > v5.X then true else false then
		v4.TextSize = 16
	else
		v4.TextSize = if false then 36 else 24
	end

	UITextSizeConstraint.MaxTextSize = v4.TextSize
	t2[v3] = onResized
	getViewportSize()

	local v82 = getViewportSize()

	if if v82.Y > v82.X then true else false then
		v4.TextSize = 16
	else
		v4.TextSize = if false then 36 else 24
	end

	UITextSizeConstraint.MaxTextSize = v4.TextSize

	local v11 = nil
	local v12 = nil

	if p3 == "Slider" then
		v12 = CreateNewSlider(p4, p5)
		v12.SliderFrame.Parent = v3
		v11 = v12.SliderFrame
	elseif p3 == "Selector" then
		v12 = CreateSelector(p4, p5)
		v12.SelectorFrame.Parent = v3
		v11 = v12.SelectorFrame
	elseif p3 == "DropDown" then
		v12 = CreateDropDown(p4, p5, p1.HubRef)
		v12.DropDownFrame.Parent = v3
		v11 = v12.DropDownFrame
	elseif p3 == "TextBox" then
		local v13 = false
		local v14 = false
		local v15 = t.Create("ImageLabel")({
			Image = "",
			BackgroundTransparency = 1
		})

		v12 = {
			HubRef = nil
		}

		local v16 = t.Create("TextBox")({
			BackgroundTransparency = 0.5,
			BorderSizePixel = 0,
			TextWrapped = true,
			TextSize = 24,
			ZIndex = 2,
			ClearTextOnFocus = false,
			AnchorPoint = Vector2.new(1, 0.5),
			Size = UDim2.new(0.6, 0, 1, 0),
			Position = UDim2.new(1, 0, 0.5, 0),
			Text = p2,
			TextColor3 = Color3.fromRGB(49, 49, 49),
			TextYAlignment = Enum.TextYAlignment.Top,
			TextXAlignment = Enum.TextXAlignment.Left,
			Font = Enum.Font.SourceSans,
			SelectionImageObject = v15,
			Parent = v3
		})

		v11 = v16
		v16.Focused:Connect(function() --[[ Line: 2331 | Upvalues: VRService (ref), UserInputService (ref), GuiService (ref), v16 (copy), p2 (copy) ]]
			if if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false then
				GuiService.SelectedCoreObject = v16
			end

			if v16.Text ~= p2 then
				return
			end

			v16.Text = ""
		end)
		v16.FocusLost:Connect(function(p1, p2) --[[ Line: 2340 | Upvalues: v14 (ref) ]]
			v14 = false
		end)

		if p6 then
			v16.Position = UDim2.new(v16.Position.X.Scale, v16.Position.X.Offset, v16.Position.Y.Scale, v16.Position.Y.Offset + p6)
		end

		v11.SelectionGained:Connect(function() --[[ Line: 2352 | Upvalues: VRService (ref), UserInputService (ref), v16 (copy), v12 (ref), v11 (ref) ]]
			if not (if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false) then
				return
			end

			v16.BackgroundTransparency = 0.1

			if not v12.HubRef then
				return
			end

			v12.HubRef:ScrollToFrame(v11)
		end)
		v11.SelectionLost:Connect(function() --[[ Line: 2361 | Upvalues: VRService (ref), UserInputService (ref), v16 (copy) ]]
			if not (if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false) then
				return
			end

			v16.BackgroundTransparency = 0.5
		end)

		local function f17() --[[ Line: 2367 | Upvalues: PlayerGui (ref), v11 (ref), VRService (ref), UserInputService (ref), p1 (copy), GuiService (ref), v13 (ref) ]]
			local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")

			if DropDownFullscreenFrame and DropDownFullscreenFrame.Visible then
				return
			end

			local v1 = v11

			if not (v1 and (v1.Visible and v1.ZIndex > 1)) then
				return
			end

			if not ((if VRService.VREnabled then false elseif UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then false else true) and p1.Active) then
				return
			end

			GuiService.SelectedCoreObject = v1
			v13 = true
		end

		local function processInput(p1) --[[ processInput | Line: 2386 | Upvalues: GuiService (ref), v11 (ref), v14 (ref), v16 (copy) ]]
			if p1.UserInputState ~= Enum.UserInputState.Begin or (p1.KeyCode ~= Enum.KeyCode.Return or GuiService.SelectedCoreObject ~= v11) then
				return
			end

			v14 = true
			v16:CaptureFocus()
		end

		v16.MouseEnter:Connect(f17)
		UserInputService.InputBegan:Connect(processInput)
	elseif p3 == "TextEntry" then
		local v18 = false
		local v19 = false
		local v20 = t.Create("ImageLabel")({
			Image = "",
			BackgroundTransparency = 1
		})

		v12 = {
			HubRef = nil
		}

		local v21 = t.Create("TextBox")({
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			TextWrapped = false,
			TextSize = 24,
			ZIndex = 2,
			ClearTextOnFocus = false,
			AnchorPoint = Vector2.new(1, 0.5),
			Size = UDim2.new(0.4, -10, 0, 40),
			Position = UDim2.new(1, 0, 0.5, 0),
			Text = p2,
			TextColor3 = Color3.fromRGB(178, 178, 178),
			TextYAlignment = Enum.TextYAlignment.Center,
			TextXAlignment = Enum.TextXAlignment.Center,
			Font = Enum.Font.SourceSans,
			SelectionImageObject = v20,
			Parent = v3
		})

		v11 = v21
		v21.Focused:Connect(function() --[[ Line: 2430 | Upvalues: VRService (ref), UserInputService (ref), GuiService (ref), v21 (copy), p2 (copy) ]]
			if if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false then
				GuiService.SelectedCoreObject = v21
			end

			if v21.Text ~= p2 then
				return
			end

			v21.Text = ""
		end)
		v21.FocusLost:Connect(function(p1, p2) --[[ Line: 2439 | Upvalues: v19 (ref) ]]
			v19 = false
		end)

		if p6 then
			v21.Position = UDim2.new(v21.Position.X.Scale, v21.Position.X.Offset, v21.Position.Y.Scale, v21.Position.Y.Offset + p6)
		end

		v11.SelectionGained:Connect(function() --[[ Line: 2451 | Upvalues: VRService (ref), UserInputService (ref), v21 (copy), v12 (ref), v11 (ref) ]]
			if not (if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false) then
				return
			end

			v21.BackgroundTransparency = 0.8

			if not v12.HubRef then
				return
			end

			v12.HubRef:ScrollToFrame(v11)
		end)
		v11.SelectionLost:Connect(function() --[[ Line: 2460 | Upvalues: VRService (ref), UserInputService (ref), v21 (copy) ]]
			if not (if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false) then
				return
			end

			v21.BackgroundTransparency = 1
		end)

		local function f22() --[[ Line: 2466 | Upvalues: PlayerGui (ref), v11 (ref), VRService (ref), UserInputService (ref), p1 (copy), GuiService (ref), v18 (ref) ]]
			local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")

			if DropDownFullscreenFrame and DropDownFullscreenFrame.Visible then
				return
			end

			local v1 = v11

			if not (v1 and (v1.Visible and v1.ZIndex > 1)) then
				return
			end

			if not ((if VRService.VREnabled then false elseif UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then false else true) and p1.Active) then
				return
			end

			GuiService.SelectedCoreObject = v1
			v18 = true
		end

		local function processInput(p1) --[[ processInput | Line: 2485 | Upvalues: GuiService (ref), v11 (ref), v19 (ref), v21 (copy) ]]
			if p1.UserInputState ~= Enum.UserInputState.Begin or (p1.KeyCode ~= Enum.KeyCode.Return or GuiService.SelectedCoreObject ~= v11) then
				return
			end

			v19 = true
			v21:CaptureFocus()
		end

		v3.MouseEnter:Connect(f22)
		function v12.SetZIndex(p1, p2) --[[ SetZIndex | Line: 2497 | Upvalues: v21 (copy) ]]
			v21.ZIndex = p2
		end
		function v12.SetInteractable(p1, p2) --[[ SetInteractable | Line: 2501 | Upvalues: v21 (copy) ]]
			v21.Selectable = p2

			if p2 then
				v21.TextColor3 = Color3.fromRGB(178, 178, 178)
				v21.ZIndex = 2
			else
				v21.TextColor3 = Color3.fromRGB(49, 49, 49)
				v21.ZIndex = 1
			end
		end
		function v12.SetValue(p1, p2) --[[ SetValue | Line: 2512 | Upvalues: v21 (copy) ]]
			v21.Text = p2
		end

		local ValueChanged = Instance.new("BindableEvent")

		ValueChanged.Name = "ValueChanged"
		v21.FocusLost:Connect(function() --[[ Line: 2519 | Upvalues: ValueChanged (copy), v21 (copy) ]]
			ValueChanged:Fire(v21.Text)
		end)
		v12.ValueChanged = ValueChanged.Event
		UserInputService.InputBegan:Connect(processInput)
	end

	v12.Name = p2 .. "ValueChanger"

	local sum = v1 + v8

	if p6 then
		sum = sum + p6
	end

	t4[p1] = sum

	if v2 then
		local function f23() --[[ Line: 2538 | Upvalues: PlayerGui (ref), v12 (ref), VRService (ref), UserInputService (ref), p1 (copy), GuiService (ref) ]]
			local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")

			if DropDownFullscreenFrame and DropDownFullscreenFrame.Visible then
				return
			end

			local v1 = v12.SliderFrame or v12.SliderFrame or v12.DropDownFrame or v12.SelectorFrame

			if not (v1 and (v1.Visible and v1.ZIndex > 1)) then
				return
			end

			if not ((if VRService.VREnabled then false elseif UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then false else true) and p1.Active) then
				return
			end

			GuiService.SelectedCoreObject = v1
		end

		v3.MouseEnter:Connect(f23)

		local function onVREnabled(p1) --[[ onVREnabled | Line: 2568 | Upvalues: VRService (ref), v3 (ref), v11 (ref), GuiService (ref) ]]
			if p1 ~= "VREnabled" then
				return
			end

			if VRService.VREnabled then
				v3.Selectable = true
				v3.Active = true
				v11.Active = true
				GuiService.Changed:Connect(function(p13) --[[ Line: 2574 | Upvalues: GuiService (ref), v3 (ref) ]]
					if p13 ~= "SelectedCoreObject" then
						return
					end

					local SelectedCoreObject = GuiService.SelectedCoreObject

					if SelectedCoreObject and (SelectedCoreObject == v3 or SelectedCoreObject:IsDescendantOf(v3)) then
						v3.ImageTransparency = 0.5
						v3.BackgroundTransparency = 1

						return
					end

					v3.ImageTransparency = 1
					v3.BackgroundTransparency = 1
				end)

				return
			end

			v3.Selectable = false
			v3.Active = false
		end

		VRService.Changed:Connect(onVREnabled)

		if VRService.VREnabled then
			v3.Selectable = true
			v3.Active = true
			v11.Active = true
			GuiService.Changed:Connect(function(p13) --[[ Line: 2574 | Upvalues: GuiService (ref), v3 (ref) ]]
				if p13 ~= "SelectedCoreObject" then
					return
				end

				local SelectedCoreObject = GuiService.SelectedCoreObject

				if SelectedCoreObject and (SelectedCoreObject == v3 or SelectedCoreObject:IsDescendantOf(v3)) then
					v3.ImageTransparency = 0.5
					v3.BackgroundTransparency = 1

					return
				end

				v3.ImageTransparency = 1
				v3.BackgroundTransparency = 1
			end)
		else
			v3.Selectable = false
			v3.Active = false
		end

		v11.SelectionGained:Connect(function() --[[ Line: 2595 | Upvalues: VRService (ref), UserInputService (ref), v3 (ref), v12 (ref) ]]
			if not (if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false) then
				return
			end

			if VRService.VREnabled then
				v3.ImageTransparency = 0.5
				v3.BackgroundTransparency = 1
			else
				v3.ImageTransparency = 1
				v3.BackgroundTransparency = 0.5
			end

			if not v12.HubRef then
				return
			end

			v12.HubRef:ScrollToFrame(v3)
		end)
		v11.SelectionLost:Connect(function() --[[ Line: 2610 | Upvalues: VRService (ref), UserInputService (ref), v3 (ref) ]]
			if not (if VRService.VREnabled then false else (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false) then
				return
			end

			v3.ImageTransparency = 1
			v3.BackgroundTransparency = 1
		end)
	end

	p1:AddRow(v3, v4, v12, p6, false)
	v12.Selection = v11

	return v3, v4, v12
end

local function AddNewRowObject(p1, p2, p3, p4) --[[ AddNewRowObject | Line: 2625 | Upvalues: t4 (copy), t (copy), v8 (ref), v7 (copy), t2 (copy), getViewportSize (copy), GuiService (copy), VRService (copy) ]]
	local v1 = if t4[p1] then t4[p1] else 0
	local v2 = t.Create("ImageButton")({
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
		ImageTransparency = 1,
		Active = false,
		AutoButtonColor = false,
		ZIndex = 2,
		Selectable = false,
		Name = p2 .. "Frame",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(10, 10, 10, 10),
		Size = UDim2.new(1, 0, 0, v8),
		Position = UDim2.new(0, 0, 0, v1),
		SelectionImageObject = v7,
		Parent = p1.Page
	})

	v2.ImageColor3 = v2.BackgroundColor3
	v2.SelectionGained:Connect(function() --[[ Line: 2650 | Upvalues: v2 (copy) ]]
		v2.BackgroundTransparency = 0.5
	end)
	v2.SelectionLost:Connect(function() --[[ Line: 2653 | Upvalues: v2 (copy) ]]
		v2.BackgroundTransparency = 1
	end)

	local v3 = t.Create("TextLabel")({
		TextSize = 16,
		BackgroundTransparency = 1,
		ZIndex = 2,
		Name = p2 .. "Label",
		Text = p2,
		Font = Enum.Font.SourceSansBold,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(0, 200, 1, 0),
		Position = UDim2.new(0, 10, 0, 0),
		Parent = v2
	})

	t2[v2] = function(p1, p2) --[[ onResized | Line: 2670 | Upvalues: v3 (copy) ]]
		if p2 then
			v3.TextSize = 16

			return
		end

		v3.TextSize = if false then 36 else 24
	end
	getViewportSize()

	local v4 = getViewportSize()

	if if v4.Y > v4.X then true else false then
		v3.TextSize = 16
	else
		v3.TextSize = if false then 36 else 24
	end

	if p4 then
		v2.Position = UDim2.new(v2.Position.X.Scale, v2.Position.X.Offset, v2.Position.Y.Scale, v2.Position.Y.Offset + p4)
	end

	local sum = v1 + v8

	if p4 then
		sum = sum + p4
	end

	t4[p1] = sum

	local function f7() --[[ Line: 2695 | Upvalues: v2 (copy), GuiService (ref) ]]
		if not v2.Visible then
			return
		end

		GuiService.SelectedCoreObject = v2
	end

	v2.MouseEnter:Connect(f7)
	p3.SelectionImageObject = v7
	p3.SelectionGained:Connect(function() --[[ Line: 2704 | Upvalues: VRService (ref), v2 (copy) ]]
		if VRService.VREnabled then
			v2.ImageTransparency = 0.5
			v2.BackgroundTransparency = 1
		else
			v2.ImageTransparency = 1
			v2.BackgroundTransparency = 0.5
		end
	end)
	p3.SelectionLost:Connect(function() --[[ Line: 2713 | Upvalues: v2 (copy) ]]
		v2.ImageTransparency = 1
		v2.BackgroundTransparency = 1
	end)
	p3.Parent = v2
	p1:AddRow(v2, v3, p3, p4, true)

	return v2
end

local t5 = {
	Create = function(p1, p2) --[[ Create | Line: 2727 ]]
		return function(p1) --[[ Line: 2728 | Upvalues: p2 (copy) ]]
			local v1 = Instance.new(p2)
			local v2 = nil

			for k, v in pairs(p1) do
				if type(k) == "number" then
					v.Parent = v1

					continue
				end

				if k == "Parent" then
					v2 = v

					continue
				end

				v1[k] = v
			end

			if v2 then
				v1.Parent = v2
			end

			return v1
		end
	end,
	RayPlaneIntersection = function(p1, p2, p3, p4) --[[ RayPlaneIntersection | Line: 2749 ]]
		local unit = p3.unit
		local Unit = p2.Unit
		local v1 = unit:Dot(Unit.Direction)

		if v1 == 0 then
			return nil
		end

		local v2 = unit:Dot(p4 - Unit.Origin) / v1

		if v2 < 0 then
			return nil
		end

		return Unit.Origin + Unit.Direction * v2
	end,
	GetEaseLinear = function(p1) --[[ GetEaseLinear | Line: 2767 | Upvalues: Linear (copy) ]]
		return Linear
	end,
	GetEaseOutQuad = function(p1) --[[ GetEaseOutQuad | Line: 2770 | Upvalues: EaseOutQuad (copy) ]]
		return EaseOutQuad
	end,
	GetEaseInOutQuad = function(p1) --[[ GetEaseInOutQuad | Line: 2773 | Upvalues: EaseInOutQuad (copy) ]]
		return EaseInOutQuad
	end,
	CreateNewSlider = function(p1, p2, p3, p4) --[[ CreateNewSlider | Line: 2777 | Upvalues: CreateNewSlider (copy) ]]
		return CreateNewSlider(p2, p3, p4)
	end,
	CreateNewSelector = function(p1, p2, p3) --[[ CreateNewSelector | Line: 2781 | Upvalues: CreateSelector (copy) ]]
		return CreateSelector(p2, p3)
	end,
	CreateNewDropDown = function(p1, p2, p3) --[[ CreateNewDropDown | Line: 2785 | Upvalues: CreateDropDown (copy) ]]
		return CreateDropDown(p2, p3, nil)
	end,
	AddNewRow = function(p1, p2, p3, p4, p5, p6, p7) --[[ AddNewRow | Line: 2789 | Upvalues: AddNewRow (copy) ]]
		return AddNewRow(p2, p3, p4, p5, p6, p7)
	end,
	AddNewRowObject = function(p1, p2, p3, p4, p5) --[[ AddNewRowObject | Line: 2793 | Upvalues: AddNewRowObject (copy) ]]
		return AddNewRowObject(p2, p3, p4, p5)
	end,
	ShowAlert = function(p1, p2, p3, p4, p5, p6) --[[ ShowAlert | Line: 2797 | Upvalues: ShowAlert (copy) ]]
		ShowAlert(p2, p3, p4, p5, p6)
	end,
	IsSmallTouchScreen = function(p1) --[[ IsSmallTouchScreen | Line: 2801 | Upvalues: getViewportSize (copy), UserInputService (copy) ]]
		local v1 = getViewportSize()

		return UserInputService.TouchEnabled and (if v1.Y < 500 then true else v1.X < 700)
	end,
	IsPortrait = function(p1) --[[ IsPortrait | Line: 2805 | Upvalues: getViewportSize (copy) ]]
		local v1 = getViewportSize()

		return v1.Y > v1.X
	end,
	MakeStyledButton = function(p1, p2, p3, p4, p5, p6, p7) --[[ MakeStyledButton | Line: 2809 | Upvalues: MakeButton (copy) ]]
		return MakeButton(p2, p3, p4, p5, p6, p7)
	end,
	MakeStyledImageButton = function(p1, p2, p3, p4, p5, p6, p7, p8) --[[ MakeStyledImageButton | Line: 2813 | Upvalues: MakeImageButton (copy) ]]
		return MakeImageButton(p2, p3, p4, p5, p6, p7, p8)
	end,
	AddButtonRow = function(p1, p2, p3, p4, p5, p6, p7) --[[ AddButtonRow | Line: 2817 | Upvalues: AddButtonRow (copy) ]]
		return AddButtonRow(p2, p3, p4, p5, p6, p7)
	end,
	CreateSignal = function(p1) --[[ CreateSignal | Line: 2821 | Upvalues: CreateSignal (copy) ]]
		return CreateSignal()
	end,
	UsesSelectedObject = function(p1) --[[ UsesSelectedObject | Line: 2825 | Upvalues: VRService (copy), UserInputService (copy) ]]
		if VRService.VREnabled then
			return false
		end

		return (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) and true or false
	end,
	TweenProperty = function(p1, p2, p3, p4, p5, p6, p7, p8) --[[ TweenProperty | Line: 2829 ]]
		return PropertyTweener(p2, p3, p4, p5, p6, p7, p8)
	end,
	OnResized = function(p1, p2, p3) --[[ OnResized | Line: 2833 | Upvalues: addOnResizedCallback (copy) ]]
		return addOnResizedCallback(p2, p3)
	end
}

function t5.FireOnResized(p1) --[[ FireOnResized | Line: 2837 | Upvalues: getViewportSize (copy), t5 (copy), t2 (copy) ]]
	local v1 = getViewportSize()
	local v2 = t5:IsPortrait()

	for k, v in pairs(t2) do
		v(v1, v2)
	end
end
function t5.Lerp(p1, p2, p3, p4) --[[ Lerp | Line: 2848 ]]
	return (1 - p2) * p3 + p2 * p4
end
function t5.Round(p1, p2) --[[ Round | Line: 2853 ]]
	return p2 % 1 >= 0.5 and math.ceil(p2) or math.floor(p2)
end

return t5