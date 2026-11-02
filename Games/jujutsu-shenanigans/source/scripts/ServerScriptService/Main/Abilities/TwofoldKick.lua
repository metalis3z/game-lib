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
		
		local Anim = MoveAnims["Honored One"].Kick.TwofoldKick
		local FinisherAnim = MoveAnims["Honored One"].Kick.Finisher
		local HitAnim = MoveAnims["Honored One"].Kick.TwofoldHit
		
		local Stun = StunHandler:Stun(Character,nil,true,0,0,true)
		
		task.delay(0.25, function()
			local Trail = script.CombatTrail:Clone()
			Trail.Parent = workspace.Thrown
			for _, v in pairs(Trail:GetChildren()) do
				v.Parent = Character["Right Leg"]
				task.delay(.65,function()
					v:Destroy()
					Trail:Destroy()
				end)
			end
		end)
		
		task.delay(0.45, function()
			local clone_2 = script.Twofold:Clone()
			clone_2.CFrame = HumRP.CFrame * CFrame.new(0, -2, -2) * CFrame.Angles(-0.2617993877991494, 0, 0)
			clone_2.Transparency = 0.5
			clone_2.Parent = workspace.Effects
			clone_2.Swing2.Swing1:Emit(10)
			TS:Create(clone_2, TweenInfo.new(0.3), {
				CFrame = clone_2.CFrame + clone_2.CFrame.UpVector * 3;
				Size = Vector3.new(0, 10, 0);
			}):Play()
			Debris:AddItem(clone_2, 0.4)
			
			SoundsModule:PlaySound(MoveSounds["Honored One"]["Kick"].Fist3, HumRP)
			
			local Hitbox = HitboxHandler.new()
		    Hitbox.Instance = HumRP
		    Hitbox.Size = Vector3.new(1,1,1) * 8
		    Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
		    Hitbox.onTouch = function(EnemyCharacter)
			    if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyCharacter.Humanoid.Health <= 0 then return end

			    local EnemyHumanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				
				local HitInfo
				
				SoundsModule:PlaySound(MoveSounds["Honored One"]["Kick"].RushBreak, EnemyHumRP)
				
				if EnemyHumanoid.Health <= 16 then
					HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0, 1.45, nil, false, false)
				else
					HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 7, 1.45, nil, false, false)
				end
				
				local LookVector = -CFrame.lookAt(EnemyHumRP.Position, HumRP.Position).LookVector
				
				NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(LookVector.X * 1, 25, LookVector.Z * 1) })
				RagdollHandler.ragdoll(EnemyHumanoid, 2, false, nil, nil)
			end
			Hitbox:Start()
			task.delay(0.25, function()
				Hitbox:Destroy()
			end)
		end)
		
		task.delay(1.045, function()
			local Trail = script.CombatTrail:Clone()
			Trail.Parent = workspace.Thrown
			for _, v in pairs(Trail:GetChildren()) do
				v.Parent = Character["Right Leg"]
				task.delay(.35,function()
					v:Destroy()
					Trail:Destroy()
				end)
			end
			
			StunHandler:Unstun(Character, Stun)
			
			SoundsModule:PlaySound(MoveSounds["Honored One"]["Kick"].Fist2, HumRP)
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(1,1,1) * 9
			Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
			Hitbox.onTouch = function(EnemyCharacter)
				if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyCharacter.Humanoid.Health <= 0 then return end

				local EnemyHumanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				
				local HitInfo
				
				local LookVector = -CFrame.lookAt(EnemyHumRP.Position, HumRP.Position).LookVector
				
				if EnemyHumanoid.Health <= 9 then
					AnimationService:stopAll(Character)
					AnimationService:playAnimation(Character, FinisherAnim)
					AnimationService:playAnimation(EnemyCharacter, HitAnim)
					RagdollHandler.cancelRagdoll(EnemyCharacter)
					
					SoundsModule:PlaySound(MoveSounds["Honored One"]["ReversalRed"].Aim, HumRP)
					
					local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -4.75) * CFrame.Angles(0, rad(-180), 0), 6)
					Weld:Start()
					task.delay(0.25, function()
						SoundsModule:PlaySound(MoveSounds["Honored One"]["ReversalRed"].Throw, HumRP)
						SoundsModule:PlaySound(MoveSounds["Honored One"]["ReversalRed"].Wind, HumRP)
						
						local sound = game.ServerStorage.Assets.Sounds.Moves["Honored One"].ReversalRed.Charge:Clone()
						sound.Parent = HumRP
						sound:Play()
						Debris:AddItem(sound, 0.1)
						
						local red = script.ReversalRed:Clone()
						red.Parent = workspace.Effects
						red.Weld.Part0 = Character:WaitForChild("Left Arm")
						Debris:AddItem(red, .75)

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
					end)
					
					EnemyHumanoid.AutoRotate = false
					EnemyCharacter:AddTag('CantRotate')
					
					ReplicateEffects_Set:FireAllClients('Rd',{Stage = "Fly", Char = Character})
					local cf = HumRP.CFrame
					TS:Create(HumRP, TweenInfo.new(.4125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = cf * CFrame.new(0, 12, 0) }):Play()
					
					
					task.delay(1.067, function()
						SoundsModule:PlaySound(MoveSounds["Honored One"]["ReversalRed"].Explode, HumRP)
						
						local clone = script.RedExplode:Clone()
						clone.Position = HumRP.Position + Vector3.new(0,0,-2)
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
						
						if Weld then
							Weld:Stop()
							Weld = nil
						end
						
						DamageHandler:TakeDamage(Character, EnemyHumanoid, 9, 1.75, nil, false, false)
						NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(LookVector.X * 155, 35, LookVector.Z * 155) })
						RagdollHandler.ragdoll(EnemyHumanoid, 10, false, nil, nil)
					end)
				else
					HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 9, 1.75, nil, false, false)
					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(LookVector.X * 10, 25, LookVector.Z * 10) })
					RagdollHandler.ragdoll(EnemyHumanoid, 2, false, nil, nil)
				end

				
				SoundsModule:PlaySound(MoveSounds["Honored One"]["Kick"].DivergentHit, EnemyHumRP)
				
				
				local clone = script.Twofold.Sparks:Clone()
				clone.Parent = HumRP.RootAttachment
				clone:Emit(20)
				Debris:AddItem(clone, 0.4)
				--var4_upvw:Flash(arg1_5, Color3.new(1, 1, 1))
				
			end
			Hitbox:Start()
			task.delay(0.25, function()
				Hitbox:Destroy()
			end)
		end)
		
		AnimationService:playAnimation(Character, Anim)
	end
}