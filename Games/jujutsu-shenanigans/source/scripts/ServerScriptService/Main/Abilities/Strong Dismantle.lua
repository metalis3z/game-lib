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

local RayCastParamss = RaycastParams.new()
RayCastParamss.IgnoreWater = true
RayCastParamss.RespectCanCollide = true
RayCastParamss.FilterDescendantsInstances = {workspace.Map}
RayCastParamss.FilterType = Enum.RaycastFilterType.Include


local rad = shared.rad
local StartAirDetect = shared.AirDetect
local DefaultJoint = shared.DefaultJoint

return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		
		local Stun = StunHandler:Stun(Character, 1.25, true)
		
		local Hit = false
		
		local anim = MoveAnims.Heian.StrongDism.Dismantle
		local cf = HumRP.CFrame
		local cf2 = HumRP.CFrame
		
		task.delay(0.37, function()
			local movepart = script.DismantleProjectile:Clone()
			movepart.Parent = workspace.Effects
			
			local movepart2 = script.DismantleProjectile:Clone()
			movepart2.Parent = workspace.Effects
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = movepart
			Hitbox.Size = Vector3.new(30, 30, 30)
			Hitbox.onTouch = function(EnemyCharacter)
				if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyCharacter.Humanoid.Health <= 0 then return end

				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 45, 1.45, nil, false, false)

				local LookVector = -CFrame.lookAt(EnemyHumRP.Position, movepart.Position).LookVector

				if HitInfo.Finisher == true then
					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(LookVector.X * 2, 2, LookVector.Z * 2) })
					RagdollHandler.ragdoll(EnemyHumanoid, 2, false, nil, nil)
					StartAirDetect:Fire(EnemyCharacter)
				else
					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(LookVector.X * 2, 2, LookVector.Z * 2) })
					RagdollHandler.ragdoll(EnemyHumanoid, 2, false, nil, nil)
					StartAirDetect:Fire(EnemyCharacter)
				end
			end

			Hitbox:Start()

			task.delay(0.75, function()
				Hitbox:Destroy()
			end)

			movepart.CFrame = cf 
			movepart2.CFrame = cf

			TS:Create(movepart, TweenInfo.new(1.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = cf * CFrame.new(0, 0, -222) }):Play()
			TS:Create(movepart2, TweenInfo.new(1.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = cf * CFrame.new(0, 0, -222) }):Play()


			Debris:AddItem(movepart2, .405)
			Debris:AddItem(movepart, .405)
		end)
		
		AnimationService:playAnimation(Character, anim)
	end
}