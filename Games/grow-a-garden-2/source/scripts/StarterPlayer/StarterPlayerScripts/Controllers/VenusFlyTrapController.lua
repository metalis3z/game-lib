--credit to leon games studio
local Players = game:GetService("Players")

game:GetService("CollectionService")
game:GetService("RunService")
game:GetService("TweenService")

local t = {}
local CCDIKController = require(script.CCDIKController)
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local RagdollModule = require(game.ReplicatedStorage.ClientModules.RagdollModule)

local function lerp(p1, p2, p3) --[[ lerp | Line: 14 ]]
	return p1 + (p2 - p1) * p3
end

local function weldFruitToPlant(p1, p2) --[[ weldFruitToPlant | Line: 18 ]]
	local v1 = p2.PlantModel and (p2.PlantModel.Base and p2.PlantModel.Base:FindFirstChild("PLAYER_POINT"))

	if not v1 then
		return
	end

	if p1:IsA("Model") then
		local PrimaryPart = p1.PrimaryPart

		if not PrimaryPart then
			return
		end

		for v2, v3 in p1:GetDescendants() do
			if v3:IsA("BasePart") and v3.Name ~= "HarvestPart" then
				v3.Anchored = false
				v3.CanCollide = false

				if v3 ~= PrimaryPart then
					local WeldConstraint = Instance.new("WeldConstraint")

					WeldConstraint.Part0 = PrimaryPart
					WeldConstraint.Part1 = v3
					WeldConstraint.Parent = v3
				end
			end
		end

		p1:PivotTo(v1.CFrame)

		local AttachWeld = Instance.new("WeldConstraint")

		AttachWeld.Part0 = PrimaryPart
		AttachWeld.Part1 = v1
		AttachWeld.Parent = PrimaryPart
		AttachWeld.Name = "AttachWeld"
	else
		if not p1:IsA("BasePart") then
			return
		end

		p1.Anchored = false
		p1.CanCollide = false
		p1.CFrame = v1.CFrame

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = p1
		WeldConstraint.Part1 = v1
		WeldConstraint.Parent = p1
	end
end

local function IsNightTime() --[[ IsNightTime | Line: 68 ]]
	local Night = game.ReplicatedStorage:FindFirstChild("Night")

	if not (Night and Night:IsA("BoolValue")) then
		return false
	end

	return Night.Value == true
end

local function findTarget(p1) --[[ findTarget | Line: 75 | Upvalues: Players (copy) ]]
	if p1:GetAttribute("Decaying") then
		return
	end

	local Night = game.ReplicatedStorage:FindFirstChild("Night")

	if not (if Night and Night:IsA("BoolValue") then if Night.Value == true then true else false else false) then
		return
	end

	local v2 = p1:GetAttribute("UserId")
	local v3 = nil
	local v4 = nil

	for v5, v6 in Players:GetPlayers() do
		if v2 ~= v6.UserId and v6.Character then
			local Magnitude = (v6.Character:GetPivot().Position - p1.Base.Position).Magnitude

			if Magnitude < 40 and (not v3 or Magnitude < v3) then
				v4 = v6.Character
				v3 = Magnitude
			end
		end
	end

	if v4 then
		return v4.HumanoidRootPart
	end
end

local function v1(p1, p2) --[[ connectParts | Line: 119 | Upvalues: v1 (copy) ]]
	local v12 = p2 or ""

	for v2, v3 in p1 do
		local v4 = p1[v2 + 1]

		if v3 and v4 then
			local Motor6D = Instance.new("Motor6D")

			Motor6D.Name = v3.Name .. v12
			Motor6D.Part0 = v3
			Motor6D.Part1 = v4
			Motor6D.C0 = CFrame.new(0, v3.Size.Y / 2, 0)
			Motor6D.C1 = v4.CFrame:Inverse() * (v3.CFrame * Motor6D.C0)
			Motor6D.Parent = v3
		end

		for v6, v7 in v3:GetChildren() do
			if v7.Name == "Reference" then
				for v8, v9 in v7.Value:GetDescendants() do
					if v9:IsA("BasePart") then
						local WeldConstraint = Instance.new("WeldConstraint")

						WeldConstraint.Part0 = v9
						WeldConstraint.Part1 = v3
						WeldConstraint.Parent = v9
					end
				end

				continue
			end

			if v7.Name == "LeafStemReference" then
				local t = {}
				local EndJoint = nil

				for v10, v11 in v7.Value:GetChildren() do
					if v11:IsA("BasePart") then
						if v11.Name == "EndJoint" then
							EndJoint = v11

							continue
						end

						t[tonumber(v11.Name)] = v11
					end
				end

				local v13 = nil

				for i = 1, #t do
					if t[i] ~= nil then
						v13 = i

						break
					end
				end

				local t2 = { table.unpack(t, v13) }

				table.insert(t2, EndJoint)
				v1(t2, v7.Name)

				local Motor6D = Instance.new("Motor6D")

				Motor6D.Name = "Root_" .. v7.Name
				EndJoint.Name = "EndJoint"
				Motor6D.Part0 = v3
				Motor6D.Part1 = t2[1]
				Motor6D.C0 = CFrame.new(0, v3.Size.Y / 2, 0)
				Motor6D.C1 = t2[1].CFrame:Inverse() * (v3.CFrame * Motor6D.C0)
				Motor6D.Parent = v3
			end
		end
	end
