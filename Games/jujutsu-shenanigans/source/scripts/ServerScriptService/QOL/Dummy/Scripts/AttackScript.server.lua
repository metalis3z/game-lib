local Character = script.Parent
local HumRP = Character.HumanoidRootPart
local Humanoid = Character.Humanoid
local RNS = game["Run Service"]
local ServerStorage = game.ServerStorage
local AnimationService = require(ServerStorage.Modules.AnimationService)
local HitboxHandler = require(ServerStorage.Modules.HitboxHandler)
local iFramesService = require(ServerStorage.Modules.iFramesService)
local DamageHandler = require(ServerStorage.Modules.DamageHandler)
local AnimationEvents = require(game.ReplicatedStorage.Modules.AnimationEvents)
local RagdollHandler = require(ServerStorage.Modules.RagdollHandler)
local StunHandler = require(ServerStorage.Modules.StunHandler)
local NewKnockback = require(ServerStorage.Modules.BodymoverService)
local Animations = ServerStorage.Assets.Animations
local Debris = game.Debris

RNS.Heartbeat:Connect(function()
	if not Character:HasTag('Punching') and not Character:HasTag('PunchCDS') and not Character:HasTag('CantPunch') then 
		Character:AddTag('Punching')
		Character:AddTag('PunchCDS')
		
		local PunchAnim: Animation = Animations.Combat.Punches.Default['1']
		local PunchAnimTrack = AnimationService:getAnimationTrack(Character, PunchAnim)
		local AnimEvents = AnimationEvents.new(PunchAnimTrack)

		AnimEvents:AddEvent('Hit', { .250 }, function()
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(1,1,1) * 7
			Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
			Hitbox.onTouch = function(EnemyCharacter: Model)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyAnimator: Animator = EnemyHumanoid.Animator

				if EnemyCharacter == Character or EnemyHumanoid.Health <= 0 or iFramesService:HasiFrame(EnemyCharacter, 'M1') or EnemyCharacter:HasTag('Ragdolled') then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 4, 1, ServerStorage.Assets.Animations.Combat.Hits['1'], true, true, false, false, true, 'M1')

				
				if HitInfo.Countered == true then return end


				if HitInfo.Blocked == true then
					local SFX: Sound
					if EnemyCharacter:HasTag('PerfectBlock') then
						SFX = ServerStorage.Assets.Sounds.Combat.Hits.PerfectBlocked:Clone()
					else
						SFX = ServerStorage.Assets.Sounds.Combat.Hits.Blocked:Clone()
					end
					SFX.SoundGroup = game.SoundService.Sounds
					SFX.Parent = EnemyHumRP
					SFX:Play()
					Debris:AddItem(SFX, SFX.TimeLength + 1)
				else
					local SFX: Sound = ServerStorage.Assets.Sounds.Combat.Hits.Default.Punch['1']:Clone()
					SFX.SoundGroup = game.SoundService.Sounds
					SFX.Parent = EnemyHumRP
					SFX:Play()
					Debris:AddItem(SFX, SFX.TimeLength + 1)
				end
			end

			Hitbox:Once()
			Hitbox:Destroy()
		end)

		AnimEvents:AddEvent('Stopped', {}, function()
			Character:RemoveTag('Punching')

			task.wait(1)

			Character:RemoveTag('PunchCDS')
		end)

		AnimationService:playAnimation(Character, PunchAnim)
		AnimEvents:Play()

		local SwingSFX = ServerStorage.Assets.Sounds.Combat.Swings.Default.Punch['1']:Clone()
		SwingSFX.SoundGroup = game.SoundService.Sounds
		SwingSFX.Parent = HumRP
		SwingSFX:Play()
		game.Debris:AddItem(SwingSFX, SwingSFX.TimeLength + 1)
	end
end)