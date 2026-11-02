--credit to quartz games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local BillboardGui = script.BillboardGui
local TextLabel = BillboardGui.TextLabel.TextLabel
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Assets = ReplicatedStorage.Assets
local Gnome = Assets:WaitForChild("Gnome")
local Temporary = workspace.Temporary
local v1 = 0

local function raycastSkipTransparent(p1, p2, p3) --[[ raycastSkipTransparent | Line: 35 ]]
	for i = 1, 10 do
		local v1 = workspace:Raycast(p1, p2, p3)

		if not v1 then
			break
		end

		if not (v1.Instance.Transparency >= 1) then
			return v1
		end

		local v2 = table.clone(p3.FilterDescendantsInstances)

		table.insert(v2, v1.Instance)
		p3.FilterDescendantsInstances = v2
	end

	return nil
end

local v2 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local v3 = Color3.fromRGB(100, 255, 100)
local v4 = Color3.fromRGB(255, 100, 100)
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local Gnomes = workspace:WaitForChild("Gnomes")
local GnomeVisuals = Instance.new("Folder")

GnomeVisuals.Name = "GnomeVisuals"
GnomeVisuals.Parent = workspace

local t2 = {}
local t3 = {}

Networking.Gnome.Positions.OnClientEvent:Connect(function(p1) --[[ Line: 77 | Upvalues: t3 (copy) ]]
	if typeof(p1) ~= "table" then
		return
	end

	for v1, v2 in p1 do
		local v3 = v2[1]
		local v4 = v2[2]

		if typeof(v3) == "Instance" and (v3:IsA("BasePart") and typeof(v4) == "Vector3") then
			t3[v3] = v4
		end
	end
end)

local v10 = nil

local function createRangeIndicator(p1) --[[ createRangeIndicator | Line: 107 | Upvalues: Assets (copy), t3 (copy) ]]
	if p1.RangeIndicator then
		return
	end

	local v1 = p1.Part:GetAttribute("Range") or 50
	local GnomeRangeIndicator = Assets.SprinklerRadius:Clone()

	GnomeRangeIndicator.Name = "GnomeRangeIndicator"
	GnomeRangeIndicator.Size = Vector3.new(v1, 0.5, v1)
	GnomeRangeIndicator.Anchored = true
	GnomeRangeIndicator.CanCollide = false
	GnomeRangeIndicator.CanQuery = false
	GnomeRangeIndicator.CanTouch = false

	local v2 = t3[p1.Part] or p1.Part.Position

	GnomeRangeIndicator.CFrame = CFrame.new(v2.X, v2.Y - p1.Part.Size.Y / 2 + 0.1, v2.Z)
	p1.RangeIndicator = GnomeRangeIndicator
end

local function showRangeIndicator(p1) --[[ showRangeIndicator | Line: 127 | Upvalues: createRangeIndicator (copy), Temporary (copy) ]]
	if not p1.RangeIndicator then
		createRangeIndicator(p1)
	end

	local RangeIndicator = p1.RangeIndicator

	if RangeIndicator then
		RangeIndicator.Parent = Temporary
		p1.IsHovered = true
	end
end

local function hideRangeIndicator(p1) --[[ hideRangeIndicator | Line: 139 ]]
	if p1.RangeIndicator then
		p1.RangeIndicator.Parent = nil
	end

	p1.IsHovered = false
end

