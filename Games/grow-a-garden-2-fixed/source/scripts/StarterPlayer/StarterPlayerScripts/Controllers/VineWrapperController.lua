--credit to quartz games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local CatmullRomSpline = require(ReplicatedStorage.ClientModules.CatmullRomSpline)
local CCDIKController = require(ReplicatedStorage.ClientModules.CCDIKController)
local LocalPlayer = Players.LocalPlayer

local function LoadAnim(p1) --[[ LoadAnim | Line: 21 ]]
	if not p1 then
		return
	end

	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	local Animator = Humanoid:FindFirstChildOfClass("Animator")

	if Animator then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = "rbxassetid://78592768207309"
		Animator:LoadAnimation(Animation).Priority = Enum.AnimationPriority.Action
	end
end

local v1 = RaycastParams.new()

v1.FilterType = Enum.RaycastFilterType.Exclude

local function Raycast(p1, p2) --[[ Raycast | Line: 48 | Upvalues: LocalPlayer (copy), v1 (copy) ]]
	local t = {}

	if LocalPlayer.Character then
		table.insert(t, LocalPlayer.Character)
	end

	if p2 then
		for v12, v2 in game.CollectionService:GetTagged("Character") do
			table.insert(t, v2)
		end
	end

	local count = 10

	repeat
		v1.FilterDescendantsInstances = t

		local v3 = workspace:Raycast(p1.Origin, p1.Direction * 40, v1)

		if not v3 then
			return p1.Origin + p1.Direction * 40
		end

		local v4 = v3.Instance

		if v4.Transparency < 1 and (v4.CanQuery and not v4:IsDescendantOf(LocalPlayer.Character)) then
			return v3.Position, v4, v3.Normal
		end

		table.insert(t, v4)
		count = count - 1
	until count == 0
end

local function randomPerpOffset(p1, p2) --[[ randomPerpOffset | Line: 86 ]]
	local v1 = Random.new()
	local Unit = p1.Unit:Cross(if math.abs((p1.Unit:Dot(Vector3.new(0, 1, 0)))) > 0.9 then Vector3.new(1, 0, 0) else Vector3.new(0, 1, 0)).Unit
	local Unit2 = p1.Unit:Cross(Unit).Unit

	return Unit * v1:NextNumber(-p2, p2) + Unit2 * v1:NextNumber(-p2, p2)
end

local Vine = game.ReplicatedStorage.Assets.Vine

local function FollowPath(p1, p2, p3) --[[ FollowPath | Line: 97 | Upvalues: RunService (copy), Vine (copy), TweenService (copy) ]]
	local v2 = math.round((p1 - p2).Magnitude / 2) + 1
	local Part = Instance.new("Part")

	Part.Size = Vector3.new(0.01, 0.01, 0.01)
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.Massless = true
	Part.CastShadow = false
	Part.EnableFluidForces = false
	Part.MaterialVariant = "Weld 2x2 Plastic"
	Part.Color = Color3.fromRGB(44, 101, 29)
	Part.Parent = p3

	local v3 = 0
	local v4 = 0.1 + v2 * 0.005
	local PrimaryPart = p3.PrimaryPart
	local Z = PrimaryPart.Size.Z

	task.spawn(function() --[[ Line: 122 | Upvalues: v3 (ref), v4 (copy), RunService (ref), Z (copy), PrimaryPart (copy), Part (copy), p3 (copy) ]]
		while v3 < v4 do
			v3 = v3 + RunService.Heartbeat:Wait()

			local v1 = v3 / v4
			local v2 = v1 * Z

			Part.CFrame = PrimaryPart.CFrame * CFrame.new(0, 0, Z / 2 - v2 / 2)
			Part.Size = Vector3.new(0.7 * v1, 0.7 * v1, v2)
		end

		Part.CFrame = PrimaryPart.CFrame

		local WeldConstraint = Instance.new("WeldConstraint")

		Part.Anchored = false
		WeldConstraint.Part0 = Part
		WeldConstraint.Part1 = p3.PrimaryPart
		WeldConstraint.Parent = Part
	end)

	for i = 0, v2 do
		local v5 = i / math.round(v2)

		p1:Lerp(p2, v5)

		local v6 = Vine:Clone()
		local v7 = v6.Size * Random.new():NextNumber(0.8, 1.3)

		v6.Size = Vector3.new(0, 0, 0)
		v6.Parent = p3

		local PrimaryPart2 = p3.PrimaryPart
		local Z2 = PrimaryPart2.Size.Z
		local v9 = PrimaryPart2.CFrame * CFrame.new(0, 0, Z2 / 2 - v5 * Z2)

		v6.CFrame = CFrame.new(v9.Position, v9.Position + Random.new():NextUnitVector())
		TweenService:Create(v6, TweenInfo.new(0.3), {
			Size = v7
		}):Play()
		TweenService:Create(v6.SurfaceAppearance, TweenInfo.new(0.35), {
			Color = Color3.fromRGB(44, 101, 29)
		}):Play()

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = v6
		WeldConstraint.Part1 = p3.PrimaryPart
		WeldConstraint.Parent = v6
		v6.Anchored = false
		v6.Massless = true
		v6.CanCollide = false
		v6.CanQuery = false
		v6.CanTouch = false
		v6.CastShadow = false
		v6.EnableFluidForces = false
		task.wait(0.005)
	end
