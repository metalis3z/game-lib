
local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local FADE_TIME = 0.5

local Net = require(ReplicatedStorage.Packages.Net)

local InvisibilityEvent = Net:RemoteEvent("Tools/CupidsWings/Invisibility")

local ToolAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("CupidsWings")
local FlyAnim = ToolAssets:WaitForChild("FlyAnim")
local WingsRigTemplate = ToolAssets:WaitForChild("WingsRig")

local WingsWooshStart = ToolAssets:WaitForChild("WingsWooshStart")
local WingsWooshEnd = ToolAssets:WaitForChild("WingsWooshEnd")
local WingsIdleMagicSound = ToolAssets:WaitForChild("WingsIdleMagicSound")
local WingsIdleSound = ToolAssets:WaitForChild("WingsIdleSound")
local WingsEquipSound = ToolAssets:WaitForChild("WingsEquipSound")
local WingsUnequipSound = ToolAssets:WaitForChild("WingsUnequipSound")

WingsIdleMagicSound.Looped = true
WingsIdleSound.Looped = true

local Player = nil
local Character = nil
local Humanoid = nil
local RootPart = nil

local Flying = false
local ToolEquipped = false
local IsInvisible = false
local FlyTrack = nil

local FlightSpin, FlightPower, FlightHold
local WingsRigClone = nil 

local INVISIBILITY_DURATION = 15
local INVISIBILITY_COOLDOWN = 60

local function SetToolTransparency(transparency)
	local canCollide = (transparency == 0)
	for _, part in ipairs(Tool:GetDescendants()) do
		if part:IsA("BasePart") then
			local lowerName = string.lower(part.Name)

			if transparency == 0 then
				if lowerName:find("root") or lowerName:find("hitbox") or lowerName:find("bounding") or lowerName:find("aura") or lowerName:find("hearts") then
					part.Transparency = 1
				else
					part.Transparency = 0
				end
			else
				part.Transparency = 1
			end

			part.CanCollide = false 
			part.CanQuery = canCollide
		elseif part:IsA("Decal") or part:IsA("Texture") then
			part.Transparency = transparency
		end
	end
end

local function ClearBackWeld()
	if WingsRigClone then
		WingsRigClone:Destroy()
		WingsRigClone = nil
	end

	if not IsInvisible then
		SetToolTransparency(0)
	end
end

local function AttachToBack()
	if not Character or not Humanoid then return end
	ClearBackWeld()

	local TargetPart = Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Torso")
	if not TargetPart then return end

	local oldAutoRotate = Humanoid.AutoRotate
	Humanoid.AutoRotate = false

	SetToolTransparency(1)

	WingsRigClone = WingsRigTemplate:Clone()
	WingsRigClone.Name = "WingsRigClone"

	for _, child in ipairs(WingsRigClone:GetDescendants()) do
		if child:IsA("BasePart") then
			child.Massless = true
			child.CanCollide = false
			child.CanTouch = false
			child.CanQuery = false
			child.Anchored = false
			child.CastShadow = false 

			local lowerName = string.lower(child.Name)
			if lowerName:find("root") or lowerName:find("hitbox") or lowerName:find("bounding") or lowerName:find("aura") or lowerName:find("hearts") then
				child.Transparency = 1
			end
		elseif child:IsA("Sound") or child:IsA("Script") or child:IsA("LocalScript") then
			child:Destroy()
		end
	end

	WingsRigClone.Parent = Character

	local Offset = CFrame.new(0, -3.9, 0) * CFrame.Angles(0, math.rad(180), 0)

	local rigRoot = WingsRigClone.PrimaryPart or WingsRigClone:FindFirstChild("Root") or WingsRigClone:FindFirstChildWhichIsA("BasePart")

	if rigRoot then
		rigRoot.Transparency = 1

		local BackWeld = Instance.new("Weld")
		BackWeld.Name = "CupidBackWeld"
		BackWeld.Part0 = TargetPart
		BackWeld.Part1 = rigRoot
		BackWeld.C0 = Offset
		BackWeld.Parent = rigRoot
	end

	task.wait(0.1)
	if Humanoid then Humanoid.AutoRotate = oldAutoRotate end
end

