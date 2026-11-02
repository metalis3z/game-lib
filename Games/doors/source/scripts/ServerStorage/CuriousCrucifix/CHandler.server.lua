repeat task.wait() until script.Parent.Parent:FindFirstChild("Humanoid")
local Humanoid = script.Parent.Parent:WaitForChild("Humanoid")
local DEBOUNCE = false
local PlayIdle = false
local AnimationsFolder = script.Parent.Animations
local TOOL_CRUCIFIX = script.Parent
local SEALED = TOOL_CRUCIFIX.Sealed
local HANDLE = TOOL_CRUCIFIX.Handle
local Hold = Humanoid:LoadAnimation(AnimationsFolder.idle)
local SEAL = game.ServerScriptService.Server.Assets.Seal

local TRACK

local FRIENDLY_FIRE = false

local UNLIMITED_USE = false
local UNLIMITED_USE_CRUCIFIX_COOLDOWN = 0
local UNLIMITED_USE_FAILEDCRUCIFIX_COOLDOWN = 0 -- Cooldown when the duration ends 

local ATTACK_SPECIFICALLY = false -- If true, it attacks anything including "CAN_BE_USED_ON" and "FAILED_CRUCIFIX"/ If false, it attacks in the list "CAN_BE_USED_ON" and "FAILED_CRUCIFIX" only.
local FAILEDCRUCIFIX_ONLY = false -- Makes the Crucifix always fail.
local SHAKE_SCREEN = true -- Shakes the camera/screen

local CAN_BE_USED_ON = {"RushNew"}
local CANT_BE_USED_ON = {"GigaDummy"}

local FAILED_CRUCIFIX = {"SeekRig", "FigureRagdoll", --[["WriteStudio"--]]} -- Characters that are invincible to the crucifix.
local FAILED_CRUCIFIX_DURATION = 5 -- Normal is 5. If you change the Duration, the sound will be different.

local COLOR_CRUCIFIX = Color3.new(1, 0.984314, 0.584314) -- The Crucifix color.
local COLOR_FAILEDCRUCIFIX = Color3.new(1, 0, 0) -- The Failed Crucifix color.

local COLOR_SEAL = Color3.new(1, 0.984314, 0.584314) -- The Seal color.
local COLOR_FAILEDSEAL = Color3.new(1, 0, 0) -- The Failed Seal color.

--local HITBOX_RANGE = 25 -- You can change manually.
local SHOW_HITBOX = false -- Easier management.

-- |||||||||||||||||||| --




local FOLDER = Instance.new("Folder")
local FOLDER_CLONED = Instance.new("Folder")

if game.ServerStorage:FindFirstChild("TRASH_CRUCIFIX") == nil then

	FOLDER.Name = "TRASH_CRUCIFIX"
	FOLDER.Parent = game.ServerStorage

end

if game.Workspace:FindFirstChild("CLONED_PARTS") == nil then

	FOLDER_CLONED.Name = "CLONED_PARTS"
	FOLDER_CLONED.Parent = game.Workspace

end

for i, COLORING in pairs(TOOL_CRUCIFIX.Handle:GetDescendants()) do

	if COLORING:IsA("PointLight") then
		COLORING.Color = COLOR_CRUCIFIX
	end

end

local TWEENSERVICE = game:GetService("TweenService")

local function MOVE(MODEL, PART)

	local TWEENINFO = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
	local CFRAME = Instance.new("CFrameValue")

	if MODEL.PrimaryPart ~= nil then

		CFRAME.Value = MODEL:GetPrimaryPartCFrame()

	elseif MODEL.PrimaryPart == nil and MODEL:FindFirstChild("HumanoidRootPart") then

		MODEL.PrimaryPart = MODEL:FindFirstChild("HumanoidRootPart")

		CFRAME.Value = MODEL:GetPrimaryPartCFrame()

	elseif MODEL.PrimaryPart == nil and MODEL:FindFirstChild("Torso") then

		MODEL.PrimaryPart = MODEL:FindFirstChild("Torso")

		CFRAME.Value = MODEL:GetPrimaryPartCFrame()

	elseif MODEL.PrimaryPart == nil and MODEL:FindFirstChild("UpperTorso") then

		MODEL.PrimaryPart = MODEL:FindFirstChild("UpperTorso")

		CFRAME.Value = MODEL:GetPrimaryPartCFrame()

	end

	CFRAME:GetPropertyChangedSignal("Value"):Connect(function()

		MODEL:SetPrimaryPartCFrame(CFRAME.Value)

	end)

	local TWEENING = TWEENSERVICE:Create(CFRAME, TWEENINFO, {Value = PART.CFrame * CFrame.Angles(math.rad(MODEL.PrimaryPart.Orientation.X), math.rad(MODEL.PrimaryPart.Orientation.Y), math.rad(MODEL.PrimaryPart.Orientation.Z))})

	TWEENING:Play()

end

local function MOVE2(MODEL, PART)

	local TWEENINFO = TweenInfo.new(2, Enum.EasingStyle.Back, Enum.EasingDirection.In, 0, false, 0)
	local CFRAME = Instance.new("CFrameValue")

	if MODEL.PrimaryPart ~= nil then

		CFRAME.Value = MODEL:GetPrimaryPartCFrame()

	elseif MODEL.PrimaryPart == nil and MODEL:FindFirstChild("HumanoidRootPart") then

		MODEL.PrimaryPart = MODEL:FindFirstChild("HumanoidRootPart")

		CFRAME.Value = MODEL:GetPrimaryPartCFrame()

	elseif MODEL.PrimaryPart == nil and MODEL:FindFirstChild("Torso") then

		MODEL.PrimaryPart = MODEL:FindFirstChild("Torso")

		CFRAME.Value = MODEL:GetPrimaryPartCFrame()

	elseif MODEL.PrimaryPart == nil and MODEL:FindFirstChild("UpperTorso") then

		MODEL.PrimaryPart = MODEL:FindFirstChild("UpperTorso")

		CFRAME.Value = MODEL:GetPrimaryPartCFrame()

	end

	CFRAME:GetPropertyChangedSignal("Value"):Connect(function()

		MODEL:SetPrimaryPartCFrame(CFRAME.Value)

	end)

	local TWEENING = TWEENSERVICE:Create(CFRAME, TWEENINFO, {Value = PART.CFrame * CFrame.Angles(math.rad(MODEL.PrimaryPart.Orientation.X), math.rad(MODEL.PrimaryPart.Orientation.Y), math.rad(MODEL.PrimaryPart.Orientation.Z))})

	TWEENING:Play()

