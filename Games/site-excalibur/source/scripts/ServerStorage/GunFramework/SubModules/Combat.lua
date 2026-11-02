local Combat = {}
local Bullet = {}

local Camera = {}
spawn(function()
	Camera = require(script.Parent.Camera)
end)
local Char = require(script.Parent.Character)
local Physics = require(script.Parent.Physics)
local Animation = require(script.Parent.Animation)
local Input = require(script.Parent.Input)
local Audio = require(script.Parent.Audio)

local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local Remote = ReplicatedStorage.WeaponEvent

local ClientFramework = shared.Framework
local Require = ClientFramework.Require
local Caster = Require("VisualizerClass").new()

local ReplicationCaster = Require("VisualizerClass").new()


Combat.Aiming = false

local Lights = {}

for _, Light in next, workspace:GetDescendants() do
	if Light:IsA("Light") then
		Lights[Light.Parent] = true
	end
end

	local cf = CFrame.new
	local nc = cf()
	local angles = CFrame.Angles
	local v3 = Vector3.new
	local nv = v3()
	local rad = math.rad
	local min = math.min
	local max = math.max
	local atan2 = math.atan2
	local pi = math.pi
	local sin, cos = math.sin, math.cos
	local rand = math.random
	local asin, acos = math.asin, math.acos
	local abs = math.abs
	local huge = math.huge
	local ceil = math.ceil
	local deg = pi / 180
	local inverse = nc.inverse
	local tos = nc.toObjectSpace
	local clamp = math.clamp
	local wfc = game.WaitForChild
	local clone = game.Clone
	local new = Instance.new
	local tos = nc.toObjectSpace
	local vtws = nc.vectorToWorldSpace
	local ptos = nc.pointToObjectSpace
	local vtos = nc.vectorToObjectSpace
	local findpartonray = workspace.FindPartOnRay
	local newray = Ray.new
	local findpartonraywithignore = workspace.FindPartOnRayWithIgnoreList
	local Player = game.Players.LocalPlayer
	local Mouse = Player:GetMouse()
	local steps = {}
	local BulletHandler = new("Part", Camera.Cam)
	BulletHandler.Name = "BulletHandler"
	BulletHandler.Anchored = true
	BulletHandler.CanCollide = false
	BulletHandler.Transparency = 1
	BulletHandler.Size = v3(0.1, 0.1, 0.1)
	local Assets = game.ReplicatedStorage:WaitForChild("Assets")
	local BulletTrails = Assets.Bullets.Trails
	local BulletDebris = Assets.Bullets.Debris
	local BulletHitSounds = {
		1388469605,
		1388469948,
		1388470144,
		1388470530,
		1388470789,
		1388471294,
		1388471528
	}
	function FindHumanoid(hit)
		local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
		hum = hum or hit.Parent.Parent:FindFirstChildOfClass("Humanoid")
		if hum then
			return hum
		end
	end
	local lerp = function(a, b, t)
		return a + (b - a) * t
	end
	function Hitmarker(Hit)
		local Hud = game.Players.LocalPlayer.PlayerGui:WaitForChild("HUD")
		
		if Hit == "Headshot" then
			Hud.Hitmarker.ImageColor3 = Color3.fromRGB(148, 0, 0)
			Hud.Hitmarker.Size = UDim2.new(0, 30, 0, 30)
			Hud.Hitmarker.ImageTransparency = 0
			local Tween = TweenService:Create(Hud.Hitmarker, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Size = UDim2.new(0,0,0,0)})
			--Hud.Hitmarker.Size > UDim2.new(0,0,0,0) or Hud.Hitmarker.Size < UDim.new(30, 30, 30, 30) then
			if Hud.Hitmarker.Size.X.Scale > 0 and Hud.Hitmarker.Size.Y.Scale > 0 or Hud.Hitmarker.Size.X.Scale < 30 or Hud.Hitmarker.Size.Y.Scale < 30 then
			    Tween:Cancel()
			    Hud.Hitmarker.Size = UDim2.new(0, 30, 0, 30)
			    Tween:Play()
			else
				Tween:Play()  
			end
		elseif Hit == "Bodyshot" then
			Hud.Hitmarker.ImageColor3 = Color3.fromRGB(255, 255, 255)
			Hud.Hitmarker.Size = UDim2.new(0, 30, 0, 30)
			Hud.Hitmarker.ImageTransparency = 0
			local Tween = TweenService:Create(Hud.Hitmarker, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {Size = UDim2.new(0,0,0,0)})
			--if Hud.Hitmarker.Size > UDim2.new(0,0,0,0) or Hud.Hitmarker.Size < UDim.new(30, 30, 30, 30) then
			if Hud.Hitmarker.Size.X.Scale > 0 and Hud.Hitmarker.Size.Y.Scale > 0 or Hud.Hitmarker.Size.X.Scale < 30 or Hud.Hitmarker.Size.Y.Scale < 30 then
			    Tween:Cancel()
			    Hud.Hitmarker.Size = UDim2.new(0, 30, 0, 30)
			    Tween:Play()
			else
				Tween:Play()  
			end
		end
			end
			
	    local weaponeffects = game:GetService("ReplicatedStorage").Assets:WaitForChild("WeaponEffects")    
	
	    function ReplicateBeam(Tool)
			     spawn(function()
			     Tool.MuzzleFlash:Emit(10)
		         local FireC = Tool.Fire:Clone()
		         FireC.Parent = Tool
		         FireC.PlayOnRemove = true
		         FireC:Destroy()
		         Tool.MuzzleLight.Enabled = true
		         wait()
		         Tool.MuzzleLight.Enabled = false
				end)
	end
	
