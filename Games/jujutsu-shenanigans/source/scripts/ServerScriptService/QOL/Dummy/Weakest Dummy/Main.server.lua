local RNS = game:GetService('RunService')
local SvSt = game:GetService('ServerStorage')
local RS = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')



local Assets = SvSt.Assets

local MoveSounds = Assets.Sounds.Moves
local MoveAnims = Assets.Animations.Moves



local ReplicateSet = RS.Remotes.Replicate.Set



local RpModules = RS.Modules

local WeldSystem = require(RpModules.WeldSystem)
local AnimationEvents = require(RpModules.AnimationEvents)
local Utility = require(RpModules.Utility)


local SvModules = SvSt.Modules

local StunHandler = require(SvModules.StunHandler)
local iFramesService = require(SvModules.iFramesService)
local AnimationService = require(SvModules.AnimationService)
local DamageHandler = require(SvModules.DamageHandler)
local SoundsModule = require(SvModules.SoundsModule)



local Character = script.Parent
local Humanoid = Character.Humanoid
local HumRP = Character.HumanoidRootPart
local Head = Character.Head
local Torso = Character.Torso


local StunsFolder: Folder = Character.Stuns

local StunAdded = StunsFolder.ChildAdded
local StunRemoved = StunsFolder.ChildRemoved



local VelocityDebug = script.VelocityDebug
local Start = time()

RNS.Heartbeat:Connect(function()
	local Velocity = Torso.AssemblyLinearVelocity
	local Length = Velocity.Magnitude
	local Direction = Velocity.Unit


	if Length > .5 then
		VelocityDebug.Transparency = 0
		VelocityDebug.Size = Vector3.new(.25, .25, Length)
		VelocityDebug.CFrame = CFrame.new(Torso.Position, Torso.Position + Direction)
		VelocityDebug.CFrame *= CFrame.new(0, 0, -Length/2)
	else
		VelocityDebug.Size = Vector3.new(1, 1, 1) * .25
		VelocityDebug.Transparency = 1
	end
end)



--// Health Visualizer \\--

local HealthBillboard: BillboardGui = Head.HealthBillboard
local HealthText: TextLabel = HealthBillboard.HealthText



--// Functions \\--

function ChangeHealthText()
	HealthText.Text = math.round((Humanoid.Health * 100) / Humanoid.MaxHealth) ..'%'
end



--// Health Regeneration \\--

local HealConnection: RBXScriptConnection = nil


Humanoid:GetPropertyChangedSignal('Health'):Connect(function()
	ChangeHealthText()
end)



ChangeHealthText()



--// Stun Visualizer Handler \\--

StunAdded:Connect(function()
	if StunsFolder:FindFirstChild('Stunned') then
		HealthText.TextColor3 = Color3.new(1, 0, 0)
	end
end)

StunRemoved:Connect(function()
	if not StunsFolder:FindFirstChild('Stunned') then
		HealthText.TextColor3 = Color3.new(1, 1, 1)
	end
end)


Character.ChildAdded:Connect(function(child: ObjectValue?)
	if child.Name == 'DamagedLog' and Character:HasTag('SpecialCounter') then
		local Stun = StunHandler:Stun(Character, nil, true)

		local EnemyCharacter: Model = child.Value
		local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
		local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
		local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

		
		local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true)
		EnemyHumanoid.AutoRotate = false
		EnemyCharacter:AddTag('CantRotate')
		iFramesService:AddAlliFrames(EnemyCharacter)
		AnimationService:stopAll(EnemyCharacter)
		
		HumRP.Anchored = true
		iFramesService:AddAlliFrames(Character)
		
		local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3) * CFrame.Angles(0, math.rad(180), 0))


		--local HitAnim = MoveAnims.Other.CMDCounterPlayer
		--local VictimAnim = MoveAnims.Other.CMDCounterVictim

		local HitTrack = AnimationService:getAnimationTrack(Character, HitAnim)
		local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnim)

		local HitEvents = AnimationEvents.new(HitTrack)
		HitEvents:AddEvent('Hit', { 1.583, 3.717, 3.867, 4.033, 4.283, 4.367, 4.450, 4.567, 4.750, 4.850, 4.967, 5.183, 5.350, 5.483, 5.983 }, function()
			if (EnemyHumanoid.Health - 7) <= 0 then
				EnemyHumRP.Anchored = true

				if Weld ~= nil then
					Weld:Stop()
					Weld = nil
				end
			end
			
			DamageHandler:TakeDamage(Character, EnemyHumanoid, 7, nil, nil, false, false, true, true)
		end)
		HitEvents:AddEvent('Desintegrate', { 6.5 }, function()
			ReplicateSet:FireAllClients('CommandCounter', { Stage = 'Desintegrate'; Character = EnemyCharacter; })
		end)
		HitEvents:AddEvent('End', { 8 }, function()
			Utility('TriggerTransparency')(Character, 1)
			ReplicateSet:FireAllClients('CommandCounter', { Stage = 'TP'; Pos = Character.Torso.Position; })
			AnimationService:stopAll(Character)

			task.wait(.1)

			Utility('TriggerTransparency')(Character, 0)
			ReplicateSet:FireAllClients('CommandCounter', { Stage = 'TP'; Pos = Character.Torso.Position; })
			

			if Weld ~= nil then
				Weld:Stop()
				Weld = nil
			end

			StunHandler:Unstun(Character, Stun)
			iFramesService:RemoveAlliFrames(Character)
			HumRP.Anchored = false
		end)

		local VictimEvents = AnimationEvents.new(VictimTrack)
		VictimEvents:AddEvent('Stopped', {}, function()
			StunHandler:Unstun(EnemyCharacter, EnemyStun)
			iFramesService:RemoveAlliFrames(EnemyCharacter)

			if Weld ~= nil then
				Weld:Stop()
				Weld = nil
			end
			
			EnemyHumRP.Anchored = true
			EnemyHumRP.CFrame *= CFrame.new(0, 0, 40.037)
			
			EnemyHumanoid.AutoRotate = true
			EnemyCharacter:RemoveTag('CantRotate')
		end)


		AnimationService:stopAll(Character)
		AnimationService:stopAll(EnemyCharacter)
		--AnimationService:playAnimation(Character, HitAnim)
		--AnimationService:playAnimation(EnemyCharacter, VictimAnim)
		SoundsModule:PlaySound(MoveSounds.Other.CMDCounter, Character.Torso, 1, 1)
		HitEvents:Play()
		VictimEvents:Play()
		Weld:Start()
		EnemyCharacter:AddTag('DontDoDieFunction')
		

		if EnemyPlayer then
			ReplicateSet:FireClient(EnemyPlayer, 'CommandCounter', { Stage = 'Start'; CF = HumRP; })
		end
	end
end)