--// Services \\--

local SvSt = game:GetService('ServerStorage')
local TS = game:GetService('TweenService')
local RS = game:GetService('ReplicatedStorage')



--// Comunication \\--

local ReplicateSet = RS.Remotes.Replicate.Set


local EmotesComms = RS.Remotes.Emotes

local EmotesGet = EmotesComms.Get
local EmotesSet = EmotesComms.Set




--// Modules \\--

local RpModules = RS.Modules

local WeldSystem = require(RpModules.WeldSystem)


local SvModules = SvSt.Modules

local AnimationService = require(SvModules.AnimationService)
local SoundsModule = require(SvModules.SoundsModule)

local ShakeCameraModule = require(game.ReplicatedFirst.ShakeCamera)


--// Local Functions \\--

local function TriggerHumanoid(Character: Model, Params: { any })
	local Humanoid: Humanoid = Character.Humanoid
	
	Character:SetAttribute('DefaultRunSpeed', Params.RS)
	Character:SetAttribute('DefaultWalkSpeed', Params.WS)
	Character:SetAttribute('DefaultJumpPower', Params.JP)

	Humanoid.WalkSpeed = Params.WS
	Humanoid.JumpPower = Params.JP
	Humanoid.AutoRotate = Params.AR
end



return {

	March = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)



		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 10; WS =10; JP = 0; AR = true; })
	end,
	
	['Enternal Seal'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local sealanim = game.ReplicatedStorage.Assets.Animations.Animseal.AttackerSeal


		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
		local Weld
		local Weld2
		local Weld3
		local assets = {}

		ReplicateSet:FireAllClients('RemoveEmoteSync', { MainChar = Character; })

		local syncC: RBXScriptConnection
		syncC = EmotesSet.OnServerEvent:Connect(function(_, Target: Model, EnemyCharacter: Model)
			if Target == Character then
				syncC:Disconnect()
				ReplicateSet:FireAllClients('RemoveEmoteSync', { MainChar = Character; })


				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart


				TriggerHumanoid(EnemyCharacter, { RS = 0; WS = 0; JP = 0; AR = false; })
				Humanoid.AutoRotate = false

				local prison = script.EnternalSeal.PrisonRealmRig:Clone()
				prison.Parent = Character

				local cube = script.EnternalSeal.Strings:Clone()
				cube.Parent = Character
				cube.PrimaryPart.CFrame = HumRP.CFrame

				local cube2 = script.EnternalSeal.Cube:Clone()
				cube2.Parent = Character

				ReplicateSet:FireAllClients('CUMFORME', { Stage = 'Hit'; Char = Character; EChar = EnemyCharacter; StartCF = HumRP.CFrame; })

				local AnimControl1 = cube.String1.AnimationController
				local prisonAnim1 = AnimControl1:LoadAnimation(game.ReplicatedStorage.Assets.Animations.Animseal.String["1"])

				local AnimControl2 = cube.String2.AnimationController
				local prisonAnim2 = AnimControl1:LoadAnimation(game.ReplicatedStorage.Assets.Animations.Animseal.String["2"])

				local AnimControl3 = cube.String3.AnimationController
				local prisonAnim3 = AnimControl1:LoadAnimation(game.ReplicatedStorage.Assets.Animations.Animseal.String["3"])

				local AnimControl4 = cube.String4.AnimationController
				local prisonAnim4 = AnimControl1:LoadAnimation(game.ReplicatedStorage.Assets.Animations.Animseal.String["4"])

				local AnimControl5 = cube.String5.AnimationController
				local prisonAnim5 = AnimControl1:LoadAnimation(game.ReplicatedStorage.Assets.Animations.Animseal.String["5"])

				local AnimControl6 = cube.String6.AnimationController
				local prisonAnim6 = AnimControl1:LoadAnimation(game.ReplicatedStorage.Assets.Animations.Animseal.String["6"])

				local AnimControl = prison.AnimationController
				local prisonAnim = AnimControl:LoadAnimation(game.ReplicatedStorage.Assets.Animations.Animseal.MonsterSeal)

				Weld2 = WeldSystem.new(HumRP, prison.RootPart, CFrame.new(0, 0, 2.5) * CFrame.Angles(0, math.rad(180), 0), 10.817)
				Weld2:Start()

				Weld3 = WeldSystem.new(HumRP, cube2.RootPart, CFrame.new(0, 0, .5) * CFrame.Angles(0, math.rad(180), 0), 10.817)
				Weld3:Start()

				Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -5.5) * CFrame.Angles(0, math.rad(180), 0), 10.817)
				Weld:Start()



				task.delay(15.5, function()
					if Weld then
						Weld:Stop()
						Weld = nil
					end

					TriggerHumanoid(EnemyCharacter, { RS = 25; WS = 16; JP = 50; AR = true; })
				end)

				AnimationService:stopAll(Character)

				--AnimationService:playAnimation(EnemyCharacter, game.ReplicatedStorage.Assets.Animseal.EnemySeal)
				AnimationService:playAnimation(Character, game.ReplicatedStorage.Assets.Animations.Animseal.AttackerSeal)

				--table.insert(assets, SoundsModule:PlaySound(script["Dab Me Up"].Handshake, Character['Left Arm'], 1, 1))
			end
		end)


		task.delay(15.5, function()
			if Weld then
				Weld:Stop()
				Weld = nil
			end

			ReplicateSet:FireAllClients('RemoveEmoteSync', { MainChar = Character; })
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		ReplicateSet:FireAllClients('AddEmoteSync', { MainChar = Character; })

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	
	['Boogie Woogie'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
		local assets = {}

		Track.Stopped:Once(function()
			-- Reset Humanoid stats
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			-- Clean up assets
			for _, v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)

		-- Play the clap animation
		AnimationService:playAnimation(Character, Anim)

		-- Clone and attach the Clap to the player's Left Arm
		local clone_upvr = script.LeftArm.Clap:Clone()
		clone_upvr.Parent = Character["Left Arm"]
		table.insert(assets, clone_upvr)

		-- Emit particles at the "clap" marker
		Track:GetMarkerReachedSignal("clap"):Connect(function()
			for _, v in ipairs(clone_upvr:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end
		end)

		-- Play sound and store in assets
		table.insert(assets, SoundsModule:PlaySound(script.LeftArm.Clap.Sound, HumRP, 1, 2))
		wait()

		-- Freeze character movement
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end
,
	
	["Handing Out Ls"] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
		local assets = {}

		-- Cleanup function when animation stops
		Track.Stopped:Once(function()
			-- Reset humanoid stats
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			-- Destroy all assets
			for _, v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)

		-- Play the throw animation
		AnimationService:playAnimation(Character, Anim)

		-- Sound asset

		-- Attach particle effects to parts
		local clone_upvr_3 = script.ToHRP.throwL:Clone()
		clone_upvr_3.Parent = HumRP
		table.insert(assets, clone_upvr_3)

		local clone_upvr_2 = script.ToLeftArm.LetterParticle:Clone()
		clone_upvr_2.Parent = Character["Left Arm"]
		table.insert(assets, clone_upvr_2)

		local clone_upvr = script.ToRightArm.ThrownLetter:Clone()
		clone_upvr.Parent = Character["Right Arm"]
		table.insert(assets, clone_upvr)

		-- Animation markers
		Track:GetMarkerReachedSignal("disable"):Connect(function()
			clone_upvr.L.Enabled = false
		end)

		Track:GetMarkerReachedSignal("throw"):Connect(function()
			clone_upvr_3.Throw:Emit(1)
			clone_upvr.L.Enabled = false
		end)

		Track:GetMarkerReachedSignal("grab"):Connect(function()
			clone_upvr.L.Enabled = true
		end)

		-- Freeze character movement
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end
,

	['Wukong'] = function(Player, Anim)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
		local assets = {}

		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)

		-- Play the animation
		AnimationService:playAnimation(Character, Anim)

		-- Clone and attach the staff prop to the right arm
		local clone_upvr = script.Staff:Clone()
		clone_upvr.ToRightArm.Part0 = Character["Right Arm"]
		clone_upvr.Parent = Character
		table.insert(assets, clone_upvr)

		-- Play the startup animation
		local any_LoadAnimation_result1_upvr = Humanoid:LoadAnimation(script.Startup2)
		any_LoadAnimation_result1_upvr.Priority = Enum.AnimationPriority.Action3
		any_LoadAnimation_result1_upvr:Play(0)
		
		-- Create and play a sound, then insert it into assets for cleanup later
		local Sound = Instance.new("Sound")
		Sound.SoundId = "rbxassetid://114107488177133"
		Sound.Volume = 5
		Sound.Looped = false
		Sound.RollOffMaxDistance = 200
		Sound.Parent = HumRP
		Sound:Play()
		table.insert(assets, Sound)


		-- Transition to the main emote animation after the startup animation finishes
		any_LoadAnimation_result1_upvr.Stopped:Once(function()
			Track:Play(0)
		end)

		-- Play the sound and add it to the assets for cleanup

		-- Disable character movement during emote
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = false; })

		return function()
			-- Clean up assets when animation stops
			for _,v in ipairs(assets) do
				if v and v.Parent then
					v:Destroy()
				end
			end
			any_LoadAnimation_result1_upvr:Stop(0)
		end
	end,


	['The Honored One'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart
		local Torso: BasePart = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso") -- Detect torso part
		local RemoteEvent = game:GetService('ReplicatedStorage').Remotes.RemoteEvent

		local assets = {}

		local any_LoadAnimation_result1_upvr = Humanoid:LoadAnimation(script.Startup5)
		any_LoadAnimation_result1_upvr.Priority = Enum.AnimationPriority.Action3
		any_LoadAnimation_result1_upvr:Play(0)

		any_LoadAnimation_result1_upvr.Stopped:Once(function()
			local MainTrack: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
			MainTrack.Priority = Enum.AnimationPriority.Action3
			AnimationService:playAnimation(Character, Anim)

			local MusicSound = SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1)
			table.insert(assets, MusicSound)

			MainTrack:GetMarkerReachedSignal("FullSprawl"):Connect(function()
				local ColorForEffects: Color3 = Character:GetAttribute("ColorForEffects") or Color3.fromRGB(255, 255, 255)
				RemoteEvent:FireClient(Player, { TBL = "HitEffectLighting" })
				shared.Highlight(Character, ColorForEffects, 2, Character)

				local whitesparkles = script.HonoredOne.HonoredOneFX.whitesparkles:Clone()
				whitesparkles.Parent = Character.Torso 
				table.insert(assets, whitesparkles)

				if whitesparkles then
					whitesparkles:Emit(whitesparkles:GetAttribute("EmitCount"))
				end
			end)

			MainTrack:GetMarkerReachedSignal("PreNewPose"):Connect(function()
				local ColorForEffects: Color3 = Character:GetAttribute("ColorForEffects") or Color3.fromRGB(255, 210, 29)
				RemoteEvent:FireClient(Player, { TBL = "HitEffectLighting" })
				shared.Highlight(Character, ColorForEffects, 2, Character)
				end)


			-- cleanup after main animation finishes
			MainTrack.Stopped:Once(function()
				TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

				for _, v in ipairs(assets) do
					if v and v.Parent then
						v:Destroy()
					end
				end
			end)
		end)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true })
	end,
	
	['Im Floating'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart
		local Torso: BasePart = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso") -- Detect torso part
		local RemoteEvent = game:GetService('ReplicatedStorage').Remotes.RemoteEvent

		local assets = {}

		local any_LoadAnimation_result1_upvr = Humanoid:LoadAnimation(script.Startup8)
		any_LoadAnimation_result1_upvr.Priority = Enum.AnimationPriority.Action3
		any_LoadAnimation_result1_upvr:Play(0)

		any_LoadAnimation_result1_upvr.Stopped:Once(function()
			local MainTrack: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
			MainTrack.Priority = Enum.AnimationPriority.Action3
			AnimationService:playAnimation(Character, Anim)


			-- cleanup after main animation finishes
			MainTrack.Stopped:Once(function()
				TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

				for _, v in ipairs(assets) do
					if v and v.Parent then
						v:Destroy()
					end
				end
			end)
		end)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true })
	end,
	['No Hands'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart
		local Torso: BasePart = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso") -- Detect torso part
		local RemoteEvent = game:GetService('ReplicatedStorage').Remotes.RemoteEvent

		local assets = {}

		local any_LoadAnimation_result1_upvr = Humanoid:LoadAnimation(script.Startup9)
		any_LoadAnimation_result1_upvr.Priority = Enum.AnimationPriority.Action3
		any_LoadAnimation_result1_upvr:Play(0)

		any_LoadAnimation_result1_upvr.Stopped:Once(function()
			local MainTrack: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
			MainTrack.Priority = Enum.AnimationPriority.Action3
			AnimationService:playAnimation(Character, Anim)


			-- cleanup after main animation finishes
			MainTrack.Stopped:Once(function()
				TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

				for _, v in ipairs(assets) do
					if v and v.Parent then
						v:Destroy()
					end
				end
			end)
		end)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true })
	end,

	['Johny Coin'] = function(Player, Anim)
		local Character = Player.Character
		local Humanoid = Character:FindFirstChild("Humanoid")
		local HumRP = Character:FindFirstChild("HumanoidRootPart")
		local var5_upvw = false

		local assets = {}

		-- Get the animation track for the given animation
		local Track = AnimationService:getAnimationTrack(Character, Anim)

		-- Set up behavior for when the animation stops
		Track.Stopped:Once(function()
			-- Reset the humanoid movement properties after the animation ends
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true })

			-- Clean up assets
			for _, asset in pairs(assets) do
				if asset and asset.Parent then
					asset:Destroy()
				end
			end
		end)

		-- Play the animation
		AnimationService:playAnimation(Character, Anim)

		-- Clone and attach LeftHand prop
		local LeftHandClone = script.LeftHand:Clone()
		LeftHandClone.LeftHandWeld.Part0 = Character["Left Arm"]
		LeftHandClone.Parent = Character

		-- Clone and attach RightHand prop
		local RightHandClone = script.RightHand:Clone()
		RightHandClone.RightHandWeld.Part0 = Character["Right Arm"]
		RightHandClone.Parent = Character

		-- Change LeftHand and RightHand prop colors to match player's arms
		for _, v in ipairs(LeftHandClone:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.Color = Character["Left Arm"].Color
			end
		end
		for _, v in ipairs(RightHandClone:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.Color = Character["Right Arm"].Color
			end
		end
		table.insert(assets, SoundsModule:PlaySound(script["Johny Coin"].Sound, HumRP, 1, 1))
		-- Clone and attach jhncoin prop to 
		local jhncoinClone = script.jhncoin:Clone()
		jhncoinClone.ToLeftArm.Part0 = Character["Left Arm"]
		jhncoinClone.Parent = Character

		-- Store all assets for cleanup later
		table.insert(assets, LeftHandClone)
		table.insert(assets, RightHandClone)
		table.insert(assets, jhncoinClone)

		-- Load and play the startup animation with high priority
		local StartupAnimation = Character.Humanoid:LoadAnimation(script.Startup)
		StartupAnimation.Priority = Enum.AnimationPriority.Action3
		StartupAnimation:Play(0)

		-- When the animation stops, trigger the next stage
		StartupAnimation.Stopped:Once(function()
			if not var5_upvw then
				Track:Play(0)
			end
		end)

		-- Freeze the player's movement while the emote plays
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true })

		-- Play sound and store it in assets

		-- Cleanup when the emote ends
		return function()
			-- Destroy all cloned assets
			LeftHandClone:Destroy()
			RightHandClone:Destroy()
			jhncoinClone:Destroy()

			-- Stop the startup animation
			StartupAnimation:Stop(0)
		end
	end
	,
	
	['Weight Lift'] = function(Player, Anim)
		-- Ensure the Player and Character exist
		local Character = Player.Character
		if not Character then return end

		local Humanoid = Character:FindFirstChild("Humanoid")
		if not Humanoid then return end

		local HumRP = Character:FindFirstChild("HumanoidRootPart")
		if not HumRP then return end

		local var3_upvw = false
		local assets = {}
		local isPlaying = true -- Track if the animation is still playing

		-- Get the animation track for the given animation
		local Track = AnimationService:getAnimationTrack(Character, Anim)

		-- Set up behavior for when the animation stops
		Track.Stopped:Once(function()
			if isPlaying then
				isPlaying = false
				-- Reset the humanoid movement properties after the animation ends
				TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true })

				-- Clean up assets
				for _, asset in pairs(assets) do
					if asset and asset.Parent then
						asset:Destroy()
					end
				end
			end
		end)

		-- Play the animation
		AnimationService:playAnimation(Character, Anim)

		-- Clone and attach the benchpress model to the player
		local clone_upvr = script.benchpress:Clone()
		clone_upvr.RootPart.ToHRP.Part0 = HumRP -- Attach to player's HumanoidRootPart
		clone_upvr.Parent = Character
		table.insert(assets, clone_upvr)

		-- Color effects based on the player's attribute
		local ColorForEffects = Character:GetAttribute("ColorForEffects")
		if ColorForEffects then
			for _, v in pairs(clone_upvr.RootPart:GetDescendants()) do
				if v:IsA("ParticleEmitter") or v:IsA("Beam") then
					v.Color = ColorSequence.new(ColorForEffects)
				end
			end
		end

		-- Load and play the bench press animation
		local benchAnim = Humanoid:LoadAnimation(script.benchpress.StartUpPlayer)
		benchAnim.Priority = Enum.AnimationPriority.Action4
		benchAnim:Play(0)

		-- Add the bench animation to the assets table for cleanup
		table.insert(assets, benchAnim)

		-- Set up when the bench press animation stops
		benchAnim.Stopped:Once(function()
			if isPlaying then
				if not var3_upvw then
					Track:Play(0) -- Loop the main animation
				end
				benchAnim:Stop(0)
				TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = false })
			end
		end)

		-- Freeze the player's movement while the emote plays
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = false })

		-- Return a cleanup function to destroy the assets when the animation ends or if stopped early
		return function()
			if isPlaying then
				isPlaying = false -- Ensure this is only done once
				-- Clean up assets
				for _,v in ipairs(assets) do
					if v and v.Parent then
						v:Destroy()
					end
				end
				-- Cleanup additional parts of the bench press model
				if clone_upvr then
					clone_upvr['Meshesweight11.003']:Destroy()
					clone_upvr['Meshesweight11.007']:Destroy()
					clone_upvr['Meshesweighttable11']:Destroy()
					clone_upvr['Meshesweighttable11.001']:Destroy()
					clone_upvr.Meshesweight11:Destroy()
					clone_upvr.Circle1:Destroy()
					clone_upvr:Destroy()
				end
				-- Reset the humanoid movement properties
				TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true })
			end
		end
	end,
	
	['Weights Off']= function(Player, Anim)
		local Character = Player.Character
		local Humanoid = Character:FindFirstChild("Humanoid")
		local HumRP = Character:FindFirstChild("HumanoidRootPart")
		local assets = {}

		-- Get the animation track for the given animation
		local Track = AnimationService:getAnimationTrack(Character, Anim)

		-- Set up behavior for when the animation stops
		Track.Stopped:Once(function()
			-- Reset the humanoid movement properties after the animation ends
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true })

			-- Clean up assets
			for _, asset in pairs(assets) do
				if asset and asset.Parent then
					asset:Destroy()
				end
			end
		end)

		-- Play the animation
		AnimationService:playAnimation(Character, Anim)

		-- Clone and attach "ankle weights" to the player
		local ankleWeights = script["ankle weights"]:Clone()
		ankleWeights.Lock.ToHRP.Part0 = HumRP -- Attach to player's HumanoidRootPart
		ankleWeights["Lock.001"].ToHRP.Part0 = HumRP -- Attach second part
		ankleWeights.Parent = Character

		-- Clone and attach ankle weights VFX to the player
		local ankleVFX = script.ankleweightsvfx:Clone()
		ankleVFX.ToHRP.Part0 = HumRP -- Attach VFX to the player
		ankleVFX.Parent = Character

		-- Store the assets to clean up later
		table.insert(assets, ankleWeights)
		table.insert(assets, ankleVFX)

		-- Set up the marker to trigger the VFX upon "landing" marker being reached in the animation
		Track:GetMarkerReachedSignal("landing"):Once(function()
			ShakeCameraModule:ShakeCamera(10, 35, 0, .5)
			for _, v in ipairs(ankleVFX:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end
		end)

		-- Freeze the player's movement while the emote plays
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true })

		-- Create and play a sound, then insert it into assets for cleanup later
		local Sound = Instance.new("Sound")
		Sound.SoundId = "rbxassetid://114036260612594"
		Sound.Volume = 5
		Sound.Looped = false
		Sound.RollOffMaxDistance = 200
		Sound.Parent = HumRP
		Sound:Play()
		table.insert(assets, Sound)


		-- Cleanup when the emote ends
		return function()
			-- Destroy the cloned ankle weights and VFX
			ankleWeights:Destroy()
			ankleVFX:Destroy()
		end
	end
	,




	--[[SuperSonic = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		-- Load the animation from the provided script
		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)

		-- Clone the chaos emeralds model
		local emeraldModel = script.chaosemralds:Clone()
		emeraldModel.HumanoidRootPart.ToRigHRP.Part0 = HumRP
		emeraldModel.Parent = Character

		-- Load and play the emerald animation
		local emeraldAnimation = emeraldModel.Humanoid.Animator:LoadAnimation(script.EmeraldAnim)
		emeraldAnimation.Priority = Enum.AnimationPriority.Action3
		emeraldAnimation:Play(0)

		-- Clone the particles model
		local particlesModel = script.Particles:Clone()
		particlesModel.ToHRP.Part0 = HumRP
		particlesModel.Parent = Character

		-- Disable all particle effects when the animation hits the "disable" marker
		emeraldAnimation:GetMarkerReachedSignal("disable"):Once(function()
			for _, v in ipairs(emeraldModel:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v.Enabled = false
				elseif v:IsA("MeshPart") then
					v.Transparency = 1
				elseif v:IsA("Trail") then
					v.Enabled = false
				elseif v:IsA("PointLight") then
					v.Enabled = false
				end
			end
		end)

		-- Emit particles on the "shockwave" marker
		Track:GetMarkerReachedSignal("shockwave"):Once(function()
			for _, emitter in ipairs(particlesModel.AfterAura:GetChildren()) do
				if emitter:IsA("ParticleEmitter") then
					emitter:Emit(emitter:GetAttribute("EmitCount"))
				end
			end
		end)

		-- Return a cleanup function
		return function()
			particlesModel:Destroy()
			emeraldModel:Destroy()
			emeraldAnimation:Stop(0)
		end
	end
,]]--
	['Cola Kick'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)

		local assets = {}

		Track.Stopped:Once(function()
			-- Reset humanoid properties when the animation stops
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			-- Destroy all assets when the animation stops
			for _, v in pairs(assets) do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)

		-- Play the animation
		AnimationService:playAnimation(Character, Anim)

		-- Clone the Model prop and attach it to the Right Arm
		local clone_upvr = script.Model:Clone()
		clone_upvr.Handle.ToRightArm.Part0 = Character["Right Arm"]
		clone_upvr.Parent = Character
		table.insert(assets, clone_upvr) -- Add prop to assets for cleanup

		-- Listen for the "kick" marker signal
		Track:GetMarkerReachedSignal("kick"):Once(function()
			-- Fire a remote event with the "ColaKick" data
			game.ReplicatedStorage.Remotes.RemoteEvent:FireAllClients({
				TBL = "ColaKick";
				ModelProp = clone_upvr;
				Direction = Character.Torso.CFrame.LookVector * clone_upvr.PrimaryPart.Mass * 5;
			})

			-- Set the transparency of all parts in the cloned model
			for _, v in ipairs(clone_upvr:GetChildren()) do
				if v:IsA("Part") then
					v.Transparency = 1
				end
			end
		end)

		-- Create and play sound, then insert it into assets for cleanup later
		local Sound = Instance.new("Sound")
		Sound.SoundId = "rbxassetid://80366248641767"
		Sound.Volume = 1
		Sound.Looped = false
		Sound.Parent = HumRP
		Sound:Play()
		table.insert(assets, Sound)

		-- Freeze the character's movement
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = false })

		-- Return a function for disconnecting/cleaning up
		return function()
			-- Destroy assets and stop animation
			clone_upvr:Destroy()
		end
	end
	,
	['Touch Grass'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)

		local assets = {}

		Track.Stopped:Once(function()
			-- Reset humanoid properties
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			-- Destroy all assets when the animation stops
			for _, v in pairs(assets) do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)

		-- Play the animation
		AnimationService:playAnimation(Character, Anim)

		-- Clone the Grass prop and attach it to the character
		local clone_upvr = script.Grass:Clone()
		clone_upvr.ToHRP.Part0 = HumRP
		clone_upvr.Parent = Character
		table.insert(assets, clone_upvr) -- Add prop to assets for cleanup

		-- Play sound and insert it into assets for cleanup later

		-- Freeze the character's movement
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = false; })

		-- Single remote event similar to the one in the format you provided
		if game.ReplicatedStorage:FindFirstChild("Remotes") and game.ReplicatedStorage.Remotes:FindFirstChild("RemoteEvent") then
			game.ReplicatedStorage.Remotes.RemoteEvent:FireClient(Player, {
				TBL = "MauioShake";
				Length = 0.25;
				Intensity = Random.new():NextNumber(2.75, 3);
				TweenSpeed = Random.new():NextNumber(0.035, 0.08);
				AxisMultipliers = Vector3.new(0.89999, 0.69999, 0.89999);
				FadeStyle = "inQuad";
			})
		end
	end
	,

	['Nerf This'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)

		local assets = {}

		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _, v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)

		AnimationService:playAnimation(Character, Anim)

		-- Sounds

		-- Create Left Handle
		local leftHandle = script.Clipboard.LeftHandle:Clone()
		leftHandle:SetAttribute("EmoteProperty", true)
		table.insert(assets, leftHandle)

		local motor6D_Left = leftHandle.LeftHandle
		motor6D_Left:SetAttribute("EmoteProperty", true)
		table.insert(assets, motor6D_Left)

		motor6D_Left.Part0 = Character["Left Arm"]
		motor6D_Left.Part1 = leftHandle
		motor6D_Left.Parent = Character["Left Arm"]

		-- Set random decal texture for Left Handle
		leftHandle:FindFirstChild("Decal", true).Texture = "rbxassetid://" .. ({
			15114667107, 
			15124465439, 
			15143528856, 
			15114672498, 
			15143529209, 
			15143528539, 
			16136325038
		})[math.random(1, 7)]

		leftHandle.Parent = Character

		-- Create Right Handle
		local rightHandle = script.Clipboard.RightHandle:Clone()
		rightHandle:SetAttribute("EmoteProperty", true)
		table.insert(assets, rightHandle)

		local motor6D_Right = rightHandle.RightHandle
		motor6D_Right:SetAttribute("EmoteProperty", true)
		table.insert(assets, motor6D_Right)

		motor6D_Right.Part0 = Character["Right Arm"]
		motor6D_Right.Part1 = rightHandle
		motor6D_Right.Parent = Character
		rightHandle.Parent = Character
	end,

	Ramen = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local AnimationTrack: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)

		local assets = {}
		local v597 = {} -- Initialize v597 as a local table

		-- When the animation stops, clean up and reset humanoid stats
		AnimationTrack.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			-- Clean up assets
			for _, asset in assets do
				if asset and asset.Parent then
					asset:Destroy()
				end
			end
		end)

		-- Play the animation
		AnimationService:playAnimation(Character, Anim)

		-- Clone the Ramen handle and attach it to the player
		local RamenHandle = script.Ramen.Handle:Clone()
		RamenHandle:SetAttribute("EmoteProperty", true)
		table.insert(assets, RamenHandle)

		local HandleMotor6D = RamenHandle.Handle
		HandleMotor6D:SetAttribute("EmoteProperty", true)
		table.insert(assets, HandleMotor6D)

		HandleMotor6D.Part0 = Character["Left Arm"]
		HandleMotor6D.Part1 = RamenHandle
		HandleMotor6D.Parent = Character["Left Arm"]

		RamenHandle.Parent = Character

		-- Clone the sticks and attach them to the player
		for _, StickName in pairs({ "stickLeft", "stickRight" }) do
			local Stick = script.Ramen[StickName]:Clone()
			Stick:SetAttribute("EmoteProperty", true)
			table.insert(assets, Stick)

			Stick.Parent = Character["Right Arm"]

			local StickMotor6D = Stick[StickName]
			StickMotor6D:SetAttribute("EmoteProperty", true)
			table.insert(assets, StickMotor6D)

			StickMotor6D.Part0 = Character["Right Arm"]
			StickMotor6D.Part1 = Stick
			StickMotor6D.Parent = Character["Right Arm"]

			--	Stick.Beam.Attachment0 = Stick.Attachment
			--	Stick.Beam.Attachment1 = RamenHandle.Bowl.Noodles[string.gsub(Stick.Name, "stick", "")]
			Stick.Beam.Enabled = false

			v597[StickName] = Stick.Beam
		end

		-- Freeze character movement
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true })
	end
	,
	['Your Grave'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)

		local assets = {}

		Track.Stopped:Once(function()
			-- Reset Humanoid stats
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			-- Clean up assets
			for _, v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)

		-- Play the animation
		AnimationService:playAnimation(Character, Anim)

		-- Clone the Dig handle and attach it to the player
		local v366 = script.Dig.Handle:Clone()
		v366:SetAttribute("EmoteProperty", true)
		table.insert(assets, v366)

		local l_m6d_6 = v366.m6d
		l_m6d_6:SetAttribute("EmoteProperty", true)
		table.insert(assets, l_m6d_6)

		l_m6d_6.Name = "Handle"
		l_m6d_6.Part0 = Character["Right Arm"]
		l_m6d_6.Part1 = v366
		l_m6d_6.Parent = Character["Right Arm"]

		v366.Parent = Character

		-- Clone the Grave and attach it to the player
		local v368 = script.Dig.Grave:Clone()
		v368:SetAttribute("EmoteProperty", true)
		table.insert(assets, v368)

		local l_Weld_0 = Instance.new("Weld")
		l_Weld_0:SetAttribute("EmoteProperty", true)
		table.insert(assets, l_Weld_0)

		l_Weld_0.Part0 = HumRP
		l_Weld_0.Part1 = v368.Headstone
		l_Weld_0.Parent = v368
		l_Weld_0.C0 = CFrame.new(1.59004211, -1.53838396, -5.02381897, -0.999934554, -0.0114461109, 0, -0.0114019588, 0.996077538, -0.0877478421, 0.00100437133, -0.0877420902, -0.996142864)

		v368.Parent = Character

		-- Play sound and store in assets

		wait()

		-- Freeze character movement
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,



	KJSeries = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)



		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['Only Dance'] = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)

		local HakariParticles = script.HakariParticles.Particle:Clone()
		HakariParticles.Parent = Character
		HakariParticles.m6d.Part0 = Character.Torso
		assets['Only Dance'] = HakariParticles


		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 5; WS = 5; JP = 0; AR = true; })
	end,

	['They Found Out'] = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)

		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 5; WS = 5; JP = 0; AR = true; })
	end,

	PoolDance = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)



		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	RussianDance = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)

		table.insert(SoundsModule:PlaySound(script.RussianDance.Sound, HumRP, 1, 1))
		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)



		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 10; WS = 8; JP = 0; AR = true; })
	end,

	SneakWalk = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)



		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 8; WS = 8; JP = 0; AR = true; })
	end,

	BoogieDown = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)



		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 2; WS = 2; JP = 0; AR = true; })
	end,

	CatDance = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)



		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	California = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)



		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	Mad = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart
		
		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
		local Stopped = true
		
		
		local assets = {}
		Track.Stopped:Once(function()
			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
			
			if Stopped == true then return end
			
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })
		end)
		AnimationService:playAnimation(Character, Anim)
		task.delay(Track.Length - .1, function()
			Stopped = false
		end)
		
		table.insert(assets, SoundsModule:PlaySound(script.Mad.Hits, HumRP, 1, 1))
		table.insert(assets, SoundsModule:PlaySound(script.Mad.Roar, HumRP, 1, -(script.Mad.Roar.TimeLength - 2), { DelayTime = 1.5; TweenInfo = TweenInfo.new(.5, Enum.EasingStyle.Linear); }))
		
		wait()
		
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	
	['Smug'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Smug.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	
	['Shadow Boxing'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Smug.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['Dink'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Smug.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['I am Alone'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Smug.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	
	['Dab Me Up'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
		local Weld
		local assets = {}
		
		
		ReplicateSet:FireAllClients('RemoveEmoteSync', { MainChar = Character; })
		
		
		local syncC: RBXScriptConnection
		syncC = EmotesSet.OnServerEvent:Connect(function(_, Target: Model, EnemyCharacter: Model)
			if Target == Character then
				syncC:Disconnect()
				ReplicateSet:FireAllClients('RemoveEmoteSync', { MainChar = Character; })
				
				
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart


				TriggerHumanoid(EnemyCharacter, { RS = 0; WS = 0; JP = 0; AR = false; })
				Humanoid.AutoRotate = false
				
				
				Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3.5) * CFrame.Angles(0, math.rad(180), 0), 2.817)
				Weld:Start()
				
				
				AnimationService:getAnimationTrack(EnemyCharacter, Anim).Stopped:Once(function()
					if Weld then
						Weld:Stop()
						Weld = nil
					end
					
					TriggerHumanoid(EnemyCharacter, { RS = 25; WS = 16; JP = 50; AR = true; })
				end)
				
				AnimationService:adjustSpeed(Character, Anim, 1)
				AnimationService:playAnimation(EnemyCharacter, Anim)
				
				table.insert(assets, SoundsModule:PlaySound(script["Dab Me Up"].Handshake, Character['Left Arm'], 1, 1))
			end
		end)

	
		Track.Stopped:Once(function()
			if Weld then
				Weld:Stop()
				Weld = nil
			end
			
			ReplicateSet:FireAllClients('RemoveEmoteSync', { MainChar = Character; })
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })
			
			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim, 0)
		
		ReplicateSet:FireAllClients('AddEmoteSync', { MainChar = Character; })
		
		wait()
		
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	
	['Secret Handshake'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
		local Weld
		local assets = {}


		ReplicateSet:FireAllClients('RemoveEmoteSync', { MainChar = Character; })


		local syncC: RBXScriptConnection
		syncC = EmotesSet.OnServerEvent:Connect(function(_, Target: Model, EnemyCharacter: Model)
			if Target == Character then
				syncC:Disconnect()
				ReplicateSet:FireAllClients('RemoveEmoteSync', { MainChar = Character; })


				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart


				TriggerHumanoid(EnemyCharacter, { RS = 0; WS = 0; JP = 0; AR = false; })
				Humanoid.AutoRotate = false


				Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3.5) * CFrame.Angles(0, math.rad(180), 0), 2.817)
				Weld:Start()


				AnimationService:getAnimationTrack(EnemyCharacter, Anim).Stopped:Once(function()
					if Weld then
						Weld:Stop()
						Weld = nil
					end

					TriggerHumanoid(EnemyCharacter, { RS = 25; WS = 16; JP = 50; AR = true; })
				end)

				AnimationService:adjustSpeed(Character, Anim, 1)
				AnimationService:playAnimation(EnemyCharacter, Anim)

			end
		end)


		Track.Stopped:Once(function()
			if Weld then
				Weld:Stop()
				Weld = nil
			end

			ReplicateSet:FireAllClients('RemoveEmoteSync', { MainChar = Character; })
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim, 0)

		ReplicateSet:FireAllClients('AddEmoteSync', { MainChar = Character; })

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	Owl = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)
		

		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1))
		
		wait()
		
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	['Arona Dance'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)


		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	['Crying'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)


		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	['Kung Fu Kick'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)


		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	['Shadow Box'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)


		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	['Nokotan'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)


		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,


	['Rick Dance'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['Unlock'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['Headless'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['Comeback'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['Hold on'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['Cat Dance'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['Car Shearer'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['Where is my arm!?'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['One Handed Pushup'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['Levitating'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)

		table.insert(assets, SoundsModule:PlaySound(script.Owl.Music, HumRP, 1, 1))

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,

	['Eye Pop'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		local EventConnections = {}
		EventConnections['Pop'] = Track:GetMarkerReachedSignal('Pop'):Once(function()
			assets.RightEye.Transparency = 0
			assets.RightEye.Reye2.Transparency = 0
			assets.RightEye.Reye3.Transparency = 0
			
			assets.LeftEye.Transparency = 0
			assets.LeftEye.Leye2.Transparency = 0
			assets.LeftEye.Leye3.Transparency = 0
		end)
		EventConnections['Hide'] = Track:GetMarkerReachedSignal('Hide'):Once(function()
			assets.RightEye.Transparency = 1
			assets.RightEye.Reye2.Transparency = 1
			assets.RightEye.Reye3.Transparency = 1

			assets.LeftEye.Transparency = 1
			assets.LeftEye.Leye2.Transparency = 1
			assets.LeftEye.Leye3.Transparency = 1
		end)
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })
			
			for _,c in EventConnections do
				c:Disconnect()
			end
			
			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		

		table.insert(assets, SoundsModule:PlaySound(script["Eye Pop"].Sound, Character.Torso, 1, 1))
		
		local RightEye = script["Eye Pop"].Reye1:Clone()
		RightEye.Parent = Character
		RightEye.m6d.Part0 = Character.Head
		RightEye.m6d.Part1 = RightEye
		assets['RightEye'] = RightEye
		
		local LeftEye = script["Eye Pop"].Leye1:Clone()
		LeftEye.Parent = Character
		LeftEye.m6d.Part0 = Character.Head
		LeftEye.m6d.Part1 = LeftEye
		assets['LeftEye'] = LeftEye
		
		
		AnimationService:playAnimation(Character, Anim)
		
		wait()
		
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	
	Sturdy = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)


		table.insert(assets, SoundsModule:PlaySound(script.Sturdy.Music, HumRP, 1, 1))

		AnimationService:playAnimation(Character, Emote)
		
		wait()
		
		TriggerHumanoid(Character, { RS = 5; WS = 5; JP = 0; AR = true; })
	end,
	
	Chrono = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)


		table.insert(assets, SoundsModule:PlaySound(script.Chrono.Music, HumRP, 1, 1))

		AnimationService:playAnimation(Character, Emote)
		
		wait()
		
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	
	Griddy = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)


		table.insert(assets, SoundsModule:PlaySound(script.Griddy.Music, HumRP, 1, 1))

		AnimationService:playAnimation(Character, Emote)
		
		wait()
		
		TriggerHumanoid(Character, { RS = 5; WS = 5; JP = 0; AR = true; })
	end,
	
	Helicopter = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)


		table.insert(assets, SoundsModule:PlaySound(script.Griddy.Music, HumRP, 1, 1))

		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 5; WS = 5; JP = 0; AR = true; })
	end,

	Laugh = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)


		table.insert(assets, SoundsModule:PlaySound(script.Laugh.Sound, HumRP, 1, 1))

		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	
	['Take The L'] = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)


		table.insert(assets, SoundsModule:PlaySound(script["Take The L"].Music, HumRP, 1, 1))
		table.insert(assets, SoundsModule:PlaySound(script["Take The L"].Horn, HumRP, 1, 1))

		AnimationService:playAnimation(Character, Emote)

		wait()

		TriggerHumanoid(Character, { RS = 5; WS = 5; JP = 0; AR = true; })
	end,
	
	['Friday Night'] = function(Player: Player, Anim: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)
		AnimationService:playAnimation(Character, Anim)


		wait()

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = false; })
	end,
}