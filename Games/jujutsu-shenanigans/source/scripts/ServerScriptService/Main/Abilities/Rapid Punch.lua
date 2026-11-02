local Debris = game:GetService('Debris')

local StunHandler = require(game.ServerStorage.Modules.StunHandler)
local HitboxHandler = require(game.ServerStorage.Modules.HitboxHandler)
local DamageHandler = require(game.ServerStorage.Modules.DamageHandler)
local RagdollHandler = require(game.ServerStorage.Modules.RagdollHandler)
local NewKnockback = require(game.ServerStorage.Modules.BodymoverService)
local AnimationService = require(game.ServerStorage.Modules.AnimationService)
local iFramesService = require(game.ServerStorage.Modules.iFramesService)
local WeaponsHandler = require(game.ServerStorage.Modules.WeaponsHandler)
local CollisionsModule = require(game.ServerStorage.Modules.CollisionsModule)
local SoundsModule = require(game.ServerStorage.Modules.SoundsModule)
local KnockbackModule = require(game.ServerStorage.Modules.KnockbackModule)

local TS = game:GetService("TweenService")


local AnimationEvents = shared.AnimationEvents
local Utility = shared.Utility
local WeldSystem = shared.WeldSystem
local limbtrail = shared['Limb Trail']

local Sounds = shared.SoundsFolder
local Animations = shared.AnimsFolder

local MoveAnims = shared.MoveAnims
local MoveSounds = shared.MoveSounds


local PlrSet = shared.PlrSet
local PlrGet = shared.PlrGet


local ReplicateEffects_Set = shared.repfire


local rad = shared.rad
local StartAirDetect = shared.AirDetect
local DefaultJoint = shared.DefaultJoint


