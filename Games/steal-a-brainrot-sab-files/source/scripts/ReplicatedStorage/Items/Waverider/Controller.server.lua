local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Net = require(ReplicatedStorage.Packages.Net)

local Tool = script.Parent

local Player = nil
local Character = nil
local Humanoid = nil
local HumanoidRootPart = nil
local ToolEquipped = false

local FlightSpin = nil
local FlightPower = nil
local FlightHold = nil
local RigClone = nil
local RigBone = nil

local DiedConnection = nil
local MovementConnection = nil

local IsMoving = false
local IsBoosting = false
local Initialized = false
local TrailRightSnapshot = nil

local WaveriderAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("Waverider")
local RigTemplate = WaveriderAssets:WaitForChild("WaveriderRig")

local DEFAULT_SPEED_MULTIPLIER = 1.65
local BOOST_SPEED_MULTIPLIER = 1.9
local BOOST_DURATION = 10
local BOOST_COOLDOWN = 30

local function SetToolTransparency(transparency)
	for _, Part in ipairs(Tool:GetDescendants()) do
		if Part:IsA("BasePart") or Part:IsA("Decal") or Part:IsA("Texture") then
			Part.Transparency = transparency
		end
	end
end

local function setInstanceEnabled(instance, enabled)
	if instance:IsA("ParticleEmitter") or instance:IsA("Beam") then
		instance.Enabled = enabled
	end
end

local function getBoostMovingTargets(bone)
	local targets = {}
	local Boosting = bone:FindFirstChild("Boosting")
	if not Boosting then
		return targets
	end

	local RearAnchor = Boosting:FindFirstChild("RearAnchor")
	if RearAnchor then
		local Rotate = RearAnchor:FindFirstChild("Rotate")
		if Rotate then
			local ThurstMain = Rotate:FindFirstChild("ThurstMain")
			if ThurstMain then
				table.insert(targets, ThurstMain)
			end

			local Water = Rotate:FindFirstChild("Water")
			if Water then
				table.insert(targets, Water)
			end

			local Main = Rotate:FindFirstChild("Main")
			if Main then
				table.insert(targets, Main)
			end

			local RotateAttachment = Rotate:FindFirstChild("Attachment")
			if RotateAttachment then
				local Droplets1 = RotateAttachment:FindFirstChild("Droplets1")
				if Droplets1 then
					table.insert(targets, Droplets1)
				end

				local Droplets2 = RotateAttachment:FindFirstChild("Droplets2")
				if Droplets2 then
					table.insert(targets, Droplets2)
				end
			end
		end
	end

	local WaterTip = Boosting:FindFirstChild("WaterTip")
	if WaterTip then
		local End = WaterTip:FindFirstChild("End")
		if End then
			local Main = End:FindFirstChild("Main")
			if Main then
				table.insert(targets, Main)
			end
		end
	end

	return targets
end

local function handleMovingAttachment(bone, moving)
	local movingAttach = bone:FindFirstChild("Moving")
	if not movingAttach then
		return
	end
	for _, descendant in ipairs(movingAttach:GetDescendants()) do
		setInstanceEnabled(descendant, moving)
	end
end

local function handleBoostingAttachment(bone, boosting, moving)
	local boostingAttach = bone:FindFirstChild("Boosting")
	if not boostingAttach then
		return
	end

	local shouldEnable = boosting and moving

	for _, descendant in ipairs(boostingAttach:GetDescendants()) do
		setInstanceEnabled(descendant, false)
	end

	if shouldEnable then
		for _, target in ipairs(getBoostMovingTargets(bone)) do
			setInstanceEnabled(target, true)
		end
	end
end

