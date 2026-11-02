--credit to leon games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")
local Rakes = ReplicatedStorage.Assets.Rakes
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local RakeData = require(ReplicatedStorage.SharedModules.RakeData)

require(ReplicatedStorage.ClientModules.PlacementGrid)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local CurrentCamera = workspace.CurrentCamera
local Gardens = workspace:WaitForChild("Gardens")
local Assets = ReplicatedStorage.Assets
local Temporary = workspace.Temporary

local function debugPrint(...) --[[ debugPrint | Line: 35 ]] end

local v1 = 0
local v2 = Color3.fromRGB(100, 255, 100)
local v3 = Color3.fromRGB(255, 100, 100)
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local t2 = {}
local v9 = 0
local v10 = false
local v11 = nil
local t3 = {}
local t4 = {}
local v12 = nil
local v13 = nil

function t.Init(p1) --[[ Init | Line: 84 | Upvalues: RakeData (copy), t2 (copy) ]]
	for v1, v2 in RakeData do
		t2[v2.RakeName] = v2
	end
end
function t.Start(p1) --[[ Start | Line: 90 | Upvalues: v12 (ref), PlayerGui (copy), v13 (ref), v10 (ref), v9 (ref), debugPrint (copy), UserInputService (copy), LocalPlayer (copy) ]]
	v12 = PlayerGui:WaitForChild("RakeUI")
	v13 = v12:WaitForChild("Rotate")
	v13.Visible = false
	v13.Activated:Connect(function() --[[ Line: 95 | Upvalues: v10 (ref), v9 (ref), debugPrint (ref) ]]
		if not v10 then
			return
		end

		v9 = (v9 + 15) % 360
		debugPrint("UI Rotate pressed, placingRotation =", v9)
	end)
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 102 | Upvalues: p1 (copy) ]]
		p1:OnInput(p12, p2)
	end)
	UserInputService.InputEnded:Connect(function(p12, p2) --[[ Line: 106 | Upvalues: p1 (copy) ]]
		if p12.KeyCode ~= Enum.KeyCode.R and p12.KeyCode ~= Enum.KeyCode.ButtonR1 then
			return
		end

		p1:StopRotateHold()
	end)

	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 116 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	p1:SetupRakeTouchDetection()
end
function t.StartRotateHold(p1) --[[ StartRotateHold | Line: 126 | Upvalues: v11 (ref), v9 (ref) ]]
	p1:StopRotateHold()
	v11 = task.spawn(function() --[[ Line: 128 | Upvalues: v9 (ref) ]]
		task.wait(1)

		while true do
			v9 = (v9 + 15) % 360
			task.wait(0.08)
		end
	end)
