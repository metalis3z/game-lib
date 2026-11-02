local UserInputService = game:GetService("UserInputService")
local InitialSensitivity = UserInputService.MouseDeltaSensitivity
local TweeningService = game:GetService("TweenService")
local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera
local Character = workspace:WaitForChild(Player.Name)
local Humanoid = Character:WaitForChild("Humanoid")
--local TEAM = Character:WaitForChild("TEAM")
local Module = require(Tool:WaitForChild("Setting"))
local GunScript_Server = Tool:WaitForChild("GunScript_Server")
local ChangeMagAndAmmo = GunScript_Server:WaitForChild("ChangeMagAndAmmo")
local PlayServerSound = GunScript_Server:WaitForChild("PlayServerSound")
local VisualizeBullet = game.ReplicatedStorage:WaitForChild("VisualizeBullet")
local VisualizeMuzzle = game.ReplicatedStorage:WaitForChild("VisualizeMuzzle")
local MarkerEvent = script:WaitForChild("MarkerEvent")
local MagValue = GunScript_Server:WaitForChild("Mag")
local AmmoValue = GunScript_Server:WaitForChild("Ammo")
local GUI = script:WaitForChild("GunGUI")
local CrosshairModule = require(GUI:WaitForChild("CrosshairModule"))
local CameraModule = require(GUI:WaitForChild("CameraModule"))
local IdleAnim
local FireAnim
local ReloadAnim
local ShotgunClipinAnim
local HoldDownAnim
local EquippedAnim
local SlideAnim
local Grip2
local Handle2
local HandleToFire = Handle
local jammed = false
local shootEnabled = false

local slid = false

local spring = require(script.SpringModule)
local oldPosition = Vector2.new()

local self={}

-- for the scope wiggle
self.scope = spring.new(Vector3.new(0,200,0))
self.scope.s = Module.ScopeSwaySpeed
self.scope.d = Module.ScopeSwayDamper

-- for the knockback wiggle
self.knockback = spring.new(Vector3.new())
self.knockback.s = Module.ScopeKnockbackSpeed
self.knockback.d = Module.ScopeKnockbackDamper

--------------------------------------------------------------------------------------------------

if Module.DualEnabled then
	Handle2 = Tool:WaitForChild("Handle2",2)
	if Handle2 == nil and Module.DualEnabled then error("\"Dual\" setting is enabled but \"Handle2\" is missing!") end
end

local Equipped = false
local Enabled = true
local Down = false
local HoldDown = false
local Reloading = false
local AimDown = false
local Scoping = false
local Mag = MagValue.Value
local Ammo = AmmoValue.Value
local MaxAmmo = Module.MaxAmmo
local slideEnabled = true


local tickDb = false
function tickSound()
	if Reloading then return end
	if tickDb == true then return end

	tickDb = true
	PlayServerSound:FireServer(Handle.TickSound)

	delay(0,function()
		tickDb = false
	end)
end

local GunRunA = Instance.new('Animation')
GunRunA.Name = 'GunRun'         -- 16377000099             16389196838
GunRunA.AnimationId = 'rbxassetid://17149115432'
GunRun = Humanoid:LoadAnimation(GunRunA)
GunRun.Priority = Enum.AnimationPriority.Action

if Module.IdleAnimationID ~= nil or Module.DualEnabled then
	IdleAnim = Tool:WaitForChild("IdleAnim")
	IdleAnim = Humanoid:LoadAnimation(IdleAnim) 
	IdleAnim.Priority = Enum.AnimationPriority.Action2
end
if Module.FireAnimationID ~= nil then
	FireAnim = Tool:WaitForChild("FireAnim")
	FireAnim = Humanoid:LoadAnimation(FireAnim) 
	FireAnim.Priority = Enum.AnimationPriority.Action2
end
if Module.ReloadAnimationID ~= nil then
	ReloadAnim = Tool:WaitForChild("ReloadAnim")
	ReloadAnim = Humanoid:LoadAnimation(ReloadAnim)
end
if Module.ShotgunClipinAnimationID ~= nil then
	ShotgunClipinAnim = Tool:WaitForChild("ShotgunClipinAnim")
	ShotgunClipinAnim = Humanoid:LoadAnimation(ShotgunClipinAnim)
end
if Module.HoldDownAnimationID ~= nil then
	HoldDownAnim = Tool:WaitForChild("HoldDownAnim")
	HoldDownAnim = Humanoid:LoadAnimation(HoldDownAnim) HoldDownAnim.Priority = Enum.AnimationPriority.Action2
end
if Module.EquippedAnimationID ~= nil then
	EquippedAnim = Tool:WaitForChild("EquippedAnimation")
	EquippedAnim = Humanoid:LoadAnimation(EquippedAnim)
end
if slideEnabled then
	SlideAnim = Tool:WaitForChild("SlideAnim")
	SlideAnim = Humanoid:LoadAnimation(SlideAnim)
end

function wait(TimeToWait)
	if TimeToWait ~= nil then
		local TotalTime = 0
		TotalTime = TotalTime + game:GetService("RunService").Heartbeat:wait()
		while TotalTime < TimeToWait do
			TotalTime = TotalTime + game:GetService("RunService").Heartbeat:wait()
		end
	else
		game:GetService("RunService").Heartbeat:wait()
	end
end

function numLerp(A, B, Alpha)
	return A + (B - A) * Alpha
end

function RAND(Min, Max, Accuracy)
	local Inverse = 1 / (Accuracy or 1)
	return (math.random(Min * Inverse, Max * Inverse) / Inverse)
end

--Casts a ray. It will ignore nearly transparent objects and the tool's parent.
function CastRay(StartPos,Direction,Length)
	local Hit,EndPos = game.Workspace:FindPartOnRay(Ray.new(StartPos,Direction * Length))
	if Hit then
		if (not Tool.Parent or Hit:IsDescendantOf(Tool.Parent)) or Hit.Transparency > 0.9 then
			return CastRay(EndPos + (Direction * 0.01),Direction,Length - ((StartPos - EndPos).magnitude))
		end
	end

	return EndPos
end

--Casts the input's position to 3D space.
local function Get3DPosition(CurrentPosOnScreen)
	local X = CurrentPosOnScreen.X + math.random(-Module.SpreadX * 2, Module.SpreadX * 2) * (AimDown and 1-Module.SpreadRedutionIS and 1-Module.SpreadRedutionS or 1)
	local Y = CurrentPosOnScreen.Y + math.random(-Module.SpreadY * 2, Module.SpreadY * 2) * (AimDown and 1-Module.SpreadRedutionIS and 1-Module.SpreadRedutionS or 1)
	local InputRay = Camera:ScreenPointToRay(X,Y)
	local EndPos = InputRay.Origin + InputRay.Direction
	return CastRay(Camera.CFrame.p,(EndPos - Camera.CFrame.p).unit,1000)