end

function PLAY_FUNCTION(P, T)
	print("Get crufixed")
	
	if T and T.Parent then
		if T.Parent.Name == "Rush" or T.Parent.Name == "RushNew" then
			T.Parent:SetAttribute("Crucifixed", true)
			game.Workspace.GameSettings.Entities.RushIsBlood.Value = true
		end
	end
	
	if T:FindFirstChild("Repent") and T:FindFirstChild("PlaySound") and T:FindFirstChild("Footsteps") then
		T.Repent:Play()
		T.PlaySound:Stop()
		T.Footsteps:Stop()
	end
	
	local HANDLE_CLONE = HANDLE:Clone()
	local SEAL_CLONE = SEAL:Clone()
	local TARGET_END = SEAL_CLONE.Parts.TargetEnd

	local SOUND = HANDLE_CLONE.Sound
	local CROSS_CLONE = SEAL_CLONE.Parts.MoonPart.Cross

	local PLAYER_HUMANOIDROOTPART = P.HumanoidRootPart
	local PLAYER_POSITION = PLAYER_HUMANOIDROOTPART.Position
	local PLAYER_DIRECTION = PLAYER_HUMANOIDROOTPART.CFrame.LookVector
	local PLAYER_ROTATION = PLAYER_HUMANOIDROOTPART.CFrame - Vector3.new(PLAYER_POSITION, PLAYER_POSITION + PLAYER_DIRECTION)

	local PART_POSITION = PLAYER_POSITION + PLAYER_DIRECTION * 5

	local SEALED_CLONE = SEALED:Clone()
	SEALED_CLONE.Parent = T.Parent
	
	if T and T.Parent then
		if T.Parent.Name == "A60Moving" then
			T.Parent:SetAttribute("Crucifixed", true)
			T.ParticleEmitter3.Enabled = false

			HANDLE_CLONE.Attachment.PointLight.Enabled = false
			HANDLE_CLONE.Attachment.Triangles.Enabled = false
			HANDLE_CLONE.Attachment.ZoomParticle.Enabled = false
			
			for i, v in pairs(T.Attachment:GetChildren()) do
				if v:IsA("Light") then
					v.Enabled = false
				end
			end
		end
	end
	
	if T and T.Parent then
		if T.Parent.Name == "TrololoMoving" then
			T.Parent:SetAttribute("Crucifixed", true)
			
			T.Attachment.ParticleEmitter.LightEmission = 0.25

			HANDLE_CLONE.Attachment.PointLight.Enabled = false
			HANDLE_CLONE.Attachment.Triangles.Enabled = false
			HANDLE_CLONE.Attachment.ZoomParticle.Enabled = false

			for i, v in pairs(T.Attachment:GetChildren()) do
				if v:IsA("Light") then
					v.Enabled = false
				end
			end
		end
	end
	
	if T and T.Parent then
		if T.Parent.Name == "KreekMoving" then
			T.Parent:SetAttribute("Crucifixed", true)

			T.Attachment.ParticleEmitter.LightEmission = 0.3

			HANDLE_CLONE.Attachment.PointLight.Enabled = false
			HANDLE_CLONE.Attachment.Triangles.Enabled = false
			HANDLE_CLONE.Attachment.ZoomParticle.Enabled = false

			for i, v in pairs(T.Attachment:GetChildren()) do
				if v:IsA("Light") then
					v.Enabled = false
				end
			end
		end
	end

	--if T.Parent:FindFirstChild("Humanoid") then
	--	T.Parent:FindFirstChild("Humanoid").WalkSpeed = 0
	--end
	
	if T.Parent.PrimaryPart ~= T.Parent:FindFirstChild("HumanoidRootPart") and T.Parent:FindFirstChild("HumanoidRootPart") then
		T.Parent.PrimaryPart = T.Parent:FindFirstChild("HumanoidRootPart")
	end
	if T.Parent.PrimaryPart == nil then
		T.Parent.PrimaryPart = T
	end
	
	local LookVectorr = T.Parent.PrimaryPart.CFrame.LookVector * Vector3.new(1, 0, 1)
	T.Parent.PrimaryPart.CFrame = CFrame.new(T.Parent.PrimaryPart.Position, T.Parent.PrimaryPart.Position + LookVectorr)
	
	local PRIMARY_PART = T.Parent.PrimaryPart
	
	local SEAL_RAY = Instance.new("Part", game.Workspace)
	SEAL_RAY.Transparency = 1
	SEAL_RAY.Size = Vector3.new(1, 1, 1)
	SEAL_RAY.CanCollide = false
	SEAL_RAY.Anchored = true
	if T.Parent:FindFirstChild("HumanoidRootPart") then
		SEAL_RAY.Position = T.Parent:FindFirstChild("HumanoidRootPart").Position
	elseif T.Parent:FindFirstChild("Torso") then
		SEAL_RAY.Position = T.Parent:FindFirstChild("Torso").Position
	elseif T.Parent:FindFirstChild("UpperTorso") then
		SEAL_RAY.Position = T.Parent:FindFirstChild("UpperTorso").Position
	else
		SEAL_RAY.Position = PRIMARY_PART.Position or T.Position
	end
	

	if T.Parent:FindFirstChildOfClass("Humanoid") then

		local HUMANOID = T.Parent:FindFirstChildOfClass("Humanoid")
		HUMANOID.WalkSpeed = 0
		HUMANOID.JumpPower = 0

	end

	HANDLE_CLONE.CFrame = CFrame.new(PART_POSITION, PART_POSITION + PLAYER_ROTATION.LookVector)

	if UNLIMITED_USE == false then

		HANDLE:Destroy()
		TOOL_CRUCIFIX.Parent = game.ServerStorage:WaitForChild("TRASH_CRUCIFIX")

	end

	if T.Parent:FindFirstChild("HumanoidRootPart") ~= nil or T.Parent:FindFirstChild("Root") ~= nil then

		local RAYCASTPARAMS = RaycastParams.new()

		RAYCASTPARAMS.FilterDescendantsInstances = {T.Parent}

		local RAYCAST = game.Workspace:Raycast(SEAL_RAY.Position, SEAL_RAY.CFrame.UpVector * -100, RAYCASTPARAMS)

		if RAYCAST then

			local OBJECT = RAYCAST.Instance

			SEAL_CLONE.Parts.MoonPart.Position = RAYCAST.Position

		end

		if UNLIMITED_USE == true then

			--HITBOX.Size = Vector3.new(HITBOX_RANGE, HITBOX_RANGE, HITBOX_RANGE)

		end

		CROSS_CLONE.Parent = T.Parent:FindFirstChild("HumanoidRootPart")

		if T.Parent:FindFirstChild("Crucifix_Config") ~= nil and T.Parent:FindFirstChild("AnimationController") then
			print("Dumper")
			local CRUCIFIX_ANIMATION = T.Parent:FindFirstChild("Crucifix_Config")

			local ANIMATION = T.Parent:FindFirstChild("AnimationController"):LoadAnimation(CRUCIFIX_ANIMATION.Animation.Working:FindFirstChildOfClass("Animation"))
			
			if CRUCIFIX_ANIMATION.Animation.Working.Loop.Value == true then
				ANIMATION.Looped = true
			else
				ANIMATION.Looped = false
			end
			
			ANIMATION:Play()

		end
		
		local MOVEPART_1 = Instance.new("Part")

		MOVEPART_1.Transparency = 0
		MOVEPART_1.Size = Vector3.new(1, 1, 1)
		MOVEPART_1.CanCollide = false
		MOVEPART_1.Anchored = true
		if T.Parent:FindFirstChild("HumanoidRootPart") then
			MOVEPART_1.Position = T.Parent:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0, 4, 0)
		elseif T.Parent:FindFirstChild("Root") then
			MOVEPART_1.Position = T.Parent:FindFirstChild("Root").Position + Vector3.new(0, 4, 0)
		end

		MOVE(T.Parent, MOVEPART_1)

	elseif T.Parent:FindFirstChild("HumanoidRootPart") == nil then

		local RAYCASTPARAMS = RaycastParams.new()

		RAYCASTPARAMS.FilterDescendantsInstances = {T.Parent}

		local RAYCAST = game.Workspace:Raycast(SEAL_RAY.Position, SEAL_RAY.CFrame.UpVector * -100, RAYCASTPARAMS)

		if RAYCAST then

			local OBJECT = RAYCAST.Instance

			SEAL_CLONE.Parts.MoonPart.Position = RAYCAST.Position

		end

		if UNLIMITED_USE == true then

			---HITBOX.Size = Vector3.new(HITBOX_RANGE, HITBOX_RANGE, HITBOX_RANGE)

		end

		CROSS_CLONE.Parent = T
		
		local MOVEPART_1 = Instance.new("Part")

		MOVEPART_1.Transparency = 0
		MOVEPART_1.Size = Vector3.new(1, 1, 1)
		MOVEPART_1.CanCollide = false
		MOVEPART_1.Anchored = true
		MOVEPART_1.Position = T.Position + Vector3.new(0, 4, 0)

		MOVE(T.Parent, MOVEPART_1)

	end

	TARGET_END.Position = SEAL_CLONE.Parts.MoonPart.Position - Vector3.new(0, 50, 0)
	SEAL_CLONE.Parts.RingAttachmentPart.Position = SEAL_CLONE.Parts.MoonPart.Position
	SEAL_CLONE.Parts.DevilsStarPart.Position = SEAL_CLONE.Parts.MoonPart.Position
	SEAL_CLONE.Parts.MoonSymbolsPart.Position = SEAL_CLONE.Parts.MoonPart.Position
	SEAL_CLONE.Parts.SymbolsPart.Position = SEAL_CLONE.Parts.MoonPart.Position
	
	SEAL_CLONE["Self-Destruct"].Enabled = true
	HANDLE_CLONE["Self-Destruct"].Enabled = true
	
	PRIMARY_PART.Orientation = Vector3.new(0, PRIMARY_PART.Orientation.Y, 0)
	
	if T.Parent.Name == "Eyes" or T.Parent.Name == "LookMan" then
		
		T:FindFirstChild("Crucifix"):Play()
		T:FindFirstChild("Attachment").Angry.Enabled = true
		T:FindFirstChild("Ambience"):Stop()
		T:FindFirstChild("Initiate"):Stop()
		T:FindFirstChild("Scream"):Stop()
		T:FindFirstChild("Repent"):Stop()
		T:FindFirstChild("Attack"):Stop()
		
	end
	
	if SHAKE_SCREEN == true then

		local PLYR = game.Players:FindFirstChild(P.Name)

		game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(12, 35, 0.3, 6)
		game.ReplicatedStorage.Crucifix_Remotes.WorkingCrucifix:FireClient(PLYR)

	end
	
	for i, TOUCHED_PARTS in pairs(T.Parent:GetDescendants()) do

		if TOUCHED_PARTS:IsA("Script") 
			or TOUCHED_PARTS:IsA("LocalScript") 
			or TOUCHED_PARTS:IsA("ModuleScript") then

			TOUCHED_PARTS.Enabled = false

		end

	end

	for i, COLORING in pairs(SEAL_CLONE:GetDescendants()) do

		if COLORING:IsA("Beam") then
			COLORING.Color = ColorSequence.new(COLOR_SEAL)
		elseif COLORING:IsA("PointLight") then
			COLORING.Color = COLOR_SEAL
		elseif COLORING:IsA("ParticleEmitter") then
			COLORING.Color = ColorSequence.new(COLOR_SEAL)
		end

	end

	for i, COLORING in pairs(HANDLE_CLONE:GetDescendants()) do

		if COLORING:IsA("PointLight") then
			COLORING.Color = COLOR_CRUCIFIX
		elseif COLORING:IsA("ParticleEmitter") then
			COLORING.Color = ColorSequence.new(COLOR_CRUCIFIX)
		end

	end
	
	SOUND.Crucifix.Parent = HANDLE_CLONE
	
	HANDLE_CLONE.Crucifix:Play()
	
	if T.Parent:FindFirstChild("Crucifix_Config") ~= nil then

		local CRUCIFIX_SOUND = T.Parent:FindFirstChild("Crucifix_Config")

		for i, PLAY in pairs(CRUCIFIX_SOUND.Sound:GetChildren()) do

			if PLAY:IsA("Sound") then

				local PLAY_CLONE = PLAY:Clone()

				if T.Parent:FindFirstChild("HumanoidRootPart") ~= nil  then

					PLAY_CLONE.Parent = T.Parent:FindFirstChild("HumanoidRootPart")

					PLAY_CLONE:Play()

				else

					PLAY_CLONE.Parent = T

					PLAY_CLONE:Play()

				end

			end

		end

	end

	HANDLE_CLONE.Anchored = true
	HANDLE_CLONE.CanCollide = false

	HANDLE_CLONE.Material = Enum.Material.Neon
	HANDLE_CLONE.Color = COLOR_CRUCIFIX

	HANDLE_CLONE.Parent = game.Workspace:WaitForChild("CLONED_PARTS")
	SEAL_CLONE.Parent = game.Workspace:WaitForChild("CLONED_PARTS")

	local TI = TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
	local C = {CFrame = HANDLE_CLONE.CFrame * CFrame.new(0,3,-6)}
	local TI2 = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
	local C2 = {AngularVelocity = Vector3.new(0,20,0)}

	local TWEEN_RING = TWEENSERVICE:Create(SEAL_CLONE.Parts.RingAttachmentPart, TI, {Position = SEAL_CLONE.Parts.RingAttachmentPart.Position - Vector3.new(0, 6, 0)})
	local TWEEN_START = TWEENSERVICE:Create(HANDLE_CLONE, TI, C)

	local BAV = Instance.new("BodyAngularVelocity",HANDLE_CLONE)
	local IP = Instance.new("BodyPosition",HANDLE_CLONE)
	local G = Instance.new("BodyGyro",HANDLE_CLONE)

	local TWEEN_BAV1 = TWEENSERVICE:Create(HANDLE_CLONE:WaitForChild("BodyAngularVelocity"), TI2, C2)

	local TWEENINFO_LIGHT = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	local TWEEN_LIGHT = TWEENSERVICE:Create(SEAL_CLONE.Parts.MoonPart.LightAttach.LightBright, TWEENINFO_LIGHT, {Range = 50})

	TWEEN_RING:Play()

	TWEEN_START:Play()

	TWEEN_START.Completed:Wait()

	SEAL_CLONE.Parts.RingAttachmentPart:Destroy()

	HANDLE_CLONE.Anchored = false

	BAV.MaxTorque = Vector3.new(0, 99999999999999999, 0)
	IP.D = 200
	IP.P = 200
	IP.MaxForce = Vector3.new(400000000, 400000000, 400000000)
	IP.Position = HANDLE_CLONE.Position + Vector3.new(0, 1, 0)
	G.MaxTorque = Vector3.new(0, 0, 0)

	TWEEN_BAV1:Play()

	TWEEN_LIGHT:Play()

	wait(0.75)
	
	local MOVEPART_2 = Instance.new("Part")

	MOVEPART_2.Transparency = 0
	MOVEPART_2.Size = Vector3.new(1, 1, 1)
	MOVEPART_2.CanCollide = false
	MOVEPART_2.Anchored = true
	MOVEPART_2.Position = SEAL_CLONE.Parts.MoonPart.Position + Vector3.new(0, -25, 0)

	MOVE2(T.Parent, MOVEPART_2)

	wait(2.75)

	CROSS_CLONE:Destroy()
	SEAL_CLONE.Chain_Beams:Destroy()
	SEALED_CLONE:Destroy()
	
	if T.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
		T.Parent:FindFirstChildOfClass("Humanoid").Health = 0
		for i, UNANCHOR in pairs(T.Parent:GetDescendants()) do
			if UNANCHOR:IsA("BasePart") or UNANCHOR:IsA("Part") or UNANCHOR:IsA("MeshPart") then
				local PLAYERS_INGAME = game.Players:GetPlayers()
				for i = 1, #PLAYERS_INGAME do
					if T.Parent ~= nil then
						if T.Parent.Name == PLAYERS_INGAME[i].Name then

							UNANCHOR.Anchored = false

						end
					end
				end 
			end
		end
	end

	if T.Parent ~= nil then
		if T.Parent:IsA("Model") then
			if T.Parent.Name == CAN_BE_USED_ON[table.find(CAN_BE_USED_ON, T.Parent.Name)] then
				T.Parent:Destroy()
			end
		end
	end
	
	local TWEENINFO_SEAL1 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	local TWEENINFO_SEAL2 = TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

	local TWEEN_BRIGHTNESS1 = TWEENSERVICE:Create(SEAL_CLONE.Seal_Beams.MoonSymbols, TWEENINFO_SEAL1, {Brightness = 0})
	local TWEEN_BRIGHTNESS2 = TWEENSERVICE:Create(SEAL_CLONE.Seal_Beams.Symbols, TWEENINFO_SEAL1, {Brightness = 0})
	local TWEEN_BRIGHTNESS3 = TWEENSERVICE:Create(SEAL_CLONE.Seal_Beams.DevilsStar, TWEENINFO_SEAL1, {Brightness = 0})
	local TWEEN_BRIGHTNESS4 = TWEENSERVICE:Create(SEAL_CLONE.Seal_Beams.Moon, TWEENINFO_SEAL2, {Brightness = 0})

	local TI3 = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
	local C3 = {AngularVelocity = Vector3.new(0,0,0)}

	local TWEEN_BAV2 = TWEENSERVICE:Create(HANDLE_CLONE:WaitForChild("BodyAngularVelocity"), TI3, C3)

	local TWEENINFO_LIGHT2 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	local TWEEN_LIGHT2 = TWEENSERVICE:Create(SEAL_CLONE.Parts.MoonPart.LightAttach.LightBright, TWEENINFO_LIGHT2, {Brightness = 0})
	local TWEEN_LIGHT3 = TWEENSERVICE:Create(HANDLE_CLONE.Light, TWEENINFO_LIGHT2, {Brightness = 0})

	local TWEENINFO_HANDLE = TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
	local TWEEN_END = TWEENSERVICE:Create(HANDLE_CLONE, TWEENINFO_HANDLE, {Size = HANDLE_CLONE.Size + Vector3.new(1, 1, 0)})
	local TWEEN_END2 = TWEENSERVICE:Create(HANDLE_CLONE, TweenInfo.new(1), {Transparency = 2})

	local EXPLODE_PARTICLE = HANDLE_CLONE.ExplodeParticle

	TWEEN_BRIGHTNESS1:Play()
	TWEEN_BRIGHTNESS1.Completed:Wait()

	TWEEN_BRIGHTNESS2:Play()
	TWEEN_BRIGHTNESS2.Completed:Wait()

	TWEEN_BRIGHTNESS3:Play()
	TWEEN_BRIGHTNESS3.Completed:Wait()

	TWEEN_BAV2:Play()

	TWEEN_BRIGHTNESS4:Play()
	TWEEN_BRIGHTNESS4.Completed:Wait()

	TWEEN_LIGHT2:Play()

	TWEEN_LIGHT3:Play()

	TWEEN_END:Play()

	TWEEN_END2:Play()

	EXPLODE_PARTICLE.Enabled = true
	wait(0.05)
	EXPLODE_PARTICLE.Enabled = false

	if UNLIMITED_USE == true and DEBOUNCE == true then

		wait(UNLIMITED_USE_CRUCIFIX_COOLDOWN)

		DEBOUNCE = false

	end

	HANDLE_CLONE.Crucifix.Ended:Wait()
  
    T:Destroy()
	SEAL_CLONE:Destroy()
	HANDLE_CLONE:Destroy()

