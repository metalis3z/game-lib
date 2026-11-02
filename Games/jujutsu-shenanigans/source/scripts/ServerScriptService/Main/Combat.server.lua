--// Services \\--

local TS = game:GetService('TweenService')
local RS = game:GetService('ReplicatedStorage')
local SvSt = game:GetService('ServerStorage')
local Players = game:GetService('Players')
local Debris = game:GetService('Debris')



--// Bindables \\--

local StartAirDetection = SvSt.Bindables.AirDetector



--// Remotes \\--

local CombatRemotes = RS.Remotes.Combat

local CombatGet = CombatRemotes.Get
local CombatSet = CombatRemotes.Set

local CombatSetEvent = CombatSet.OnServerEvent


local ReplicateRemotes = RS.Remotes.Replicate

local ReplicateGet = ReplicateRemotes.Get
local ReplicateSet = ReplicateRemotes.Set


local Comunicator: RemoteEvent = RS.Remotes.Comunicator.Set



--// Server Modules \\--

local SvModules = SvSt.Modules

local DamageHandler = require(SvModules.DamageHandler)
local HitboxHandler = require(SvModules.HitboxHandler)
local RagdollHandler = require(SvModules.RagdollHandler)
local StunHandler = require(SvModules.StunHandler)
local AnimationService = require(SvModules.AnimationService)
local NewKnockback = require(SvModules.BodymoverService)
local iFramesService = require(SvModules.iFramesService)
local WeaponsHandler = require(SvModules.WeaponsHandler)
local KnockbackModule = require(SvModules.KnockbackModule)



--// Replicated Modules \\--

local RpModules = RS.Modules
local VoxBreak = require(RpModules.VoxBreaker)
local AnimationEvents = require(RpModules.AnimationEvents)
local Utility = require(RpModules.Utility)



----//// ASSETS \\\\----

local Assets = SvSt.Assets

--// Animations \\--

local Animations = Assets.Animations


local CombatAnims = Animations.Combat



--// Sounds \\--

local Sounds = Assets.Sounds


local CombatSounds = Sounds.Combat



--// Combat Variables \\--

local ThrowableCs = {}
local LastPunch = {}
local MaxCombo = 4



--// Functions \\--

function ChangeCombo(Char: Model)
	if not Char:GetAttribute('Combo') then
		Char:SetAttribute('Combo', 0)
	end
	
	
	if LastPunch[Char] then
		if (time() - LastPunch[Char]) >= 1.5 then
			Char:SetAttribute('Combo', 1)
		else
			if Char:GetAttribute('Combo') >= MaxCombo then
				Char:SetAttribute('Combo', 1)
			else
				Char:SetAttribute('Combo', Char:GetAttribute('Combo') + 1)
			end
		end
	else
		Char:SetAttribute('Combo', Char:GetAttribute('Combo') + 1)
	end
	
	LastPunch[Char] = time()
	
	return Char:GetAttribute('Combo')
end

function GetPunchAnim(Char: Model, Uppercut, Downslam)
	local CurrentCombo = Char:GetAttribute('Combo')


	local PunchesFolder = CombatAnims.Punches.Default
	local Player = Players:GetPlayerFromCharacter(Char)
	if Player and CombatAnims.Punches:FindFirstChild(Player.Configuration.Moveset.Value) then
		PunchesFolder = CombatAnims.Punches[Player.Configuration.Moveset.Value]
	end
	
	local Hum: Humanoid = Char.Humanoid
	local Animator: Animator = Hum.Animator
	local Animation
	
	if CurrentCombo < MaxCombo then
		Animation = PunchesFolder[tostring(CurrentCombo)]
	else
		if not Uppercut and not Downslam then
			Animation = PunchesFolder[tostring(MaxCombo)]
		else
			if Downslam then
				Animation = CombatAnims.Punches.Downslam
			else
				if Uppercut then
					if Char:HasTag('HasSword') then
						Animation = CombatAnims.Punches.SwordUppercut
					else
						Animation = CombatAnims.Punches.Uppercut
					end
				end
			end
		end
	end
	
	return Animation
end


