-- MADE BY LOXY:3
local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local Net = require(ReplicatedStorage.Packages.Net)

local BoostEvent = Net:RemoteEvent("Tools/Waverider/Boost")

local ToolAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("Waverider")
local WaveriderRigTemplate = ToolAssets:WaitForChild("WaveriderRig")

local EquipSound = ToolAssets:WaitForChild("EquipSound")
local UnequipSound = ToolAssets:WaitForChild("UnequipSound")
local IdleSound = ToolAssets:WaitForChild("IdleSound")
local MovingSound = ToolAssets:WaitForChild("MovingSound")
local BoostSound = ToolAssets:WaitForChild("BoostSound")

IdleSound.Looped = true
MovingSound.Looped = true

local Player = nil
local Character = nil
local Humanoid = nil
local RootPart = nil

local Flying = false
local ToolEquipped = false
local Boosting = false

local FlightSpin, FlightPower, FlightHold
local WaveriderRigClone = nil

local BOOST_DURATION = 3
local BOOST_COOLDOWN = 30
local BOOST_SPEED_MULTIPLIER = 2
local BASE_SPEED_MULTIPLIER = 1.65

local function CleanUpBodyMovers()
	for _, v in pairs({FlightSpin, FlightPower, FlightHold}) do
		if v and v.Parent then
			v.Parent = nil
		end
	end
	FlightSpin = nil
	FlightPower = nil
	FlightHold = nil
end

local function ClearRig()
	if WaveriderRigClone then
		CollectionService:RemoveTag(WaveriderRigClone, "WaveriderRig")
		WaveriderRigClone:Destroy()
		WaveriderRigClone = nil
	end
end

local function AttachRig()
	if not Character or not Humanoid then return end
	ClearRig()

	local TargetPart = Character:FindFirstChild("HumanoidRootPart")
	if not TargetPart then return end

	WaveriderRigClone = WaveriderRigTemplate:Clone()
	WaveriderRigClone.Name = "WaveriderRigClone"

	for _, child in ipairs(WaveriderRigClone:GetDescendants()) do
		if child:IsA("BasePart") then
			child.Massless = true
			child.CanCollide = false
			child.CanTouch = false
			child.CanQuery = false
			child.Anchored = false
			child.CastShadow = false
		elseif child:IsA("Sound") or child:IsA("Script") or child:IsA("LocalScript") then
			child:Destroy()
		end
	end

	WaveriderRigClone.Parent = Character

	local rigRoot = WaveriderRigClone.PrimaryPart or WaveriderRigClone:FindFirstChildWhichIsA("BasePart")

	if rigRoot then
		local BackWeld = Instance.new("Weld")
		BackWeld.Name = "WaveriderWeld"
		BackWeld.Part0 = TargetPart
		BackWeld.Part1 = rigRoot
		BackWeld.C0 = CFrame.new(0, -2, 1.5) * CFrame.Angles(0, math.rad(180), 0)
		BackWeld.Parent = rigRoot
	end

	CollectionService:AddTag(WaveriderRigClone, "WaveriderRig")
end

local function StartFlying()
	if not Character or not Humanoid or not RootPart then return end

	Flying = true
	AttachRig()

	Tool:SetAttribute("SpeedMultiplier", BASE_SPEED_MULTIPLIER)
	Tool:SetAttribute("Boosting", false)

	CleanUpBodyMovers()

	FlightSpin = Instance.new("BodyGyro")
	FlightSpin.Name = "FlightSpin"
	FlightSpin.P = 10000
	FlightSpin.MaxTorque = Vector3.new(1, 1, 1) * 1000000
	FlightSpin.CFrame = RootPart.CFrame

	FlightPower = Instance.new("BodyVelocity")
	FlightPower.Name = "FlightPower"
	FlightPower.Velocity = Vector3.new(0, 0, 0)
	FlightPower.MaxForce = Vector3.new(0, 0, 0)
	FlightPower.P = 1000

	FlightHold = Instance.new("BodyPosition")
	FlightHold.Name = "FlightHold"
	FlightHold.P = 100000
	FlightHold.MaxForce = Vector3.new(FlightHold.P, FlightHold.P, FlightHold.P)
	FlightHold.Position = RootPart.Position

	FlightSpin.Parent = RootPart
	FlightPower.Parent = RootPart
	FlightHold.Parent = RootPart

	IdleSound:Play()
