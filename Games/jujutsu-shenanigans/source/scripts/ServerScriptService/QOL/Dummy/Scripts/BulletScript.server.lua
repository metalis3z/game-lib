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
local StartSound = script.Fire:Clone()
local TS = game:GetService("TweenService")

RNS.Heartbeat:Connect(function()
	if not Character:HasTag('Punching') and not Character:HasTag('PunchCDS') and not Character:HasTag('CantPunch') then 
		Character:AddTag('Punching')
		Character:AddTag('PunchCDS')

		local PunchAnim: Animation = Animations.Moves.Gambler["Reserve Balls"].Player
		local PunchAnimTrack = AnimationService:getAnimationTrack(Character, PunchAnim)
		local AnimEvents = AnimationEvents.new(PunchAnimTrack)
		
		task.delay(0.15, function()
			local ball = game.ServerStorage.Assets.Models.Gambler.Reserve:Clone()
			ball.Parent = workspace.Effects
			ball.Weld.Part1 = Character:WaitForChild("Right Arm")
			Debris:AddItem(ball, .38)
		end)

		AnimEvents:AddEvent('Hit', { .533 }, function()
			StartSound.Parent = HumRP
			StartSound:Play()
			
			local movepart = game.ServerStorage.Assets.Models.Gambler.Reserve:Clone()
			movepart.Anchored = true
			movepart.Parent = workspace.Thrown
			movepart.CFrame = HumRP.CFrame
			Debris:AddItem(movepart, 0.605)
			
			local cf = HumRP.CFrame + Vector3.new(0,0,-3)
			
			task.delay(0.025, function()
				movepart.Stars.Enabled = true
			end)
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = movepart
			Hitbox.Size = Vector3.new(1,1,1) * 4
			Hitbox.Offset = CFrame.new(0,0,0)
			Hitbox.onTouch = function(EnemyCharacter: Model)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyAnimator: Animator = EnemyHumanoid.Animator

				if EnemyCharacter == Character or EnemyHumanoid.Health <= 0 or iFramesService:HasiFrame(EnemyCharacter, 'M1') or EnemyCharacter:HasTag('Ragdolled') then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 6.5, 1, ServerStorage.Assets.Animations.Combat.Hits['1'], true, true, false, false, true, 'M1')


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
					local LookVector = -CFrame.lookAt(EnemyHumRP.Position, movepart.Position).LookVector
					
					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(LookVector.X * 2, 2, LookVector.Z * 2) })
					RagdollHandler.ragdoll(EnemyHumanoid, 1.5, false, nil, nil)
					
					local SFX: Sound = script.Impact:Clone()
					SFX.SoundGroup = game.SoundService.Sounds
					SFX.Parent = EnemyHumRP
					SFX:Play()
					Debris:AddItem(SFX, SFX.TimeLength + 1)
				end
			end

			Hitbox:Start()
			task.delay(.605, function()
				Hitbox:Destroy()
			end)
			
			TS:Create(movepart, TweenInfo.new(.6125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = cf * CFrame.new(0, 0, -33.5) }):Play()
			
		end)

		AnimEvents:AddEvent('Stopped', {}, function()
			Character:RemoveTag('Punching')

			task.wait(1)

			Character:RemoveTag('PunchCDS')
		end)

		AnimationService:playAnimation(Character, PunchAnim)
		AnimEvents:Play()
	end
end)