local DashGetFunctions = {
	CheckSideDash = function(Character: Model, currDirection: string)
		local Humanoid: Humanoid = Character.Humanoid
		
		
		local returnValue
		
		if not Character:HasTag('Ragdolled') then
			if Character:HasTag('SideDashCD') or Character:HasTag('CantSideDash') or Character:HasTag('Stunned') then
				returnValue = false
			else
				returnValue = true
			end
		else
			if Character:HasTag('CantRagdollCancel') or not Character:HasTag('RagdollCancel') then
				returnValue = false
			else
				if Character:HasTag('RagdollCancel') then
					returnValue = true

					RagdollHandler.cancelRagdoll(Humanoid, true, false, nil)

					Character:RemoveTag('RagdollCancel')
					task.delay(30, function()
						Character:AddTag('RagdollCancel')
					end)
				else
					returnValue = false
				end
			end
		end
		
		if returnValue then
			local HumRP: BasePart = Character.HumanoidRootPart
			local Animator: Animator = Character.Humanoid.Animator
			
			
			ReplicateSet:FireAllClients('DashCharacter', { Type = 'Side'; Character = Character; Right = currDirection == 'Right'; })			
			AnimationService:playAnimation(Character, Assets.Animations.Combat.Dashes['Dash'..currDirection])
			
			
			local SFX = CombatSounds.Dashing.SideDash:Clone()
			SFX.Parent = HumRP
			SFX:Play()
			Debris:AddItem(SFX, SFX.TimeLength + 1)
			
			
			RS.Remotes.Comunicator.Set:FireClient(Players:GetPlayerFromCharacter(Character), 'TriggerJump', { Value = false })
			Character:AddTag('CantDash')
			Character:AddTag('SideDashCD')
			task.delay(2,function()
				Character:RemoveTag('SideDashCD')
			end)
			task.delay(.6, function()
				RS.Remotes.Comunicator.Set:FireClient(Players:GetPlayerFromCharacter(Character), 'TriggerJump', { Value = true })
				Character:RemoveTag('CantDash')
			end)
		end
		
		return returnValue
	end,
	
	CheckBackDash = function(Character: Model)
		local Humanoid: Humanoid = Character.Humanoid


		local returnValue

		if not Character:HasTag('Ragdolled') then
			if Character:HasTag('DashCD') or Character:HasTag('CantDash') or Character:HasTag('Stunned') then
				returnValue = false
			else
				if not Character:HasTag('DashCD') and not Character:HasTag('CantDash') then
					returnValue = true
				else
					returnValue = false
				end
			end
		else
			if Character:HasTag('CantRagdollCancel') or not Character:HasTag('RagdollCancel') then
				returnValue = false
			else
				if Character:HasTag('RagdollCancel') and not Character:HasTag('CantRagdollCancel') then
					returnValue = true

					RagdollHandler.cancelRagdoll(Humanoid, true, false, nil)

					Character:RemoveTag('RagdollCancel')
					task.delay(30, function()
						Character:AddTag('RagdollCancel')
					end)
				else
					returnValue = false
				end
			end
		end

		if returnValue then
			local HumRP: BasePart = Character.HumanoidRootPart
			local Animator: Animator = Character.Humanoid.Animator
			
			
			ReplicateSet:FireAllClients('DashCharacter', { Type = 'Back'; Character = Character; })
			AnimationService:playAnimation(Character, Assets.Animations.Combat.Dashes.DashBack)


			local SFX = CombatSounds.Dashing.BackDash:Clone()
			SFX.Parent = HumRP
			SFX:Play()
			Debris:AddItem(SFX, SFX.TimeLength + 1)



			RS.Remotes.Comunicator.Set:FireClient(Players:GetPlayerFromCharacter(Character), 'TriggerJump', { Value = false })
			Character:AddTag('CantSideDash')
			Character:AddTag('DashCD')
			task.delay(4,function()
				Character:RemoveTag('DashCD')
			end)
			task.delay(1.051, function()
				RS.Remotes.Comunicator.Set:FireClient(Players:GetPlayerFromCharacter(Character), 'TriggerJump', { Value = true })
				Character:RemoveTag('CantSideDash')
			end)
		end

		return returnValue
	end,
	
	CheckFrontDash = function(Character: Model)
		if Character:HasTag('Stunned') then return end

		local Player = Players:GetPlayerFromCharacter(Character)
		local HumRP : BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		local returnValue = false
		local detectWall = false

		local opars = OverlapParams.new()
		opars.FilterType = Enum.RaycastFilterType.Include
		opars.FilterDescendantsInstances = { workspace.Map }

		local ray: RaycastResult
		local rpars = RaycastParams.new()
		rpars.FilterType = Enum.RaycastFilterType.Include
		rpars.FilterDescendantsInstances = { workspace.Map }


		local hitparts = workspace:GetPartBoundsInBox(HumRP.CFrame * CFrame.new(0, 0, -3.5), Vector3.new(1, 1, 1) * 7, opars)
		if #hitparts > 0 then
			for _, Part: Part in hitparts do
				ray = workspace:Raycast(HumRP.Position, CFrame.new(HumRP.Position, Vector3.new(Part.Position.X, HumRP.Position.Y, Part.Position.Z)).LookVector * 7, rpars)

				if Part and Part.Parent and Part:HasTag('Combeable') and not Part:HasTag('Destroyed') and Character:GetAttribute('Combo') == 4 and Character:FindFirstChild('DamagerLog') and Character.DamagerLog.TimeRemaining.Value > Character.DamagerLog:GetAttribute('CombatStateDuration') - 2 and Character.DamagerLog.Value:HasTag('Ragdolled') and ray then
					detectWall = true

					break
				end
			end
		end
		
		returnValue = false
		
		if detectWall and not Character:HasTag('WallcomboCD') then
			
			local EnemyCharacter: Model = Character.DamagerLog.Value
			if not EnemyCharacter then return end
			local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
			if not EnemyHumanoid or (EnemyHumanoid and EnemyHumanoid.Health <= 0) then return end
			local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
			if not EnemyHumRP then return end
			

			AnimationService:stopAll(Character)
			AnimationService:stopAll(EnemyCharacter)
			RagdollHandler.cancelRagdoll(EnemyHumanoid, true, false ,nil)
			
			
			EnemyCharacter:AddTag('CantRotate')

			Character:AddTag('CantRotate')
			
			
			iFramesService:AddAlliFrames(Character)
			iFramesService:AddAlliFrames(EnemyCharacter)
			
			Humanoid.AutoRotate = false
			HumRP.Anchored = true
			EnemyHumRP.Anchored = true
			EnemyHumanoid.AutoRotate = false
			EnemyHumRP.CFrame = CFrame.lookAlong(Vector3.new(ray.Position.X, HumRP.Position.Y, ray.Position.Z), ray.Normal.Unit)
			EnemyHumRP.Orientation = Vector3.new(0, EnemyHumRP.Orientation.Y, EnemyHumRP.Orientation.Z)
			
			
			local Wallcmb = require(SvModules.WallCombos)[Player.Configuration.Moveset.Value] or require(SvModules.WallCombos).Default
			Wallcmb(Character, EnemyCharacter)
		else
			returnValue = not Character:HasTag('CantDash') or not Character:HasTag('DashCD')
			
			if Character:HasTag('CantDash') or Character:HasTag('DashCD') then
				returnValue = false
			else
				if not Character:HasTag('CantDash') and not Character:HasTag('DashCD') then
					returnValue = true
				else
					returnValue = false
				end
			end

			task.spawn(function()
				if returnValue then
					local Player = Players:GetPlayerFromCharacter(Character)
					
					
					local DashStart = CombatAnims.Dashes.DashFront
					if Character:HasTag('HasSword') then
						WeaponsHandler:TriggerSeath(Character, false)
						
						DashStart = CombatAnims.Dashes.Sword.DashFront
					end
					

					local AnimTrack = AnimationService:getAnimationTrack(Character, DashStart)
					local HitEvents = AnimationEvents.new(AnimTrack)

					AnimationService:stopAll(Character)


					task.spawn(function()
						local Hit = false
						local Ended = false
						local Stun = StunHandler:Stun(Character, 1.25)
						local Start = time()
						local NearEnemys = {}
						for _, CloseEnemy in workspace.Live:GetChildren() do
							if CloseEnemy == Character then continue end
							
							local CloseHumRP: BasePart = CloseEnemy:FindFirstChild('HumanoidRootPart')
							if CloseHumRP then
								if (CloseHumRP.Position - HumRP.Position).Magnitude < 30 then
									table.insert(NearEnemys, CloseEnemy)
								end
							end
						end
						
						HitEvents:AddEvent('Hit', { .150 }, function()
							task.spawn(function()
								local EnemiesTable: Model = RS.Remotes.Comunicator.Get:InvokeClient(Player, { Func = 'Hitbox'; Instance = HumRP; Size = Vector3.new(1, 1, 1) * 7; Offset = CFrame.new(0, 0, -3.5); Time = 'Once'; Method = 'Multiple'; })
								if EnemiesTable == nil then return end
								
								ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 2; Roughness = 50; FadeInTime = 0; FadeOutTime = .25 })
								
								for _,EnemyCharacter: Model in EnemiesTable do
									if not EnemyCharacter:FindFirstChild("HumanoidRootPart") then return end
									
									local EnemyHumRP = EnemyCharacter.HumanoidRootPart
									local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
									local Ragdolled = EnemyCharacter:HasTag('Ragdolled')
									local inAir = EnemyCharacter:HasTag('inAir')
									local AirnRag = Ragdolled == true and inAir == true


									if EnemyCharacter == Character or EnemyHumanoid.Health <= 0 or iFramesService:HasiFrame(EnemyCharacter, 'M1') then continue end

									if not Ragdolled or (Ragdolled and inAir) then
										local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 4, 1, Assets.Animations.Combat.Hits[tostring(math.random(1,4))], true, true, true)

										if HitInfo.Countered == true then return end

										Hit = true

										if HitInfo.CouldHit == true or Ragdolled then
											ReplicateSet:FireAllClients('Dash', { Stage = 'HitFX', HitPart = EnemyCharacter.Torso })

											local SFX
											if Character:HasTag('HasSword') then
												SFX = Assets.Sounds.Combat.Dashing.FrontDashSwordHit:Clone()
											else
												SFX = Assets.Sounds.Combat.Dashing.FrontDashHit:Clone()
											end

											SFX.Parent = EnemyHumRP
											SFX:Play()
											Debris:AddItem(SFX, SFX.TimeLength + 1)

											task.delay(.1, function()
												StunHandler:Unstun(Character, Stun)
											end)

											if Ragdolled then
												RagdollHandler.cancelRagdoll(EnemyHumanoid, true, true, HumRP)
											elseif table.find(NearEnemys, EnemyCharacter) then
												--KnockbackModule:Knockback(EnemyCharacter, HumRP.CFrame.LookVector * 250, Character)
											end
										else
											local SFX = Assets.Sounds.Combat.Hits.Blocked:Clone()
											SFX.Parent = EnemyHumRP
											SFX:Play()
											Debris:AddItem(SFX, SFX.TimeLength + 1)
										end
									end
								end
							end)
						end)

						AnimationService:playAnimation(Character, DashStart)
						ReplicateSet:FireAllClients('DashCharacter', { Type = 'Front'; Character = Character; })

						
						task.delay(.283, function()
							AnimationService:adjustSpeed(Character, DashStart, 0)

							local EnemiesTable: Model = RS.Remotes.Comunicator.Get:InvokeClient(Player, { Func = 'Hitbox'; Instance = HumRP; Size = Vector3.new(1, 1, 1) * 7; Offset = CFrame.new(0, 0, -3.5); Time = .6; Method = 'Multiple'; })
							if EnemiesTable == nil then return end

							for _,EnemyCharacter: Model in EnemiesTable do
								if EnemyCharacter == Character or not EnemyCharacter:FindFirstChild("HumanoidRootPart") then continue end

								local EnemyHumRP = EnemyCharacter.HumanoidRootPart
								local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
								local Ragdolled = EnemyCharacter:HasTag('Ragdolled')
								local inAir = EnemyCharacter:HasTag('inAir')
								
								if EnemyHumanoid.Health <= 0 then continue end

								if not Ragdolled or (Ragdolled and inAir) then
									if Ended == false then
										Ended = true

										local SwingSFX
										if Character:HasTag('HasSword') and Character.Sword:GetAttribute('Seathed') == false then
											SwingSFX = Assets.Sounds.Combat.Swings.Default.Slash['1']:Clone()
										else
											SwingSFX = Assets.Sounds.Combat.Dashing.FrontDashSwing:Clone()
										end
										SwingSFX.Parent = HumRP
										SwingSFX:Play()
										Debris:AddItem(SwingSFX, SwingSFX.TimeLength + 1)


										AnimationService:adjustSpeed(Character, DashStart, 1)
										HitEvents:Play()

										CombatSet:FireAllClients(Character)
									end
								end
							end
						end)

						task.wait(.7)

						if not Ended then
							Ended = true


							local SwingSFX
							if Character:HasTag('HasSword') and Character.Sword:GetAttribute('Seathed') == false then
								SwingSFX = Assets.Sounds.Combat.Swings.Default.Slash['1']:Clone()
							else
								SwingSFX = Assets.Sounds.Combat.Dashing.FrontDashSwing:Clone()
							end
							SwingSFX.Parent = HumRP
							SwingSFX:Play()
							Debris:AddItem(SwingSFX, SwingSFX.TimeLength + 1)


							AnimationService:adjustSpeed(Character, DashStart, 1)
							HitEvents:Play()
						end
					end)

					Character:AddTag('CantDash')
					Character:AddTag('DashCD')
					task.delay(4,function()
						Character:RemoveTag('CantDash')
						Character:RemoveTag('DashCD')
					end)

					local humrpCF = HumRP.CFrame * CFrame.Angles(math.rad(90),0,0)

					task.spawn(function()
						local sfx = Assets.Sounds.Combat.Dashing.FrontDash:Clone()
						sfx.Parent = HumRP
						sfx:Play()
						Debris:AddItem(sfx, sfx.TimeLength + 1)
					end)
					
					if Player.Configuration.Moveset.Value == 'Test' then
						local c = script.FasterM1Trail:Clone()
						c.Parent = workspace.Thrown
						for _, v in pairs(c:GetChildren()) do
							v.Parent = Character["Right Arm"]
							task.delay(1.25,function()
								v:Destroy()
								c:Destroy()
							end)
						end
					end
					
					local FirstProps = { Size = Vector3.new(.6,.6,.6), Transparency = 0 }
					local FinalProps = { Size = Vector3.new(12,.6,12), Transparency = 1 }
					local TN_Info = { Time = .25, Style = 'Sine', Direction = 'Out' }

					ReplicateSet:FireAllClients('Ring',{ FirstProps = FirstProps, CF = humrpCF, TN_Info = TN_Info, FinalProps = FinalProps } )
				end
			end)
		end

		return returnValue
	end,
}