end

local function BuildSpline(p1, p2) --[[ BuildSpline | Line: 195 | Upvalues: randomPerpOffset (copy), CatmullRomSpline (copy) ]]
	local v1 = p2 - p1
	local Magnitude = v1.Magnitude
	local v2 = p1 + v1 * 0.33 + randomPerpOffset(v1, 3) + Vector3.new(0, 5, 0)
	local v3 = p1 + v1 * 0.66 + randomPerpOffset(v1, 3) + Vector3.new(0, 4, 0)
	local v4 = p1 - v1.Unit * (Magnitude * 0.15) + randomPerpOffset(v1, 0.8999999999999999)
	local v5 = p2 + v1.Unit * (Magnitude * 0.15) + randomPerpOffset(v1, 0.8999999999999999)
	local v6 = CatmullRomSpline.new({ v4, p1, v2, v3 })

	v6:AddPoint(p2)
	v6:AddPoint(v5)

	return v6
end

local function FollowSplinePath(p1, p2, p3) --[[ FollowSplinePath | Line: 213 | Upvalues: BuildSpline (copy), FollowPath (copy) ]]
	local v1 = BuildSpline(p1, p2)
	local VineGroup = Instance.new("Model")

	VineGroup.Name = "VineGroup"
	VineGroup.Parent = workspace.Temporary

	local t = {}
	local t2 = {}
	local t3 = {}
	local sum = 0

	for i = 1, 6 do
		local Model = Instance.new("Model")

		Model.Name = "Segment_" .. i
		Model.Parent = VineGroup
		t[i] = Model

		local v2 = v1:CalculatePositionAt((i - 1) / 6)
		local v3 = v1:CalculatePositionAt(i / 6)

		t2[i] = v2

		if i == 6 then
			t2[i + 1] = v3
		end

		table.insert(t3, {
			SegStart = v2,
			SegEnd = v3
		})

		local Magnitude = (v3 - v2).Magnitude
		local PrimaryPart = Instance.new("Part")

		PrimaryPart.Name = "PrimaryPart"
		PrimaryPart.Anchored = false
		PrimaryPart.CanCollide = false
		PrimaryPart.CanQuery = false
		PrimaryPart.CanTouch = false
		PrimaryPart.Massless = true
		PrimaryPart.CastShadow = false
		PrimaryPart.EnableFluidForces = false
		PrimaryPart.Transparency = 1
		PrimaryPart.Size = Vector3.new(1, 1, Magnitude)
		PrimaryPart.CFrame = CFrame.lookAt((v2 + v3) / 2, v3)
		PrimaryPart.Parent = Model
		Model.PrimaryPart = PrimaryPart
		sum = sum + Magnitude
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

	for j = 1, 5 do
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

	for v6, v7 in t4 do
		local Attachment = Instance.new("Attachment")

		Attachment.Name = v7.Part0.Name .. "AxisAttachment"
		Attachment.CFrame = v7.C0
		Attachment.Parent = v7.Part0

		local Attachment2 = Instance.new("Attachment")

		Attachment2.Name = v7.Part0.Name .. "JointAttachment"
		Attachment2.CFrame = v7.C1
		Attachment2.Parent = v7.Part1
	end

	local PrimaryPart = t[6].PrimaryPart
	local Target = Instance.new("Attachment")

	Target.Name = "Target"
	Target.CFrame = CFrame.new(0, 0, -PrimaryPart.Size.Z / 2)
	Target.Parent = PrimaryPart

	for v8, v9 in t do
		v9.PrimaryPart.Anchored = false
	end

	for v10, v11 in t3 do
		local v12 = t[v10]

		task.spawn(function() --[[ Line: 333 | Upvalues: FollowPath (ref), v11 (copy), v12 (copy) ]]
			FollowPath(v11.SegStart, v11.SegEnd, v12)
		end)
	end

	return t, t4, sum, VineGroup