local function handleEmitAttachment(bone)
	local emitAttach = bone:FindFirstChild("Emit")
	if not emitAttach then
		return
	end

	for _, descendant in ipairs(emitAttach:GetDescendants()) do
		if descendant:IsA("ParticleEmitter") then
			descendant.Enabled = true
			descendant:Emit(50)
		end
	end

	task.delay(1, function()
		for _, descendant in ipairs(emitAttach:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") then
				descendant.Enabled = false
			end
		end
	end)
end

local function captureTrailRightState(bone)
	local snapshot = {}
	local trailRight = bone:FindFirstChild("TrailRight")
	if not trailRight then
		return snapshot
	end

	for _, descendant in ipairs(trailRight:GetDescendants()) do
		if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
			snapshot[descendant] = descendant.Enabled
		end
	end

	return snapshot
end

local function setTrailRightDisabled(bone)
	local trailRight = bone:FindFirstChild("TrailRight")
	if not trailRight then
		return
	end

	for _, descendant in ipairs(trailRight:GetDescendants()) do
		setInstanceEnabled(descendant, false)
	end
end

local function restoreTrailRightState(snapshot)
	if not snapshot then
		return
	end

	for instance, wasEnabled in pairs(snapshot) do
		if instance and instance.Parent then
			setInstanceEnabled(instance, wasEnabled)
		end
	end
end

local function ApplyVisualState()
	if not RigBone then
		return
	end

	local boostAndMoving = IsBoosting and IsMoving

	if boostAndMoving then
		handleMovingAttachment(RigBone, false)
		handleBoostingAttachment(RigBone, true, true)
	else
		handleBoostingAttachment(RigBone, false, false)
		handleMovingAttachment(RigBone, IsMoving)
	end
end

local function ResetRigVisuals(bone)
	if not bone then
		return
	end

	handleMovingAttachment(bone, false)
	handleBoostingAttachment(bone, false, false)

	local emitAttach = bone:FindFirstChild("Emit")
	if emitAttach then
		for _, descendant in ipairs(emitAttach:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") then
				descendant.Enabled = false
			end
		end
	end
end

local function StartMovementTracking()
	if MovementConnection then
		MovementConnection:Disconnect()
	end

	IsMoving = false
	Initialized = false

	MovementConnection = RunService.Heartbeat:Connect(function()
		if not (RigClone and RigClone.Parent and HumanoidRootPart and HumanoidRootPart.Parent) then
			return
		end

		local Velocity = HumanoidRootPart.AssemblyLinearVelocity
		local HorizontalSpeed = Vector3.new(Velocity.X, 0, Velocity.Z).Magnitude
		local isMovingNow = HorizontalSpeed > 5

		if not Initialized or isMovingNow ~= IsMoving then
			Initialized = true
			IsMoving = isMovingNow
			ApplyVisualState()
		end
	end)
end

local function StopMovementTracking()
	if MovementConnection then
		MovementConnection:Disconnect()
		MovementConnection = nil
	end
	IsMoving = false
	Initialized = false
end

local function CleanUpBodyMovers()
	for _, Mover in pairs({ FlightSpin, FlightPower, FlightHold }) do
		if Mover and Mover.Parent then
			Mover:Destroy()
		end
	end
	FlightSpin = nil
	FlightPower = nil
	FlightHold = nil
end

local function DetachRig()
	if RigClone then
		RigClone:Destroy()
		RigClone = nil
	end
	RigBone = nil
end

local function AttachRig()
	DetachRig()
	if not Character or not HumanoidRootPart then
		return
	end

	if not Humanoid or Humanoid.Health <= 0 then
		return
	end

	RigClone = RigTemplate:Clone()
	RigClone.Name = "WaveriderRig"

	for _, Child in ipairs(RigClone:GetDescendants()) do
		if Child:IsA("BasePart") then
			Child.Massless = true
			Child.CanCollide = false
			Child.CanTouch = false
			Child.CanQuery = false
			Child.Anchored = false
			Child.CastShadow = false
		elseif Child:IsA("Script") or Child:IsA("LocalScript") then
			Child:Destroy()
		end
	end

	local Cube = RigClone:FindFirstChild("Cube")
	if not Cube then
		RigClone:Destroy()
		RigClone = nil
		return
	end

	local C0 = CFrame.new(-0.0160000008, -3.05599999, 0.815999985, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	local C1 = CFrame.new(0, -6, 0)

	Cube.CFrame = HumanoidRootPart.CFrame * C0 * C1:Inverse()
	RigClone.Parent = Character

	local RigWeld = Instance.new("Weld")
	RigWeld.Name = "Weld"
	RigWeld.Part0 = Cube
	RigWeld.Part1 = HumanoidRootPart
	RigWeld.C0 = C0
	RigWeld.C1 = C1
	RigWeld.Parent = Cube

	CollectionService:AddTag(RigClone, "WaveriderRig")

	RigBone = Cube:FindFirstChild("Bone")
	IsBoosting = false
	TrailRightSnapshot = nil
	ResetRigVisuals(RigBone)
	StartMovementTracking()
end

local function StartFlight()
	if not HumanoidRootPart then
		return
	end

	if not Humanoid or Humanoid.Health <= 0 then
		return
	end

	CleanUpBodyMovers()

	FlightSpin = Instance.new("BodyGyro")
	FlightSpin.Name = "FlightSpin"
	FlightSpin.P = 10000
	FlightSpin.D = 500
	FlightSpin.MaxTorque = Vector3.new(1, 1, 1) * 1000000
	FlightSpin.CFrame = HumanoidRootPart.CFrame

	FlightPower = Instance.new("BodyVelocity")
	FlightPower.Name = "FlightPower"
	FlightPower.Velocity = Vector3.new(0, 0, 0)
	FlightPower.MaxForce = Vector3.new(1, 1, 1) * 1000000
	FlightPower.P = 1000

	FlightHold = Instance.new("BodyPosition")
	FlightHold.Name = "FlightHold"
	FlightHold.P = 100000
	FlightHold.D = 1250
	FlightHold.MaxForce = Vector3.new(0, 0, 0)
	FlightHold.Position = HumanoidRootPart.Position

	FlightSpin.Parent = HumanoidRootPart
	FlightPower.Parent = HumanoidRootPart
	FlightHold.Parent = HumanoidRootPart
end

local function StopFlight()
	CleanUpBodyMovers()
	StopMovementTracking()

	if RigClone then
		RigClone:SetAttribute("BoostActive", false)
	end

	IsBoosting = false
	TrailRightSnapshot = nil

	DetachRig()
	SetToolTransparency(0)
	Tool:SetAttribute("Boosting", false)
	Tool:SetAttribute("SpeedMultiplier", DEFAULT_SPEED_MULTIPLIER)

	if Humanoid and Humanoid.Parent and Humanoid.Health > 0 then
		Humanoid.WalkSpeed = 32
		Humanoid.PlatformStand = false
		Humanoid.AutoRotate = true
		Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
	end

	if HumanoidRootPart and HumanoidRootPart.Parent then
		HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
	end
end

local function OnHumanoidDied()
	StopFlight()
end

local BoostEvent = Net:RemoteEvent("Tools/Waverider/Boost")
BoostEvent.OnServerEvent:Connect(function(Plr)
	if Plr ~= Player then
		return
	end
	if not ToolEquipped then
		return
	end
	if not Humanoid or Humanoid.Health <= 0 then
		return
	end
	if not RigClone then
		return
	end

	local Cooldown = tonumber(Tool:GetAttribute("CooldownTime") or 0) or 0
	if Cooldown > 0 then
		return
	end
	if Tool:GetAttribute("Boosting") == true then
		return
	end

	Tool:SetAttribute("Boosting", true)
	RigClone:SetAttribute("BoostBeams", true)
	RigClone:SetAttribute("BoostActive", true)

	IsBoosting = true
	if RigBone then
		handleEmitAttachment(RigBone)
		TrailRightSnapshot = captureTrailRightState(RigBone)
		setTrailRightDisabled(RigBone)
	end
	ApplyVisualState()

	task.spawn(function()
		task.wait(2)
		if RigClone then
			RigClone:SetAttribute("BoostBeams", false)
		end
	end)
	Tool:SetAttribute("SpeedMultiplier", BOOST_SPEED_MULTIPLIER)

	local ThisRig = RigClone
	task.spawn(function()
		task.wait(BOOST_DURATION)
		Tool:SetAttribute("Boosting", false)
		Tool:SetAttribute("SpeedMultiplier", DEFAULT_SPEED_MULTIPLIER)

		if ThisRig and ThisRig.Parent then
			ThisRig:SetAttribute("BoostActive", false)
		end

		if RigClone == ThisRig then
			IsBoosting = false
			if RigBone then
				restoreTrailRightState(TrailRightSnapshot)
			end
			TrailRightSnapshot = nil
			ApplyVisualState()
		end
	end)

	task.spawn(function()
		local Remaining = BOOST_COOLDOWN
		while Remaining > 0 do
			Tool:SetAttribute("CooldownTime", Remaining)
			task.wait(0.1)
			Remaining -= 0.1
		end
		Tool:SetAttribute("CooldownTime", 0)
	end)
end)

local ActivateEvent = Net:RemoteEvent("Tools/Waverider/Activate")
ActivateEvent.OnServerEvent:Connect(function(Plr)
	if Plr ~= Player then
		return
	end
	if not ToolEquipped then
		return
	end
	if not Humanoid or Humanoid.Health <= 0 then
		return
	end
	AttachRig()
	StartFlight()
	SetToolTransparency(1)
end)

local DeactivateEvent = Net:RemoteEvent("Tools/Waverider/Deactivate")
DeactivateEvent.OnServerEvent:Connect(function(Plr)
	if Plr ~= Player then
		return
	end
	StopFlight()
end)

local function Equipped()
	Character = Tool.Parent
	Player = Players:GetPlayerFromCharacter(Character)
	if not Player then
		return
	end
	Humanoid = Character:FindFirstChildOfClass("Humanoid")
	HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not Humanoid or Humanoid.Health <= 0 then
		return
	end

	ToolEquipped = true
	Tool:SetAttribute("SpeedMultiplier", DEFAULT_SPEED_MULTIPLIER)
	Tool:SetAttribute("Boosting", false)
	Tool:SetAttribute("CooldownTime", 0)

	if DiedConnection then
		DiedConnection:Disconnect()
	end
	DiedConnection = Humanoid.Died:Connect(OnHumanoidDied)
end

local function Unequipped()
	ToolEquipped = false
	Tool:SetAttribute("Boosting", false)
	Tool:SetAttribute("SpeedMultiplier", DEFAULT_SPEED_MULTIPLIER)
	StopFlight()

	if DiedConnection then
		DiedConnection:Disconnect()
		DiedConnection = nil
	end

	Player = nil
	Character = nil
	Humanoid = nil
	HumanoidRootPart = nil
end

Tool.Equipped:Connect(Equipped)
Tool.Unequipped:Connect(Unequipped)