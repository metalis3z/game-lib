--credit to prince games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local CollectionService = game:GetService("CollectionService")
local SoundService = game:GetService("SoundService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Gardens = workspace:WaitForChild("Gardens")
local Props = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Props")
local v1 = false

local function UpdateIsMobile() --[[ UpdateIsMobile | Line: 25 | Upvalues: v1 (ref), UserInputService (copy) ]]
	v1 = if workspace.CurrentCamera.ViewportSize.X < 1000 then true else UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

v1 = if workspace.CurrentCamera.ViewportSize.X < 1000 then true else UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateIsMobile)

local function PlayPlaceSFX() --[[ PlayPlaceSFX | Line: 40 | Upvalues: LocalPlayer (copy), SoundService (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if v1 then
		local Sound = Instance.new("Sound")

		Sound.SoundId = "rbxassetid://136697624359338"
		Sound.Volume = 1
		Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
		Sound.Parent = v1
		Sound:Play()
		game.Debris:AddItem(Sound, Sound.TimeLength / math.max(Sound.PlaybackSpeed, 0.01) + 1)
	end
end

local function profileBegin(p1) --[[ profileBegin | Line: 55 ]]
	debug.profilebegin("Controllers/PropController/" .. p1)
end

local function profileEnd() --[[ profileEnd | Line: 59 ]]
	debug.profileend()
end

local v3 = false
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = 0
local v13 = nil
local v14 = 0
local v15 = nil
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local v16 = 0

local function debugLog(...) --[[ debugLog | Line: 88 ]] end

local function vec3str(p1) --[[ vec3str | Line: 92 ]]
	return string.format("(%.4f, %.4f, %.4f)", p1.X, p1.Y, p1.Z)
end

local function cfstr(p1) --[[ cfstr | Line: 96 ]]
	local v1, v2, v3 = p1:ToEulerAnglesYXZ()
	local format = string.format
	local Position = p1.Position

	return format("pos=%s rot=(%.2f, %.2f, %.2f)deg", string.format("(%.4f, %.4f, %.4f)", Position.X, Position.Y, Position.Z), math.deg(v1), math.deg(v2), (math.deg(v3)))
end

function t.Init(p1) --[[ Init | Line: 101 ]] end
function t.Start(p1) --[[ Start | Line: 105 | Upvalues: LocalPlayer (copy), v13 (ref) ]]
	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 111 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	LocalPlayer:GetAttributeChangedSignal("PlotId"):Connect(function() --[[ Line: 115 | Upvalues: v13 (ref) ]]
		v13 = nil
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 120 | Upvalues: v10 (ref) ]]
	p2.ChildAdded:Connect(function(p1) --[[ Line: 121 | Upvalues: v10 (ref) ]]
		if not (p1:IsA("Tool") and p1:GetAttribute("Build")) then
			return
		end

		v10 = p1
	end)
	p2.ChildRemoved:Connect(function(p12) --[[ Line: 127 | Upvalues: v10 (ref), p1 (copy) ]]
		if not p12:IsA("Tool") or (not p12:GetAttribute("Build") or v10 ~= p12) then
			return
		end

		v10 = nil
		p1:StopPlacement()
	end)

	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("Build") then
			v10 = v2
		end
	end
end
function t.GetPlayerPlotFolder(p1) --[[ GetPlayerPlotFolder | Line: 143 | Upvalues: v13 (ref), LocalPlayer (copy), Gardens (copy) ]]
	if v13 then
		return v13
	end

	local v1 = LocalPlayer:GetAttribute("PlotId")

	if not v1 then
		return nil
	end

	local v2 = Gardens:FindFirstChild("Plot" .. tostring(v1))

	if v2 then
		v13 = v2

		return v2
	end

	return nil
end
function t.GetSpawnPoint(p1) --[[ GetSpawnPoint | Line: 158 ]]
	local v1 = p1:GetPlayerPlotFolder()

	if v1 then
		return v1:FindFirstChild("SpawnPoint")
	end

	return nil
end
function t.SnapToGrid(p1, p2) --[[ SnapToGrid | Line: 164 | Upvalues: v16 (ref), debugLog (copy) ]]
	local v1 = p1:GetSpawnPoint()

	if not v1 then
		debugLog("SnapToGrid: WARNING no spawnPoint, falling back to world-space snap")

		return Vector3.new(math.round(p2.X / 0.5) * 0.5, math.round(p2.Y / 0.5) * 0.5, math.round(p2.Z / 0.5) * 0.5)
	end

	local v8 = v1.CFrame:PointToObjectSpace(p2)
	local v15 = Vector3.new(math.round(v8.X / 0.5) * 0.5, math.round(v8.Y / 0.5) * 0.5, math.round(v8.Z / 0.5) * 0.5)
	local v162 = v1.CFrame:PointToWorldSpace(v15)

	if v16 < 20 then
		v16 = v16 + 1
		debugLog("SnapToGrid: worldIn=" .. string.format("(%.4f, %.4f, %.4f)", p2.X, p2.Y, p2.Z))

		local v18 = v1.CFrame
		local v19, v20, v21 = v18:ToEulerAnglesYXZ()
		local format = string.format
		local Position = v18.Position

		debugLog("  spawnCFrame=" .. format("pos=%s rot=(%.2f, %.2f, %.2f)deg", string.format("(%.4f, %.4f, %.4f)", Position.X, Position.Y, Position.Z), math.deg(v19), math.deg(v20), (math.deg(v21))))
		debugLog("  localPos=" .. string.format("(%.4f, %.4f, %.4f)", v8.X, v8.Y, v8.Z))
		debugLog("  snappedLocal=" .. string.format("(%.4f, %.4f, %.4f)", v15.X, v15.Y, v15.Z))
		debugLog("  worldOut=" .. string.format("(%.4f, %.4f, %.4f)", v162.X, v162.Y, v162.Z))
		debugLog("  deltaXYZ local=(" .. string.format("%.4f", v8.X - v15.X) .. ", " .. string.format("%.4f", v8.Y - v15.Y) .. ", " .. string.format("%.4f", v8.Z - v15.Z) .. ")")
	end

	return v162
end
function t.CalculateYOffset(p1, p2) --[[ CalculateYOffset | Line: 195 ]]
	if p2 and p2.PrimaryPart then
		local PrimaryPart = p2.PrimaryPart

		return PrimaryPart.Size.Y / 2 + (p2:GetPivot().Position.Y - PrimaryPart.Position.Y)
	end

	return 0
end
function t.CreateRaycastParams(p1) --[[ CreateRaycastParams | Line: 207 | Upvalues: LocalPlayer (copy), v4 (ref), v15 (ref) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Exclude

	local t = {}
	local Character = LocalPlayer.Character

	if Character then
		table.insert(t, Character)
	end

	if v4 then
		table.insert(t, v4)
	end

	if v15 then
		table.insert(t, v15)
	end

	v1.FilterDescendantsInstances = t

	return v1
end
function t.IsTouchInJoystickZone(p1, p2) --[[ IsTouchInJoystickZone | Line: 230 | Upvalues: CurrentCamera (copy), GuiService (copy) ]]
	local ViewportSize = CurrentCamera.ViewportSize
	local v1 = GuiService:GetGuiInset()

	return if p2.X / ViewportSize.X < 0.3 then (p2.Y - v1.Y) / (ViewportSize.Y - v1.Y) > 0.6 else false
end
function t.GetPlacementPositionFromScreen(p1, p2, p3) --[[ GetPlacementPositionFromScreen | Line: 240 | Upvalues: CurrentCamera (copy), debugLog (copy), v16 (ref), v14 (ref) ]]
	local v1 = p1:CreateRaycastParams()
	local v2 = CurrentCamera:ViewportPointToRay(p2, p3)
	local Origin = v2.Origin
	local v3 = v2.Direction * 5000

	for i = 1, 100 do
		local v4 = workspace:Raycast(Origin, v3, v1)

		if not v4 then
			debugLog("Raycast: iteration " .. i .. " hit nothing")

			return nil
		end

		if not (v4.Instance and (v4.Instance:IsA("BasePart") and v4.Instance.Transparency >= 0.5)) then
			local v6 = v4.Instance:GetFullName()
			local Position = v4.Position
			local v7 = string.format("(%.4f, %.4f, %.4f)", Position.X, Position.Y, Position.Z)
			local Normal = v4.Normal

			debugLog("Raycast: hit " .. v6 .. " at " .. v7 .. " normal=" .. string.format("(%.4f, %.4f, %.4f)", Normal.X, Normal.Y, Normal.Z))
			v16 = 0

			local v8 = p1:SnapToGrid(v4.Position)
			local v10 = Vector3.new(v8.X, v8.Y + v14, v8.Z)

			debugLog("Raycast: finalPos=" .. string.format("(%.4f, %.4f, %.4f)", v10.X, v10.Y, v10.Z) .. " (yOffset=" .. string.format("%.4f", v14) .. ")")

			return v10
		end

		debugLog("Raycast: iteration " .. i .. " skipping transparent part: " .. v4.Instance:GetFullName() .. " transparency=" .. v4.Instance.Transparency)

		local Magnitude = (v4.Position - Origin).Magnitude

		Origin = v4.Position + v2.Direction * 0.01
		v3 = v2.Direction * (5000 - Magnitude - 0.01)

		local v11 = table.clone(v1.FilterDescendantsInstances)

		table.insert(v11, v4.Instance)
		v1.FilterDescendantsInstances = v11
	end

	return nil
end
function t.GetPlacementPosition(p1) --[[ GetPlacementPosition | Line: 280 | Upvalues: UserInputService (copy) ]]
	local v1 = UserInputService:GetMouseLocation()

	return p1:GetPlacementPositionFromScreen(v1.X, v1.Y)
end
function t.CreatePreview(p1, p2) --[[ CreatePreview | Line: 285 | Upvalues: Props (copy), v14 (ref), debugLog (copy), v1 (ref) ]]
	local v12 = Props:FindFirstChild(p2)

	if not v12 then
		return nil
	end

	local PropPreview = v12:Clone()

	for v2, v3 in PropPreview:GetDescendants() do
		if v3:IsA("BasePart") then
			v3.Transparency = 0.5
			v3.CanCollide = false
			v3.CanQuery = false
			v3.CanTouch = false
			v3.Anchored = true
		end
	end

	PropPreview.Name = "PropPreview"
	PropPreview.Parent = workspace
	v14 = p1:CalculateYOffset(PropPreview)
	debugLog("CreatePreview: propName=" .. p2 .. " yOffset=" .. string.format("%.4f", v14))

	if v1 then
		for v4, v5 in PropPreview:GetDescendants() do
			if v5:IsA("BasePart") then
				v5.Transparency = 1
			end
		end
	end

	return PropPreview
end
function t.CreateSelectionBox(p1, p2) --[[ CreateSelectionBox | Line: 320 | Upvalues: v1 (ref) ]]
	local SelectionBox = Instance.new("SelectionBox")

	SelectionBox.Color3 = Color3.fromRGB(0, 255, 0)
	SelectionBox.LineThickness = 0.05
	SelectionBox.Transparency = 0.3
	SelectionBox.Adornee = p2
	SelectionBox.Parent = p2

	if v1 then
		SelectionBox.Visible = false
	end

	return SelectionBox
end
function t.UpdatePreview(p1) --[[ UpdatePreview | Line: 335 | Upvalues: v1 (ref), v4 (ref), v12 (ref), v5 (ref) ]]
	debug.profilebegin("Controllers/PropController/UpdatePreview")

	if v1 then
		debug.profileend()

		return
	end

	if not (v4 and v4.PrimaryPart) then
		debug.profileend()

		return
	end

	local v13 = p1:GetPlacementPosition()

	if not v13 then
		debug.profileend()

		return
	end

	local v2 = p1:GetGardenRotationY()
	local v42 = CFrame.Angles(0, v2 + math.rad(v12), 0)

	v4:PivotTo(CFrame.new(v13) * v42)

	if not v5 then
		debug.profileend()

		return
	end

	v5.Color3 = p1:CanPlace() and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
	debug.profileend()
end
function t.CanPlace(p1) --[[ CanPlace | Line: 364 | Upvalues: v4 (ref) ]]
	if p1:GetPlayerPlotFolder() then
		return v4 and v4.PrimaryPart and true or false
	end

	return false
end
function t.IsPlacing(p1) --[[ IsPlacing | Line: 371 | Upvalues: v3 (ref) ]]
	return v3
end
function t.GetCurrentPropName(p1) --[[ GetCurrentPropName | Line: 375 | Upvalues: v11 (ref) ]]
	return v11
end
function t.UnequipTool(p1) --[[ UnequipTool | Line: 379 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	Humanoid:UnequipTools()
end
function t.OnPlacementInput(p1, p2, p3) --[[ OnPlacementInput | Line: 389 | Upvalues: v3 (ref), v1 (ref), t2 (copy) ]]
	if not v3 then
		return
	end

	if v1 then
		if p2.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		t2[p2] = {
			startTime = tick(),
			startPos = p2.Position
		}
	else
		if p3 then
			return
		end

		if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.KeyCode == Enum.KeyCode.ButtonR2 then true else false then
			p1:PlaceProp()

			return
		end

		if if p2.KeyCode == Enum.KeyCode.R then true else p2.KeyCode == Enum.KeyCode.ButtonR1 then
			p1:RotateProp(45)
		end
	end
end
function t.OnPlacementInputEnded(p1, p2, p3) --[[ OnPlacementInputEnded | Line: 418 | Upvalues: v3 (ref), v1 (ref), t2 (copy) ]]
	if not v3 then
		return
	end

	if not v1 then
		return
	end

	if p2.UserInputType ~= Enum.UserInputType.Touch then
		return
	end

	local v12 = t2[p2]

	t2[p2] = nil

	if not v12 then
		return
	end

	local v2 = tick() - v12.startTime

	if v2 > 0.3 then
		return
	end

	if (p2.Position - v12.startPos).Magnitude > 30 then
		return
	end

	local Position = p2.Position

	if not p1:IsTouchInJoystickZone((Vector2.new(Position.X, Position.Y))) then
		p1:PlacePropAtScreen(Position.X, Position.Y)
	end
end
function t.StartPlacement(p1, p2) --[[ StartPlacement | Line: 450 | Upvalues: v3 (ref), v10 (ref), v11 (ref), v12 (ref), v4 (ref), v5 (ref), debugLog (copy), v6 (ref), RunService (copy), v7 (ref), UserInputService (copy), v1 (ref), v8 (ref), v9 (ref), t6 (copy), t3 (copy) ]]
	if v3 then
		p1:StopPlacement()
	end

	if not v10 then
		return
	end

	v3 = true
	v11 = p2
	v12 = 0
	v4 = p1:CreatePreview(p2)

	if not v4 then
		v3 = false

		return
	end

	v5 = p1:CreateSelectionBox(v4)
	p1:CreateGrid()

	local v13 = p1:GetSpawnPoint()

	if v13 then
		local v32 = v13.CFrame
		local v42, v52, v62 = v32:ToEulerAnglesYXZ()
		local format = string.format
		local Position = v32.Position

		debugLog("StartPlacement: spawnPoint=" .. format("pos=%s rot=(%.2f, %.2f, %.2f)deg", string.format("(%.4f, %.4f, %.4f)", Position.X, Position.Y, Position.Z), math.deg(v42), math.deg(v52), (math.deg(v62))))

		local format2 = string.format

		debugLog("StartPlacement: gardenRotY=" .. format2("%.4f deg", (math.deg((p1:GetGardenRotationY())))))
	else
		debugLog("StartPlacement: WARNING spawnPoint is nil!")
	end

	v6 = RunService.RenderStepped:Connect(function() --[[ Line: 481 | Upvalues: p1 (copy) ]]
		debug.profilebegin("Controllers/PropController/PreviewUpdate")
		p1:UpdatePreview()
		debug.profileend()
	end)
	v7 = UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 487 | Upvalues: p1 (copy) ]]
		p1:OnPlacementInput(p12, p2)
	end)

	if v1 then
		v8 = UserInputService.InputEnded:Connect(function(p12, p2) --[[ Line: 492 | Upvalues: p1 (copy) ]]
			p1:OnPlacementInputEnded(p12, p2)
		end)
	end

	if v10 then
		v9 = v10.AttributeChanged:Connect(function(p12) --[[ Line: 498 | Upvalues: v10 (ref), p1 (copy), t6 (ref), v11 (ref) ]]
			if p12 ~= "RemainingCount" then
				return
			end

			local v1 = v10:GetAttribute("RemainingCount")

			if not (v1 and v1 <= 0) then
				return
			end

			p1:StopPlacement()
			p1:UnequipTool()

			for v2, v3 in t6 do
				task.spawn(v3, v11)
			end
		end)
	end

	for v92, v102 in t3 do
		task.spawn(v102, p2)
	end
end
function t.StopPlacement(p1) --[[ StopPlacement | Line: 518 | Upvalues: v3 (ref), v11 (ref), v12 (ref), v14 (ref), t2 (copy), v6 (ref), v7 (ref), v8 (ref), v9 (ref), v5 (ref), v4 (ref), t4 (copy) ]]
	local v1 = v3
	local v2 = v11

	v3 = false
	v11 = nil
	v12 = 0
	v14 = 0
	table.clear(t2)

	if v6 then
		v6:Disconnect()
		v6 = nil
	end

	if v7 then
		v7:Disconnect()
		v7 = nil
	end

	if v8 then
		v8:Disconnect()
		v8 = nil
	end

	if v9 then
		v9:Disconnect()
		v9 = nil
	end

	p1:DestroyGrid()

	if v5 then
		v5:Destroy()
		v5 = nil
	end

	if v4 then
		v4:Destroy()
		v4 = nil
	end

	if not v1 then
		return
	end

	for v32, v42 in t4 do
		task.spawn(v42, v2)
	end
end
function t.GetGardenRotationY(p1) --[[ GetGardenRotationY | Line: 569 ]]
	local v1 = p1:GetSpawnPoint()

	if v1 then
		local _, v2, _2 = v1.CFrame:ToEulerAnglesYXZ()

		return v2
	end

	return 0
end
function t.RotateProp(p1, p2) --[[ RotateProp | Line: 576 | Upvalues: v12 (ref) ]]
	v12 = (v12 + p2) % 360
end
function t.CreateGrid(p1) --[[ CreateGrid | Line: 580 | Upvalues: debugLog (copy), CollectionService (copy), v15 (ref) ]]
	p1:DestroyGrid()

	local v1 = p1:GetSpawnPoint()
	local v2 = p1:GetPlayerPlotFolder()

	if not v1 then
		debugLog("CreateGrid: ABORT - no spawnPoint")

		return
	end

	if not v2 then
		debugLog("CreateGrid: ABORT - no plot")

		return
	end

	local v4 = v1.CFrame
	local v5, v6, v7 = v4:ToEulerAnglesYXZ()
	local format = string.format
	local Position = v4.Position

	debugLog("CreateGrid: spawnPoint=" .. format("pos=%s rot=(%.2f, %.2f, %.2f)deg", string.format("(%.4f, %.4f, %.4f)", Position.X, Position.Y, Position.Z), math.deg(v5), math.deg(v6), (math.deg(v7))))

	local v8 = nil

	for v9, v10 in v2:GetDescendants() do
		if v10:IsA("BasePart") and CollectionService:HasTag(v10, "PropArea") then
			v8 = v10

			break
		end
	end

	if v8 then
		debugLog("CreateGrid: propArea=" .. v8:GetFullName())

		local Size = v8.Size

		debugLog("CreateGrid: propArea.Size=" .. string.format("(%.4f, %.4f, %.4f)", Size.X, Size.Y, Size.Z))

		local v13 = v8.CFrame
		local v14, v152, v16 = v13:ToEulerAnglesYXZ()
		local format2 = string.format
		local Position2 = v13.Position

		debugLog("CreateGrid: propArea.CFrame=" .. format2("pos=%s rot=(%.2f, %.2f, %.2f)deg", string.format("(%.4f, %.4f, %.4f)", Position2.X, Position2.Y, Position2.Z), math.deg(v14), math.deg(v152), (math.deg(v16))))
		debugLog("CreateGrid: propArea.Transparency=" .. v8.Transparency)

		local PlacementGrid = Instance.new("Folder")

		PlacementGrid.Name = "PlacementGrid"

		local v17 = v1.CFrame:PointToObjectSpace(v8.Position)
		local v18 = v8.Size.X / 2 + 0.5
		local v19 = v8.Size.Z / 2 + 0.5

		debugLog("CreateGrid: areaLocalCenter=" .. string.format("(%.4f, %.4f, %.4f)", v17.X, v17.Y, v17.Z))
		debugLog("CreateGrid: halfX=" .. v18 .. " halfZ=" .. v19)

		local v21 = math.ceil((v17.X - v18) / 0.5) * 0.5
		local v23 = math.floor((v17.X + v18) / 0.5) * 0.5
		local v25 = math.ceil((v17.Z - v19) / 0.5) * 0.5
		local v27 = math.floor((v17.Z + v19) / 0.5) * 0.5

		debugLog("CreateGrid: grid bounds local X=[" .. v21 .. ", " .. v23 .. "] Z=[" .. v25 .. ", " .. v27 .. "]")

		local v28 = v8.Position.Y + v8.Size.Y / 2 + 0.05

		debugLog("CreateGrid: gridY=" .. string.format("%.4f", v28))

		local v29 = v23 - v21
		local v30 = v27 - v25

		if v29 <= 0 or v30 <= 0 then
			debugLog("CreateGrid: ABORT - zero or negative grid dimensions: xLength=" .. v29 .. " zLength=" .. v30)
		else
			local v31 = Color3.fromRGB(0, 170, 255)
			local _, v32, _2 = v1.CFrame:ToEulerAnglesYXZ()
			local count = 0
			local v33 = (v21 + v23) / 2
			local v34 = (v25 + v27) / 2

			for i = 0, math.round((v27 - v25) / 0.5) do
				local v35 = v1.CFrame:PointToWorldSpace((Vector3.new(v33, 0, v25 + i * 0.5)))
				local v36 = Vector3.new(v35.X, v28, v35.Z)
				local Part = Instance.new("Part")

				Part.Anchored = true
				Part.CanCollide = false
				Part.CanQuery = false
				Part.CanTouch = false
				Part.CastShadow = false
				Part.Material = Enum.Material.Neon
				Part.Color = v31
				Part.Transparency = 0.5
				Part.Size = Vector3.new(v29, 0.1, 0.1)
				Part.CFrame = CFrame.new(v36) * CFrame.Angles(0, v32, 0)
				Part.Parent = PlacementGrid
				count = count + 1
			end

			for j = 0, math.round((v23 - v21) / 0.5) do
				local v37 = v1.CFrame:PointToWorldSpace((Vector3.new(v21 + j * 0.5, 0, v34)))
				local v38 = Vector3.new(v37.X, v28, v37.Z)
				local Part = Instance.new("Part")

				Part.Anchored = true
				Part.CanCollide = false
				Part.CanQuery = false
				Part.CanTouch = false
				Part.CastShadow = false
				Part.Material = Enum.Material.Neon
				Part.Color = v31
				Part.Transparency = 0.5
				Part.Size = Vector3.new(0.1, 0.1, v30)
				Part.CFrame = CFrame.new(v38) * CFrame.Angles(0, v32, 0)
				Part.Parent = PlacementGrid
				count = count + 1
			end

			debugLog("CreateGrid: created " .. count .. " grid lines")
			PlacementGrid.Parent = workspace
			v15 = PlacementGrid
			debugLog("CreateGrid: done, folder parented to workspace")
		end
	else
		debugLog("CreateGrid: ABORT - no PropArea found in plot descendants")
		debugLog("CreateGrid: listing plot descendants with tags:")

		for v39, v40 in v2:GetDescendants() do
			if v40:IsA("BasePart") then
				local v41 = CollectionService:GetTags(v40)

				if #v41 > 0 then
					debugLog("  " .. v40:GetFullName() .. " tags=" .. table.concat(v41, ","))
				end
			end
		end
	end
end
function t.DestroyGrid(p1) --[[ DestroyGrid | Line: 711 | Upvalues: v15 (ref) ]]
	if not v15 then
		return
	end

	v15:Destroy()
	v15 = nil
end
function t.PlacePropAtScreen(p1, p2, p3) --[[ PlacePropAtScreen | Line: 718 | Upvalues: v3 (ref), v4 (ref), v11 (ref), v12 (ref), v10 (ref), debugLog (copy), Networking (copy), PlayPlaceSFX (copy), t5 (copy) ]]
	if not (v3 and (v4 and v11)) then
		return
	end

	local v1 = p1:GetPlacementPositionFromScreen(p2, p3)

	if not v1 then
		return
	end

	local v2 = p1:GetGardenRotationY()
	local v42 = CFrame.Angles(0, v2 + math.rad(v12), 0)

	v4:PivotTo(CFrame.new(v1) * v42)

	if not p1:CanPlace() then
		return
	end

	local v5 = v10

	if not v5 then
		return
	end

	local v6 = v11
	local v7 = math.deg(v2) + v12

	debugLog("PlacePropAtScreen: pos=" .. string.format("(%.4f, %.4f, %.4f)", v1.X, v1.Y, v1.Z) .. " gardenRotY=" .. string.format("%.2f", (math.deg(v2))) .. " currentRot=" .. v12 .. " worldRot=" .. string.format("%.2f", v7))
	Networking.Prop.PlaceProp:Fire(v1, v6, v5, v7)
	PlayPlaceSFX()

	for v8, v9 in t5 do
		task.spawn(v9, v6, v1, v7)
	end
end
function t.PlaceProp(p1) --[[ PlaceProp | Line: 755 | Upvalues: v3 (ref), v4 (ref), v11 (ref), v10 (ref), v12 (ref), debugLog (copy), Networking (copy), PlayPlaceSFX (copy), t5 (copy) ]]
	if not (v3 and (v4 and v11)) then
		return
	end

	if not p1:CanPlace() then
		return
	end

	local v1 = p1:GetPlacementPosition()

	if not v1 then
		return
	end

	local v2 = v10

	if not v2 then
		return
	end

	local v32 = v11
	local v42 = p1:GetGardenRotationY()
	local v5 = math.deg(v42) + v12

	debugLog("PlaceProp: pos=" .. string.format("(%.4f, %.4f, %.4f)", v1.X, v1.Y, v1.Z) .. " gardenRotY=" .. string.format("%.2f", (math.deg(v42))) .. " currentRot=" .. v12 .. " worldRot=" .. string.format("%.2f", v5))
	Networking.Prop.PlaceProp:Fire(v1, v32, v2, v5)
	PlayPlaceSFX()

	for v6, v7 in t5 do
		task.spawn(v7, v32, v1, v5)
	end
end
function t.OnPlacementStarted(p1, p2) --[[ OnPlacementStarted | Line: 779 | Upvalues: t3 (copy) ]]
	table.insert(t3, p2)
end
function t.OnPlacementStopped(p1, p2) --[[ OnPlacementStopped | Line: 783 | Upvalues: t4 (copy) ]]
	table.insert(t4, p2)
end
function t.OnPropPlaced(p1, p2) --[[ OnPropPlaced | Line: 787 | Upvalues: t5 (copy) ]]
	table.insert(t5, p2)
end
function t.OnOutOfProps(p1, p2) --[[ OnOutOfProps | Line: 791 | Upvalues: t6 (copy) ]]
	table.insert(t6, p2)
end

return t