end

local function createVine(p1, p2) --[[ createVine | Line: 342 | Upvalues: LocalPlayer (copy), Networking (copy), FollowSplinePath (copy), Players (copy), CCDIKController (copy), UserInputService (copy), Raycast (copy), RunService (copy), TweenService (copy) ]]
	local Character = p1.Character

	if not Character then
		return
	end

	local v1 = nil

	for v2, v3 in Character:GetChildren() do
		if v3:IsA("Tool") and (v3:HasTag("VineWrapper") or (v3:GetAttribute("VineWrapper") or v3.Name == "Vine Wrapper")) then
			v1 = v3

			break
		end
	end

	if not v1 then
		return
	end

	local Handle = v1:FindFirstChild("Handle")

	if not (Handle and Handle:FindFirstChild("VineEmitter")) then
		return
	end

	local v4 = game.SoundService.SFX["Vine Cast"]:Clone()

	v4.Parent = v1.Handle
	v4:Play()
	game.Debris:AddItem(v4, 3)

	local VineEmitter = v1.Handle.VineEmitter

	if p1 == LocalPlayer then
		Networking.VineWrapper.Activate:Fire(p2)
	end

	local v5, v6, v7, v8 = FollowSplinePath(VineEmitter.Position, p2, VineEmitter)
	local v9 = nil

	if p1 == LocalPlayer then
		local v10 = OverlapParams.new()

		v10.FilterDescendantsInstances = game.CollectionService:GetTagged("Character")
		v10.FilterType = Enum.RaycastFilterType.Whitelist

		local v11 = workspace:GetPartBoundsInRadius(p2, 12, v10)

		if #v11 > 0 then
			for v12, v13 in v11 do
				if v13.Parent ~= Character and (v13.Parent and v13.Parent:HasTag("Character")) then
					local v14 = Players:GetPlayerFromCharacter(v13.Parent)

					if not (v14 and (v14:GetAttribute("InSafeZone") or v14:GetAttribute("IsInOwnGarden"))) then
						v9 = v13.Parent

						break
					end
				end
			end
		end

		if v9 then
			Networking.VineWrapper.AssignTarget:Fire(v9, v7)
		end
	else
		local v15 = tick()

		repeat
			task.wait()
			v9 = v1.Target.Value
		until v9 or tick() - v15 > 2
	end

	local t = {}

	for v16, v17 in v6 do
		t[v17] = {
			ConstraintType = "BallSocketConstraint",
			UpperAngle = 35,
			TwistLimitsEnabled = false
		}
	end

	local v18 = CCDIKController.new(v6, t)

	v18.LerpMode = false
	v18.ConstantLerpSpeed = false
	v18.AngularSpeed = 12.566370614359172
	v18.UseLastMotor = false
	tick()

	local v19 = 0
	local v20 = if p1 == LocalPlayer then false else true
	local sum = 0

	v4:Stop()

	local v21 = game.SoundService.SFX.VineStrike:Clone()

	v21.Parent = v1.Handle
	v21:Play()
	game.Debris:AddItem(v21, 3)

	if v9 then
		game.Debris:AddItem(v21, 3)
		v22 = p2
		v23 = p2
		v24 = p2

		while sum < 7.5 and (v9 and (Character:FindFirstChild("HumanoidRootPart") and (v1 and (v1:IsDescendantOf(workspace) and v1:GetAttribute("Active") == true)))) do
			local v25 = game:GetService("RunService").Heartbeat:Wait()

			sum = sum + v25

			if p1 == LocalPlayer then
				local v26 = UserInputService:GetMouseLocation()
				local v27, _, v28 = Raycast(workspace.CurrentCamera:ViewportPointToRay(v26.X, v26.Y), true)

				if not v28 then
					v28 = Vector3.new(0, 0.3, 0)
				end

				local v29 = v27 + v28 * 8
				local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
				local v30 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("VineTarget") else HumanoidRootPart

				if v30 and v30:IsA("Attachment") then
					local Position = HumanoidRootPart.Position

					if v7 < (v29 - Position).Magnitude then
						v29 = Position + (v29 - Position).Unit * v7
					end

					local v31 = v24:Lerp(v29, 1 - math.exp(-18 * v25))

					v30.WorldCFrame = CFrame.new(v31, Position)
					v24 = v31
				end
			end

			if v9 and v9:FindFirstChild("HumanoidRootPart") then
				v23 = v9.HumanoidRootPart.Position
			end

			if v20 then
				local v32 = tick()

				if v32 - v19 >= 0.03333333333333333 then
					if (v23 - v22).Magnitude ^ 2 > 0.01 or v19 == 0 then
						v18:CCDIKIterateOnce(v23, 0, v32 - v19)
						v22 = v23
					end

					v19 = v32
				else
					continue
				end
			else
				v18:CCDIKIterateUntil(v23, 0.5, 3, v25)
				v22 = v23
			end
		end
	elseif p1 == LocalPlayer then
		local v33 = tick()

		while tick() - v33 < 0.3 and (v1 and (v1:IsDescendantOf(workspace) and v1:GetAttribute("Active") == true)) do
			RunService.Heartbeat:Wait()
		end
	end

	v1:SetAttribute("Active", false)

	local Attachment = Instance.new("Attachment")

	Attachment.Position = v8:GetPivot().Position

	local v34 = game.SoundService.SFX.VineCrumble:Clone()

	v34.Parent = Attachment
	v34:Play()
	Attachment.Parent = workspace.Terrain
	game.Debris:AddItem(Attachment, 3)

	for v35, v36 in v5 do
		v36.PrimaryPart.Anchored = true
		task.spawn(function() --[[ Line: 544 | Upvalues: v36 (copy), TweenService (ref) ]]
			for v1, v2 in v36:GetChildren() do
				if v2 ~= v36.PrimaryPart then
					if v2:IsA("MeshPart") then
						TweenService:Create(v2, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
							Size = Vector3.new(0, 0, 0),
							CFrame = CFrame.new(v2.Position, v2.Position + Random.new():NextUnitVector())
						}):Play()
						TweenService:Create(v2.SurfaceAppearance, TweenInfo.new(0.2), {
							Color = Color3.fromRGB(71, 35, 14)
						}):Play()
					elseif v2:IsA("BasePart") then
						TweenService:Create(v2, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
							Size = Vector3.new(0, 0, 0)
						}):Play()
					end

					task.wait(0.005)
				end
			end

			task.delay(0.2, function() --[[ Line: 565 | Upvalues: v36 (ref) ]]
				v36:Destroy()
			end)
		end)
	end

	for v37, v38 in v6 do
		v38:Destroy()
	end

	game.Debris:AddItem(v8, 5)