local function updateHoverDetection() --[[ updateHoverDetection | Line: 146 | Upvalues: LocalPlayer (copy), UserInputService (copy), CurrentCamera (copy), t2 (copy), v10 (ref), createRangeIndicator (copy), Temporary (copy) ]]
	if not LocalPlayer.Character then
		return
	end

	local v1 = UserInputService:GetMouseLocation()
	local v2 = CurrentCamera:ViewportPointToRay(v1.X, v1.Y)
	local t = {}

	for v3, v4 in t2 do
		if v4.Model and v4.Model.Parent then
			table.insert(t, v4.Model)
		end
	end

	if #t == 0 then
		if not v10 then
			return
		end

		local v5 = v10

		if v5.RangeIndicator then
			v5.RangeIndicator.Parent = nil
		end

		v5.IsHovered = false
		v10 = nil
	else
		local v6 = RaycastParams.new()

		v6.FilterType = Enum.RaycastFilterType.Include
		v6.FilterDescendantsInstances = t

		local v7 = workspace:Raycast(v2.Origin, v2.Direction * 500, v6)
		local v8 = nil

		if v7 and v7.Instance then
			for v9, v102 in t2 do
				if v102.Part:GetAttribute("Owner") == LocalPlayer.Name and (v7.Instance:IsDescendantOf(v102.Model) or v7.Instance == v102.Model.PrimaryPart) then
					v8 = v102

					break
				end
			end
		end

		if v8 == v10 then
			return
		end

		if v10 then
			local v11 = v10

			if v11.RangeIndicator then
				v11.RangeIndicator.Parent = nil
			end

			v11.IsHovered = false
		end

		if v8 then
			if not v8.RangeIndicator then
				createRangeIndicator(v8)
			end

			local v12 = v8
			local RangeIndicator = v12.RangeIndicator

			if RangeIndicator then
				RangeIndicator.Parent = Temporary
				v12.IsHovered = true
			end
		end

		v10 = v8
	end
end

local function setupVisualGnome(p1) --[[ setupVisualGnome | Line: 203 | Upvalues: t2 (copy), Gnome (copy), t3 (copy), GnomeVisuals (copy), BillboardGui (copy) ]]
	if t2[p1] then
		return
	end

	local v1 = Gnome:Clone()

	v1.Name = "GnomeVisual_" .. p1.Name

	local AnimationController = v1:FindFirstChildOfClass("AnimationController")

	if not AnimationController then
		AnimationController = Instance.new("AnimationController")
		AnimationController.Parent = v1
	end

	local Animator = AnimationController:FindFirstChildOfClass("Animator")

	if not Animator then
		Animator = Instance.new("Animator")
		Animator.Parent = AnimationController
	end

	local PrimaryPart = v1.PrimaryPart

	if PrimaryPart then
		PrimaryPart.Anchored = true
	end

	for v2, v3 in v1:GetDescendants() do
		if v3:IsA("BasePart") and v3 ~= PrimaryPart then
			v3.Anchored = false
		end

		if v3:IsA("BasePart") then
			v3.CanCollide = false
			v3.CanQuery = true
			v3.CanTouch = false
		end
	end

	local _, v6, _2 = p1.CFrame:ToEulerAnglesYXZ()
	local v7 = CFrame.new((t3[p1] or p1.Position) + Vector3.new(0, 0, 0)) * CFrame.Angles(0, v6, 0)

	if PrimaryPart then
		v1:PivotTo(v7)
	end

	v1.Parent = GnomeVisuals

	local t = {}
	local t4 = {}

	for v8, v9 in v1:GetChildren() do
		if v9:IsA("Animation") then
			t[v9.Name] = v9
		end
	end

	local Animations = v1:FindFirstChild("Animations")

	if Animations then
		for v10, v11 in Animations:GetChildren() do
			if v11:IsA("Animation") then
				t[v11.Name] = v11
			end
		end
	end

	for v12, v13 in t do
		local ok, result = pcall(function() --[[ Line: 269 | Upvalues: Animator (ref), v13 (copy) ]]
			return Animator:LoadAnimation(v13)
		end)

		if ok and result then
			t4[v12] = result

			if v12 == "Idle" or v12 == "Walk" then
				result.Looped = true

				continue
			end

			if v12 == "Attack" then
				result.Looped = false
			end
		end
	end

	local v14 = BillboardGui:Clone()

	if PrimaryPart then
		v14.Adornee = PrimaryPart
		v14.Parent = PrimaryPart
	end

	local t5 = {
		CurrentState = "",
		AttributeConn = nil,
		RangeIndicator = nil,
		IsHovered = false,
		Part = p1,
		Model = v1,
		Animator = Animator,
		Tracks = t4,
		CurrentCF = v7,
		Billboard = v14
	}

	t5.AttributeConn = p1.AttributeChanged:Connect(function(p12) --[[ Line: 304 | Upvalues: p1 (copy), t5 (copy) ]]
		if p12 ~= "GnomeState" then
			return
		end

		switchAnimation(t5, (p1:GetAttribute("GnomeState")))
	end)
	t2[p1] = t5
	switchAnimation(t5, p1:GetAttribute("GnomeState") or "idle")
