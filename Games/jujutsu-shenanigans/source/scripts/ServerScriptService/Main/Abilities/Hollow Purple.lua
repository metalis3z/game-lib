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
local Vox = require(game.ReplicatedStorage.Modules.VoxBreaker)
local TS = game:GetService('TweenService')
local Debris = game:GetService('Debris')

local AnimationEvents = shared.AnimationEvents
local Utility = shared.Utility
local WeldSystem = shared.WeldSystem

local Sounds = shared.SoundsFolder
local Animations = shared.AnimsFolder
local MoveAnims = shared.MoveAnims
local MoveSounds = shared.MoveSounds

local ReplicateEffects_Set : RemoteEvent = shared.repfire

local rad = shared.rad
local StartAirDetect = shared.AirDetect

return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local Anim = MoveAnims["Honored One"].Hollow.Start
		local AnimTrick = AnimationService:getAnimationTrack(Character, Anim)
		local Stun = StunHandler:Stun(Character,nil,true,0,0,true)
		iFramesService:AddAlliFrames(Character)
		local AnimEvents = {}		
		local Connection : RBXScriptConnection
		
		if Humanoid.Jump == true then
			ReplicateEffects_Set:FireAllClients('Hollow',{Stage = "Fly", Char = Character})
		end
		
		ReplicateEffects_Set:FireAllClients('Hollow',{Stage = "Purple", Char = Character})
		
		task.delay(1.15, function()
			local clone_4_upvr = script.HollowPurple.Purple:Clone()
			clone_4_upvr.Weld.Part1 = HumRP
			clone_4_upvr.Parent = workspace.Effects
			TS:Create(clone_4_upvr, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
				Size = Vector3.new(15, 15, 15);
			}):Play()
			TS:Create(clone_4_upvr.Weld, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
				C1 = CFrame.new(0, 3, -13);
			}):Play()
			TS:Create(clone_4_upvr.PointLight, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Brightness = 10;
			}):Play()
			task.spawn(function() 

				local Highlight = Instance.new("Highlight", clone_4_upvr.Warp)
				Highlight.FillTransparency = 1
				Highlight.OutlineTransparency = 1
				TS:Create(clone_4_upvr.Warp, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Size = Vector3.new(40, 40, 40);
					Transparency = 1;
				}):Play()
				Debris:AddItem(clone_4_upvr.Warp, 0.5)
			end)
			
			Debris:AddItem(clone_4_upvr, 1.30)
		end)
		
		task.delay(2.42, function()
			local clone_6 = script.HollowPurple.PurpleSnap.Center:Clone()
			clone_6.Parent = Character["Right Arm"]
			clone_6.Ring:Emit(1)
			clone_6.Star:Emit(1)
			clone_6.Wave:Emit(1)
			clone_6.Snap1:Emit(20)
			game.Debris:AddItem(clone_6, 1)
			
			local movepart = script.HollowPurple.PurpleProjectile:Clone()
			movepart.Parent = workspace.Effects
			movepart.Weld.Part1 = HumRP
			Debris:AddItem(movepart.Weld, 0.25)
			
			task.delay(0.245, function()
				movepart.Anchored = true
				
				local cf = HumRP.CFrame
				
				local MinimumSize = 4.5
				local Seconds = 75
				local Size = Vector3.new(10.5, 10.5, 10.5)
				local Shape = Enum.PartType.Ball
				local Cframe = nil

				local Hitboxs = Vox.CreateMoveableHitbox(MinimumSize,Seconds,Size,Cframe,Shape)
				Hitboxs:Start()
				Hitboxs:WeldTo(movepart)
				Hitboxs.Touched:Connect(function(Touched)
					for i, v in pairs(Touched) do
						for i, v in pairs(Touched) do
							if v:IsA("BasePart") then
								--[[v.Size = v.Size * 0.95
								local bv = Instance.new("BodyVelocity", v)
								bv.Velocity =  HumRP.CFrame.LookVector * 25
								bv.MaxForce = Vector3.new(10000,900000,10000)
								bv.Name = "Velocity"
								task.spawn(function()
									task.wait(0.2)
									bv:Destroy()
								end)
								v.Anchored = false
								v:SetAttribute("Destroyable", false)]]
								
								
								game.Debris:AddItem(v,0)
								v:SetAttribute("Destroyable", false)
							end
						end
					end
				end)
				
				local Hitbox = HitboxHandler.new()
				Hitbox.Instance = movepart
				Hitbox.Size = Vector3.new(30, 30, 30)
				Hitbox.onTouch = function(EnemyCharacter)
					if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyCharacter.Humanoid.Health <= 0 then return end

					local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
					local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

					local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 65, 1.45, nil, false, false)
					
					local LookVector = -CFrame.lookAt(EnemyHumRP.Position, movepart.Position).LookVector
					
					
					
					if HitInfo.Finisher == true then
						for _, v_2 in EnemyCharacter:GetDescendants() do
							if v_2:IsA("BasePart") or v_2:IsA("Decal") then
								v_2.Transparency = 1
							end
						end
						EnemyCharacter["Left Leg"].Transparency = 0
						local clone_5 = script.LegBurn:Clone()
						clone_5.Weld.Part1 = EnemyCharacter["Left Leg"]
						local Weld = clone_5.Weld
						Weld.C1 *= CFrame.new(0, 1, 0)
						clone_5.Parent = EnemyCharacter
						EnemyCharacter["Right Leg"].Transparency = 0
						local clone_2 = script.LegBurn:Clone()
						clone_2.Weld.Part1 = EnemyCharacter["Right Leg"]
						local Weld_2 = clone_2.Weld
						Weld_2.C1 *= CFrame.new(0, 1, 0)
						clone_2.Parent = EnemyCharacter
						
						local hitglove = script.HitGlow:Clone()
						hitglove.Parent = workspace.Effects

						local f = EnemyCharacter["Right Leg"]
						local l = EnemyCharacter["Left Arm"]
						local r = EnemyCharacter["Right Arm"]
						local g = EnemyCharacter["Left Leg"]
						local h = EnemyCharacter.Head
						local t = EnemyCharacter.Torso

						local f1 = hitglove.Torso.WeldF
						local l1 = hitglove.Torso.WeldL
						local r1 = hitglove.Torso.WeldR
						local g1 = hitglove.Torso.WeldG
						local h1 = hitglove.Torso.WeldH
						local t1 = hitglove.Torso.WeldT

						f1.Part1 = f
						l1.Part1 = l
						r1.Part1 = r
						g1.Part1 = g
						h1.Part1 = h
						t1.Part1 = t

						task.delay(13.15, function()
							hitglove:Destroy()
						end)
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


				TS:Create(movepart, TweenInfo.new(.7125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = cf * CFrame.new(0, 0, -222) }):Play()


				Debris:AddItem(movepart, .805)
			end)
		end)
		
		task.delay(4.45, function()
			iFramesService:RemoveAlliFrames(Character)
			StunHandler:Unstun(Character)
		end)
	

        AnimationService:playAnimation(Character,Anim)
	end
}
