-- Reference copy for study. Game: jujutsu-shenanigans
-- Original: ServerStorage/Modules/RagdollHandler.lua  (ModuleScript, 400 lines)
-- What it does: Fighting-game ragdoll: replaces joints, adds collider parts, ragdolls for a duration, tracks 'inAir' to slam on landing, cancels ragdoll with knockback, and when ragdolls stack on one character keeps only the longest timer.

-- services --

local RS = game:GetService('ReplicatedStorage')
local RNS = game:GetService('RunService')
local CS = game:GetService('CollectionService')
local SvSt = game:GetService('ServerStorage')
local TS = game:GetService('TweenService')
local Debris = game:GetService('Debris')
local Players = game:GetService('Players')


-- bindables --

local StartAirDetection = SvSt.Bindables.AirDetector

-- assets --

local Assets = SvSt.Assets

local GroundHitSound = Assets.Sounds.Other.Collapse
local KnockbackAnim = Assets.Animations.Other.Knockback
local Voxbreaker = require(RS.Modules.VoxBreaker)

-- remotes --

local Remotes = RS.Remotes

local Replicate = Remotes.Replicate.Set


-- modules --

local SvModules = SvSt.Modules

local StunHandler = require(SvModules.StunHandler)
local AnimationService = require(SvModules.AnimationService)
local NewKnockback = require(SvModules.BodymoverService)
local KnockbackModule = require(SvModules.KnockbackModule)
local SoundsModule = require(SvModules.SoundsModule)
local voxBreaker = require(game.ReplicatedStorage.Modules.VoxBreaker)


-- module --

local Ragdoll = {}
local landedConnections = {}


-- variables --

local rad = math.rad

local ragdollInstanceNames = {
	["RagdollAttachment"] = true,
	["RagdollConstraint"] = true,
	["ColliderPart"] = true,
}

-- voxeleffect --
-- Hitbox Management Functions --

-- Hitbox tracking table
local activeHitboxes = {}

-- Function to create and enable the moveable hitbox
local function enableMoveableHitbox(Character)
	local HumRP = Character:FindFirstChild("HumanoidRootPart")
	if not HumRP then return end

	local moveable = voxBreaker.CreateMoveableHitbox(3, 20, Vector3.new(5, 5, 5), CFrame.new(), Enum.PartType.Ball)
	local connection
	local touched = {}

	-- Set up the Touched connection
	connection = moveable.Touched:Connect(function(Parts)
		for _, v: Part in pairs(Parts) do
			if not table.find(touched, v) then
				v.Size = v.Size * 0.95
				v.Anchored = false
				v:SetAttribute("Destroyable", false)
				
				table.insert(touched, v)
			end
		end
	end)

	-- Update the hitbox position continuously
	task.spawn(function()
		while moveable and moveable.Part and Character:HasTag("Ragdolled") do
			moveable.Part.Position = HumRP.Position + HumRP.Velocity / 12
			task.wait()
		end
	end)

	-- Store the hitbox and connection
	activeHitboxes[Character] = { hitbox = moveable, connection = connection }

	-- Start the hitbox
	moveable:Start()
end

-- Function to disable the moveable hitbox
local function disableMoveableHitbox(Character)
	local data = activeHitboxes[Character]
	if not data then return end

	-- Stop the hitbox and disconnect the connection
	if data.hitbox then
		data.hitbox:Destroy()
	end
	if data.connection then
		data.connection:Disconnect()
	end

	-- Clean up
	activeHitboxes[Character] = nil
end


-- local functions --

local function destroyLowestRagdoll(RagdollTable: { any })
	if #RagdollTable > 0 then
		local lowestValue = { Object = nil, Duration = nil }
		for _,Ragdoll: NumberValue in RagdollTable do
			local actualValue = Ragdoll.Value

			if not lowestValue.Object then
				lowestValue = { Object = Ragdoll, Duration = actualValue }
			else
				if lowestValue.Duration > actualValue then
					lowestValue = { Object = Ragdoll, Duration = actualValue }
				end
			end
		end

		lowestValue.Object:Destroy()
	end
