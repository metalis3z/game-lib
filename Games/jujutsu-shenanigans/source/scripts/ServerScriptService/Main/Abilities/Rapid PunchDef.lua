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
		
		local animTrack = AnimationService:getAnimationTrack(Character, MoveAnims["Honored One"].RapidPunch.Fail)

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

				if HitInfo.Countered == true then return end

				if HitInfo.Blocked == true then
					SoundsModule:PlaySound(Sounds.Combat.Hits.Blocked, EnemyHumRP, 1, 1)
				elseif EnemyCharacter:HasTag('Ragdolled') then
					Hit = false
				else
					iFramesService:AddAlliFrames(Character)
					Hit = true

					stun = StunHandler:Stun(EnemyCharacter, nil, true)

					weld = Instance.new("Weld")
					weld.Parent = Character
					weld.Part0 = Character:FindFirstChild("HumanoidRootPart")
					weld.Part1 = EnemyCharacter:FindFirstChild("HumanoidRootPart")
					weld.C1 = CFrame.new(0, 0, -3) * CFrame.Angles(0, rad(180), 0)

					animTrack:Stop(0)

					local animTrack = AnimationService:getAnimationTrack(Character, MoveAnims["Honored One"].RapidPunch.Startap)

					local PunchAnimEvents = AnimationEvents.new(animTrack)

					local punches = 0
					local clamp = false
					PunchAnimEvents:AddEvent("Punch", {28 / 60, 4 / 60, 50 / 60, 55 / 60, 60 / 60, 67 / 60, 72 / 60, 82 / 60, 85 / 60, 92 / 60, 98 / 60, 103 / 60, 106 / 60, 112 / 60, 130 / 60, 145 / 60, 165 / 60, 195 / 60 }, function()
						punches += 1

						if EnemyHumanoid.Health <= .5 then
							clamp = true
							EnemyHumanoid.Health = .5
							local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0, 1, Animations.Combat.Hits[math.random(1, 4)], false, true, true, true, true)
						end

						if not clamp then
							local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, .5, 1, Animations.Combat.Hits[math.random(1, 4)], false, true, true, true, true)
						end

					end)

					--PunchAnimEvents:AddEvent('Walk', { 0 }, function()

						--ReplicateEffects_Set:FireAllClients('Barrage', { Stage = 'Walk'; Char = Character; })

					--end)

					PunchAnimEvents:AddEvent("FinalPunch", {194 / 60}, function()

						if EnemyHumanoid.Health <= 6 then
							EnemyHumanoid.Health = .5
							local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0, 1, Animations.Combat.Hits[math.random(1, 4)], false, true, true, true, true)

							local animTrack = AnimationService:getAnimationTrack(Character, MoveAnims["Honored One"].RapidPunch.Finesher)

							local FinalPunchAnimEvents = AnimationEvents.new(animTrack)

							FinalPunchAnimEvents:AddEvent("FinisherFinalPunch", {25 / 60}, function()
								weld:Destroy()
								local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, 1, Animations.Combat.Hits[math.random(1, 4)], false, true, true, true, true)
								NewKnockback:Knockback(EnemyCharacter, {KnockbackType = "Velocity", MaxForce = Vector3.new(math.huge, math.huge, math.huge), Velocity = HumRP.CFrame.LookVector * 180, Time = .1})
							end)

							FinalPunchAnimEvents:AddEvent("Stopped", {}, function()

								StunHandler:Unstun(EnemyCharacter, stun)
								StunHandler:Unstun(Character, Stun)
							end)

							animTrack:Play()
							FinalPunchAnimEvents:Play()
						else

							weld:Destroy()
							local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 6, 1, Animations.Combat.Hits[math.random(1, 4)], false, true, true, true, true)
							RagdollHandler.ragdoll(EnemyHumanoid, 1.5)
							NewKnockback:Knockback(EnemyCharacter, {KnockbackType = "Velocity", MaxForce = Vector3.new(math.huge, math.huge, math.huge), Velocity = HumRP.CFrame.LookVector * 80, Time = .1})
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

			task.wait(.033)

			Hitbox:Once()
			Hitbox:Destroy()

			if Hit then
				ReplicateEffects_Set:FireClient(Player, 'ShakeCamera', { Magnitude = 2, Roughness = 10, FadeInTime = 0, FadeOutTime = .5 })
			end
		end)



		WindupAnimEvents:AddEvent("Stopped", {}, function()
			if not Hit then
				StunHandler:Unstun(Character, Stun)
				Humanoid.AutoRotate = true
				iFramesService:RemoveAlliFrames(Character)
			end
		end)

		animTrack:Play()
		animTrack:AdjustSpeed(1)
		WindupAnimEvents:Play()
	end
}