end

MarkerEvent.Event:connect(function(IsHeadshot)
	pcall(function()
		if Module.HitmarkerEnabled then
			if IsHeadshot then
				GUI.Crosshair.Hitmarker.ImageColor3 = Module.HitmarkerColorHS
				GUI.Crosshair.Hitmarker.ImageTransparency = 0
				TweeningService:Create(GUI.Crosshair.Hitmarker, TweenInfo.new(Module.HitmarkerFadeTimeHS, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
				local markersound = GUI.Crosshair.MarkerSound:Clone()
				markersound.SoundId = "rbxassetid://"..Module.HitmarkerSoundID[math.random(1,#Module.HitmarkerSoundID)]
				markersound.PlaybackSpeed = Module.HitmarkerSoundPitchHS
				markersound.Parent = Player.PlayerGui
				markersound:Play()
				game:GetService("Debris"):addItem(markersound,1.15)
			else
				GUI.Crosshair.Hitmarker.ImageColor3 = Module.HitmarkerColor
				GUI.Crosshair.Hitmarker.ImageTransparency = 0
				TweeningService:Create(GUI.Crosshair.Hitmarker, TweenInfo.new(Module.HitmarkerFadeTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
				local markersound = GUI.Crosshair.MarkerSound:Clone()
				markersound.SoundId = "rbxassetid://"..Module.HitmarkerSoundID[math.random(1,#Module.HitmarkerSoundID)]
				markersound.PlaybackSpeed = Module.HitmarkerSoundPitch
				markersound.Parent = Player.PlayerGui
				markersound:Play()
				game:GetService("Debris"):addItem(markersound,1.15)
			end
		end
	end)
end)

function EjectShell(ShootingHandle)
	 if Module.BulletShellEnabled and _G.Effects == true then
		local ShellPos = (ShootingHandle.CFrame * CFrame.new(Module.BulletShellOffset.X,Module.BulletShellOffset.Y,Module.BulletShellOffset.Z)).p
		local Chamber = Instance.new("Part")
		Chamber.Name = "Chamber"
		Chamber.Size = Vector3.new(0.01,0.01,0.01)
		Chamber.Transparency = 1
		Chamber.Anchored = false
		Chamber.CanCollide = false
		Chamber.TopSurface = Enum.SurfaceType.SmoothNoOutlines
		Chamber.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
		local Weld = Instance.new("Weld",Chamber)
		Weld.Part0 = ShootingHandle
		Weld.Part1 = Chamber
		Weld.C0 = CFrame.new(Module.BulletShellOffset.X,Module.BulletShellOffset.Y,Module.BulletShellOffset.Z)
		Chamber.Position = ShellPos
		Chamber.Parent = workspace.CurrentCamera
		local function spawner()
			local Shell = Instance.new("Part")
			Shell.CFrame = Chamber.CFrame * CFrame.fromEulerAnglesXYZ(-2.5,1,1)
			Shell.Size = Module.ShellSize
			Shell.CanCollide = Module.AllowCollide
			Shell.Name = "Shell"
			--VVV Edit here VVV--
			Shell.Velocity = Chamber.CFrame.lookVector * 20 + Vector3.new(math.random(-10,10),20,math.random(-10,10))
			Shell.RotVelocity = Vector3.new(0,200,0)
			--^^^ Edit here ^^^--
			Shell.Parent = workspace.CurrentCamera
			local shellmesh = Instance.new("SpecialMesh")
			shellmesh.Scale = Module.ShellScale
			shellmesh.MeshId = "rbxassetid://"..Module.ShellMeshID
			shellmesh.TextureId = "rbxassetid://"..Module.ShellTextureID
			shellmesh.MeshType = "FileMesh"
			shellmesh.Parent = Shell
			game:GetService("Debris"):addItem(Shell,Module.DisappearTime)
		end	
		spawn(spawner)
		game.Debris:AddItem(Chamber,10)									
	end
end

local recoiling = false

function RecoilCamera()
	if Module.CameraRecoilingEnabled then
		local CurrentRecoil = Module.Recoil*(AimDown and 1-Module.RecoilRedution or 1)
		local RecoilX = math.rad(CurrentRecoil * RAND(Module.AngleX_Min, Module.AngleX_Max, Module.Accuracy))
		local RecoilY = math.rad(CurrentRecoil * RAND(Module.AngleY_Min, Module.AngleY_Max, Module.Accuracy))
		local RecoilZ = math.rad(CurrentRecoil * RAND(Module.AngleZ_Min, Module.AngleZ_Max, Module.Accuracy))
		CameraModule:accelerate(RecoilX,RecoilY,RecoilZ)	    
		delay(0.03, function()
			CameraModule:accelerateXY(-RecoilX,-RecoilY)
		end)
	end
end

function Slide()
	if slid == true then return end
	if not Equipped then return end
	
	slid = true
	if Handle:FindFirstChild("SlideSound") then
		PlayServerSound:FireServer(Handle.SlideSound)	
	end	
	UpdateGUI()
	SlideAnim:Play()
end

function Jam()
	jammed = true
	UpdateGUI()
end

function UnJam()
	if jammed then
		jammed = false
		if Handle:FindFirstChild("SlideSound") then
			PlayServerSound:FireServer(Handle.SlideSound)	
		end	
		SlideAnim:Play()
		UpdateGUI()
	end
end

GUI.MobileButtons.Unjam.MouseButton1Click:Connect(function()
	if not slid then
		Slide()
	end

	UnJam()
end)

UserInputService.InputBegan:Connect(function(key, gp)
	if not gp then
		if key.KeyCode == Enum.KeyCode.ButtonB then
			if not slid then
				Slide()
			end
			if jammed then
				UnJam()
			end
		end
	end
end)


UserInputService.InputBegan:Connect(function(key,gp)
	if not gp then
		if key.KeyCode == Module.JamKey and jammed then
			UnJam()
		end
	end
end)

UserInputService.InputBegan:Connect(function(key,gp)
	if not gp then
		if key.KeyCode == Module.JamKey and not slid then
			Slide()
		end
	end
end)

function Fire(ShootingHandle, InputPos) if Character:FindFirstChild('RAGDOLLED') then return end	
	if Humanoid.WalkSpeed >= 14 then 
		if GunRun then GunRun:Play(nil, nil, Module.FireAnimationSpeed) end
	else 
		if FireAnim then FireAnim:Play(nil,nil,Module.FireAnimationSpeed) end 
	end

	local chancing = math.random(1,150)

	if chancing <= Module.JamChance then
		Jam()
		return
	end

	local FireDirection = (InputPos - ShootingHandle:FindFirstChild("GunFirePoint").WorldPosition).unit
	Player.PlayerScripts.BulletVisualizerClientScript.Visualize:Fire(Tool,ShootingHandle,FireDirection,
		ShootingHandle:FindFirstChild("GunFirePoint"),
		{Module.HitEffectEnabled,Module.HitSoundIDs,Module.HitSoundPitchMin,Module.HitSoundPitchMax,Module.HitSoundVolume,script:WaitForChild("HitEffect"),Module.CustomHitEffect},
		{Module.BloodEnabled,Module.HitCharSndIDs,Module.HitCharSndPitchMin,Module.HitCharSndPitchMax,Module.HitCharSndVolume,script:WaitForChild("BloodEffect")},
		{Module.BulletHoleEnabled,Module.BulletHoleSize,Module.BulletHoleTexture,Module.PartColor,Module.BulletHoleVisibleTime,Module.BulletHoleFadeTime},
		{Module.ExplosiveEnabled,Module.ExplosionRadius,Module.ExplosionSoundEnabled,Module.ExplosionSoundIDs,Module.ExplosionSoundPitchMin,Module.ExplosionSoundPitchMax,Module.ExplosionSoundVolume,Module.CustomExplosion,script:WaitForChild("ExplosionEffect")},
		{Module.BulletTracerEnabled,Module.BulletTracerOffset0,Module.BulletTracerOffset1,script:WaitForChild("TracerEffect"),Module.BulletParticleEnaled,script:WaitForChild("ParticleEffect"),Module.Range,Module.BulletSpeed,Module.DropGravity,Module.WindOffset,Module.BulletSize,Module.BulletColor,Module.BulletTransparency,Module.BulletMaterial,Module.BulletShape,Module.BulletMeshEnabled,Module.BulletMeshID,Module.BulletTextureID,Module.BulletMeshScale},
		{Module.BaseDamage,Module.HeadshotDamageMultiplier,Module.HeadshotEnabled},
		{Module.BulletLightEnabled,Module.BulletLightBrightness,Module.BulletLightColor,Module.BulletLightRange,Module.BulletLightShadows},
		{Module.Knockback, Module.Lifesteal, Module.FlamingBullet, Module.FreezingBullet, GunScript_Server:FindFirstChild("IgniteScript"), GunScript_Server:FindFirstChild("IcifyScript"), Module.IgniteChance, Module.IcifyChance},
		{Module.CriticalDamageEnabled,Module.CriticalBaseChance,Module.CriticalDamageMultiplier},
		{Module.GoreEffectEnabled,Module.GoreSoundIDs,Module.GoreSoundPitchMin,Module.GoreSoundPitchMax,Module.GoreSoundVolume,script:WaitForChild("GoreEffect")})
	VisualizeBullet:FireServer(Tool,ShootingHandle,FireDirection,
		ShootingHandle:FindFirstChild("GunFirePoint"),
		{Module.HitEffectEnabled,Module.HitSoundIDs,Module.HitSoundPitchMin,Module.HitSoundPitchMax,Module.HitSoundVolume,script:WaitForChild("HitEffect"),Module.CustomHitEffect},
		{Module.BloodEnabled,Module.HitCharSndIDs,Module.HitCharSndPitchMin,Module.HitCharSndPitchMax,Module.HitCharSndVolume,script:WaitForChild("BloodEffect")},
		{Module.BulletHoleEnabled,Module.BulletHoleSize,Module.BulletHoleTexture,Module.PartColor,Module.BulletHoleVisibleTime,Module.BulletHoleFadeTime},
		{Module.ExplosiveEnabled,Module.ExplosionRadius,Module.ExplosionSoundEnabled,Module.ExplosionSoundIDs,Module.ExplosionSoundPitchMin,Module.ExplosionSoundPitchMax,Module.ExplosionSoundVolume,Module.CustomExplosion,script:WaitForChild("ExplosionEffect")},
		{Module.BulletTracerEnabled,Module.BulletTracerOffset0,Module.BulletTracerOffset1,script:WaitForChild("TracerEffect"),Module.BulletParticleEnaled,script:WaitForChild("ParticleEffect"),Module.Range,Module.BulletSpeed,Module.DropGravity,Module.WindOffset,Module.BulletSize,Module.BulletColor,Module.BulletTransparency,Module.BulletMaterial,Module.BulletShape,Module.BulletMeshEnabled,Module.BulletMeshID,Module.BulletTextureID,Module.BulletMeshScale},
		{Module.WhizSoundEnabled,Module.WhizSoundID,Module.WhizSoundVolume,Module.WhizSoundPitchMin,Module.WhizSoundPitchMax,Module.WhizDistance},
		{Module.BulletLightEnabled,Module.BulletLightBrightness,Module.BulletLightColor,Module.BulletLightRange,Module.BulletLightShadows})												
end

function Reload()
	if Enabled and not Reloading and (Ammo > 0 or not Module.LimitedAmmoEnabled) and Mag < Module.AmmoPerMag then
		Reloading = true
		if AimDown then
			TweeningService:Create(Camera, TweenInfo.new(Module.TweenLengthNAD, Module.EasingStyleNAD, Module.EasingDirectionNAD), {FieldOfView = _G.FOV}):Play()
			CrosshairModule:setcrossscale(1)
			--[[local GUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ZoomGui")
			if GUI then GUI:Destroy() end]]
			Scoping = false
			game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.Classic
			UserInputService.MouseDeltaSensitivity = InitialSensitivity
			AimDown = false
		end
		UpdateGUI()
		if Module.ShotgunReload then
			for i = 1,(Module.AmmoPerMag - Mag) do
				if ShotgunClipinAnim then ShotgunClipinAnim:Play(nil,nil,Module.ShotgunClipinAnimationSpeed) end
				Handle.ShotgunClipin:Play()
				wait(Module.ShellClipinSpeed)
			end
		end
		if ReloadAnim then ReloadAnim:Play(nil,nil,Module.ReloadAnimationSpeed) end

		PlayServerSound:FireServer(Handle.ReloadSound)


		wait(Module.ReloadTime)
		if Module.LimitedAmmoEnabled then
			local ammoToUse = math.min(Module.AmmoPerMag - Mag, Ammo)
			Mag = Mag + ammoToUse
			Ammo = Ammo - ammoToUse
		else
			Mag = Module.AmmoPerMag
		end
		ChangeMagAndAmmo:FireServer(Mag,Ammo)
		Reloading = false
		UpdateGUI()
	end
end

function UpdateGUI()
	GUI.Frame.Mag.Fill:TweenSizeAndPosition(UDim2.new(Mag/Module.AmmoPerMag,0,1,0), UDim2.new(0,0,0,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.25, true)
	GUI.Frame.Ammo.Fill:TweenSizeAndPosition(UDim2.new(Ammo/Module.MaxAmmo,0,1,0), UDim2.new(0,0,0,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.25, true)
	GUI.Frame.Mag.Current.Text = Mag
	GUI.Frame.Mag.Max.Text = Module.AmmoPerMag
	GUI.Frame.Ammo.Current.Text = Ammo
	GUI.Frame.Ammo.Max.Text = Module.MaxAmmo

	GUI.Frame.Mag.Current.Visible = not Reloading
	GUI.Frame.Mag.Max.Visible = not Reloading
	GUI.Frame.Mag.Frame.Visible = not Reloading
	GUI.Frame.Mag.Reloading.Visible = Reloading

	GUI.Frame.Ammo.Current.Visible = not (Ammo <= 0)
	GUI.Frame.Ammo.Max.Visible = not (Ammo <= 0)
	GUI.Frame.Ammo.Frame.Visible = not (Ammo <= 0)
	GUI.Frame.Ammo.NoMoreAmmo.Visible = (Ammo <= 0)

	GUI.Frame.Ammo.Visible = Module.LimitedAmmoEnabled
	GUI.Frame.Size = Module.LimitedAmmoEnabled and UDim2.new(0,250,0,100) or UDim2.new(0,250,0,55)
	GUI.Frame.Position = Module.LimitedAmmoEnabled and UDim2.new(1,-260,1,-140)or UDim2.new(1,-260,1,-95)
	GUI.MobileButtons.Visible = UserInputService.TouchEnabled --For mobile version
	GUI.MobileButtons.AimButton.Visible = Module.SniperEnabled or Module.IronsightEnabled
	GUI.MobileButtons.HoldDownButton.Visible = Module.HoldDownEnabled
	GUI.MobileButtons.Unjam.Visible = jammed

	if not slid then
		GUI.MobileButtons.Unjam.Visible = true
	end

	if not GUI.MobileButtons.Visible then

		if not slid then
			GUI.Frame.Ammo.Jam.Visible = true
			GUI.Frame.Ammo.Jam.Text = "PRESS F TO SLIDE"
			return
		end

		GUI.Frame.Ammo.Jam.Visible = jammed
		GUI.Frame.Ammo.Jam.Text = "JAMMED - PRESS "..Module.JamKeyString.." TO UNJAM"
	end	
end

--------------------------------------------------------------------------------------------------

--= Mobile Functions =--

-- aiming

GUI.MobileButtons.AimButton.MouseButton1Click:connect(function()
	if not Reloading and not HoldDown and AimDown == false and Equipped == true and Module.IronsightEnabled and (Character.Head.Position - Camera.CoordinateFrame.p).magnitude <= 1 then
		TweeningService:Create(Camera, TweenInfo.new(Module.TweenLength, Module.EasingStyle, Module.EasingDirection), {FieldOfView = _G.FOV - 5}):Play()
		CrosshairModule:setcrossscale(Module.CrossScaleIS)
		--[[local GUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ZoomGui") or Tool.ZoomGui:Clone()
		GUI.Parent = game:GetService("Players").LocalPlayer.PlayerGui]]
		--Scoping = false
		game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
		UserInputService.MouseDeltaSensitivity = InitialSensitivity * Module.MouseSensitiveIS
		AimDown = true
	elseif not Reloading and not HoldDown and AimDown == false and Equipped == true and Module.SniperEnabled and (Character.Head.Position - Camera.CoordinateFrame.p).magnitude <= 1 then
		TweeningService:Create(Camera, TweenInfo.new(Module.TweenLength, Module.EasingStyle, Module.EasingDirection), {FieldOfView = _G.FOV - 30}):Play()
		CrosshairModule:setcrossscale(Module.CrossScaleS)
		--[[local GUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ZoomGui") or Tool.ZoomGui:Clone()
		GUI.Parent = game:GetService("Players").LocalPlayer.PlayerGui]]
		local zoomsound = GUI.Scope.ZoomSound:Clone()
		zoomsound.Parent = Player.PlayerGui
		zoomsound:Play()
		Scoping = true
		game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
		UserInputService.MouseDeltaSensitivity = InitialSensitivity * Module.MouseSensitiveS
		AimDown = true
		game:GetService("Debris"):addItem(zoomsound,5)
	else
		TweeningService:Create(Camera, TweenInfo.new(Module.TweenLengthNAD, Module.EasingStyleNAD, Module.EasingDirectionNAD), {FieldOfView = _G.FOV}):Play()
		CrosshairModule:setcrossscale(1)
		--[[local GUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ZoomGui")
		if GUI then GUI:Destroy() end]]
		Scoping = false
		game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.Classic
		UserInputService.MouseDeltaSensitivity = InitialSensitivity
		AimDown = false
	end
end)

-- holding down gun

GUI.MobileButtons.HoldDownButton.MouseButton1Click:connect(function()
	if not Reloading and not HoldDown and Module.HoldDownEnabled then
		HoldDown = true
		IdleAnim:Stop()
		if HoldDownAnim then HoldDownAnim:Play(nil,nil,Module.HoldDownAnimationSpeed) end
		if AimDown then
			TweeningService:Create(Camera, TweenInfo.new(Module.TweenLengthNAD, Module.EasingStyleNAD, Module.EasingDirectionNAD), {FieldOfView = _G.FOV}):Play()
			CrosshairModule:setcrossscale(1)
        --[[local GUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ZoomGui")
        if GUI then GUI:Destroy() end]]
			Scoping = false
			game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.Classic
			UserInputService.MouseDeltaSensitivity = InitialSensitivity
			AimDown = false
		end
	else
		HoldDown = false
		IdleAnim:Play(nil,nil,Module.IdleAnimationSpeed)
		if HoldDownAnim then HoldDownAnim:Stop() end
	end
end)

UserInputService.InputBegan:Connect(function(key, gp)
	if not gp then
		if key.KeyCode == Enum.KeyCode.ButtonY then
			if not Reloading and not HoldDown and Module.HoldDownEnabled then
				HoldDown = true
				IdleAnim:Stop()
				if HoldDownAnim then HoldDownAnim:Play(nil,nil,Module.HoldDownAnimationSpeed) end
				if AimDown then
					TweeningService:Create(Camera, TweenInfo.new(Module.TweenLengthNAD, Module.EasingStyleNAD, Module.EasingDirectionNAD), {FieldOfView = _G.FOV}):Play()
					CrosshairModule:setcrossscale(1)
					Scoping = false
					game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.Classic
					UserInputService.MouseDeltaSensitivity = InitialSensitivity
					AimDown = false
				end
			else
				HoldDown = false
				IdleAnim:Play(nil,nil,Module.IdleAnimationSpeed)
				if HoldDownAnim then HoldDownAnim:Stop() end
			end
		end
	end
end)

-- reloading

GUI.MobileButtons.ReloadButton.MouseButton1Click:connect(function()
	Reload()
end)

UserInputService.InputBegan:Connect(function(key, gp)
	if not gp then
		if key.KeyCode == Enum.KeyCode.ButtonX then
			Reload()
		end
	end
end)

-- firing

GUI.MobileButtons.FireButton.MouseButton1Down:connect(function()
	if jammed then return end
	if slid == false then return end
	if not shootEnabled and Equipped or (Character:FindFirstChild('RAGDOLLED')) then return end
	if Mag <= 0 then return tickSound() end

	Down = true
	local IsChargedShot = false
	if Equipped and Enabled and Down and not Reloading and not HoldDown and Mag > 0 and Humanoid.Health > 0 then
		Enabled = false
		if Module.ChargedShotEnabled then
			if HandleToFire:FindFirstChild("ChargeSound") then HandleToFire.ChargeSound:Play() end
			wait(Module.ChargingTime)
			IsChargedShot = true
		end
		if Module.MinigunEnabled then
			if HandleToFire:FindFirstChild("WindUp") then HandleToFire.WindUp:Play() end
			wait(Module.DelayBeforeFiring)
		end
		while Equipped and not Reloading and not HoldDown and (Down or IsChargedShot) and Mag > 0 and Humanoid.Health > 0 and not jammed do
			IsChargedShot = false

			Player.PlayerScripts.BulletVisualizerServerScript.VisualizeM:Fire(HandleToFire,
				Module.MuzzleFlashEnabled,
				{Module.MuzzleLightEnabled,Module.LightBrightness,Module.LightColor,Module.LightRange,Module.LightShadows,Module.VisibleTime},
				script:WaitForChild("MuzzleEffect"))
			VisualizeMuzzle:FireServer(HandleToFire,
				Module.MuzzleFlashEnabled,
				{Module.MuzzleLightEnabled,Module.LightBrightness,Module.LightColor,Module.LightRange,Module.LightShadows,Module.VisibleTime},
				script:WaitForChild("MuzzleEffect"))	

			for i = 1,(Module.BurstFireEnabled and Module.BulletPerBurst or 1) do
				--VVV Edit here VVV--
				self.knockback.t = 1 * Vector3.new(-1, -20 * .005, 0)
				--^^^ Edit here ^^^--
				spawn(RecoilCamera)
				EjectShell(HandleToFire)
				CrosshairModule.crossspring:accelerate(Module.CrossExpansion)	

				if Module["PlayAllSounds"] and Module["PlayAllSounds"] == true then
					if HandleToFire:FindFirstChild("FireSounds") then
						for i,v in pairs(HandleToFire:FindFirstChild("FireSounds"):GetChildren()) do
							Player.PlayerScripts.BulletVisualizerServerScript.Play:Fire{
								SoundId = v.SoundId,
								Position = HandleToFire,
								Effects = Module.EchoEffect,
								Volume = v.Volume,
								EmitterSize = v.EmitterSize,
								Pitch = v.PlaybackSpeed,
								Replicate = Module.Replicate
							}
						end
					else
						local sounder = getRandomSound()
						Player.PlayerScripts.BulletVisualizerServerScript.Play:Fire{
							SoundId = sounder.SoundId,
							Position = HandleToFire,
							Effects = Module.EchoEffect,
							Volume = sounder.Volume,
							EmitterSize = sounder.EmitterSize,
							Pitch = sounder.PlaybackSpeed,
							Replicate = Module.Replicate
						}
					end
				else
					local sounder = getRandomSound()
					Player.PlayerScripts.BulletVisualizerServerScript.Play:Fire{
						SoundId = sounder.SoundId,
						Position = HandleToFire,
						Effects = Module.EchoEffect,
						Volume = sounder.Volume,
						EmitterSize = sounder.EmitterSize,
						Pitch = sounder.PlaybackSpeed,
						Replicate = Module.Replicate
					}
				end

				for x = 1,(Module.ShotgunEnabled and Module.BulletPerShot or 1) do
					local Position = Get3DPosition(GUI.Crosshair.AbsolutePosition)
					Fire(HandleToFire, Position)
				end
				Mag = Mag - 1
				ChangeMagAndAmmo:FireServer(Mag,Ammo)
				UpdateGUI()
				if Module.BurstFireEnabled then wait(Module.BurstRate) end
				if Mag <= 0 or jammed then break end
			end
			HandleToFire = (HandleToFire == Handle and Module.DualEnabled) and Handle2 or Handle
			wait(Module.FireRate)
			if not Module.Auto then break end
		end
		stopRunning(true)
		if Module.MinigunEnabled then
			if HandleToFire:FindFirstChild("WindDown") then HandleToFire.WindDown:Play() end
			wait(Module.DelayAfterFiring)
		end
		Enabled = true
		if Mag <= 0 then 
			if Module["AutoReload"] and Module["AutoReload"] == true then
				Reload()
			end	
		end
	end
end)

-- non firing

GUI.MobileButtons.FireButton.MouseButton1Up:connect(function()
	Down = false
end)

--------------------------------------------------------------------------------------------------

function getRandomSound()
	local handlef = HandleToFire

	if not handlef:FindFirstChild("FireSounds") then
		return handlef:FindFirstChild("FireSound")
	else
		local FireSounds = handlef:FindFirstChild("FireSounds"):GetChildren()
		local SelectedFireSound = FireSounds[math.random(1,#FireSounds)]
		return SelectedFireSound
	end
end

function stopRunning(iflooped)
	local handlef = HandleToFire

	if not handlef:FindFirstChild("FireSounds") then
		if not iflooped then handlef:FindFirstChild("FireSound"):Stop() end
		if iflooped then if handlef:FindFirstChild("FireSound").Looped then handlef:FindFirstChild("FireSound"):Stop() end end
		return
	else
		for i,v in pairs(handlef:FindFirstChild("FireSounds"):GetChildren()) do
			if not iflooped then v:Stop() end
			if iflooped then if v.Looped then v:Stop() end end
		end 
	end
end

Mouse.Button1Down:connect(function()
	if UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then return end
		if jammed then return end
		if not slid then return end
		if not shootEnabled and Equipped or (Character:FindFirstChild('RAGDOLLED')) then return end
		if Mag <= 0 then return tickSound() end
		Down = true
		local IsChargedShot = false
		if Equipped and Enabled and Down and not Reloading and not HoldDown and Mag > 0 and Humanoid.Health > 0 then
			Enabled = false
			if Module.ChargedShotEnabled then
				if HandleToFire:FindFirstChild("ChargeSound") then HandleToFire.ChargeSound:Play() end
				wait(Module.ChargingTime)
				IsChargedShot = true
			end
			if Module.MinigunEnabled then
				if HandleToFire:FindFirstChild("WindUp") then HandleToFire.WindUp:Play() end
				wait(Module.DelayBeforeFiring)
			end
			while Equipped and not Reloading and not HoldDown and (Down or IsChargedShot) and Mag > 0 and Humanoid.Health > 0 and not jammed do
				IsChargedShot = false

				Player.PlayerScripts.BulletVisualizerServerScript.VisualizeM:Fire(HandleToFire,
					Module.MuzzleFlashEnabled,
					{Module.MuzzleLightEnabled,Module.LightBrightness,Module.LightColor,Module.LightRange,Module.LightShadows,Module.VisibleTime},
					script:WaitForChild("MuzzleEffect"))
				VisualizeMuzzle:FireServer(HandleToFire,
					Module.MuzzleFlashEnabled,
					{Module.MuzzleLightEnabled,Module.LightBrightness,Module.LightColor,Module.LightRange,Module.LightShadows,Module.VisibleTime},
					script:WaitForChild("MuzzleEffect"))	

				for i = 1,(Module.BurstFireEnabled and Module.BulletPerBurst or 1) do
					--VVV Edit here VVV--
					self.knockback.t = 1 * Vector3.new(-1, -20 * .005, 0)
					--^^^ Edit here ^^^--
					spawn(RecoilCamera)
					EjectShell(HandleToFire)
					CrosshairModule.crossspring:accelerate(Module.CrossExpansion)

					if Module["PlayAllSounds"] and Module["PlayAllSounds"] == true then

						if HandleToFire:FindFirstChild("FireSounds") then

							for i,v in pairs(HandleToFire:FindFirstChild("FireSounds"):GetChildren()) do
								Player.PlayerScripts.BulletVisualizerServerScript.Play:Fire{
									SoundId = v.SoundId,
									Position = HandleToFire,
									Effects = Module.EchoEffect,
									Volume = v.Volume,
									EmitterSize = v.EmitterSize,
									Pitch = v.PlaybackSpeed,
									Replicate = Module.Replicate
								}
							end
						else
							local sounder = getRandomSound()
							Player.PlayerScripts.BulletVisualizerServerScript.Play:Fire{
								SoundId = sounder.SoundId,
								Position = HandleToFire,
								Effects = Module.EchoEffect,
								Volume = sounder.Volume,
								EmitterSize = sounder.EmitterSize,
								Pitch = sounder.PlaybackSpeed,
								Replicate = Module.Replicate
							}
						end
					else
						local sounder = getRandomSound()
						Player.PlayerScripts.BulletVisualizerServerScript.Play:Fire{
							SoundId = sounder.SoundId,
							Position = HandleToFire,
							Effects = Module.EchoEffect,
							Volume = sounder.Volume,
							EmitterSize = sounder.EmitterSize,
							Pitch = sounder.PlaybackSpeed,
							Replicate = Module.Replicate
						}
					end

					for x = 1,(Module.ShotgunEnabled and Module.BulletPerShot or 1) do
						local Position = Get3DPosition(Mouse)
						if UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
							Fire(HandleToFire, Get3DPosition(GUI.Crosshair.AbsolutePosition))
						else
							Fire(HandleToFire, Position)
						end
					end
					Mag = Mag - 1
					ChangeMagAndAmmo:FireServer(Mag,Ammo)
					UpdateGUI()
					if Module.BurstFireEnabled then wait(Module.BurstRate) end
					if Mag <= 0 or jammed then break end
				end
				HandleToFire = (HandleToFire == Handle and Module.DualEnabled) and Handle2 or Handle
				wait(Module.FireRate)
				if not Module.Auto then break end
			end
			stopRunning(true)
			--if HandleToFire.FireSound.Playing and HandleToFire.FireSound.Looped then HandleToFire.FireSound:Stop() end
			if Module.MinigunEnabled then
				if HandleToFire:FindFirstChild("WindDown") then HandleToFire.WindDown:Play() end
				wait(Module.DelayAfterFiring)
			end
			Enabled = true
			if Mag <= 0 then 
				if Module["AutoReload"] and Module["AutoReload"] == true then
					Reload()
				end	
			end
	end
end)
Mouse.Button1Up:connect(function()
	if not UserInputService.TouchEnabled then
		Down = false
	else
		if UserInputService.GamepadEnabled then
			Down = false
		end
	end
end)

ChangeMagAndAmmo.OnClientEvent:connect(function(ChangedMag,ChangedAmmo)
	Mag = ChangedMag
	Ammo = ChangedAmmo
	UpdateGUI()
end)
Tool.Equipped:connect(function(TempMouse)
	Equipped = true
	delay(Module.EquipTime,function()
		if Equipped then shootEnabled = true else shootEnabled = false end
	end)
	if Module.AmmoPerMag ~= math.huge then GUI.Frame.Visible = true end
	GUI.Parent = Player.PlayerGui
	UpdateGUI()
		if Handle:FindFirstChild('EquippedSound') then PlayServerSound:FireServer(Handle.EquippedSound) end

	if Module.WalkSpeedRedutionEnabled then
		Humanoid.WalkSpeed = Humanoid.WalkSpeed - Module.WalkSpeedRedution
	else
		Humanoid.WalkSpeed = Humanoid.WalkSpeed
	end
	CrosshairModule:setcrosssettings(Module.CrossSize, Module.CrossSpeed, Module.CrossDamper)
	UserInputService.MouseIconEnabled = false
	if not Character.InCar.Value then if EquippedAnim then EquippedAnim:Play(nil,nil,Module.EquippedAnimationSpeed) end end
	if IdleAnim  then IdleAnim:Play(nil,nil,Module.IdleAnimationSpeed) end
	TempMouse.KeyDown:connect(function(Key)
		if string.lower(Key) == "r" then
			Reload()
		elseif string.lower(Key) == "e" then
			if not Reloading and not HoldDown and Module.HoldDownEnabled then
				HoldDown = true
				IdleAnim:Stop()
				if HoldDownAnim then HoldDownAnim:Play(nil,nil,Module.HoldDownAnimationSpeed) end
				if AimDown then 
					TweeningService:Create(Camera, TweenInfo.new(Module.TweenLengthNAD, Module.EasingStyleNAD, Module.EasingDirectionNAD), {FieldOfView = _G.FOV}):Play()
					CrosshairModule:setcrossscale(1)
			        --[[local GUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ZoomGui")
			        if GUI then GUI:Destroy() end]]
					Scoping = false
					game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.Classic
					UserInputService.MouseDeltaSensitivity = InitialSensitivity
					AimDown = false
				end
			else
				HoldDown = false
				IdleAnim:Play(nil,nil,Module.IdleAnimationSpeed)
				if HoldDownAnim then HoldDownAnim:Stop() end
			end
		end
	end)
	Mouse.Button2Down:connect(function()
		if not Reloading and not HoldDown and AimDown == false and Equipped == true and Module.IronsightEnabled and (Camera.Focus.p-Camera.CoordinateFrame.p).magnitude <= 1 then
			TweeningService:Create(Camera, TweenInfo.new(Module.TweenLength, Module.EasingStyle, Module.EasingDirection), {FieldOfView = _G.FOV - 5}):Play()
			CrosshairModule:setcrossscale(Module.CrossScaleIS)
				--[[local GUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ZoomGui") or Tool.ZoomGui:Clone()
				GUI.Parent = game:GetService("Players").LocalPlayer.PlayerGui]]
			--Scoping = false
			game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
			UserInputService.MouseDeltaSensitivity = InitialSensitivity * Module.MouseSensitiveIS
			AimDown = true
		elseif not Reloading and not HoldDown and AimDown == false and Equipped == true and Module.SniperEnabled and (Camera.Focus.p-Camera.CoordinateFrame.p).magnitude <= 1 then
			TweeningService:Create(Camera, TweenInfo.new(Module.TweenLength, Module.EasingStyle, Module.EasingDirection), {FieldOfView = _G.FOV - 30}):Play()
			CrosshairModule:setcrossscale(Module.CrossScaleS)
				--[[local GUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ZoomGui") or Tool.ZoomGui:Clone()
				GUI.Parent = game:GetService("Players").LocalPlayer.PlayerGui]]
			local zoomsound = GUI.Scope.ZoomSound:Clone()
			zoomsound.Parent = Player.PlayerGui
			zoomsound:Play()
			Scoping = true
			game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
			UserInputService.MouseDeltaSensitivity = InitialSensitivity * Module.MouseSensitiveS
			AimDown = true
			game:GetService("Debris"):addItem(zoomsound,zoomsound.TimeLength)
		end
	end)
	Mouse.Button2Up:connect(function()
		if AimDown then
			TweeningService:Create(Camera, TweenInfo.new(Module.TweenLengthNAD, Module.EasingStyleNAD, Module.EasingDirectionNAD), {FieldOfView = _G.FOV}):Play()
			CrosshairModule:setcrossscale(1)
			--[[local GUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ZoomGui")
			if GUI then GUI:Destroy() end]]
			Scoping = false
			game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.Classic
			UserInputService.MouseDeltaSensitivity = InitialSensitivity
			AimDown = false
		end
	end)
	if Module.DualEnabled and not workspace.FilteringEnabled then
		Handle2.CanCollide = false
		local LeftArm = Tool.Parent:FindFirstChild("Left Arm") or Tool.Parent:FindFirstChild("LeftHand")
		local RightArm = Tool.Parent:FindFirstChild("Right Arm") or Tool.Parent:FindFirstChild("RightHand")
		if RightArm then
			local Grip = RightArm:WaitForChild("RightGrip",0.01)
			if Grip then
				Grip2 = Grip:Clone()
				Grip2.Name = "LeftGrip"
				Grip2.Part0 = LeftArm
				Grip2.Part1 = Handle2
				--Grip2.C1 = Grip2.C1:inverse()
				Grip2.Parent = LeftArm
			end
		end
	end
end)
Tool.Unequipped:connect(function()
	shootEnabled = false
	slid = false
	HoldDown = false
	Equipped = false
	GUI.Parent = script
	GUI.Frame.Visible = false
	if Module.WalkSpeedRedutionEnabled then
		Humanoid.WalkSpeed = Humanoid.WalkSpeed + Module.WalkSpeedRedution
	else
		Humanoid.WalkSpeed = Humanoid.WalkSpeed
	end
	UserInputService.MouseIconEnabled = true
	if IdleAnim then IdleAnim:Stop() end
	if HoldDownAnim then HoldDownAnim:Stop() end
	if AimDown then
		TweeningService:Create(Camera, TweenInfo.new(Module.TweenLengthNAD, Module.EasingStyleNAD, Module.EasingDirectionNAD), {FieldOfView = _G.FOV}):Play()
		CrosshairModule:setcrossscale(1)
			--[[local GUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ZoomGui")
			if GUI then GUI:Destroy() end]]
		Scoping = false
		game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.Classic
		UserInputService.MouseDeltaSensitivity = InitialSensitivity
		AimDown = false
	end
	if Module.DualEnabled and not workspace.FilteringEnabled then
		Handle2.CanCollide = true
		if Grip2 then Grip2:Destroy() end
	end
end)

Humanoid.Died:connect(function()
	HoldDown = false
	Equipped = false
	GUI.Parent = script
	GUI.Frame.Visible = false
	Tool.Parent = Player.Backpack
	if Module.WalkSpeedRedutionEnabled then
		Humanoid.WalkSpeed = Humanoid.WalkSpeed + Module.WalkSpeedRedution
	else
		Humanoid.WalkSpeed = Humanoid.WalkSpeed
	end
	UserInputService.MouseIconEnabled = true
	if IdleAnim then IdleAnim:Stop() end
	if HoldDownAnim then HoldDownAnim:Stop() end
	if AimDown then
		TweeningService:Create(Camera, TweenInfo.new(Module.TweenLengthNAD, Module.EasingStyleNAD, Module.EasingDirectionNAD), {FieldOfView = _G.FOV}):Play()
		CrosshairModule:setcrossscale(1)
			--[[local GUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ZoomGui")
			if GUI then GUI:Destroy() end]]
		Scoping = false
		game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.Classic
		UserInputService.MouseDeltaSensitivity = InitialSensitivity
		AimDown = false
	end
	if Module.DualEnabled and not workspace.FilteringEnabled then
		Handle2.CanCollide = true
		if Grip2 then Grip2:Destroy() end
	end
end)

--[[
local lastTick = tick()

game:GetService("RunService"):BindToRenderStep("Mouse", Enum.RenderPriority.Input.Value, function()
	local deltaTime = tick() - lastTick
	lastTick = tick()
	
	if Scoping and UserInputService.MouseEnabled and UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled then --For pc version
		GUI.Scope.Size = UDim2.new(numLerp(GUI.Scope.Size.X.Scale, 1.2, math.min(deltaTime * 5, 1)), 36, numLerp(GUI.Scope.Size.Y.Scale, 1.2, math.min(deltaTime * 5, 1)), 36)
		GUI.Scope.Position = UDim2.new(0, Mouse.X - GUI.Scope.AbsoluteSize.X / 2, 0, Mouse.Y - GUI.Scope.AbsoluteSize.Y / 2)
	elseif Scoping and UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.KeyboardEnabled then --For mobile version, but in first-person view
		GUI.Scope.Size = UDim2.new(numLerp(GUI.Scope.Size.X.Scale, 1.2, math.min(deltaTime * 5, 1)), 36, numLerp(GUI.Scope.Size.Y.Scale, 1.2, math.min(deltaTime * 5, 1)), 36)
	    GUI.Scope.Position = UDim2.new(0, GUI.Crosshair.AbsolutePosition.X - GUI.Scope.AbsoluteSize.X / 2, 0, GUI.Crosshair.AbsolutePosition.Y - GUI.Scope.AbsoluteSize.Y / 2)
	else
		GUI.Scope.Size = UDim2.new(0.6, 36, 0.6, 36)
		GUI.Scope.Position = UDim2.new(0, 0, 0, 0)
	end
	
	GUI.Scope.Visible = Scoping
	
    if UserInputService.MouseEnabled and UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled then --For pc version
	    GUI.Crosshair.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y)    
    elseif UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.KeyboardEnabled and (Character.Head.Position - Camera.CoordinateFrame.p).magnitude > 2 then --For mobile version, but in third-person view
	    GUI.Crosshair.Position = UDim2.new(0.5, -1, 0.45, -19)
    elseif UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.KeyboardEnabled and (Character.Head.Position - Camera.CoordinateFrame.p).magnitude <= 2 then --For mobile version, but in first-person view
	    GUI.Crosshair.Position = UDim2.new(0.5, -1, 0.5, -19)
    end
	
end)
]]

game:GetService("RunService"):BindToRenderStep("Scope", Enum.RenderPriority.First.Value, function(tick)		
	self.knockback.t = self.knockback.t:lerp(Vector3.new(), .2)
end)

game:GetService("RunService"):BindToRenderStep("Mouse", Enum.RenderPriority.Input.Value, function()
	local delta = UserInputService:GetMouseDelta() / Module.ScopeSensitive

	if Scoping and UserInputService.MouseEnabled and UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled then --For pc version
		GUI.Scope.Position = UDim2.new(0, self.scope.p.x + (self.knockback.p.y * 1000), 0, self.scope.p.y + (self.knockback.p.x * 200))
		local offset = GUI.Scope.AbsoluteSize.x * 0.5
		self.scope.t = Vector3.new(Mouse.x - offset - delta.x, Mouse.y - offset - delta.y, 0)
		oldPosition = Vector2.new(Mouse.x, Mouse.y)
	elseif Scoping and UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.KeyboardEnabled then --For mobile version, but in first-person view
		GUI.Scope.Position = UDim2.new(0, self.scope.p.x + (self.knockback.p.y * 1000), 0, self.scope.p.y + (self.knockback.p.x * 200))
		local offset = GUI.Scope.AbsoluteSize.x * 0.5
		self.scope.t = Vector3.new(GUI.Crosshair.AbsolutePosition.X - offset - delta.x, GUI.Crosshair.AbsolutePosition.Y - offset - delta.y, 0)
		oldPosition = Vector2.new(GUI.Crosshair.AbsolutePosition.X, GUI.Crosshair.AbsolutePosition.Y)
	end

	GUI.Scope.Visible = Scoping
	if not Scoping then
		GUI.Crosshair.Main.Visible = true
	else
		GUI.Crosshair.Main.Visible = false
	end

	if UserInputService.MouseEnabled and UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled then --For pc version
		GUI.Crosshair.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y)
	elseif UserInputService.GamepadEnabled and not UserInputService.MouseEnabled and not UserInputService.KeyboardEnabled and (Character.Head.Position - Camera.CoordinateFrame.p).magnitude > 2 then
		GUI.Crosshair.Position = UDim2.new(0.5, -1, 0.45, -19)
	elseif UserInputService.GamepadEnabled and not UserInputService.MouseEnabled and not UserInputService.KeyboardEnabled and (Character.Head.Position - Camera.CoordinateFrame.p).magnitude <= 2 then
		GUI.Crosshair.Position = UDim2.new(0.5, -1, 0.5, -19)
	elseif UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.KeyboardEnabled and (Character.Head.Position - Camera.CoordinateFrame.p).magnitude > 2 then --For mobile version, but in third-person view
		GUI.Crosshair.Position = UDim2.new(0.5, -1, 0.45, -19)
	elseif UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.KeyboardEnabled and (Character.Head.Position - Camera.CoordinateFrame.p).magnitude <= 2 then --For mobile version, but in first-person view
		GUI.Crosshair.Position = UDim2.new(0.5, -1, 0.5, -19)
	end
end)


--[[ 3RD PERSON AIMING MODULE ]]

local UIS = game:FindService('UserInputService')
local aiming = false
task.wait(3) local hrp = Character:WaitForChild("HumanoidRootPart")
local x = 0
local y = 0
local offset = Vector3.new(2, 2, 7)

function AimInA()
	if aiming then return end
	Character.LowerTorso.CFrame = CFrame.new(Character.LowerTorso.Position, Vector3.new(Mouse.Hit.p.X, Character.LowerTorso.Position.Y, Mouse.Hit.p.Z));
	Humanoid.AutoRotate = false
	local camera = workspace.CurrentCamera
	camera.CameraType = Enum.CameraType.Scriptable
	aiming = true
end

function UnAM()
	if not aiming then return end
	Humanoid.AutoRotate = true
	local camera = workspace.CurrentCamera
	camera.CameraType = Enum.CameraType.Custom
	aiming = false
	UIS.MouseBehavior = Enum.MouseBehavior.Default
end

Mouse.Button2Down:Connect(function()
	if Equipped and not aiming and Character:FindFirstChild("Head").LocalTransparencyModifier == 0 then
		----AimIn()
	end	
end)

Mouse.Button2Up:Connect(function()
	if Equipped and aiming then
		UnAM()
	end	
end)

Tool.Unequipped:Connect(function()
	if aiming then UnAM() end
	UIS.MouseBehavior = Enum.MouseBehavior.Default
end)

UIS.InputChanged:Connect(function(input, processed)

	if processed then return end

	if not aiming then return end

	if input.UserInputType == Enum.UserInputType.MouseMovement then
		x = x - input.Delta.X
		y = math.clamp(y - input.Delta.Y*0.4, -75, 75)
		hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(-input.Delta.X), 0)
	end
end)

game:GetService("RunService").RenderStepped:connect(function() task.wait(60)
	if aiming and Humanoid.Health ~= 0 and not recoiling then
		local camera = workspace.CurrentCamera

		UIS.MouseBehavior = Enum.MouseBehavior.LockCenter

		local startCFrame = CFrame.new((hrp.CFrame.Position)) * CFrame.Angles(0, math.rad(x), 0) * CFrame.Angles(math.rad(y), 0, 0)
		local cameraCFrame = startCFrame:ToWorldSpace(CFrame.new(offset.X, offset.Y, offset.Z))
		local cameraDirection = startCFrame:ToWorldSpace(CFrame.new(offset.X, offset.Y, -10000))

		camera.CoordinateFrame = CFrame.new(cameraCFrame.Position, cameraDirection.Position)
	end	
end)