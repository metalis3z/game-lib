--credit to quartz games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Gardens = workspace:WaitForChild("Gardens")
local v1 = 0
local v2 = false
local v3 = 0
local t2 = {}
local Assets = ReplicatedStorage.Assets
local Dirt = Assets.Dirt
local Seeds = Assets.Seeds
local PlantSFX = game.SoundService.SFX.PlantSFX
local Temporary = workspace.Temporary
local v4 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v5 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v6 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v7 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v8 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local v9 = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v10 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v11 = TweenInfo.new(0.12, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
local v12 = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v13 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local t3 = {
	Color3.fromRGB(101, 67, 33),
	Color3.fromRGB(92, 60, 28),
	Color3.fromRGB(110, 75, 40),
	Color3.fromRGB(85, 55, 25)
}

function t.Init(p1) --[[ Init | Line: 55 ]] end
function t.Start(p1) --[[ Start | Line: 58 | Upvalues: UserInputService (copy), CurrentCamera (copy), Networking (copy), LocalPlayer (copy) ]]
	UserInputService.InputEnded:Connect(function(p12, p2) --[[ Line: 59 | Upvalues: p1 (copy) ]]
		p1:OnInputEnded(p12)
	end)
	UserInputService.TouchTapInWorld:Connect(function(p12, p2) --[[ Line: 66 | Upvalues: p1 (copy), CurrentCamera (ref) ]]
		if p2 then
			return
		end

		if not p1:IsTouchInput() then
			return
		end

		local v1 = p1:GetEquippedTool()

		if v1 and v1:GetAttribute("SeedTool") ~= nil then
			p1:TryPlantWithRay((CurrentCamera:ViewportPointToRay(p12.X, p12.Y)))
		end
	end)
	Networking.Plant.PlantFx.OnClientEvent:Connect(function(p12, p2) --[[ Line: 77 | Upvalues: p1 (copy) ]]
		p1:PlayPlantFx(p12, p2)
	end)
	p1:WatchBackpack()

	if LocalPlayer.Character then
		p1:WatchCharacter(LocalPlayer.Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 85 | Upvalues: p1 (copy) ]]
		p1:WatchCharacter(p12)
	end)
end
function t.IsTouchInput(p1) --[[ IsTouchInput | Line: 90 | Upvalues: UserInputService (copy) ]]
	return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end
function t.WatchBackpack(p1) --[[ WatchBackpack | Line: 94 | Upvalues: LocalPlayer (copy) ]]
	local function hook(p12) --[[ hook | Line: 95 | Upvalues: p1 (copy) ]]
		for v1, v2 in p12:GetChildren() do
			if v2:IsA("Tool") then
				p1:TrySetupSeedTool(v2)
			end
		end

		p12.ChildAdded:Connect(function(p12) --[[ Line: 101 | Upvalues: p1 (ref) ]]
			if not p12:IsA("Tool") then
				return
			end

			p1:TrySetupSeedTool(p12)
		end)
	end

	local Backpack = LocalPlayer:FindFirstChildOfClass("Backpack")

	if Backpack then
		hook(Backpack)
	end

	LocalPlayer.ChildAdded:Connect(function(p1) --[[ Line: 110 | Upvalues: hook (copy) ]]
		if not p1:IsA("Backpack") then
			return
		end

		hook(p1)
	end)
end
function t.WatchCharacter(p1, p2) --[[ WatchCharacter | Line: 117 ]]
	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Tool") then
			p1:TrySetupSeedTool(v2)
		end
	end

	p2.ChildAdded:Connect(function(p12) --[[ Line: 123 | Upvalues: p1 (copy) ]]
		if not p12:IsA("Tool") then
			return
		end

		p1:TrySetupSeedTool(p12)
	end)
end
function t.TrySetupSeedTool(p1, p2) --[[ TrySetupSeedTool | Line: 130 | Upvalues: t2 (copy) ]]
	if not t2[p2] then
		p1:SetupSeedTool(p2)
	end