end

local function createColliderPart(part: BasePart)
	if not part then return end
	local wc = Instance.new("WeldConstraint")
	wc.Part1 = part

	local rp = Instance.new("Part")
	rp.Name = "ColliderPart"
	rp.Size = Vector3.new(1, 0.25, 1)
	rp.Massless = true
	rp.CFrame = part.CFrame * CFrame.new(0, -0.85, 0)
	rp.Transparency = 1
	rp.CollisionGroup = 'RagdollColliders'

	wc.Part0 = rp

	wc.Parent = rp
	rp.Parent = part
end

local function replaceJoints(Character: Model)
	local Humanoid: Humanoid = Character.Humanoid

	for _, motorValue: ObjectValue in pairs(Character.Motor6D:GetChildren()) do
		local motor: Motor6D = motorValue.Value
		if not motor then continue end
		local a0, a1 = script[motor.Part1.Name].Att0:Clone(), script[motor.Part1.Name].Att1:Clone()

		a0.Name = "RagdollAttachment"
		a1.Name = "RagdollAttachment"

		createColliderPart(motor.Part1)

		local b = script[motor.Part1.Name].BSC:Clone()
		b.Attachment0 = a0
		b.Attachment1 = a1
		b.Name = "RagdollConstraint"

		a0.Parent = Character.Torso
		a1.Parent = motor.Part1
		b.Parent = motor.Parent

		motor.Enabled = false
	end
end

local function resetJoints(Character: Model)
	local Humanoid: Humanoid = Character.Humanoid

	if Humanoid.Health > 0 then 
		for _, instance in pairs(Character:GetDescendants()) do
			if ragdollInstanceNames[instance.Name] then
				instance:Destroy()
			end
		end

		for _, motorValue: ObjectValue in Character.Motor6D:GetChildren() do
			local motor: Motor6D = motorValue.Value
			if not motor then continue end

			motor.Enabled = true
		end
	end
end


-- module functions --

function Ragdoll.cancelRagdoll(Humanoid: Humanoid, _, DoKnockback: boolean, MainPart: BasePart)
	coroutine.wrap(function()
		if not Humanoid or not Humanoid.Parent or not Humanoid.Parent:HasTag('Ragdolled') or not Humanoid.Parent:FindFirstChild('HumanoidRootPart') then return end

		local Character: Model = Humanoid.Parent
		local HumRP: BasePart = Character.HumanoidRootPart
		local Animator: Animator = Humanoid.Animator

		disableMoveableHitbox(Character)

		local RagdollsFolder: Folder = Character.Ragdolls
		local Ragdolls: { any } = RagdollsFolder:GetChildren()

		destroyLowestRagdoll(Ragdolls)

		if not RagdollsFolder:FindFirstChild('Ragdolled') and Humanoid.Health > 0 then
			if landedConnections[Character] then
				landedConnections[Character]:Disconnect()
				landedConnections[Character] = nil
			end

			local ragdollCancel = Instance.new('BoolValue')
			ragdollCancel.Name = 'RagdollCancel'
			ragdollCancel.Parent = Character
			Debris:AddItem(ragdollCancel, 2)

			StunHandler:RemoveAllStuns(Character)
			resetJoints(Character)

			Character:RemoveTag('CantRotate')
			Character:RemoveTag('Ragdolled')
			Character:SetAttribute('RagdollTime', nil)

			Character:AddTag('StunImmunity')
			task.delay(.5, function()
				Character:RemoveTag('StunImmunity')
			end)


			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)


			Humanoid.AutoRotate = true
			Humanoid.WalkSpeed = 16
			Humanoid.JumpPower = 50
			Humanoid.PlatformStand = false


			Replicate:FireAllClients('TriggerRagdoll', { State = false; Humanoid = Humanoid; })


			HumRP.Massless = false

			if DoKnockback == true and MainPart ~= nil then
				KnockbackModule:Knockback(Character, MainPart.CFrame.LookVector * 140, MainPart.Parent)
			end
		end
	end)()
end