end

local WeldGlow_Player_Vine = game.MaterialService.ToolMaterials.GlowWeldTemplate:Clone()

WeldGlow_Player_Vine.Name = "WeldGlow_Player_Vine"
WeldGlow_Player_Vine.Parent = game.MaterialService.ToolMaterials

local function newVineWrapper(p1) --[[ newVineWrapper | Line: 585 | Upvalues: LocalPlayer (copy), UserInputService (copy), Raycast (copy), ReplicatedStorage (copy), WeldGlow_Player_Vine (copy), createVine (copy) ]]
	if p1.Parent ~= LocalPlayer.Backpack and p1.Parent ~= LocalPlayer.Character then
		return
	end

	local v1 = false
	local v2 = 0

	local function toolEquipped() --[[ toolEquipped | Line: 596 | Upvalues: v1 (ref), p1 (copy) ]]
		v1 = true

		for v12, v2 in p1.Handle.Vines:GetChildren() do
			v2.MaterialVariant = "WeldGlow_Player_Vine"
		end
	end

	local function toolUnequipped() --[[ toolUnequipped | Line: 605 | Upvalues: v1 (ref) ]]
		v1 = false
	end

	local function activated() --[[ activated | Line: 611 | Upvalues: UserInputService (ref), v2 (ref), p1 (copy), LocalPlayer (ref), Raycast (ref), ReplicatedStorage (ref), WeldGlow_Player_Vine (ref), createVine (ref) ]]
		local v1 = UserInputService:GetMouseLocation()
		local v22 = workspace.CurrentCamera:ViewportPointToRay(v1.X, v1.Y)

		if tick() - v2 < 2 then
			return
		end

		if p1:GetAttribute("Active") == true then
			return
		end

		local v3 = p1:GetAttribute("CooldownUntil")

		if v3 and workspace:GetServerTimeNow() < v3 then
			return
		end

		if LocalPlayer.Character and LocalPlayer.Character:GetAttribute("VineWrapped") then
			return
		end

		v2 = tick()
		p1:SetAttribute("Active", true)

		local v4, v5, _ = Raycast(v22)
		local v6 = true
		local v7

		if p1:IsDescendantOf(LocalPlayer.Character) then
			local v8 = LocalPlayer.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.Animations.VinewrapperSlam)

			v8.Priority = Enum.AnimationPriority.Action
			v8:Play(0.5, 1, 1)
			game.TweenService:Create(WeldGlow_Player_Vine, TweenInfo.new(1), {
				EmissiveStrength = 2
			}):Play()
			v7 = v8

			for v9, v10 in p1.Handle.VineEmitterAttachment:GetChildren() do
				v10.Enabled = true
			end

			task.spawn(function() --[[ Line: 665 | Upvalues: v6 (ref), WeldGlow_Player_Vine (ref), p1 (ref) ]]
				while v6 do
					task.wait(0.1)

					local Part = Instance.new("Part")

					Part.Size = Vector3.new(0.2, 0.2, 0.2)
					Part.Color = ({ Color3.fromRGB(162, 227, 51), Color3.fromRGB(56, 158, 40), Color3.fromRGB(45, 141, 52) })[Random.new():NextInteger(1, 3)]
					Part.Parent = workspace.Temporary
					Part.Anchored = true
					Part.CanCollide = false
					Part.CanTouch = false
					Part.CanQuery = false
					Part.MaterialVariant = WeldGlow_Player_Vine.Name
					game.TweenService:Create(Part, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
						Size = Vector3.new(0.4, 0.4, 0.4)
					}):Play()

					local v1 = 0.8 / #p1.DetailEffect:GetChildren()
					local v2 = nil

					task.spawn(function() --[[ Line: 691 | Upvalues: p1 (ref), v2 (ref), v1 (copy), Part (copy) ]]
						for i = 1, #p1.DetailEffect:GetChildren() do
							local v12 = p1.DetailEffect:FindFirstChild((tostring(i)))

							if v2 == nil then
								v2 = v12

								continue
							end

							local sum = 0

							while sum < v1 do
								sum = sum + game:GetService("RunService").Heartbeat:Wait()
								Part.CFrame = v2.CFrame:Lerp(v12.CFrame, sum / v1)
							end

							v2 = v12
						end

						Part:Destroy()
					end)
				end
			end)

			local v11 = ClientTrapCharacter(LocalPlayer.Character, game.ReplicatedStorage.Assets.VineArmTemplate)

			v8:GetMarkerReachedSignal("SlamDown"):Wait()
			v8:AdjustSpeed(0)
			game.TweenService:Create(WeldGlow_Player_Vine, TweenInfo.new(1), {
				EmissiveStrength = 1
			}):Play()

			for v12, v13 in p1.Handle.VineEmitterAttachment:GetChildren() do
				v13:Emit(v13:GetAttribute("EmitCount"))
			end

			task.spawn(function() --[[ Line: 725 | Upvalues: LocalPlayer (ref), v6 (ref), WeldGlow_Player_Vine (ref), v11 (copy), p1 (ref) ]]
				local v1 = LocalPlayer.Character.Torso:WaitForChild("Left Shoulder")
				local v2 = LocalPlayer.Character.Torso:WaitForChild("Right Shoulder")
				local C0 = v1.C0
				local C02 = v2.C0
				local sum = 0

				while v6 do
					sum = sum + task.wait(0)

					local v3 = math.sin(sum * 4) * 0.03490658503988659
					local v4 = math.cos(sum * 4) * 0.03490658503988659
					local v5 = (math.sin(sum * 20) * 0.6 + math.sin(sum * 20 * 1.4) * 0.4) * 0.03490658503988659

					v2.C0 = C02 * CFrame.Angles(v3 + v5, 0, v4 + v5)
					v1.C0 = C0 * CFrame.Angles(v3 + v5, 0, -(v4 + v5))
				end

				game.TweenService:Create(WeldGlow_Player_Vine, TweenInfo.new(1), {
					EmissiveStrength = 0
				}):Play()
				v11()

				for v62, v7 in p1.Handle.VineEmitterAttachment:GetChildren() do
					v7.Enabled = false
					v7:Emit(v7:GetAttribute("EmitCount"))
				end

				v1.C0 = C0
				v2.C0 = C02
			end)
		else
			v7 = nil
		end

		if v4 then
			if v5 then
				local _2
				local v14 = v5:FindFirstAncestorOfClass("Model")

				while true do
					if not v14 or v14 == workspace then
						createVine(LocalPlayer, v4)
						v7:AdjustSpeed(-1)
						_2 = false
						p1:SetAttribute("Active", false)

						return
					end

					if v14:HasTag("Character") and v14 ~= LocalPlayer.Character then
						break
					end

					v14 = v14.Parent and v14.Parent:FindFirstAncestorOfClass("Model")
				end

				local HumanoidRootPart = v14:FindFirstChild("HumanoidRootPart")

				if HumanoidRootPart then
					v4 = HumanoidRootPart.Position
				end
			end

			createVine(LocalPlayer, v4)
			v7:AdjustSpeed(-1)
		end

		p1:SetAttribute("Active", false)
	end

	local function syncCooldownVisual() --[[ syncCooldownVisual | Line: 800 | Upvalues: p1 (copy) ]]
		local v1 = p1:GetAttribute("CooldownUntil")

		if typeof(v1) == "number" then
			local v3 = math.max(0, v1 - workspace:GetServerTimeNow())

			p1:SetAttribute("CooldownEnd", os.clock() + v3)
		end
	end

	p1:GetAttributeChangedSignal("CooldownUntil"):Connect(syncCooldownVisual)
	syncCooldownVisual()
	p1.Activated:Connect(activated)
	p1.Unequipped:Connect(toolUnequipped)
	p1.Equipped:Connect(toolEquipped)
