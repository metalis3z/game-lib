--credit to quartz games studio
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CatmullRomSpline = require(ReplicatedStorage.ClientModules.CatmullRomSpline)
local CCDIKController = require(ReplicatedStorage.ClientModules.CCDIKController)
local VineWrapperController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.VineWrapperController)
local Animation = Instance.new("Animation")

Animation.AnimationId = "rbxassetid://76035653903095"

local Animation2 = Instance.new("Animation")

Animation2.AnimationId = "rbxassetid://111430418578997"

local Animation3 = Instance.new("Animation")

Animation3.AnimationId = "rbxassetid://138102881117255"

local VineInspect = script.Parent.VineInspect

VineInspect.Parent = nil

local WeldGlow_Player_Shop = game.MaterialService.ToolMaterials.GlowWeldTemplate:Clone()

WeldGlow_Player_Shop.Name = "WeldGlow_Player_Shop"
WeldGlow_Player_Shop.Parent = game.MaterialService.ToolMaterials

local Vine = ReplicatedStorage.Assets.Vine

local function RandomPerpendicularOffset(p1, p2) --[[ RandomPerpendicularOffset | Line: 47 ]]
	local v1 = Random.new()
	local Unit = p1.Unit:Cross(if math.abs((p1.Unit:Dot(Vector3.new(0, 1, 0)))) > 0.9 then Vector3.new(1, 0, 0) else Vector3.new(0, 1, 0)).Unit
	local Unit2 = p1.Unit:Cross(Unit).Unit

	return Unit * v1:NextNumber(-p2, p2) + Unit2 * v1:NextNumber(-p2, p2)
end

local function BuildSpline(p1, p2) --[[ BuildSpline | Line: 56 | Upvalues: RandomPerpendicularOffset (copy), CatmullRomSpline (copy) ]]
	local v1 = p2 - p1
	local Magnitude = v1.Magnitude
	local v2 = p1 + v1 * 0.33 + RandomPerpendicularOffset(v1, 3) + Vector3.new(0, 15, 0)
	local v3 = p1 + v1 * 0.66 + RandomPerpendicularOffset(v1, 3) + Vector3.new(0, 12, 0)
	local v4 = p1 - v1.Unit * (Magnitude * 0.15) + RandomPerpendicularOffset(v1, 0.8999999999999999)
	local v5 = p2 + v1.Unit * (Magnitude * 0.15) + RandomPerpendicularOffset(v1, 0.8999999999999999)
	local v6 = CatmullRomSpline.new({ v4, p1, v2, v3 })

	v6:AddPoint(p2)
	v6:AddPoint(v5)

	return v6
end

