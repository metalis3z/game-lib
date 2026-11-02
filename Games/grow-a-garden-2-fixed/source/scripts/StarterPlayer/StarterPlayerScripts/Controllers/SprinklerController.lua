--credit to quartz games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

game:GetService("Debris")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Sprinklers = ReplicatedStorage.Assets.Sprinklers
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local SprinklerData = require(ReplicatedStorage.SharedModules.SprinklerData)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Gardens = workspace:WaitForChild("Gardens")
local Assets = ReplicatedStorage.Assets
local Dirt = Assets.Dirt
local Seeds = Assets.Seeds
local Temporary = workspace.Temporary
local v1 = 0

TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
TweenInfo.new(0.12, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local v2 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local _ = {
	Color3.fromRGB(101, 67, 33),
	Color3.fromRGB(92, 60, 28),
	Color3.fromRGB(110, 75, 40),
	Color3.fromRGB(85, 55, 25)
}
local v3 = Color3.fromRGB(100, 255, 100)
local v4 = Color3.fromRGB(255, 100, 100)
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local t2 = {}

function t.Init(p1) --[[ Init | Line: 69 | Upvalues: SprinklerData (copy), t2 (copy) ]]
	for v1, v2 in SprinklerData do
		t2[v2.SprinklerName] = v2
	end
end
function t.Start(p1) --[[ Start | Line: 76 | Upvalues: UserInputService (copy), LocalPlayer (copy) ]]
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 78 | Upvalues: p1 (copy) ]]
		p1:OnInput(p12, p2)
	end)
	UserInputService.TouchTapInWorld:Connect(function(p12, p2) --[[ Line: 87 | Upvalues: p1 (copy) ]]
		if p2 then
			return
		end

		local v1 = p1:GetEquippedTool()

		if v1 and v1:GetAttribute("Sprinkler") then
			p1:TryPlace(p12)
		end
	end)

	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 100 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