end

local function getDesiredAgeUpdateHz() --[[ getDesiredAgeUpdateHz | Line: 197 ]]
	local ok, result = pcall(function() --[[ Line: 198 ]]
		return UserSettings().GameSettings
	end)

	if not (ok and result) then
		return 30
	end

	local SavedQualityLevel = result.SavedQualityLevel
	local v1 = nil

	if typeof(SavedQualityLevel) == "EnumItem" then
		v1 = SavedQualityLevel.Value
	elseif type(SavedQualityLevel) == "number" then
		v1 = SavedQualityLevel
	end

	if type(v1) ~= "number" then
		return 50
	end

	if v1 == 0 then
		return 30
	end

	if v1 >= 7 then
		return 60
	end

	if v1 >= 4 then
		return 25
	end

	return 30
end

local function hzToTick(p1) --[[ hzToTick | Line: 219 ]]
	if p1 <= 0 then
		return 0.02
	end

	return 1 / math.clamp(p1, 15, 60)
end

local function groupArmJoints(p1, p2) --[[ groupArmJoints | Line: 224 | Upvalues: CCDIKController (copy) ]]
	local t = {}

	for v1, v2 in p2:GetChildren() do
		local Motor6D = v2:FindFirstChildOfClass("Motor6D")

		if Motor6D then
			t[tonumber(v2.Name)] = Motor6D
		end
	end

	local v4 = nil

	for i = 1, #t do
		if t[i] ~= nil then
			v4 = i

			break
		end
	end

	local t2 = { table.unpack(t, v4) }
	local v5 = p2.EndJoint.CFrame
	local Attachment = Instance.new("Attachment")

	Attachment.Parent = p1.RotationHandler
	Attachment.WorldCFrame = v5

	return {
		bend = CCDIKController.new(t2),
		Attachment = Attachment,
		joints = t2,
		startingCF = Attachment.Position,
		maxRange = (v5.Position - (t2[1].C0 * t2[1].Part0.CFrame).Position).Magnitude * 0.9
	}
end

local function addStemBallSockets(p1, p2) --[[ addStemBallSockets | Line: 256 ]]
	local t = {}

	for v1, v2 in p1 do
		if p2[v1] then
			local v3 = v2.CFrame * CFrame.new(0, v2.Size.Y / 2, 0)
			local Attachment = Instance.new("Attachment")

			Attachment.Name = v2.Name .. "AxisAttachment"
			Attachment.Parent = v2
			Attachment.WorldCFrame = v3 * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)

			local v4 = p1[v1 + 1]

			if v4 then
				local Attachment2 = Instance.new("Attachment")

				Attachment2.Name = v2.Name .. "JointAttachment"
				Attachment2.Parent = v4
				Attachment2.WorldCFrame = v3 * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)

				local BallSocketConstraint = Instance.new("BallSocketConstraint")

				BallSocketConstraint.Name = v2.Name .. "BallSocket"
				BallSocketConstraint.LimitsEnabled = true
				BallSocketConstraint.UpperAngle = 90
				BallSocketConstraint.Attachment0 = Attachment
				BallSocketConstraint.Attachment1 = Attachment2
				BallSocketConstraint.Parent = v2
				table.insert(t, BallSocketConstraint)
			end
		end
	end

	return t
end

local function ProcessBite(p1) --[[ ProcessBite | Line: 306 | Upvalues: RagdollModule (copy), Networking (copy) ]]
	RagdollModule:Ragdoll(game.Players.LocalPlayer.Character, 2)
	Networking.FlytrapService.Chomp:Fire(p1)