end

function switchAnimation(p1, p2) --[[ switchAnimation | Line: 318 ]]
	if p1.CurrentState == p2 then
		return
	end

	p1.CurrentState = p2

	for v1, v2 in p1.Tracks do
		if v2.IsPlaying then
			v2:Stop(0.2)
		end
	end

	local v3 = nil

	if p2 == "idle" then
		v3 = "Idle"
	elseif p2 == "wandering" or p2 == "chasing" then
		v3 = "Walk"
	elseif p2 == "attacking" then
		v3 = "Attack"
	end

	if not (v3 and p1.Tracks[v3]) then
		return
	end

	p1.Tracks[v3]:Play(0.2)
end

local function cleanupVisualGnome(p1) --[[ cleanupVisualGnome | Line: 342 | Upvalues: t2 (copy), v10 (ref), t3 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	if v10 == v1 then
		v10 = nil
	end

	if v1.AttributeConn then
		v1.AttributeConn:Disconnect()
	end

	if v1.RangeIndicator then
		v1.RangeIndicator:Destroy()
	end

	if v1.Billboard then
		v1.Billboard:Destroy()
	end

	for v2, v3 in v1.Tracks do
		v3:Stop(0)
		v3:Destroy()
	end

	if not v1.Model then
		t3[p1] = nil
		t2[p1] = nil

		return
	end

	v1.Model:Destroy()
	t3[p1] = nil
	t2[p1] = nil
end

function t.Init(p1) --[[ Init | Line: 380 ]] end
function t.Start(p1) --[[ Start | Line: 383 | Upvalues: UserInputService (copy), LocalPlayer (copy) ]]
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 384 | Upvalues: p1 (copy) ]]
		p1:OnInput(p12, p2)
	end)
	UserInputService.TouchTapInWorld:Connect(function(p12, p2) --[[ Line: 391 | Upvalues: p1 (copy) ]]
		if p2 then
			return
		end

		local v1 = p1:GetEquippedTool()

		if v1 and v1:GetAttribute("Gnome") then
			p1:TryPlace(p12)
		end
	end)

	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 404 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	p1:StartGnomeVisuals()