end
function t.SetupSeedTool(p1, p2) --[[ SetupSeedTool | Line: 135 | Upvalues: t2 (copy), v2 (ref) ]]
	if not t2[p2] then
		local t = {}

		table.insert(t, p2.Activated:Connect(function() --[[ Line: 140 | Upvalues: p2 (copy), p1 (copy) ]]
			if p2:GetAttribute("SeedTool") ~= nil then
				p1:OnPlantTriggered()
			end
		end))

		local function f1() --[[ Line: 145 | Upvalues: v2 (ref) ]]
			v2 = false
		end

		table.insert(t, p2.Deactivated:Connect(f1))
		table.insert(t, p2.AncestryChanged:Connect(function() --[[ Line: 149 | Upvalues: p2 (copy), p1 (copy) ]]
			if p2:IsDescendantOf(game) then
				return
			end

			p1:CleanupSeedTool(p2)
		end))
		table.insert(t, p2.Destroying:Connect(function() --[[ Line: 155 | Upvalues: p1 (copy), p2 (copy) ]]
			p1:CleanupSeedTool(p2)
		end))
		t2[p2] = t
	end
end
function t.CleanupSeedTool(p1, p2) --[[ CleanupSeedTool | Line: 162 | Upvalues: t2 (copy) ]]
	local v1 = t2[p2]

	if not v1 then
		return
	end

	for v2, v3 in v1 do
		v3:Disconnect()
	end

	t2[p2] = nil