end

game.CollectionService:GetInstanceAddedSignal("VineWrapper"):Connect(newVineWrapper)

local t = {}

for v2, v3 in game.CollectionService:GetTagged("VineWrapper") do
	newVineWrapper(v3)
end

Networking.VineWrapper.SendVisual.OnClientEvent:Connect(function(p1, p2) --[[ Line: 823 | Upvalues: createVine (copy) ]]
	createVine(p1, p2)
end)

local VineWrapperAssets = ReplicatedStorage.Assets:WaitForChild("VineWrapperAssets")
local VineTemplate = VineWrapperAssets:WaitForChild("VineTemplate")
local Flower = VineWrapperAssets:WaitForChild("Flower")
local t2 = {
	{
		Name = "Left Leg",
		Wait = 0
	},
	{
		Name = "Right Leg",
		Wait = 0.05
	},
	{
		Name = "Torso",
		Wait = 0.1
	},
	{
		Name = "Left Arm",
		Wait = 0.18
	},
	{
		Name = "Right Arm",
		Wait = 0.2
	}
}
local t3 = {
	Color3.fromRGB(255, 180, 200),
	Color3.fromRGB(255, 230, 130),
	Color3.fromRGB(200, 160, 255),
	Color3.fromRGB(255, 120, 100),
	Color3.fromRGB(180, 220, 255)
}
local t4 = {}

