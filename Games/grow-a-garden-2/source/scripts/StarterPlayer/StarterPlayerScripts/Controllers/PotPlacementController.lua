--credit to leon games studio
local t = {
	StartOrder = 8
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local PlacementGrid = require(ReplicatedStorage.ClientModules.PlacementGrid)
local NotificationController = require(script.Parent.NotificationController)
local LocalPlayer = Players.LocalPlayer
local Gardens = workspace:WaitForChild("Gardens")
local POT = ReplicatedStorage.Assets.POT
local Plants = ReplicatedStorage.PlantGenerationModules.Plants
local Fruits = ReplicatedStorage.PlantGenerationModules.Fruits
local v1 = false
local v2 = 0
local v3 = nil
local v4 = false
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local t2 = {}
local v9 = false
local v10 = nil
local v11 = nil
local v12 = RaycastParams.new()

v12.FilterType = Enum.RaycastFilterType.Exclude

local function GetPlayerPlot() --[[ GetPlayerPlot | Line: 60 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")

	if v1 then
		return Gardens:FindFirstChild("Plot" .. tostring(v1))
	end

	return nil
end

local function GetSpawnPoint() --[[ GetSpawnPoint | Line: 67 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil

	if v2 then
		return v2:FindFirstChild("SpawnPoint")
	end

	return nil
end

local function BuildPropAreaCache() --[[ BuildPropAreaCache | Line: 74 | Upvalues: LocalPlayer (copy), Gardens (copy), v7 (ref), CollectionService (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v2 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil

	if not v2 then
		v7 = nil

		return
	end

	local t = {}

	for v4, v5 in v2:GetDescendants() do
		if v5:IsA("BasePart") and CollectionService:HasTag(v5, "PropArea") then
			table.insert(t, v5)
		end
	end

	v7 = t
end

local function IsPositionInPropArea(p1) --[[ IsPositionInPropArea | Line: 90 | Upvalues: v7 (ref) ]]
	local v1 = v7

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

local function UpdateRaycastParams(p1) --[[ UpdateRaycastParams | Line: 104 | Upvalues: LocalPlayer (copy), v12 (copy) ]]
	local t = {}
	local Character = LocalPlayer.Character

	if Character then
		table.insert(t, Character)
	end

	if p1 then
		table.insert(t, p1)
	end

	v12.FilterDescendantsInstances = t

	return v12
end

local function RaycastFromMouse(p1) --[[ RaycastFromMouse | Line: 120 | Upvalues: LocalPlayer (copy), v12 (copy), UserInputService (copy), CollectionService (copy) ]]
	local t = {}
	local Character = LocalPlayer.Character

	if Character then
		table.insert(t, Character)
	end

	if p1 then
		table.insert(t, p1)
	end

	v12.FilterDescendantsInstances = t

	local v1 = v12
	local CurrentCamera = workspace.CurrentCamera
	local v2 = UserInputService:GetMouseLocation()
	local v3 = CurrentCamera:ViewportPointToRay(v2.X, v2.Y)
	local v4 = table.clone(v1.FilterDescendantsInstances)

	for i = 1, 10 do
		local v5
		local v6 = workspace:Raycast(v3.Origin, v3.Direction * 900, v1)

		if not v6 then
			break
		end

		local v7 = CollectionService:HasTag(v6.Instance, "PropArea") or CollectionService:HasTag(v6.Instance, "PlantArea")

		v5 = v7 and (if math.abs(v6.Normal.Y) < 0.1 then true else false)

		if not (v6.Instance.Transparency > 0 or v5) then
			return v6
		end

		table.insert(v4, v6.Instance)
		v1.FilterDescendantsInstances = v4
	end

	return nil
end

local function UpdatePreviewColor(p1) --[[ UpdatePreviewColor | Line: 146 | Upvalues: v3 (ref) ]]
	if not v3 then
		return
	end

	local SelectionBox = v3:FindFirstChild("SelectionBox")

	if not (SelectionBox and SelectionBox:IsA("SelectionBox")) then
		return
	end

	SelectionBox.Color3 = p1 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end

local function CreateSelectionBox() --[[ CreateSelectionBox | Line: 155 | Upvalues: v3 (ref) ]]
	if v3 and v3.PrimaryPart then
		local SelectionBox = Instance.new("SelectionBox")

		SelectionBox.Name = "SelectionBox"
		SelectionBox.Color3 = Color3.fromRGB(0, 255, 0)
		SelectionBox.LineThickness = 0.03
		SelectionBox.Transparency = 0.3
		SelectionBox.Adornee = v3.PrimaryPart
		SelectionBox.Parent = v3
	end
end

local function StopRotateHold() --[[ StopRotateHold | Line: 167 | Upvalues: v8 (ref) ]]
	if not v8 then
		return
	end

	task.cancel(v8)
	v8 = nil
end

local function StartRotateHold() --[[ StartRotateHold | Line: 175 | Upvalues: v8 (ref), v2 (ref) ]]
	if v8 then
		task.cancel(v8)
		v8 = nil
	end

	v8 = task.spawn(function() --[[ Line: 177 | Upvalues: v2 (ref) ]]
		task.wait(1)

		while true do
			v2 = (v2 + 15) % 360
			task.wait(0.08)
		end
	end)
end

local v13 = nil

local function HideHeldVisual() --[[ HideHeldVisual | Line: 190 | Upvalues: v13 (ref), v11 (ref), LocalPlayer (copy), v9 (ref), v1 (ref) ]]
	if v13 then
		v13:Disconnect()
		v13 = nil
	end

	for v12, v2 in v11:GetChildren() do
		if v2:GetAttribute("Owner") == LocalPlayer.UserId then
			for v3, v4 in v2:GetDescendants() do
				if v4:IsA("BasePart") or v4:IsA("Decal") then
					if not v4:GetAttribute("OriginalTransparency") then
						v4:SetAttribute("OriginalTransparency", v4.Transparency)
					end

					v4.Transparency = 1
				end
			end

			v9 = true

			return
		end
	end

	v13 = v11.ChildAdded:Connect(function(p1) --[[ Line: 214 | Upvalues: v1 (ref), v13 (ref), LocalPlayer (ref), v9 (ref) ]]
		if not v1 then
			v13:Disconnect()
			v13 = nil

			return
		end

		if p1:GetAttribute("Owner") == LocalPlayer.UserId then
			v13:Disconnect()
			v13 = nil
			task.defer(function() --[[ Line: 224 | Upvalues: p1 (copy), v1 (ref), v9 (ref) ]]
				for v12, v2 in p1:GetDescendants() do
					if v2:IsA("BasePart") or v2:IsA("Decal") then
						if not v2:GetAttribute("OriginalTransparency") then
							v2:SetAttribute("OriginalTransparency", v2.Transparency)
						end

						v2.Transparency = 1
					end
				end

				p1.DescendantAdded:Connect(function(p1) --[[ Line: 234 | Upvalues: v1 (ref), v9 (ref) ]]
					if not (v1 and v9) then
						return
					end

					if not (p1:IsA("BasePart") or p1:IsA("Decal")) then
						return
					end

					if not p1:GetAttribute("OriginalTransparency") then
						p1:SetAttribute("OriginalTransparency", p1.Transparency)
					end

					p1.Transparency = 1
				end)
				v9 = true
			end)
		end
	end)
end

local function ShowHeldVisual() --[[ ShowHeldVisual | Line: 248 | Upvalues: v13 (ref), v9 (ref), v11 (ref), LocalPlayer (copy) ]]
	if v13 then
		v13:Disconnect()
		v13 = nil
	end

	if not v9 then
		return
	end

	v9 = false

	for v1, v2 in v11:GetChildren() do
		if v2:GetAttribute("Owner") == LocalPlayer.UserId then
			for v3, v4 in v2:GetDescendants() do
				if v4:IsA("BasePart") or v4:IsA("Decal") then
					v4.Transparency = v4:GetAttribute("OriginalTransparency") or 0
					v4:SetAttribute("OriginalTransparency", nil)
				end
			end

			return
		end
	end
end

local function RebuildPreviewVisualPartsCache() --[[ RebuildPreviewVisualPartsCache | Line: 274 | Upvalues: v3 (ref), v10 (ref) ]]
	if not v3 then
		v10 = nil

		return
	end

	local t = {}

	for v1, v2 in v3:GetDescendants() do
		if v2:IsA("BasePart") or v2:IsA("Decal") then
			table.insert(t, v2)
		end
	end

	v10 = t
end

local function BuildPreview(p1) --[[ BuildPreview | Line: 289 | Upvalues: v3 (ref), POT (copy), ReplicatedStorage (copy), Plants (copy), Fruits (copy), RebuildPreviewVisualPartsCache (copy) ]]
	if v3 then
		v3:Destroy()
		v3 = nil
	end

	local v1 = p1:GetAttribute("PlantName")
	local v2 = p1:GetAttribute("Seed")
	local v32 = p1:GetAttribute("SizeMultiplier") or 1
	local _ = p1:GetAttribute("Age") or 0
	local v4 = p1:GetAttribute("MaxAge") or 100
	local v5 = p1:GetAttribute("Mutation")
	local PottedPlantPreview = POT:Clone()

	PottedPlantPreview.Name = "PottedPlantPreview"
	PottedPlantPreview:ScaleTo(v32)

	for v6, v7 in PottedPlantPreview:GetDescendants() do
		if v7:IsA("BasePart") then
			v7.Transparency = 0.5
			v7.CanCollide = false
			v7.CanQuery = false
			v7.CanTouch = false
			v7.Anchored = true
		end
	end

	if v1 and v2 then
		local v8 = ReplicatedStorage.Assets.Plants:FindFirstChild(v1)
		local v9 = Plants:FindFirstChild(v1)
		local v10

		if v8 then
			v10 = false
		else
			local v11 = ReplicatedStorage.Assets.Fruits:FindFirstChild(v1)

			v8, v9, v10 = v11, Fruits:FindFirstChild(v1), true
		end

		if v8 and v9 then
			local v13 = require(v9)
			local v14 = v8:Clone()

			v14:SetAttribute("Age", v4)
			v14:SetAttribute("MaxAge", v4)

			if v5 and v5 ~= "" then
				v14:SetAttribute("Mutation", v5)
			end

			v14.Parent = workspace;
			(v10 and v13.InitFruit or v13.InitPlant)(v14, v2, v32)

			local sum = 0

			repeat
				sum = sum + task.wait()
			until v14:HasTag("InitializationComplete") or sum > 5

			(v10 and v13.BeginFruitGrowth or v13.BeginPlantGrowth)(v14)
			task.wait()

			for v17, v18 in v14:GetDescendants() do
				if v18:IsA("BasePart") and v18.Transparency < 1 then
					v18.Transparency = 0.5
					v18.CanCollide = false
					v18.CanQuery = false
					v18.CanTouch = false
					v18.Anchored = true
				end
			end

			local PlantRoot = PottedPlantPreview:FindFirstChild("PlantRoot", true)

			if PlantRoot then
				local PrimaryPart = v14.PrimaryPart
				local v20 = v14.PrimaryPart and PrimaryPart.Position.Y - PrimaryPart.Size.Y / 2 or v14:GetPivot().Position.Y

				for v21, v22 in v14:GetDescendants() do
					if v22:IsA("BasePart") and (v22.Transparency < 1 and v22.Size.Y > 0.01) then
						local v23 = v22.Position.Y - v22.Size.Y / 2

						if v23 < v20 then
							v20 = v23
						end
					end
				end

				local v24 = v14:GetPivot().Position.Y - v20
				local Position = PlantRoot.WorldCFrame.Position

				v14:PivotTo(CFrame.new(Position.X, Position.Y + v24, Position.Z))
			end

			local Fruits2 = ReplicatedStorage.Assets.Fruits
			local FruitSpawnLocations = v14:FindFirstChild("FruitSpawnLocations")
			local v25 = p1:GetAttribute("SavedFruitsJSON")

			if FruitSpawnLocations and (v25 and v25 ~= "") then
				local ok, result = pcall(function() --[[ Line: 389 | Upvalues: v25 (copy) ]]
					return game:GetService("HttpService"):JSONDecode(v25)
				end)

				if ok and (result and #result > 0) then
					local v26 = Fruits2:FindFirstChild(v1)
					local v27 = Fruits:FindFirstChild(v1)

					if v26 and v27 then
						local v28 = require(v27)

						for v29, v30 in result do
							local v31 = FruitSpawnLocations:FindFirstChild((tostring(v30.SpawnLocationIndex))) or FruitSpawnLocations:GetChildren()[v30.SpawnLocationIndex]

							if v31 then
								local v322 = v26:Clone()

								v322:SetAttribute("Age", v4)
								v322:SetAttribute("MaxAge", v4)

								if v30.Mutation and v30.Mutation ~= "" then
									v322:SetAttribute("Mutation", v30.Mutation)
								end

								v322.Parent = workspace
								v28.InitFruit(v322, v30.Seed, v30.SizeMultiplier)

								local sum2 = 0

								repeat
									sum2 = sum2 + task.wait()
								until v322:HasTag("InitializationComplete") or sum2 > 5

								v28.BeginFruitGrowth(v322)
								task.wait()

								if v30.OvertimeGrowth and v30.OvertimeGrowth > 1 then
									v322:ScaleTo(v30.OvertimeGrowth)
								end

								for v33, v34 in v322:GetDescendants() do
									if v34:IsA("BasePart") and v34.Transparency < 1 then
										v34.Transparency = 0.5
										v34.CanCollide = false
										v34.CanQuery = false
										v34.CanTouch = false
										v34.Anchored = true
									end
								end

								v322:PivotTo(v31.CFrame)
								v322.Parent = PottedPlantPreview
							end
						end
					end
				end
			end

			v14.Parent = PottedPlantPreview
		end
	end

	PottedPlantPreview.Parent = workspace
	v3 = PottedPlantPreview

	if not (PottedPlantPreview and PottedPlantPreview.PrimaryPart) then
		RebuildPreviewVisualPartsCache()

		return
	end

	local SelectionBox = Instance.new("SelectionBox")

	SelectionBox.Name = "SelectionBox"
	SelectionBox.Color3 = Color3.fromRGB(0, 255, 0)
	SelectionBox.LineThickness = 0.03
	SelectionBox.Transparency = 0.3
	SelectionBox.Adornee = PottedPlantPreview.PrimaryPart
	SelectionBox.Parent = PottedPlantPreview
	RebuildPreviewVisualPartsCache()
end

local function UpdatePreviewVisibility() --[[ UpdatePreviewVisibility | Line: 459 | Upvalues: v3 (ref), LocalPlayer (copy), v10 (ref), RebuildPreviewVisualPartsCache (copy), HideHeldVisual (copy), ShowHeldVisual (copy) ]]
	if not v3 then
		return
	end

	local v1 = LocalPlayer:GetAttribute("IsInOwnGarden")
	local v2 = if v1 then 0.5 else 1
	local v32 = v10

	if not v32 then
		RebuildPreviewVisualPartsCache()
		v32 = v10
	end

	if v32 then
		for v4, v5 in v32 do
			if v5.Parent then
				if v5:IsA("BasePart") then
					v5.Transparency = v2

					continue
				end

				if v5:IsA("Decal") then
					v5.Transparency = v2
				end
			end
		end
	end

	local SelectionBox = v3:FindFirstChild("SelectionBox")

	if SelectionBox and SelectionBox:IsA("SelectionBox") then
		SelectionBox.Visible = v1
	end

	if v1 then
		HideHeldVisual()
	else
		ShowHeldVisual()
	end
end

local function UpdatePreview() --[[ UpdatePreview | Line: 500 | Upvalues: v3 (ref), LocalPlayer (copy), UpdatePreviewVisibility (copy), RaycastFromMouse (copy), Gardens (copy), PlacementGrid (copy), v5 (ref), v2 (ref), v4 (ref), IsPositionInPropArea (copy), UpdatePreviewColor (copy) ]]
	if not (v3 and v3.PrimaryPart) then
		return
	end

	if LocalPlayer:GetAttribute("IsInOwnGarden") then
		local v1 = RaycastFromMouse(v3)

		if not v1 then
			return
		end

		local v22 = LocalPlayer:GetAttribute("PlotId")
		local v32 = if v22 then Gardens:FindFirstChild("Plot" .. tostring(v22)) else nil
		local v52 = if v32 then v32:FindFirstChild("SpawnPoint") else nil
		local v6

		if v52 and math.abs(v1.Normal.Y) > 0.1 then
			v6 = PlacementGrid.SnapToGrid(v1.Position, v52, 0.5)
		else
			local v7, v8, v9, v10, v11, v12

			v7 = v1.Position.X / 0.5 + 0.5
			v8 = math.floor(v7) * 0.5
			v9 = v1.Position.Y
			v10 = v1.Position.Z / 0.5 + 0.5
			v11 = math.floor(v10) * 0.5
			v12 = Vector3.new(v8, v9, v11)
			v6 = v12
		end

		v5 = v6
		v3:PivotTo((PlacementGrid.PositionModel(v3, v6, if v52 then PlacementGrid.GetGardenRotationY(v52) or 0 else 0, v2)))
		v4 = IsPositionInPropArea(v6)
		UpdatePreviewColor(v4)
	end

	UpdatePreviewVisibility()
end

local function PlacePot() --[[ PlacePot | Line: 539 | Upvalues: v3 (ref), v4 (ref), v5 (ref), v6 (ref), LocalPlayer (copy), NotificationController (copy), Gardens (copy), PlacementGrid (copy), v2 (ref), Networking (copy) ]]
	if not (v3 and (v4 and (v5 and v6))) then
		return
	end

	if not LocalPlayer:GetAttribute("IsInOwnGarden") then
		NotificationController:CreateNotification("You must be in your garden to place this!")

		return
	end

	local v1 = LocalPlayer:GetAttribute("PlotId")
	local v22 = if v1 then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil
	local v42 = if v22 then v22:FindFirstChild("SpawnPoint") else nil

	Networking.PotPlacement.PlacePottedPlant:Fire(v5, math.deg(if v42 then PlacementGrid.GetGardenRotationY(v42) or 0 else 0) + v2, v6:GetAttribute("Id"))
end

local function ClearConnections() --[[ ClearConnections | Line: 562 | Upvalues: t2 (ref) ]]
	for v1, v2 in t2 do
		v2:Disconnect()
	end

	t2 = {}
end

local function ExitPlacementMode() --[[ ExitPlacementMode | Line: 568 | Upvalues: v1 (ref), v8 (ref), t2 (ref), v7 (ref), v3 (ref), v10 (ref), v2 (ref), v5 (ref), v4 (ref) ]]
	v1 = false

	if v8 then
		task.cancel(v8)
		v8 = nil
	end

	for v12, v22 in t2 do
		v22:Disconnect()
	end

	t2 = {}
	v7 = nil

	if v3 then
		v3:Destroy()
		v3 = nil
	end

	v10 = nil
	v2 = 0
	v5 = nil
	v4 = false
end

local function EnterPlacementMode(p1) --[[ EnterPlacementMode | Line: 584 | Upvalues: v1 (ref), v8 (ref), t2 (ref), v7 (ref), v3 (ref), v10 (ref), v2 (ref), v5 (ref), v4 (ref), v6 (ref), BuildPreview (copy), BuildPropAreaCache (copy), RunService (copy), UpdatePreview (copy), UserInputService (copy), PlacePot (copy), LocalPlayer (copy), HideHeldVisual (copy), RebuildPreviewVisualPartsCache (copy), UpdatePreviewVisibility (copy) ]]
	if v1 then
		v1 = false

		if v8 then
			task.cancel(v8)
			v8 = nil
		end

		for v12, v22 in t2 do
			v22:Disconnect()
		end

		t2 = {}
		v7 = nil

		if v3 then
			v3:Destroy()
			v3 = nil
		end

		v10 = nil
		v2 = 0
		v5 = nil
		v4 = false
	end

	v1 = true
	v6 = p1
	BuildPreview(p1)
	BuildPropAreaCache()

	local v32 = t2

	table.insert(v32, RunService.RenderStepped:Connect(UpdatePreview))

	local v52 = t2

	local function f6(p1, p2) --[[ Line: 598 | Upvalues: v1 (ref), PlacePot (ref), v2 (ref), v8 (ref), t2 (ref), v7 (ref), v3 (ref), v10 (ref), v5 (ref), v4 (ref) ]]
		if p2 then
			return
		end

		if not v1 then
			return
		end

		if if p1.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p1.KeyCode == Enum.KeyCode.ButtonR2 then true else false then
			PlacePot()

			return
		end

		if p1.KeyCode == Enum.KeyCode.R or p1.KeyCode == Enum.KeyCode.ButtonR1 then
			v2 = (v2 + 15) % 360

			if not v8 then
				v8 = task.spawn(function() --[[ Line: 177 | Upvalues: v2 (ref) ]]
					task.wait(1)

					while true do
						v2 = (v2 + 15) % 360
						task.wait(0.08)
					end
				end)

				return
			end

			task.cancel(v8)
			v8 = nil
			v8 = task.spawn(function() --[[ Line: 177 | Upvalues: v2 (ref) ]]
				task.wait(1)

				while true do
					v2 = (v2 + 15) % 360
					task.wait(0.08)
				end
			end)
		else
			if p1.KeyCode ~= Enum.KeyCode.Escape and p1.KeyCode ~= Enum.KeyCode.ButtonB then
				return
			end

			v1 = false

			if v8 then
				task.cancel(v8)
				v8 = nil
			end

			for v22, v32 in t2 do
				v32:Disconnect()
			end

			t2 = {}
			v7 = nil

			if not v3 then
				v10 = nil
				v2 = 0
				v5 = nil
				v4 = false

				return
			end

			v3:Destroy()
			v3 = nil
			v10 = nil
			v2 = 0
			v5 = nil
			v4 = false
		end
	end

	table.insert(v52, UserInputService.InputBegan:Connect(f6))

	local v72 = t2

	local function f8(p1) --[[ Line: 631 | Upvalues: v8 (ref) ]]
		if p1.KeyCode ~= Enum.KeyCode.R and p1.KeyCode ~= Enum.KeyCode.ButtonR1 or not v8 then
			return
		end

		task.cancel(v8)
		v8 = nil
	end

	table.insert(v72, UserInputService.InputEnded:Connect(f8))

	local v9 = t2

	local function f11() --[[ Line: 638 | Upvalues: p1 (copy), LocalPlayer (ref), v1 (ref), v8 (ref), t2 (ref), v7 (ref), v3 (ref), v10 (ref), v2 (ref), v5 (ref), v4 (ref) ]]
		if p1.Parent == LocalPlayer.Character then
			return
		end

		v1 = false

		if v8 then
			task.cancel(v8)
			v8 = nil
		end

		for v12, v22 in t2 do
			v22:Disconnect()
		end

		t2 = {}
		v7 = nil

		if v3 then
			v3:Destroy()
			v3 = nil
		end

		v10 = nil
		v2 = 0
		v5 = nil
		v4 = false
	end

	table.insert(v9, p1:GetPropertyChangedSignal("Parent"):Connect(f11))

	local v13, v14

	if LocalPlayer:GetAttribute("IsInOwnGarden") then
		HideHeldVisual()
	end

	v13 = LocalPlayer:GetAttributeChangedSignal("IsInOwnGarden")
	v14 = function() --[[ Line: 650 | Upvalues: RebuildPreviewVisualPartsCache (ref), UpdatePreviewVisibility (ref), LocalPlayer (ref), BuildPropAreaCache (ref) ]]
		RebuildPreviewVisualPartsCache()
		task.defer(UpdatePreviewVisibility)

		if not LocalPlayer:GetAttribute("IsInOwnGarden") then
			return
		end

		BuildPropAreaCache()
	end
	table.insert(t2, v13:Connect(v14))
end

function t.Init(p1) --[[ Init | Line: 668 | Upvalues: v11 (ref) ]]
	v11 = workspace:WaitForChild("PottedPlantVisuals")
end
function t.Start(p1) --[[ Start | Line: 672 | Upvalues: EnterPlacementMode (copy), v1 (ref), v8 (ref), t2 (ref), v7 (ref), v3 (ref), v10 (ref), v2 (ref), v5 (ref), v4 (ref), LocalPlayer (copy), Networking (copy) ]]
	local function SetupCharacter(p1) --[[ SetupCharacter | Line: 673 | Upvalues: EnterPlacementMode (ref), v1 (ref), v8 (ref), t2 (ref), v7 (ref), v3 (ref), v10 (ref), v2 (ref), v5 (ref), v4 (ref) ]]
		p1.ChildAdded:Connect(function(p12) --[[ Line: 675 | Upvalues: p1 (copy), EnterPlacementMode (ref) ]]
			if not (p12:IsA("Tool") and p12:GetAttribute("PottedPlant")) then
				return
			end

			task.defer(function() --[[ Line: 677 | Upvalues: p12 (copy), p1 (ref), EnterPlacementMode (ref) ]]
				if p12.Parent ~= p1 then
					return
				end

				EnterPlacementMode(p12)
			end)
		end)
		p1.ChildRemoved:Connect(function(p1) --[[ Line: 686 | Upvalues: v1 (ref), v8 (ref), t2 (ref), v7 (ref), v3 (ref), v10 (ref), v2 (ref), v5 (ref), v4 (ref) ]]
			if not (p1:IsA("Tool") and p1:GetAttribute("PottedPlant")) then
				return
			end

			v1 = false

			if v8 then
				task.cancel(v8)
				v8 = nil
			end

			for v12, v22 in t2 do
				v22:Disconnect()
			end

			t2 = {}
			v7 = nil

			if v3 then
				v3:Destroy()
				v3 = nil
			end

			v10 = nil
			v2 = 0
			v5 = nil
			v4 = false
		end)
	end

	SetupCharacter(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())
	LocalPlayer.CharacterAdded:Connect(SetupCharacter)
	Networking.PotPlacement.PottedPlantPlaced.OnClientEvent:Connect(function() --[[ Line: 698 | Upvalues: v1 (ref), v8 (ref), t2 (ref), v7 (ref), v3 (ref), v10 (ref), v2 (ref), v5 (ref), v4 (ref) ]]
		v1 = false

		if v8 then
			task.cancel(v8)
			v8 = nil
		end

		for v12, v22 in t2 do
			v22:Disconnect()
		end

		t2 = {}
		v7 = nil

		if v3 then
			v3:Destroy()
			v3 = nil
		end

		v10 = nil
		v2 = 0
		v5 = nil
		v4 = false
	end)
end

return t