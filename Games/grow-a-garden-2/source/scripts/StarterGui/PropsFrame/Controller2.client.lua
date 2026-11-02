--credit to quartz games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local GamepadService = game:GetService("GamepadService")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local PropData = require(ReplicatedStorage.SharedModules.PropData)
local PlayerStateClient = require(ReplicatedStorage.ClientModules.PlayerStateClient)
local PlacementGrid = require(ReplicatedStorage.ClientModules.PlacementGrid)
local Trove = require(ReplicatedStorage.ClientModules.Trove)
local GuiController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v1 = Color3.fromRGB(120, 255, 120)
local v2 = Color3.fromRGB(255, 80, 80)
local v3 = Color3.fromRGB(100, 200, 255)
local v4 = Color3.fromRGB(255, 60, 60)
local Gardens = workspace:WaitForChild("Gardens")
local Props = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Props")
local PropsFrame = PlayerGui:WaitForChild("PropsFrame")
local Items = PropsFrame:WaitForChild("Items")
local InitialModeButtonBar = PropsFrame:WaitForChild("InitialModeButtonBar")
local BackModeButtonBar = PropsFrame:WaitForChild("BackModeButtonBar")
local ScrollingFrame = Items:WaitForChild("ScrollingFrame")
local Template = ScrollingFrame:WaitForChild("Template")
local Build = InitialModeButtonBar:WaitForChild("Build")
local Delete = InitialModeButtonBar:WaitForChild("Delete")
local Back = BackModeButtonBar:WaitForChild("Back")
local ExitButton = Items:WaitForChild("Header"):WaitForChild("ExitButton")
local TouchControlFrame = PlayerGui:WaitForChild("BuildMobile"):WaitForChild("TouchControlFrame")
local BuildButton = TouchControlFrame:WaitForChild("BuildButton")

TouchControlFrame.Visible = false

local v5 = ReplicatedStorage.Assets.BillboardUIs:WaitForChild("CosmeticControl"):Clone()

v5.Parent = PlayerGui
v5.Enabled = false

local Frame = v5:WaitForChild("Frame")
local Tip = Frame:WaitForChild("Tip")
local Buttons = Frame:WaitForChild("Buttons")
local RotateBar = Frame:WaitForChild("RotateBar")
local Move = Buttons:WaitForChild("Move")
local Hover = Move:WaitForChild("Hover")
local Shade = Move:WaitForChild("Shade")
local Delete2 = Buttons:WaitForChild("Delete")
local Hover2 = Delete2:WaitForChild("Hover")
local Shade2 = Delete2:WaitForChild("Shade")
local Rotate = RotateBar:WaitForChild("Rotate")
local Hover3 = Rotate:WaitForChild("Hover")
local Shade3 = Rotate:WaitForChild("Shade")
local ArrowSlider = RotateBar:WaitForChild("ArrowSlider")
local v6 = Trove.new()
local v7 = Trove.new()
local v8 = nil
local v9 = false
local v10 = false
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = false
local v17 = false
local v18 = nil
local v19 = nil
local v20 = nil
local v21 = 0
local v22 = 0
local t = {}
local t2 = {}
local v23 = 0
local v24 = 0
local v25 = false
local v26 = nil
local v27 = nil
local v28 = nil
local v29 = 0
local v30 = false
local v31 = nil
local v32 = false
local v33 = nil
local v34 = nil
local v35 = nil
local t3 = {}
local v36 = false
local v37 = nil
local v38 = nil

local function UpdateIsMobile(p1) --[[ UpdateIsMobile | Line: 141 | Upvalues: UserInputService (copy), v9 (ref), v10 (ref) ]]
	local v1 = if p1 then p1 else UserInputService:GetLastInputType()

	if v1 == Enum.UserInputType.Touch then
		v9 = true
		v10 = false

		return
	end

	if v1 == Enum.UserInputType.MouseMovement or (v1 == Enum.UserInputType.MouseButton1 or (v1 == Enum.UserInputType.MouseButton2 or v1 == Enum.UserInputType.Keyboard)) then
		v9 = false
		v10 = false

		return
	end

	if not string.find(v1.Name, "Gamepad", 1, true) then
		return
	end

	v9 = false
	v10 = true
end

UpdateIsMobile()
UserInputService.LastInputTypeChanged:Connect(UpdateIsMobile)

local function GetCharacter() --[[ GetCharacter | Line: 162 | Upvalues: LocalPlayer (copy) ]]
	return LocalPlayer.Character
end