return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		
		local animTrack = AnimationService:getAnimationTrack(Character, MoveAnims["Honored One"].RapidPunch.User)

		local Hit = false
		local EnemyCharacter : Model
		local EnemyHumanoid  : Humanoid
		local Stun = StunHandler:Stun(Character, nil, true)

		local stun
		local weld

		local WindupAnimEvents = AnimationEvents.new(animTrack)

		WindupAnimEvents:AddEvent("Kick", { 0.5 } , function()
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.HitType = 'Single'
			Hitbox.Ignore = { Character }
			Hitbox.Size = Vector3.new(.1,1,1) * 8
			Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
			Hitbox.onTouch = function(EnemyCharacter)
				if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyCharacter.Humanoid.Health <= 0 then return end

				EnemyHumanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				local HitInfo

				if EnemyHumanoid.Health <= 5 then
					EnemyHumanoid.Health = 1
					
					
					HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0, 1, nil, false, true, true, true, true)
				else
					HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, 1, nil, false, true, true, true, true)
				end
				
				local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -2.75) * CFrame.Angles(0, rad(-180), 0), 6)
				Weld:Start()

				if HitInfo.Countered == true then return end

				if HitInfo.Blocked == true then
					SoundsModule:PlaySound(Sounds.Combat.Hits.Blocked, EnemyHumRP, 1, 1)
				elseif EnemyCharacter:HasTag('Ragdolled') then
					Hit = false
				else
					--iFramesService:AddAlliFrames(Character)
					Hit = true

					--SoundsModule:PlaySound(MoveSounds.KJ.Ravage.Hit, HumRP, 1, 1)
					
					EnemyHumanoid.AutoRotate = false
					EnemyCharacter:AddTag('CantRotate')
					
					stun = StunHandler:Stun(EnemyCharacter, nil, true)

					animTrack:Stop(0)

					local animTrack = AnimationService:getAnimationTrack(Character, MoveAnims["Honored One"].RapidPunch.Hits)

					local PunchAnimEvents = AnimationEvents.new(animTrack)
					
					--local HitSound = MoveSounds["Strongest of Today"].Rapid.Sound

					--local sound = SoundsModule:PlaySound(MoveSounds["Strongest of Today"].Rapid.Sound, HumRP, 1)

					local clamp = false
					PunchAnimEvents:AddEvent("Punch", {28 / 60, 4 / 60, 50 / 60, 55 / 60, 60 / 60, 67 / 60, 72 / 60, 82 / 60, 85 / 60, 92 / 60, 98 / 60, 103 / 60, 106 / 60, 112 / 60, 130 / 60, 145 / 60, 165 / 60, 195 / 60 }, function()
						ReplicateEffects_Set:FireAllClients('dddd2', { Char = Character; })
						if EnemyHumanoid.Health <= .5 then
							clamp = true
							EnemyHumanoid.Health = .5
							local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0, 1, Animations.Combat.Hits[math.random(1, 4)], false, true, true, true, true)
						end

						if not clamp then
							local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, .5, 1, Animations.Combat.Hits[math.random(1, 4)], false, true, true, true, true)
						end

					end)

					PunchAnimEvents:AddEvent("FinalPunch", {194 / 60}, function()
						if EnemyHumanoid.Health <= 6 then
							EnemyHumanoid.Health = .5
							local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0, 1, Animations.Combat.Hits[math.random(1, 4)], false, true, true, true, true)

							local animTrack = AnimationService:getAnimationTrack(Character, MoveAnims["Honored One"].RapidPunch.Finisher)

							local FinalPunchAnimEvents = AnimationEvents.new(animTrack)

							FinalPunchAnimEvents:AddEvent("FinisherFinalPunch", {0.4}, function()
								if Weld then
									Weld:Stop()
									Weld = nil
								end
								local clone_2_upvr = script.BlackFlashHit:Clone()
								clone_2_upvr.Position = HumRP.Position
								clone_2_upvr.Parent = workspace.Effects
								Debris:AddItem(clone_2_upvr, 1)
								--var4_upvw:Flash(arg2, Color3.new(1, 0, 0))
								--var4_upvw:PlaySound(Sounds_upvr.Itadori.DivergentFist.BlackFlashHit, HumanoidRootPart, game.SoundService.Effect))
								clone_2_upvr.Wind2:Emit(8)
								TS:Create(clone_2_upvr.PointLight, TweenInfo.new(1), {
									Brightness = 0;
								}):Play()
								task.delay(0.1, function() -- Line 58
									clone_2_upvr.Blast:Emit(8)
									clone_2_upvr.Sparks:Emit(15)
									clone_2_upvr.Lightning:Emit(6)
									clone_2_upvr.Wind:Emit(7)
								end)
								
								local clone = script.BlackFlashCC:Clone()
								clone.Parent = game.Lighting
								task.wait(0.04)
								clone.TintColor = Color3.new(1, 1, 1)
								task.wait(0.04)
								clone.Brightness = 200
								clone.Contrast = -1000
								task.wait(0.04)
								clone:Destroy()
								
								local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 12, 1, Animations.Combat.Hits[math.random(1, 4)], false, true, true, true, true)
								NewKnockback:Knockback(EnemyCharacter, {KnockbackType = "Velocity", MaxForce = Vector3.new(math.huge, math.huge, math.huge), Velocity = HumRP.CFrame.LookVector * 180, Time = .1})
								RagdollHandler.ragdoll(EnemyHumanoid, 1.5)
							end)

							FinalPunchAnimEvents:AddEvent("Stopped", {}, function()
								StunHandler:Unstun(EnemyCharacter, stun)
								EnemyHumanoid.AutoRotate = true
								EnemyCharacter:RemoveTag('CantRotate')
								StunHandler:Unstun(Character, Stun)
							end)

							animTrack:Play()
							FinalPunchAnimEvents:Play()
						else

							if Weld then
								Weld:Stop()
								Weld = nil
							end
							local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 6, 1, Animations.Combat.Hits[math.random(1, 4)], false, true, true, true, true)
							RagdollHandler.ragdoll(EnemyHumanoid, 1.5)
							NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(HumRP.CFrame.LookVector.X * 2, 2, HumRP.CFrame.LookVector.Z * 2) })
						end
					end)

					PunchAnimEvents:AddEvent("Stopped", {}, function()
						if not clamp then
							StunHandler:Unstun(EnemyCharacter, stun)
							StunHandler:Unstun(Character, Stun)
						end
					end)

					animTrack:Play()
					PunchAnimEvents:Play()
				end
			end


			Hitbox:Once()

			if Hit then
				ReplicateEffects_Set:FireClient(Player, 'ShakeCamera', { Magnitude = 2, Roughness = 10, FadeInTime = 0, FadeOutTime = .5 })
			end
		end)



		WindupAnimEvents:AddEvent("Stopped", {}, function()
			if not Hit then
				StunHandler:Unstun(Character, Stun)
				--iFramesService:RemoveAlliFrames(Character)
			end
		end)

		animTrack:Play()
		animTrack:AdjustSpeed(1)
		WindupAnimEvents:Play()
	end
}