end
function t.GetPlayerPlot(p1) --[[ GetPlayerPlot | Line: 169 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")

	if v1 then
		return Gardens:FindFirstChild("Plot" .. v1)
	end

	return nil
end
function t.GetEquippedTool(p1) --[[ GetEquippedTool | Line: 175 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if Character then
		return Character:FindFirstChildWhichIsA("Tool")
	end

	return nil
end
function t.CreatePlantAreaParams(p1) --[[ CreatePlantAreaParams | Line: 181 | Upvalues: CollectionService (copy) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Include
	v1.FilterDescendantsInstances = CollectionService:GetTagged("PlantArea")

	return v1
end
function t.CreatePlantsParams(p1) --[[ CreatePlantsParams | Line: 188 ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Include

	local t = {}

	for v2, v3 in workspace.Gardens:GetChildren() do
		local Plants = v3:FindFirstChild("Plants")

		if Plants then
			table.insert(t, Plants)
		end
	end

	v1.FilterDescendantsInstances = t

	return v1
end
function t.TryPlantWithRay(p1, p2) --[[ TryPlantWithRay | Line: 202 | Upvalues: v1 (ref), Networking (copy) ]]
	local v12 = os.clock()

	if v12 - v1 < 0.05 then
		return false
	end

	local v2 = p1:GetEquippedTool()

	if not v2 then
		return false
	end

	local v3 = v2:GetAttribute("SeedTool")

	if not v3 then
		return false
	end

	local v4 = p1:GetPlayerPlot()

	if not v4 then
		return false
	end

	local v5 = p1:CreatePlantAreaParams()
	local v6 = nil

	for i = 1, 5 do
		local v7 = workspace:Raycast(p2.Origin, p2.Direction * 5000, v5)

		v6 = v7

		if v7 then
			local v8 = v7.Instance

			if v8.Transparency < 1 then
				v6 = v7

				break
			end

			local FilterDescendantsInstances = v5.FilterDescendantsInstances
			local v9 = table.find(FilterDescendantsInstances, v8)

			if v9 then
				table.remove(FilterDescendantsInstances, v9)
				v5.FilterDescendantsInstances = FilterDescendantsInstances
			else
				break
			end
		else
			break
		end
	end

	if not v6 then
		return false
	end

	if not v6.Instance:IsDescendantOf(v4) then
		return false
	end

	local v10 = workspace:Raycast(p2.Origin, p2.Direction * 5000, p1:CreatePlantsParams())

	if v10 then
		local Position = v6.Position
		local Position2 = v10.Position

		if (Vector2.new(Position2.X, Position2.Z) - Vector2.new(Position.X, Position.Z)).Magnitude < 1 then
			return false
		end
	end

	v1 = v12
	Networking.Plant.PlantSeed:Fire(v6.Position, v3, v2)

	return true
end
function t.OnPlantTriggered(p1) --[[ OnPlantTriggered | Line: 247 | Upvalues: v2 (ref), UserInputService (copy), CurrentCamera (copy), v3 (ref) ]]
	if p1:IsTouchInput() then
		return
	end

	if not v2 then
		local v1 = UserInputService:GetMouseLocation()

		p1:TryPlantWithRay((CurrentCamera:ViewportPointToRay(v1.X, v1.Y)))
		v2 = true
		v3 = os.clock()
		task.spawn(function() --[[ Line: 260 | Upvalues: v2 (ref), v3 (ref), UserInputService (ref), CurrentCamera (ref), p1 (copy) ]]
			while v2 and os.clock() - v3 < 1 do
				task.wait(0.05)
			end

			while v2 do
				local v1 = UserInputService:GetMouseLocation()

				p1:TryPlantWithRay((CurrentCamera:ViewportPointToRay(v1.X, v1.Y)))
				task.wait(0.4)
			end
		end)
	end
end
function t.OnInputEnded(p1, p2) --[[ OnInputEnded | Line: 275 | Upvalues: v2 (ref) ]]
	if p2.UserInputType ~= Enum.UserInputType.MouseButton1 and (p2.UserInputType ~= Enum.UserInputType.Touch and p2.KeyCode ~= Enum.KeyCode.ButtonR2) then
		return
	end

	v2 = false
end
function t.SetPartsTransparency(p1, p2, p3) --[[ SetPartsTransparency | Line: 283 ]]
	if p2:IsA("BasePart") then
		p2.Transparency = p3
	end

	for v1, v2 in p2:GetDescendants() do
		if v2:IsA("BasePart") then
			v2.Transparency = p3
		end
	end
end
function t.CreateDirtChunk(p1, p2) --[[ CreateDirtChunk | Line: 295 | Upvalues: t3 (copy), Temporary (copy), TweenService (copy), v10 (copy), v11 (copy), v12 (copy), v13 (copy), Debris (copy) ]]
	local Part = Instance.new("Part")
	local v1 = math.random(25, 45) / 100

	Part.Size = Vector3.new(v1, v1 * 0.7, v1)
	Part.Color = t3[math.random(1, #t3)]
	Part.Material = Enum.Material.SmoothPlastic
	Part.Anchored = true
	Part.CanCollide = false
	Part.CastShadow = false
	Part.Transparency = 0
	Part.Position = p2 + Vector3.new(0, 0.05, 0)
	Part.Orientation = Vector3.new(math.random(-30, 30), math.random(-180, 180), math.random(-30, 30))
	Part.Parent = Temporary

	local v5 = math.rad((math.random(0, 360)))
	local v6 = math.random(30, 60) / 100
	local v7 = math.cos(v5) * v6
	local v8 = math.sin(v5) * v6
	local v102 = p2 + Vector3.new(v7 * 0.6, math.random(50, 90) / 100, v8 * 0.6)
	local v112 = p2 + Vector3.new(v7, 0.02, v8)
	local v122 = v112 + Vector3.new(0, -0.01, 0)
	local v132 = TweenService
	local t = {
		Position = v102
	}

	t.Orientation = Part.Orientation + Vector3.new(math.random(-45, 45), math.random(-90, 90), math.random(-45, 45))

	local v17 = v132:Create(Part, v10, t)

	v17:Play()
	v17.Completed:Connect(function() --[[ Line: 326 | Upvalues: TweenService (ref), Part (copy), v11 (ref), v112 (copy), v1 (copy), v12 (ref), v122 (copy), v13 (ref), Debris (ref) ]]
		local v14 = TweenService
		local v2 = Part
		local t = {
			Position = v112
		}
		local v4 = v1 * 1.1
		local v5 = v1 * 0.5
		local v6 = v1 * 1.1

		t.Size = Vector3.new(v4, v5, v6)

		local v7 = v14:Create(v2, v11, t)

		v7:Play()
		v7.Completed:Connect(function() --[[ Line: 333 | Upvalues: TweenService (ref), Part (ref), v12 (ref), v122 (ref), v1 (ref), v13 (ref), Debris (ref) ]]
			local v14 = TweenService
			local v2 = Part
			local t = {
				Position = v122
			}

			t.Size = Vector3.new(v1, v1 * 0.65, v1)

			local v7 = v14:Create(v2, v12, t)

			v7:Play()
			v7.Completed:Connect(function() --[[ Line: 340 | Upvalues: TweenService (ref), Part (ref), v13 (ref), Debris (ref) ]]
				task.delay(0.15, function() --[[ Line: 341 | Upvalues: TweenService (ref), Part (ref), v13 (ref), Debris (ref) ]]
					TweenService:Create(Part, v13, {
						Transparency = 1
					}):Play()
					Debris:AddItem(Part, v13.Time)
				end)
			end)
		end)
	end)
end
function t.PlaySfx(p1) --[[ PlaySfx | Line: 351 | Upvalues: PlantSFX (copy), Temporary (copy) ]]
	local v1 = PlantSFX:Clone()

	v1.PlaybackSpeed = 1 + math.random(-10, 10) / 100
	v1.Parent = Temporary
	v1:Play()
	v1.Ended:Connect(function() --[[ Line: 356 | Upvalues: v1 (copy) ]]
		v1:Destroy()
	end)
end
function t.SpawnDirtChunks(p1, p2) --[[ SpawnDirtChunks | Line: 361 ]]
	for i = 1, math.random(6, 10) do
		task.delay(i * 0.015, function() --[[ Line: 364 | Upvalues: p1 (copy), p2 (copy) ]]
			p1:CreateDirtChunk(p2)
		end)
	end
end
function t.CreateDirtDecal(p1, p2) --[[ CreateDirtDecal | Line: 370 | Upvalues: Dirt (copy), Temporary (copy), TweenService (copy), v4 (copy), v5 (copy), Debris (copy) ]]
	local v1 = Dirt:Clone()

	v1.Position = p2 - Vector3.new(0, 0.01, 0)

	local v2 = math.random(-180, 180)

	v1.Orientation = Vector3.new(Dirt.Orientation.X, v2, Dirt.Orientation.Z)
	v1.Size = Vector3.new(0.1, 0.8, 0.8)
	v1.Transparency = 1
	v1.Parent = Temporary
	TweenService:Create(v1, v4, {
		Size = Vector3.new(0.1, 2, 2),
		Transparency = 0
	}):Play()
	task.delay(math.random(7, 11), function() --[[ Line: 381 | Upvalues: TweenService (ref), v1 (copy), v5 (ref), Debris (ref) ]]
		TweenService:Create(v1, v5, {
			Size = Vector3.new(0.1, 1.75, 1.75),
			Transparency = 1
		}):Play()
		Debris:AddItem(v1, v5.Time)
	end)
end
function t.CreateImpactRing(p1, p2) --[[ CreateImpactRing | Line: 388 | Upvalues: Temporary (copy), TweenService (copy), Debris (copy) ]]
	local Part = Instance.new("Part")

	Part.Shape = Enum.PartType.Cylinder
	Part.Size = Vector3.new(0.05, 0.3, 0.3)
	Part.Color = Color3.fromRGB(139, 90, 43)
	Part.Material = Enum.Material.SmoothPlastic
	Part.Anchored = true
	Part.CanCollide = false
	Part.CastShadow = false
	Part.Transparency = 0.3
	Part.Position = p2 + Vector3.new(0, 0.02, 0)
	Part.Orientation = Vector3.new(0, 0, 90)
	Part.Parent = Temporary
	TweenService:Create(Part, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = Vector3.new(0.05, 1.8, 1.8),
		Transparency = 1
	}):Play()
	Debris:AddItem(Part, 0.35)
end
function t.PlayPlantFx(p1, p2, p3) --[[ PlayPlantFx | Line: 411 | Upvalues: Seeds (copy), Temporary (copy), v6 (copy), TweenService (copy), v7 (copy), v8 (copy), v9 (copy), Debris (copy) ]]
	local v1 = Seeds:FindFirstChild(p3)

	if not v1 then
		p1:PlaySfx()
		p1:SpawnDirtChunks(p2)
		p1:CreateDirtDecal(p2)
		p1:CreateImpactRing(p2)

		return
	end

	local v2 = v1:Clone()
	local v3 = if v2:IsA("BasePart") then v2 else v2.PrimaryPart

	if v3 then
		v3.Anchored = true
		v3.CanCollide = false

		local Size = v3.Size
		local Orientation = v3.Orientation
		local v4 = CFrame.new(p2 + Vector3.new(0, 1.5, 0))
		local v5 = v4 * CFrame.Angles(0, math.rad(Orientation.Y), 0)
		local v62 = CFrame.new(p2 + Vector3.new(0, 2, 0))
		local v82 = v62 * CFrame.Angles(0, math.rad(Orientation.Y + 15), 0)
		local v92 = CFrame.new(p2 + Vector3.new(0, 0.15, 0))
		local v11 = v92 * CFrame.Angles(0, math.rad(Orientation.Y + 60), 0)
		local v14 = CFrame.new(p2 + Vector3.new(0, 0.15 - Size.Y * 0.15, 0))
		local v16 = v14 * CFrame.Angles(0, math.rad(Orientation.Y + 60), 0)
		local v17 = CFrame.new(p2 + Vector3.new(0, -0.1, 0))
		local v19 = v17 * CFrame.Angles(0, math.rad(Orientation.Y + 60), 0)

		v3.CFrame = v5
		p1:SetPartsTransparency(v2, 1)
		v2.Parent = Temporary
		p1:TweenAllPartsTransparency(v2, v6, 0)

		local v20 = TweenService:Create(v3, v7, {
			CFrame = v82
		})

		v20:Play()
		v20.Completed:Once(function() --[[ Line: 451 | Upvalues: TweenService (ref), v3 (copy), v8 (ref), v11 (copy), v9 (ref), v16 (copy), Size (copy), v19 (copy), p1 (copy), v2 (copy), p2 (copy), Debris (ref) ]]
			local v1 = TweenService:Create(v3, v8, {
				CFrame = v11
			})

			v1:Play()
			v1.Completed:Once(function() --[[ Line: 457 | Upvalues: TweenService (ref), v3 (ref), v9 (ref), v16 (ref), Size (ref), v19 (ref), p1 (ref), v2 (ref), p2 (ref), Debris (ref) ]]
				local v1 = TweenService
				local v22 = v3
				local t = {
					CFrame = v16
				}
				local v4 = Size.X * 1.3
				local v5 = Size.Y * 0.6
				local v6 = Size.Z * 1.3

				t.Size = Vector3.new(v4, v5, v6)

				local v7 = v1:Create(v22, v9, t)

				v7:Play()
				v7.Completed:Once(function() --[[ Line: 464 | Upvalues: TweenService (ref), v3 (ref), v19 (ref), Size (ref), p1 (ref), v2 (ref), p2 (ref), Debris (ref) ]]
					local v1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

					TweenService:Create(v3, v1, {
						CFrame = v19,
						Size = Size * 0.8
					}):Play()
					p1:TweenAllPartsTransparency(v2, v1, 1)
					p1:PlaySfx()
					p1:SpawnDirtChunks(p2)
					p1:CreateDirtDecal(p2)
					p1:CreateImpactRing(p2)
					Debris:AddItem(v2, 0.2)
				end)
			end)
		end)
	else
		v2:Destroy()
	end
end
function t.TweenAllPartsTransparency(p1, p2, p3, p4) --[[ TweenAllPartsTransparency | Line: 485 | Upvalues: TweenService (copy) ]]
	if p2:IsA("BasePart") then
		TweenService:Create(p2, p3, {
			Transparency = p4
		}):Play()
	end

	for v1, v2 in p2:GetDescendants() do
		if v2:IsA("BasePart") then
			TweenService:Create(v2, p3, {
				Transparency = p4
			}):Play()
		end
	end
end

return t