local function GetPlayerPlot() --[[ GetPlayerPlot | Line: 167 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")

	if v1 then
		return Gardens:FindFirstChild("Plot" .. tostring(v1))
	end

	return nil
end

local function GetPlotProps() --[[ GetPlotProps | Line: 174 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil

	if v2 then
		return v2:FindFirstChild("Props")
	end

	return nil
end

local function GetSpawnPoint() --[[ GetSpawnPoint | Line: 181 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil

	if not v2 then
		return nil
	end

	local SpawnPoint = v2:FindFirstChild("SpawnPoint")

	if SpawnPoint and SpawnPoint:IsA("BasePart") then
		return SpawnPoint
	end

	return nil
end

local function BuildPropAreaCache() --[[ BuildPropAreaCache | Line: 190 | Upvalues: LocalPlayer (copy), Gardens (copy), v38 (ref), CollectionService (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil

	if not v2 then
		v38 = nil

		return
	end

	local t = {}

	for v4, v5 in v2:GetDescendants() do
		if v5:IsA("BasePart") and CollectionService:HasTag(v5, "PropArea") then
			table.insert(t, v5)
		end
	end

	v38 = t
end

local function IsPositionInPropArea(p1) --[[ IsPositionInPropArea | Line: 206 | Upvalues: v38 (ref) ]]
	local v1 = v38

	if not v1 then
		return false
	end

	for v2, v3 in v1 do
		local v4 = v3.CFrame:PointToObjectSpace(p1)
		local v5 = v3.Size * 0.5

		if math.abs(v4.X) <= v5.X + 0.5 and math.abs(v4.Z) <= v5.Z + 0.5 then
			return true
		end
	end

	return false
end

local function IsPlacementValid(p1, p2) --[[ IsPlacementValid | Line: 221 | Upvalues: LocalPlayer (copy), Gardens (copy), CollectionService (copy), IsPositionInPropArea (copy) ]]
	if p2 then
		local v1 = LocalPlayer:GetAttribute("PlotId")
		local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil

		if v2 and p2:IsDescendantOf(v2) and not (CollectionService:HasTag(p2, "PropArea") or CollectionService:HasTag(p2, "PlantArea")) then
			return true
		end
	end

	return IsPositionInPropArea(p1)
end

local function GetPropCount(p1) --[[ GetPropCount | Line: 234 | Upvalues: v8 (ref) ]]
	if not v8 then
		return 0
	end

	local v1 = v8.Data.Inventory and v8.Data.Inventory.Props

	return if v1 then v1[p1] or 0 else 0
end

local function GetPropDataByName(p1) --[[ GetPropDataByName | Line: 241 | Upvalues: PropData (copy) ]]
	for v1, v2 in PropData.Data do
		if v2.PropName == p1 then
			return v2
		end
	end

	return nil
end

local v39 = RaycastParams.new()

v39.FilterType = Enum.RaycastFilterType.Exclude

local function UpdateRaycastParams(p1) --[[ UpdateRaycastParams | Line: 255 | Upvalues: LocalPlayer (copy), v39 (copy) ]]
	local t = {}
	local Character = LocalPlayer.Character

	if Character then
		table.insert(t, Character)
	end

	if p1 then
		table.insert(t, p1)
	end

	v39.FilterDescendantsInstances = t

	return v39
end

local function ShouldSkipHit(p1) --[[ ShouldSkipHit | Line: 269 | Upvalues: CollectionService (copy) ]]
	local v1 = p1.Instance

	if v1.Transparency >= 1 then
		return true
	end

	if not (CollectionService:HasTag(v1, "PropArea") or CollectionService:HasTag(v1, "PlantArea")) then
		return false
	end

	if math.abs(p1.Normal.Y) < 0.1 then
		return true
	end

	return false
end

local function RaycastFromMouse(p1) --[[ RaycastFromMouse | Line: 283 | Upvalues: LocalPlayer (copy), v39 (copy), UserInputService (copy), CurrentCamera (copy), CollectionService (copy) ]]
	local t = {}
	local Character = LocalPlayer.Character

	if Character then
		table.insert(t, Character)
	end

	if p1 then
		table.insert(t, p1)
	end

	v39.FilterDescendantsInstances = t

	local v1 = v39
	local v2 = UserInputService:GetMouseLocation()
	local v3 = CurrentCamera:ViewportPointToRay(v2.X, v2.Y)
	local v4 = table.clone(v1.FilterDescendantsInstances)

	for i = 1, 30 do
		local v5
		local v6 = workspace:Raycast(v3.Origin, v3.Direction * 1500, v1)

		if not v6 then
			break
		end

		local v7 = v6.Instance

		if v7.Transparency >= 1 then
			v5 = true
		else
			local v8 = CollectionService:HasTag(v7, "PropArea") or CollectionService:HasTag(v7, "PlantArea")

			v5 = if v8 then math.abs(v6.Normal.Y) < 0.1 else false
		end

		if not v5 then
			return v6
		end

		table.insert(v4, v6.Instance)
		v1.FilterDescendantsInstances = v4
	end

	return nil
end

local function SnapPositionToGrid(p1) --[[ SnapPositionToGrid | Line: 302 | Upvalues: LocalPlayer (copy), Gardens (copy), PlacementGrid (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil
	local v4

	if v2 then
		local SpawnPoint = v2:FindFirstChild("SpawnPoint")

		v4 = if SpawnPoint and SpawnPoint:IsA("BasePart") then SpawnPoint else nil
	else
		v4 = nil
	end

	if v4 then
		return PlacementGrid.SnapToGrid(p1, v4, 0.5)
	end

	return p1
end

local function GetGardenRotationY() --[[ GetGardenRotationY | Line: 309 | Upvalues: LocalPlayer (copy), Gardens (copy), PlacementGrid (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil
	local v4

	if v2 then
		local SpawnPoint = v2:FindFirstChild("SpawnPoint")

		v4 = if SpawnPoint and SpawnPoint:IsA("BasePart") then SpawnPoint else nil
	else
		v4 = nil
	end

	if v4 then
		return PlacementGrid.GetGardenRotationY(v4)
	end

	return 0
end

local function PositionModel(p1, p2, p3) --[[ PositionModel | Line: 316 | Upvalues: PlacementGrid (copy), LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil
	local v4, v5, v6

	if v2 then
		local SpawnPoint = v2:FindFirstChild("SpawnPoint")

		if SpawnPoint and SpawnPoint:IsA("BasePart") then
			v4 = SpawnPoint
			v5 = p1
			v6 = p2
		else
			v4 = nil
			v5 = p1
			v6 = p2
		end
	else
		v4 = nil
		v5 = p1
		v6 = p2
	end

	return PlacementGrid.PositionModel(v5, v6, if v4 then PlacementGrid.GetGardenRotationY(v4) else 0, p3)
end

local function ResolvePlacementGround(p1, p2, p3) --[[ ResolvePlacementGround | Line: 321 | Upvalues: LocalPlayer (copy), Gardens (copy), PlacementGrid (copy) ]]
	local Position = p1.Position
	local Normal = p1.Normal
	local PrimaryPart = p2.PrimaryPart

	if not PrimaryPart then
		return Position
	end

	local Size = PrimaryPart.Size
	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil
	local v4

	if v2 then
		local SpawnPoint = v2:FindFirstChild("SpawnPoint")

		v4 = if SpawnPoint and SpawnPoint:IsA("BasePart") then SpawnPoint else nil
	else
		v4 = nil
	end

	local function SnapXYZ(p1) --[[ SnapXYZ | Line: 330 | Upvalues: v4 (copy) ]]
		if v4 then
			local v1 = v4.CFrame:PointToObjectSpace(p1)

			return v4.CFrame:PointToWorldSpace((Vector3.new(math.round(v1.X / 0.5) * 0.5, math.round(v1.Y / 0.5) * 0.5, math.round(v1.Z / 0.5) * 0.5)))
		end

		return p1
	end

	local function SnapY(p1) --[[ SnapY | Line: 340 | Upvalues: v4 (copy) ]]
		if v4 then
			local v1 = v4.CFrame:PointToObjectSpace((Vector3.new(0, p1, 0)))

			return v4.CFrame:PointToWorldSpace((Vector3.new(v1.X, math.round(v1.Y / 0.5) * 0.5, v1.Z))).Y
		end

		return p1
	end

	local v5 = math.abs(Normal.X)
	local v6 = math.abs(Normal.Y)
	local v7 = math.abs(Normal.Z)

	if math.abs(math.max(v5, v6, v7) - v6) < 0.001 then
		return SnapXYZ(Position)
	end

	local v9 = Vector3.new(Normal.X, 0, Normal.Z)

	if v9.Magnitude < 0.001 then
		return SnapXYZ(Position)
	end

	local Unit = v9.Unit
	local Angles = CFrame.Angles
	local v11 = LocalPlayer:GetAttribute("PlotId")
	local v12 = if v11 then Gardens:FindFirstChild("Plot" .. tostring(v11)) else nil
	local v14

	if v12 then
		local SpawnPoint = v12:FindFirstChild("SpawnPoint")

		v14 = if SpawnPoint and SpawnPoint:IsA("BasePart") then SpawnPoint else nil
	else
		v14 = nil
	end

	local v15 = if v14 then PlacementGrid.GetGardenRotationY(v14) else 0
	local v17 = Angles(0, v15 + math.rad(p3), 0):VectorToObjectSpace(Unit)
	local v18 = math.abs(v17.X) * Size.X * 0.5
	local v19 = v18 + math.abs(v17.Z) * Size.Z * 0.5
	local v20 = Vector3.new(Position.X, 0, Position.Z) + Unit * v19
	local v21 = Position.Y - Size.Y * 0.5
	local v22

	if v4 then
		local v23 = v4.CFrame:PointToObjectSpace((Vector3.new(0, v21, 0)))

		v22 = v4.CFrame:PointToWorldSpace((Vector3.new(v23.X, math.round(v23.Y / 0.5) * 0.5, v23.Z))).Y
	else
		v22 = v21
	end

	local v27 = SnapXYZ(v20)

	if v7 <= v5 then
		return Vector3.new(v20.X, v22, v27.Z)
	end

	return Vector3.new(v27.X, v22, v20.Z)
end

local function GetPropUnderMouse() --[[ GetPropUnderMouse | Line: 375 | Upvalues: LocalPlayer (copy), Gardens (copy), UserInputService (copy), CurrentCamera (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil
	local v4 = if v2 then v2:FindFirstChild("Props") else nil

	if not v4 then
		return nil, nil
	end

	local v5 = RaycastParams.new()

	v5.FilterType = Enum.RaycastFilterType.Include
	v5.FilterDescendantsInstances = { v4 }

	local v6 = UserInputService:GetMouseLocation()
	local v7 = CurrentCamera:ViewportPointToRay(v6.X, v6.Y)
	local v8 = workspace:Raycast(v7.Origin, v7.Direction * 1500, v5)

	if not v8 then
		return nil, nil
	end

	local v9 = v8.Instance

	while v9 and v9 ~= v4 do
		if v9:IsA("Model") and v9:GetAttribute("PropId") then
			return v9, v9:GetAttribute("PropId")
		end

		v9 = v9.Parent
	end

	return nil, nil
end

local function PlayPropSFX(p1) --[[ PlayPropSFX | Line: 396 | Upvalues: LocalPlayer (copy), SoundService (copy), Debris (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if v1 then
		local Sound = Instance.new("Sound")

		Sound.SoundId = p1
		Sound.Volume = 1
		Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
		Sound.Parent = v1
		Sound:Play()
		Debris:AddItem(Sound, Sound.TimeLength / math.max(Sound.PlaybackSpeed, 0.01) + 1)
	end
end

local function HideAllUI() --[[ HideAllUI | Line: 410 | Upvalues: InitialModeButtonBar (copy), Items (copy), v5 (copy), TouchControlFrame (copy), BackModeButtonBar (copy) ]]
	InitialModeButtonBar.Visible = false
	Items.Visible = false
	v5.Enabled = false
	TouchControlFrame.Visible = false
	BackModeButtonBar.Visible = false
end

local function IsGuiObjectTrulyVisible(p1) --[[ IsGuiObjectTrulyVisible | Line: 419 | Upvalues: PlayerGui (copy) ]]
	if p1.BackgroundTransparency >= 1 and not (p1:IsA("TextLabel") or (p1:IsA("TextButton") or (p1:IsA("ImageLabel") or p1:IsA("ImageButton")))) then
		return false
	end

	if (p1:IsA("ImageLabel") or p1:IsA("ImageButton")) and (p1.ImageTransparency >= 1 and p1.BackgroundTransparency >= 1) then
		return false
	end

	if (p1:IsA("TextLabel") or p1:IsA("TextButton")) and (p1.TextTransparency >= 1 and p1.BackgroundTransparency >= 1) then
		return false
	end

	local v1 = p1

	while v1 and v1 ~= PlayerGui do
		if v1:IsA("GuiObject") and not v1.Visible then
			return false
		end

		if v1:IsA("ScreenGui") and not v1.Enabled then
			return false
		end

		v1 = v1.Parent
	end

	return true
end

local function IsInputOverUI() --[[ IsInputOverUI | Line: 451 | Upvalues: UserInputService (copy), PlayerGui (copy), IsGuiObjectTrulyVisible (copy), PropsFrame (copy) ]]
	local v1 = UserInputService:GetMouseLocation()

	for v2, v3 in PlayerGui:GetGuiObjectsAtPosition(v1.X, v1.Y) do
		if v3:IsA("GuiObject") and (IsGuiObjectTrulyVisible(v3) and v3:IsDescendantOf(PlayerGui)) then
			local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")

			if not (ProximityPrompts and v3:IsDescendantOf(ProximityPrompts) or v3:IsDescendantOf(PropsFrame)) then
				local v4 = v3:IsA("TextButton") or (v3:IsA("ImageButton") or (v3:IsA("TextBox") or v3:IsA("GuiButton") and v3.Active))

				if not v4 and v3.Active then
					v4 = true
				end

				if v4 then
					return true
				end
			end
		end
	end

	return false
end

local function DisableModelCollisions(p1) --[[ DisableModelCollisions | Line: 474 | Upvalues: t (ref), t2 (ref) ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") and v2.CanCollide then
			v2.CanCollide = false
			table.insert(t, v2)
		end

		if v2:IsA("Seat") then
			v2.Disabled = true
			table.insert(t2, v2)
		end
	end
end

local function RestoreModelCollisions() --[[ RestoreModelCollisions | Line: 488 | Upvalues: t (ref), t2 (ref) ]]
	for v1, v2 in t do
		if v2 and (v2:IsDescendantOf(workspace) and v2:IsA("BasePart")) then
			v2.CanCollide = true
		end
	end

	t = {}

	for v3, v4 in t2 do
		if v4 and (v4:IsDescendantOf(workspace) and v4:IsA("Seat")) then
			v4.Disabled = false
		end
	end

	t2 = {}
end

local function CreateSelectionBox(p1, p2) --[[ CreateSelectionBox | Line: 504 ]]
	local SelectionBox = Instance.new("SelectionBox")

	SelectionBox.Name = "SelectionBox"
	SelectionBox.Color3 = p2
	SelectionBox.LineThickness = 0.03
	SelectionBox.Transparency = 0.3
	SelectionBox.Adornee = p1.PrimaryPart or p1
	SelectionBox.Parent = p1

	return SelectionBox
end

local function SetSelectionBoxColor(p1, p2) --[[ SetSelectionBoxColor | Line: 516 ]]
	if not p1 then
		return
	end

	p1.Color3 = p2
end

local function DestroyDeleteHighlight() --[[ DestroyDeleteHighlight | Line: 521 | Upvalues: v34 (ref) ]]
	if not v34 then
		return
	end

	v34:Destroy()
	v34 = nil
end

local function SetDeleteHighlight(p1) --[[ SetDeleteHighlight | Line: 529 | Upvalues: v34 (ref), v4 (copy) ]]
	if v34 then
		v34:Destroy()
		v34 = nil
	end

	v34 = Instance.new("Highlight")
	v34.FillColor = v4
	v34.FillTransparency = 0.7
	v34.OutlineColor = v4
	v34.OutlineTransparency = 0
	v34.Adornee = p1
	v34.Parent = p1
end

local function SetSiblingButtonsBackground(p1, p2) --[[ SetSiblingButtonsBackground | Line: 541 | Upvalues: Buttons (copy), Rotate (copy) ]]
	for v1, v2 in Buttons:GetChildren() do
		if v2:IsA("Frame") and v2 ~= p2 then
			local bg = v2:FindFirstChild("bg")

			if bg then
				bg.Visible = not p1
			end
		end
	end

	local bg = Rotate:FindFirstChild("bg")

	if not bg then
		return
	end

	bg.Visible = not p1
end

local function SetMovingShadeState(p1) --[[ SetMovingShadeState | Line: 553 | Upvalues: Shade (copy), Tip (copy), UserInputService (copy), SetSiblingButtonsBackground (copy), Move (copy) ]]
	Shade.Visible = p1
	Tip.Visible = not p1
	UserInputService.MouseIconEnabled = not p1
	SetSiblingButtonsBackground(p1, Move)
end

local function SetRotatingShadeState(p1) --[[ SetRotatingShadeState | Line: 561 | Upvalues: Shade3 (copy), ArrowSlider (copy), Tip (copy), UserInputService (copy), Buttons (copy), v37 (ref), TweenService (copy), Rotate (copy) ]]
	Shade3.Visible = p1
	ArrowSlider.Visible = p1
	Tip.Visible = not p1
	UserInputService.MouseIconEnabled = not p1

	for v1, v2 in Buttons:GetChildren() do
		if v2:IsA("Frame") then
			local bg = v2:FindFirstChild("bg")

			if bg then
				bg.Visible = not p1
			end
		end
	end

	if p1 then
		return
	end

	if v37 then
		v37:Cancel()
		v37:Destroy()
		v37 = nil
	end

	local v3 = TweenService:Create(Rotate, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Position = UDim2.new(0, 0, 0, 0)
	})

	v37 = v3
	v3.Completed:Once(function() --[[ Line: 581 | Upvalues: v37 (ref), v3 (copy) ]]
		if v37 == v3 then
			v37 = nil
		end

		v3:Destroy()
	end)
	v3:Play()
end

local v40 = nil
local v41 = nil

local function FinishMove() --[[ FinishMove | Line: 597 | Upvalues: v16 (ref), v7 (copy), Shade (copy), Tip (copy), UserInputService (copy), SetSiblingButtonsBackground (copy), Move (copy), RestoreModelCollisions (copy), v13 (ref), v18 (ref), v20 (ref), v25 (ref), Networking (copy), v14 (ref), v21 (ref), PlayPropSFX (copy), v15 (ref), v3 (copy) ]]
	if not v16 then
		return
	end

	v16 = false
	v7:Clean()
	Shade.Visible = false
	Tip.Visible = true
	UserInputService.MouseIconEnabled = true
	SetSiblingButtonsBackground(false, Move)
	RestoreModelCollisions()

	if v13 then
		v13:SetAttribute("IsBeingMoved", false)
	end

	if v13 and (v13.PrimaryPart and (v18 and v13.PrimaryPart.CFrame ~= v18)) then
		if v20 and v25 then
			Networking.Prop.MoveProp:Fire(v14, v20, v21)
			PlayPropSFX("rbxassetid://136697624359338")
		else
			v13:PivotTo(v18)
		end
	end

	v20 = nil
	v25 = false

	local v1 = v15
	local v2 = v3

	if v1 then
		v1.Color3 = v2
	end

	v18 = nil
end

local function StartMove() --[[ StartMove | Line: 621 | Upvalues: v13 (ref), v16 (ref), v17 (ref), LocalPlayer (copy), v18 (ref), DisableModelCollisions (copy), BuildPropAreaCache (copy), v15 (ref), v1 (copy), Shade (copy), Tip (copy), UserInputService (copy), SetSiblingButtonsBackground (copy), Move (copy), v24 (ref), Gardens (copy), PlacementGrid (copy), v23 (ref), v7 (copy), RaycastFromMouse (copy), ResolvePlacementGround (copy), v20 (ref), v21 (ref), v25 (ref), IsPlacementValid (copy), v2 (copy), FinishMove (copy) ]]
	if not (v13 and v13.PrimaryPart) then
		return
	end

	if v16 or v17 then
		return
	end

	local Character = LocalPlayer.Character
	local v12 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

	if v12 and v12.Sit then
		v12.Sit = false
		task.wait()
	end

	if v12 and v12.Sit then
		return
	end

	v16 = true
	v18 = v13:GetPivot()
	v13:SetAttribute("IsBeingMoved", true)
	DisableModelCollisions(v13)
	BuildPropAreaCache()

	local v22 = v15
	local v3 = v1

	if v22 then
		v22.Color3 = v3
	end

	Shade.Visible = true
	Tip.Visible = false
	UserInputService.MouseIconEnabled = false
	SetSiblingButtonsBackground(true, Move)

	local v4 = LocalPlayer:GetAttribute("PlotId")
	local v5 = if v4 then Gardens:FindFirstChild("Plot" .. tostring(v4)) else nil
	local v72

	if v5 then
		local SpawnPoint = v5:FindFirstChild("SpawnPoint")

		v72 = if SpawnPoint and SpawnPoint:IsA("BasePart") then SpawnPoint else nil
	else
		v72 = nil
	end

	v24 = if v72 then PlacementGrid.GetGardenRotationY(v72) else 0

	local _, v10, _2 = v13.PrimaryPart.CFrame:ToEulerAnglesYXZ()
	local v11 = v10 - v24

	v23 = math.deg(v11)
	v7:Connect(UserInputService.InputChanged, function(p1) --[[ Line: 641 | Upvalues: v16 (ref), RaycastFromMouse (ref), v13 (ref), ResolvePlacementGround (ref), v23 (ref), PlacementGrid (ref), LocalPlayer (ref), Gardens (ref), v20 (ref), v21 (ref), v24 (ref), v25 (ref), IsPlacementValid (ref), v15 (ref), v1 (ref), v2 (ref) ]]
		if not v16 then
			return
		end

		if not (if p1.UserInputType == Enum.UserInputType.MouseMovement then true else p1.UserInputType == Enum.UserInputType.Touch) then
			return
		end

		local v22 = RaycastFromMouse(v13)

		if not v22 then
			return
		end

		local v3 = ResolvePlacementGround(v22, v13, v23)
		local v4 = v13
		local v6 = LocalPlayer:GetAttribute("PlotId")
		local v7 = if v6 then Gardens:FindFirstChild("Plot" .. tostring(v6)) else nil
		local v9, v10, v11

		if v7 then
			local SpawnPoint = v7:FindFirstChild("SpawnPoint")

			if SpawnPoint and SpawnPoint:IsA("BasePart") then
				v9 = SpawnPoint
				v10 = v4
				v11 = v3
			else
				v9 = nil
				v10 = v4
				v11 = v3
			end
		else
			v9 = nil
			v10 = v4
			v11 = v3
		end

		v13:PivotTo((PlacementGrid.PositionModel(v10, v11, if v9 then PlacementGrid.GetGardenRotationY(v9) else 0, v23)))
		v20 = v3
		v21 = math.deg(v24) + v23
		v25 = IsPlacementValid(v3, v22.Instance)

		local v152 = v15

		if not v152 then
			return
		end

		v152.Color3 = v25 and v1 or v2
	end)
	v7:Connect(UserInputService.InputEnded, function(p1) --[[ Line: 656 | Upvalues: FinishMove (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		FinishMove()
	end)
end

local function FinishRotate() --[[ FinishRotate | Line: 665 | Upvalues: v17 (ref), v7 (copy), SetRotatingShadeState (copy), RestoreModelCollisions (copy), v13 (ref), v18 (ref), Networking (copy), v14 (ref), PlayPropSFX (copy), v15 (ref), v3 (copy), v19 (ref) ]]
	if not v17 then
		return
	end

	v17 = false
	v7:Clean()
	SetRotatingShadeState(false)
	RestoreModelCollisions()

	if v13 then
		v13:SetAttribute("IsBeingMoved", false)
	end

	if v13 and (v13.PrimaryPart and (v18 and v13.PrimaryPart.CFrame ~= v18)) then
		local _, v1, _2 = v13.PrimaryPart.CFrame:ToEulerAnglesYXZ()

		Networking.Prop.MoveProp:Fire(v14, v13.PrimaryPart.Position, (math.deg(v1)))
		PlayPropSFX("rbxassetid://136697624359338")
	end

	local v2 = v15
	local v32 = v3

	if v2 then
		v2.Color3 = v32
	end

	v18 = nil
	v19 = nil
end

local function StartRotate() --[[ StartRotate | Line: 685 | Upvalues: v13 (ref), v16 (ref), v17 (ref), LocalPlayer (copy), v18 (ref), v19 (ref), v22 (ref), DisableModelCollisions (copy), Shade3 (copy), ArrowSlider (copy), Tip (copy), UserInputService (copy), Buttons (copy), v7 (copy), Rotate (copy), FinishRotate (copy) ]]
	if not (v13 and v13.PrimaryPart) then
		return
	end

	if v16 or v17 then
		return
	end

	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

	if v1 and v1.Sit then
		v1.Sit = false
		task.wait()
	end

	if v1 and v1.Sit then
		return
	end

	v17 = true
	v18 = v13:GetPivot()
	v19 = nil
	v22 = 0
	v13:SetAttribute("IsBeingMoved", true)
	DisableModelCollisions(v13)
	Shade3.Visible = true
	ArrowSlider.Visible = true
	Tip.Visible = false
	UserInputService.MouseIconEnabled = false

	for v2, v3 in Buttons:GetChildren() do
		if v3:IsA("Frame") then
			local bg = v3:FindFirstChild("bg")

			if bg then
				bg.Visible = false
			end
		end
	end

	v7:Connect(UserInputService.InputChanged, function(p1) --[[ Line: 702 | Upvalues: v17 (ref), UserInputService (ref), v19 (ref), Rotate (ref), v22 (ref), v18 (ref), v13 (ref) ]]
		if not v17 then
			return
		end

		if not (if p1.UserInputType == Enum.UserInputType.MouseMovement then true else p1.UserInputType == Enum.UserInputType.Touch) then
			return
		end

		local v2 = UserInputService:GetMouseLocation()

		if not v19 then
			v19 = v2.X
		end

		local v3 = v19 - v2.X

		Rotate.Position = UDim2.new(0, -v3, 0, 0)

		local v4 = math.floor(v3 / 15) * 15

		if v4 ~= v22 then
			v22 = v4
			v13:PivotTo(v18 * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -math.rad(v4)))
		end
	end)
	v7:Connect(UserInputService.InputEnded, function(p1) --[[ Line: 719 | Upvalues: FinishRotate (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		FinishRotate()
	end)
end

local function ClearAutoRotate() --[[ ClearAutoRotate | Line: 728 | Upvalues: v33 (ref) ]]
	if not v33 then
		return
	end

	task.cancel(v33)
	v33 = nil
end

local function StartAutoRotate() --[[ StartAutoRotate | Line: 736 | Upvalues: v33 (ref), v29 (ref) ]]
	if v33 then
		task.cancel(v33)
		v33 = nil
	end

	v33 = task.spawn(function() --[[ Line: 738 | Upvalues: v29 (ref) ]]
		task.wait(0.5)

		while true do
			v29 = (v29 + 15) % 360
			task.wait(0.08)
		end
	end)
end

local function CleanupPlacing() --[[ CleanupPlacing | Line: 748 | Upvalues: v33 (ref), v38 (ref), LocalPlayer (copy), Gardens (copy), v26 (ref), v27 (ref), v28 (ref), v29 (ref), v30 (ref), v31 (ref), v32 (ref), TouchControlFrame (copy) ]]
	if v33 then
		task.cancel(v33)
		v33 = nil
	end

	v38 = nil

	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil
	local v4 = if v2 then v2:FindFirstChild("Props") else nil

	if v4 then
		for v5, v6 in v4:GetDescendants() do
			if v6:IsA("ProximityPrompt") and v6.Name ~= "Reload" then
				v6.Enabled = true
			end
		end
	end

	if v26 then
		v26:Destroy()
		v26 = nil
	end

	v27 = nil
	v28 = nil
	v29 = 0
	v30 = false
	v31 = nil
	v32 = false
	TouchControlFrame.Visible = false
end

local function UpdatePlacingPreview() --[[ UpdatePlacingPreview | Line: 775 | Upvalues: v26 (ref), RaycastFromMouse (copy), ResolvePlacementGround (copy), v29 (ref), v31 (ref), PlacementGrid (copy), LocalPlayer (copy), Gardens (copy), v30 (ref), IsPlacementValid (copy), v27 (ref), v1 (copy), v2 (copy) ]]
	if not (v26 and v26.PrimaryPart) then
		return
	end

	local v12 = RaycastFromMouse(v26)

	if not v12 then
		return
	end

	local v22 = ResolvePlacementGround(v12, v26, v29)

	v31 = v22

	local v3 = v26
	local v5 = LocalPlayer:GetAttribute("PlotId")
	local v6 = if v5 then Gardens:FindFirstChild("Plot" .. tostring(v5)) else nil
	local v8, v9, v10

	if v6 then
		local SpawnPoint = v6:FindFirstChild("SpawnPoint")

		if SpawnPoint and SpawnPoint:IsA("BasePart") then
			v8 = SpawnPoint
			v9 = v3
			v10 = v22
		else
			v8 = nil
			v9 = v3
			v10 = v22
		end
	else
		v8 = nil
		v9 = v3
		v10 = v22
	end

	v26:PivotTo((PlacementGrid.PositionModel(v9, v10, if v8 then PlacementGrid.GetGardenRotationY(v8) else 0, v29)))
	v30 = IsPlacementValid(v22, v12.Instance)

	local v13 = v27

	if not v13 then
		return
	end

	v13.Color3 = v30 and v1 or v2
end

local function PlaceNewProp() --[[ PlaceNewProp | Line: 788 | Upvalues: v26 (ref), v28 (ref), v12 (ref), v30 (ref), v31 (ref), v8 (ref), v40 (ref), LocalPlayer (copy), Gardens (copy), PlacementGrid (copy), v29 (ref), Networking (copy), PlayPropSFX (copy), CleanupPlacing (copy) ]]
	if not (v26 and v28) then
		return
	end

	if not v12 then
		return
	end

	if not v30 then
		return
	end

	if not v31 then
		return
	end

	local v1 = v28
	local v2

	if v8 then
		local v3 = v8.Data.Inventory and v8.Data.Inventory.Props

		v2 = if v3 then v3[v1] or 0 else 0
	else
		v2 = 0
	end

	if not (v2 <= 0) then
		local v4 = LocalPlayer:GetAttribute("PlotId")
		local v5 = if v4 then Gardens:FindFirstChild("Plot" .. tostring(v4)) else nil
		local v7

		if v5 then
			local SpawnPoint = v5:FindFirstChild("SpawnPoint")

			v7 = if SpawnPoint and SpawnPoint:IsA("BasePart") then SpawnPoint else nil
		else
			v7 = nil
		end

		Networking.Prop.PlaceProp:Fire(v31, v28, v12, math.deg(if v7 then PlacementGrid.GetGardenRotationY(v7) else 0) + v29)
		PlayPropSFX("rbxassetid://136697624359338")

		if not (v2 - 1 <= 0) then
			return
		end

		CleanupPlacing()
	end

	v40()
end

local function DeselectProp() --[[ DeselectProp | Line: 808 | Upvalues: v15 (ref), v5 (copy), v13 (ref), v14 (ref), v7 (copy), v16 (ref), v17 (ref), v18 (ref), RestoreModelCollisions (copy) ]]
	if v15 then
		v15:Destroy()
		v15 = nil
	end

	v5.Enabled = false
	v5.Adornee = nil
	v13 = nil
	v14 = nil
	v7:Clean()
	v16 = false
	v17 = false
	v18 = nil
	RestoreModelCollisions()
end

local function SelectProp(p1, p2) --[[ SelectProp | Line: 825 | Upvalues: v13 (ref), v15 (ref), v5 (copy), v14 (ref), v7 (copy), v16 (ref), v17 (ref), v18 (ref), RestoreModelCollisions (copy), v3 (copy) ]]
	if v13 == p1 then
		return
	end

	if v13 then
		if v15 then
			v15:Destroy()
			v15 = nil
		end

		v5.Enabled = false
		v5.Adornee = nil
		v13 = nil
		v14 = nil
		v7:Clean()
		v16 = false
		v17 = false
		v18 = nil
		RestoreModelCollisions()
	end

	v13 = p1
	v14 = p2
	v16 = false
	v17 = false

	local SelectionBox = Instance.new("SelectionBox")

	SelectionBox.Name = "SelectionBox"
	SelectionBox.Color3 = v3
	SelectionBox.LineThickness = 0.03
	SelectionBox.Transparency = 0.3
	SelectionBox.Adornee = p1.PrimaryPart or p1
	SelectionBox.Parent = p1
	v15 = SelectionBox

	local v2 = p1.PrimaryPart or p1:FindFirstChildWhichIsA("BasePart")

	if not v2 then
		return
	end

	v5.Adornee = v2
	v5.Enabled = true
end

local function UpdateDeleteHover() --[[ UpdateDeleteHover | Line: 841 | Upvalues: GetPropUnderMouse (copy), v35 (ref), v34 (ref), v4 (copy) ]]
	local v1 = GetPropUnderMouse()

	if v1 == v35 then
		return
	end

	v35 = v1

	if v34 then
		v34:Destroy()
		v34 = nil
	end

	if not v1 then
		return
	end

	local v2 = v1

	if v34 then
		v34:Destroy()
		v34 = nil
	end

	v34 = Instance.new("Highlight")
	v34.FillColor = v4
	v34.FillTransparency = 0.7
	v34.OutlineColor = v4
	v34.OutlineTransparency = 0
	v34.Adornee = v2
	v34.Parent = v2
end

local function CleanupDelete() --[[ CleanupDelete | Line: 852 | Upvalues: v34 (ref), v35 (ref) ]]
	if v34 then
		v34:Destroy()
		v34 = nil
	end

	v35 = nil
end

local function SelectFirstPropTile() --[[ SelectFirstPropTile | Line: 858 | Upvalues: ScrollingFrame (copy), Template (copy), GuiService (copy), ExitButton (copy) ]]
	local v1 = nil
	local v2 = nil

	for v3, v4 in ScrollingFrame:GetChildren() do
		if v4:IsA("GuiObject") and (v4 ~= Template and v4.Visible) then
			local Button = v4:FindFirstChild("Button")

			if Button and Button:IsA("GuiButton") then
				local AbsolutePosition = v4.AbsolutePosition

				if not v1 or (AbsolutePosition.Y < v1.Y or AbsolutePosition.Y == v1.Y and AbsolutePosition.X < v1.X) then
					v1 = AbsolutePosition
					v2 = Button
				end
			end
		end
	end

	GuiService.SelectedObject = if v2 then v2 else ExitButton
end

local v42 = false

local function EnableInventoryGamepadSelection() --[[ EnableInventoryGamepadSelection | Line: 878 | Upvalues: v42 (ref), GuiService (copy), Items (copy), ContextActionService (copy), v40 (ref), v6 (copy), GamepadService (copy), SelectFirstPropTile (copy) ]]
	if v42 then
		return
	end

	v42 = true
	GuiService:AddSelectionParent("PropInventory", Items)
	ContextActionService:BindAction("PropInventoryBack", function(p1, p2) --[[ Line: 882 | Upvalues: v40 (ref) ]]
		if p2 == Enum.UserInputState.Begin then
			v40()

			return Enum.ContextActionResult.Sink
		end

		return Enum.ContextActionResult.Pass
	end, false, Enum.KeyCode.ButtonB)
	v6:Add(function() --[[ Line: 887 | Upvalues: v42 (ref), ContextActionService (ref), GuiService (ref), Items (ref) ]]
		v42 = false
		ContextActionService:UnbindAction("PropInventoryBack")
		GuiService:RemoveSelectionGroup("PropInventory")

		local SelectedObject = GuiService.SelectedObject

		if not (SelectedObject and SelectedObject:IsDescendantOf(Items)) then
			return
		end

		GuiService.SelectedObject = nil
	end)

	if GamepadService.GamepadCursorEnabled then
		task.delay(0.2, function() --[[ Line: 899 | Upvalues: v42 (ref), GamepadService (ref), SelectFirstPropTile (ref) ]]
			if v42 then
				GamepadService:DisableGamepadCursor()
				SelectFirstPropTile()
			end
		end)
	else
		SelectFirstPropTile()
	end
end

v40 = function() --[[ Line: 910 | Upvalues: GuiController (copy), PropsFrame (copy), CleanupPlacing (copy), v34 (ref), v35 (ref), v6 (copy), v11 (ref), InitialModeButtonBar (copy), BackModeButtonBar (copy), Items (copy), UserInputService (copy), v16 (ref), v17 (ref), IsInputOverUI (copy), GetPropUnderMouse (copy), v13 (ref), v15 (ref), v5 (copy), v14 (ref), v7 (copy), v18 (ref), RestoreModelCollisions (copy), v3 (copy) ]]
	if GuiController.Gui == PropsFrame then
		GuiController:Close()
		PropsFrame.Enabled = true
	end

	CleanupPlacing()

	if v34 then
		v34:Destroy()
		v34 = nil
	end

	v35 = nil
	v6:Clean()
	v11 = "Edit"
	InitialModeButtonBar.Visible = true
	BackModeButtonBar.Visible = false
	Items.Visible = false
	v6:Connect(UserInputService.InputBegan, function(p1, p2) --[[ Line: 922 | Upvalues: v11 (ref), v16 (ref), v17 (ref), IsInputOverUI (ref), GetPropUnderMouse (ref), v13 (ref), v15 (ref), v5 (ref), v14 (ref), v7 (ref), v18 (ref), RestoreModelCollisions (ref), v3 (ref) ]]
		if p2 then
			return
		end

		if v11 ~= "Edit" then
			return
		end

		if if p1.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p1.UserInputType == Enum.UserInputType.Touch then true else false then
			if v16 or v17 then
				return
			end

			if IsInputOverUI() then
				return
			end

			local v2, v32 = GetPropUnderMouse()

			if v2 and v32 then
				if v13 ~= v2 then
					if v13 then
						if v15 then
							v15:Destroy()
							v15 = nil
						end

						v5.Enabled = false
						v5.Adornee = nil
						v13 = nil
						v14 = nil
						v7:Clean()
						v16 = false
						v17 = false
						v18 = nil
						RestoreModelCollisions()
					end

					v13 = v2
					v14 = v32
					v16 = false
					v17 = false

					local SelectionBox = Instance.new("SelectionBox")

					SelectionBox.Name = "SelectionBox"
					SelectionBox.Color3 = v3
					SelectionBox.LineThickness = 0.03
					SelectionBox.Transparency = 0.3
					SelectionBox.Adornee = v2.PrimaryPart or v2
					SelectionBox.Parent = v2
					v15 = SelectionBox

					local v52 = v2.PrimaryPart or v2:FindFirstChildWhichIsA("BasePart")

					if v52 then
						v5.Adornee = v52
						v5.Enabled = true
					end
				end
			else
				if v15 then
					v15:Destroy()
					v15 = nil
				end

				v5.Enabled = false
				v5.Adornee = nil
				v13 = nil
				v14 = nil
				v7:Clean()
				v16 = false
				v17 = false
				v18 = nil
				RestoreModelCollisions()
			end
		end

		if p1.KeyCode ~= Enum.KeyCode.Escape and p1.KeyCode ~= Enum.KeyCode.ButtonB or not v13 then
			return
		end

		if v15 then
			v15:Destroy()
			v15 = nil
		end

		v5.Enabled = false
		v5.Adornee = nil
		v13 = nil
		v14 = nil
		v7:Clean()
		v16 = false
		v17 = false
		v18 = nil
		RestoreModelCollisions()
	end)
end

local function f43() --[[ Line: 944 | Upvalues: v15 (ref), v5 (copy), v13 (ref), v14 (ref), v7 (copy), v16 (ref), v17 (ref), v18 (ref), RestoreModelCollisions (copy), CleanupPlacing (copy), v34 (ref), v35 (ref), v6 (copy), v11 (ref), InitialModeButtonBar (copy), Items (copy), GuiController (copy), UserInputService (copy), v40 (ref), v10 (ref), EnableInventoryGamepadSelection (copy) ]]
	if v15 then
		v15:Destroy()
		v15 = nil
	end

	v5.Enabled = false
	v5.Adornee = nil
	v13 = nil
	v14 = nil
	v7:Clean()
	v16 = false
	v17 = false
	v18 = nil
	RestoreModelCollisions()
	CleanupPlacing()

	if v34 then
		v34:Destroy()
		v34 = nil
	end

	v35 = nil
	v6:Clean()
	v11 = "Build"
	InitialModeButtonBar.Visible = false
	Items.Visible = true
	GuiController:Open("PropsFrame")
	v6:Connect(UserInputService.InputBegan, function(p1, p2) --[[ Line: 953 | Upvalues: v11 (ref), v40 (ref) ]]
		if p2 then
			return
		end

		if v11 ~= "Build" then
			return
		end

		if p1.KeyCode ~= Enum.KeyCode.Escape and p1.KeyCode ~= Enum.KeyCode.ButtonB then
			return
		end

		v40()
	end)

	if v10 then
		EnableInventoryGamepadSelection()
	end

	v6:Connect(UserInputService.LastInputTypeChanged, function(p1) --[[ Line: 964 | Upvalues: v11 (ref), EnableInventoryGamepadSelection (ref) ]]
		if v11 ~= "Build" then
			return
		end

		if not string.find(p1.Name, "Gamepad", 1, true) then
			return
		end

		EnableInventoryGamepadSelection()
	end)
end

local function f44(p1) --[[ Line: 973 | Upvalues: v12 (ref), v8 (ref), GuiController (copy), PropsFrame (copy), v15 (ref), v5 (copy), v13 (ref), v14 (ref), v7 (copy), v16 (ref), v17 (ref), v18 (ref), RestoreModelCollisions (copy), CleanupPlacing (copy), v6 (copy), v11 (ref), v28 (ref), v29 (ref), v30 (ref), v32 (ref), Items (copy), InitialModeButtonBar (copy), BackModeButtonBar (copy), TouchControlFrame (copy), v9 (ref), Props (copy), f43 (ref), v26 (ref), v27 (ref), v1 (copy), BuildPropAreaCache (copy), LocalPlayer (copy), Gardens (copy), UserInputService (copy), RunService (copy), UpdatePlacingPreview (copy), IsInputOverUI (copy), PlaceNewProp (copy), v33 (ref), v41 (ref), v40 (ref) ]]
	if not v12 then
		return
	end

	local v19

	if v8 then
		local v2 = v8.Data.Inventory and v8.Data.Inventory.Props

		v19 = v2 and v2[p1] or 0
	else
		v19 = 0
	end

	if v19 <= 0 then
		return
	end

	if GuiController.Gui == PropsFrame then
		GuiController:Close()
		PropsFrame.Enabled = true
	end

	if v15 then
		v15:Destroy()
		v15 = nil
	end

	v5.Enabled = false
	v5.Adornee = nil
	v13 = nil
	v14 = nil
	v7:Clean()
	v16 = false
	v17 = false
	v18 = nil
	RestoreModelCollisions()
	CleanupPlacing()
	v6:Clean()
	v11 = "Placing"
	v28 = p1
	v29 = 0
	v30 = false
	v32 = false
	Items.Visible = false
	InitialModeButtonBar.Visible = false
	BackModeButtonBar.Visible = true
	TouchControlFrame.Visible = v9

	local v3 = Props:FindFirstChild(p1)

	if not v3 then
		f43()

		return
	end

	v26 = v3:Clone()

	for v4, v52 in v26:GetDescendants() do
		if v52:IsA("BasePart") then
			if v52.Transparency < 1 then
				v52.Transparency = 0.5
			end

			v52.CanCollide = false
			v52.CanQuery = false
			v52.CanTouch = false
			v52.Anchored = true
		end

		if v52:IsA("ProximityPrompt") then
			v52.Enabled = false
		end
	end

	if v26.PrimaryPart then
		v26.PrimaryPart.Transparency = 1
	end

	v26.Name = "PropPreview"
	v26.Parent = workspace

	local v62 = v26
	local SelectionBox = Instance.new("SelectionBox")

	SelectionBox.Name = "SelectionBox"
	SelectionBox.Color3 = v1
	SelectionBox.LineThickness = 0.03
	SelectionBox.Transparency = 0.3
	SelectionBox.Adornee = v62.PrimaryPart or v62
	SelectionBox.Parent = v62
	v27 = SelectionBox
	BuildPropAreaCache()

	local v82 = LocalPlayer:GetAttribute("PlotId")
	local v92 = if v82 then Gardens:FindFirstChild("Plot" .. tostring(v82)) else nil
	local v112 = if v92 then v92:FindFirstChild("Props") else nil

	if v112 then
		for v122, v132 in v112:GetDescendants() do
			if v132:IsA("ProximityPrompt") then
				v132.Enabled = false
			end
		end
	end

	if v9 then
		v6:Connect(UserInputService.TouchStarted, function(p1, p2) --[[ Line: 1023 | Upvalues: v32 (ref) ]]
			if not p2 then
				v32 = true
			end
		end)
		v6:Connect(UserInputService.TouchEnded, function() --[[ Line: 1027 | Upvalues: v32 (ref) ]]
			v32 = false
		end)
		v6:Connect(RunService.RenderStepped, function() --[[ Line: 1030 | Upvalues: v32 (ref), UpdatePlacingPreview (ref) ]]
			if not v32 then
				return
			end

			UpdatePlacingPreview()
		end)
	else
		v6:Connect(RunService.RenderStepped, UpdatePlacingPreview)
	end

	v6:Connect(UserInputService.InputBegan, function(p1, p2) --[[ Line: 1036 | Upvalues: v11 (ref), v9 (ref), IsInputOverUI (ref), PlaceNewProp (ref), v29 (ref), v33 (ref), f43 (ref) ]]
		if v11 ~= "Placing" then
			return
		end

		if p2 then
			return
		end

		if (if p1.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p1.KeyCode == Enum.KeyCode.ButtonR2 then true else false) and not v9 then
			if not IsInputOverUI() then
				PlaceNewProp()
			end
		elseif p1.KeyCode == Enum.KeyCode.R or p1.KeyCode == Enum.KeyCode.ButtonR1 then
			v29 = (v29 + 15) % 360

			if v33 then
				task.cancel(v33)
				v33 = nil
			end

			v33 = task.spawn(function() --[[ Line: 738 | Upvalues: v29 (ref) ]]
				task.wait(0.5)

				while true do
					v29 = (v29 + 15) % 360
					task.wait(0.08)
				end
			end)
		elseif p1.KeyCode == Enum.KeyCode.Escape or p1.KeyCode == Enum.KeyCode.ButtonB then
			f43()
		end
	end)
	v6:Connect(UserInputService.InputEnded, function(p1) --[[ Line: 1056 | Upvalues: v33 (ref) ]]
		if p1.KeyCode ~= Enum.KeyCode.R and p1.KeyCode ~= Enum.KeyCode.ButtonR1 or not v33 then
			return
		end

		task.cancel(v33)
		v33 = nil
	end)

	if v12 then
		v6:Connect(v12.AttributeChanged, function(p1) --[[ Line: 1062 | Upvalues: v12 (ref), v41 (ref), LocalPlayer (ref) ]]
			if p1 ~= "RemainingCount" then
				return
			end

			local v1 = v12:GetAttribute("RemainingCount")

			if not (v1 and v1 <= 0) then
				return
			end

			v41()

			local Character = LocalPlayer.Character
			local v2 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

			if not v2 then
				return
			end

			v2:UnequipTools()
		end)
	end

	if not v8 then
		return
	end

	v6:Add((v8:OnChange(function(p12, p2) --[[ Line: 1074 | Upvalues: p1 (copy), v8 (ref), v11 (ref), v28 (ref), v40 (ref) ]]
		if not p2 or (p2[1] ~= "Inventory" or (p2[2] ~= "Props" or p2[3] ~= p1)) then
			return
		end

		if not ((if v8.Data.Inventory and v8.Data.Inventory.Props then v8.Data.Inventory.Props[p1] or 0 else 0) <= 0) or (v11 ~= "Placing" or v28 ~= p1) then
			return
		end

		v40()
	end)))
end

local function f45() --[[ Line: 1086 | Upvalues: v15 (ref), v5 (copy), v13 (ref), v14 (ref), v7 (copy), v16 (ref), v17 (ref), v18 (ref), RestoreModelCollisions (copy), CleanupPlacing (copy), v34 (ref), v35 (ref), v6 (copy), v11 (ref), InitialModeButtonBar (copy), Items (copy), BackModeButtonBar (copy), RunService (copy), UpdateDeleteHover (copy), UserInputService (copy), GetPropUnderMouse (copy), Networking (copy), PlayPropSFX (copy), v40 (ref) ]]
	if v15 then
		v15:Destroy()
		v15 = nil
	end

	v5.Enabled = false
	v5.Adornee = nil
	v13 = nil
	v14 = nil
	v7:Clean()
	v16 = false
	v17 = false
	v18 = nil
	RestoreModelCollisions()
	CleanupPlacing()

	if v34 then
		v34:Destroy()
		v34 = nil
	end

	v35 = nil
	v6:Clean()
	v11 = "Erase"
	InitialModeButtonBar.Visible = false
	Items.Visible = false
	BackModeButtonBar.Visible = true
	v6:Connect(RunService.RenderStepped, UpdateDeleteHover)
	v6:Connect(UserInputService.InputBegan, function(p1, p2) --[[ Line: 1096 | Upvalues: v11 (ref), GetPropUnderMouse (ref), v34 (ref), v35 (ref), Networking (ref), PlayPropSFX (ref), v40 (ref) ]]
		if p2 then
			return
		end

		if v11 ~= "Erase" then
			return
		end

		if if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then true elseif p1.KeyCode == Enum.KeyCode.ButtonR2 then true else false then
			local v2, v3 = GetPropUnderMouse()

			if not (v2 and v3) then
				return
			end

			if v34 then
				v34:Destroy()
				v34 = nil
			end

			v35 = nil
			Networking.Prop.PickupProp:Fire(v3)
			PlayPropSFX("rbxassetid://133258951303453")
		else
			if p1.KeyCode ~= Enum.KeyCode.Escape and p1.KeyCode ~= Enum.KeyCode.ButtonB then
				return
			end

			v40()
		end
	end)
end

v41 = function() --[[ Line: 1119 | Upvalues: v6 (copy), v7 (copy), v15 (ref), v5 (copy), v13 (ref), v14 (ref), v16 (ref), v17 (ref), v18 (ref), RestoreModelCollisions (copy), CleanupPlacing (copy), v34 (ref), v35 (ref), InitialModeButtonBar (copy), Items (copy), TouchControlFrame (copy), BackModeButtonBar (copy), v11 (ref), GuiController (copy), PropsFrame (copy) ]]
	v6:Clean()
	v7:Clean()

	if v15 then
		v15:Destroy()
		v15 = nil
	end

	v5.Enabled = false
	v5.Adornee = nil
	v13 = nil
	v14 = nil
	v7:Clean()
	v16 = false
	v17 = false
	v18 = nil
	RestoreModelCollisions()
	CleanupPlacing()

	if v34 then
		v34:Destroy()
		v34 = nil
	end

	v35 = nil
	RestoreModelCollisions()
	InitialModeButtonBar.Visible = false
	Items.Visible = false
	v5.Enabled = false
	TouchControlFrame.Visible = false
	BackModeButtonBar.Visible = false
	v11 = nil

	if GuiController.Gui == PropsFrame then
		GuiController:Close()
	end

	PropsFrame.Enabled = false
end

local function AddPropItem(p1, p2) --[[ AddPropItem | Line: 1135 | Upvalues: t3 (copy), PropData (copy), Template (copy), f44 (ref), ScrollingFrame (copy) ]]
	if t3[p1] then
		return
	end

	local v1 = nil

	for v2, v3 in PropData.Data do
		if v3.PropName == p1 then
			v1 = v3

			break
		end
	end

	if not v1 then
		return
	end

	local v4 = Template:Clone()
	local Button = v4.Button

	v4.Name = p1
	v4.Visible = true

	local Vector = Button:FindFirstChild("Vector")

	if Vector then
		Vector.Image = v1.IMG or ""
	end

	local AmountTextLabel = Button:FindFirstChild("AmountTextLabel")

	if AmountTextLabel then
		AmountTextLabel.Text = "x" .. tostring(p2)
	end

	Button.Activated:Connect(function() --[[ Line: 1151 | Upvalues: f44 (ref), p1 (copy) ]]
		f44(p1)
	end)
	Button.Selectable = true
	Button:SetAttribute("TextToolTip", p1)
	v4.Parent = ScrollingFrame
	t3[p1] = v4
end

local function RemovePropItem(p1) --[[ RemovePropItem | Line: 1168 | Upvalues: t3 (copy), GuiService (copy), SelectFirstPropTile (copy) ]]
	local v1 = t3[p1]

	if not v1 then
		return
	end

	local SelectedObject = GuiService.SelectedObject
	local v2 = if SelectedObject == nil then false else SelectedObject:IsDescendantOf(v1)

	v1:Destroy()
	t3[p1] = nil

	if not v2 then
		return
	end

	SelectFirstPropTile()
end

local function UpdatePropItemCount(p1, p2) --[[ UpdatePropItemCount | Line: 1181 | Upvalues: t3 (copy) ]]
	local v1 = t3[p1]

	if not v1 then
		return
	end

	local Button = v1:FindFirstChild("Button")
	local v2 = if Button then Button:FindFirstChild("AmountTextLabel") else Button

	if not v2 then
		return
	end

	v2.Text = "x" .. tostring(p2)
end

local function InitializePropsList() --[[ InitializePropsList | Line: 1192 | Upvalues: v36 (ref), v8 (ref), AddPropItem (copy), t3 (copy), GuiService (copy), SelectFirstPropTile (copy) ]]
	if v36 then
		return
	end

	if not v8 then
		return
	end

	v36 = true

	local v1 = v8.Data.Inventory and v8.Data.Inventory.Props

	if v1 then
		for v2, v3 in v1 do
			if type(v3) == "number" and v3 > 0 then
				AddPropItem(v2, v3)
			end
		end
	end

	v8:OnChange(function(p1, p2) --[[ Line: 1204 | Upvalues: v8 (ref), t3 (ref), GuiService (ref), SelectFirstPropTile (ref), AddPropItem (ref) ]]
		if not p2 or (p2[1] ~= "Inventory" or p2[2] ~= "Props") then
			return
		end

		local v1 = p2[3]

		if not v1 then
			return
		end

		local v2 = v8.Data.Inventory and v8.Data.Inventory.Props and v8.Data.Inventory.Props[v1] or 0

		if v2 <= 0 then
			local v3 = t3[v1]

			if not v3 then
				return
			end

			local SelectedObject = GuiService.SelectedObject
			local v4 = if SelectedObject == nil then false else SelectedObject:IsDescendantOf(v3)

			v3:Destroy()
			t3[v1] = nil

			if v4 then
				SelectFirstPropTile()
			end
		elseif t3[v1] then
			local v5 = t3[v1]

			if not v5 then
				return
			end

			local Button = v5:FindFirstChild("Button")
			local v6 = if Button then Button:FindFirstChild("AmountTextLabel") else Button

			if v6 then
				v6.Text = "x" .. tostring(v2)
			end
		else
			AddPropItem(v1, v2)
		end
	end)
end

local function OnToolEquipped(p1) --[[ OnToolEquipped | Line: 1220 | Upvalues: v12 (ref), PropsFrame (copy), v40 (ref) ]]
	if p1:GetAttribute("Build") then
		v12 = p1
		PropsFrame.Enabled = true
		v40()
	end
end

local function OnToolUnequipped(p1) --[[ OnToolUnequipped | Line: 1228 | Upvalues: v12 (ref), v41 (ref) ]]
	if not p1:GetAttribute("Build") then
		return
	end

	if v12 ~= p1 then
		return
	end

	v12 = nil
	v41()
end

local function SetupCharacter(p1) --[[ SetupCharacter | Line: 1237 | Upvalues: v12 (ref), PropsFrame (copy), v40 (ref), v41 (ref) ]]
	p1.ChildAdded:Connect(function(p1) --[[ Line: 1238 | Upvalues: v12 (ref), PropsFrame (ref), v40 (ref) ]]
		if not p1:IsA("Tool") then
			return
		end

		if not p1:GetAttribute("Build") then
			return
		end

		v12 = p1
		PropsFrame.Enabled = true
		v40()
	end)
	p1.ChildRemoved:Connect(function(p1) --[[ Line: 1241 | Upvalues: v12 (ref), v41 (ref) ]]
		if not p1:IsA("Tool") then
			return
		end

		if not p1:GetAttribute("Build") then
			return
		end

		if v12 ~= p1 then
			return
		end

		v12 = nil
		v41()
	end)

	for v1, v2 in p1:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("Build") then
			v12 = v2
			PropsFrame.Enabled = true
			v40()
		end
	end
end

Build.Activated:Connect(function() --[[ Line: 1250 | Upvalues: v11 (ref), f43 (ref) ]]
	if v11 ~= "Edit" then
		return
	end

	f43()
end)
Delete.Activated:Connect(function() --[[ Line: 1254 | Upvalues: v11 (ref), f45 (ref) ]]
	if v11 ~= "Edit" then
		return
	end

	f45()
end)
Hover.MouseButton1Down:Connect(function() --[[ Line: 1258 | Upvalues: v11 (ref), v13 (ref), StartMove (copy) ]]
	if v11 ~= "Edit" or not v13 then
		return
	end

	StartMove()
end)
Hover3.MouseButton1Down:Connect(function() --[[ Line: 1262 | Upvalues: v11 (ref), v13 (ref), StartRotate (copy) ]]
	if v11 ~= "Edit" or not v13 then
		return
	end

	StartRotate()
end)
Hover2.Activated:Connect(function() --[[ Line: 1266 | Upvalues: v11 (ref), v13 (ref), v14 (ref), Networking (copy), PlayPropSFX (copy), v40 (ref) ]]
	if v11 ~= "Edit" or not (v13 and v14) then
		return
	end

	Networking.Prop.PickupProp:Fire(v14)
	PlayPropSFX("rbxassetid://133258951303453")
	v40()
end)
Hover2.MouseButton1Down:Connect(function() --[[ Line: 1274 | Upvalues: Shade2 (copy) ]]
	Shade2.Visible = true
end)
Hover2.MouseButton1Up:Connect(function() --[[ Line: 1275 | Upvalues: Shade2 (copy) ]]
	Shade2.Visible = false
end)
Hover2.MouseLeave:Connect(function() --[[ Line: 1276 | Upvalues: Shade2 (copy) ]]
	Shade2.Visible = false
end)
BuildButton.Activated:Connect(function() --[[ Line: 1278 | Upvalues: v11 (ref), PlaceNewProp (copy) ]]
	if v11 ~= "Placing" then
		return
	end

	PlaceNewProp()
end)
Back.Activated:Connect(function() --[[ Line: 1282 | Upvalues: v11 (ref), v40 (ref) ]]
	if v11 ~= "Placing" and v11 ~= "Erase" then
		return
	end

	v40()
end)
ExitButton.Activated:Connect(function() --[[ Line: 1288 | Upvalues: Items (copy), v40 (ref) ]]
	Items.Visible = false
	v40()
end)
Rotate.Position = UDim2.new(0, 0, 0, 0)
PropsFrame.Enabled = false
HideAllUI()
Template.Visible = false

local Character = LocalPlayer.Character

if Character then
	SetupCharacter(Character)
end

LocalPlayer.CharacterAdded:Connect(SetupCharacter)
GuiController.GuiUnfocusedSignal:Connect(function(p1) --[[ Line: 1303 | Upvalues: PropsFrame (copy), v11 (ref), v40 (ref) ]]
	if p1 ~= PropsFrame then
		return
	end

	if v11 == "Build" then
		v40()
	end
end)
task.spawn(function() --[[ Line: 1309 | Upvalues: v8 (ref), PlayerStateClient (copy), InitializePropsList (copy) ]]
	v8 = PlayerStateClient:WaitForLocalReplica(30)

	if not v8 then
		return
	end

	InitializePropsList()
end)