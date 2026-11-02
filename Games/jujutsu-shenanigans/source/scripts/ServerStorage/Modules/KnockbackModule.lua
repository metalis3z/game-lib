local module = {}


local CollectionService = game:GetService('CollectionService')


local ModulesFolder = script.Parent

local StunHandler = require(ModulesFolder.StunHandler)
local Bodymover = require(ModulesFolder.BodymoverService)
local AnimationService = require(ModulesFolder.AnimationService)


local ReplicateSet = game.ReplicatedStorage.Remotes.Replicate.Set


local knockAnim = ModulesFolder.Parent.Assets.Animations.Other.Knockback

function module:Knockback(Character: Model, Velocity: Vector3?, LookAtCharacter: Model, CustomAnimation: Animation?, customTime: number?, to, ringFX, waitForFloor)
	local HumRP: BasePart = Character.HumanoidRootPart
	local Humanoid: Humanoid = Character.Humanoid

	local tweenTime
	if Humanoid.Health > 0 then
		local AnimTrack: AnimationTrack
		if CustomAnimation then
			AnimTrack = AnimationService:getAnimationTrack(Character, CustomAnimation)
			tweenTime = AnimTrack.Length
			StunHandler:Stun(Character, tweenTime, true, 0, 0, true)
			ReplicateSet:FireAllClients('RockTrail',{ parent = HumRP, size = .5, side = 2.5, t = 5, height = 5, spawnrate = .15, duration = tweenTime })
		else
			local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
			AnimTrack = AnimationService:getAnimationTrack(Character, knockAnim)
			Character:AddTag("Knockbacked")

			tweenTime = .6
			AnimTrack:GetMarkerReachedSignal('freeze'):Once(function()
				local inAir = Character:FindFirstChild('inAir')
				if inAir and Character:HasTag("inAir") then

					inAir.Destroying:Once(function()

						ReplicateSet:FireAllClients('RockTrail',{ parent = HumRP, size = .5, side = 2.5, t = 5, height = 5, spawnrate = .15, duration = .533 })

						if waitForFloor == true then
							Bodymover:Knockback(Character, { KnockbackType = 'VelocityTweenDown', MaxForce = Vector3.new(1,0,1) * 100000, Velocity = Velocity, Time = customTime or tweenTime })
						end
					end)
				else
					ReplicateSet:FireAllClients('RockTrail',{ parent = HumRP, size = .5, side = 2.5, t = 5, height = 5, spawnrate = .15, duration = .533 })
				end
			end)
			AnimTrack:GetMarkerReachedSignal('Unstun'):Once(function()
				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end
			end)
			AnimTrack.Stopped:Once(function()
				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end
				Humanoid.AutoRotate = true

				Character:RemoveTag('CantRotate')
				Character:RemoveTag("Knockbacked")
			end)
		end
		
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, AnimTrack.Animation)

		Bodymover:makeEnemyFaceCharacter(Character, LookAtCharacter, to)
		
		if typeof(Velocity) == 'Vector3' then
			if waitForFloor == true then
				Bodymover:Knockback(Character, { KnockbackType = 'Velocity', MaxForce = Vector3.new(1,1,1) * 100000, Velocity = Velocity })
			else
				Bodymover:Knockback(Character, { KnockbackType = 'VelocityTweenDown', MaxForce = Vector3.new(1,1,1) * 100000, Velocity = Velocity, Time = customTime or tweenTime })
			end
		end

		if not CustomAnimation then
			ModulesFolder.Parent.Bindables.AirDetector:Fire(Character, true)
		end
	else
		Bodymover:Knockback(Character, { KnockbackType = 'Velocity', MaxForce = Vector3.new(1,1,1) * 100000, Velocity = Velocity })
	end


	if ringFX ~= false then

		ReplicateSet:FireAllClients('Ring', {
			CF = CFrame.lookAlong(HumRP.Position, (if typeof(Velocity) == 'Vector3' then Velocity else HumRP.CFrame.LookVector)) * CFrame.Angles(math.rad(90), 0, 0),

			FirstProps = {
				Size = Vector3.new(.6,.6,.6),
				Transparency = 0
			},

			TN_Info = {
				Time = .5, 
				Style = 'Quad',
				Direction = 'Out'
			},

			FinalProps = {
				Size = Vector3.new(12,.6,12),
				Transparency = 1
			}
		})
	end


	Character:AddTag('CantRotate')
	Humanoid.AutoRotate = false	
end

return module
