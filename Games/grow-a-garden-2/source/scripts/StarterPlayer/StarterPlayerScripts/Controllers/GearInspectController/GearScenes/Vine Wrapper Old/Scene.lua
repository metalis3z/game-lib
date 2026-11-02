--credit to quartz games studio
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CatmullRomSpline = require(ReplicatedStorage.ClientModules.CatmullRomSpline)
local CCDIKController = require(ReplicatedStorage.ClientModules.CCDIKController)
local Vine = ReplicatedStorage.Assets.Vine
local Victim = script.Parent:WaitForChild("Victim")

local function RandomPerpendicularOffset(p1, p2) --[[ RandomPerpendicularOffset | Line: 38 ]]
	local v1 = Random.new()
	local Unit = p1.Unit:Cross(if math.abs((p1.Unit:Dot(Vector3.new(0, 1, 0)))) > 0.9 then Vector3.new(1, 0, 0) else Vector3.new(0, 1, 0)).Unit
	local Unit2 = p1.Unit:Cross(Unit).Unit

	return Unit * v1:NextNumber(-p2, p2) + Unit2 * v1:NextNumber(-p2, p2)
end

local function BuildSpline(p1, p2) --[[ BuildSpline | Line: 47 | Upvalues: RandomPerpendicularOffset (copy), CatmullRomSpline (copy) ]]
	local v1 = p2 - p1
	local Magnitude = v1.Magnitude
	local v2 = p1 + v1 * 0.33 + RandomPerpendicularOffset(v1, 3) + Vector3.new(0, 5, 0)
	local v3 = p1 + v1 * 0.66 + RandomPerpendicularOffset(v1, 3) + Vector3.new(0, 4, 0)
	local v4 = p1 - v1.Unit * (Magnitude * 0.15) + RandomPerpendicularOffset(v1, 0.8999999999999999)
	local v5 = p2 + v1.Unit * (Magnitude * 0.15) + RandomPerpendicularOffset(v1, 0.8999999999999999)
	local v6 = CatmullRomSpline.new({ v4, p1, v2, v3 })

	v6:AddPoint(p2)
	v6:AddPoint(v5)

	return v6
end

local function GrowSegment(p1, p2, p3) --[[ GrowSegment | Line: 65 | Upvalues: RunService (copy), Vine (copy), TweenService (copy) ]]
	local v2 = math.round((p1 - p2).Magnitude / 2) + 1
	local PrimaryPart = p3.PrimaryPart

	if not PrimaryPart then
		return
	end

	local Part = Instance.new("Part")

	Part.Size = Vector3.new(0.01, 0.01, 0.01)
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.MaterialVariant = "Weld 2x2 Plastic"
	Part.Color = Color3.fromRGB(44, 101, 29)
	Part.Parent = p3

	local v3 = 0
	local v4 = 0.1 + v2 * 0.005
	local Z = PrimaryPart.Size.Z

	task.spawn(function() --[[ Line: 85 | Upvalues: v3 (ref), v4 (copy), p3 (copy), RunService (ref), Z (copy), PrimaryPart (copy), Part (copy) ]]
		while v3 < v4 and p3.Parent do
			v3 = v3 + RunService.Heartbeat:Wait()

			local v1 = v3 / v4
			local v2 = v1 * Z

			Part.CFrame = PrimaryPart.CFrame * CFrame.new(0, 0, Z / 2 - v2 / 2)
			Part.Size = Vector3.new(0.7 * v1, 0.7 * v1, v2)
		end

		if p3.Parent then
			Part.CFrame = PrimaryPart.CFrame

			local WeldConstraint = Instance.new("WeldConstraint")

			Part.Anchored = false
			WeldConstraint.Part0 = Part
			WeldConstraint.Part1 = p3.PrimaryPart
			WeldConstraint.Parent = Part
		end
	end)

	for i = 0, v2 do
		if not p3.Parent then
			break
		end

		local v5 = i / math.round(v2)
		local Z2 = PrimaryPart.Size.Z
		local v7 = PrimaryPart.CFrame * CFrame.new(0, 0, Z2 / 2 - v5 * Z2)
		local v8 = Vine:Clone()
		local v9 = v8.Size * Random.new():NextNumber(0.8, 1.3)

		v8.Size = Vector3.new(0, 0, 0)
		v8.Parent = p3
		v8.CFrame = CFrame.new(v7.Position, v7.Position + Random.new():NextUnitVector())
		TweenService:Create(v8, TweenInfo.new(0.3), {
			Size = v9
		}):Play()
		TweenService:Create(v8.SurfaceAppearance, TweenInfo.new(0.35), {
			Color = Color3.fromRGB(44, 101, 29)
		}):Play()

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = v8
		WeldConstraint.Part1 = p3.PrimaryPart
		WeldConstraint.Parent = v8
		v8.Anchored = false
		v8.Massless = true
		v8.CanCollide = false
		v8.CanQuery = false
		v8.CanTouch = false
		task.wait(0.005)
	end
