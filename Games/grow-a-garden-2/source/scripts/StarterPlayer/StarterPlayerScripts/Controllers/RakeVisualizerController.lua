--credit to quartz games studio
local t = {
	StartOrder = 4
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GardenSyncController = require(script.Parent.GardenSyncController)
local RakeData = require(ReplicatedStorage.SharedModules.RakeData)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Gardens = workspace:WaitForChild("Gardens")
local Temporary = workspace:WaitForChild("Temporary")
local Assets = ReplicatedStorage.Assets
local Rakes = Assets.Rakes
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = nil
local v2 = nil
local v3 = nil

function t.Init(p1) --[[ Init | Line: 31 | Upvalues: RakeData (copy), t3 (copy) ]]
	for v1, v2 in RakeData do
		t3[v2.RakeName] = v2
	end
end
function t.Start(p1) --[[ Start | Line: 37 | Upvalues: GardenSyncController (copy), Networking (copy), RunService (copy) ]]
	GardenSyncController:OnRakeAdded(function(p12, p2, p3) --[[ Line: 38 | Upvalues: p1 (copy) ]]
		p1:SpawnRakeFromData(p12, p2, p3)
	end)
	GardenSyncController:OnRakeRemoved(function(p12, p2) --[[ Line: 42 | Upvalues: p1 (copy) ]]
		p1:RemoveRakeById(p12, p2)
	end)
	Networking.Place.RakeActivated.OnClientEvent:Connect(function(p12, p2) --[[ Line: 46 | Upvalues: p1 (copy) ]]
		p1:PlayRakeActivatedFx(p12, p2)
	end)
	RunService.Heartbeat:Connect(function() --[[ Line: 50 | Upvalues: p1 (copy) ]]
		debug.profilebegin("Controllers/RakeVisualizerController/Heartbeat")
		p1:UpdateRakeTimers()
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
function t.GetSpawnPoint(p1, p2) --[[ GetSpawnPoint | Line: 73 ]]
	local v1 = p1:GetPlayerPlot(p2)

	if v1 then
		return v1:FindFirstChild("SpawnPoint")
	end

	return nil
end
function t.GetRakesFolder(p1, p2) --[[ GetRakesFolder | Line: 83 ]]
	local v1 = p1:GetPlayerPlot(p2)

	if not v1 then
		return nil
	end

	local Rakes = v1:FindFirstChild("Rakes")

	if not Rakes then
		local Rakes2 = Instance.new("Folder")

		Rakes2.Name = "Rakes"
		Rakes2.Parent = v1
		Rakes = Rakes2
	end

	return Rakes
end
function t.GetRakeData(p1, p2) --[[ GetRakeData | Line: 98 | Upvalues: t3 (copy) ]]
	return t3[p2]
end
function t.CreateRakeTimerUI(p1, p2) --[[ CreateRakeTimerUI | Line: 102 ]]
	local v1 = script.RakeTimerUI:Clone()

	v1.Parent = p2

	return v1
end
function t.UpdateRakeTimers(p1) --[[ UpdateRakeTimers | Line: 108 | Upvalues: t2 (copy), t4 (copy) ]]
	local v1 = os.time()
	local t = {}

	for v2, v3 in t2 do
		if v3 and v3.Parent then
			local v4 = t4[v2]

			if v4 then
				local v7 = math.clamp(v4.Lifetime - (v1 - v4.PlacedAt), 0, v4.Lifetime)

				if v7 <= 0 then
					table.insert(t, v2)

					continue
				end

				local v8 = math.floor(v7 / 60)
				local v9 = v7 % 60
				local RakeTimerUI = v3:FindFirstChild("RakeTimerUI")

				if RakeTimerUI and RakeTimerUI:IsA("BillboardGui") then
					local TextLabel = RakeTimerUI:FindFirstChildOfClass("TextLabel")

					if TextLabel then
						TextLabel.Text = string.format("%d:%02d", v8, v9)
					end
				end
			end
		end
	end

	for v10, v11 in t do
		local v12 = t2[v11]

		if v12 then
			v12:Destroy()
		end

		t2[v11] = nil
		t4[v11] = nil
	end
end
function t.SpawnRakeFromData(p1, p2, p3, p4) --[[ SpawnRakeFromData | Line: 151 | Upvalues: t2 (copy), t4 (copy), Rakes (copy) ]]
	local v1 = p1:GetSpawnPoint(p2)

	if not v1 then
		return
	end

	local v2 = p1:GetRakesFolder(p2)

	if not v2 then
		return
	end

	local RakeName = p4.RakeName

	if not RakeName then
		return
	end

	local v3 = p1:GetRakeData(RakeName)

	if v3 and (p4.PlacedAt and os.time() - p4.PlacedAt >= (v3.Lifetime or (1 / 0))) then
		return
	end

	local v4 = ("%*_%*"):format(p2, p3)

	if t2[v4] then
		t2[v4]:Destroy()
		t2[v4] = nil
		t4[v4] = nil
	end

	local v5 = v4
	local v8 = v1.CFrame:PointToWorldSpace((Vector3.new(p4.Positions.PosX, p4.Positions.PosY, p4.Positions.PosZ)))
	local _, v9, _2 = v1.CFrame:ToEulerAnglesYXZ()
	local v10 = math.rad(p4.Positions.Rotation or 0) + v9
	local v11 = CFrame.new(v8) * CFrame.Angles(0, v10, 0)
	local v12 = Rakes:FindFirstChild(RakeName)

	if not v12 then
		return
	end

	local v13 = v12:Clone()

	v13.Name = v5
	v13:SetAttribute("RakeId", p3)
	v13:SetAttribute("UserId", p2)
	v13:SetAttribute("RakeName", RakeName)
	v13.Parent = v2
	v13:PivotTo(v11 * CFrame.Angles(0, math.pi, 0))

	for v14, v15 in v13:GetDescendants() do
		if v15:IsA("BasePart") then
			v15.CanTouch = false
		end
	end

	local HoverDetection = Instance.new("Part")

	HoverDetection.Name = "HoverDetection"
	HoverDetection.Size = Vector3.new(3, 2, 3)
	HoverDetection.Transparency = 1
	HoverDetection.CanCollide = false
	HoverDetection.CanTouch = false
	HoverDetection.CanQuery = true
	HoverDetection.Anchored = true
	HoverDetection.CFrame = v11
	HoverDetection.Parent = v13

	local v16 = p1:GetRakeData(RakeName)
	local v18 = (v16 and v16.Radius or 7) * 2
	local TouchHitbox = Instance.new("Part")

	TouchHitbox.Name = "TouchHitbox"
	TouchHitbox.Shape = Enum.PartType.Cylinder
	TouchHitbox.Size = Vector3.new(6, v18, v18)
	TouchHitbox.CFrame = CFrame.new(v8) * CFrame.Angles(0, 0, 1.5707963267948966)
	TouchHitbox.Transparency = 1
	TouchHitbox.CanCollide = false
	TouchHitbox.CanTouch = true
	TouchHitbox.CanQuery = false
	TouchHitbox.Anchored = true
	TouchHitbox.Parent = v13

	if v16 then
		t4[v5] = {
			PlacedAt = p4.PlacedAt,
			Lifetime = v16.Lifetime
		}
		p1:CreateRakeTimerUI(v13)
	end

	t2[v5] = v13
end
function t.RemoveRakeById(p1, p2, p3) --[[ RemoveRakeById | Line: 256 | Upvalues: t2 (copy), t4 (copy) ]]
	local v1 = ("%*_%*"):format(p2, p3)
	local v2 = t2[v1]

	if not v2 then
		return
	end

	v2:Destroy()
	t2[v1] = nil
	t4[v1] = nil
end
function t.FindModelByRakeId(p1, p2) --[[ FindModelByRakeId | Line: 270 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2 do
		if v2 and (v2.Parent and v2:GetAttribute("RakeId") == p2) then
			return v2
		end
	end

	return nil
end
function t.GetRakeFromPart(p1, p2) --[[ GetRakeFromPart | Line: 279 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2 do
		if v2 and (v2.Parent and p2:IsDescendantOf(v2)) then
			return v2
		end
	end

	return nil
end
function t.PlayRakeActivatedFx(p1, p2, p3) --[[ PlayRakeActivatedFx | Line: 291 | Upvalues: TweenService (copy) ]]
	local v1 = p1:FindModelByRakeId(p2)

	if not v1 then
		return
	end

	local RakeModel = v1:FindFirstChild("RakeModel")
	local v2 = if RakeModel then RakeModel:FindFirstChild("Hitbox") else RakeModel

	if v2 then
		local Thud = v2:FindFirstChild("Thud")

		if Thud then
			Thud.PlaybackSpeed = math.random(90, 110) / 100
			Thud.TimePosition = 0
			Thud:Play()
		end

		local VFX = v2:FindFirstChild("VFX")

		if VFX and VFX:FindFirstChild("Break") then
			VFX.Break:Emit(2)
		end
	end

	if not RakeModel then
		return
	end

	local v3 = RakeModel:GetPivot()
	local _, v4, _2 = v3:ToOrientation()
	local v5 = CFrame.new(v3.Position) * CFrame.Angles(0, v4 + math.pi, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
	local v6 = Instance.new("NumberValue")

	v6.Value = 0

	local v7 = nil

	v7 = v6.Changed:Connect(function() --[[ Line: 325 | Upvalues: RakeModel (copy), v7 (ref), v6 (copy), v3 (copy), v5 (copy) ]]
		if RakeModel and RakeModel.Parent then
			RakeModel:PivotTo(v3:Lerp(v5, v6.Value))
		else
			v7:Disconnect()
			v6:Destroy()
		end
	end)

	local v8 = TweenService:Create(v6, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
		Value = 1
	})

	v8:Play()
	v8.Completed:Once(function() --[[ Line: 337 | Upvalues: TweenService (ref), v6 (copy), v7 (ref) ]]
		task.wait(2)

		local v1 = TweenService:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Value = 0
		})

		v1:Play()
		v1.Completed:Once(function() --[[ Line: 342 | Upvalues: v7 (ref), v6 (ref) ]]
			v7:Disconnect()
			v6:Destroy()
		end)
	end)
end
function t.UpdateHoverPreview(p1) --[[ UpdateHoverPreview | Line: 353 | Upvalues: v3 (ref), UserInputService (copy), CurrentCamera (copy), Temporary (copy), LocalPlayer (copy) ]]
	if v3 and not v3.Parent then
		p1:DestroyHoverPreview()
	end

	local v1 = UserInputService:GetMouseLocation()
	local v2 = CurrentCamera:ViewportPointToRay(v1.X, v1.Y)
	local v32 = RaycastParams.new()

	v32.FilterType = Enum.RaycastFilterType.Exclude

	local t = { Temporary }
	local Character = LocalPlayer.Character

	if Character then
		table.insert(t, Character)
	end

	v32.FilterDescendantsInstances = t

	local v4 = nil

	for i = 1, 10 do
		local v5 = workspace:Raycast(v2.Origin, v2.Direction * 5000, v32)

		if v5 then
			local v6 = v5.Instance

			if v6.Transparency >= 0.9 and v6.Name ~= "HoverDetection" then
				table.insert(t, v6)
				v32.FilterDescendantsInstances = t
				v4 = v5
			else
				v4 = v5

				break
			end
		else
			v4 = v5

			break
		end
	end

	local v7 = if v4 then p1:GetRakeFromPart(v4.Instance) else nil

	if v7 == v3 then
		return
	end

	p1:DestroyHoverPreview()

	if not v7 then
		return
	end

	p1:CreateHoverPreview(v7)
end
function t.CreateHoverPreview(p1, p2) --[[ CreateHoverPreview | Line: 405 | Upvalues: v3 (ref), t3 (copy), Assets (copy), Temporary (copy), v1 (ref), v2 (ref), TweenService (copy) ]]
	v3 = p2

	local v12 = t3[p2:GetAttribute("RakeName")]

	if not v12 then
		return
	end

	local v22 = Assets.SprinklerRadius:Clone()

	v22.Size = Vector3.new(v12.Radius * 2, 0.5, v12.Radius * 2)
	v22.Anchored = true
	v22.CanCollide = false
	v22.CanQuery = false
	v22.CanTouch = false

	local Position = p2:GetPivot().Position

	v22.CFrame = CFrame.new((Vector3.new(Position.X, 142.602, Position.Z)))
	v22.Parent = Temporary
	v1 = v22

	local SurfaceGui = v22:FindFirstChild("SurfaceGui")

	if not SurfaceGui then
		return
	end

	local PrimaryCircle = SurfaceGui:FindFirstChild("PrimaryCircle")

	if not (PrimaryCircle and PrimaryCircle:IsA("ImageLabel")) then
		return
	end

	v2 = task.spawn(function() --[[ Line: 428 | Upvalues: v1 (ref), PrimaryCircle (copy), SurfaceGui (copy), TweenService (ref) ]]
		while v1 and v1.Parent do
			local v12 = PrimaryCircle:Clone()
			local UIScale = v12:FindFirstChildOfClass("UIScale")

			if not UIScale then
				local UIScale2 = Instance.new("UIScale")

				UIScale2.Parent = v12
				UIScale = UIScale2
			end

			v12.Parent = SurfaceGui
			UIScale.Scale = 0

			local v2 = TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			TweenService:Create(UIScale, v2, {
				Scale = 1
			}):Play()

			local v3 = TweenService:Create(v12, v2, {
				ImageTransparency = 0
			})

			v3:Play()
			v3.Completed:Once(function() --[[ Line: 446 | Upvalues: TweenService (ref), v12 (copy) ]]
				local v1 = TweenService:Create(v12, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					ImageTransparency = 1
				})

				v1:Play()
				v1.Completed:Once(function() --[[ Line: 450 | Upvalues: v12 (ref) ]]
					v12:Destroy()
				end)
			end)
			task.wait(1.1)
		end
	end)
end
function t.DestroyHoverPreview(p1) --[[ DestroyHoverPreview | Line: 462 | Upvalues: v2 (ref), v1 (ref), v3 (ref) ]]
	if v2 then
		task.cancel(v2)
		v2 = nil
	end

	if not v1 then
		v3 = nil

		return
	end

	v1:Destroy()
	v1 = nil
	v3 = nil
end

return t