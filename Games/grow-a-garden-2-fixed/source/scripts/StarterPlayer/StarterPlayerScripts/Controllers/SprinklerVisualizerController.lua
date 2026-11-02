--credit to quartz games studio
local t = {
	StartOrder = 4
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GardenSyncController = require(script.Parent.GardenSyncController)
local SprinklerData = require(ReplicatedStorage.SharedModules.SprinklerData)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Gardens = workspace:WaitForChild("Gardens")
local Temporary = workspace:WaitForChild("Temporary")
local Assets = ReplicatedStorage.Assets
local Sprinklers = Assets.Sprinklers
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = 0
local v2 = nil
local v3 = nil
local v4 = nil

function t.Init(p1) --[[ Init | Line: 34 | Upvalues: SprinklerData (copy), t3 (copy) ]]
	for v1, v2 in SprinklerData do
		t3[v2.SprinklerName] = v2
	end
end
function t.Start(p1) --[[ Start | Line: 40 | Upvalues: GardenSyncController (copy), RunService (copy) ]]
	GardenSyncController:OnSprinklerAdded(function(p12, p2, p3) --[[ Line: 41 | Upvalues: p1 (copy) ]]
		p1:SpawnSprinklerFromData(p12, p2, p3)
	end)
	GardenSyncController:OnSprinklerRemoved(function(p12, p2) --[[ Line: 45 | Upvalues: p1 (copy) ]]
		p1:RemoveSprinklerById(p12, p2)
	end)
	RunService.Heartbeat:Connect(function(p12) --[[ Line: 49 | Upvalues: p1 (copy) ]]
		debug.profilebegin("Controllers/SprinklerVisualizerController/Heartbeat")
		p1:UpdateSprinklerTimers()
		p1:UpdateSprinklerSpins(p12)
		p1:UpdateHoverPreview()
		debug.profileend()
	end)
end
function t.GetPlayerPlot(p1, p2) --[[ GetPlayerPlot | Line: 58 | Upvalues: Players (copy), Gardens (copy) ]]
	local v1 = Players:GetPlayerByUserId(p2)

	if not v1 then
		return nil
	end

	local v2 = v1:GetAttribute("PlotId")

	if v2 then
		return Gardens:FindFirstChild("Plot" .. v2)
	end

	return nil
end
function t.GetSpawnPoint(p1, p2) --[[ GetSpawnPoint | Line: 68 ]]
	local v1 = p1:GetPlayerPlot(p2)

	if v1 then
		return v1:FindFirstChild("SpawnPoint")
	end

	return nil
end
function t.GetSprinklersFolder(p1, p2) --[[ GetSprinklersFolder | Line: 75 ]]
	local v1 = p1:GetPlayerPlot(p2)

	if not v1 then
		return nil
	end

	local Sprinklers = v1:FindFirstChild("Sprinklers")

	if not Sprinklers then
		local Sprinklers2 = Instance.new("Folder")

		Sprinklers2.Name = "Sprinklers"
		Sprinklers2.Parent = v1
		Sprinklers = Sprinklers2
	end

	return Sprinklers
end
function t.GetSprinklerData(p1, p2) --[[ GetSprinklerData | Line: 88 | Upvalues: t3 (copy) ]]
	return t3[p2]
end
function t.CreateSprinklerTimerUI(p1, p2) --[[ CreateSprinklerTimerUI | Line: 92 ]]
	local v1 = script.SprinklerTimerUI:Clone()

	v1.Parent = p2

	return v1
end
function t.UpdateSprinklerTimers(p1) --[[ UpdateSprinklerTimers | Line: 98 | Upvalues: t2 (copy), t4 (copy) ]]
	local v1 = os.time()

	for v2, v3 in t2 do
		if v3 and v3.Parent then
			local v4 = t4[v2]

			if v4 then
				local v7 = math.clamp(v4.Lifetime - (v1 - v4.PlacedAt), 0, v4.Lifetime)

				if v7 <= 0 then
					v3:Destroy()
					t2[v2] = nil
					t4[v2] = nil

					continue
				end

				local v8 = math.floor(v7 / 60)
				local v9 = v7 % 60
				local SprinklerTimerUI = v3:FindFirstChild("SprinklerTimerUI")

				if SprinklerTimerUI and SprinklerTimerUI:IsA("BillboardGui") then
					local TextLabel = SprinklerTimerUI:FindFirstChildOfClass("TextLabel")

					if TextLabel then
						TextLabel.Text = string.format("%d:%02d", v8, v9)
					end
				end
			end
		end
	end
end
function t.UpdateSprinklerSpins(p1, p2) --[[ UpdateSprinklerSpins | Line: 130 | Upvalues: v1 (ref), t2 (copy) ]]
	v1 = v1 + p2

	if v1 < 0.2 then
		return
	end

	v1 = 0

	local v12 = CFrame.Angles(0, 0.3141592653589793, 0)

	for v2, v3 in t2 do
		if v3 and v3.Parent then
			v3:PivotTo(v3:GetPivot() * v12)
		end
	end
end
function t.SpawnSprinklerFromData(p1, p2, p3, p4) --[[ SpawnSprinklerFromData | Line: 148 | Upvalues: t2 (copy), t4 (copy), Sprinklers (copy), SoundService (copy) ]]
	local v1 = p1:GetSpawnPoint(p2)

	if not v1 then
		return
	end

	local v2 = p1:GetSprinklersFolder(p2)

	if not v2 then
		return
	end

	local SprinklerName = p4.SprinklerName

	if not SprinklerName then
		return
	end

	local v3 = ("%*_%*"):format(p2, p3)

	if t2[v3] then
		t2[v3]:Destroy()
		t2[v3] = nil
		t4[v3] = nil
	end

	local v4 = v3
	local v6 = v1.CFrame:PointToWorldSpace((Vector3.new(p4.Positions.PosX, p4.Positions.PosY, p4.Positions.PosZ)))
	local v8 = p4.Positions.Rotation + math.deg((select(2, v1.CFrame:ToEulerAnglesYXZ())))
	local v9 = CFrame.new(v6) * CFrame.Angles(0, math.rad(v8), 0)
	local v10 = Sprinklers:FindFirstChild(SprinklerName)

	if not v10 then
		return
	end

	local v11 = v10:Clone()

	v11.Name = v4
	v11:SetAttribute("SprinklerId", p3)
	v11:SetAttribute("UserId", p2)
	v11:SetAttribute("SprinklerName", SprinklerName)
	v11.Parent = v2
	v11:PivotTo(v9)

	local v12 = p1:GetSprinklerData(SprinklerName)

	if v12 then
		if os.time() - p4.PlacedAt >= v12.Lifetime then
			v11:Destroy()

			return
		end

		t4[v4] = {
			PlacedAt = p4.PlacedAt,
			Lifetime = v12.Lifetime
		}
		p1:CreateSprinklerTimerUI(v11)
	end

	local v13 = v11.PrimaryPart or v11:FindFirstChildWhichIsA("BasePart")

	if not v13 then
		t2[v4] = v11

		return
	end

	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://76520945762958"
	Sound.Volume = 0.5
	Sound.RollOffMaxDistance = 100
	Sound.Looped = true
	Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	Sound.Parent = v13
	Sound:Play()
	t2[v4] = v11
end
function t.RemoveSprinklerById(p1, p2, p3) --[[ RemoveSprinklerById | Line: 218 | Upvalues: t2 (copy), t4 (copy) ]]
	local v1 = ("%*_%*"):format(p2, p3)
	local v2 = t2[v1]

	if not v2 then
		return
	end

	v2:Destroy()
	t2[v1] = nil
	t4[v1] = nil
end
function t.GetSprinklerFromPart(p1, p2) --[[ GetSprinklerFromPart | Line: 229 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2 do
		if v2 and (v2.Parent and p2:IsDescendantOf(v2)) then
			return v2
		end
	end

	return nil
end
function t.UpdateHoverPreview(p1) --[[ UpdateHoverPreview | Line: 238 | Upvalues: v4 (ref), UserInputService (copy), CurrentCamera (copy), Temporary (copy), LocalPlayer (copy) ]]
	if v4 and not v4.Parent then
		p1:DestroyHoverPreview()
	end

	local v1 = UserInputService:GetMouseLocation()
	local v2 = CurrentCamera:ViewportPointToRay(v1.X, v1.Y)
	local v3 = RaycastParams.new()

	v3.FilterType = Enum.RaycastFilterType.Exclude

	local t = { Temporary }
	local Character = LocalPlayer.Character

	if Character then
		table.insert(t, Character)
	end

	v3.FilterDescendantsInstances = t

	local v42 = nil

	for i = 1, 10 do
		local v5 = workspace:Raycast(v2.Origin, v2.Direction * 5000, v3)

		if not v5 then
			break
		end

		local v6 = v5.Instance
		local v7 = p1:GetSprinklerFromPart(v6)

		if v7 then
			v42 = v7

			break
		end

		if not (v6.Transparency >= 0.9) then
			break
		end

		table.insert(t, v6)
		v3.FilterDescendantsInstances = t
	end

	if v42 == v4 then
		return
	end

	p1:DestroyHoverPreview()

	if not v42 then
		return
	end

	p1:CreateHoverPreview(v42)
end
function t.CreateHoverPreview(p1, p2) --[[ CreateHoverPreview | Line: 292 | Upvalues: v4 (ref), t3 (copy), Assets (copy), Temporary (copy), v2 (ref), v3 (ref), TweenService (copy) ]]
	v4 = p2

	local v1 = t3[p2:GetAttribute("SprinklerName")]

	if not v1 then
		return
	end

	local v22 = Assets.SprinklerRadius:Clone()

	v22.Size = Vector3.new(v1.Radius, 0.5, v1.Radius)
	v22.Anchored = true
	v22.CanCollide = false
	v22.CanQuery = false
	v22.CanTouch = false

	local Position = p2:GetPivot().Position

	v22.CFrame = CFrame.new((Vector3.new(Position.X, 142.602, Position.Z)))
	v22.Parent = Temporary
	v2 = v22

	local SurfaceGui = v22:FindFirstChild("SurfaceGui")

	if not SurfaceGui then
		return
	end

	local PrimaryCircle = SurfaceGui:FindFirstChild("PrimaryCircle")

	if PrimaryCircle and PrimaryCircle:IsA("ImageLabel") then
		v3 = task.spawn(function() --[[ Line: 317 | Upvalues: v2 (ref), PrimaryCircle (copy), SurfaceGui (copy), TweenService (ref) ]]
			while v2 and v2.Parent do
				local v1 = PrimaryCircle:Clone()
				local UIScale = v1:FindFirstChildOfClass("UIScale")

				if not UIScale then
					local UIScale2 = Instance.new("UIScale")

					UIScale2.Parent = v1
					UIScale = UIScale2
				end

				v1.Parent = SurfaceGui
				UIScale.Scale = 0

				local v22 = TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

				TweenService:Create(UIScale, v22, {
					Scale = 1
				}):Play()

				local v3 = TweenService:Create(v1, v22, {
					ImageTransparency = 0
				})

				v3:Play()
				v3.Completed:Once(function() --[[ Line: 335 | Upvalues: TweenService (ref), v1 (copy) ]]
					local v12 = TweenService:Create(v1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						ImageTransparency = 1
					})

					v12:Play()
					v12.Completed:Once(function() --[[ Line: 339 | Upvalues: v1 (ref) ]]
						v1:Destroy()
					end)
				end)
				task.wait(1.1)
			end
		end)
	end
end
function t.DestroyHoverPreview(p1) --[[ DestroyHoverPreview | Line: 349 | Upvalues: v3 (ref), v2 (ref), v4 (ref) ]]
	if v3 then
		task.cancel(v3)
		v3 = nil
	end

	if v2 then
		v2:Destroy()
		v2 = nil
	end

	v4 = nil
end

return t