local function GrowSegment(p1, p2, p3) --[[ GrowSegment | Line: 74 | Upvalues: RunService (copy), Vine (copy) ]]
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

	task.spawn(function() --[[ Line: 94 | Upvalues: v3 (ref), v4 (copy), p3 (copy), RunService (ref), Z (copy), PrimaryPart (copy), Part (copy) ]]
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
		game.TweenService:Create(v8, TweenInfo.new(0.3), {
			Size = v9
		}):Play()
		game.TweenService:Create(v8.SurfaceAppearance, TweenInfo.new(0.35), {
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

local function FireVine(p1, p2, p3, p4) --[[ FireVine | Line: 146 | Upvalues: BuildSpline (copy), CCDIKController (copy), GrowSegment (copy) ]]
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

		task.spawn(function() --[[ Line: 253 | Upvalues: GrowSegment (ref), v14 (copy), v15 (copy) ]]
			GrowSegment(v14.SegStart, v14.SegEnd, v15)
		end)
	end

	local function UpdateGoal(p1, p2) --[[ UpdateGoal | Line: 259 | Upvalues: VineGroup (copy), v12 (copy) ]]
		if VineGroup.Parent then
			v12:CCDIKIterateOnce(p1, 0, p2)
		end
	end

	return {
		Retract = function() --[[ Retract | Line: 265 | Upvalues: VineGroup (copy), t (copy), t4 (copy) ]]
			if not VineGroup.Parent then
				return
			end

			for v1, v2 in t do
				if v2.Parent then
					v2.PrimaryPart.Anchored = true
					task.spawn(function() --[[ Line: 271 | Upvalues: v2 (copy) ]]
						for v1, v22 in v2:GetChildren() do
							if v22 ~= v2.PrimaryPart then
								if v22:IsA("MeshPart") then
									game.TweenService:Create(v22, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
										Size = Vector3.new(0, 0, 0),
										CFrame = CFrame.new(v22.Position, v22.Position + Random.new():NextUnitVector())
									}):Play()

									if v22:FindFirstChildOfClass("SurfaceAppearance") then
										game.TweenService:Create(v22.SurfaceAppearance, TweenInfo.new(0.2), {
											Color = Color3.fromRGB(71, 35, 14)
										}):Play()
									end
								elseif v22:IsA("BasePart") then
									game.TweenService:Create(v22, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
										Size = Vector3.new(0, 0, 0)
									}):Play()
								end

								task.wait(0.005)
							end
						end
					end)
				end
			end

			task.delay(0.6, function() --[[ Line: 292 | Upvalues: t4 (ref), VineGroup (ref) ]]
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

function t.Run(p1) --[[ Run | Line: 304 | Upvalues: VineInspect (copy), RunService (copy), Animation (copy), Animation2 (copy), Animation3 (copy), VineWrapperController (copy), ReplicatedStorage (copy), WeldGlow_Player_Shop (copy), FireVine (copy) ]]
	local Plot = p1.Plot
	local PlayerModel = p1.PlayerModel
	local Camera = p1.Camera
	local Trove = p1.Trove

	if not (PlayerModel and p1.PlayerHumanoid) then
		return
	end

	local v1 = VineInspect:Clone()

	Trove:Add(v1)

	local Player1 = PlayerModel:Clone()

	Player1.PrimaryPart = Player1.HumanoidRootPart
	Player1:PivotTo(v1.Player1:GetPivot())
	Player1.Parent = v1

	local v2 = v1.Player1["Vine Wrapper"]:Clone()

	v2.Parent = Player1

	local WeldConstraint = Instance.new("WeldConstraint")

	WeldConstraint.Part0 = v2.Handle
	WeldConstraint.Part1 = Player1["Right Arm"]
	WeldConstraint.Parent = Player1
	v1.Player1:Destroy()
	Player1.Name = "Player1"
	v1.Parent = workspace.Terrain
	Camera.CameraType = Enum.CameraType.Scriptable

	local v3 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 360 | Upvalues: v1 (copy), Camera (copy) ]]
		if v1.Parent then
			workspace.CurrentCamera.CFrame = v1.Camera.Camera.CFrame
			Camera.FieldOfView = 35
		end
	end)

	Trove:Add(v3)
	game:GetService("ContentProvider"):PreloadAsync({ Animation, Animation2, Animation3 })

	local v4 = script.FadeIn:Clone()

	v4.Parent = game.Players.LocalPlayer.PlayerGui
	v4.Frame.BackgroundTransparency = 0
	Trove:Add(v4)

	repeat
		task.wait(0.25)
	until game:GetService("ContentProvider").RequestQueueSize == 0

	if v1.Parent then
		local v5 = Player1.Humanoid.Animator:LoadAnimation(Animation)
		local v6 = v1.Player2.Humanoid.Animator:LoadAnimation(Animation2)
		local v7 = v1.Camera.AnimationController.Animator:LoadAnimation(Animation3)

		p1:ApplyRandomFriendAppearance(v1.Player2, nil, true)

		local t2 = {}

		workspace.CurrentCamera.FieldOfView = 35

		local v8 = true

		Trove:Add(v7:GetMarkerReachedSignal("Start"):Connect(function() --[[ Line: 397 | Upvalues: v4 (copy) ]]
			game.TweenService:Create(v4.Frame, TweenInfo.new(0.3), {
				BackgroundTransparency = 1
			}):Play()
		end))

		if not v1:FindFirstChild("Temporary") then
			local Temporary = Instance.new("Folder")

			Temporary.Name = "Temporary"
			Temporary.Parent = v1
		end

		local function f10() --[[ Line: 409 | Upvalues: VineWrapperController (ref), Player1 (copy), ReplicatedStorage (ref), WeldGlow_Player_Shop (ref), v2 (copy), v8 (ref), v1 (copy) ]]
			task.spawn(function() --[[ Line: 410 | Upvalues: VineWrapperController (ref), Player1 (ref), ReplicatedStorage (ref), WeldGlow_Player_Shop (ref), v2 (ref), v8 (ref), v1 (ref) ]]
				local v12 = VineWrapperController.WrapCharacter(Player1, ReplicatedStorage.Assets.VineArmTemplate)

				game.TweenService:Create(WeldGlow_Player_Shop, TweenInfo.new(1), {
					EmissiveStrength = 2
				}):Play()

				for v22, v3 in v2.Handle.VineEmitterAttachment:GetChildren() do
					v3.Enabled = true
					v3:Emit(v3:GetAttribute("EmitCount"))
				end

				v8 = true

				while v8 do
					task.wait(0.1)

					local v4 = v1 and v1.Parent and v1:FindFirstChild("Temporary")

					if not v4 then
						break
					end

					local Part = Instance.new("Part")

					Part.Size = Vector3.new(0.2, 0.2, 0.2)
					Part.Color = ({ Color3.fromRGB(162, 227, 51), Color3.fromRGB(56, 158, 40), Color3.fromRGB(45, 141, 52) })[Random.new():NextInteger(1, 3)]
					Part.Parent = v4
					Part.Anchored = true
					Part.CanCollide = false
					Part.CanTouch = false
					Part.CanQuery = false
					Part.MaterialVariant = WeldGlow_Player_Shop.Name
					game.TweenService:Create(Part, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
						Size = Vector3.new(0.4, 0.4, 0.4)
					}):Play()

					local v5 = 0.8 / #v2.DetailEffect:GetChildren()
					local v6 = nil

					task.spawn(function() --[[ Line: 446 | Upvalues: v2 (ref), v6 (ref), v5 (copy), Part (copy) ]]
						for i = 1, #v2.DetailEffect:GetChildren() do
							if not v2:FindFirstChild("DetailEffect") then
								return
							end

							local v1 = v2.DetailEffect:FindFirstChild((tostring(i)))

							if v6 == nil then
								v6 = v1

								continue
							end

							local sum = 0

							while sum < v5 do
								sum = sum + game:GetService("RunService").Heartbeat:Wait()
								Part.CFrame = v6.CFrame:Lerp(v1.CFrame, sum / v5)
							end

							v6 = v1
						end

						Part:Destroy()
					end)
				end

				v12()
			end)
		end

		table.insert(t2, v7:GetMarkerReachedSignal("Chargeup"):Connect(f10))

		local v11 = nil
		local v12 = nil

		local function f14() --[[ Line: 482 | Upvalues: WeldGlow_Player_Shop (ref), v2 (copy), v11 (ref), FireVine (ref), v1 (copy), v12 (ref), VineWrapperController (ref), RunService (ref), Trove (copy) ]]
			game.TweenService:Create(WeldGlow_Player_Shop, TweenInfo.new(1), {
				EmissiveStrength = 1
			}):Play()

			for v13, v22 in v2.Handle.VineEmitterAttachment:GetChildren() do
				v22:Emit(v22:GetAttribute("EmitCount"))
			end

			local v3 = game.SoundService.SFX["Vine Cast"]:Clone()

			v3.Parent = v2.Handle
			v3:Play()
			game.Debris:AddItem(v3, 3)
			v11 = FireVine(v2.Handle.VineEmitter.Position, v1.Player2.Torso.Position, v2.Handle.VineEmitter, v1.Temporary)
			v12 = VineWrapperController.WrapCharacter(v1.Player2)

			local v4 = nil

			v4 = RunService.Heartbeat:Connect(function(p1) --[[ Line: 502 | Upvalues: v1 (ref), v4 (ref), v11 (ref) ]]
				if v1.Parent and v1.Temporary.Parent then
					v11.UpdateGoal(v1.Player2.Torso.Position, p1)

					return
				end

				if not v4 then
					return
				end

				v4:Disconnect()
			end)
			Trove:Add(v12)
			Trove:Add(v4)
		end

		table.insert(t2, v7:GetMarkerReachedSignal("CreateVine"):Connect(f14))

		local function f16() --[[ Line: 513 | Upvalues: v11 (ref), v8 (ref), v12 (ref), WeldGlow_Player_Shop (ref), v2 (copy) ]]
			if v11.Retract then
				pcall(v11.Retract)
			end

			v8 = false
			v12()
			game.TweenService:Create(WeldGlow_Player_Shop, TweenInfo.new(1), {
				EmissiveStrength = 0
			}):Play()

			for v1, v22 in v2.Handle.VineEmitterAttachment:GetChildren() do
				v22:Emit(v22:GetAttribute("EmitCount"))
				v22.Enabled = false
			end

			local v3 = game.SoundService.SFX.VineStrike:Clone()

			v3.Parent = v2.Handle
			v3:Play()
			game.Debris:AddItem(v3, 3)

			local v4 = game.SoundService.SFX.VineCrumble:Clone()

			v4.Parent = v2.Handle
			v4:Play()
			game.Debris:AddItem(v4, 2)
		end

		table.insert(t2, v7:GetMarkerReachedSignal("VineDisconnect"):Connect(f16))
		table.insert(t2, v7:GetMarkerReachedSignal("FadeOut"):Connect(function() --[[ Line: 543 | Upvalues: v4 (copy) ]]
			game.TweenService:Create(v4.Frame, TweenInfo.new(0.3), {
				BackgroundTransparency = 0
			}):Play()
		end))
		v5.Looped = true
		v6.Looped = true
		v7.Looped = true
		v5:Play()
		v6:Play()
		v7:Play()
		Camera.FieldOfView = 25
		Trove:Add(function() --[[ Line: 562 | Upvalues: v8 (ref), v11 (ref), v12 (ref), v4 (copy), v3 (ref), v5 (copy), v7 (copy), v6 (copy) ]]
			v8 = false

			if v11 and v11.Retract then
				pcall(v11.Retract)
			end

			if v12 then
				v12()
				v12 = nil
			end

			if v4 then
				v4:Destroy()
			end

			if v3 then
				v3:Disconnect()
			end

			if v5 then
				v5:Stop()
				v5:Destroy()
			end

			if v7 then
				v7:Stop()
				v7:Destroy()
			end

			if not v6 then
				return
			end

			v6:Stop()
			v6:Destroy()
		end)
	end
end

return t