local function SetInvisibility(state)
	if not Character then return end
	IsInvisible = state

	if state then
		WingsWooshStart:Play()
	else
		WingsWooshEnd:Play()   
	end

	local tweenInfo = TweenInfo.new(FADE_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

	for _, obj in pairs(Character:GetDescendants()) do
		if (obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart") or obj:IsA("Decal") or obj:IsA("Texture") then
			local targetTrans = 0
			if state then
				obj:SetAttribute("PrevTrans", obj.Transparency)
				targetTrans = 1
			else
				targetTrans = obj:GetAttribute("PrevTrans") or 0
			end

			local tween = TweenService:Create(obj, tweenInfo, {Transparency = targetTrans})
			tween:Play()

		elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Light") then
			if state then
				obj:SetAttribute("PrevEnabled", obj.Enabled)
				obj.Enabled = false
			else
				if obj:GetAttribute("PrevEnabled") ~= nil then
					obj.Enabled = obj:GetAttribute("PrevEnabled")
				end
			end
		end
	end
end

InvisibilityEvent.OnServerEvent:Connect(function(plr)
	if plr ~= Player or not ToolEquipped or IsInvisible then return end
	local currentCooldown = Tool:GetAttribute("CooldownTime") or 0
	if currentCooldown > 0 then return end

	SetInvisibility(true)

	task.spawn(function()
		task.wait(INVISIBILITY_DURATION)
		if ToolEquipped and IsInvisible then
			SetInvisibility(false)
		end
	end)

	task.spawn(function()
		local cooldown = INVISIBILITY_COOLDOWN
		while cooldown > 0 do
			Tool:SetAttribute("CooldownTime", cooldown)
			task.wait(0.1)
			cooldown = cooldown - 0.1
		end
		Tool:SetAttribute("CooldownTime", 0)
	end)
end)

local function CleanUpBodyMovers()
	for _, v in pairs({FlightSpin, FlightPower, FlightHold}) do
		if v and v.Parent then v:Destroy() end
	end
end

local function Activated()
	if not Tool.Enabled or not Character or not Humanoid then return end

	Tool.Enabled = false
	Flying = not Flying

	if Flying then
		AttachToBack()

		WingsIdleMagicSound:Play()

		Tool:SetAttribute("SpeedModifier", 0)
		Tool:SetAttribute("JumpModifier", 0)
		CleanUpBodyMovers()

		FlightSpin = Instance.new("BodyGyro")
		FlightSpin.Name = "FlightSpin"
		FlightSpin.P = 10000
		FlightSpin.MaxTorque = Vector3.new(1, 1, 1) * 1000000
		FlightSpin.CFrame = RootPart.CFrame

		FlightPower = Instance.new("BodyVelocity")
		FlightPower.Name = "FlightPower"
		FlightPower.Velocity = Vector3.new(0, 0, 0)
		FlightPower.MaxForce = Vector3.new(1, 1, 1) * 1000000
		FlightPower.P = 1000

		FlightHold = Instance.new("BodyPosition")
		FlightHold.Name = "FlightHold"
		FlightHold.P = 100000
		FlightHold.MaxForce = Vector3.new(0, 0, 0)
		FlightHold.Position = RootPart.Position

		FlightSpin.Parent = RootPart
		FlightPower.Parent = RootPart
		FlightHold.Parent = RootPart

		local animator = Humanoid:FindFirstChildOfClass("Animator")
		if animator and FlyAnim then
			FlyTrack = animator:LoadAnimation(FlyAnim)
			FlyTrack.Priority = Enum.AnimationPriority.Action4 
			FlyTrack:Play(0.2)
		end
	else
		ClearBackWeld()
		CleanUpBodyMovers()

		WingsIdleMagicSound:Stop()

		Tool:SetAttribute("SpeedModifier", 1)
		Tool:SetAttribute("JumpModifier", 1)

		if FlyTrack then
			FlyTrack:Stop(0.2)
			FlyTrack:Destroy()
			FlyTrack = nil
		end

		if Humanoid then
			Humanoid.PlatformStand = false
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
		if RootPart then
			RootPart.Velocity = Vector3.zero
			RootPart.RotVelocity = Vector3.zero
		end
	end

	task.wait(0.25)
	Tool.Enabled = true
end

local function Equipped()
	Character = Tool.Parent
	Player = Players:GetPlayerFromCharacter(Character)
	Humanoid = Character:FindFirstChild("Humanoid")
	RootPart = Character:FindFirstChild("HumanoidRootPart")

	ToolEquipped = true
	Tool.Enabled = true

	WingsIdleSound:Play()
	WingsEquipSound:Play()

	ClearBackWeld()
	SetToolTransparency(0) 
	Tool:SetAttribute("CooldownTime", Tool:GetAttribute("CooldownTime") or 0)
end

local function Unequipped()
	Flying = false
	ToolEquipped = false

	WingsIdleSound:Stop()
	WingsIdleMagicSound:Stop()
	WingsUnequipSound:Play()

	ClearBackWeld()
	CleanUpBodyMovers()

	if Humanoid then
		Humanoid.PlatformStand = false
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end

	Tool:SetAttribute("SpeedModifier", 1)
	Tool:SetAttribute("JumpModifier", 1)

	if FlyTrack then
		FlyTrack:Stop()
		FlyTrack:Destroy()
		FlyTrack = nil
	end

	if IsInvisible then
		SetInvisibility(false)
	end
end

Tool.Activated:Connect(Activated)
Tool.Equipped:Connect(Equipped)
Tool.Unequipped:Connect(Unequipped)