end

local function Attack(p1) --[[ Attack | Line: 313 | Upvalues: Players (copy), RagdollModule (copy), Networking (copy) ]]
	local v1 = CFrame.new(0, 0, -1) * p1.Offsets.CenterOffset
	local v2 = CFrame.new(0, 0, -15)
	local t = {}
	local sum = 0

	for v3, v4 in p1.Model.PlantModel:GetDescendants() do
		if v4:IsA("BasePart") then
			t[v4] = v4.CanCollide
			v4.CanCollide = false
		end
	end

	local v5 = true

	while sum < 0.3 do
		sum = sum + game:GetService("RunService").Heartbeat:Wait()

		local v6 = game.TweenService:GetValue(sum / 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)

		p1.CenterOffset = p1.Offsets.CenterOffset:Lerp(v1, v6)
		p1.TopOffset = p1.Offsets.TopOffset:Lerp(v2, v6)

		local v7 = 0.7 * v6

		p1.Model.PlantModel.Rig.Base.TopJaw.DesiredAngle = v7
		p1.Model.PlantModel.Rig.Base.BottomJaw.DesiredAngle = -v7
	end

	task.spawn(function() --[[ Line: 354 | Upvalues: p1 (copy), v5 (ref), Players (ref), RagdollModule (ref), Networking (ref) ]]
		local _, _2 = p1.Model.PlantModel.Rig:GetBoundingBox()
		local t = {}
		local v1

		repeat
			if not v5 then
				break
			end

			t = v1
			task.wait(0)

			local v2, v3 = p1.Model.PlantModel.Rig:GetBoundingBox()
			local v4 = OverlapParams.new()

			v4.FilterDescendantsInstances = { Players.LocalPlayer.Character }
			v4.FilterType = Enum.RaycastFilterType.Include
			v1 = workspace:GetPartBoundsInBox(v2, v3 * 0.7, v4)
		until #v1 > 0

		if not (#t > 0) then
			p1.Model.PlantModel.Rig.Base.BiteMiss:Play()

			return
		end

		p1.Model.PlantModel.Rig.Base.Chomp:Play()

		for v52, v6 in p1.Model.PlantModel.Rig.Base.Attachment:GetChildren() do
			v6:Emit(v6:GetAttribute("EmitCount") or 3)
		end

		RagdollModule:Ragdoll(game.Players.LocalPlayer.Character, 2)
		Networking.FlytrapService.Chomp:Fire(p1.Owner)
	end)
	task.wait(0.1)

	local sum2 = 0

	while sum2 < 0.1 do
		sum2 = sum2 + game:GetService("RunService").Heartbeat:Wait()

		local v8 = -0.7 + 0.85 * game.TweenService:GetValue(sum2 / 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		p1.Model.PlantModel.Rig.Base.TopJaw.DesiredAngle = v8
		p1.Model.PlantModel.Rig.Base.BottomJaw.DesiredAngle = -v8
	end

	local t2 = {}

	for v9, v10 in p1.RestPoses do
		t2[v9] = {
			C0 = v9.C0,
			C1 = v9.C1
		}
	end

	task.delay(1, function() --[[ Line: 422 | Upvalues: t (copy) ]]
		for v1, v2 in t do
			v1.CanCollide = v2
		end
	end)

	local sum3 = 0

	while sum3 < 2 do
		sum3 = sum3 + game:GetService("RunService").Heartbeat:Wait()

		local v11 = game.TweenService:GetValue(sum3 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

		p1.CenterOffset = v1:Lerp(p1.Offsets.CenterOffset, v11)
		p1.TopOffset = v2:Lerp(p1.Offsets.TopOffset, v11)

		local v12 = -0.15 * v11

		p1.Model.PlantModel.Rig.Base.TopJaw.DesiredAngle = v12
		p1.Model.PlantModel.Rig.Base.BottomJaw.DesiredAngle = -v12
	end
end

local function setupFlyTrap(p1) --[[ setupFlyTrap | Line: 445 | Upvalues: v1 (copy), addStemBallSockets (copy), weldFruitToPlant (copy), groupArmJoints (copy), t (copy) ]]
	local t2 = {}

	if not p1:HasTag("InitializationComplete") then
		repeat
			task.wait()
		until p1:HasTag("InitializationComplete")
	end

	for i = 1, 8 do
		if p1:FindFirstChild((tostring(i))) then
			table.insert(t2, p1:FindFirstChild((tostring(i))))
		end
	end

	v1(t2)

	local HeadWeld = Instance.new("Motor6D")

	HeadWeld.Part0 = t2[#t2]
	HeadWeld.Part1 = p1.PlantModel.Rig.RootPart
	HeadWeld.C0 = CFrame.new(0, t2[#t2].Size.Y / 2, 0)
	HeadWeld.Name = "HeadWeld"
	HeadWeld.C1 = p1.PlantModel.Rig.RootPart.CFrame:Inverse() * (t2[#t2].CFrame * HeadWeld.C0)
	HeadWeld.Parent = t2[#t2]

	for v2, v3 in p1.PlantModel:GetChildren() do
		if v3:IsA("Model") and v3.Name ~= "Rig" then
			local v4 = p1.PlantModel.Rig[v3.Name]

			for v5, v6 in v3:GetDescendants() do
				if v6:IsA("BasePart") then
					local WeldConstraint = Instance.new("WeldConstraint")

					WeldConstraint.Part0 = v6
					WeldConstraint.Part1 = v4
					WeldConstraint.Parent = v6
				end
			end
		end
	end

	local Fruit_Spawn = p1.FruitSpawnLocations:FindFirstChild("Fruit_Spawn")
	local WeldConstraint = Instance.new("WeldConstraint")

	WeldConstraint.Part0 = Fruit_Spawn
	WeldConstraint.Part1 = p1.PlantModel.Rig.Base
	WeldConstraint.Parent = Fruit_Spawn

	local Root = Instance.new("Motor6D")

	Root.Part0 = p1.Base
	Root.Part1 = t2[1]
	Root.Name = "Root"
	Root.C0 = CFrame.new(0, p1.Base.Size.Y / 2, 0)
	Root.C1 = t2[1].CFrame:Inverse() * (p1.Base.CFrame * Root.C0)
	Root.Parent = p1.Base

	local t3 = {}

	for v7, v8 in t2 do
		local v9 = v8:FindFirstChild(v8.Name)

		if not v9 then
			v9 = v8:FindFirstChildOfClass("Motor6D")
		end

		table.insert(t3, v9)
	end

	p1.PlantModel.Rig.RootPart:FindFirstChildOfClass("Motor6D")
	addStemBallSockets(t2, t3)

	local t4 = {}
	local t5 = {}

	for v10, v11 in t3 do
		if v11 then
			t4[v11] = v11.C0
			t5[v11] = v11.C1
		end
	end

	local Fruits = p1:FindFirstChild("Fruits")

	if Fruits then
		for v12, v13 in Fruits:GetChildren() do
			weldFruitToPlant(v13, p1)
		end

		Fruits.ChildAdded:Connect(function(p12) --[[ Line: 541 | Upvalues: p1 (copy), weldFruitToPlant (ref) ]]
			task.defer(function() --[[ Line: 542 | Upvalues: p12 (copy), p1 (ref), weldFruitToPlant (ref) ]]
				if not (p12 and (p12.Parent and (p1 and p1.Parent))) then
					return
				end

				weldFruitToPlant(p12, p1)
			end)
		end)
	end

	for v14, v15 in p1:GetDescendants() do
		if v15:IsA("BasePart") and (v15.Name ~= "Base" and v15.Name ~= "HarvestPart") then
			v15.Anchored = false
		end
	end

	local v16 = script.AnimationController:Clone()

	v16.Parent = p1

	local RotationHandler = p1.Base:Clone()

	RotationHandler:ClearAllChildren()
	RotationHandler.Name = "RotationHandler"
	RotationHandler.Anchored = true
	RotationHandler.Parent = p1

	local t6 = { groupArmJoints(p1, p1.Leaf1), (groupArmJoints(p1, p1.Leaf2)) }
	local Attachment = Instance.new("Attachment")

	Attachment.Parent = RotationHandler
	Attachment.WorldCFrame = t2[#t2 - 2].CFrame

	local Banana = Instance.new("Attachment")

	Banana.Parent = RotationHandler
	Banana.WorldCFrame = p1.PlantModel.Rig.IKJoint.CFrame
	Banana.Name = "Banana"

	local Center = v16.Center

	Center.EndEffector = t2[#t2 - 2]
	Center.ChainRoot = t2[2]
	Center.Target = Attachment
	Center.Enabled = true

	local Top = v16.Top

	Top.EndEffector = p1.PlantModel.Rig.IKJoint
	Top.ChainRoot = t2[#t2 - 2]
	Top.Target = Banana
	Top.Enabled = true

	local v17 = Random.new():NextInteger(1, 9999)
	local v18 = p1.Base.CFrame:ToObjectSpace(Attachment.WorldCFrame)
	local v19 = p1.Base.CFrame:ToObjectSpace(Banana.WorldCFrame)

	p1.PlantModel.Rig.Base.TopJaw.MaxVelocity = 0.15
	p1.PlantModel.Rig.Base.BottomJaw.MaxVelocity = 0.15
	tick()
	t[p1] = {
		CurrentTarget = nil,
		TargetLocked = false,
		LookTarget = nil,
		Model = p1,
		Offsets = {
			CenterOffset = v18 * CFrame.new(0, 2, 0),
			TopOffset = v19 * CFrame.new(0, 4, 0) * CFrame.Angles(0, 0, -0.7853981633974483)
		},
		RandomOffset = v17,
		CenterOffset = v18,
		TopOffset = v19,
		Base = RotationHandler,
		ArmJoints = t6,
		NextAttack = tick(),
		LastDecision = tick(),
		RestPoses = t4,
		Owner = game.Players:GetPlayerByUserId(p1:GetAttribute("UserId")),
		StartingPivot = RotationHandler.CFrame,
		Attachment1 = Attachment,
		Attachment2 = Banana
	}
end

game.CollectionService:GetInstanceAddedSignal("VenusFlyTrap"):Connect(setupFlyTrap)

for v2, v3 in game.CollectionService:GetTagged("VenusFlyTrap") do
	setupFlyTrap(v3)
end

task.spawn(function() --[[ Line: 658 | Upvalues: getDesiredAgeUpdateHz (copy), t (copy), findTarget (copy), Attack (copy) ]]
	while true do
		local v1 = task.wait
		local v2 = getDesiredAgeUpdateHz()
		local v4 = v1(if v2 <= 0 then 0.02 else 1 / math.clamp(v2, 15, 60))

		for v5, v6 in t do
			if v5:IsDescendantOf(workspace) then
				if tick() - v6.LastDecision > 1 then
					v6.LastDecision = tick()
					task.spawn(function() --[[ Line: 672 | Upvalues: v6 (copy), findTarget (ref), v5 (copy), Attack (ref) ]]
						if v6.CurrentTarget == nil or not v6.CurrentTarget:IsDescendantOf(workspace) then
							v6.CurrentTarget = findTarget(v5)

							if v6.CurrentTarget then
								v6.NextAttack = tick() + 2
							end
						end

						if not (v6.CurrentTarget and ((v6.CurrentTarget.Position - v5.Base.Position).Magnitude < 30 and tick() - v6.NextAttack > 0)) then
							return
						end

						v6.TargetLocked = true
						v6.NextAttack = tick() + 9
						Attack(v6)
						v6.TargetLocked = false
						v6.CurrentTarget = findTarget(v5)
					end)
				end

				v6.LookTarget = v6.CurrentTarget and v6.CurrentTarget.Position or v5.Base.CFrame * CFrame.new(0, 0, 8).Position

				local v10 = CFrame.new(0, math.sin((v6.RandomOffset + tick()) * 0.7), 0)
				local v11 = (v6.LookTarget - v6.Base.Position).Unit * Vector3.new(1, 0, 1)

				if not v6.TargetLocked then
					v6.LookTarget = v6.CurrentTarget and v6.CurrentTarget.Position or v5.Base.CFrame * CFrame.new(0, 0, 8).Position
				end

				local v15 = CFrame.Angles(math.rad(math.clamp(1 - (v6.LookTarget - v6.Base.Position).Magnitude / 25, 0, 1) * -20), 0, 0)
				local Position = v5.Base.Position

				v6.Base.CFrame = v6.Base.CFrame:Lerp(CFrame.new(Position, Position + v11) * v15, v4 * 2)
				v6.Attachment1.WorldCFrame = v6.Base.CFrame * v6.CenterOffset * v10
				v6.Attachment2.WorldCFrame = v6.Base.CFrame * v6.TopOffset * v10 * v15

				for v16, v17 in v6.ArmJoints do
					v17.Attachment.Position = v17.startingCF + Vector3.new(0, math.sin((v6.RandomOffset + tick()) * 1.2), (math.sin(4 + v6.RandomOffset + tick() * 1.2)))
					v17.bend:CCDIKIterateOnce(v17.Attachment.WorldPosition, 0, v4)
				end

				continue
			end

			t[v5] = nil
		end
	end
end)

return {}