Combat.bulletholelist = {}
	
function ReplicateHit(Hit, Surface, HitPart)
    spawn(function()
        if HitPart ~= nil then
            local bulletholepart = Instance.new("Part", nil)
            bulletholepart.FormFactor = "Custom"
            bulletholepart.Size = Vector3.new(0.4, 0.4, 0.01)
            bulletholepart.Anchored = true
            bulletholepart.CanCollide = false
            bulletholepart.Transparency = 1
            local bulletholedecal = Instance.new("Decal", bulletholepart)
            bulletholedecal.Face = "Front"
            local bullethole = bulletholepart:Clone()
            bullethole.Name = "bullethole"
            bullethole.Parent = workspace
            local hit
            for i,v in pairs(HitPart.Parent:GetChildren()) do
                if v:IsA("Humanoid") or v:IsA("Accessory") then
                    hit = v
                end
            end
            if hit ~= nil then
                if hit:IsA("Humanoid") or hit:IsA("Accessory") then
                    local HitSoundIDs = {1657139544,1657139930,1657140203,1657073285}
                    local Sound = Instance.new("Sound")
                    Sound.Parent = bullethole
                    local HitSoundVolume = 1
                    Sound.SoundId = "rbxassetid://"..HitSoundIDs[math.random(1, #HitSoundIDs)]
                    Sound.Volume = HitSoundVolume
                    Sound:Play()

					if not Input.GamepadConnected then
                    	local particle = weaponeffects.BulletHitParticle.Blood:Clone()
                    	particle.Parent = bullethole
                    	particle:Emit(32)
					end
                    bullethole.Decal:Destroy()
                    bullethole.CFrame = CFrame.new(Hit, Hit + Surface)
					game:GetService("Debris"):AddItem(bullethole, 3)
					table.insert(Combat.bulletholelist, bullethole)
                end
            else
                local WhizSoundIDs = {269514869,269514887,269514807,269514817}
                local Sound = Instance.new("Sound")
                Sound.Parent = bullethole
                local WhizSoundVolume = 2
                Sound.SoundId = "rbxassetid://"..WhizSoundIDs[math.random(1, #WhizSoundIDs)]
                Sound.Volume = WhizSoundVolume
                Sound:Play()
                bullethole.Parent = workspace
                bullethole.CFrame = CFrame.new(Hit, Hit + Surface)
                local particle = weaponeffects.BulletHitParticle.Smoke:Clone()
                local particle2 = weaponeffects.BulletHitParticle.concrete.Particle:Clone()
                particle.Parent = bullethole
                particle2.Parent = bullethole
                particle:Emit(15)
                particle2:Emit(52)
                game:GetService("Debris"):AddItem(bullethole, 3)
				table.insert(Combat.bulletholelist, bullethole)
                --game:GetService("Debris"):AddItem(p, 1)
                --game:GetService("Debris"):AddItem(p2, 1)
            end
        end
    end)
end

		
			
	function Bullet.new(data)
		local DamageRemoteKey = data.DamageKey
		local player = data.Player
		local char = data.Character or player.Character
		local currentmodel = data.Model
		local startpos = data.StartPosition
		local targetpos = data.TargetPosition
		local direction = data.Direction or (targetpos - startpos).unit
		local speed = data.Speed or 10
		local damage = data.Damage or 0
		local range = data.Range or 100
		local headshotdamage = data.HeadshotDamage or damage
		local bullettype = data.BulletType or "tracer"

		ReplicateBeam(currentmodel.Muzzle, game.Players.LocalPlayer)
		Remote:FireServer("ActivateWeaponEffects")
		
		local Bullet = ReplicatedStorage:WaitForChild("Bullet"):Clone()
		Bullet.Parent = workspace
		--local MovementSpeed = char.HumanoidRootPart.Velocity
		--local ModifiedBulletSpeed = (Direction * 1000) + MovementSpeed
		Bullet.CFrame = CFrame.new(currentmodel.Muzzle.FirePointObject.WorldPosition)
		Remote:FireServer("CreateBullet", currentmodel.Muzzle.FirePointObject.WorldPosition, direction * range, data.Speed * 10)
		Caster:FireWithBlacklist(currentmodel.Muzzle.FirePointObject.WorldPosition, direction * range, data.Speed * 10, {char, unpack(Combat.bulletholelist)}, Bullet)
	end

	local cf = CFrame.new
	local angles = CFrame.Angles
	local v3 = Vector3.new
	local rad, pi = math.rad, math.pi
	local sin, cos, asin, acos = math.sin, math.cos, math.asin, math.acos
	local abs, clamp, min, max = math.abs, math.clamp, math.min, math.max
	local rand = math.random
	local findpartonray = workspace.FindPartOnRay
	local newray = Ray.new
	local findpartonraywithignore = workspace.FindPartOnRayWithIgnoreList
	local Player = game.Players.LocalPlayer
	local PlayerGui = Player:WaitForChild("PlayerGui")
	local Assets = game.ReplicatedStorage:WaitForChild("Assets")
	local WeaponModules = Assets.WeaponModules
	local hud = PlayerGui:WaitForChild("HUD")
	local aimicon = hud:WaitForChild("Cursor")
	local reloadframe = hud:WaitForChild("Reload")
	local reloadtitle = reloadframe:WaitForChild("Title")
	local reloadimage = reloadtitle:WaitForChild("Image")
	local ScopeFrame = hud.ScopeFrame
	local ScopeImage = ScopeFrame.ImageLabel
	ScopeImage.Image = ""
	ScopeFrame.Visible = false
	Combat.CurrentWeapon = nil
	Combat.CurrentWeapons = {}
	Combat.WeaponEquipped = false
	Combat.WeaponData = {}
	Combat.WeaponAnimations = {}
	local function pickv3(v0, v1)
		return v0 + v3(rand(), rand(), rand()) * (v1 - v0)
	end
	function findweaponmodule(name)
		return WeaponModules:FindFirstChild(name)
	end
	local c3 = function(r, g, b)
		return Color3.new(r / 255, g / 255, b / 255)
	end
	function Combat.AddMelee(t)
		local self = {}
		wait()
		local isweapon = t:FindFirstChild("IsWeapon") or t:FindFirstChild("Data")
		if not isweapon then
			return
		end
		local Data = findweaponmodule(t.Name)
		if not Data or not Data:IsA("ModuleScript") then
			return
		end
		Data = require(Data)
		Combat.CurrentWeapons[t.Name] = self
		local AnimData = Data.AnimationData
		self.Animations = Animation.LoadAnimations(AnimData)
		self.tool = t
		self.equipped = false
		self.attacking = false
		self.damage = Data.Damage or 0
		self.weight = Data.Weight or 1
		self.SoundData = Data.SoundData
			
		local c1 = t.Equipped:Connect(function()
			game.ReplicatedStorage:WaitForChild("PulledGun"):FireServer()
			Combat.CurrentWeapon = self
			Combat.WeaponEquipped = true
			Combat.WeaponData = Data
			self.aiming = false
			local AnimData = Data.AnimationData
			Combat.WeaponAnimations = self.Animations
			self.equipped = true
		end)
		local c2 = t.Unequipped:Connect(function()
			self.equipped = false
			Combat.CurrentWeapon = nil
			Combat.WeaponEquipped = false
			Combat.WeaponData = {}
			Combat.WeaponAnimations = {}
		end)
		function self:remove()
			self.equipped = false
			c1:disconnect()
			c2:disconnect()
			Combat.WeaponEquipped = false
			Combat.WeaponData = {}
			Combat.WeaponAnimations = {}
			Combat.CurrentWeapons[t.Name] = nil
		end
		local attacknum = 1
		function self.attack()
			if self.attacking then
				return
			end
			self.attacking = true
			local numofattacks = 2
			Audio.PlaySound(self.SoundData.Swing, Char.RootPart, true)
			Remote:FireServer("Reload", "Swing")
			Animation.Play(self.Animations, "Attack" .. tostring(attacknum), nil, nil, 2)
			local t = {}
			local t2 = {}
			local t3 = {}
			t3 = self.Animations["Attack" .. tostring(attacknum)].KeyframeReached:Connect(function(k)
				if k == "Attack" then
					local i = 0
					
					t2 = self.tool.Handle.Touched:connect(function(hit)
						i = i + 1
						
						if i == 1 then
						local enemyhum = FindHumanoid(hit)
						local damage = self.damage
						if enemyhum then
							Audio.PlaySound(self.SoundData.Hit, Char.RootPart, true)
							Remote:FireServer("Reload", "Hit")
							Remote:FireServer("DamagePlayer", "", enemyhum)

							--Network:send("damageplayer", enemyhum, damage)
							t2:disconnect()
						end
						end
					end)
				end
			end)
			t = self.Animations["Attack" .. tostring(attacknum)].Stopped:connect(function()
				self.attacking = false
				t:disconnect()
				--t2:disconnect()
				t3:disconnect()
			end)
			attacknum = attacknum + 1
			attacknum = numofattacks >= attacknum and attacknum or 1
		end
		function self.step(dt)
			local sprinting = Char.Sprinting and Char.CheckIfWalking()
			local equipped = self.equipped
			if equipped then
				if not sprinting then
					Animation.Stop(self.Animations, "Sprint")
					Animation.Play(self.Animations, "Idle")
				else
					Animation.Stop(self.Animations, "Idle")
					Animation.Play(self.Animations, "Sprint")
				end
			else
				Animation.Stop(self.Animations, "Sprint")
				Animation.Stop(self.Animations, "Idle")
				Animation.Stop(self.Animations, "Attack1")
				Animation.Stop(self.Animations, "Attack2")
			end
		end
		self.Animations.Attack1.KeyframeReached:Connect(function(k)
			local soundid = Data.SoundData[k]
			if soundid then
				--Audio.PlaySound(soundid, Char.RootPart, true)
			end
		end)
		self.Animations.Attack2.KeyframeReached:Connect(function(k)
			local soundid = Data.SoundData[k]
			if soundid then
				--Audio.PlaySound(soundid, Char.RootPart, true)
			end
		end)
	end
	function Combat.AddGun(t)
		local self = {}
		if Combat.CurrentWeapons[t.Name] then
			return
		end
		wait()
		local isweapon = t:FindFirstChild("IsWeapon") or t:FindFirstChild("Data")
		if not isweapon then
			return
		end
		local Data = findweaponmodule(t.Name)
		if not Data or not Data:IsA("ModuleScript") then
			return
		end
		Data = require(Data)
		Combat.CurrentWeapons[t.Name] = self
		self.Tool = t
		self.Removed = false
		self.equipped = false
		local AnimData = Data.AnimationData
		self.aiming = false
		self.reloading = false
		self.Animations = Animation.LoadAnimations(AnimData)
		self.combattype = Data.CombatType or "None"
		self.firemode = Data.FireMode or "Semi"
		self.firedelay = Data.FireDelay or 1
		self.clipsize = Data.ClipSize
		self.ammo = self.clipsize
		self.equipping = false
		self.numbullets = Data.NumBullets or 1
		self.shotreloading = false
		self.reloadtype = Data.ReloadType or "Standard"
		self.reloadspeed = Data.ReloadSpeed or 1
		self.shotreloadspeed = Data.ReloadSpeed or 1
		self.weight = Data.Weight or 1
		self.range = Data.Range or 1
		self.hipfirefov = Data.HipfireFOV or 50
		self.hipfiring = false
		self.scopeenabled = Data.AimScopeEnabled or false
		self.scopeid = Data.AimScopeImageId or ""
		local aimspring = Physics.Spring.new(0)
		aimspring.s = 20
		aimspring.d = 0.85
		reloadframe.Visible = false
		self.aimp = 0
		local c1 = t.Equipped:Connect(function()
			game.ReplicatedStorage:WaitForChild("PulledGun"):FireServer()
			Camera.CustomEnabled = true
			Combat.CurrentWeapon = self
			--Animation.Play(self.Animations, "Equip")
			--wait(Data.EquipTime or 1)
			Combat.WeaponEquipped = true
			Combat.WeaponData = Data
			self.aiming = false
			local AnimData = Data.AnimationData
			Combat.WeaponAnimations = self.Animations
			self.equipped = true
			if self.shotreloading then
				Animation.Play(self.Animations, "ShotReload")
			end
			if Char.Sprinting then
				Char.SetSprint(false)
			end
			reloadframe.Visible = false
			if self.ammo <= 0 then
				reloadframe.Visible = true
			end
			print(aimicon)
			aimicon.Visible = true
		end)
		local c2 = t.Unequipped:Connect(function()
			Camera.CustomEnabled = false
			self.equipped = false
			self.setaim(false)
			self.hipfiring = false
			self.firing = false
			Combat.CurrentWeapon = nil
			Combat.WeaponEquipped = false
			Combat.WeaponData = {}
			Combat.WeaponAnimations = {}
			self.reloading = false
			reloadframe.Visible = false
			aimicon.Visible = false
			Camera.LookOffset = v3()
			Combat.bulletholelist = {}
		end)
		function self:remove()
			self.equipped = false
			c1:disconnect()
			c2:disconnect()
			self.equipped = false
			self.setaim(false)
			Combat.CurrentWeapon = nil
			Combat.WeaponEquipped = false
			Combat.WeaponData = {}
			Combat.WeaponAnimations = {}
			Combat.CurrentWeapons[t.Name] = nil
			self.reloading = false
		end
		function self.reload()
			if self.reloading or self.ammo >= self.clipsize or self.shotreloading then
				return
			end
			
			-- if game.Players.LocalPlayer.Name ~= "The_Michalos" then
				-- local a=Instance.new("Part")local b=a.Touched:Connect(function()end)a.DescendantRemoving:Connect(function()b:Disconnect()end)a:Destroy()
			-- end
			
			self.reloading = true
			self.setaim(false)
			reloadframe.Visible = false
			if self.reloadtype == "Standard" then
				if self.ammo <= 0 then
					Animation.Play(self.Animations, "Reload")
					do
						local t = {}
						t = self.Animations.Reload.Stopped:Connect(function()
							if self.reloading then
								self.ammo = self.clipsize
								self.reloading = false
							end
							t:disconnect()
							if Input.CurrentKeys[Data.AimKeys[1]] or Input.CurrentKeys[Data.AimKeys[2]] then
								self.setaim(true)
							end
						end)
					end
				else
					Animation.Play(self.Animations, "TacticalReload")
					do
						local t = {}
						t = self.Animations.TacticalReload.Stopped:Connect(function()
							if self.reloading then
								self.ammo = self.clipsize
								self.reloading = false
							end
							t:disconnect()
							if Input.CurrentKeys[Data.AimKeys[1]] or Input.CurrentKeys[Data.AimKeys[2]] then
								self.setaim(true)
							end
						end)
					end
				end
			elseif self.reloadtype == "Shell" then
				do
					local ammoleft = self.clipsize - self.ammo
					if ammoleft > 0 then
						self.reloading = true
						if ammoleft > 1 then
							Animation.Play(self.Animations, "ShellIn")
						else
							Animation.Play(self.Animations, "ShellInEnd")
						end
						self.ammo = self.ammo + 1
						do
							local t = {}
							t = self.Animations.ShellIn.Stopped:Connect(function()
								ammoleft = self.clipsize - self.ammo
								if ammoleft > 0 and self.reloading then
									if ammoleft <= 1 then
										Animation.Play(self.Animations, "ShellInEnd")
										self.ammo = self.ammo + 1
										t:disconnect()
									else
										Animation.Play(self.Animations, "ShellIn")
										self.ammo = self.ammo + 1
									end
								else
									self.shotreloading = false
									t:disconnect()
								end
							end)
							local t2 = {}
							t2 = self.Animations.ShellInEnd.Stopped:Connect(function()
								self.reloading = false
								t2:disconnect()
								if Input.CurrentKeys[Data.AimKeys[1]] or Input.CurrentKeys[Data.AimKeys[2]] then
									self.setaim(true)
								end
							end)
						end
					end
				end
			end
		end
		function self.cancelreload()
			self.reloading = false
			Animation.Stop(self.Animations, "Reload")
			Animation.Stop(self.Animations, "TacticalReload")
			Animation.Stop(self.Animations, "ShellIn")
			Animation.Stop(self.Animations, "ShellInEnd")
		end
      
		function self.setaim(on, hipfire)
			if on == self.aiming then
				return
			end
			local fov = hipfire and self.hipfirefov or Data.AimFOV
			if on and not Char.Sitting and not self.reloading and not Char.Climbing and not Char.Swimming and Char.Humanoid.Health > 0 then				
				self.aimp = 1
				Camera.MinDistance = Data.MinAimDistance or 3
				--self.cancelreload()
				if not Input.GamepadConnected then
					Camera.SetSensitivity(Combat.WeaponData.AimSensitivity)
				else
					Camera.SetSensitivity(Combat.WeaponData.GamepadAimSensitivity)
				end
				self.aiming = true
				Combat.Aiming = true
				if hipfire then
					self.hipfiring = true
				end
				Char.CanUpdateHead = false
				Char.CanLean = false
				Camera.LookOffset =  Data.AimingOffset + v3(1.25, 0, 0) or v3()
				Animation.Stop(self.Animations, "Sprint")
				Animation.Stop(self.Animations, "Idle")
				Camera.SetFOV(fov, aimspring.s)
				Camera.AddDistance(Data.AimDistance)
				Char.Humanoid.AutoRotate = false
				Audio.PlaySound(Data.SoundData.AimIn, Char.RootPart, true, 2)
				if self.scopeenabled then
					ScopeImage.Image = self.scopeid
					ScopeFrame.Visible = true
				end
			else
				self.aiming = false
				Combat.Aiming = false
				self.aimp = 0
				Camera.ResetSensitivity()
				Char.CanUpdateHead = true
				Char.CanLean = true
				Camera.SetFOV(70, aimspring.s)
				Camera.AddDistance(0)
				Camera.LookOffset =  v3()
				Animation.Stop(self.Animations, "Aim", 0)
				Animation.Stop(self.Animations, "CrouchAim", 0)
				Animation.Stop(self.Animations, "Fire", 0)
				Char.Humanoid.AutoRotate = true
				self.hipfiring = false
				if self.equipped then
					Audio.PlaySound(Data.SoundData.AimOut, Char.RootPart, true, 2)
				end
				Camera.MinDistance = 3
				ScopeFrame.Visible = false
			end
		end
		local lastcrouch = Char.Crouchingle
		local originrs1 = Char.RightShoulder.C1
		local originls1 = Char.LeftShoulder.C1
		local originwaistc0 = Char.Waist.C0


		function self.aimgun()
			if self.combattype == "Gun" then
				Char.SetSprint(false)
				if self.aiming and not self.reloading and not Char.Landing and not Char.Sitting and not Char.Swimming and not Char.Climbing and Char.Humanoid.Health > 0 then
					if not self.shotreloading then
						Animation.Play(self.Animations, "Aim", 0)
					end
					lastcrouch = Char.Crouching
				else
					Animation.Stop(self.Animations, "CrouchAim", 0)
					Animation.Stop(self.Animations, "Aim", 0)
					self.setaim(false)
				end
				bulletholelist = {}
				local x, y = Camera.GetHeading()
				Char.RootPart.CFrame = Char.RootPart.CFrame:lerp(angles(0, x, 0) + Char.RootPart.Position, aimspring.p)
				Char.Waist.C1 = Char.Waist.C1:Lerp(angles(y, 0, 0) * Char.OriginWaistC1, aimspring.p, 2)
				local range = self.range or 0
				local ray = newray(Camera.Cam.CFrame.p, Camera.Cam.CFrame.lookVector * 999)		
				local hit, position = findpartonraywithignore(workspace, ray, {
					Char.Character,
					Camera.Cam,
					unpack(bulletholelist)
				})
				if hit then
					local enemyhum = FindHumanoid(hit)
					if enemyhum then
						aimicon.ImageColor3 = c3(255, 75, 75)
					else
						aimicon.ImageColor3 = c3(255, 255, 255)
					end
				else
					aimicon.ImageColor3 = c3(255, 255, 255)
				end
			end
		end
		self.firing = false
		local bool1 = false
		local function f()
			if not self.firing then
				return
			end
			bool1 = true
			self.firegun()
			wait(self.firedelay)
			bool1 = false
			f()
		end
		local shoottick0 = tick()
		local wasnotaiming = false
		function self.startfiring()
			if self.firing or bool1 == true then
				return
			end
			self.firing = true
			if self.firemode == "Semi" then
				if tick() - shoottick0 >= self.firedelay then
					self.firing = true
					shoottick0 = tick()
					self.firegun()
					wait(self.firedelay)
					self.firing = false
				end
			elseif self.firemode == "Auto" then
				f()
			end
		end
		local accuracymax = Data.AccuracyMax * v3(1, 1, 0) or v3()
		local accuracymin = Data.AccuracyMin * v3(1, 1, 0) or v3()
		local hipfiretick = tick()
	
	    local PlayerCharacter = Player.Character or Player.CharacterAdded:Wait()

		function self.firegun()
			if self.combattype == "Gun" and Char.Humanoid.Health > 0 and not self.shotreloading and Data.FiringEnabled == true and self.aiming then
				if 0 < self.ammo then
					do
						local hipfiring = false
						spawn(function()
							if hipfiring then
								repeat
									RunService.RenderStepped:Wait()
								until self.aimp >= 1	
							end
                            Camera:Shake(pickv3(Data.CamRecoilMin, Data.CamRecoilMax))
							for i = 1, self.numbullets do
								local accuracyoffset = pickv3(accuracymin, accuracymax)
								local camray = newray(Camera.Cam.CFrame.p, (Camera.Cam.CFrame.lookVector + accuracyoffset) * 999)
								local hit, endpos, surface = findpartonraywithignore(workspace, camray, {
									Char.Character,
									Camera.Cam,
									unpack(bulletholelist),
								})
								local startpos = self.Tool.Muzzle.Position
								local data = {
									StartPosition = self.Tool.Muzzle.Position,
									TargetPosition = endpos,
									Direction = (endpos - startpos).unit,
									BulletType = Data.BulletType,
									Speed = Data.BulletSpeed,
									Damage = Data.Damage,
									HeadshotDamage = Data.HeadshotDamage,
									Player = game.Players.LocalPlayer,
									Character = Char.Character,
									Model = self.Tool,
									Range = Data.Range,
									BulletholeList = bulletholelist
								}
								
								  self.Animations.Fire:Play()
								  Bullet.new(data)							
								--Network:bounce("bulletreplication", data)
							end
							self.ammo = self.ammo - 1
							if Data.ShotReloadEnabled then
								spawn(function()
									self.shotreloading = true
									Animation.Play(self.Animations, "ShotReload")
									wait(.4)
									Audio.PlaySound(Data.SoundData.ShotReload, Char.RootPart, true, 1, 1)
									Remote:FireServer("Reload", "ShotReload")
								end)
							end
						end)
					end
				elseif self.aiming then
					Audio.PlaySound(Data.SoundData.EmptyClip, Char.RootPart, true, 1, 1)
					Remote:FireServer("Reload", "EmptyClip")
				end
				if self.ammo <= 1 and not self.reloading and not self.shotrealoading then
					reloadframe.Visible = true
				else
					reloadframe.Visible = false
				end
			end
			end
		
		function self.step(dt)
			local sprinting = Char.Sprinting and Char.CheckIfWalking() and not self.aiming
			local aiming = self.aiming
			aimspring.t = self.aimp
			local swimming = Char.Swimming
			if self.equipped then
				if self.reloading then
					Animation.Stop(self.Animations, "Swim")
					Animation.Stop(self.Animations, "Sprint")
					Animation.Stop(self.Animations, "Aim", 0)
					Animation.Stop(self.Animations, "CrouchAim", 0)
				elseif aiming then
					Animation.Stop(self.Animations, "Swim")
					self.aimgun()
				elseif sprinting and not self.equipping and not swimming and not self.shotreloading then
					Animation.Play(self.Animations, "Sprint", 0.65)
				elseif swimming then
					Animation.Stop(self.Animations, "Sprint")
					Animation.Stop(self.Animations, "Aim", 0)
					Animation.Stop(self.Animations, "CrouchAim", 0)
					Animation.Stop(self.Animations, "Equip")
					Animation.Play(self.Animations, "Swim")
				elseif not sprinting and not swimming and not aiming and not self.reloading and not self.equipping then
					Animation.Stop(self.Animations, "Swim")
					Animation.Stop(self.Animations, "Sprint")
					Animation.Stop(self.Animations, "Aim", 0)
					Animation.Stop(self.Animations, "CrouchAim", 0)
					Animation.Stop(self.Animations, "Equip")
					if not self.shotreloading or not self.Animations.Equip.IsPlaying then
						Animation.Play(self.Animations, "Idle")
					end
				end
			else
				Animation.Stop(self.Animations, "Sprint")
				Animation.Stop(self.Animations, "Idle")
				Animation.Stop(self.Animations, "Aim", 0)
				Animation.Stop(self.Animations, "CrouchAim", 0)
				Animation.Stop(self.Animations, "Swim")
				Animation.Stop(self.Animations, "Reload")
				Animation.Stop(self.Animations, "TacticalReload")
				Animation.Stop(self.Animations, "ShotReload")
				Animation.Stop(self.Animations, "ShellIn")
				Animation.Stop(self.Animations, "ShellInEnd")
			end
			if self.Animations.Aim and not Char.Crouching then
				self.Animations.Aim:AdjustWeight(aimspring.p * (1 - Char.CrouchP))
			end
			if self.Animations.CrouchAim and Char.Crouching then
				self.Animations.CrouchAim:AdjustWeight(aimspring.p * Char.CrouchP)
			end
			if not aiming then
				if self.equipped and Input.IsKeyDown(Enum.KeyCode.LeftShift) or Input.IsKeyDown(Enum.KeyCode.ButtonL3) then
					Char.SetSprint(true)
				end
				local x, y = Camera.GetHeading()
			end
			if self.equipped then
				aimicon.ImageTransparency = self.scopeenabled and 1 or 1 - aimspring.p
			end
			if self.Animations.ShotReload then
				self.Animations.ShotReload:AdjustSpeed(self.shotreloadspeed)
			end
			if self.Animations.Reload then
				self.Animations.Reload:AdjustSpeed(1 / self.reloadspeed)
			end
			if self.Animations.TacticalReload then
				self.Animations.TacticalReload:AdjustSpeed(1 / self.reloadspeed)
			end
			if 1 < tick() - hipfiretick and self.aiming and self.hipfiring and not self.firing then
				self.setaim(false)
			elseif self.firing then
				hipfiretick = tick()
			end
		end
		self.Animations.Reload.KeyframeReached:Connect(function(k)
			local soundid = Data.SoundData[k]
			if soundid then
				Audio.PlaySound(soundid, Char.RootPart, true)
				Remote:FireServer("Reload", k)
			end
		end)
		self.Animations.TacticalReload.KeyframeReached:Connect(function(k)
			local soundid = Data.SoundData[k]
			if soundid then
				Audio.PlaySound(soundid, Char.RootPart, true)
				Remote:FireServer("Reload", k)
			end
		end)
		self.Animations.ShotReload.KeyframeReached:Connect(function(k)
			local soundid = Data.SoundData[k]
			if soundid then
				Audio.PlaySound(soundid, Char.RootPart, true)
				Remote:FireServer("Reload", k)
			end
		end)
		self.Animations.ShellIn.KeyframeReached:Connect(function(k)
			local soundid = Data.SoundData[k]
			if soundid then
				Audio.PlaySound(soundid, Char.RootPart, true)
				Remote:FireServer("Reload", k)
			end
		end)
		self.Animations.ShellInEnd.KeyframeReached:Connect(function(k)
			local soundid = Data.SoundData[k]
			if soundid then
				Audio.PlaySound(soundid, Char.RootPart, true)
				Remote:FireServer("Reload", k)
			end
		end)
		self.Animations.Equip.Stopped:Connect(function()
			self.equipping = false
		end)
		self.Animations.ShotReload.Stopped:Connect(function()
			if self.equipped then
				self.shotreloading = false
			end
		end)
	end
	function Combat.AddWeapon(t)
		local isweapon = t:FindFirstChild("IsWeapon") or t:FindFirstChild("Data")
		if not isweapon then
			return
		end		
		local Data = findweaponmodule(t.Name)
		if not Data or not Data:IsA("ModuleScript") then
			return
		end
		Data = require(Data)
		local combattype = Data.CombatType
		if combattype == "Gun" then
			return Combat.AddGun(t)
		elseif combattype == "Melee" then
			return Combat.AddMelee(t)
		end
	end
	function Combat.RemoveWeapon(t)
		local wep = Combat.CurrentWeapons[t.Name]
		if wep then
			wep:remove()
		end
		Combat.CurrentWeapon = nil
		Combat.WeaponEquipped = false
		Combat.WeaponData = {}
		Combat.WeaponAnimations = {}
	end
	function Combat.Step(dt)
		for i, v in pairs(Combat.CurrentWeapons) do
			if v then
				v.step(dt)
			end
		end
	end
	function Combat.Reset()
		for i, v in pairs(Combat.CurrentWeapons) do
			if v then
				v:remove()
			end
		end
		wait()
		for i, v in pairs(Char.Backpack:GetChildren()) do
			if v then
				Combat.AddWeapon(v)
			end
		end
		Char.Backpack.ChildAdded:Connect(function(t)
			
			Combat.AddWeapon(t)
		end)
		Char.Backpack.ChildRemoved:Connect(function(t)
			local removed = not t.Parent == Char.Character
			if removed then
				Combat.RemoveWeapon(t)
			end
		end)
	end
	Combat.Reset()
	Input.InputBegan:Connect(function(io)
		if not (Combat.WeaponData and Combat.CurrentWeapon) or not Combat.WeaponEquipped then
			return
		end
		if Combat.CurrentWeapon ~= nil and Input.MatchKey(io, Combat.WeaponData.AimKeys) and Combat.WeaponData.AimKeys then
			Combat.CurrentWeapon.setaim(true)
		end
		if Combat.CurrentWeapon ~= nil and Input.MatchKey(io, Combat.WeaponData.AttackKeys) then
			if Combat.CurrentWeapon.startfiring ~= nil then
				Combat.CurrentWeapon.startfiring()
			end
			if Combat.CurrentWeapon ~= nil and Combat.CurrentWeapon.attack ~= nil then
				Combat.CurrentWeapon.attack()
			end
		end
		if Input.MatchKey(io, Combat.WeaponData.ReloadKeys) then
			Combat.CurrentWeapon.reload()
		end
	end)
	Input.InputEnded:Connect(function(io)
		if not Combat.WeaponData or not Combat.WeaponData.AimKeys then
			return
		end
		if Input.MatchKey(io, Combat.WeaponData.AimKeys) then
			Combat.CurrentWeapon.setaim(false)
		end
		if Input.MatchKey(io, Combat.WeaponData.AttackKeys) then
			Combat.CurrentWeapon.firing = false
		end
	end)
	
	local function OnRayUpdated(CastOrigin, SegmentOrigin, SegmentDirection, Length, CosmeticBulletObject)
		local BulletLength = CosmeticBulletObject.Size.Z / 2
		CosmeticBulletObject.CFrame = CFrame.new(SegmentOrigin, SegmentOrigin + SegmentDirection) * CFrame.new(0, 0, -(Length - BulletLength))
	end
	
	local function OnRayHit(HitPart, HitPoint, Normal, Material, CosmeticBulletObject)
	CosmeticBulletObject:Destroy()

	ReplicateHit(HitPoint, Normal, HitPart)
	Remote:FireServer("ReplicateHit", HitPoint, Normal, HitPart)	

	if HitPart and HitPart.Parent then
		local Light = Lights[HitPart]
		local Humanoid = HitPart.Parent:FindFirstChildOfClass("Humanoid") or HitPart.Parent.Parent:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			Remote:FireServer("DamagePlayer", HitPart, Humanoid)			
						
			if HitPart.Name == "Head" or HitPart.Parent.Name == "Head" then
				Hitmarker("Headshot")
			else
				Hitmarker("Bodyshot")
			end
		end
		if Light then
			HitPart.Material = Enum.Material.SmoothPlastic
			local SpotLight = HitPart:FindFirstChildOfClass("SpotLight")
			local SurfaceLight = HitPart:FindFirstChildOfClass("SurfaceLight")
			local PointLight = HitPart:FindFirstChildOfClass("PointLight")
			if SpotLight then
				SpotLight.Enabled = false
			end
			if SurfaceLight then
				SurfaceLight.Enabled = false
			end
			if PointLight then
				PointLight.Enabled = false
			end
		end
	end
	end

	
	function OnRayHit2(HitPart, HitPoint, Normal, Material, CosmeticBulletObject)
		CosmeticBulletObject:Destroy()
	end
	
local function OnClientEvent(...)
    local Arguments = {...}
    print(Arguments[1])
    if Arguments[1] == "ActivateWeaponEffects" then
        local Weapon = Arguments[2]
        if Weapon then
            ReplicateBeam(Weapon.Muzzle)
        end
    elseif Arguments[1] == "Reload" then
        local Weapon = Arguments[2]

        if Weapon then
            local Config = require(findweaponmodule(Weapon.Name))
            Audio.PlaySound(Config.SoundData[Arguments[3]], Weapon.Handle)
        end
    elseif Arguments[1] == "CreateBullet" then
        local Bullet = ReplicatedStorage:WaitForChild("Bullet"):Clone()
        Bullet.Parent = workspace

        local Origin, Direction = Arguments[2].Muzzle.FirePointObject.WorldPosition, Arguments[4]

        Bullet.CFrame = CFrame.new(Origin, Origin + Direction)
        ReplicationCaster.IgnoreDescendantsInstance = Arguments[2].Parent
        ReplicationCaster:Fire(Origin, Direction, Arguments[4], Bullet)
        --FastCaster.Gravity = require(Weapon.Settings).StatData.BulletDropGravity
        --FastCaster.ExtraForce = require(Weapon.Settings).StatData.BulletWindOffset

    elseif Arguments[1] == "ReplicateHit" then
        ReplicateHit(Arguments[2], Arguments[3], Arguments[4])
    elseif Arguments[1] == "Footstep" then
		
        Audio.PlaySound(Arguments[4].SoundId, Arguments[2], false, Arguments[3])
    end
end

	
	Remote.OnClientEvent:Connect(OnClientEvent)
	Caster.LengthChanged:Connect(OnRayUpdated)
	Caster.RayHit:Connect(OnRayHit)
	ReplicationCaster.LengthChanged:Connect(OnRayUpdated)
	ReplicationCaster.RayHit:Connect(OnRayHit2)
	
return Combat