end

function PLAY_FAILED_FUNCTION(P, T)
	
	local animd
	
	if T.Parent.Name == "SeekMoving" then
		T.Parent.AssetControl.Enabled = false
		
		T.Parent.Settings.GetCrucifixed.Value = true
		
		T.Footsteps:Stop()
		T.FootstepsFar:Stop()
		
		for i,v in pairs(T.Parent.SeekRig.AnimationController:GetPlayingAnimationTracks()) do
			v:Stop()
		end
	end
	
	wait()
	
	if T.Parent.Name == "SeekMoving" then
		animd = T.Parent.SeekRig.AnimationController:LoadAnimation(T.Parent.SeekRig.AnimCrucifix)
		animd:Play()
	end
	
	local HANDLE = TOOL_CRUCIFIX.Handle

	local HANDLE_CLONE = HANDLE:Clone()
	local SEAL_CLONE = SEAL:Clone()
	local SEALED_CLONE = SEALED:Clone()

	local WALKSPEED_SAVE = nil
	local JUMPPOWER_SAVE = nil

	local SOUND = HANDLE_CLONE.Sound
	local CROSS_CLONE = SEAL_CLONE.Parts.MoonPart.Cross

	local PLAYER_HUMANOIDROOTPART = P.HumanoidRootPart
	local PLAYER_POSITION = PLAYER_HUMANOIDROOTPART.Position
	local PLAYER_DIRECTION = PLAYER_HUMANOIDROOTPART.CFrame.LookVector
	local PLAYER_ROTATION = PLAYER_HUMANOIDROOTPART.CFrame - Vector3.new(PLAYER_POSITION, PLAYER_POSITION + PLAYER_DIRECTION)

	local PART_POSITION = PLAYER_POSITION + PLAYER_DIRECTION * 5

	if T.Parent.PrimaryPart ~= T.Parent:FindFirstChild("HumanoidRootPart") and T.Parent:FindFirstChild("HumanoidRootPart") then
		T.Parent.PrimaryPart = T.Parent:FindFirstChild("HumanoidRootPart")
	end
	if T.Parent:FindFirstChild("Hitbox") then
		T.Parent:FindFirstChild("Hitbox").Kill.Enabled = false
	end
	
	if T.Parent:FindFirstChild("Crucified") then
		T.Parent:FindFirstChild("Crucified").Value = true
	end
	if T.Parent.PrimaryPart == nil then
		T.Parent.PrimaryPart = T
	end
	
	local PRIMARY_PART = T.Parent.PrimaryPart

	SEALED_CLONE.Parent = T.Parent

	HANDLE_CLONE.CFrame = CFrame.new(PART_POSITION, PART_POSITION + PLAYER_ROTATION.LookVector)

	if T.Name == "FigureRagdoll" then
		
	else
		if T.Parent:FindFirstChild("HumanoidRootPart") then
			T.Parent:FindFirstChild("HumanoidRootPart").Anchored = true
		end
	end

	if UNLIMITED_USE == false then

		HANDLE:Destroy()
		TOOL_CRUCIFIX.Parent = game.ServerStorage:WaitForChild("TRASH_CRUCIFIX")

	end

	for i, TOUCHED_PARTS in pairs(T.Parent:GetDescendants()) do

		if (TOUCHED_PARTS:IsA("Script") 
			or TOUCHED_PARTS:IsA("LocalScript") 
			or TOUCHED_PARTS:IsA("ModuleScript")) 
			and TOUCHED_PARTS.Name ~= "Animate" and TOUCHED_PARTS.Name ~= "CHandler"  then

			TOUCHED_PARTS.Enabled = false

		end

	end

	for i, COLORING in pairs(SEAL_CLONE:GetDescendants()) do

		if COLORING:IsA("Beam") then
			COLORING.Color = ColorSequence.new(COLOR_SEAL)
		elseif COLORING:IsA("PointLight") then
			COLORING.Color = COLOR_SEAL
		elseif COLORING:IsA("ParticleEmitter") then
			COLORING.Color = ColorSequence.new(COLOR_SEAL)
		end

	end

	for i, COLORING in pairs(HANDLE_CLONE:GetDescendants()) do

		if COLORING:IsA("PointLight") then
			COLORING.Color = COLOR_CRUCIFIX
		elseif COLORING:IsA("ParticleEmitter") then
			COLORING.Color = ColorSequence.new(COLOR_CRUCIFIX)
		end

	end

	if T.Parent:FindFirstChild("HumanoidRootPart") ~= nil then

		local RAYCASTPARAMS = RaycastParams.new()

		RAYCASTPARAMS.FilterDescendantsInstances = {T.Parent}

		local RAYCAST = game.Workspace:Raycast(T.Parent:FindFirstChild("HumanoidRootPart").Position, T.Parent:FindFirstChild("HumanoidRootPart").CFrame.UpVector * -100, RAYCASTPARAMS)

		if RAYCAST then

			local OBJECT = RAYCAST.Instance

			SEAL_CLONE.Parts.MoonPart.Position = RAYCAST.Position

		end

		if UNLIMITED_USE == true then

			--HITBOX.Size = Vector3.new(HITBOX_RANGE, HITBOX_RANGE, HITBOX_RANGE)

		end

		CROSS_CLONE.Parent = T.Parent:FindFirstChild("HumanoidRootPart")

		if T.Parent:FindFirstChild("Crucifix_Config") ~= nil 
			and T.Parent:FindFirstChildOfClass("Humanoid") then

			local CRUCIFIX_ANIMATION = T.Parent:FindFirstChild("Crucifix_Config")
			local ANIMATION = T.Parent:FindFirstChildOfClass("Humanoid"):LoadAnimation(CRUCIFIX_ANIMATION.Animation.Failing.StartAnimation:FindFirstChildOfClass("Animation"))
			
			if CRUCIFIX_ANIMATION.Animation.Failing.StartAnimation.Loop.Value == true then
				ANIMATION.Looped = true
			else
				ANIMATION.Looped = false
			end
			
			ANIMATION:Play()
		end


	elseif T.Parent:FindFirstChild("HumanoidRootPart") == nil then

		local RAYCASTPARAMS = RaycastParams.new()

		RAYCASTPARAMS.FilterDescendantsInstances = {T.Parent}

		local RAYCAST = game.Workspace:Raycast(T.Position, T.CFrame.UpVector * -100, RAYCASTPARAMS)

		if RAYCAST then

			local OBJECT = RAYCAST.Instance

			SEAL_CLONE.Parts.MoonPart.Position = RAYCAST.Position

		end

		if UNLIMITED_USE == true then

			---HITBOX.Size = Vector3.new(HITBOX_RANGE, HITBOX_RANGE, HITBOX_RANGE)

		end

		CROSS_CLONE.Parent = T

	end

	SEAL_CLONE.Parts.RingAttachmentPart.Position = SEAL_CLONE.Parts.MoonPart.Position
	SEAL_CLONE.Parts.DevilsStarPart.Position = SEAL_CLONE.Parts.MoonPart.Position
	SEAL_CLONE.Parts.MoonSymbolsPart.Position = SEAL_CLONE.Parts.MoonPart.Position
	SEAL_CLONE.Parts.SymbolsPart.Position = SEAL_CLONE.Parts.MoonPart.Position
	
	SEAL_CLONE["Self-Destruct"].Enabled = true
	HANDLE_CLONE["Self-Destruct"].Enabled = true
	
	if SHAKE_SCREEN == true then

		local PLYR = game.Players:FindFirstChild(P.Name)

		game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(12, 35, 0.3, 6)
		game.ReplicatedStorage.Crucifix_Remotes.FailingCrucifix:FireClient(PLYR)

	end
	
	SOUND.FailedCrucifix.Parent = HANDLE_CLONE
	
	HANDLE_CLONE.FailedCrucifix:Play()
	
	if T.Parent:FindFirstChild("Crucifix_Config") ~= nil and T.Parent:FindFirstChild("HumanoidRootPart") ~= nil then

		local CRUCIFIX_SOUND = T.Parent:FindFirstChild("Crucifix_Config")

		for i, PLAY in pairs(CRUCIFIX_SOUND.Sound:GetChildren()) do

			if PLAY:IsA("Sound") then
				
				local PLAY_CLONE = PLAY:Clone()
				
				if T.Parent:FindFirstChild("HumanoidRootPart") ~= nil  then
					
					PLAY_CLONE.Parent = T.Parent:FindFirstChild("HumanoidRootPart")

					PLAY_CLONE:Play()
					
				else
					
					PLAY_CLONE.Parent = T
					
					PLAY_CLONE:Play()
					
				end

			end

		end

	end
	
	HANDLE_CLONE.Anchored = true
	HANDLE_CLONE.CanCollide = false

	HANDLE_CLONE.Material = Enum.Material.Neon
	HANDLE_CLONE.Color = COLOR_CRUCIFIX

	HANDLE_CLONE.Parent = game.Workspace:WaitForChild("CLONED_PARTS")
	SEAL_CLONE.Parent = game.Workspace:WaitForChild("CLONED_PARTS")

	local TI = TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
	local C = {CFrame = HANDLE_CLONE.CFrame * CFrame.new(0,3,-6)}
	local TI2 = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
	local C2 = {AngularVelocity = Vector3.new(0,20,0)}
	local TI3 = TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
	local C3 = {AngularVelocity = Vector3.new(0,0,0)}

	local BAV = Instance.new("BodyAngularVelocity",HANDLE_CLONE)
	local BP = Instance.new("BodyPosition",HANDLE_CLONE)
	local G = Instance.new("BodyGyro",HANDLE_CLONE)	

	local TWEEN_RING = TWEENSERVICE:Create(SEAL_CLONE.Parts.RingAttachmentPart, TI, {Position = SEAL_CLONE.Parts.RingAttachmentPart.Position - Vector3.new(0, 6, 0)})
	TWEEN_RING:Play()

	local TWEEN_START = TWEENSERVICE:Create(HANDLE_CLONE, TI, C)
	TWEEN_START:Play()
	TWEEN_START.Completed:Wait()

	SEAL_CLONE.Parts.RingAttachmentPart:Destroy()

	HANDLE_CLONE.Anchored = false

	BAV.MaxTorque = Vector3.new(0, 99999999999999999, 0)
	BP.D = 200
	BP.P = 200
	BP.MaxForce = Vector3.new(400000000, 400000000, 400000000)
	BP.Position = HANDLE_CLONE.Position + Vector3.new(0, 1, 0)
	G.MaxTorque = Vector3.new(0, 0, 0)

	local TWEEN_BAV1 = TWEENSERVICE:Create(HANDLE_CLONE:WaitForChild("BodyAngularVelocity"), TI2, C2)
	TWEEN_BAV1:Play()

	local TWEENINFO_LIGHT = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	local TWEEN_LIGHT = TWEENSERVICE:Create(SEAL_CLONE.Parts.MoonPart.LightAttach.LightBright, TWEENINFO_LIGHT, {Range = 50})
	TWEEN_LIGHT:Play()

	wait(3)

	local TWEEN_BAV2 = TWEENSERVICE:Create(HANDLE_CLONE:WaitForChild("BodyAngularVelocity"), TI3, C3)
	TWEEN_BAV2:Play()

	for i, COLORING in pairs(SEAL_CLONE:GetDescendants()) do

		if COLORING:IsA("Beam") then
			COLORING.Color = ColorSequence.new(COLOR_FAILEDSEAL)
		elseif COLORING:IsA("PointLight") then
			local TWEEN_PLIGHT = TWEENSERVICE:Create(COLORING, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {Color = Color3.new(COLOR_FAILEDSEAL)})
			TWEEN_PLIGHT:Play()
		elseif COLORING:IsA("ParticleEmitter") then
			COLORING.Color = ColorSequence.new(COLOR_FAILEDSEAL)
		end

	end

	for i, COLORING in pairs(HANDLE_CLONE:GetDescendants()) do

		if COLORING:IsA("PointLight") then
			local TWEEN_PLIGHT = TWEENSERVICE:Create(COLORING, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {Color = Color3.new(COLOR_FAILEDCRUCIFIX)})
			TWEEN_PLIGHT:Play()
		elseif COLORING:IsA("ParticleEmitter") then
			COLORING.Color = ColorSequence.new(COLOR_FAILEDCRUCIFIX)
		end

	end

	HANDLE_CLONE.Color = COLOR_FAILEDCRUCIFIX

	wait(FAILED_CRUCIFIX_DURATION)
	
	SEALED_CLONE:Destroy()
	
	local TWEENINFO_HANDLE = TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
	local TWEEN_END = TWEENSERVICE:Create(HANDLE_CLONE, TWEENINFO_HANDLE, {Size = HANDLE_CLONE.Size + Vector3.new(1, 1, 0)})
	TWEEN_END:Play()

	local TWEEN_END2 = TWEENSERVICE:Create(HANDLE_CLONE, TweenInfo.new(2), {Transparency = 1})
	TWEEN_END2:Play()

	wait(0.5)

	if T.Parent:FindFirstChildOfClass("Humanoid") then

		local HUMANOID = T.Parent:FindFirstChildOfClass("Humanoid")
		HUMANOID.WalkSpeed = WALKSPEED_SAVE
		HUMANOID.JumpPower = JUMPPOWER_SAVE

	end

	if T.Parent:FindFirstChild("HumanoidRootPart") and T.Parent:FindFirstChildOfClass("Humanoid") then

		T.Parent:FindFirstChild("HumanoidRootPart").Anchored = false

	end

	if T.Parent:FindFirstChild("Crucifix_Config") ~= nil 
		and T.Parent:FindFirstChildOfClass("Humanoid") then

		local CRUCIFIX_ANIMATION = T.Parent:FindFirstChild("Crucifix_Config")

		local ANIMATION = T.Parent:FindFirstChildOfClass("Humanoid"):LoadAnimation(CRUCIFIX_ANIMATION.Animation.Failing.StartAnimation:FindFirstChildOfClass("Animation"))
		ANIMATION.Looped = false
		ANIMATION:Play()
		ANIMATION:Stop()

		local ANIMATION2 = T.Parent:FindFirstChildOfClass("Humanoid"):LoadAnimation(CRUCIFIX_ANIMATION.Animation.Failing.EndAnimation:FindFirstChildOfClass("Animation"))
		ANIMATION2.Looped = false
		ANIMATION2:Play()

	end

	for i, TOUCHED_PARTS in pairs(T.Parent:GetDescendants()) do

		if TOUCHED_PARTS:IsA("Script") 
			or TOUCHED_PARTS:IsA("LocalScript") 
			or TOUCHED_PARTS:IsA("ModuleScript") then

			TOUCHED_PARTS.Enabled = true

		end

	end

	for i, CHAIN in pairs(SEAL_CLONE.Chain_Beams:GetDescendants()) do

		if CHAIN:IsA("Beam") then
			local TWEENINFO_CHAINSEAL = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
			TWEENSERVICE:Create(CHAIN, TWEENINFO_CHAINSEAL, {Brightness = 0}):Play()
		end

	end
	
	local TWEENINFO_SEAL1 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	local TWEENINFO_SEAL2 = TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	local TWEENINFO_SEAL3 = TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

	local TWEEN_BRIGHTNESS1 = TWEENSERVICE:Create(SEAL_CLONE.Seal_Beams.MoonSymbols, TWEENINFO_SEAL1, {Brightness = 0})
	local TWEEN_BRIGHTNESS2 = TWEENSERVICE:Create(SEAL_CLONE.Seal_Beams.Symbols, TWEENINFO_SEAL1, {Brightness = 0})
	local TWEEN_BRIGHTNESS3 = TWEENSERVICE:Create(SEAL_CLONE.Seal_Beams.DevilsStar, TWEENINFO_SEAL1, {Brightness = 0})
	local TWEEN_BRIGHTNESS4 = TWEENSERVICE:Create(SEAL_CLONE.Seal_Beams.Moon, TWEENINFO_SEAL3, {Brightness = 0})

	local TWEENINFO_LIGHT2 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

	local TWEEN_LIGHT2 = TWEENSERVICE:Create(SEAL_CLONE.Parts.MoonPart.LightAttach.LightBright, TWEENINFO_LIGHT2, {Brightness = 0})
	local TWEEN_LIGHT3 = TWEENSERVICE:Create(HANDLE_CLONE.Light, TWEENINFO_LIGHT2, {Brightness = 0})

	TWEEN_BRIGHTNESS1:Play()
	TWEEN_BRIGHTNESS1.Completed:Wait()

	TWEEN_BRIGHTNESS2:Play()
	TWEEN_BRIGHTNESS2.Completed:Wait()

	TWEEN_BRIGHTNESS3:Play()
	TWEEN_BRIGHTNESS3.Completed:Wait()

	TWEEN_BRIGHTNESS4:Play()
	TWEEN_BRIGHTNESS4.Completed:Wait()

	TWEEN_LIGHT2:Play()

	TWEEN_LIGHT3:Play()
	
	--[[if T.Parent:FindFirstChild("Crucifix_Config") ~= nil then

		local CRUCIFIX_ANIMATION = T.Parent:FindFirstChild("Crucifix_Config")

		local ANIMATION = T.Parent:FindFirstChild("Humanoid"):LoadAnimation(CRUCIFIX_ANIMATION.Animation:FindFirstChildOfClass("Animation"))
		ANIMATION:Play()

	end--]]

	if UNLIMITED_USE == true and DEBOUNCE == true then

		wait(UNLIMITED_USE_FAILEDCRUCIFIX_COOLDOWN)

		if T.Parent:FindFirstChild("Sealed") ~= nil then
			T.Parent:FindFirstChild("Sealed"):Destroy()
		end

		DEBOUNCE = false

	end

	HANDLE_CLONE.FailedCrucifix.Ended:Wait()

	SEAL_CLONE:Destroy()
	HANDLE_CLONE:Destroy()

	if T.Parent:FindFirstChild("Hitbox") then
		T.Parent:FindFirstChild("Hitbox").Kill.Enabled = true
	end
	if T.Parent.Name == "SeekMoving" then
		T.Parent.AssetControl.Enabled = true
		animd:Stop()
	end
	if T.Parent:FindFirstChild("Crucified") then
		T.Parent:FindFirstChild("Crucified").Value = false
	end

