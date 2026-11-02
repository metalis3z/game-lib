--credit to leon games studio
local Players = game:GetService("Players")

game:GetService("CollectionService")
game:GetService("RunService")
game:GetService("TweenService")

local t2 = {}

require(script.CCDIKController)
require(game.ReplicatedStorage.SharedModules.Networking)
require(game.ReplicatedStorage.ClientModules.RagdollModule)

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
	if p1.Parent:GetAttribute("Decaying") then
		return
	end

	local Night = game.ReplicatedStorage:FindFirstChild("Night")

	if not (if Night and Night:IsA("BoolValue") then if Night.Value == true then true else false else false) then
		return
	end

	local v2 = p1.Parent:GetAttribute("UserId")
	local v3 = nil
	local v4 = nil

	for v5, v6 in Players:GetPlayers() do
		if v6.UserId ~= v2 and v6.Character then
			local Magnitude = ((v6.Character:GetPivot().Position - p1.BasePart.Position) * Vector3.new(1, 0, 1)).Magnitude

			if Magnitude < 30 and (not v3 or Magnitude < v3) then
				v4 = v6.Character
				v3 = Magnitude
			end
		end
	end

	if v4 then
		return v4.HumanoidRootPart
	end
end

local v1 = tick()
local FlameEffect = script.FlameEffect

FlameEffect.Parent = game.Lighting
FlameEffect.Enabled = false

local v2 = nil

local function handleDamage() --[[ handleDamage | Line: 130 | Upvalues: v1 (ref), v2 (ref), FlameEffect (copy) ]]
	if tick() - v1 < 1.5 then
		return
	end

	v1 = tick()

	local v12 = game.ReplicatedStorage.Assets.Vignette:Clone()

	v12.ImageLabel.ImageColor3 = Color3.fromRGB(255, 35, 35)
	v12.Parent = game.Players.LocalPlayer.PlayerGui
	v12.ImageLabel.ImageTransparency = 0.6

	if not v2 then
		FlameEffect.Brightness = 0.1
		FlameEffect.Saturation = 0.1
		FlameEffect.TintColor = Color3.fromRGB(255, 181, 97)
		v2 = game.TweenService:Create(FlameEffect, TweenInfo.new(0.5), {
			Brightness = 0,
			Saturation = 0,
			TintColor = Color3.fromRGB(255, 255, 255)
		})
		FlameEffect.Enabled = true
		v2:Play()
		game.TweenService:Create(v12.ImageLabel.UIScale, TweenInfo.new(0.5), {
			Scale = 1.06
		}):Play()
		game.TweenService:Create(v12.ImageLabel, TweenInfo.new(0.5), {
			ImageTransparency = 1
		}):Play()
		task.delay(0.5, function() --[[ Line: 158 | Upvalues: FlameEffect (ref) ]]
			FlameEffect.Enabled = false
		end)
		game.Debris:AddItem(v12, 0.5)

		return
	end

	v2:Cancel()
	FlameEffect.Brightness = 0.1
	FlameEffect.Saturation = 0.1
	FlameEffect.TintColor = Color3.fromRGB(255, 181, 97)
	v2 = game.TweenService:Create(FlameEffect, TweenInfo.new(0.5), {
		Brightness = 0,
		Saturation = 0,
		TintColor = Color3.fromRGB(255, 255, 255)
	})
	FlameEffect.Enabled = true
	v2:Play()
	game.TweenService:Create(v12.ImageLabel.UIScale, TweenInfo.new(0.5), {
		Scale = 1.06
	}):Play()
	game.TweenService:Create(v12.ImageLabel, TweenInfo.new(0.5), {
		ImageTransparency = 1
	}):Play()
	task.delay(0.5, function() --[[ Line: 158 | Upvalues: FlameEffect (ref) ]]
		FlameEffect.Enabled = false
	end)
	game.Debris:AddItem(v12, 0.5)
end