end

local function StopFlying()
	Flying = false
	Boosting = false

	ClearRig()
	CleanUpBodyMovers()

	IdleSound:Stop()
	MovingSound:Stop()

	Tool:SetAttribute("SpeedMultiplier", BASE_SPEED_MULTIPLIER)
	Tool:SetAttribute("Boosting", false)

	if Humanoid then
		Humanoid.PlatformStand = false
		Humanoid.AutoRotate = true
		Humanoid.WalkSpeed = 16
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end

	if RootPart then
		RootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		RootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
	end
end

BoostEvent.OnServerEvent:Connect(function(plr)
	if plr ~= Player or not ToolEquipped or not Flying or Boosting then return end
	local currentCooldown = Tool:GetAttribute("CooldownTime") or 0
	if currentCooldown > 0 then return end

	Boosting = true
	Tool:SetAttribute("Boosting", true)
	Tool:SetAttribute("SpeedMultiplier", BOOST_SPEED_MULTIPLIER)

	if WaveriderRigClone then
		WaveriderRigClone:SetAttribute("BoostBeams", true)
	end

	BoostSound:Play()

	task.spawn(function()
		task.wait(BOOST_DURATION)
		if ToolEquipped and Boosting then
			Boosting = false
			Tool:SetAttribute("Boosting", false)
			Tool:SetAttribute("SpeedMultiplier", BASE_SPEED_MULTIPLIER)

			if WaveriderRigClone then
				WaveriderRigClone:SetAttribute("BoostBeams", false)
			end
		end
	end)

	task.spawn(function()
		local cooldown = BOOST_COOLDOWN
		while cooldown > 0 do
			Tool:SetAttribute("CooldownTime", cooldown)
			task.wait(0.1)
			cooldown = cooldown - 0.1
		end
		Tool:SetAttribute("CooldownTime", 0)
	end)
end)

local function Activated()
	if not Tool.Enabled or not Character or not Humanoid then return end

	Tool.Enabled = false

	if Flying then
		StopFlying()
	else
		StartFlying()
	end

	task.wait(0.25)
	Tool.Enabled = true
end

local function Equipped()
	Character = Tool.Parent
	Player = Players:GetPlayerFromCharacter(Character)
	Humanoid = Character:FindFirstChildOfClass("Humanoid")
	RootPart = Character:FindFirstChild("HumanoidRootPart")

	if not Humanoid or not RootPart then return end

	ToolEquipped = true
	Tool.Enabled = true

	EquipSound:Play()

	Tool:SetAttribute("SpeedMultiplier", BASE_SPEED_MULTIPLIER)
	Tool:SetAttribute("Boosting", false)
	Tool:SetAttribute("CooldownTime", Tool:GetAttribute("CooldownTime") or 0)
end

local function Unequipped()
	ToolEquipped = false

	if Flying then
		StopFlying()
	end

	UnequipSound:Play()

	ClearRig()
	CleanUpBodyMovers()

	if Humanoid then
		Humanoid.PlatformStand = false
		Humanoid.AutoRotate = true
		Humanoid.WalkSpeed = 16
	end

	Tool:SetAttribute("SpeedMultiplier", BASE_SPEED_MULTIPLIER)
	Tool:SetAttribute("Boosting", false)
end

Tool.Activated:Connect(Activated)
Tool.Equipped:Connect(Equipped)
Tool.Unequipped:Connect(Unequipped)