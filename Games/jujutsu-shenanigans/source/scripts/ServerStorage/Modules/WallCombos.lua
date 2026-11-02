local Players = game:GetService('Players')
local SvSt = game:GetService('ServerStorage')
local RS = game:GetService('ReplicatedStorage')
local TS = game:GetService('TweenService')
local Debris = game:GetService('Debris')


local Remotes = RS.Remotes
local SvModules = SvSt.Modules
local RpModules = RS.Modules


local ReplicateSet = Remotes.Replicate.Set


local AnimationEvents = require(RpModules.AnimationEvents)
local AnimationService = require(SvModules.AnimationService)
local StunHandler = require(SvModules.StunHandler)
local DamageService = require(SvModules.DamageHandler)
local RagdollHandler = require(SvModules.RagdollHandler)
local iFramesService = require(SvModules.iFramesService)
local NewKnockback = require(SvModules.BodymoverService)
local CollisionsHandler = require(SvModules.CollisionsModule)
local SoundsModule = require(SvModules.SoundsModule)


local Assets = SvSt.Assets

local Models = Assets.Models
local WallcomboAnims = Assets.Animations.Wallcombos
local WallcomboSound = Assets.Sounds.Wallcombos


return {
	Default = function(Character: Model, EnemyCharacter: Model, Weld: Weld)
		local Player = Players:GetPlayerFromCharacter(Character)
		local HumRP : BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		
		local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
		local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
		local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
		
		HumRP.CFrame *= CFrame.new(0, 0, 3)
		Weld.C0 *= CFrame.new(0, 0, 3)
		
		local HitTrack = AnimationService:getAnimationTrack(Character, WallcomboAnims.Default.Player)
		local VicTrack = AnimationService:getAnimationTrack(EnemyCharacter, WallcomboAnims.Default.Victim)
		
		local HitEvn = AnimationEvents.new(HitTrack)
		local VicEvn = AnimationEvents.new(VicTrack)
		
		
		HitEvn:AddEvent('FirstHit', { .217 }, function()
			DamageService:TakeDamage(Character, EnemyHumanoid, 2, nil, nil, false, false, true, true, false)
			
			ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 2, Roughness = 10, FadeInTime = 0, FadeOutTime = .25 })	
		end)
		
		HitEvn:AddEvent('Hit', { .583, .883, 1.133, 1.783 }, function()
			DamageService:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, false, true, true, false)
			
			ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 2, Roughness = 5, FadeInTime = 0, FadeOutTime = .25 })
		end)
		
		HitEvn:AddEvent('FinalHit', { 2.667 }, function()
			Weld:Destroy()
			
			DamageService:TakeDamage(Character, EnemyHumanoid, 2, nil, nil, false, false, true, true, true)
			
			NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(1, 1, 1) * math.huge, Velocity = (-HumRP.CFrame.LookVector * 40) + Vector3.new(0, 40, 0) })
			RagdollHandler.ragdoll(EnemyHumanoid, 2, false, nil, nil)
			
			ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 2, Roughness = 20, FadeInTime = 0, FadeOutTime = .25 })
		end)
		
		HitEvn:AddEvent('Stopped', {}, function()
			Character:RemoveTag('CantRotate')

			iFramesService:RemoveAlliFrames(Character)

			Humanoid.AutoRotate = true
			HumRP.Anchored = false
		end)
		
		
		VicEvn:AddEvent('Stopped', {}, function()
			EnemyCharacter:RemoveTag('CantRotate')

			iFramesService:RemoveAlliFrames(EnemyCharacter)

			EnemyHumanoid.AutoRotate = true
			EnemyHumRP.Anchored = false
		end)
		
		
		AnimationService:playAnimation(Character, WallcomboAnims.Default.Player)
		HitEvn:Play()
		AnimationService:playAnimation(EnemyCharacter, WallcomboAnims.Default.Victim)
		VicEvn:Play()
		
		local sfx = WallcomboSound.Default.Sound:Clone()
		sfx.SoundGroup = game.SoundService.Sounds
		sfx.Parent = EnemyHumRP
		sfx:Play()
		Debris:AddItem(sfx, sfx.TimeLength + 1)
		
		StunHandler:Stun(Character, HitTrack.Length, true)
		StunHandler:Stun(EnemyCharacter, VicTrack.Length, true)
	end,
	
	KJ = function(Character: Model, EnemyCharacter: Model, Weld: Weld)
		local Player = Players:GetPlayerFromCharacter(Character)
		local HumRP : BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
		local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
		local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid

		
		CollisionsHandler:SetCollisionGroup(Character, 'GrabbedPlayers')
		CollisionsHandler:SetCollisionGroup(EnemyCharacter, 'GrabbedPlayers')
		
		HumRP.CFrame *= CFrame.new(0, 0, 1)

		local HitTrack = AnimationService:getAnimationTrack(Character, WallcomboAnims.KJ.Player)
		local VicTrack = AnimationService:getAnimationTrack(EnemyCharacter, WallcomboAnims.KJ.Victim)

		local HitEvn = AnimationEvents.new(HitTrack)
		local VicEvn = AnimationEvents.new(VicTrack)


		HitEvn:AddEvent('FirstHit', { .150 }, function()
			DamageService:TakeDamage(Character, EnemyHumanoid, 2, nil, nil, false, false, true, true, false)
		end)

		HitEvn:AddEvent('Hit', { 2.933 }, function()
			DamageService:TakeDamage(Character, EnemyHumanoid, 2, nil, nil, false, false, true, true, false)

			ReplicateSet:FireAllClients('rockCircle',{ CF = Character['Right Leg'].CFrame; Radius = 2; Parts = 4; Reverse = false; flyRocks = false; SizeMult = .5; AdaptLength = false; Sound = false })
		end)

		HitEvn:AddEvent('FinalHit', { 5.867 }, function()
			Weld:Destroy()
			
			task.spawn(function()
				VicTrack:Stop()
				EnemyCharacter:RemoveTag('CantRotate')

				iFramesService:RemoveAlliFrames(EnemyCharacter)

				EnemyHumanoid.AutoRotate = true
			end)
			
			DamageService:TakeDamage(Character, EnemyHumanoid, 16, nil, nil, false, false, true, true, true)
			ReplicateSet:FireClient(Player, 'ShakeCamera', { Preset = 'Explosion'; })
			NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(1, 1, 1) * math.huge, Velocity = -HumRP.CFrame.RightVector * 70 })
			RagdollHandler.ragdoll(EnemyHumanoid, 2, false, nil, nil)
		end)

		HitEvn:AddEvent('Stopped', {}, function()
			Character:RemoveTag('CantRotate')

			iFramesService:RemoveAlliFrames(Character)

			CollisionsHandler:SetCollisionGroup(Character, 'Players')
			CollisionsHandler:SetCollisionGroup(EnemyCharacter, 'Players')

			Humanoid.AutoRotate = true
			HumRP.Anchored = false
		end)


		VicEvn:AddEvent('Stopped', {}, function()
			EnemyCharacter:RemoveTag('CantRotate')
			
			iFramesService:RemoveAlliFrames(EnemyCharacter)

			EnemyHumanoid.AutoRotate = true
			EnemyHumRP.Anchored = false
		end)


		--SoundsModule:PlaySound(WallcomboSound.KJ.Player, Character.Torso, 1, 1)
		SoundsModule:PlaySound(WallcomboSound.KJ.Hit, EnemyCharacter.Torso, 1, 1)
		

		AnimationService:playAnimation(Character, WallcomboAnims.KJ.Player)
		HitEvn:Play()
		AnimationService:playAnimation(EnemyCharacter, WallcomboAnims.KJ.Victim)
		VicEvn:Play()
		
		ReplicateSet:FireAllClients('Wallcombo', { Combo = 'KJ'; Stage = 'Start'; Character = Character; EnemyCharacter = EnemyCharacter; })

		StunHandler:Stun(Character, HitTrack.Length, true)
		StunHandler:Stun(EnemyCharacter, VicTrack.Length, true)
	end,
	
	Kokushibo = function(Character: Model, EnemyCharacter: Model, Weld: Weld)
		local Player = Players:GetPlayerFromCharacter(Character)
		local HumRP : BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
		local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
		local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid

		HumRP.CFrame *= CFrame.new(0, 0, 3)
		Weld.C0 *= CFrame.new(0, 0, 3)

		local HitTrack = AnimationService:getAnimationTrack(Character, WallcomboAnims.Kokushibo.Player)
		local VicTrack = AnimationService:getAnimationTrack(EnemyCharacter, WallcomboAnims.Kokushibo.Victim)

		local HitEvn = AnimationEvents.new(HitTrack)
		local VicEvn = AnimationEvents.new(VicTrack)


		HitEvn:AddEvent('FirstHit', { .133 }, function()
			DamageService:TakeDamage(Character, EnemyHumanoid, 2, nil, nil, false, false, true, true, false)

			ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 2, Roughness = 10, FadeInTime = 0, FadeOutTime = .25 })	
		end)

		HitEvn:AddEvent('AnchorSword', { .767 }, function()
			Character.Sword.WeaponHold.Anchored = true
		end)
		
		HitEvn:AddEvent('HalfMoon', { .833 }, function()
			local HalfMoon = Models.Weapons.Kokushibo.HalfMoon:Clone()
			HalfMoon.Parent = Character
			HalfMoon.Size = Vector3.new(0.017, 0.923, 0.923)
			HalfMoon.Weld.Part0 = Character['Left Arm']
			HalfMoon.Weld.C0 = CFrame.new(0, -.5, 0)
			TS:Create(HalfMoon.Weld, TweenInfo.new(.217, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { C0 = CFrame.new(0, -1, 0); C1 = CFrame.Angles(math.rad(65), 0, 0) }):Play()
			
			task.delay(.734, function()
				HalfMoon:Destroy()
				
				ReplicateSet:FireAllClients('Wallcombo', { Combo = 'Kokushibo'; Stage = 'Explosion'; CF = EnemyHumRP.CFrame; })
			end)			
		end)

		HitEvn:AddEvent('Hit', { .383, 1.567 }, function()
			DamageService:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, false, true, true, false)

			ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 2, Roughness = 5, FadeInTime = 0, FadeOutTime = .25 })
		end)

		HitEvn:AddEvent('FinalHit', { 2.333 }, function()
			Weld:Destroy()
			
			Character.Sword.WeaponHold.Anchored = false
			
			DamageService:TakeDamage(Character, EnemyHumanoid, 2, nil, nil, false, false, true, true, true)

			NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(1, 1, 1) * math.huge, Velocity = (-HumRP.CFrame.RightVector * 40) + Vector3.new(0, 40, 0) })
			RagdollHandler.ragdoll(EnemyHumanoid, 2, false, nil, nil)

			ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 2, Roughness = 20, FadeInTime = 0, FadeOutTime = .25 })
		end)

		HitEvn:AddEvent('Stopped', {}, function()
			Character:RemoveTag('CantRotate')

			iFramesService:RemoveAlliFrames(Character)

			Humanoid.AutoRotate = true
			HumRP.Anchored = false
		end)


		VicEvn:AddEvent('Stopped', {}, function()
			EnemyCharacter:RemoveTag('CantRotate')

			iFramesService:RemoveAlliFrames(EnemyCharacter)

			EnemyHumanoid.AutoRotate = true
			EnemyHumRP.Anchored = false
		end)


		AnimationService:playAnimation(Character, WallcomboAnims.Kokushibo.Player)
		HitEvn:Play()
		AnimationService:playAnimation(EnemyCharacter, WallcomboAnims.Kokushibo.Victim)
		VicEvn:Play()

		SoundsModule:PlaySound(WallcomboSound.Kokushibo.Sound, HumRP)

		StunHandler:Stun(Character, HitTrack.Length, true)
		StunHandler:Stun(EnemyCharacter, VicTrack.Length, true)
	end,
	
	Jun = function(Character: Model, EnemyCharacter: Model, Weld: Weld)
		local Player = Players:GetPlayerFromCharacter(Character)
		local HumRP : BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
		local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
		local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid

		local Katana = Models.Weapons.Jun.Katana:Clone()
		Katana.Katana.RightHandle.Part0 = Character['Right Arm']
		Katana.Sheathe.LeftHandle.C0 = CFrame.new(-1, -0.999999762, -1.1920929E-6, 0.999997139, 0, 0, 0, 0.939693272, -0.342020482, 0, 0.342020482, 0.939693272)
		Katana.Sheathe.LeftHandle.Part0 = Character['Torso']
		Katana.Katana.RightHandle.Enabled = false
		Katana.Sheathe.Sheathed.Enabled = true
		Katana.Parent = Character

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
		
		CollisionsHandler:SetCollisionGroup(Character, 'GrabbedPlayers')
		CollisionsHandler:SetCollisionGroup(EnemyCharacter, 'GrabbedPlayers')


		local UserAnim = WallcomboAnims.Jun.User
		local UserTrack = AnimationService:getAnimationTrack(Character, WallcomboAnims.Jun.User)
		local UserEvents = {}
		
		UserEvents['Slam1'] = UserTrack:GetMarkerReachedSignal('Slam1'):Once(function()
			DamageService:TakeDamage(Character, EnemyHumanoid, 8, nil, nil, false, false, true, true, false, nil, nil)
		end)
		
		UserEvents['Slam2'] = UserTrack:GetMarkerReachedSignal('Slam2'):Once(function()
			DamageService:TakeDamage(Character, EnemyHumanoid, 8, nil, nil, false, false, true, true, false, nil, nil)
		end)
		
		UserEvents['Unsheathe'] = UserTrack:GetMarkerReachedSignal('Unsheathe'):Once(function()
			Katana.Katana.RightHandle.Enabled = true
			Katana.Sheathe.Sheathed.Enabled = false
		end)
		
		UserEvents['Slash'] = UserTrack:GetMarkerReachedSignal('Slash'):Once(function()
			Weld:Destroy()
			
			StunHandler:Unstun(EnemyCharacter, EnemyStun)
			iFramesService:RemoveAlliFrames(EnemyCharacter)
			
			EnemyCharacter:RemoveTag('CantRotate')
			EnemyHumanoid.AutoRotate = true
			
			CollisionsHandler:SetCollisionGroup(EnemyCharacter, 'Players')
			
			ReplicateSet:FireAllClients('Destroy', { cf = HumRP.CFrame * CFrame.new(0, 0, -4), size = Vector3.new(1, 1, 1) * 8, burn = false, vel = Vector3.new(0, 125, 0) })
			
			DamageService:TakeDamage(Character, EnemyHumanoid, 8, nil, nil, false, false, true, true, true, nil, 10)
			RagdollHandler.ragdoll(EnemyHumanoid, 2)
			NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(0, 100000, 0), Velocity = Vector3.new(0, 100, 0) })
		end)
		
		UserTrack.Stopped:Once(function()
			for _,v in UserEvents do
				v:Disconnect()
			end
			
			Katana:Destroy()
			
			HumRP.Anchored = false
			StunHandler:Unstun(Character, Stun)
			iFramesService:RemoveAlliFrames(Character)
			
			Character:RemoveTag('CantRotate')
			Humanoid.AutoRotate = true
			
			CollisionsHandler:SetCollisionGroup(Character, 'Players')
		end)
		
		ReplicateSet:FireAllClients('JunWallcomo', { Part = EnemyHumRP })
		
		AnimationService:playAnimation(Character, UserAnim)
		AnimationService:playAnimation(EnemyCharacter, WallcomboAnims.Jun.Victim)
		
		SoundsModule:PlaySound(WallcomboSound.Jun.User, HumRP)
		SoundsModule:PlaySound(WallcomboSound.Jun.UserVoice, HumRP)
		SoundsModule:PlaySound(WallcomboSound.Jun.Victim, EnemyHumRP)
	end,
	
	['Strongest of Today'] = function(Character: Model, EnemyCharacter: Model, Weld: Weld)
		local Player = Players:GetPlayerFromCharacter(Character)
		local HumRP : BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
		local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
		local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid

		HumRP.CFrame *= CFrame.new(0, 0, 3)
		Weld.C0 *= CFrame.new(0, 0, 3)

		if EnemyPlayer then
			ReplicateSet:FireClient(EnemyPlayer, 'UpdateVictimCFrame', { CF = EnemyHumRP.CFrame })
		end

		local HitTrack = AnimationService:getAnimationTrack(Character, WallcomboAnims["Strongest of Today"].Player)
		local VicTrack = AnimationService:getAnimationTrack(EnemyCharacter, WallcomboAnims["Strongest of Today"].Victim)

		local HitEvn = AnimationEvents.new(HitTrack)
		local VicEvn = AnimationEvents.new(VicTrack)

		ReplicateSet:FireAllClients('Wallcombo', { Combo = 'Strongest of Today'; Stage = 'All'; rootpart2 = EnemyHumRP })

		HitEvn:AddEvent('hit1', { .08 }, function()
			DamageService:TakeDamage(Character, EnemyHumanoid, 15, nil, nil, false, false, true, true, false)
			ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 3, Roughness = 20, FadeInTime = 0, FadeOutTime = .25 })
		end)

		HitEvn:AddEvent('hit2', { 1.22 }, function()
			DamageService:TakeDamage(Character, EnemyHumanoid, 35, nil, nil, false, false, true, true, false)
			ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 5, Roughness = 20, FadeInTime = 0, FadeOutTime = .35 })

			ReplicateSet:FireClient(Player, 'Wallcombo', { Combo = 'Strongest of Today'; Stage = 'Start' })
			if EnemyPlayer then
				ReplicateSet:FireClient(EnemyPlayer, 'Wallcombo', { Combo = 'Strongest of Today'; Stage = 'Start' })
			end
		end)

		HitEvn:AddEvent('hit3', { 3.86 }, function()
			Weld:Destroy()
			DamageService:TakeDamage(Character, EnemyHumanoid, 85, nil, nil, false, false, true, true, true)
			ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 7, Roughness = 20, FadeInTime = 0, FadeOutTime = .5 })

			for i, v in pairs(EnemyCharacter:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Transparency = 1
				end
				if v:IsA("Decal") then
					v.Transparency = 1
				end
			end
		end)

		HitEvn:AddEvent('Stopped', {}, function()
			Character:RemoveTag('CantRotate')

			Humanoid.AutoRotate = true
			HumRP.Anchored = false
		end)


		VicEvn:AddEvent('Stopped', {}, function()
			EnemyCharacter:RemoveTag('CantRotate')

			iFramesService:RemoveAlliFrames(EnemyCharacter)

			EnemyHumanoid.AutoRotate = true
			EnemyHumRP.Anchored = false
		end)

		--local sfx = SvSt.Assets.Sounds.Wallcombos['Strongest of Today'].Sound:Clone()
		--sfx.Parent = EnemyHumRP
		--sfx:Play()
		--Debris:AddItem(sfx, sfx.TimeLength + 1)

		AnimationService:playAnimation(Character, WallcomboAnims["Strongest of Today"].Player)
		HitEvn:Play()
		AnimationService:playAnimation(EnemyCharacter, WallcomboAnims["Strongest of Today"].Victim)
		VicEvn:Play()

		StunHandler:Stun(Character, HitTrack.Length, true)
		StunHandler:Stun(EnemyCharacter, VicTrack.Length, true)
	end,
	
	['Bald Hero'] = function(Character: Model, EnemyCharacter: Model, Weld: Weld)
		local Player = Players:GetPlayerFromCharacter(Character)
		local HumRP : BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
		local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
		local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid

		EnemyHumRP.CFrame *= CFrame.new(0, 0, -2)
		HumRP.CFrame = EnemyHumRP.CFrame * CFrame.new(0, 0, -5.7) * CFrame.Angles(0, math.rad(180), 0)

		if EnemyPlayer then
			ReplicateSet:FireClient(EnemyPlayer, 'UpdateVictimCFrame', { CF = EnemyHumRP.CFrame })
		end

		local HitTrack = AnimationService:getAnimationTrack(Character, WallcomboAnims["Bald Hero"].Player)
		local VicTrack = AnimationService:getAnimationTrack(EnemyCharacter, WallcomboAnims["Bald Hero"].Victim)

		local HitEvn = AnimationEvents.new(HitTrack)
		local VicEvn = AnimationEvents.new(VicTrack)


		HitEvn:AddEvent('FirstHit', { .217 }, function()
			DamageService:TakeDamage(Character, EnemyHumanoid, 15, nil, nil, false, false, true, true, false)

			ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 3, Roughness = 20, FadeInTime = 0, FadeOutTime = .25 })
		end)

		HitEvn:AddEvent('FinalHit', { 2.7 }, function()
			Weld:Destroy()
			
			ReplicateSet:FireClient(Player, 'ShakeCamera', { Magnitude = 5, Roughness = 26, FadeInTime = 0, FadeOutTime = .25 })

			DamageService:TakeDamage(Character, EnemyHumanoid, 2, nil, nil, false, false, true, true, true)

			NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(1, 1, 1) * math.huge, Velocity = (-HumRP.CFrame.LookVector * 40) + Vector3.new(0, 40, 0) })
			RagdollHandler.ragdoll(EnemyHumanoid, 2, false, nil, nil)
		end)

		HitEvn:AddEvent('Stopped', {}, function()
			Character:RemoveTag('CantRotate')

			iFramesService:RemoveAlliFrames(Character)

			Humanoid.AutoRotate = true
			HumRP.Anchored = false
		end)


		VicEvn:AddEvent('Stopped', {}, function()
			EnemyCharacter:RemoveTag('CantRotate')

			iFramesService:RemoveAlliFrames(EnemyCharacter)

		EnemyHumanoid.AutoRotate = true
			EnemyHumRP.Anchored = false
		end)


		AnimationService:playAnimation(Character, WallcomboAnims["Bald Hero"].Player)
		HitEvn:Play()
		AnimationService:playAnimation(EnemyCharacter, WallcomboAnims["Bald Hero"].Victim)
		VicEvn:Play()

		local sfx = SvSt.Assets.Sounds.Wallcombos["Bald Hero"].Sound:Clone()
		sfx.Parent = HumRP
		sfx:Play()
		Debris:AddItem(sfx, sfx.TimeLength + 1)

		StunHandler:Stun(Character, HitTrack.Length, true)
		StunHandler:Stun(EnemyCharacter, VicTrack.Length, true)
	end,
}