end

TOOL_CRUCIFIX.Equipped:Connect(function() 

	local PLAYER = TOOL_CRUCIFIX.Parent	
	
	script.Parent.Function.Event:Connect(function(model)
		Hold:Stop()
		PLAYER:SetAttribute("CuriousEnabled", false)
		if model.Parent.Name == "Rush" or model.Parent.Name == "RushNew" or model.Parent.Name == "Screech" or model.Parent.Name == "LookMan" or model.Parent.Name == "A60Moving" or model.Parent.Name == "TrololoMoving" or model.Parent.Name == "KreekMoving" then
			model.Parent:SetAttribute("Crucifixed", true)
			PLAY_FUNCTION(PLAYER, model)
		elseif model.Parent.Name == "SeekMoving" then
			PLAY_FAILED_FUNCTION(PLAYER, model)
		elseif model.Name == "FigureRagdoll" then
			PLAY_FAILED_FUNCTION(PLAYER, model)
		end
	end)

end)

script.Parent.Equipped:Connect(function()
	script.Parent.Parent:SetAttribute("CuriousEnabled", true)
	Hold:Play()
end)

script.Parent.Unequipped:Connect(function()
	local player = script.Parent.Parent.Parent
	player.Character:SetAttribute("CuriousEnabled", false)
	Hold:Stop()
end)