local function Weld(p1, p2) --[[ Weld | Line: 854 ]]
	local WeldConstraint = Instance.new("WeldConstraint")

	WeldConstraint.Part0 = p2
	WeldConstraint.Part1 = p1
	WeldConstraint.Parent = p1
end

local function HushPart(p1) --[[ HushPart | Line: 862 ]]
	p1.CanCollide = false
	p1.CanQuery = false
	p1.CanTouch = false
	p1.Massless = true
	p1.CastShadow = false
	p1.EnableFluidForces = false
end

local function GrowLimb(p1, p2, p3) --[[ GrowLimb | Line: 872 | Upvalues: TweenService (copy), Flower (copy), t3 (copy) ]]
	local v1 = p3.CFrame
	local t = {}

	for v2, v3 in p1:GetDescendants() do
		if v3:IsA("BasePart") and v3 ~= p3 then
			t[v3] = {
				Offset = v1:ToObjectSpace(v3.CFrame),
				TargetSize = v3.Size
			}
		end
	end

	for v4, v5 in t do
		v4.CFrame = p2.CFrame * v5.Offset
		v4.Size = Vector3.new(0.01, 0.01, 0.01)
		v4.Transparency = 1
		v4.Anchored = false
		v4.CanCollide = false
		v4.CanQuery = false
		v4.CanTouch = false
		v4.Massless = true
		v4.CastShadow = false
		v4.EnableFluidForces = false

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = p2
		WeldConstraint.Part1 = v4
		WeldConstraint.Parent = v4
	end

	p1.Parent = p2

	local t2 = {}

	for v6, v7 in t do
		local v9 = math.floor((v6.Position - p3.Position).Magnitude / 0.5)

		t2[v9] = t2[v9] or {}
		table.insert(t2[v9], v6)
	end

	local t4 = {}

	for v12 in t2 do
		table.insert(t4, v12)
	end

	table.sort(t4)

	local sum = 0

	for v13, v14 in t4 do
		local v15 = t2[v14]

		task.delay(sum, function() --[[ Line: 909 | Upvalues: v15 (copy), t (copy), TweenService (ref), Flower (ref), t3 (ref), p1 (copy) ]]
			for v1, v2 in v15 do
				if v2.Parent then
					local v3 = t[v2]

					if v3 then
						v2.Transparency = 0
						TweenService:Create(v2, TweenInfo.new(0.04), {
							Size = v3.TargetSize
						}):Play()
						task.spawn(function() --[[ Line: 916 | Upvalues: v2 (copy), Flower (ref), t3 (ref), p1 (ref), TweenService (ref) ]]
							local Sprout = v2:FindFirstChild("Sprout")

							if not (Sprout and Sprout:IsA("Attachment")) then
								return
							end

							local v1 = Flower:Clone()

							if v1:FindFirstChild("Petals") and v1:FindFirstChild("Base") then
								local v22 = t3[Random.new():NextInteger(1, #t3)]

								for v3, v4 in v1.Petals:GetChildren() do
									v4.Color = v22
								end

								v1.Parent = p1
								v1:PivotTo(Sprout.WorldCFrame)

								for v5, v6 in v1:GetDescendants() do
									if v6:IsA("BasePart") then
										v6.CanCollide = false
										v6.CanQuery = false
										v6.CanTouch = false
										v6.Massless = true
										v6.CastShadow = false
										v6.EnableFluidForces = false
									end
								end

								local Weld = Instance.new("Weld")

								Weld.Part0 = Sprout.Parent
								Weld.Part1 = v1.Base
								Weld.C0 = Sprout.Parent.CFrame:ToObjectSpace(v1.Base.CFrame)
								Weld.C1 = CFrame.new()
								Weld.Parent = v1.Base
								v1:ScaleTo(0.01)

								local v7 = Random.new():NextNumber(0.6, 1.1)

								for v8, v9 in v1:GetDescendants() do
									if v9:IsA("BasePart") then
										local _ = v9.Size * (v7 / 0.01)

										TweenService:Create(v9, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
											Size = v9.Size * v7 * 100
										}):Play()
									end
								end

								task.delay(0.5, function() --[[ Line: 960 | Upvalues: v1 (copy) ]]
									for v12, v2 in v1.Base:GetChildren() do
										if v2:IsA("Motor6D") then
											v2.DesiredAngle = 0.7853981633974483

											if v2.Name == "Reverse" then
												v2.DesiredAngle = v2.DesiredAngle * -1
											end

											v2.MaxVelocity = 0.03
										end
									end
								end)
							else
								v1:Destroy()
							end
						end)
						task.wait(0.01)
					end
				end
			end
		end)
		sum = sum + 0.02
	end
end

function ClientTrapCharacter(p1, p2) --[[ ClientTrapCharacter | Line: 980 | Upvalues: VineTemplate (copy), t2 (copy), GrowLimb (copy), TweenService (copy) ]]
	local Vines = (if p2 then p2 else VineTemplate):Clone()

	Vines.Name = "Vines"

	local t = {}

	for v2, v3 in t2 do
		local v4 = Vines:FindFirstChild(v3.Name)
		local v5 = p1:FindFirstChild(v3.Name)

		if v4 and v5 then
			local v6 = nil

			for v7, v8 in v4:GetChildren() do
				if v8:IsA("BasePart") and v8.Name == v3.Name then
					v6 = v8

					break
				end
			end

			if v6 then
				local Model = v4:FindFirstChild("Model")

				if Model then
					task.delay(v3.Wait, function() --[[ Line: 1005 | Upvalues: p1 (copy), v5 (copy), GrowLimb (ref), Model (copy), v6 (ref) ]]
						if p1.Parent and v5.Parent then
							GrowLimb(Model, v5, v6)
						end
					end)
					v6:Destroy()
					table.insert(t, Model)
				end
			end
		end
	end

	return function() --[[ Destroy | Line: 1014 | Upvalues: t (copy), TweenService (ref) ]]
		for v1, v2 in t do
			game.Debris:AddItem(v2, 1)

			local v3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local v4 = Color3.fromRGB(71, 35, 14)

			for v5, v6 in v2:GetChildren() do
				if v6:IsA("BasePart") then
					TweenService:Create(v6, v3, {
						Size = Vector3.new(0, 0, 0),
						Color = v4
					}):Play()

					continue
				end

				if v6:IsA("Model") then
					for v7, v8 in v6:GetDescendants() do
						if v8:IsA("BasePart") then
							TweenService:Create(v8, v3, {
								Size = Vector3.new(0, 0, 0),
								Color = v4
							}):Play()
						end
					end
				end
			end
		end
	end
end
Networking.VineWrapper.WrapCharacter.OnClientEvent:Connect(function(p1) --[[ Line: 1037 | Upvalues: t4 (copy) ]]
	if not (p1 and p1:IsDescendantOf(workspace)) then
		return
	end

	if t4[p1] then
		pcall(t4[p1])
		t4[p1] = nil
	end

	t4[p1] = ClientTrapCharacter(p1)
end)
Networking.VineWrapper.UnwrapCharacter.OnClientEvent:Connect(function(p1) --[[ Line: 1047 | Upvalues: t4 (copy) ]]
	if not p1 then
		return
	end

	local v1 = t4[p1]

	if not v1 then
		return
	end

	t4[p1] = nil
	pcall(v1)
end)
t.WrapCharacter = ClientTrapCharacter

return t