end
function t.StopRotateHold(p1) --[[ StopRotateHold | Line: 137 | Upvalues: v11 (ref) ]]
	if not v11 then
		return
	end

	task.cancel(v11)
	v11 = nil
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 147 ]]
	p2.ChildAdded:Connect(function(p12) --[[ Line: 148 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("Rake")) then
			return
		end

		p1:EnterPlacingMode(p12:GetAttribute("Rake"))
	end)
	p2.ChildRemoved:Connect(function(p12) --[[ Line: 154 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("Rake")) then
			return
		end

		p1:ExitPlacingMode()
	end)

	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("Rake") then
			p1:EnterPlacingMode(v2:GetAttribute("Rake"))
		end
	end
end
function t.EnterPlacingMode(p1, p2) --[[ EnterPlacingMode | Line: 170 | Upvalues: v10 (ref), v9 (ref), debugPrint (copy), v13 (ref) ]]
	p1:ExitPlacingMode()
	v10 = true
	v9 = 0
	debugPrint("EnterPlacingMode: rakeName =", p2, ", placingRotation reset to 0")

	if not v13 then
		p1:CreatePreview(p2)

		return
	end

	v13.Visible = true
	p1:CreatePreview(p2)
end
function t.ExitPlacingMode(p1) --[[ ExitPlacingMode | Line: 185 | Upvalues: v10 (ref), v13 (ref) ]]
	v10 = false
	p1:StopRotateHold()

	if not v13 then
		p1:DestroyPreview()

		return
	end

	v13.Visible = false
	p1:DestroyPreview()
end
function t.CreatePreview(p1, p2) --[[ CreatePreview | Line: 199 | Upvalues: Rakes (copy), t2 (copy), v4 (ref), Assets (copy), v5 (ref), v7 (ref), TweenService (copy), v8 (ref), Debris (copy), Temporary (copy), v6 (ref), RunService (copy) ]]
	p1:DestroyPreview()

	local v1 = Rakes:FindFirstChild(p2)
	local v2 = t2[p2]

	if not (v1 and v2) then
		return
	end

	v4 = v1:Clone()
	v4.Name = "RakePreview"

	local v3 = Assets.SprinklerRadius:Clone()

	v3.Size = Vector3.new(v2.Radius * 2, 0.5, v2.Radius * 2)
	v3.Anchored = true
	v3.CanCollide = false
	v3.CanQuery = false
	v3.CanTouch = false
	v3.Parent = v4
	v5 = v3

	local SurfaceGui = v3:FindFirstChild("SurfaceGui")

	if SurfaceGui then
		local PrimaryCircle = SurfaceGui:FindFirstChild("PrimaryCircle")

		if PrimaryCircle and PrimaryCircle:IsA("ImageLabel") then
			v7 = TweenService:Create(PrimaryCircle, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
				ImageTransparency = 0.5
			})
			v8 = task.spawn(function() --[[ Line: 228 | Upvalues: v5 (ref), PrimaryCircle (copy), SurfaceGui (copy), TweenService (ref), Debris (ref) ]]
				while v5 do
					local v1 = PrimaryCircle:Clone()
					local UIScale = v1:FindFirstChildOfClass("UIScale")

					if not UIScale then
						local UIScale2 = Instance.new("UIScale")

						UIScale2.Parent = v1
						UIScale = UIScale2
					end

					v1.Parent = SurfaceGui
					UIScale.Scale = 0

					local v2 = TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
					local v3 = TweenService:Create(UIScale, v2, {
						Scale = 1
					})

					v3:Play()
					Debris:AddItem(v3, v2.Time)

					local v4 = TweenService:Create(v1, v2, {
						ImageTransparency = 0
					})

					v4:Play()
					Debris:AddItem(v4, v2.Time)
					v4.Completed:Once(function() --[[ Line: 250 | Upvalues: TweenService (ref), v1 (copy), Debris (ref) ]]
						local v12 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						local v2 = TweenService:Create(v1, v12, {
							ImageTransparency = 1
						})

						v2:Play()
						Debris:AddItem(v2, v12.Time)
						v2.Completed:Once(function() --[[ Line: 255 | Upvalues: v1 (ref) ]]
							v1:Destroy()
						end)
					end)
					task.wait(1.1)
				end
			end)
		end
	end

	for v62, v72 in v4:GetDescendants() do
		if v72:IsA("BasePart") then
			if v72.Transparency == 0 then
				v72.Transparency = 0.5
			end

			v72.CanCollide = false
			v72.CanQuery = false
			v72.CanTouch = false
			v72.Anchored = true

			continue
		end

		if v72:IsA("ParticleEmitter") then
			v72.Enabled = false
		end
	end

	v4.Parent = Temporary
	v6 = RunService.RenderStepped:Connect(function() --[[ Line: 281 | Upvalues: p1 (copy) ]]
		p1:UpdatePreview()
	end)
end
function t.DestroyPreview(p1) --[[ DestroyPreview | Line: 286 | Upvalues: v8 (ref), v7 (ref), v4 (ref), v5 (ref), v6 (ref) ]]
	if v8 then
		task.cancel(v8)
		v8 = nil
	end

	if v7 then
		v7:Cancel()
		v7:Destroy()
		v7 = nil
	end

	if v4 then
		v4:Destroy()
		v4 = nil
	end

	v5 = nil

	if not v6 then
		return
	end

	v6:Disconnect()
	v6 = nil
end
function t.SetPreviewColor(p1, p2) --[[ SetPreviewColor | Line: 312 | Upvalues: v4 (ref), v2 (copy), v3 (copy) ]]
	if not v4 then
		return
	end

	local v1 = p2 and v2 or v3

	for v22, v32 in v4:GetDescendants() do
		if v32:IsA("BasePart") then
			v32.Color = v1
		end
	end
end
function t.IsUsingGamepad(p1) --[[ IsUsingGamepad | Line: 325 | Upvalues: UserInputService (copy) ]]
	local v1 = UserInputService:GetLastInputType()

	return if v1 == Enum.UserInputType.Gamepad1 or (v1 == Enum.UserInputType.Gamepad2 or v1 == Enum.UserInputType.Gamepad3) then true else v1 == Enum.UserInputType.Gamepad4
end
function t.GetGamepadPlacementRay(p1) --[[ GetGamepadPlacementRay | Line: 333 | Upvalues: LocalPlayer (copy) ]]
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
function t.CreateRaycastParams(p1) --[[ CreateRaycastParams | Line: 345 | Upvalues: CollectionService (copy) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Include

	local v2 = CollectionService:GetTagged("GardenTotalArea")

	for v3, v4 in CollectionService:GetTagged("PlantArea") do
		table.insert(v2, v4)
	end

	v1.FilterDescendantsInstances = v2

	return v1
end
function t.CreatePreviewRaycastParams(p1) --[[ CreatePreviewRaycastParams | Line: 360 | Upvalues: LocalPlayer (copy), Temporary (copy) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Exclude

	local Character = LocalPlayer.Character
	local v2 = workspace:QueryDescendants("BasePart[Transparency = 1]")

	table.insert(v2, Temporary)

	if Character then
		table.insert(v2, Character)
	end

	v1.FilterDescendantsInstances = v2

	return v1
end
function t.GetPlayerPlot(p1) --[[ GetPlayerPlot | Line: 376 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")

	if v1 then
		return Gardens:FindFirstChild("Plot" .. v1)
	end

	return nil
end
function t.GetPlotFromPart(p1, p2) --[[ GetPlotFromPart | Line: 382 | Upvalues: Gardens (copy) ]]
	local v1 = p2

	repeat
		if not v1 then
			break
		end

		if v1.Parent == Gardens and string.match(v1.Name, "^Plot%d+$") then
			return v1
		end

		v1 = v1.Parent
	until v1 == workspace

	return nil
end
function t.GetPlotId(p1, p2) --[[ GetPlotId | Line: 394 ]]
	local match = string.match

	return tonumber(match(p2.Name, "%d+"))
end
function t.GetEquippedTool(p1) --[[ GetEquippedTool | Line: 398 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if Character then
		return Character:FindFirstChildWhichIsA("Tool")
	end

	return nil
end
function t.GetSpawnPoint(p1) --[[ GetSpawnPoint | Line: 404 ]]
	local v1 = p1:GetPlayerPlot()

	if v1 then
		return v1:FindFirstChild("SpawnPoint")
	end

	return nil
end
function t.GetGardenRotationY(p1) --[[ GetGardenRotationY | Line: 410 ]]
	local v1 = p1:GetSpawnPoint()

	if v1 then
		local _, v2, _2 = v1.CFrame:ToEulerAnglesYXZ()

		return v2
	end

	return 0
end
function t.IsTooCloseToRake(p1, p2, p3) --[[ IsTooCloseToRake | Line: 420 | Upvalues: v4 (ref) ]]
	if not p2 then
		return false
	end

	local Rakes = p2:FindFirstChild("Rakes")

	if not Rakes then
		return false
	end

	for v1, v2 in Rakes:GetDescendants() do
		if v2:IsA("Model") and (v2 ~= v4 and (v2.PrimaryPart and (v2.PrimaryPart.Position - p3).Magnitude < 0.5)) then
			return true
		end
	end

	return false
end
function t.IsValidPlacement(p1, p2) --[[ IsValidPlacement | Line: 437 | Upvalues: CollectionService (copy) ]]
	local v2 = CollectionService:GetTagged("GardenTotalArea")

	if #v2 == 0 then
		return false
	end

	local v3 = RaycastParams.new()

	v3.FilterType = Enum.RaycastFilterType.Include
	v3.FilterDescendantsInstances = v2

	return workspace:Raycast(p2 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0), v3) ~= nil
end
function t.ComputeRakeCFrame(p1, p2) --[[ ComputeRakeCFrame | Line: 452 | Upvalues: v9 (ref) ]]
	local v2 = p1:GetGardenRotationY() + math.rad(v9)

	return CFrame.new(p2) * CFrame.Angles(0, v2, 0)
end
function t.UpdatePreview(p1) --[[ UpdatePreview | Line: 461 | Upvalues: v4 (ref), UserInputService (copy), CurrentCamera (copy), CollectionService (copy), LocalPlayer (copy), Temporary (copy), v5 (ref) ]]
	if not v4 then
		return
	end

	local v1 = p1:CreateRaycastParams()
	local v2

	if p1:IsUsingGamepad() then
		local v3, v42 = p1:GetGamepadPlacementRay()

		if not v3 then
			v4.Parent = nil

			return
		end

		v2 = workspace:Raycast(v3, v42, v1)
	else
		local v6 = UserInputService:GetMouseLocation()
		local v7 = CurrentCamera:ViewportPointToRay(v6.X, v6.Y)

		v2 = workspace:Raycast(v7.Origin, v7.Direction * 5000, v1)
	end

	if v2 then
		local v9 = v2.Instance
		local v10 = p1:GetPlotFromPart(v9)
		local v11 = v10 and (if CollectionService:HasTag(v9, "GardenTotalArea") then v9:IsDescendantOf(v10) and (if v10:GetAttribute("OwnerUserId") == LocalPlayer.UserId then not p1:IsTooCloseToRake(v10, v2.Position) and p1:IsValidPlacement(v2.Position) else false) else CollectionService:HasTag(v9, "PlantArea") and v9:IsDescendantOf(v10) and (if v10:GetAttribute("OwnerUserId") == LocalPlayer.UserId then not p1:IsTooCloseToRake(v10, v2.Position) and p1:IsValidPlacement(v2.Position) else false))

		v4.Parent = Temporary

		local Position = v2.Position
		local v12 = Vector3.new(Position.X, Position.Y, Position.Z)

		v4:PivotTo(p1:ComputeRakeCFrame(v12) * CFrame.Angles(0, math.pi, 0))

		if not v5 then
			p1:SetPreviewColor(v11)

			return
		end

		v5.CFrame = CFrame.new(v12)
		p1:SetPreviewColor(v11)
	else
		local v13 = p1:CreatePreviewRaycastParams()
		local v14

		if p1:IsUsingGamepad() then
			local v15, v16 = p1:GetGamepadPlacementRay()

			if not v15 then
				v4.Parent = nil

				return
			end

			v14 = workspace:Raycast(v15, v16, v13)
		else
			local v18 = UserInputService:GetMouseLocation()
			local v19 = CurrentCamera:ViewportPointToRay(v18.X, v18.Y)

			v14 = workspace:Raycast(v19.Origin, v19.Direction * 5000, v13)
		end

		if not v14 then
			v4.Parent = nil

			return
		end

		v4.Parent = Temporary

		local Position = v14.Position
		local v21 = Vector3.new(Position.X, 142.602, Position.Z)

		v4:PivotTo(p1:ComputeRakeCFrame(v21) * CFrame.Angles(0, math.pi, 0))

		if not v5 then
			p1:SetPreviewColor(false)

			return
		end

		v5.CFrame = CFrame.new(v21)
		p1:SetPreviewColor(false)
	end
end
function t.CleanupTouchConnections(p1) --[[ CleanupTouchConnections | Line: 546 | Upvalues: t4 (ref) ]]
	for v1, v2 in t4 do
		v2:Disconnect()
	end

	t4 = {}
end
function t.OnRakeTouched(p1, p2, p3) --[[ OnRakeTouched | Line: 553 | Upvalues: LocalPlayer (copy), t2 (copy), t3 (copy), debugPrint (copy), Networking (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	if not p3:IsDescendantOf(Character) then
		return
	end

	local v1 = os.clock()
	local v2 = p2:GetAttribute("RakeName") or p2.Name
	local v3 = p2:GetAttribute("RakeId") or p2.Name
	local v6 = t3[v3]

	if v6 and v1 - v6 < (t2[v2] and t2[v2].Cooldown or 3) then
		return
	end

	t3[v3] = v1

	local v7 = if p2.PrimaryPart then p2.PrimaryPart.Position else p2:GetPivot().Position

	debugPrint("=== RAKE TOUCHED ===")
	debugPrint("  rakeName =", v2)
	debugPrint("  rakePosition =", v7)

	if p2.PrimaryPart then
		local v8 = p2.PrimaryPart.CFrame
		local _, v9, _2 = v8:ToEulerAnglesYXZ()

		debugPrint("  Client sees PrimaryPart CFrame =", v8)
		debugPrint("  Client sees PrimaryPart rotY(rad) =", v9, "rotY(deg) =", (math.deg(v9)))
		debugPrint("  Client sees PrimaryPart LookVector =", v8.LookVector)
		debugPrint("  Client sees PrimaryPart RightVector =", v8.RightVector)
	else
		debugPrint("  WARNING: PrimaryPart is nil!")
	end

	debugPrint("  Firing RakeActivated to server with position =", v7)
	debugPrint("=== END RAKE TOUCHED ===")
	Networking.Place.RakeActivated:Fire(v2, v7)
end
function t.ConnectRakeTouch(p1, p2) --[[ ConnectRakeTouch | Line: 593 | Upvalues: t4 (ref) ]]
	for v1, v2 in p2:GetDescendants() do
		if v2:IsA("BasePart") then
			table.insert(t4, (v2.Touched:Connect(function(p12) --[[ Line: 596 | Upvalues: p1 (copy), p2 (copy) ]]
				p1:OnRakeTouched(p2, p12)
			end)))
		end
	end
end
function t.GetRakeModelFromDescendant(p1, p2) --[[ GetRakeModelFromDescendant | Line: 605 | Upvalues: Gardens (copy) ]]
	local v1 = p2

	while v1 and v1 ~= Gardens do
		if v1:IsA("Model") and (v1.Parent and v1.Parent.Name == "Rakes") then
			return v1
		end

		v1 = v1.Parent
	end

	return nil
end

local t5 = {}

function t.SetupRakeTouchDetection(p1) --[[ SetupRakeTouchDetection | Line: 619 | Upvalues: debugPrint (copy), Gardens (copy), t5 (copy), t4 (ref) ]]
	debugPrint("SetupRakeTouchDetection: setting up DescendantAdded listener")

	for v1, v2 in Gardens:GetChildren() do
		if v2:IsA("Model") then
			local Rakes = v2:FindFirstChild("Rakes")

			if Rakes then
				for v3, v4 in Rakes:GetChildren() do
					if v4:IsA("Model") and not t5[v4] then
						t5[v4] = true
						p1:ConnectRakeTouch(v4)
						debugPrint("  Connected existing rake:", v4.Name, "in", v2.Name)
					end
				end
			end
		end
	end

	Gardens.DescendantAdded:Connect(function(p12) --[[ Line: 639 | Upvalues: t5 (ref), p1 (copy), debugPrint (ref), t4 (ref) ]]
		if p12:IsA("Model") and (p12.Parent and p12.Parent.Name == "Rakes") then
			task.wait()

			if t5[p12] then
				return
			end

			t5[p12] = true
			p1:ConnectRakeTouch(p12)
			debugPrint("  DescendantAdded: connected new rake model:", p12.Name)
		else
			if not p12:IsA("BasePart") then
				return
			end

			local v1 = p1:GetRakeModelFromDescendant(p12)

			if not (v1 and t5[v1]) then
				return
			end

			local v2 = p12.Touched:Connect(function(p12) --[[ Line: 655 | Upvalues: p1 (ref), v1 (copy) ]]
				p1:OnRakeTouched(v1, p12)
			end)

			table.insert(t4, v2)
		end
	end)
	Gardens.DescendantRemoving:Connect(function(p1) --[[ Line: 664 | Upvalues: t5 (ref) ]]
		if not (p1:IsA("Model") and t5[p1]) then
			return
		end

		t5[p1] = nil
	end)
	debugPrint("SetupRakeTouchDetection: done")
end
function t.OnInput(p1, p2, p3) --[[ OnInput | Line: 676 | Upvalues: v10 (ref), v9 (ref), debugPrint (copy), v1 (ref), CurrentCamera (copy), CollectionService (copy), LocalPlayer (copy), Networking (copy), SoundService (copy) ]]
	if p3 then
		return
	end

	if v10 and (p2.KeyCode == Enum.KeyCode.R or p2.KeyCode == Enum.KeyCode.ButtonR1) then
		v9 = (v9 + 15) % 360
		debugPrint("R key: placingRotation =", v9)
		p1:StartRotateHold()

		return
	end

	if not (if p2.UserInputType == Enum.UserInputType.MouseButton1 or p2.UserInputType == Enum.UserInputType.Touch then true elseif p2.KeyCode == Enum.KeyCode.ButtonR2 then true else false) then
		return
	end

	local v2 = os.clock()

	if v2 - v1 < 0.5 then
		return
	end

	local v3 = p1:GetEquippedTool()

	if not v3 then
		return
	end

	local v4 = v3:GetAttribute("Rake")

	if not v4 then
		return
	end

	local v5 = p1:CreateRaycastParams()
	local v6

	if p1:IsUsingGamepad() then
		local v7, v8 = p1:GetGamepadPlacementRay()

		if not v7 then
			return
		end

		v6 = workspace:Raycast(v7, v8, v5)
	else
		local Position = p2.Position
		local v102 = CurrentCamera:ScreenPointToRay(Position.X, Position.Y)

		v6 = workspace:Raycast(v102.Origin, v102.Direction * 5000, v5)
	end

	if not v6 then
		return
	end

	local v122 = v6.Instance

	if not (CollectionService:HasTag(v122, "GardenTotalArea") or CollectionService:HasTag(v122, "PlantArea")) then
		return
	end

	local v13 = p1:GetPlotFromPart(v122)

	if not v13 then
		return
	end

	if not v122:IsDescendantOf(v13) then
		return
	end

	if not v13:GetAttribute("Owner") then
		return
	end

	local v14 = p1:GetPlotId(v13)

	if not v14 then
		return
	end

	if v13:GetAttribute("OwnerUserId") ~= LocalPlayer.UserId then
		return
	end

	if p1:IsTooCloseToRake(v13, v6.Position) then
		return
	end

	if not p1:IsValidPlacement(v6.Position) then
		return
	end

	v1 = v2

	local Position = v6.Position
	local v15 = p1:GetSpawnPoint()
	local v16 = p1:GetGardenRotationY()
	local v17 = math.deg(v16)

	debugPrint("=== PLACEMENT FIRE ===")
	debugPrint("  hitPosition =", Position)
	debugPrint("  rakeName =", v4)
	debugPrint("  targetPlotId =", v14)
	debugPrint("  SpawnPoint CFrame =", v15 and v15.CFrame or "nil")
	debugPrint("  gardenRotY(rad) =", v16, "gardenRotY(deg) =", v17)
	debugPrint("  placingRotation(deg) =", v9)

	local v21 = v17 + v9

	debugPrint("  worldRotationDeg = gardenRotYDeg + placingRotation =", v21)

	local v23 = CFrame.new(Position) * CFrame.Angles(0, v16 + math.rad(v9), 0)
	local _, v24, _2 = v23:ToEulerAnglesYXZ()

	debugPrint("  PREVIEW CFrame =", v23)
	debugPrint("  PREVIEW rotY(deg) =", (math.deg(v24)))
	debugPrint("  PREVIEW LookVector =", v23.LookVector)

	local SpawnPoint = v13:FindFirstChild("SpawnPoint")
	local v25

	if SpawnPoint then
		local _3, v26, _4 = SpawnPoint.CFrame:ToEulerAnglesYXZ()
		local v27 = math.deg(v26)

		debugPrint("  targetSpawnPoint CFrame =", SpawnPoint.CFrame)
		debugPrint("  targetSpawnPoint rotY(rad) =", v26, "rotY(deg) =", v27)
		v25 = v21 - v27
		debugPrint("  relativeRotation = worldRotDeg - spawnRotYDeg =", v21, "-", v27, "=", v25)
	else
		debugPrint("  WARNING: no SpawnPoint in targetPlot!")
		v25 = v21
	end

	debugPrint("  >>> SENDING TO SERVER: relativeRotation =", v25)
	debugPrint("=== END PLACEMENT FIRE ===")
	Networking.Place.PlaceRake:Fire(Position, v4, v3, v14, v25)

	local Character = LocalPlayer.Character
	local v28 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not v28 then
		return
	end

	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://135948019584556"
	Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	Sound.Parent = v28
	Sound:Play()
	game.Debris:AddItem(Sound, 3)
end

return t