local function getDesiredAgeUpdateHz() --[[ getDesiredAgeUpdateHz | Line: 170 ]]
	local ok, result = pcall(function() --[[ Line: 171 ]]
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
		return 60
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

local function hzToTick(p1) --[[ hzToTick | Line: 194 ]]
	if p1 <= 0 then
		return 0.02
	end

	return 1 / math.clamp(p1, 15, 60)
end

local function addStemBallSockets(p1, p2) --[[ addStemBallSockets | Line: 200 ]]
	local t = {
		10,
		15,
		20,
		25,
		30,
		30,
		15,
		10
	}
	local t2 = {}

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
				BallSocketConstraint.UpperAngle = t[v1]
				BallSocketConstraint.Attachment0 = Attachment
				BallSocketConstraint.Attachment1 = Attachment2
				BallSocketConstraint.Parent = v2
				table.insert(t2, BallSocketConstraint)
			end
		end
	end

	return t2
end

local function setupFlyTrap(p1) --[[ setupFlyTrap | Line: 251 | Upvalues: addStemBallSockets (copy), t2 (copy) ]]
	local t = {}

	if not p1.Parent:HasTag("InitializationComplete") then
		repeat
			task.wait()
		until p1.Parent:HasTag("InitializationComplete")
	end

	for i, v in ipairs(p1.Spine:GetChildren()) do
		if v:FindFirstChild("Motor6D") then
			table.insert(t, v)
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 263 ]]
		local v2 = tonumber(p1.Name)

		return v2 < tonumber(p2.Name)
	end)

	local t3 = {}

	for v1, v2 in t do
		local v3 = v2:FindFirstChild(v2.Name)

		if not v3 then
			v3 = v2:FindFirstChildOfClass("Motor6D")
		end

		table.insert(t3, v3)
	end

	addStemBallSockets(t, t3)

	local t4 = {}
	local t5 = {}

	for v4, v5 in t3 do
		if v5 then
			t4[v5] = v5.C0
			t5[v5] = v5.C1
		end
	end

	for v6, v7 in p1:GetDescendants() do
		if v7:IsA("BasePart") and (v7.Name ~= "BasePart" and (v7.Name ~= "HarvestPart" and v7.Parent ~= p1.Base)) then
			v7.Anchored = false
		end
	end

	local AnimationController = p1.AnimationController
	local RotationHandler = p1.BasePart:Clone()

	RotationHandler.Name = "RotationHandler"
	RotationHandler.Anchored = true
	RotationHandler.Parent = p1

	local Target1 = RotationHandler.Target1
	local Target2 = RotationHandler.Target2
	local Center = AnimationController.Center

	Center.Target = Target1
	Center.Enabled = true

	local Top = AnimationController.Top

	Top.Target = Target2
	Top.Enabled = true

	local v8 = Random.new():NextInteger(1, 9999)
	local v9 = p1.BasePart.CFrame:ToObjectSpace(Target1.WorldCFrame)
	local v10 = p1.BasePart.CFrame:ToObjectSpace(Target2.WorldCFrame)

	t2[p1] = {
		CurrentTarget = nil,
		TargetLocked = false,
		LookTarget = nil,
		Model = p1,
		Offsets = {
			CenterOffset = v9 * CFrame.new(0, 2, 0),
			TopOffset = v10
		},
		RandomOffset = v8,
		CenterOffset = v9,
		TopOffset = v10,
		Base = RotationHandler,
		OriginalCF = p1:GetPivot(),
		NextAttack = tick(),
		LastDecision = tick(),
		RestPoses = t4,
		Owner = game.Players:GetPlayerByUserId(p1.Parent:GetAttribute("UserId")),
		StartingPivot = RotationHandler.CFrame,
		Attachment1 = Target1,
		Attachment2 = Target2,
		DragonBreathEnd = game.ReplicatedStorage.Assets.DragonBreathEnd:Clone(),
		PrimaryPart = RotationHandler
	}
end

game.CollectionService:GetInstanceAddedSignal("DragonBreath"):Connect(setupFlyTrap)

for v3, v4 in game.CollectionService:GetTagged("DragonBreath") do
	setupFlyTrap(v4)
end