function Ragdoll.ragdoll(Humanoid: Humanoid, Duration, HardRagdoll, Ragdoller, RockParams, destroyAmbient)
	coroutine.wrap(function()
		if not Humanoid.Parent or not Humanoid.Parent:FindFirstChild('HumanoidRootPart') or Humanoid.Parent:HasTag('Ragdolled') then return end
		Duration = Duration or 9999

		local Character: Model = Humanoid.Parent
		local HumRP: BasePart = Character.HumanoidRootPart


		Character:AddTag('Ragdolled')
		Character:SetAttribute('RagdollTime', 0)

		enableMoveableHitbox(Character)

		local Start = time()
		local RagdollTimeConnection: RBXScriptConnection
		RagdollTimeConnection = RNS.Heartbeat:Connect(function()
			if Character:HasTag('Ragdolled') then
				local currTime = time()

				Character:SetAttribute('RagdollTime', currTime - Start)
				Start = currTime
			else
				RagdollTimeConnection:Disconnect()
				RagdollTimeConnection = nil
			end
		end)


		local Ragdolled = Instance.new("NumberValue")
		Ragdolled.Name = "Ragdolled"
		Ragdolled.Value = Duration
		Ragdolled.Parent = Character.Ragdolls
		TS:Create(Ragdolled, TweenInfo.new(Duration, Enum.EasingStyle.Linear), { Value = 0 }):Play()
		Debris:AddItem(Ragdolled, Duration)


		Humanoid.AutoRotate = false
		Humanoid.PlatformStand = true

		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
		Humanoid:ChangeState(Enum.HumanoidStateType.Physics)

		Replicate:FireAllClients('TriggerRagdoll', { State = true; Humanoid = Humanoid; })


		Character:AddTag('CantRotate')
		AnimationService:stopAll(Character)


		HumRP.Massless = true
		
		local MinimumSize = 5
		local Seconds = 25
		local Size = Vector3.new(4, 5.5, 4)
		local Shape = Enum.PartType.Block
		local Cframe = nil

		local Hitboxss = Voxbreaker.CreateMoveableHitbox(MinimumSize,Seconds,Size,Cframe,Shape)
		Hitboxss:Start()
		Hitboxss:WeldTo(HumRP)
		Hitboxss.Touched:Connect(function(Touched)
			for i, v in pairs(Touched) do
				for i, v in pairs(Touched) do
					if v:IsA("BasePart") then
						v.Size = v.Size * 0.95
						v.Anchored = false
						v:SetAttribute("Destroyable", false)
					end
				end
			end
		end)
		task.delay(Duration - 0.5, function()
			Hitboxss:Stop()
		end)


		replaceJoints(Character)


		if Duration ~= 9999 then
			StunHandler:Stun(Character, Duration)

			task.delay(Duration,function()
				Ragdoll.cancelRagdoll(Humanoid)
			end)
		else
			StunHandler:Stun(Character)
		end

		if HardRagdoll == true then
			if not RockParams then
				RockParams = { CF = HumRP.CFrame; Radius = 7; Parts = 5; }
			else
				RockParams['CF'] = HumRP.CFrame
				RockParams['Circles'] = RockParams['Circles'] or 1
			end

			RockParams['HardRagdollDetection'] = true;
			RockParams['Char'] = Character;
			RockParams['Ragdoller'] = Ragdoller;
			RockParams['destroyAmbient'] = destroyAmbient;


			Replicate:FireAllClients('rockCircle', RockParams)
		else
			task.wait()

			if not Character:HasTag('inAir') then
				SoundsModule:PlaySound(GroundHitSound, HumRP, 1, 1)
			else
				landedConnections[Character] = CS:GetInstanceRemovedSignal('inAir'):Connect(function(o)
					if o.Name == Character.Name then
						if landedConnections[Character] then
							landedConnections[Character]:Disconnect()
							landedConnections[Character] = nil
						end
						SoundsModule:PlaySound(GroundHitSound, HumRP, 1, 1)
					end
				end)
			end
		end
	end)()
end

return Ragdoll