end
function t.StartGnomeVisuals(p1) --[[ StartGnomeVisuals | Line: 411 | Upvalues: Gnomes (copy), setupVisualGnome (copy), cleanupVisualGnome (copy), RunService (copy), t2 (copy), t3 (copy), updateHoverDetection (copy) ]]
	for v1, v2 in Gnomes:GetChildren() do
		if v2:IsA("BasePart") then
			setupVisualGnome(v2)
		end
	end

	Gnomes.ChildAdded:Connect(function(p1) --[[ Line: 418 | Upvalues: setupVisualGnome (ref) ]]
		if not p1:IsA("BasePart") then
			return
		end

		setupVisualGnome(p1)
	end)
	Gnomes.ChildRemoved:Connect(function(p1) --[[ Line: 424 | Upvalues: cleanupVisualGnome (ref) ]]
		if not p1:IsA("BasePart") then
			return
		end

		cleanupVisualGnome(p1)
	end)
	RunService.RenderStepped:Connect(function(p1) --[[ Line: 431 | Upvalues: t2 (ref), cleanupVisualGnome (ref), t3 (ref), updateHoverDetection (ref) ]]
		debug.profilebegin("Controllers/GnomeController/RenderStepped")

		local v1 = math.min(1, 15 * p1)

		for v3, v4 in t2 do
			local v2

			if v3 and v3.Parent then
				local Model = v4.Model

				if Model and Model.PrimaryPart then
					local v6 = (t3[v3] or v3.Position) + Vector3.new(0, 0, 0)
					local Position = v4.CurrentCF.Position
					local v7 = Position:Lerp(v6, v1)
					local v8 = v6.X - Position.X
					local v9 = v6.Z - Position.Z

					if v8 * v8 + v9 * v9 > 0.01 and (v4.CurrentState == "wandering" or v4.CurrentState == "chasing") then
						v2 = CFrame.lookAt(v7, v7 + Vector3.new(v8, 0, v9))
					else
						local _, v12, _2 = v4.CurrentCF:ToEulerAnglesYXZ()

						v2 = CFrame.new(v7) * CFrame.Angles(0, v12, 0)
					end

					v4.CurrentCF = v2
					Model.PrimaryPart.CFrame = v2

					if v4.RangeIndicator and v4.IsHovered then
						local v13 = t3[v3] or v3.Position

						v4.RangeIndicator.CFrame = CFrame.new(v13.X, v13.Y - v3.Size.Y / 2 + 0.1, v13.Z)
					end

					if v4.Billboard then
						local v14 = v3:GetAttribute("PlacedAt")
						local v15 = v3:GetAttribute("Lifetime") or 600

						if v14 then
							local v18 = math.max(0, (math.ceil(v15 - (workspace:GetServerTimeNow() - v14))))
							local v19 = math.floor(v18 / 60)
							local v20 = v18 % 60
							local TextLabel = v4.Billboard:FindFirstChild("TextLabel")

							if TextLabel then
								TextLabel.Text = string.format("%d:%02d", v19, v20)

								local TextLabel2 = TextLabel:FindFirstChild("TextLabel")

								if TextLabel2 then
									TextLabel2.Text = string.format("%d:%02d", v19, v20)
								end
							end
						end
					end
				end

				continue
			end

			cleanupVisualGnome(v3)
		end

		updateHoverDetection()
		debug.profileend()
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 505 ]]
	p2.ChildAdded:Connect(function(p12) --[[ Line: 506 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("Gnome")) then
			return
		end

		p1:CreatePreview()
	end)
	p2.ChildRemoved:Connect(function(p12) --[[ Line: 512 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("Gnome")) then
			return
		end

		p1:DestroyPreview()
	end)

	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("Gnome") then
			p1:CreatePreview()
		end
	end
end
function t.CreatePreview(p1) --[[ CreatePreview | Line: 525 | Upvalues: v5 (ref), Gnome (copy), Assets (copy), v6 (ref), v8 (ref), TweenService (copy), v2 (copy), v9 (ref), Temporary (copy), v7 (ref), RunService (copy) ]]
	p1:DestroyPreview()
	v5 = Gnome:Clone()
	v5.Name = "GnomePreview"

	local v1 = Assets.SprinklerRadius:Clone()

	v1.Size = Vector3.new(50, 0.5, 50)
	v1.Anchored = true
	v1.CanCollide = false
	v1.CanQuery = false
	v1.CanTouch = false
	v1.Parent = v5
	v6 = v1

	local SurfaceGui = v1:FindFirstChild("SurfaceGui")

	if SurfaceGui then
		local PrimaryCircle = SurfaceGui:FindFirstChild("PrimaryCircle")

		if PrimaryCircle and PrimaryCircle:IsA("ImageLabel") then
			v8 = TweenService:Create(PrimaryCircle, v2, {
				ImageTransparency = 0.5
			})
			v9 = task.spawn(function() --[[ Line: 550 | Upvalues: v6 (ref), PrimaryCircle (copy), SurfaceGui (copy), TweenService (ref) ]]
				while v6 do
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

					TweenService:Create(UIScale, v2, {
						Scale = 1
					}):Play()

					local v3 = TweenService:Create(v1, v2, {
						ImageTransparency = 0
					})

					v3:Play()
					v3.Completed:Once(function() --[[ Line: 568 | Upvalues: TweenService (ref), v1 (copy) ]]
						local v12 = TweenService:Create(v1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							ImageTransparency = 1
						})

						v12:Play()
						v12.Completed:Once(function() --[[ Line: 572 | Upvalues: v1 (ref) ]]
							v1:Destroy()
						end)
					end)
					task.wait(1.1)
				end
			end)
		end
	end

	for v22, v3 in v5:GetDescendants() do
		if v3:IsA("BasePart") then
			if v3.Transparency == 0 then
				v3.Transparency = 0.5
			end

			v3.CanCollide = false
			v3.CanQuery = false
			v3.CanTouch = false
			v3.Anchored = true

			continue
		end

		if v3:IsA("ParticleEmitter") then
			v3.Enabled = false
		end
	end

	v5.Parent = Temporary
	v7 = RunService.RenderStepped:Connect(function() --[[ Line: 598 | Upvalues: p1 (copy) ]]
		debug.profilebegin("Controllers/GnomeController/PreviewUpdate")
		p1:UpdatePreview()
		debug.profileend()
	end)
end
function t.DestroyPreview(p1) --[[ DestroyPreview | Line: 605 | Upvalues: v9 (ref), v8 (ref), v5 (ref), v6 (ref), v7 (ref) ]]
	if v9 then
		task.cancel(v9)
		v9 = nil
	end

	if v8 then
		v8:Cancel()
		v8 = nil
	end

	if v5 then
		v5:Destroy()
		v5 = nil
	end

	v6 = nil

	if not v7 then
		return
	end

	v7:Disconnect()
	v7 = nil
end
function t.SetPreviewColor(p1, p2) --[[ SetPreviewColor | Line: 629 | Upvalues: v5 (ref) ]]
	if not v5 then
		return
	end

	for v1, v2 in v5:GetDescendants() do
		if v2:IsA("BasePart") then
			v2.Color = p2
		end
	end
end
function t.IsUsingGamepad(p1) --[[ IsUsingGamepad | Line: 639 | Upvalues: UserInputService (copy) ]]
	local v1 = UserInputService:GetLastInputType()

	return if v1 == Enum.UserInputType.Gamepad1 or (v1 == Enum.UserInputType.Gamepad2 or v1 == Enum.UserInputType.Gamepad3) then true else v1 == Enum.UserInputType.Gamepad4
end
function t.GetGamepadPlacementRay(p1) --[[ GetGamepadPlacementRay | Line: 647 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		return HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 8 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0)
	end

	return nil
end
function t.CreateRaycastParams(p1) --[[ CreateRaycastParams | Line: 662 | Upvalues: LocalPlayer (copy), Temporary (copy), GnomeVisuals (copy) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Exclude

	local Character = LocalPlayer.Character
	local t = { Temporary, GnomeVisuals }

	if Character then
		table.insert(t, Character)
	end

	v1.FilterDescendantsInstances = t

	return v1
end

local v11 = nil

local function getLocalGarden() --[[ getLocalGarden | Line: 679 | Upvalues: v11 (ref), LocalPlayer (copy) ]]
	if v11 and v11.Parent then
		return v11
	end

	v11 = nil

	for v1, v2 in workspace.Gardens:GetChildren() do
		if v2:GetAttribute("Owner") == LocalPlayer.Name then
			v11 = v2

			break
		end
	end

	return v11
end

local function getGardenAreaPart(p1) --[[ getGardenAreaPart | Line: 693 | Upvalues: CollectionService (copy) ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") and CollectionService:HasTag(v2, "GardenTotalArea") then
			return v2
		end
	end

	return nil
end

function t.IsValidPlacement(p1, p2) --[[ IsValidPlacement | Line: 702 | Upvalues: getLocalGarden (copy), getGardenAreaPart (copy) ]]
	local v1 = getLocalGarden()

	if not v1 then
		return false
	end

	local v2 = getGardenAreaPart(v1)

	if not v2 then
		return false
	end

	local v3 = RaycastParams.new()

	v3.FilterType = Enum.RaycastFilterType.Include
	v3.FilterDescendantsInstances = { v2 }

	return workspace:Raycast(p2 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0), v3) ~= nil
end
function t.UpdatePreview(p1) --[[ UpdatePreview | Line: 720 | Upvalues: v5 (ref), raycastSkipTransparent (copy), UserInputService (copy), CurrentCamera (copy), Temporary (copy), getLocalGarden (copy), v11 (ref), v6 (ref), v3 (copy), v4 (copy) ]]
	if not v5 then
		return
	end

	local v1 = p1:CreateRaycastParams()
	local v2

	if p1:IsUsingGamepad() then
		local v32, v42 = p1:GetGamepadPlacementRay()

		if not v32 then
			v5.Parent = nil

			return
		end

		v2 = raycastSkipTransparent(v32, v42, v1)
	else
		local v62 = UserInputService:GetMouseLocation()
		local v7 = CurrentCamera:ViewportPointToRay(v62.X, v62.Y)

		v2 = raycastSkipTransparent(v7.Origin, v7.Direction * 5000, v1)
	end

	if not v2 then
		v5.Parent = nil

		return
	end

	v5.Parent = Temporary

	local Position = v2.Position
	local v9 = Position + Vector3.new(0, 1.5, 0)

	getLocalGarden()

	local v10 = CFrame.Angles(0, 0, 0)

	if v11 and v11:FindFirstChild("SpawnPoint") then
		v10 = (v11.SpawnPoint.CFrame - v11.SpawnPoint.CFrame.Position) * CFrame.Angles(0, math.pi, 0)
	end

	if v5.PrimaryPart then
		v5:PivotTo(CFrame.new(v9) * v10)
	end

	if v6 then
		v6.CFrame = CFrame.new(Position) * v10
	end

	if p1:IsValidPlacement(Position) then
		p1:SetPreviewColor(v3)
	else
		p1:SetPreviewColor(v4)
	end
end
function t.GetEquippedTool(p1) --[[ GetEquippedTool | Line: 779 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if Character then
		return Character:FindFirstChildWhichIsA("Tool")
	end

	return nil
end
function t.OnInput(p1, p2, p3) --[[ OnInput | Line: 788 ]]
	if p3 then
		return
	end

	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true else p2.KeyCode == Enum.KeyCode.ButtonR2 then
		p1:TryPlace()
	end
end
function t.TryPlace(p1, p2) --[[ TryPlace | Line: 802 | Upvalues: v1 (ref), raycastSkipTransparent (copy), UserInputService (copy), CurrentCamera (copy), v11 (ref), Networking (copy), LocalPlayer (copy), SoundService (copy) ]]
	local v12 = os.clock()

	if v12 - v1 < 0.5 then
		return false
	end

	local v2 = p1:GetEquippedTool()

	if not v2 then
		return false
	end

	local v3 = v2:GetAttribute("Gnome")

	if not v3 then
		return false
	end

	local v4 = p1:CreateRaycastParams()
	local v5

	if p1:IsUsingGamepad() then
		local v6, v7 = p1:GetGamepadPlacementRay()

		if not v6 then
			return false
		end

		v5 = raycastSkipTransparent(v6, v7, v4)
	else
		local v9 = if p2 then p2 else UserInputService:GetMouseLocation()
		local v10 = CurrentCamera:ViewportPointToRay(v9.X, v9.Y)

		v5 = raycastSkipTransparent(v10.Origin, v10.Direction * 5000, v4)
	end

	if not v5 then
		return false
	end

	if not p1:IsValidPlacement(v5.Position) then
		return false
	end

	v1 = v12

	local v122

	if v11 and v11:FindFirstChild("SpawnPoint") then
		local _, v13, _2 = v11.SpawnPoint.CFrame:ToEulerAnglesYXZ()

		v122 = math.deg(v13) + 180
	else
		v122 = 0
	end

	Networking.Place.PlaceGnome:Fire(v5.Position, v3, v2, v122)

	local Character = LocalPlayer.Character
	local v14 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not v14 then
		return true
	end

	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://135948019584556"
	Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	Sound.Parent = v14
	Sound:Play()
	game.Debris:AddItem(Sound, 3)

	return true
end

return t