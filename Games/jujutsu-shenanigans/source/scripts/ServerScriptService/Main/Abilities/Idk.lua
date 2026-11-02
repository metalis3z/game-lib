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
local voxBreaker = require(game.ReplicatedStorage.Modules.VoxBreaker)


local AnimationEvents = shared.AnimationEvents
local Utility = shared.Utility
local WeldSystem = shared.WeldSystem
local limbtrail = shared['Limb Trail']
local TS = game:GetService("TweenService")

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
		
		local stun
		
		local Stun = StunHandler:Stun(Character, nil, true)
		
		local Hit = false
		local anim = MoveAnims.Kashimo.Dash.Player
		
		ReplicateEffects_Set:FireAllClients('DAsh2',{Stage = "Fly",Char = Character})
		
		task.delay(0.1, function()
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(10, 10, 10)
			Hitbox.onTouch = function(EnemyCharacter)
				if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyCharacter.Humanoid.Health <= 0 then return end
				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)
				
				AnimationService:playAnimation(EnemyCharacter, MoveAnims.Kashimo.Dash.Enemy)
				AnimationService:playAnimation(Character, MoveAnims.Kashimo.Dash.Grabber)
				
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				
				local HitInfo
				
				local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3.35) * CFrame.Angles(0, rad(-180), 0), 6)
				Weld:Start()
				
				if EnemyHumanoid.Health <= 4 then
					HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 4, 1.45, nil, false, false)
					
					if Weld then
						Weld:Stop()
						Weld = nil
					end
				else
					HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 4, 1.45, nil, false, false)
				end
				
				local LookVector = -CFrame.lookAt(EnemyHumRP.Position, HumRP.Position).LookVector
				
				Hit = true
				
				EnemyHumanoid.AutoRotate = false
				EnemyCharacter:AddTag('CantRotate')

				stun = StunHandler:Stun(EnemyCharacter, nil, true)
				
				local HitInfo2
				
				task.delay(.55, function()
					if EnemyHumanoid.Health <= 12 then
						HitInfo2 = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0, 1.45, nil, false, false)
					else
						HitInfo2 = DamageHandler:TakeDamage(Character, EnemyHumanoid, 12, 1.45, nil, false, false)
					end
					
					if Weld then
						Weld:Stop()
						Weld = nil
					end
					
					EnemyHumanoid.AutoRotate = true
					EnemyCharacter:RemoveTag('CantRotate')
					
					StunHandler:Unstun(Character, Stun)
					StunHandler:Unstun(EnemyCharacter, stun)
					
					StunHandler:Stun(EnemyCharacter, 0.5)
					
					RagdollHandler.ragdoll(EnemyHumanoid, 0.2, true)
					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(LookVector.X * 22, 12, LookVector.Z * 22) })
				end)
			end
			
			Hitbox:Start()

			task.delay(0.75, function()
				Hitbox:Destroy()
			end)
		end)
		
		task.delay(0.75, function()
			if Hit == false then
				AnimationService:stopAll(Character)
				AnimationService:playAnimation(Character, MoveAnims.Kashimo.Dash.Swing)
				StunHandler:Unstun(Character, Stun)
			end
		end)
		
		AnimationService:playAnimation(Character, anim)
	end
}