end

local function FireVine(p1, p2, p3, p4) --[[ FireVine | Line: 137 | Upvalues: BuildSpline (copy), CCDIKController (copy), GrowSegment (copy), TweenService (copy) ]]
	local v1 = BuildSpline(p1, p2)
	local VineGroup = Instance.new("Model")

	VineGroup.Name = "VineGroup"
	VineGroup.Parent = p4

	local t = {}
	local t2 = {}
	local t3 = {}

	for i = 1, 10 do
		local Model = Instance.new("Model")

		Model.Name = "Segment_" .. i
		Model.Parent = VineGroup
		t[i] = Model

		local v2 = v1:CalculatePositionAt((i - 1) / 10)
		local v3 = v1:CalculatePositionAt(i / 10)

		t2[i] = v2

		if i == 10 then
			t2[i + 1] = v3
		end

		table.insert(t3, {
			SegStart = v2,
			SegEnd = v3
		})

		local PrimaryPart = Instance.new("Part")

		PrimaryPart.Name = "PrimaryPart"
		PrimaryPart.Anchored = false
		PrimaryPart.CanCollide = false
		PrimaryPart.CanQuery = false
		PrimaryPart.Massless = true
		PrimaryPart.Transparency = 1
		PrimaryPart.Size = Vector3.new(1, 1, (v3 - v2).Magnitude)
		PrimaryPart.CFrame = CFrame.lookAt((v2 + v3) / 2, v3)
		PrimaryPart.Parent = Model
		Model.PrimaryPart = PrimaryPart
	end

	local t4 = {}
	local RootJoint = Instance.new("Motor6D")

	RootJoint.Name = "RootJoint"
	RootJoint.Part0 = p3
	RootJoint.Part1 = t[1].PrimaryPart

	local v4 = CFrame.new(t2[1])

	RootJoint.C0 = p3.CFrame:Inverse() * v4
	RootJoint.C1 = t[1].PrimaryPart.CFrame:Inverse() * v4
	RootJoint.Parent = p3
	t4[1] = RootJoint

	for j = 1, 9 do
		local PrimaryPart = t[j].PrimaryPart
		local PrimaryPart2 = t[j + 1].PrimaryPart
		local v5 = CFrame.new(t2[j + 1])
		local Motor6D = Instance.new("Motor6D")

		Motor6D.Name = "Joint_" .. j
		Motor6D.Part0 = PrimaryPart
		Motor6D.Part1 = PrimaryPart2
		Motor6D.C0 = PrimaryPart.CFrame:Inverse() * v5
		Motor6D.C1 = PrimaryPart2.CFrame:Inverse() * v5
		Motor6D.Parent = PrimaryPart
		t4[j + 1] = Motor6D
	end

	for v6, v7 in t do
		v7.PrimaryPart.Anchored = false
	end

	for v8, v9 in t4 do
		local Attachment = Instance.new("Attachment")

		Attachment.Name = v9.Part0.Name .. "AxisAttachment"
		Attachment.CFrame = v9.C0
		Attachment.Parent = v9.Part0

		local Attachment2 = Instance.new("Attachment")

		Attachment2.Name = v9.Part0.Name .. "JointAttachment"
		Attachment2.CFrame = v9.C1
		Attachment2.Parent = v9.Part1
	end

	local t5 = {}

	for v10, v11 in t4 do
		t5[v11] = {
			ConstraintType = "BallSocketConstraint",
			UpperAngle = 35,
			TwistLimitsEnabled = false
		}
	end

	local v12 = CCDIKController.new(t4, t5)

	v12.LerpMode = false
	v12.ConstantLerpSpeed = false
	v12.AngularSpeed = 0.7853981633974483
	v12.UseLastMotor = false

	for v13, v14 in t3 do
		local v15 = t[v13]

		task.spawn(function() --[[ Line: 244 | Upvalues: GrowSegment (ref), v14 (copy), v15 (copy) ]]
			GrowSegment(v14.SegStart, v14.SegEnd, v15)
		end)
	end

	local function UpdateGoal(p1, p2) --[[ UpdateGoal | Line: 250 | Upvalues: VineGroup (copy), v12 (copy) ]]
		if VineGroup.Parent then
			v12:CCDIKIterateOnce(p1, 0, p2)
		end
	end

	return {
		Retract = function() --[[ Retract | Line: 256 | Upvalues: VineGroup (copy), t (copy), TweenService (ref), t4 (copy) ]]
			if not VineGroup.Parent then
				return
			end

			for v1, v2 in t do
				if v2.Parent then
					v2.PrimaryPart.Anchored = true
					task.spawn(function() --[[ Line: 262 | Upvalues: v2 (copy), TweenService (ref) ]]
						for v1, v22 in v2:GetChildren() do
							if v22 ~= v2.PrimaryPart then
								if v22:IsA("MeshPart") then
									TweenService:Create(v22, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
										Size = Vector3.new(0, 0, 0),
										CFrame = CFrame.new(v22.Position, v22.Position + Random.new():NextUnitVector())
									}):Play()

									if v22:FindFirstChildOfClass("SurfaceAppearance") then
										TweenService:Create(v22.SurfaceAppearance, TweenInfo.new(0.2), {
											Color = Color3.fromRGB(71, 35, 14)
										}):Play()
									end
								elseif v22:IsA("BasePart") then
									TweenService:Create(v22, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
										Size = Vector3.new(0, 0, 0)
									}):Play()
								end

								task.wait(0.005)
							end
						end
					end)
				end
			end

			task.delay(0.6, function() --[[ Line: 283 | Upvalues: t4 (ref), VineGroup (ref) ]]
				for v1, v2 in t4 do
					if v2 and v2.Parent then
						v2:Destroy()
					end
				end

				if not (VineGroup and VineGroup.Parent) then
					return
				end

				VineGroup:Destroy()
			end)
		end,
		UpdateGoal = UpdateGoal
	}
