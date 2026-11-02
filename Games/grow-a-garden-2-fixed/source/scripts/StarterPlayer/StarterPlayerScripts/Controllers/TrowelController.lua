--credit to prince games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ContextActionService = game:GetService("ContextActionService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Gardens = workspace:WaitForChild("Gardens")
local HideCollectProximityPrompts = LocalPlayer:WaitForChild("HideCollectProximityPrompts")
local v1 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = false
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = false
local v21 = 0
local v22 = 0
local v23 = nil
local v24 = nil
local t2 = {}
local v25 = nil
local v26 = nil
local v27 = nil

function t.Init(p1) --[[ Init | Line: 61 ]] end
function t.ResolveButton(p1, p2) --[[ ResolveButton | Line: 65 ]]
	if not p2 then
		return nil
	end

	if p2:IsA("GuiButton") then
		return p2
	end

	local Button = p2:FindFirstChild("Button")

	if Button and Button:IsA("GuiButton") then
		return Button
	end

	local TextButton = p2:FindFirstChild("TextButton")

	if TextButton and TextButton:IsA("GuiButton") then
		return TextButton
	end

	return nil
end
function t.IsTouchOnButton(p1, p2, p3) --[[ IsTouchOnButton | Line: 86 ]]
	if not (p3 and p3.Visible) then
		return false
	end

	local AbsolutePosition = p3.AbsolutePosition
	local AbsoluteSize = p3.AbsoluteSize

	return if p2.X >= AbsolutePosition.X and (p2.X <= AbsolutePosition.X + AbsoluteSize.X and p2.Y >= AbsolutePosition.Y) then p2.Y <= AbsolutePosition.Y + AbsoluteSize.Y else false
end
function t.IsTouchOnMoveUi(p1, p2) --[[ IsTouchOnMoveUi | Line: 99 | Upvalues: v3 (ref), v4 (ref) ]]
	if not p2 or #p2 == 0 then
		return false
	end

	for v1, v2 in p2 do
		if p1:IsTouchOnButton(v2, v3) or p1:IsTouchOnButton(v2, v4) then
			return true
		end
	end

	return false
end
function t.BindGamepadRotateAction(p1) --[[ BindGamepadRotateAction | Line: 113 | Upvalues: ContextActionService (copy), v16 (ref), v14 (ref) ]]
	ContextActionService:UnbindAction("TrowelRotateAction")
	ContextActionService:BindActionAtPriority("TrowelRotateAction", function(p12, p2, p3) --[[ Line: 117 | Upvalues: v16 (ref), v14 (ref), p1 (copy) ]]
		if p2 ~= Enum.UserInputState.Begin then
			return Enum.ContextActionResult.Pass
		end

		if not (v16 and v14) then
			return Enum.ContextActionResult.Pass
		end

		if p3.KeyCode == Enum.KeyCode.ButtonL1 then
			p1:RotateMove(-1)

			return Enum.ContextActionResult.Sink
		end

		if p3.KeyCode == Enum.KeyCode.ButtonR1 then
			p1:RotateMove(1)

			return Enum.ContextActionResult.Sink
		end

		return Enum.ContextActionResult.Pass
	end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
end
function t.UnbindGamepadRotateAction(p1) --[[ UnbindGamepadRotateAction | Line: 143 | Upvalues: ContextActionService (copy) ]]
	ContextActionService:UnbindAction("TrowelRotateAction")
end
function t.BindMoveCancelAction(p1) --[[ BindMoveCancelAction | Line: 147 | Upvalues: ContextActionService (copy), v16 (ref), v14 (ref) ]]
	ContextActionService:UnbindAction("TrowelMoveCancelAction")
	ContextActionService:BindActionAtPriority("TrowelMoveCancelAction", function(p12, p2, p3) --[[ Line: 151 | Upvalues: v16 (ref), v14 (ref), p1 (copy) ]]
		if p2 ~= Enum.UserInputState.Begin then
			return Enum.ContextActionResult.Pass
		end

		if not (v16 and v14) then
			return Enum.ContextActionResult.Pass
		end

		if p3.KeyCode == Enum.KeyCode.C or p3.KeyCode == Enum.KeyCode.ButtonB then
			p1:CancelMove()

			return Enum.ContextActionResult.Sink
		end

		return Enum.ContextActionResult.Pass
	end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.C, Enum.KeyCode.ButtonB)
end
function t.UnbindMoveCancelAction(p1) --[[ UnbindMoveCancelAction | Line: 171 | Upvalues: ContextActionService (copy) ]]
	ContextActionService:UnbindAction("TrowelMoveCancelAction")
end
function t.SetMoveUiVisible(p1, p2) --[[ SetMoveUiVisible | Line: 175 | Upvalues: v3 (ref), v4 (ref), UserInputService (copy), v5 (ref), v6 (ref), v7 (ref) ]]
	if not v3 then
		return
	end

	v3.Visible = p2

	if v4 then
		v4.Visible = p2
	end

	if not p2 then
		return
	end

	local v1 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	local v2 = p1:IsUsingGamepad()

	if v5 then
		v5.Visible = v1
	end

	if v6 then
		v6.Visible = not v1 and not v2
	end

	if not v7 then
		return
	end

	v7.Visible = v2
end
function t.BindTrowelUi(p1, p2) --[[ BindTrowelUi | Line: 195 | Upvalues: v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), v7 (ref), v8 (ref), v16 (ref), v9 (ref) ]]
	local TrowelUI = p2:FindFirstChild("TrowelUI")

	if not TrowelUI then
		return
	end

	v2 = TrowelUI
	v3 = p1:ResolveButton(TrowelUI:FindFirstChild("InitialModeTrowel"):FindFirstChild("Cancel"))
	v4 = p1:ResolveButton(TrowelUI:FindFirstChild("InitialModeTrowel"):FindFirstChild("Rotate"))

	if v3 then
		local Text = v3:FindFirstChild("Text")

		if Text then
			v5 = Text:FindFirstChild("Mobile")
			v6 = Text:FindFirstChild("PC")
			v7 = Text:FindFirstChild("Console")
		end

		if v8 then
			v8:Disconnect()
			v8 = nil
		end

		v8 = v3.MouseButton1Click:Connect(function() --[[ Line: 217 | Upvalues: v16 (ref), p1 (copy) ]]
			if not v16 then
				return
			end

			p1:CancelMove()
		end)
	end

	if not v4 then
		return
	end

	if v9 then
		v9:Disconnect()
		v9 = nil
	end

	v9 = v4.MouseButton1Click:Connect(function() --[[ Line: 229 | Upvalues: v16 (ref), p1 (copy) ]]
		if not v16 then
			return
		end

		p1:RotateMove(1)
	end)
end
function t.Start(p1) --[[ Start | Line: 237 | Upvalues: LocalPlayer (copy), v16 (ref), UserInputService (copy), v15 (ref), Networking (copy), v25 (ref), v27 (ref), v26 (ref) ]]
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

	p1:BindTrowelUi(PlayerGui)
	PlayerGui.ChildAdded:Connect(function(p12) --[[ Line: 242 | Upvalues: p1 (copy), PlayerGui (copy), v16 (ref) ]]
		if p12.Name ~= "TrowelUI" then
			return
		end

		p1:BindTrowelUi(PlayerGui)
		p1:SetMoveUiVisible(v16)
	end)
	p1:SetMoveUiVisible(false)
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 251 | Upvalues: p1 (copy) ]]
		p1:OnInput(p12, p2)
	end)
	UserInputService.TouchTap:Connect(function(p12, p2) --[[ Line: 254 | Upvalues: p1 (copy) ]]
		if p2 then
			return
		end

		if not p1:IsTouchOnMoveUi(p12) then
			p1:OnPrimaryAction()
		end
	end)

	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 268 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	LocalPlayer:GetAttributeChangedSignal("PlotId"):Connect(function() --[[ Line: 272 | Upvalues: v15 (ref) ]]
		v15 = nil
	end)
	Networking.Trowel.MoveRejected.OnClientEvent:Connect(function(p1) --[[ Line: 276 | Upvalues: v25 (ref), v27 (ref), v26 (ref) ]]
		if not v25 or (not v27 or v26 ~= p1) then
			return
		end

		if v25.Parent then
			v25:PivotTo(v27)
		end

		v25 = nil
		v26 = nil
		v27 = nil
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 289 | Upvalues: v14 (ref), v16 (ref) ]]
	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("Trowel") then
			v14 = v2
			p1:StartHoverDetection()
		end
	end

	p2.ChildAdded:Connect(function(p12) --[[ Line: 299 | Upvalues: v14 (ref), p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("Trowel")) then
			return
		end

		v14 = p12
		p1:StartHoverDetection()
	end)
	p2.ChildRemoved:Connect(function(p12) --[[ Line: 306 | Upvalues: v14 (ref), v16 (ref), p1 (copy) ]]
		if not p12:IsA("Tool") or (not p12:GetAttribute("Trowel") or v14 ~= p12) then
			return
		end

		v14 = nil

		if v16 then
			p1:CancelMove()
		end

		p1:StopHoverDetection()
	end)

	local Humanoid = p2:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	Humanoid.Died:Connect(function() --[[ Line: 324 | Upvalues: v16 (ref), p1 (copy), Humanoid (copy), v14 (ref) ]]
		if v16 then
			p1:CancelMove()
		end

		Humanoid:UnequipTools()
		v14 = nil
		p1:StopHoverDetection()
	end)
end
function t.GetPlayerPlantsFolder(p1) --[[ GetPlayerPlantsFolder | Line: 335 | Upvalues: v15 (ref), LocalPlayer (copy), Gardens (copy) ]]
	if v15 then
		return v15
	end

	local v1 = LocalPlayer:GetAttribute("PlotId")

	if not v1 then
		return nil
	end

	local v2 = Gardens:FindFirstChild("Plot" .. tostring(v1))

	if v2 then
		v15 = v2:FindFirstChild("Plants")

		return v15
	end

	return nil
end
function t.GetPlayerPlot(p1) --[[ GetPlayerPlot | Line: 354 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")

	if v1 then
		return Gardens:FindFirstChild("Plot" .. tostring(v1))
	end

	return nil
end
function t.IsPartVisible(p1, p2) --[[ IsPartVisible | Line: 362 ]]
	return p2.Transparency < 1
end
function t.CreateRaycastParams(p1, p2) --[[ CreateRaycastParams | Line: 366 | Upvalues: LocalPlayer (copy) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Exclude

	local t = {}
	local Character = LocalPlayer.Character

	if Character then
		table.insert(t, Character)
	end

	if p2 then
		for v2, v3 in p2 do
			table.insert(t, v3)
		end
	end

	v1.FilterDescendantsInstances = t

	return v1
end
function t.RaycastIgnoreInvisible(p1, p2, p3, p4) --[[ RaycastIgnoreInvisible | Line: 385 | Upvalues: LocalPlayer (copy), v17 (ref) ]]
	local v1, v2, v3 = p2, p3, {}

	for i = 1, 10 do
		local v4 = workspace:Raycast(v1, v2, p4)

		if not v4 then
			break
		end

		if p1:IsPartVisible(v4.Instance) then
			return v4
		end

		table.insert(v3, v4.Instance)

		local t = {}
		local Character = LocalPlayer.Character

		if Character then
			table.insert(t, Character)
		end

		if v17 then
			table.insert(t, v17)
		end

		for v7, v8 in v3 do
			table.insert(t, v8)
		end

		p4.FilterDescendantsInstances = t

		local Magnitude = (v4.Position - v1).Magnitude

		v1 = v4.Position + p3.Unit * 0.01
		v2 = p3.Unit * (v2.Magnitude - Magnitude)

		if v2.Magnitude < 0.1 then
			break
		end
	end

	return nil
end
function t.IsUsingGamepad(p1) --[[ IsUsingGamepad | Line: 423 | Upvalues: UserInputService (copy) ]]
	local v1 = UserInputService:GetLastInputType()

	return if v1 == Enum.UserInputType.Gamepad1 or (v1 == Enum.UserInputType.Gamepad2 or v1 == Enum.UserInputType.Gamepad3) then true else v1 == Enum.UserInputType.Gamepad4
end
function t.GetMouseWorldRay(p1) --[[ GetMouseWorldRay | Line: 431 | Upvalues: LocalPlayer (copy), UserInputService (copy), CurrentCamera (copy) ]]
	if not p1:IsUsingGamepad() then
		local v1 = UserInputService:GetMouseLocation()
		local v2 = CurrentCamera:ViewportPointToRay(v1.X, v1.Y)

		return v2.Origin, v2.Direction * 5000
	end

	local Character = LocalPlayer.Character

	if not Character then
		return nil, nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		return HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 8 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0)
	end

	return nil, nil
end
function t.GetPlantTarget(p1, p2) --[[ GetPlantTarget | Line: 447 ]]
	if not p2 then
		return nil, nil
	end

	local v1 = p1:GetPlayerPlantsFolder()

	if not v1 then
		return nil, nil
	end

	local v2 = p2

	while v2 and v2 ~= workspace do
		local v3 = v2.Parent

		if v3 and v3.Name == "Fruits" then
			local v4 = v3.Parent

			if v4 and v4.Parent == v1 then
				return v4, v4.Name
			end
		end

		if v3 == v1 and v2:IsA("Model") then
			return v2, v2.Name
		end

		v2 = v3
	end

	return nil, nil
end
function t.ClearHighlight(p1) --[[ ClearHighlight | Line: 474 | Upvalues: v10 (ref), v11 (ref), v12 (ref) ]]
	if not v10 then
		v11 = nil
		v12 = nil

		return
	end

	v10:Destroy()
	v10 = nil
	v11 = nil
	v12 = nil
end
function t.DisableCollisions(p1, p2) --[[ DisableCollisions | Line: 487 | Upvalues: t2 (ref) ]]
	t2 = {}

	for v1, v2 in p2:GetDescendants() do
		if v2:IsA("BasePart") then
			t2[v2] = {
				canCollide = v2.CanCollide,
				anchored = v2.Anchored
			}
			v2.CanCollide = false
			v2.Anchored = true
		end
	end

	local PrimaryPart = p2.PrimaryPart

	if not PrimaryPart or t2[PrimaryPart] then
		return
	end

	t2[PrimaryPart] = {
		canCollide = PrimaryPart.CanCollide,
		anchored = PrimaryPart.Anchored
	}
	PrimaryPart.CanCollide = false
	PrimaryPart.Anchored = true
end
function t.RestoreCollisions(p1) --[[ RestoreCollisions | Line: 505 | Upvalues: t2 (ref) ]]
	for v1, v2 in t2 do
		if v1 and v1.Parent then
			v1.CanCollide = v2.canCollide
			v1.Anchored = v2.anchored
		end
	end

	t2 = {}
end

local v28 = 0

function t.UpdateHoverHighlight(p1) --[[ UpdateHoverHighlight | Line: 521 | Upvalues: v16 (ref), v28 (ref), v11 (ref), v10 (ref), v12 (ref) ]]
	if v16 then
		return
	end

	local v1, v2 = p1:GetMouseWorldRay()

	if not v1 then
		return
	end

	local v3 = p1:RaycastIgnoreInvisible(v1, v2, (p1:CreateRaycastParams()))
	local v5, v6 = p1:GetPlantTarget(if v3 then v3.Instance or nil else nil)

	v28 = v28 + 1

	if v28 >= 120 then
		v28 = 0
	end

	if v5 == v11 then
		return
	end

	p1:ClearHighlight()

	if not v5 then
		return
	end

	local Highlight = Instance.new("Highlight")

	Highlight.FillColor = Color3.fromRGB(0, 255, 0)
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 1
	Highlight.Parent = v5
	Highlight.Adornee = v5
	v10 = Highlight
	v11 = v5
	v12 = v6
end
function t.StartMove(p1) --[[ StartMove | Line: 561 | Upvalues: v11 (ref), v12 (ref), v16 (ref), v17 (ref), v18 (ref), v20 (ref), v23 (ref), v24 (ref), v21 (ref), v22 (ref), v19 (ref) ]]
	if not (v11 and v12) then
		return
	end

	v16 = true
	v17 = v11
	v18 = v12
	v20 = false
	v23 = nil
	v24 = v11:GetPivot()

	local PrimaryPart = v11.PrimaryPart

	if PrimaryPart then
		local _, v1, _2 = PrimaryPart.CFrame:ToEulerAnglesYXZ()

		v21 = math.deg(v1)
		v22 = PrimaryPart.Size.Y / 2
	else
		v21 = 0
		v22 = 0
	end

	p1:DisableCollisions(v11)
	p1:ClearHighlight()
	p1:SetMoveUiVisible(true)
	p1:BindGamepadRotateAction()
	p1:BindMoveCancelAction()

	local Highlight = Instance.new("Highlight")

	Highlight.FillColor = Color3.fromRGB(0, 255, 0)
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 1
	Highlight.Parent = v11
	Highlight.Adornee = v11
	v19 = Highlight
end
function t.UpdateMovingPlant(p1) --[[ UpdateMovingPlant | Line: 599 | Upvalues: v16 (ref), v17 (ref), v20 (ref), v19 (ref), v23 (ref), v21 (ref) ]]
	if not (v16 and v17) then
		return
	end

	for v1, v2 in v17:GetDescendants() do
		if v2:IsA("BasePart") and v2.CanCollide then
			v2.CanCollide = false
		end
	end

	local v3, v4 = p1:GetMouseWorldRay()

	if not v3 then
		return
	end

	local v5 = p1:RaycastIgnoreInvisible(v3, v4, (p1:CreateRaycastParams({ v17 })))

	if v5 then
		local v6 = p1:GetPlayerPlot()

		v20 = v5.Instance:HasTag("PlantArea") and (if v6 == nil then false else v5.Instance:IsDescendantOf(v6))
		v23 = v5.Position
		v17:PivotTo(CFrame.new(v5.Position.X, v5.Position.Y + 3, v5.Position.Z) * CFrame.Angles(0, math.rad(v21), 0))

		if not v19 then
			return
		end

		v19.FillColor = v20 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
	else
		v20 = false

		if not v19 then
			return
		end

		v19.FillColor = Color3.fromRGB(255, 0, 0)
	end
end
function t.LandPlant(p1, p2, p3, p4, p5, p6) --[[ LandPlant | Line: 641 | Upvalues: TweenService (copy), v1 (copy) ]]
	if not (p2 and p2.Parent) then
		return
	end

	local function restoreTheseCollisions() --[[ restoreTheseCollisions | Line: 646 | Upvalues: p6 (copy) ]]
		for v1, v2 in p6 do
			if v1 and v1.Parent then
				v1.CanCollide = v2.canCollide
				v1.Anchored = v2.anchored
			end
		end
	end

	local v12 = CFrame.new(p3.X, p3.Y, p3.Z) * CFrame.Angles(0, math.rad(p4), 0)

	if p2.PrimaryPart then
		local v2 = p2:GetPivot()
		local v3 = Instance.new("NumberValue")

		v3.Value = 0

		local v4 = TweenService:Create(v3, v1, {
			Value = 1
		})
		local v5 = v3.Changed:Connect(function() --[[ Line: 669 | Upvalues: p2 (copy), v2 (copy), v12 (copy), v3 (copy) ]]
			if not (p2 and p2.Parent) then
				return
			end

			p2:PivotTo(v2:Lerp(v12, v3.Value))
		end)

		v4.Completed:Connect(function() --[[ Line: 675 | Upvalues: v5 (ref), v3 (copy), p2 (copy), v12 (copy), p6 (copy) ]]
			v5:Disconnect()
			v3:Destroy()

			if p2 and p2.Parent then
				p2:PivotTo(v12)
			end

			for v1, v2 in p6 do
				if v1 and v1.Parent then
					v1.CanCollide = v2.canCollide
					v1.Anchored = v2.anchored
				end
			end
		end)
		v4:Play()

		return
	end

	p2:PivotTo(v12)

	for v6, v7 in p6 do
		if v6 and v6.Parent then
			v6.CanCollide = v7.canCollide
			v6.Anchored = v7.anchored
		end
	end
end
function t.ConfirmMove(p1) --[[ ConfirmMove | Line: 691 | Upvalues: v16 (ref), v17 (ref), v20 (ref), v23 (ref), Networking (copy), v18 (ref), v21 (ref), v22 (ref), v24 (ref), t2 (ref), v25 (ref), v26 (ref), v27 (ref) ]]
	if v16 and (v17 and (v20 and v23)) then
		Networking.Trowel.MovePlant:Fire(v18, v23, v21)

		local v1 = v17
		local v2 = v18
		local v7 = t2

		v25 = v1
		v26 = v2
		v27 = v24
		t2 = {}
		p1:EndMove(false)
		p1:LandPlant(v1, v23, v21, v22, v7)
		task.delay(2, function() --[[ Line: 714 | Upvalues: v26 (ref), v2 (copy), v25 (ref), v27 (ref) ]]
			if v26 ~= v2 then
				return
			end

			v25 = nil
			v26 = nil
			v27 = nil
		end)
	end
end
function t.RotateMove(p1, p2) --[[ RotateMove | Line: 723 | Upvalues: v16 (ref), v21 (ref) ]]
	if v16 then
		v21 = (v21 + p2 * 45) % 360
	end
end
function t.CancelMove(p1) --[[ CancelMove | Line: 730 | Upvalues: v16 (ref), v17 (ref), v24 (ref) ]]
	if not v16 then
		return
	end

	if v17 and v24 then
		v17:PivotTo(v24)
	end

	p1:EndMove(true)
end
function t.EndMove(p1, p2) --[[ EndMove | Line: 740 | Upvalues: v19 (ref), v16 (ref), v17 (ref), v18 (ref), v20 (ref), v23 (ref), v24 (ref) ]]
	if v19 then
		v19:Destroy()
		v19 = nil
	end

	if p2 ~= false then
		p1:RestoreCollisions()
	end

	v16 = false
	v17 = nil
	v18 = nil
	v20 = false
	v23 = nil
	v24 = nil
	p1:SetMoveUiVisible(false)
	p1:UnbindGamepadRotateAction()
	p1:UnbindMoveCancelAction()
end
function t.StartHoverDetection(p1) --[[ StartHoverDetection | Line: 767 | Upvalues: v13 (ref), HideCollectProximityPrompts (copy), RunService (copy), v16 (ref) ]]
	if not v13 then
		HideCollectProximityPrompts.Value = true
		v13 = RunService.RenderStepped:Connect(function() --[[ Line: 772 | Upvalues: v16 (ref), p1 (copy) ]]
			debug.profilebegin("Controllers/TrowelController/RenderStepped")

			if v16 then
				p1:UpdateMovingPlant()
			else
				p1:UpdateHoverHighlight()
			end

			debug.profileend()
		end)
	end
end
function t.StopHoverDetection(p1) --[[ StopHoverDetection | Line: 783 | Upvalues: HideCollectProximityPrompts (copy), v13 (ref), v16 (ref) ]]
	HideCollectProximityPrompts.Value = false

	if v13 then
		v13:Disconnect()
		v13 = nil
	end

	if v16 then
		p1:CancelMove()
	end

	p1:ClearHighlight()
end
function t.OnInput(p1, p2, p3) --[[ OnInput | Line: 801 | Upvalues: v14 (ref), v16 (ref) ]]
	if p3 then
		return
	end

	if not v14 then
		return
	end

	local v1 = if p2.UserInputType == Enum.UserInputType.MouseButton1 or p2.KeyCode == Enum.KeyCode.ButtonA then true elseif p2.KeyCode == Enum.KeyCode.ButtonR2 then true else false
	local v2 = if p2.KeyCode == Enum.KeyCode.C then true elseif p2.KeyCode == Enum.KeyCode.ButtonB then true else false
	local v3 = if p2.KeyCode == Enum.KeyCode.R or p2.KeyCode == Enum.KeyCode.ButtonL1 then true elseif p2.KeyCode == Enum.KeyCode.ButtonR1 then true else false

	if v2 and v16 then
		p1:CancelMove()

		return
	end

	if v3 and v16 then
		p1:RotateMove(if p2.KeyCode == Enum.KeyCode.ButtonL1 then -1 else 1)
	else
		if not v1 then
			return
		end

		p1:OnPrimaryAction()
	end
end
function t.OnPrimaryAction(p1) --[[ OnPrimaryAction | Line: 832 | Upvalues: v14 (ref), v16 (ref), v11 (ref), v12 (ref) ]]
	if not v14 then
		return
	end

	if v16 then
		p1:ConfirmMove()

		return
	end

	if not (v11 and v12) then
		return
	end

	p1:StartMove()
end

return t