end
function t.IsTouchInput(p1) --[[ IsTouchInput | Line: 106 | Upvalues: UserInputService (copy) ]]
	return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 110 ]]
	p2.ChildAdded:Connect(function(p12) --[[ Line: 111 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("Sprinkler")) then
			return
		end

		p1:CreatePreview(p12:GetAttribute("Sprinkler"))
	end)
	p2.ChildRemoved:Connect(function(p12) --[[ Line: 117 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("Sprinkler")) then
			return
		end

		p1:DestroyPreview()
	end)

	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("Sprinkler") then
			p1:CreatePreview(v2:GetAttribute("Sprinkler"))
		end
	end
end
function t.CreatePreview(p1, p2) --[[ CreatePreview | Line: 130 | Upvalues: Sprinklers (copy), t2 (copy), v5 (ref), Assets (copy), v6 (ref), v8 (ref), TweenService (copy), v2 (copy), v9 (ref), Temporary (copy), v7 (ref), RunService (copy) ]]
	p1:DestroyPreview()

	if p1:IsTouchInput() then
		return
	end

	local v1 = Sprinklers:FindFirstChild(p2)
	local v22 = t2[p2]

	if not (v1 and v22) then
		return
	end

	v5 = v1:Clone()
	v5.Name = "SprinklerPreview"

	local v3 = Assets.SprinklerRadius:Clone()

	v3.Size = Vector3.new(v22.Radius, 0.5, v22.Radius)
	v3.Anchored = true
	v3.CanCollide = false
	v3.CanQuery = false
	v3.CanTouch = false
	v3.Parent = v5
	v6 = v3

	local SurfaceGui = v3:FindFirstChild("SurfaceGui")

	if SurfaceGui then
		local PrimaryCircle = SurfaceGui:FindFirstChild("PrimaryCircle")

		if PrimaryCircle and PrimaryCircle:IsA("ImageLabel") then
			v8 = TweenService:Create(PrimaryCircle, v2, {
				ImageTransparency = 0.5
			})
			v9 = task.spawn(function() --[[ Line: 165 | Upvalues: v6 (ref), PrimaryCircle (copy), SurfaceGui (copy), TweenService (ref) ]]
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
					v3.Completed:Once(function() --[[ Line: 184 | Upvalues: TweenService (ref), v1 (copy) ]]
						local v12 = TweenService:Create(v1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							ImageTransparency = 1
						})

						v12:Play()
						v12.Completed:Once(function() --[[ Line: 188 | Upvalues: v1 (ref) ]]
							v1:Destroy()
						end)
					end)
					task.wait(1.1)
				end
			end)
		end
	end

	for v4, v52 in v5:GetDescendants() do
		if v52:IsA("BasePart") then
			if v52.Transparency == 0 then
				v52.Transparency = 0.5
			end

			v52.CanCollide = false
			v52.CanQuery = false
			v52.CanTouch = false
			v52.Anchored = true

			continue
		end

		if v52:IsA("ParticleEmitter") then
			v52.Enabled = false
		end
	end

	v5.Parent = Temporary
	v7 = RunService.RenderStepped:Connect(function() --[[ Line: 214 | Upvalues: p1 (copy) ]]
		p1:UpdatePreview()
	end)
end
function t.DestroyPreview(p1) --[[ DestroyPreview | Line: 219 | Upvalues: v9 (ref), v8 (ref), v5 (ref), v6 (ref), v7 (ref) ]]
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
function t.SetPreviewColor(p1, p2) --[[ SetPreviewColor | Line: 243 | Upvalues: v5 (ref), v3 (copy), v4 (copy) ]]
	if not v5 then
		return
	end

	local v1 = p2 and v3 or v4

	for v2, v32 in v5:GetDescendants() do
		if v32:IsA("BasePart") then
			v32.Color = v1
		end
	end
end
function t.IsUsingGamepad(p1) --[[ IsUsingGamepad | Line: 255 | Upvalues: UserInputService (copy) ]]
	local v1 = UserInputService:GetLastInputType()

	return if v1 == Enum.UserInputType.Gamepad1 or (v1 == Enum.UserInputType.Gamepad2 or v1 == Enum.UserInputType.Gamepad3) then true else v1 == Enum.UserInputType.Gamepad4
end
function t.GetGamepadPlacementRay(p1) --[[ GetGamepadPlacementRay | Line: 263 | Upvalues: LocalPlayer (copy) ]]
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
function t.CreatePreviewRaycastParams(p1) --[[ CreatePreviewRaycastParams | Line: 278 | Upvalues: LocalPlayer (copy), Temporary (copy) ]]
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
function t.IsTooCloseToSprinkler(p1, p2, p3) --[[ IsTooCloseToSprinkler | Line: 291 | Upvalues: v5 (ref), t2 (copy) ]]
	if not p2 then
		return false
	end

	for v1, v2 in p2:GetDescendants() do
		if v2:IsA("Model") and (v2 ~= v5 and (t2[v2.Name] and (v2.PrimaryPart and (v2.PrimaryPart.Position - p3).Magnitude < 1))) then
			return true
		end
	end

	return false
end
function t.UpdatePreview(p1) --[[ UpdatePreview | Line: 306 | Upvalues: v5 (ref), UserInputService (copy), CurrentCamera (copy), CollectionService (copy), Temporary (copy), v6 (ref) ]]
	if not v5 then
		return
	end

	local v1 = p1:CreateRaycastParams()
	local v2

	if p1:IsUsingGamepad() then
		local v3, v4 = p1:GetGamepadPlacementRay()

		if not v3 then
			v5.Parent = nil

			return
		end

		v2 = workspace:Raycast(v3, v4, v1)
	else
		local v62 = UserInputService:GetMouseLocation()
		local v7 = CurrentCamera:ViewportPointToRay(v62.X, v62.Y)

		v2 = workspace:Raycast(v7.Origin, v7.Direction * 5000, v1)
	end

	if v2 then
		local v9 = v2.Instance
		local v10 = p1:GetPlotFromPart(v9)
		local v11 = if v10 then CollectionService:HasTag(v9, "PlantArea") and (v9:IsDescendantOf(v10) and (if v10:GetAttribute("Owner") == nil then false else not p1:IsTooCloseToSprinkler(v10, v2.Position))) else v10

		v5.Parent = Temporary

		local Position = v2.Position
		local v12 = Vector3.new(Position.X, 142.602, Position.Z)

		if v5.PrimaryPart then
			v5:PivotTo(CFrame.new(v12))
		end

		if not v6 then
			p1:SetPreviewColor(v11)

			return
		end

		v6.CFrame = CFrame.new(v12)
		p1:SetPreviewColor(v11)
	else
		local v13 = p1:CreatePreviewRaycastParams()
		local v14

		if p1:IsUsingGamepad() then
			local v15, v16 = p1:GetGamepadPlacementRay()

			if not v15 then
				v5.Parent = nil

				return
			end

			v14 = workspace:Raycast(v15, v16, v13)
		else
			local v18 = UserInputService:GetMouseLocation()
			local v19 = CurrentCamera:ViewportPointToRay(v18.X, v18.Y)

			v14 = workspace:Raycast(v19.Origin, v19.Direction * 5000, v13)
		end

		if not v14 then
			v5.Parent = nil

			return
		end

		v5.Parent = Temporary

		local Position = v14.Position
		local v21 = Vector3.new(Position.X, 142.602, Position.Z)

		if v5.PrimaryPart then
			v5:PivotTo(CFrame.new(v21))
		end

		if not v6 then
			p1:SetPreviewColor(false)

			return
		end

		v6.CFrame = CFrame.new(v21)
		p1:SetPreviewColor(false)
	end
end
function t.GetPlayerPlot(p1) --[[ GetPlayerPlot | Line: 387 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")

	if v1 then
		return Gardens:FindFirstChild("Plot" .. v1)
	end

	return nil
end
function t.GetPlotFromPart(p1, p2) --[[ GetPlotFromPart | Line: 393 | Upvalues: Gardens (copy) ]]
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
function t.GetPlotId(p1, p2) --[[ GetPlotId | Line: 405 ]]
	return tonumber(string.match(p2.Name, "%d+"))
end
function t.GetEquippedTool(p1) --[[ GetEquippedTool | Line: 411 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if Character then
		return Character:FindFirstChildWhichIsA("Tool")
	end

	return nil
end
function t.CreateRaycastParams(p1) --[[ CreateRaycastParams | Line: 417 ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Include
	v1.FilterDescendantsInstances = workspace.Gardens:QueryDescendants("BasePart.PlantArea")

	return v1
end
function t.OnInput(p1, p2, p3) --[[ OnInput | Line: 427 ]]
	if p3 then
		return
	end

	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true else p2.KeyCode == Enum.KeyCode.ButtonR2 then
		p1:TryPlace()
	end
end
function t.TryPlace(p1, p2) --[[ TryPlace | Line: 441 | Upvalues: v1 (ref), UserInputService (copy), CurrentCamera (copy), CollectionService (copy), Networking (copy), LocalPlayer (copy), SoundService (copy) ]]
	local v12 = os.clock()

	if v12 - v1 < 0.5 then
		return false
	end

	local v2 = p1:GetEquippedTool()

	if not v2 then
		return false
	end

	local v3 = v2:GetAttribute("Sprinkler")

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

		v5 = workspace:Raycast(v6, v7, v4)
	else
		local v9 = if p2 then p2 else UserInputService:GetMouseLocation()
		local v10 = CurrentCamera:ViewportPointToRay(v9.X, v9.Y)

		v5 = workspace:Raycast(v10.Origin, v10.Direction * 5000, v4)
	end

	if not v5 then
		return false
	end

	local v122 = v5.Instance

	if not CollectionService:HasTag(v122, "PlantArea") then
		return false
	end

	local v13 = p1:GetPlotFromPart(v122)

	if not v13 then
		return false
	end

	if not v122:IsDescendantOf(v13) then
		return false
	end

	if not v13:GetAttribute("Owner") then
		return false
	end

	local v14 = p1:GetPlotId(v13)

	if not v14 then
		return false
	end

	if p1:IsTooCloseToSprinkler(v13, v5.Position) then
		return false
	end

	v1 = v12
	Networking.Place.PlaceSprinkler:Fire(v5.Position, v3, v2, v14)

	local Character = LocalPlayer.Character
	local v15 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not v15 then
		return true
	end

	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://135948019584556"
	Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	Sound.Parent = v15
	Sound:Play()
	game.Debris:AddItem(Sound, 3)

	return true
end

return t