end

local function SpawnVictim(p1, p2) --[[ SpawnVictim | Line: 294 | Upvalues: Victim (copy) ]]
	local VineVictim = Victim:Clone()

	VineVictim.Name = "VineVictim"
	VineVictim.Parent = p1

	local Humanoid = VineVictim:FindFirstChildOfClass("Humanoid")
	local HumanoidRootPart = VineVictim:FindFirstChild("HumanoidRootPart")

	if Humanoid and HumanoidRootPart then
		VineVictim.PrimaryPart = HumanoidRootPart
		Humanoid.AutoRotate = false
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
		Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		HumanoidRootPart.Anchored = false
		VineVictim:PivotTo(p2)

		return VineVictim, Humanoid, HumanoidRootPart
	end

	VineVictim:Destroy()

	return nil
end

local function PickDragTarget(p1, p2) --[[ PickDragTarget | Line: 320 ]]
	local v1 = math.random() * math.pi * 2
	local v2 = 2.5 + math.random() * 15.5
	local v3 = 3 + math.random() * 7
	local Position = p1.Position
	local v4 = Position.X + math.cos(v1) * v2

	return Vector3.new(v4, p2 + v3, Position.Z + math.sin(v1) * v2)
end

local function CreateFakeEmitter(p1) --[[ CreateFakeEmitter | Line: 332 ]]
	local FakeWrapperHandle = Instance.new("Part")

	FakeWrapperHandle.Name = "FakeWrapperHandle"
	FakeWrapperHandle.Size = Vector3.new(0.6, 0.6, 1.4)
	FakeWrapperHandle.Transparency = 1
	FakeWrapperHandle.CanCollide = false
	FakeWrapperHandle.CanQuery = false
	FakeWrapperHandle.Massless = true
	FakeWrapperHandle.Anchored = false
	FakeWrapperHandle.Parent = p1.Parent

	local v1 = p1.Parent
	local v2 = v1:FindFirstChild("RightHand") or v1:FindFirstChild("Right Arm") or p1
	local Weld = Instance.new("Weld")

	Weld.Part0 = v2
	Weld.Part1 = FakeWrapperHandle
	Weld.C0 = CFrame.new(0, -0.5, -0.7) * CFrame.Angles(-1.5707963267948966, 0, 0)
	Weld.Parent = FakeWrapperHandle

	return FakeWrapperHandle
