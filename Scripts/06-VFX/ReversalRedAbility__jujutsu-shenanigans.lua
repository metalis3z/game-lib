-- Reference copy for study. Game: jujutsu-shenanigans
-- Original: ServerScriptService/Main/Abilities/Reversal Red.lua  (ModuleScript, 230 lines)
-- What it does: A full ability: charge ball welded to the hand (size + light + particle rate tweens), tweened projectile with a hitbox, explosion part that emits Burst/Sparks/Wind/Dust, voxel destruction, knockback and ragdoll.

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

local TS = game:GetService("TweenService")
local Debris = game:GetService('Debris')

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
		
		local DoubleAwakeningProgress: NumberValue = Player.DoubleAwakeningProgress
		
		--local Stun = StunHandler:Stun(Character,nil,true,0,0,true)
		
		local Hit = false
		
		local red = script.ReversalRed:Clone()
		red.Parent = workspace.Effects
        red.Weld.Part0 = Character:WaitForChild("Right Arm")
		Debris:AddItem(red, .55)
		
		TS:Create(red, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
			Size = Vector3.one * 0.9;
		}):Play()
		TS:Create(red.Center.Light, TweenInfo.new(0.5), {
			Brightness = 40;
			Range = 8;
		}):Play()
		TS:Create(red.Center.Charge, TweenInfo.new(0.3), {
			Rate = 40;
			TimeScale = 1;
		}):Play()
		task.delay(0.3, function()
			red.Center.Charge.Enabled = false
		    TS:Create(red.Center.Light, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
			    Range = 16;
		    }):Play()
		end)
		
		task.delay(0.57, function()
			local cf = HumRP.CFrame 
			
			local Movepart = script.RedProjectile:clone()
			Movepart.Parent = workspace.Effects
			Movepart.Position = HumRP.Position + Vector3.new(0,0,-0.5)
			Debris:AddItem(Movepart, 1.75)
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = Movepart
			Hitbox.Size = Vector3.new(3, 3, 3)
			Hitbox.onTouch = function(EnemyCharacter)
				if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyCharacter.Humanoid.Health <= 0 then return end

				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0, 0.05, nil, true, false)

				local LookVector = -CFrame.lookAt(EnemyHumRP.Position, Movepart.Position).LookVector
				
				Hit = true
				
				Movepart:Destroy()
				
				if Hit == true then
					
					Hitbox:Stop()
					
					local clone = script.RedExplode:Clone()
					clone.Position = Movepart.Position + Vector3.new(0,0,-5)
					clone.Parent = workspace.Effects
					Debris:AddItem(clone, 2.4)
					clone.Burst:Emit(1.9)
					clone.Sparks:Emit(15)
					clone.Wind:Emit(6)
					clone.Dust:Emit(6)
					TS:Create(clone.Light, TweenInfo.new(0.5), {
						Brightness = 0;
					}):Play()
					
					local VoxHitbox1 = voxBreaker:CreateHitbox(Vector3.new(18,18,18), clone.CFrame*CFrame.new(0,0,0), Enum.PartType.Ball, 4,25)

					for i, t in pairs(VoxHitbox1) do
						game.Debris:AddItem(t,0)
						t:SetAttribute("Destroyable", false)
					end
					local VoxHitbox2 = voxBreaker:CreateHitbox(Vector3.new(20,20,20), clone.CFrame*CFrame.new(0,0,0), Enum.PartType.Ball, 4,25)
					for i, t in pairs(VoxHitbox2) do
						t.Size = t.Size * 0.95
						t.Anchored = false
						t:SetAttribute("Destroyable", false)
					end

					local Hitbox2 = HitboxHandler.new()
					Hitbox2.Instance = clone
					Hitbox2.Size = Vector3.new(23, 23, 23)
					Hitbox2.onTouch = function(EnemyCharacter)
						if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyCharacter.Humanoid.Health <= 0 then return end

						local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
						local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

						local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 10, 1.45, nil, true, false)
						--DoubleAwakeningProgress.Value += 25

						local LookVector = -CFrame.lookAt(EnemyHumRP.Position, Movepart.Position).LookVector

						if HitInfo.Finisher == true then
							print("Finisher")
						else
							Hit = true

							NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(LookVector.X * 35, 35, LookVector.Z * 10) })
							RagdollHandler.ragdoll(EnemyHumanoid, 2, false, nil, nil)
							StartAirDetect:Fire(EnemyCharacter)
						end
					end

					Hitbox2:Once()
				end
			end

			Hitbox:Start()

			task.delay(1.6, function()
				Hitbox:Destroy()
			end)
			
			TS:Create(Movepart, TweenInfo.new(1.2125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = cf * CFrame.new(0, 0, -22) }):Play()
			
			task.delay(1.15, function()
				
				if Hit == false and Movepart then
					Movepart:Destroy()
					
					Hitbox:Stop()
					
					local clone = script.RedExplode:Clone()
			        clone.Position = Movepart.Position + Vector3.new(0,0,-5)
			        clone.Parent = workspace.Effects
			        Debris:AddItem(clone, 2.4)
			        clone.Burst:Emit(1.9)
			        clone.Sparks:Emit(15)
			        clone.Wind:Emit(6)
			        clone.Dust:Emit(6)
			        TS:Create(clone.Light, TweenInfo.new(0.5), {
				        Brightness = 0;
					}):Play()
					
					local VoxHitbox1 = voxBreaker:CreateHitbox(Vector3.new(18,18,18), clone.CFrame*CFrame.new(0,0,0), Enum.PartType.Ball, 4,25)

					for i, t in pairs(VoxHitbox1) do
						game.Debris:AddItem(t,0)
						t:SetAttribute("Destroyable", false)
					end
					local VoxHitbox2 = voxBreaker:CreateHitbox(Vector3.new(20,20,20), clone.CFrame*CFrame.new(0,0,0), Enum.PartType.Ball, 4,25)
					for i, t in pairs(VoxHitbox2) do
						t.Size = t.Size * 0.95
						t.Anchored = false
						t:SetAttribute("Destroyable", false)
					end
					
					local Hitbox2 = HitboxHandler.new()
					Hitbox2.Instance = clone
					Hitbox2.Size = Vector3.new(23, 23, 23)
					Hitbox2.onTouch = function(EnemyCharacter)
						if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyCharacter.Humanoid.Health <= 0 then return end

						local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
						local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

						local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 10, 1.45, nil, true, false)

						local LookVector = -CFrame.lookAt(EnemyHumRP.Position, Movepart.Position).LookVector

						if HitInfo.Finisher == true then
							print("Finisher")
						else
							Hit = true

							NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(LookVector.X * 35, 35, LookVector.Z * 10) })
							RagdollHandler.ragdoll(EnemyHumanoid, 2, false, nil, nil)
							StartAirDetect:Fire(EnemyCharacter)
						end
					end

					Hitbox2:Once()
				end
			end)
		end)
		
		AnimationService:playAnimation(Character, MoveAnims["Honored One"].Red.User)
	end
}