--// Combat System \\--

local PunchTimings = {
	['Default'] = {
		['1'] = { Hit = .233, End = .350 }, 
		['2'] = { Hit = .183, End = .300 }, 
		['3'] = { Hit = .283, End = .417 },
		['4'] = { Hit = .233, End = .350 }
	},
	
	['KJ'] = {
		['1'] = { Hit = .167, End = .417 }, 
		['2'] = { Hit = .167, End = .467 }, 
		['3'] = { Hit = .133, End = .450 },
		['4'] = { Hit = .217, End = .683 }
	},
	
	['Honored One'] = {
		['1'] = { Hit = .167, End = .417 }, 
		['2'] = { Hit = .167, End = .467 }, 
		['3'] = { Hit = .133, End = .450 },
		['4'] = { Hit = .217, End = .683 }
	},

	['Downslam'] = { Swing = .183, Hit = .283, End = .650 },
	['Uppercut'] = { Swing = .233, Hit = .433, End = .617 }
}

CombatSetEvent:Connect(function(Player, Action, Params)
	local Character = Player.Character
	local HumRP: BasePart = Character.HumanoidRootPart
	local Humanoid: Humanoid = Character.Humanoid
	local Animator: Animator = Humanoid.Animator
	local ElPrimooo = Player.Configuration.Moveset.Value == 'El Primo'
	
	if not Character or not HumRP or not Humanoid or not Animator then return end
	
	if Action == 'Punch' then
		if Character:HasTag('CantPunch') or Character:HasTag('PunchCDS') or Character:HasTag('ThrowableGrabbed') or Character:HasTag('Stunned') or Character:HasTag('Blocking') then return end

		Character:AddTag('Punching')
		Character:AddTag('PunchCDS')

		
		local PerfectBlock = Character:HasTag('PerfectBlock')
		Character:RemoveTag('PerfectBlock')
		local Hit = false
		local CurrentCombo = ChangeCombo(Character)
		local CurrentType
		
		
		Comunicator:FireClient(Player, 'TriggerJump', { Value = false })
		
		Params.Downslam = Humanoid:GetState() == Enum.HumanoidStateType.Freefall
		
		
		if CurrentCombo >= MaxCombo then
			Character:SetAttribute('DefaultRunSpeed', 0)
			Character:SetAttribute('DefaultWalkSpeed', 0)
			
			Humanoid.WalkSpeed = 0
			
			local VoxHitbox2 = VoxBreak:CreateHitbox(Vector3.new(5.25,5.250,5.25), HumRP.CFrame*CFrame.new(0,0,-3), Enum.PartType.Block, 3.84,25)
			for i, t in pairs(VoxHitbox2) do

				--t.Size = t.Size * 0.95
				local bv = Instance.new("BodyVelocity", t)
				bv.Velocity =  HumRP.CFrame.LookVector * 25
				bv.MaxForce = Vector3.new(90000,90000,90000)
				bv.Name = "Velocity"
				task.spawn(function()
					task.wait(0.2)
					bv:Destroy()
				end)
				t.Anchored = false
				t:SetAttribute("Destroyable", false)
			end
			
			if Params.Downslam then
				CurrentType = 'Downslam'
			elseif Params.Uppercut then
				CurrentType = 'Uppercut'
			else
				CurrentType = tostring(CurrentCombo)
			end
		else
			Character:SetAttribute('DefaultRunSpeed', 16)
			Character:SetAttribute('DefaultWalkSpeed', 16)
			
			Humanoid.WalkSpeed = 16
			
			
			CurrentType = tostring(CurrentCombo)
		end


		local PunchAnim: Animation = GetPunchAnim(Character, Params.Uppercut, Params.Downslam)
		local PunchAnimTrack = AnimationService:getAnimationTrack(Character, PunchAnim)
		local AnimEvents = AnimationEvents.new(PunchAnimTrack)
		
		
		local CurrentTimings
		if CurrentType == 'Downslam' or CurrentType == 'Uppercut' then
			CurrentTimings = PunchTimings[CurrentType]
		else
			local Current
			if Character:FindFirstChild('Sword') then
				if Character.Sword:GetAttribute('Seathed') == true then
					Current = PunchTimings.Default
				else
					Current = PunchTimings[Player.Configuration.Moveset.Value]
				end
			else
				Current = PunchTimings[Player.Configuration.Moveset.Value] or PunchTimings.Default
				
				if Player.Configuration.Moveset.Value == 'Vessel' and not Character:FindFirstChild("SucunaValue") then
					if CurrentCombo == 1 then
						local c = script.HitGlow["Right Arm"]:Clone()
						c.Parent = workspace.Thrown
						c.Color = Color3.new(1, 0, 0)
						Debris:AddItem(c, 0.55)
						
						local c2 = script.Character.Vessel.Trail:Clone()
						c2.Parent = workspace.Thrown
						for _, v in pairs(c2:GetChildren()) do
							v.Parent = Character["Right Arm"]
							task.delay(.15,function()
								v:Destroy()
								c2:Destroy()
							end)
						end
						--c2.Color = c.Color
						
						local weld = Instance.new("Weld", Character:WaitForChild("Right Arm"))
						weld.Part0 = Character:WaitForChild("Right Arm")
						weld.Part1 = c
						
						
					elseif CurrentCombo == 2 then
						local c = script.HitGlow["Left Arm"]:Clone()
						c.Parent = workspace.Thrown
						c.Color = Color3.new(1, 0, 0)
						Debris:AddItem(c, 0.55)
						
						local c2 = script.Character.Vessel.Trail:Clone()
						c2.Parent = workspace.Thrown
						for _, v in pairs(c2:GetChildren()) do
							v.Parent = Character["Left Arm"]
							task.delay(.15,function()
								v:Destroy()
								c2:Destroy()
							end)
						end
						--c2.Color = c.Color
						
						local weld = Instance.new("Weld", Character:WaitForChild("Left Arm"))
						weld.Part0 = Character:WaitForChild("Left Arm")
						weld.Part1 = c
						
					elseif CurrentCombo == 3 then
						local c = script.HitGlow["Right Arm"]:Clone()
						c.Parent = workspace.Thrown
						c.Color = Color3.new(1, 0, 0)
						Debris:AddItem(c, 0.55)

						local c2 = script.Character.Vessel.Trail:Clone()
						c2.Parent = workspace.Thrown
						for _, v in pairs(c2:GetChildren()) do
							v.Parent = Character["Right Arm"]
							task.delay(.15,function()
								v:Destroy()
								c2:Destroy()
							end)
						end
						--c2.Color = c.Color

						local weld = Instance.new("Weld", Character:WaitForChild("Right Arm"))
						weld.Part0 = Character:WaitForChild("Right Arm")
						weld.Part1 = c
						
					elseif CurrentCombo == 4 then
						local c = script.HitGlow["Right Leg"]:Clone()
						c.Parent = workspace.Thrown
						c.Color = Color3.new(1, 0, 0)
						Debris:AddItem(c, 0.55)
						
						--[[local VoxHitbox2 = VoxBreak:CreateHitbox(Vector3.new(5.25,5.250,5.25), HumRP.CFrame*CFrame.new(0,0,-3), Enum.PartType.Block, 4,25)
						for i, t in pairs(VoxHitbox2) do

							t.Size = t.Size * 0.95
							local bv = Instance.new("BodyVelocity", t)
							bv.Velocity =  HumRP.CFrame.LookVector * 25
							bv.MaxForce = Vector3.new(90000,90000,90000)
							bv.Name = "Velocity"
							task.spawn(function()
								task.wait(0.2)
								bv:Destroy()
							end)
							t.Anchored = false
							t:SetAttribute("Destroyable", false)
						end]]
						
						local c2 = script.Character.Vessel.Trail:Clone()
						c2.Parent = workspace.Thrown
						for _, v in pairs(c2:GetChildren()) do
							v.Parent = Character["Right Leg"]
							task.delay(.15,function()
								v:Destroy()
								c2:Destroy()
							end)
						end
						--c2.Color = c.Color
						
						local weld = Instance.new("Weld", Character:WaitForChild("Right Leg"))
						weld.Part0 = Character:WaitForChild("Right Leg")
						weld.Part1 = c
					end
				elseif Player.Configuration.Moveset.Value == 'Honored One' then
					if CurrentCombo == 1 then
						local c = script.HitGlow["Right Arm"]:Clone()
						c.Parent = workspace.Thrown
						c.Color = Color3.new(0, 0.6, 1)
						Debris:AddItem(c, 0.55)

						local c2 = script.Character.Gojo.Trail:Clone()
						c2.Parent = workspace.Thrown
						for _, v in pairs(c2:GetChildren()) do
							v.Parent = Character["Right Arm"]
							task.delay(.15,function()
								v:Destroy()
								c2:Destroy()
							end)
						end
						--c2.Color = c.Color

						local weld = Instance.new("Weld", Character:WaitForChild("Right Arm"))
						weld.Part0 = Character:WaitForChild("Right Arm")
						weld.Part1 = c


					elseif CurrentCombo == 2 then
						local c = script.HitGlow["Left Arm"]:Clone()
						c.Parent = workspace.Thrown
						c.Color = Color3.new(0, 0.6, 1)
						Debris:AddItem(c, 0.55)

						local c2 = script.Character.Gojo.Trail:Clone()
						c2.Parent = workspace.Thrown
						for _, v in pairs(c2:GetChildren()) do
							v.Parent = Character["Left Arm"]
							task.delay(.15,function()
								v:Destroy()
								c2:Destroy()
							end)
						end
						--c2.Color = c.Color

						local weld = Instance.new("Weld", Character:WaitForChild("Left Arm"))
						weld.Part0 = Character:WaitForChild("Left Arm")
						weld.Part1 = c

					elseif CurrentCombo == 3 then
						local c = script.HitGlow["Right Arm"]:Clone()
						c.Parent = workspace.Thrown
						c.Color = Color3.new(0, 0.6, 1)
						Debris:AddItem(c, 0.55)

						local c2 = script.Character.Gojo.Trail:Clone()
						c2.Parent = workspace.Thrown
						for _, v in pairs(c2:GetChildren()) do
							v.Parent = Character["Right Arm"]
							task.delay(.15,function()
								v:Destroy()
								c2:Destroy()
							end)
						end
						--c2.Color = c.Color

						local weld = Instance.new("Weld", Character:WaitForChild("Right Arm"))
						weld.Part0 = Character:WaitForChild("Right Arm")
						weld.Part1 = c

					elseif CurrentCombo == 4 then
						local c = script.HitGlow["Right Leg"]:Clone()
						c.Parent = workspace.Thrown
						c.Color = Color3.new(0, 0.6, 1)
						Debris:AddItem(c, 0.55)

						--[[local VoxHitbox2 = VoxBreak:CreateHitbox(Vector3.new(5.25,5.250,5.25), HumRP.CFrame*CFrame.new(0,0,-3), Enum.PartType.Block, 4,25)
						for i, t in pairs(VoxHitbox2) do

							t.Size = t.Size * 0.95
							local bv = Instance.new("BodyVelocity", t)
							bv.Velocity =  HumRP.CFrame.LookVector * 25
							bv.MaxForce = Vector3.new(90000,90000,90000)
							bv.Name = "Velocity"
							task.spawn(function()
								task.wait(0.2)
								bv:Destroy()
							end)
							t.Anchored = false
							t:SetAttribute("Destroyable", false)
						end]]

						local c2 = script.Character.Gojo.Trail:Clone()
						c2.Parent = workspace.Thrown
						for _, v in pairs(c2:GetChildren()) do
							v.Parent = Character["Right Leg"]
							task.delay(.15,function()
								v:Destroy()
								c2:Destroy()
							end)
						end
						--c2.Color = c.Color

						local weld = Instance.new("Weld", Character:WaitForChild("Right Leg"))
						weld.Part0 = Character:WaitForChild("Right Leg")
						weld.Part1 = c
					end
				elseif Character:FindFirstChild("SucunaValue") and Player.Configuration.Moveset.Value == 'Vessel' then
					if CurrentCombo == 1 then
						print("1")
						local Model = Instance.new("Model", workspace.Effects)
						Debris:AddItem(Model, 0.65)
						local Highlight_5 = Instance.new("Highlight", Model)
						Highlight_5.DepthMode = Enum.HighlightDepthMode.Occluded
						Highlight_5.FillTransparency = 0
						Highlight_5.FillColor = Color3.new(0, 0, 0)
						for _ = 1, 10 do
							local var26_upvr = CFrame.new(HumRP.Position, HumRP.Position) * CFrame.new(math.random(-20, 20) / 10, math.random(-20, 20) / 10, 0) * CFrame.Angles(0, 0, math.rad(math.random(0, 360)))
							local clone_5_upvr = script.Character.Vessel.Awk.DismantleFly:Clone()
							clone_5_upvr.CFrame = HumRP.CFrame
							clone_5_upvr.Parent = Model
							task.delay(0, function()
								TS:Create(clone_5_upvr, TweenInfo.new(0.1), {
									Size = Vector3.new(15, 0, 0);
									CFrame = var26_upvr + var26_upvr.LookVector * 30;
								}):Play()
								task.delay(0.1, function()
									clone_5_upvr.Transparency = 1
								end)
								task.delay(0.05, function()
									clone_5_upvr:Destroy()
								end)
							end)
						end
					end
				end
			end

			CurrentTimings = Current[CurrentType]
		end
		
		local SwingTime = { CurrentTimings.Swing or 0 }
		local HitTime = { CurrentTimings.Hit }
		local EndTime = CurrentTimings.End
		if ElPrimooo == true and CurrentType ~= 'Downslam' and CurrentType ~= 'Uppercut' then
			HitTime = CurrentTimings.Hit
			SwingTime = CurrentTimings.Swing
		end


		if CurrentTimings.Trail ~= nil then
			WeaponsHandler:TriggerTrail(Character, true)
			task.delay(EndTime, function()
				WeaponsHandler:TriggerTrail(Character, false)
			end)
		end

		
		AnimEvents:AddEvent('Swing', SwingTime, function()
			local SwingsFolder = CombatSounds.Swings:FindFirstChild(Player.Configuration.Moveset.Value)
			if not SwingsFolder then
				if Character:HasTag('HasSword') and Character.Sword:GetAttribute('Seathed') == false then
					SwingsFolder = CombatSounds.Swings.Default.Slash
				else
					SwingsFolder = CombatSounds.Swings.Default.Punch
				end
			end
			
			local SwingSFX = SwingsFolder[tostring(CurrentCombo)]:Clone()
			SwingSFX.Parent = HumRP
			SwingSFX:Play()
			Debris:AddItem(SwingSFX, SwingSFX.TimeLength + 1)
		end)
		
		
		AnimEvents:AddEvent('Hit', HitTime, function()
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			if Params.Downslam or Params.Uppercut then
				Hitbox.Size = Vector3.new(1,2,1) * 7
				Hitbox.Offset = CFrame.new(0,-Hitbox.Size.Y/2,-Hitbox.Size.Z/2)
			else
				if Character:FindFirstChild("SucunaValue") then
					Hitbox.Size = Vector3.new(1,1,2) * 7
					Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
				else
					Hitbox.Size = Vector3.new(1,1,1) * 7
					Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
				end
			end
			Hitbox.onTouch = function(EnemyCharacter: Model)
				if not EnemyCharacter:FindFirstChild("HumanoidRootPart") then return end
				
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyAnimator: Animator = EnemyHumanoid.Animator
				
				if EnemyCharacter == Character or (CurrentType ~= 'Downslam' and (EnemyHumanoid.Health <= 0 or EnemyCharacter:HasTag('Ragdolled'))) or iFramesService:HasiFrame(EnemyCharacter, 'M1') then return end
				
				local Blockable = true
				if CurrentType == 'Downslam' then
					Blockable = false
				end
				
				local Dmg = 4
				if ElPrimooo == true then
					Dmg = 4/3
				end
				if PerfectBlock == true then
					Dmg = 4
				end
				
				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, Dmg, 1, Assets.Animations.Combat.Hits[tostring(CurrentCombo)], Blockable, true, false, true, true, 'M1')


				if HitInfo.Countered == true then return end


				if HitInfo.Blocked == true then
					local SFX: Sound
					if EnemyCharacter:HasTag('PerfectBlock') == true then
						--SFX = CombatSounds.Hits.PerfectBlocked:Clone()
						--SFX = CombatSounds.Hits.Blocked:Clone()
					else
						SFX = CombatSounds.Hits.Blocked:Clone()
					end
					SFX.Parent = EnemyHumRP
					SFX:Play()
					Debris:AddItem(SFX, SFX.TimeLength + 1)
				else
					Hit = true
					
					local HitsFolder = CombatSounds.Hits:FindFirstChild(Player.Configuration.Moveset.Value)
					if not HitsFolder then
						if Character:HasTag('HasSword') and Character.Sword:GetAttribute('Seathed') == false then
							HitsFolder = CombatSounds.Hits.Default.Stab
						else
							HitsFolder = CombatSounds.Hits.Default.Punch
						end
					end

					local SFX: Sound = HitsFolder[tostring(CurrentCombo)]:Clone()
					SFX.Parent = EnemyHumRP
					SFX:Play()
					Debris:AddItem(SFX, SFX.TimeLength + 1)
					
					--[[if PerfectBlock == true then
						ReplicateSet:FireAllClients('PerfectHit', { MainPart = EnemyHumRP; })
						
						local Perfect_SFX: Sound = CombatSounds.Hits.PerfectHit:Clone()
						Perfect_SFX.Parent = EnemyHumRP
						Perfect_SFX:Play()
						Debris:AddItem(Perfect_SFX, Perfect_SFX.TimeLength + 1)
					end]]
					
					
					if CurrentCombo >= MaxCombo then
						local FirstProps = { Size = Vector3.new(.6, .6, .6), Transparency = 0 }
						local FinalProps = { Size = Vector3.new(12, .6, 12), Transparency = 1 }
						local TN_Info = { Time = .25, Style = 'Quad', Direction = 'Out' }

						if CurrentType == 'Downslam' then
							--ReplicateSet:FireAllClients('Ring',{ FirstProps = FirstProps, CF = EnemyHumRP.CFrame, TN_Info = TN_Info, FinalProps = FinalProps } )
							--ReplicateSet:FireAllClients('rockCircle',{CF = EnemyHumRP.CFrame; Radius = 5; Parts = 4, flyRocks = true})
							
							if HitInfo.Finisher == true then
								local Stun = StunHandler:Stun(Character, nil, true)
								Humanoid.AutoRotate = false
								iFramesService:AddAlliFrames(Character)
								Character:AddTag('CantRotate')
								
								task.delay(.084, function()
									local FinisherAnim = CombatAnims.Punches.DownslamFinishers['Variation'..tostring(math.random(1, 3))]
									local FinisherEvents = AnimationEvents.new(AnimationService:getAnimationTrack(Character, FinisherAnim))
									FinisherEvents:AddEvent('Hit', { FinisherAnim:GetAttribute('Hit') }, function()
										local KnockbackHitbox = HitboxHandler.new()
										KnockbackHitbox.Instance = HumRP.CFrame
										KnockbackHitbox.Size = Vector3.new(1, 1, 1) * 14
										KnockbackHitbox.onTouch = function(EChar)
											if EChar == Character or iFramesService:HasiFrame(EChar, 'M1') then return end
											
											NewKnockback:Knockback(EChar, { KnockbackType = 'Velocity'; MaxForce = Vector3.new(1, 1, 1) * 40000; Velocity = Vector3.new(0, 100, 0) })
											RagdollHandler.ragdoll(EChar.Humanoid, 2, false, nil, nil)
										end
										KnockbackHitbox:Once()
										KnockbackHitbox:Destroy()
										
										ReplicateSet:FireAllClients('rockCircle', { CF = HumRP.CFrame; Radius = 7; Parts = 4; Reverse = false; flyRocks = true; Circles = 2; SizeMult = 1.5; RadiusMult = 1.25; AdaptLength = false; XMult = 2; YRotMult = 12; })
										
										Humanoid.AutoRotate = true
										iFramesService:RemoveAlliFrames(Character)
										StunHandler:Unstun(Character, Stun)
										Character:RemoveTag('CantRotate')
									end)
									
									AnimationService:playAnimation(Character, FinisherAnim)
									FinisherEvents:Play()
								end)
							end
						else
							if CurrentType == 'Uppercut' then
								ReplicateSet:FireAllClients('Ring',{ FirstProps = FirstProps, CF = EnemyHumRP.CFrame, TN_Info = TN_Info, FinalProps = FinalProps } )
								NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(0, 1, 0) * 10000, Velocity = Vector3.new(0, 1, 0) * 70 })
							else
								NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(10000, 10000, 10000), Velocity = Vector3.new(HumRP.CFrame.LookVector.X * 20, 20, HumRP.CFrame.LookVector.Z * 20) })
							end
							
							StartAirDetection:Fire(EnemyCharacter)
						end
						
						RagdollHandler.ragdoll(EnemyHumanoid,2)
					end
				end
			end

			Hitbox:Once()
			Hitbox:Destroy()
		end)
		
		local Cancelled = true
		local function EndFunction()
			if Cancelled == false then return end
			Cancelled = false
			
			Character:RemoveTag('Punching')

			task.spawn(function()
				local WaitTime = .15
				if CurrentCombo >= MaxCombo then
					if Hit == false then
						task.wait(WaitTime * 2)
					end
				else
					task.wait(WaitTime)
				end

				if not Character:HasTag('Punching') and not Character:HasTag('Stunned') and not Character:HasTag('Ragdolled') then
					Character:SetAttribute('DefaultRunSpeed', 25)
					Character:SetAttribute('DefaultWalkSpeed', 16)
					Character:SetAttribute('DefaultJumpPower', 50)

					Comunicator:FireClient(Player, 'TriggerJump', { Value = true })
					Humanoid.WalkSpeed = 16
				end
			end)

			if CurrentCombo >= MaxCombo then
				task.delay(1.5, function()
					Character:RemoveTag('PunchCDS')
				end)
			else
				Character:RemoveTag('PunchCDS')
			end
		end
		
		AnimEvents:AddEvent('End', { EndTime }, EndFunction)
		AnimEvents:AddEvent('Stopped', {}, EndFunction)
		
		AnimationService:playAnimation(Character, PunchAnim)
		AnimEvents:Play()
		
		if Character:HasTag('HasSword') then
			WeaponsHandler:TriggerSeath(Character, false)
		end
	elseif Action == 'Block' then
		if Params.Stage == true then
			if Character:HasTag('CantBlock') or Character:HasTag('Stunned') or Character:HasTag('Blocking') or Character:HasTag('Punching') or Character:HasTag('ThrowableGrabbed') then return end

			local Actions = {
				'CantPunch',
				'CantDash',
				'CantSideDash',
				'CantBlock',
				'Blocking',
				'CantRun'
			}
			
			local Anim
			
			local FigGui = game.Players:GetPlayerFromCharacter(Character)
			
			if Character:HasTag('HasSword') and Character.Sword:GetAttribute('Seathed') == false then
				Anim = Animations.Combat.BlockSword
			--elseif Player.Configuration.Moveset.Value == 'Secret Flame' then
			--	Anim = Animations.Combat.BlockMahito
			--elseif Player.Configuration.Moveset.Value == "Restless Gambler" then
			--	Anim = Animations.Combat.BlockHakari	
			else
				Anim = Animations.Combat.Block
			end
			
			local BlockAnimTrack: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
			
			BlockAnimTrack.Stopped:Once(function()
				Character:SetAttribute('DefaultRunSpeed', 25)
				Character:SetAttribute('DefaultWalkSpeed', 16)
				Character:SetAttribute('DefaultJumpPower', 50)
				
				Humanoid.WalkSpeed = 16
				Comunicator:FireClient(Player, 'TriggerJump', { Value = true })
				
				for _, Action in Actions do
					Character:RemoveTag(Action)
				end
			end)
			
			AnimationService:playAnimation(Character, Anim)
			
			
			Character:SetAttribute('DefaultRunSpeed', 8)
			Character:SetAttribute('DefaultWalkSpeed', 8)
			
			Humanoid.WalkSpeed = 8
			Comunicator:FireClient(Player, 'TriggerJump', { Value = false })
			

			for _, Action in Actions do
				Character:AddTag(Action)
			end
			
			
			local Perfect = true
			local PC: RBXScriptConnection
			PC = Character.ChildAdded:Connect(function(Child)
				if Child.Name == 'DamagedLog' and Child:HasTag('IsM1') and Perfect == true then
					if PC then
						PC:Disconnect()
						PC = nil
					end
					
					Character:AddTag('PerfectBlock')
					task.delay(1, function()
						Character:RemoveTag('PerfectBlock')
					end)
				end
			end)
			
			task.delay(.25, function()
				if PC then
					PC:Disconnect()
					PC = nil
				end
				
				Perfect = false
			end)
		else
			AnimationService:stopAnimation(Character, Animations.Combat.Block)
			--AnimationService:stopAnimation(Character, Animations.Combat.Block)
			--AnimationService:stopAnimation(Character, Animations.Combat.bl)
		end
	elseif Action == 'Throwable' then
		if Character:HasTag('CantThrowable') then return end
		
		if Params.Stage == 'Grab' then
			assert(Params.Throwable, Player.Name..' tried to throw a nil throwable.')
			
			local ThrowablePart: Part = Params.Throwable
			
			if (ThrowablePart.Position - HumRP.Position).Magnitude <= 14 then
				Character:AddTag('ThrowableGrabbed')
				ThrowablePart:RemoveTag('Throwable')
				ThrowablePart:SetAttribute('OriginalCF', ThrowablePart.CFrame)
				
				
				local GrabAnimSpeed = 2
				local PickupAnim = AnimationService:getAnimationTrack(Character, Animations.Throwables.Pickup)
				local PickupAnimEvents = AnimationEvents.new(PickupAnim)
				
				
				StunHandler:Stun(Character, PickupAnim.Length/GrabAnimSpeed, true)
				task.delay(PickupAnim.Length/GrabAnimSpeed, function()
					task.wait(.1)
					
					Character:SetAttribute('DefaultRunSpeed', 16)
					Character:SetAttribute('DefaultWalkSpeed', 16)
					
					Humanoid.WalkSpeed = 16
					Comunicator:FireClient(Player, 'TriggerJump', { Value = true })
				end)
				
				
				PickupAnimEvents:AddEvent('Pickup', { .533/GrabAnimSpeed }, function()
					Character:SetAttribute('DefaultRunSpeed', 16)
					Character:SetAttribute('DefaultWalkSpeed', 16)
					
					Humanoid.WalkSpeed = 16
					Comunicator:FireClient(Player, 'TriggerJump', { Value = true })
					
					
					ThrowablePart.Anchored = false
					ThrowablePart.Massless = true
					
					local Weld = script.ThrowableWeld:Clone()
					Weld.Parent = HumRP
					Weld.Part0 = HumRP
					Weld.Part1 = ThrowablePart
					Weld.C0 = CFrame.new(0, -1, -3) * CFrame.Angles(math.rad(-30), 0, 0)
					Weld.C1 = CFrame.new(0, .5, 0)
					
					
					local sfx = Sounds.Other.TrashGrab:Clone()
					sfx.Parent = ThrowablePart
					sfx:Play()
					Debris:AddItem(sfx, sfx.TimeLength + 1)
					
					ThrowableCs[Character] = game.CollectionService:GetInstanceAddedSignal('Stunned'):Connect(function(Object)
						if Object == Character then
							ThrowableCs[Character]:Disconnect()
							ThrowableCs[Character] = nil
							
							Character:RemoveTag('ThrowableGrabbed')
							Character:SetAttribute('DefaultRunSpeed', 25)
							Character:SetAttribute('DefaultWalkSpeed', 16)
							Character:SetAttribute('DefaultJumpPower', 50)
							
							Humanoid.WalkSpeed = 16
							Comunicator:FireClient(Player, 'TriggerJump', { Value = true })
							
							AnimationService:stopAnimation(Character, Animations.Throwables.Idle)
							
							Weld:Destroy()
							
							task.delay(10, function()
								local Clone = ThrowablePart:Clone()
								Clone.Anchored = true
								Clone.Massless = false
								Clone.CFrame = Clone:GetAttribute('OriginalCF')
								Clone:AddTag('Throwable')
								Clone.Parent = workspace.Map.Throwables

								ThrowablePart:Destroy()
							end)
						end
					end)
				end)
				
				PickupAnimEvents:AddEvent('Lift', { 1/GrabAnimSpeed }, function()
					local Weld: Weld = HumRP:FindFirstChild('ThrowableWeld')
					
					if Weld then
						TS:Create(Weld, TweenInfo.new(.217/GrabAnimSpeed, Enum.EasingStyle.Linear), { C0 = CFrame.new(0, 3.5, 0) * CFrame.Angles(math.rad(90), 0, 0), C1 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0) }):Play()
					end
				end)
				
				PickupAnimEvents:AddEvent('Stopped', {}, function()
					AnimationService:playAnimation(Character, Animations.Throwables.Idle)
				end)
				
				AnimationService:playAnimation(Character, Animations.Throwables.Pickup, GrabAnimSpeed)
				PickupAnimEvents:Play()
			end
		elseif Params.Stage == 'Throw' then
			local ThrowablePart
			
			local ThrowAnim = AnimationService:getAnimationTrack(Character, Animations.Throwables.Throw)
			local ThrowAnimEvents = AnimationEvents.new(ThrowAnim)

			ThrowAnimEvents:AddEvent('Throw', { .633 }, function()
				Character:RemoveTag('ThrowableGrabbed')
				Character:SetAttribute('DefaultRunSpeed', 25)
				Character:SetAttribute('DefaultWalkSpeed', 16)
				Character:SetAttribute('DefaultJumpPower', 50)
				
				Humanoid.WalkSpeed = 16
				Comunicator:FireClient(Player, 'TriggerJump', { Value = true })
				
				
				for _, Weld: Weld in HumRP:GetChildren() do
					if Weld:IsA('Weld') and Weld.Name == 'ThrowableWeld' then
						ThrowablePart = Weld.Part1
						
						Weld:Destroy()
					end
				end
				
				
				ThrowablePart.AssemblyLinearVelocity = HumRP.CFrame.LookVector * 120


				task.delay(10, function()
					local Clone = ThrowablePart:Clone()
					Clone.Anchored = true
					Clone.Massless = false
					Clone.CFrame = Clone:GetAttribute('OriginalCF')
					Clone:AddTag('Throwable')
					Clone.Parent = workspace.Map.Throwables
					
					ThrowablePart:Destroy()
				end)
				
				--ThrowablePart:AddTag('Throwable')
				
				local hitFloor = false
				local hitChars = { Character }
				
				local opars = OverlapParams.new()
				opars.FilterType = Enum.RaycastFilterType.Include
				opars.FilterDescendantsInstances = { workspace.Live }
				
				local pars = RaycastParams.new()
				pars.FilterType = Enum.RaycastFilterType.Include
				pars.FilterDescendantsInstances = { workspace.Map }
				
				
				local c: RBXScriptConnection
				c = game:GetService('RunService').Heartbeat:Connect(function()
					if not ThrowablePart or ThrowablePart.AssemblyLinearVelocity.Magnitude < 1 then
						c:Disconnect()
					else
						if not hitFloor then
							if workspace:Raycast(ThrowablePart.Position, Vector3.new(0, -1, 0), pars) then
								hitFloor = true
								
								local sfx = Sounds.Other.TrashHit:Clone()
								sfx.Parent = ThrowablePart
								sfx:Play()
								Debris:AddItem(sfx, sfx.TimeLength + 1)
							end
						end
						
						local parts = workspace:GetPartsInPart(ThrowablePart, opars)
						if #parts > 0 then
							for _, Part: Part in parts do
								if Part and Part.Parent:FindFirstChild('Humanoid') and not table.find(hitChars, Part.Parent) and Part.Parent.Humanoid.Health > 0 then
									local EnemyCharacter: Model = Part.Parent
									local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
									local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
									
									table.insert(hitChars, EnemyCharacter)
									
									if EnemyCharacter:HasTag('Ragdolled') or iFramesService:HasiFrame(EnemyCharacter, 'Throwables') then return end


									DamageHandler:TakeDamage(Character, EnemyHumanoid, 16, nil, nil, false, true, false, true)


									if EnemyCharacter:HasTag('Countering') then return end
									
									local sfx = Sounds.Other.TrashDmg:Clone()
									sfx.Parent = EnemyHumRP
									sfx:Play()
									Debris:AddItem(sfx, sfx.TimeLength + 1)
									

									RagdollHandler.ragdoll(EnemyHumanoid, 2, false)
									EnemyHumRP.AssemblyLinearVelocity = ThrowablePart.AssemblyLinearVelocity / 3
								end
							end
						end
					end
				end)
			end)
			
			ThrowAnimEvents:AddEvent('Stopped', {}, function()
				if HumRP:FindFirstChild('ThrowableWeld') then
					for _, Weld: Weld in HumRP:GetChildren() do
						if Weld:IsA('Weld') and Weld.Name == 'ThrowableWeld' then
							Character:RemoveTag('ThrowableGrabbed')
							Character:SetAttribute('DefaultRunSpeed', 25)
							Character:SetAttribute('DefaultWalkSpeed', 16)
							Character:SetAttribute('DefaultJumpPower', 50)
							
							Humanoid.WalkSpeed = 16
							Comunicator:FireClient(Player, 'TriggerJump', { Value = true })
							

							Weld:Destroy()
							
							
							task.delay(10, function()
								if ThrowablePart and ThrowablePart.Parent then
									local Clone = ThrowablePart:Clone()
									Clone.Anchored = true
									Clone.Massless = false
									Clone.CFrame = Clone:GetAttribute('OriginalCF')
									Clone:AddTag('Throwable')
									Clone.Parent = workspace.Map.Throwables

									ThrowablePart:Destroy()
								end
							end)
						end
					end
				end
			end)
			
			
			AnimationService:stopAnimation(Character, Animations.Throwables.Idle)
			AnimationService:playAnimation(Character, Animations.Throwables.Throw)
			ThrowAnimEvents:Play()
			
			
			local Wld = HumRP:FindFirstChild('ThrowableWeld')
			if Wld then
				TS:Create(Wld, TweenInfo.new(.533, Enum.EasingStyle.Linear), { C0 = CFrame.new(0, 2, 2) * CFrame.Angles(math.rad(140), 0, 0) }):Play()
				
				task.delay(.533, function()
					TS:Create(Wld, TweenInfo.new(.1, Enum.EasingStyle.Linear), { C0 = CFrame.new(0, 3.25, -1.25) * CFrame.Angles(math.rad(70), 0, 0) }):Play()
				end)
			end
			
			ThrowableCs[Character]:Disconnect()
			ThrowableCs[Character] = nil
			
			StunHandler:Stun(Character, ThrowAnim.Length, true)
		end
	end
end)

CombatGet.OnServerInvoke = function(Player, Function, currDirection)
	assert(DashGetFunctions[Function], 'The dash function especified does not exist')
	
	local Character = Player.Character
	
	if Character:HasTag('ThrowableGrabbed') then
		return false
	end
	
	return DashGetFunctions[Function](Character, currDirection)
end