end

function t.Run(p1) --[[ Run | Line: 356 | Upvalues: CreateFakeEmitter (copy), SpawnVictim (copy), FireVine (copy), RunService (copy), PickDragTarget (copy), TweenService (copy) ]]
	local Plot = p1.Plot
	local PlayerModel = p1.PlayerModel
	local PlayerHumanoid = p1.PlayerHumanoid
	local Camera = p1.Camera
	local Trove = p1.Trove

	if not PlayerModel then
		return
	end

	local HumanoidRootPart = PlayerModel:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	PlayerModel.PrimaryPart = HumanoidRootPart

	local v1 = PlayerModel:FindFirstChild("Torso") or PlayerModel:FindFirstChild("UpperTorso")
	local v2 = v1 and v1:FindFirstChild("Neck")
	local v3 = v2 and v2.C0
	local v4 = CreateFakeEmitter(HumanoidRootPart)

	Trove:Add(v4)

	local VineWrapperSceneVines = Instance.new("Folder")

	VineWrapperSceneVines.Name = "VineWrapperSceneVines"
	VineWrapperSceneVines.Parent = Plot
	Trove:Add(VineWrapperSceneVines)

	local CameraPart = Plot:FindFirstChild("CameraPart")
	local Center = Plot:FindFirstChild("Center")
	local v5 = Center and Center.Position or PlayerModel.PrimaryPart.Position

	if CameraPart then
		Camera.CameraType = Enum.CameraType.Scriptable
		Camera.CFrame = CameraPart.CFrame
	else
		Camera.CameraType = Enum.CameraType.Scriptable
		Camera.CFrame = CFrame.lookAt(v5 + Vector3.new(14, 8, 14), v5)
	end

	Camera.FieldOfView = 55

	local Y = v5.Y
	local TopLayer = Plot:FindFirstChild("TopLayer")

	if TopLayer then
		Y = TopLayer.Position.Y + TopLayer.Size.Y / 2
	end

	task.spawn(function() --[[ Line: 403 | Upvalues: VineWrapperSceneVines (copy), HumanoidRootPart (copy), Y (ref), SpawnVictim (ref), p1 (copy), PlayerModel (copy), FireVine (ref), v4 (copy), RunService (ref), Trove (copy), v2 (copy), v3 (copy), PickDragTarget (ref), TweenService (ref) ]]
		task.wait(0.4)

		while VineWrapperSceneVines.Parent do
			local v1 = HumanoidRootPart

			if not (v1 and v1.Parent) then
				break
			end

			local v22 = math.random() * math.pi * 2
			local v6 = Vector3.new(v1.Position.X + math.cos(v22) * 14, Y + 0 + 3, v1.Position.Z + math.sin(v22) * 14)
			local v7, _, v8 = SpawnVictim(VineWrapperSceneVines, CFrame.new(v6 + Vector3.new(0, -200, 0)))

			if v7 then
				v8.Anchored = true
				p1:ApplyRandomFriendAppearance(v7, nil, true)

				if VineWrapperSceneVines.Parent and v7.Parent then
					local v9 = v7:FindFirstChild("HumanoidRootPart") or v8

					v7.PrimaryPart = v9
					v9.Anchored = true
					v7:PivotTo(CFrame.new(v6))
					v9.Anchored = false
					task.wait(0.4)

					if VineWrapperSceneVines.Parent and v9.Parent then
						local X = v9.Position.X
						local Z = v9.Position.Z

						PlayerModel:PivotTo(CFrame.lookAt(v1.Position, (Vector3.new(X, v1.Position.Y, Z))))
						task.wait(0.15)

						if VineWrapperSceneVines.Parent and v9.Parent then
							local v11 = FireVine(v4.Position, v9.Position, v4, VineWrapperSceneVines)

							v9.Anchored = true

							local Anchored = v1.Anchored

							v1.Anchored = true

							local v12 = nil

							v12 = RunService.Heartbeat:Connect(function(p1) --[[ Line: 472 | Upvalues: VineWrapperSceneVines (ref), v9 (ref), v12 (ref), v11 (copy) ]]
								if VineWrapperSceneVines.Parent and v9.Parent then
									v11.UpdateGoal(v9.Position, p1)

									return
								end

								if not v12 then
									return
								end

								v12:Disconnect()
							end)
							Trove:Add(v12)

							local v13 = nil

							v13 = RunService.Heartbeat:Connect(function(p1) --[[ Line: 482 | Upvalues: VineWrapperSceneVines (ref), v9 (ref), v1 (copy), v13 (ref), PlayerModel (ref), v2 (ref), v3 (ref) ]]
								if VineWrapperSceneVines.Parent and (v9.Parent and v1.Parent) then
									local Position = v1.Position
									local Position2 = v9.Position
									local v12 = Vector3.new(Position2.X, Position.Y, Position2.Z)

									if (v12 - Position).Magnitude < 0.05 then
										return
									end

									local v22 = CFrame.lookAt(Position, v12)
									local v32 = 1 - math.exp(-8 * p1)

									PlayerModel:PivotTo((v1.CFrame:Lerp(v22, v32)))

									if not (v2 and v3) then
										return
									end

									local Magnitude = Vector2.new(Position2.X - Position.X, Position2.Z - Position.Z).Magnitude

									v2.C0 = v2.C0:Lerp(v3 * CFrame.Angles(-math.clamp(math.atan2(Position2.Y - Position.Y, (math.max(Magnitude, 0.1))), -0.7853981633974483, 1.0471975511965976), 0, 0), v32)
								else
									if not v13 then
										return
									end

									v13:Disconnect()
								end
							end)
							Trove:Add(v13)

							local v14 = tick()

							while tick() - v14 < 5 and (VineWrapperSceneVines.Parent and v9.Parent) do
								local v15 = PickDragTarget(v1, Y)
								local v17 = CFrame.lookAt(v15, (Vector3.new(v1.Position.X, v15.Y, v1.Position.Z)))
								local v18 = 0.35 + math.random() * 0.4
								local v19 = TweenService:Create(v9, TweenInfo.new(v18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									CFrame = v17
								})

								v19:Play()

								local sum = 0

								while sum < v18 and (VineWrapperSceneVines.Parent and v9.Parent) do
									sum = sum + RunService.Heartbeat:Wait()
								end

								if v19 then
									v19:Cancel()
								end
							end

							if v12 then
								v12:Disconnect()
							end

							if v13 then
								v13:Disconnect()
							end

							if v11.Retract then
								pcall(v11.Retract)
							end

							if v2 and v3 then
								v2.C0 = v3
							end

							if v7 and (v7.Parent and v9.Parent) then
								v9.Anchored = false
							end

							if v1.Parent then
								v1.Anchored = Anchored
							end

							task.wait(0.6)

							if v7 and v7.Parent then
								v7:Destroy()
							end

							task.wait(0.9)

							continue
						elseif v7 and v7.Parent then
							v7:Destroy()
						end

						continue
					elseif v7 and v7.Parent then
						v7:Destroy()
					end
				elseif v7 and v7.Parent then
					v7:Destroy()
				end
			end

			task.wait(0.9)
		end
	end)
end

return t