task.spawn(function() --[[ Line: 379 | Upvalues: getDesiredAgeUpdateHz (copy), t2 (copy), findTarget (copy), Players (copy), handleDamage (copy) ]]
	while true do
		local v1 = task.wait
		local v2 = getDesiredAgeUpdateHz()
		local v4 = v1(if v2 <= 0 then 0.02 else 1 / math.clamp(v2, 15, 60))

		for v6, v7 in t2 do
			local v5

			if v6:IsDescendantOf(workspace) then
				if tick() - v7.LastDecision > 1 then
					v7.LastDecision = tick()
					v7.CurrentTarget = findTarget(v6)
				end

				if v7.CurrentTarget then
					v6.Head.Base.TopJaw.DesiredAngle = -0.2
					v6.Head.Base.BottomJaw.DesiredAngle = 0.5
					v7.DragonBreathEnd.Parent = workspace.Temporary

					if not v7.DragonBreathEnd:GetAttribute("Enabled") then
						v7.DragonBreathEnd:SetAttribute("Enabled", true)

						for v8, v9 in v7.DragonBreathEnd:GetDescendants() do
							if v9:IsA("ParticleEmitter") or v9:IsA("SurfaceGui") then
								v9.Enabled = true
							end
						end

						for v10, v11 in v6.Head.Base.Emitter:GetChildren() do
							if v11:IsA("Beam") then
								v11.Attachment1 = v7.DragonBreathEnd.Attachment
							end
						end

						for v12, v13 in v6.Head.Base.Emitter:GetChildren() do
							if v13:IsA("Beam") or v13:IsA("ParticleEmitter") then
								v13.Enabled = true
							end
						end
					end

					v6.Head.Base.Emitter.WorldCFrame = CFrame.new(v6.Head.Base.Emitter.WorldPosition, v7.CurrentTarget.Position)

					local v15 = v7.CurrentTarget.Position * Vector3.new(1, 0, 1) + Vector3.new(0, workspace.Baseplate.Center.Position.Y, 0)

					if not v7.LastPosition then
						v7.LastPosition = v15
					end

					v7.LastPosition = v7.LastPosition:Lerp(v15, v4 * 3)

					local v17 = v7.Owner:GetAttribute("PlotId")

					v5 = if v17 then workspace:WaitForChild("Gardens"):FindFirstChild("Plot" .. v17) else v6.Parent.Parent.Parent

					local v19 = RaycastParams.new()

					v19.FilterType = Enum.RaycastFilterType.Include
					v19.FilterDescendantsInstances = {
						v5.Visual,
						workspace.Baseplate,
						v7.CurrentTarget.Parent,
						game.Players.LocalPlayer.Character
					}

					local v20 = workspace:Raycast(v6.Head.Base.Emitter.WorldPosition, v7.LastPosition - v6.Head.Base.Emitter.WorldPosition, v19)

					if v20 and v20.Position then
						v7.DragonBreathEnd.CFrame = CFrame.new(v20.Position + Vector3.new(0, 0.1, 0))

						if v20.Instance:IsDescendantOf(game.Players.LocalPlayer.Character) or v20.Instance:IsDescendantOf(v7.CurrentTarget.Parent) then
							v7.DragonBreathEnd.SurfaceGui.Enabled = false
						else
							v7.DragonBreathEnd.SurfaceGui.Enabled = true
						end
					else
						v7.DragonBreathEnd.CFrame = CFrame.new(v7.LastPosition + Vector3.new(0, 0.1, 0))
						v7.DragonBreathEnd.SurfaceGui.Enabled = true
					end

					local v21 = OverlapParams.new()

					v21.FilterDescendantsInstances = { game.Players.LocalPlayer.Character }
					v21.FilterType = Enum.RaycastFilterType.Include

					if #workspace:GetPartBoundsInRadius(v7.DragonBreathEnd.Position, 2.2, v21) > 0 and v7.Owner ~= Players.LocalPlayer then
						handleDamage()
					end
				else
					if v7.DragonBreathEnd:GetAttribute("Enabled") then
						for v22, v23 in v7.DragonBreathEnd:GetDescendants() do
							if v23:IsA("ParticleEmitter") or v23:IsA("SurfaceGui") then
								v23.Enabled = false
							end
						end

						for v24, v25 in v6.Head.Base.Emitter:GetChildren() do
							if v25:IsA("Beam") or v25:IsA("ParticleEmitter") then
								v25.Enabled = false
							end
						end

						v7.DragonBreathEnd:SetAttribute("Enabled", false)
					end

					v6.Head.Base.TopJaw.DesiredAngle = 0
					v6.Head.Base.BottomJaw.DesiredAngle = 0
				end

				v7.Attachment1.WorldCFrame = v7.Base.CFrame * v7.CenterOffset
				v7.Attachment2.WorldCFrame = v7.Base.CFrame * v7.TopOffset

				continue
			end

			t2[v6] = nil
		end
	end
end)

return {}