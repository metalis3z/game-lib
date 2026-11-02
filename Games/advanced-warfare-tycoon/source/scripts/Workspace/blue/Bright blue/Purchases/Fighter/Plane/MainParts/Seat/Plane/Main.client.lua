--Don't edit anything below unless you can script well!
--This plane was made by TurboFusion

repeat wait() until game.Players.LocalPlayer --This line makes the tool wait until it is in the Player's backpack
------------------------------------------------------------------
local Player = game.Players.LocalPlayer --This line down to line 74 set all the variables in the plane
local Character = Player.Character
local Plane = Character.Plane
local AutoCrash = Plane.AutoCrash
local Weapons = Plane.Weapons
local MainParts = Plane.MainParts
local Gear = MainParts.Gear
local Engine = MainParts.Engine
local Thrust = Engine.Thrust
local Direction = Engine.Direction
local Customize = Plane.Customize
local Tool = script.Parent
local GUI = Tool.PlaneGui
local ToolSelect = Tool.ToolSelect
local Deselect0 = Tool.Deselect0
local FireMain = Tool.FireMain
local Camera = game.Workspace.CurrentCamera
local RunService = game:GetService("RunService")
------------------------------------------------------------------
local Acceleration = Customize.Acceleration
local MaxSpeed = Customize.MaxSpeed
local StallSpeed = Customize.StallSpeed
local TurnSpeed = Customize.TurnSpeed
local ThrottleInc = Customize.ThrottleInc
local MaxBank = Customize.MaxBank
local CameraType = Customize.CameraType
local CamLock = Customize.CamLock
local Ejectable = Customize.Ejectable
local NewTargeting = Customize.NewTargeting
local PlaneName = Customize.PlaneName
local Targetable = Customize.Targetable
local FlightControls = Customize.FlightControls
local WeaponControls = Customize.WeaponControls
local TargetControls = Customize.TargetControls
local WeaponsValue = Customize.Weapons
local ReloadTimes = Customize.ReloadTimes
local AltRestrict = Customize.AltitudeRestrict
local MaxAltitude = AltRestrict.MaxAltitude
local MinAltitude = AltRestrict.MinAltitude
------------------------------------------------------------------
local GuiAVisible = true
local GuiBVisible = true
------------------------------------------------------------------
local BombM = FireMain.BombM
local MissileM = FireMain.MissileM
------------------------------------------------------------------
local RocketEnabled = true
local FlareEnabled = true
local BombEnabled = true
local MissileEnabled = true
------------------------------------------------------------------
local SUAK = false
local SDAK = false
------------------------------------------------------------------
local EngineOn = false
local Flying = false
local LockedCam = false
local LowestPoint = 0
local DesiredSpeed = 0
local CurrentSpeed = 0
local TrueAirSpeed = 0
local Throttle = 0
------------------------------------------------------------------
local FTab = {nil,nil,nil,nil,nil,nil}
------------------------------------------------------------------
local LockGui = nil
local AimGui = nil
local Tracer = nil
local TargetPlayer = nil
local Locked = false
local Targeting = false
------------------------------------------------------------------
local AimingCursor = "http://www.roblox.com/asset/?id=107455536"
local LockedCursor = "http://www.roblox.com/asset/?id=107455986"
local TargetCursor = "http://www.roblox.com/asset/?id=107455960"
local NormalCursor = "http://www.roblox.com/asset/?id=116176885"
------------------------------------------------------------------
local LandingGear = {}
local GearUp = false --End of the variables
------------------------------------------------------------------
function FixVars() --This function fixes any errors in the Customize folder
	Acceleration2 = (Acceleration.Value < 0 and 0 or Acceleration.Value > 1000 and 1000 or Acceleration.Value)
	MaxBank2 = (MaxBank.Value < -90 and -90 or MaxBank.Value > 90 and 90 or MaxBank.Value)
	MaxSpeed2 = (MaxSpeed.Value < 0 and 0 or MaxSpeed.Value < StallSpeed.Value and StallSpeed.Value or MaxSpeed.Value)
	StallSpeed2 = (StallSpeed.Value < 0 and 0 or StallSpeed.Value > MaxSpeed.Value and MaxSpeed.Value or StallSpeed.Value)
	TurnSpeed2 = (TurnSpeed.Value < 0 and 0 or TurnSpeed.Value)
	ThrottleInc2 = (ThrottleInc.Value < 0 and 0 or ThrottleInc.Value)
	MaxAltitude2 = (MaxAltitude.Value < MinAltitude.Value and MinAltitude.Value or MaxAltitude.Value)
	MinAltitude2 = (MinAltitude.Value > MaxAltitude.Value and MaxAltitude.Value or MinAltitude.Value)
	MissileTime2 = (ReloadTimes.Missiles.Value < 0 and 0 or ReloadTimes.Missiles.Value)
	RocketTime2 = (ReloadTimes.Rockets.Value < 0 and 0 or ReloadTimes.Rockets.Value)
	GunTime2 = (ReloadTimes.Guns.Value < 0 and 0 or ReloadTimes.Guns.Value)
	FlareTime2 = (ReloadTimes.Flares.Value < 0 and 0 or ReloadTimes.Flares.Value)
	BombTime2 = (ReloadTimes.Bombs.Value < 0 and 0 or ReloadTimes.Bombs.Value)
	if (CameraType.Value ~= "Attach"
	and CameraType.Value ~= "Custom"
	and CameraType.Value ~= "Fixed"
	and CameraType.Value ~= "Track"
	and CameraType.Value ~= "Watch"
	and CameraType.Value ~= "Scriptable")
	then CameraType2 = "Custom" else CameraType2 = CameraType.Value end
	if PlaneName.Value == "" then PlaneName2 = "Plane" else PlaneName2 = PlaneName.Value end
	if WeaponsValue.Value == true then
		if WeaponsValue.Missiles.Value == true or WeaponsValue.Bombs.Value == true then
			Targetable2 = true
		elseif WeaponsValue.Missiles.Value == false and WeaponsValue.Bombs.Value == false then
			Targetable2 = false
		end
	elseif WeaponsValue.Value == false then
		Targetable2 = false
	end
	if FlightControls.SpeedUp.Value == "ArrowKeyUp" then
		SpeedUp2 = 17
		SUAK = true
	elseif FlightControls.SpeedUp.Value == "ArrowKeyDown" then
		SpeedUp2 = 18
		SUAK = true
	else
		SpeedUp2 = FlightControls.SpeedUp.Value
		SUAK = false
	end
	if FlightControls.SlowDown.Value == "ArrowKeyUp" then
		SlowDown2 = 17
		SDAK = true
	elseif FlightControls.SlowDown.Value == "ArrowKeyDown" then
		SlowDown2 = 18
		SDAK = true
	else
		SlowDown2 = FlightControls.SlowDown.Value
		SDAK = false
	end
	Engine.Direction.P = TurnSpeed2
end

function FireMachineGun(GunParent) --This function creates the bullets for the MachineGuns
	while FiringGun == true do
		local Guns = GunParent:GetChildren() --This is what allow you to put as many MachineGuns as you want in the Guns folder
		for i = 1,#Guns do
			if Guns[i]:IsA("BasePart") then
				if Guns[i].Name == "MachineGun" then
					local Part = Instance.new("Part")
					Part.BrickColor = BrickColor.new("Bright yellow")
					Part.Name = "Bullet"
					Part.CanCollide = false
					Part.FormFactor = "Symmetric"
					Part.Size = Vector3.new(5,5,3)
					Part.BottomSurface = "Smooth"
					Part.TopSurface = "Smooth"
					local Mesh = Instance.new("BlockMesh")
					Mesh.Parent = Part
					Mesh.Scale = Vector3.new(1/25,1/25,1)
					local BV = Instance.new("BodyVelocity")
					BV.Parent = Part
					BV.maxForce = Vector3.new(math.huge,math.huge,math.huge)
					local PlaneTag = Instance.new("ObjectValue")
					PlaneTag.Parent = Part
					PlaneTag.Name = "PlaneTag"
					PlaneTag.Value = Plane
					Part.Touched:connect(function(Object) --This lets me call the "Touched" function, which means I don't need an external script
						if (not Object:IsDescendantOf(Character)) then
							local HitHumanoid = Object.Parent:findFirstChild("Humanoid")
							if HitHumanoid then
								HitHumanoid:TakeDamage(100) --This only damges the player if they don't have a forcefield
								local CreatorTag = Instance.new("ObjectValue")
								CreatorTag.Name = "creator"
								CreatorTag.Value = Player
								CreatorTag.Parent = HitHumanoid
							elseif (not HitHumanoid) then
								Object:BreakJoints()
							end
						end
					end)
					Part.Parent = game.Workspace
					Part.CFrame = Guns[i].CFrame + Guns[i].CFrame.lookVector * 10
					BV.velocity = (Guns[i].Velocity) + (Part.CFrame.lookVector * 2000) + (Vector3.new(0,0.15,0))
					coroutine.resume(coroutine.create(function()
						wait(3)
						Part:Destroy()
					end))
				end
			end
		end
		wait(GunTime2)
	end
end

function FireRockets(GunParent) --This function creates the rockets for the rocket spawns
	local Guns = GunParent:GetChildren() --This allows you to put as many RocketSpawns as you want in the Rockets folder
	for i = 1,#Guns do
		if Guns[i]:IsA("BasePart") then
			if Guns[i].Name == "RocketSpawn" then
				local Exploded = false
				local Part1 = Instance.new("Part")
				Part1.BrickColor = BrickColor.new("White")
				Part1.Name = "Missile"
				Part1.CanCollide = false
				Part1.FormFactor = "Symmetric"
				Part1.Size = Vector3.new(1,1,5)
				Part1.BottomSurface = "Smooth"
				Part1.TopSurface = "Smooth"
				local Mesh = Instance.new("SpecialMesh")
				Mesh.Parent = Part1
				Mesh.MeshId = "http://www.roblox.com/asset/?id=2251534"
				Mesh.MeshType = "FileMesh"
				Mesh.Scale = Vector3.new(0.5,0.5,0.5)
				local Part2 = Instance.new("Part")
				Part2.Parent = Part1
				Part2.Transparency = 1
				Part2.Name = "Visual"
				Part2.CanCollide = false
				Part2.FormFactor = "Symmetric"
				Part2.Size = Vector3.new(1,1,1)
				Part2.BottomSurface = "Smooth"
				Part2.TopSurface = "Smooth"
				local Weld = Instance.new("Weld")
				Weld.Parent = Part1
				Weld.Part0 = Part1
				Weld.Part1 = Part2
				Weld.C0 = CFrame.new(0,0,4) * CFrame.Angles(math.rad(90),0,0)
				local BV = Instance.new("BodyVelocity")
				BV.Parent = Part1
				BV.maxForce = Vector3.new(math.huge,math.huge,math.huge)
				local BG = Instance.new("BodyGyro")
				BG.Parent = Part
				BG.maxTorque = Vector3.new(math.huge,math.huge,math.huge)
				BG.cframe = Guns[i].CFrame
				local Fire = Instance.new("Fire")
				Fire.Parent = Part2
				Fire.Heat = 25
				Fire.Size = 10
				local Smoke = Instance.new("Smoke")
				Smoke.Parent = Part2
				Smoke.Color = Color3.new(200/255,200/255,200/255)
				Smoke.Opacity = 0.7
				Smoke.RiseVelocity = 25
				Smoke.Size = 10
				local PlaneTag = Instance.new("ObjectValue")
				PlaneTag.Parent = Part
				PlaneTag.Name = "PlaneTag"
				PlaneTag.Value = Plane
				Part1.Touched:connect(function(Object)
					if (not Exploded) then
						if (not Object:IsDescendantOf(Character)) then
							if Object.Name ~= "Missile" then
								Exploded = true
								local Explosion = Instance.new("Explosion",game.Workspace)
								Explosion.Position = Part1.Position
								Explosion.BlastPressure = 5000
								Explosion.BlastRadius = 10
								ScanPlayers(Part1.Position,10)
								Explosion.Parent = game.Workspace
								Part1:Destroy()
							end
						end
					end
				end)
				Part1.Parent = game.Workspace
				Part1.CFrame = Guns[i].CFrame + Guns[i].CFrame.lookVector * 10
				BV.velocity = Part1.CFrame.lookVector * 1250 + Vector3.new(0,0.15,0)
				coroutine.resume(coroutine.create(function()
					wait(5)
					Part1:Destroy()
				end))
			end
		end
	end
end

function DeployFlares(GunParent) --This function creates the flares for the flare spawns
	local Guns = GunParent:GetChildren()
	for i = 1,#Guns do
		if Guns[i]:IsA("BasePart") then
			if Guns[i].Name == "FlareSpawn" then
				local RandomFactor = 40
				local RandomX = math.rad(math.random(-RandomFactor,RandomFactor))
				local RandomY = math.rad(math.random(-RandomFactor,RandomFactor))
				local Part = Instance.new("Part")
				Part.Transparency = 1
				Part.Name = "Flare"
				Part.CanCollide = false
				Part.FormFactor = "Symmetric"
				Part.Size = Vector3.new(1,1,1)
				Part.BottomSurface = "Smooth"
				Part.TopSurface = "Smooth"
				local BG = Instance.new("BillboardGui")
				BG.Parent = Part
				BG.Size = UDim2.new(10,0,10,0)
				local IL = Instance.new("ImageLabel")
				IL.Parent = BG
				IL.BackgroundTransparency = 1
				IL.Image = "http://www.roblox.com/asset/?id=43708803"
				IL.Size = UDim2.new(1,0,1,0)
				local Smoke = Instance.new("Smoke")
				Smoke.Parent = Part
				Smoke.Opacity = 0.5
				Smoke.RiseVelocity = 25
				Smoke.Size = 5
				local PL = Instance.new("PointLight")
				PL.Parent = Part
				PL.Brightness = 10
				PL.Color = Color3.new(1,1,0)
				PL.Range = 20
				Part.Parent = game.Workspace
				Part.CFrame = (Guns[i].CFrame + Guns[i].CFrame.lookVector * 5) * CFrame.Angles(RandomX,RandomY,0)
				Part.Velocity = Part.CFrame.lookVector * 150
				coroutine.resume(coroutine.create(function()
					wait(5)
					Part:Destroy()
				end))
			end
		end
	end
end

function DropBomb(GunParent) --This function creates the non-guided bombs for the bomb spawns
	local Guns = GunParent:GetChildren()
	if Locked == false then
		for i = 1,#Guns do
			if Guns[i]:IsA("BasePart") then
				if Guns[i].Name == "BombSpawn" then
					local Exploded = false
					local Part = Instance.new("Part")
					Part.Name = "Bomb"
					Part.CanCollide = false
					Part.FormFactor = "Symmetric"
					Part.Size = Vector3.new(2,2,9)
					Part.BottomSurface = "Smooth"
					Part.TopSurface = "Smooth"
					local Mesh = Instance.new("SpecialMesh")
					Mesh.Parent = Part
					Mesh.MeshId = "http://www.roblox.com/asset/?id=88782666"
					Mesh.MeshType = "FileMesh"
					Mesh.Scale = Vector3.new(4,4,4)
					Mesh.TextureId = "http://www.roblox.com/asset/?id=88782631"
					local BG = Instance.new("BodyGyro")
					BG.Parent = Part
					BG.maxTorque = Vector3.new(math.huge,math.huge,math.huge)
					BG.cframe = Guns[i].CFrame * CFrame.Angles(math.rad(90),0,0)
					local PlaneTag = Instance.new("ObjectValue")
					PlaneTag.Parent = Part
					PlaneTag.Name = "PlaneTag"
					PlaneTag.Value = Plane
					Part.Touched:connect(function(Object)
						if (not Exploded) then
							if (not Object:IsDescendantOf(Character)) and Object.Name ~= "Bomb" then
								Exploded = true
								local Explosion = Instance.new("Explosion")
								Explosion.Position = Part.Position
								Explosion.BlastPressure = 500000
								Explosion.BlastRadius = 75
								ScanPlayers(Part.Position,75)
								Explosion.Parent = game.Workspace
								Part:Destroy()
							end
						end
					end)
					Part.Parent = game.Workspace
					Part.CFrame = (Guns[i].CFrame * CFrame.Angles(math.rad(90),0,0)) + Guns[i].CFrame.lookVector * 3
					Part.Velocity = (Part.CFrame.lookVector * (TrueAirSpeed * 0.75))
					coroutine.resume(coroutine.create(function()
						wait(7)
						Part:Destroy()
					end))
				end
			end
		end
	end
end

function DropGuidedBomb(Gun) --This function creates guided bombs for the bombs spawns
	if Locked == true then
		local Exploded = false
		local Part = Instance.new("Part")
		Part.Name = "Bomb"
		Part.CanCollide = false
		Part.FormFactor = "Symmetric"
		Part.Size = Vector3.new(2,2,9)
		Part.BottomSurface = "Smooth"
		Part.TopSurface = "Smooth"
		local Mesh = Instance.new("SpecialMesh")
		Mesh.Parent = Part
		Mesh.MeshId = "http://www.roblox.com/asset/?id=88782666"
		Mesh.MeshType = "FileMesh"
		Mesh.Scale = Vector3.new(4,4,4)
		Mesh.TextureId = "http://www.roblox.com/asset/?id=88782631"
		local OV = Instance.new("ObjectValue")
		OV.Parent = Part
		OV.Name = "Tracker"
		OV.Value = Tracer
		local NV = Instance.new("NumberValue")
		NV.Parent = Part
		NV.Name = "PlaneSpd"
		NV.Value = TrueAirSpeed * 0.8 --This makes the bombs travel speed 4/5 of the plane's speed
		local BG = Instance.new("BodyGyro")
		BG.Parent = Part
		BG.maxTorque = Vector3.new(math.huge,math.huge,math.huge)
		BG.P = 2000
		local BV = Instance.new("BodyVelocity")
		BV.Parent = Part
		BV.maxForce = Vector3.new(math.huge,6000,math.huge)
		BV.velocity = Vector3.new(0,0,0)
		local Script = BombM:clone()
		Script.Parent = Part
		local PlaneTag = Instance.new("ObjectValue")
		PlaneTag.Parent = Part
		PlaneTag.Name = "PlaneTag"
		PlaneTag.Value = Plane
		Part.Touched:connect(function(Object)
			if (not Exploded) then
				if (not Object:IsDescendantOf(Character)) and Object.Name ~= "Bomb" then
					Exploded = true
					local Explosion = Instance.new("Explosion")
					Explosion.Position = Part.Position
					Explosion.BlastPressure = 500000
					Explosion.BlastRadius = 75
					ScanPlayers(Part.Position,75)
					Explosion.Parent = game.Workspace
					Part:Destroy()
				end
			end
		end)
		Part.Parent = game.Workspace
		Part.CFrame = (Gun.CFrame * CFrame.Angles(math.rad(90),0,0)) + Gun.CFrame.lookVector * 10
		Script.Disabled = false
	end
end

function FireMissile(Gun) --This function creates the non-guided missiles for the missile spawns
	if Locked == false then
		local Exploded = false
		local Part1 = Instance.new("Part")
		Part1.Name = "Missile"
		Part1.CanCollide = false
		Part1.FormFactor = "Symmetric"
		Part1.Size = Vector3.new(1,1,13)
		Part1.BottomSurface = "Smooth"
		Part1.TopSurface = "Smooth"
		local Mesh = Instance.new("SpecialMesh")
		Mesh.Parent = Part1
		Mesh.MeshId = "http://www.roblox.com/asset/?id=2251534"
		Mesh.MeshType = "FileMesh"
		Mesh.TextureId = "http://www.roblox.com/asset/?id=2564491"
		local Part2 = Instance.new("Part")
		Part2.Parent = Part1
		Part2.Name = "Visual"
		Part2.Transparency = 1
		Part2.CanCollide = false
		Part2.FormFactor = "Symmetric"
		Part2.Size = Vector3.new(1,1,1)
		Part2.BottomSurface = "Smooth"
		Part2.TopSurface = "Smooth"
		local Weld = Instance.new("Weld")
		Weld.Parent = Part1
		Weld.Part0 = Part1
		Weld.Part1 = Part2
		Weld.C0 = CFrame.new(0,0,5)*CFrame.Angles(math.rad(90),0,0)
		local BV = Instance.new("BodyVelocity")
		BV.Parent = Part1
		BV.maxForce = Vector3.new(math.huge,math.huge,math.huge)
		local BG = Instance.new("BodyGyro")
		BG.Parent = Part
		BG.maxTorque = Vector3.new(math.huge,math.huge,math.huge)
		BG.cframe = Gun.CFrame * CFrame.Angles(math.rad(90),0,0)
		local Fire = Instance.new("Fire")
		Fire.Parent = Part2
		Fire.Enabled = false
		Fire.Heat = 25
		Fire.Size = 30
		local Smoke = Instance.new("Smoke")
		Smoke.Parent = Part2
		Smoke.Color = Color3.new(40/51,40/51,40/51)
		Smoke.Enabled = false
		Smoke.Opacity = 1
		Smoke.RiseVelocity = 25
		Smoke.Size = 25
		local PlaneTag = Instance.new("ObjectValue")
		PlaneTag.Parent = Part
		PlaneTag.Name = "PlaneTag"
		PlaneTag.Value = Plane
		Part1.Touched:connect(function(Object)
			if (not Exploded) then
				if (not Object:IsDescendantOf(Character)) and Object.Name ~= "Missile" then
					Exploded = true
					local Explosion = Instance.new("Explosion")
					Explosion.Position = Part1.Position
					Explosion.BlastPressure = 50000
					Explosion.BlastRadius = 50
					ScanPlayers(Part1.Position,50)
					Explosion.Parent = game.Workspace
					Part1:Destroy()
				end
			end
		end)
		Part1.Parent = game.Workspace
		Part1.CFrame = (Gun.CFrame * CFrame.Angles(math.rad(90),0,0)) + Gun.CFrame.lookVector * 15
		BV.velocity = Part1.CFrame.lookVector * Engine.Velocity.magnitude
		coroutine.resume(coroutine.create(function()
			wait(0.3)
			BV.velocity = (Part1.CFrame.lookVector * 1500) + Vector3.new(0,0.15,0)
			Fire.Enabled = true
			Smoke.Enabled = true
		end))
		coroutine.resume(coroutine.create(function()
			wait(5)
			Part1:Destroy()
		end))
	end
end

function FireGuidedMissile(Gun) --This function creates the guided missiles for the missile spawns
	if Targetable2 then
		if Locked == true then
			local Exploded = false
			local Part1 = Instance.new("Part")
			Part1.Name = "Missile"
			Part1.CanCollide = false
			Part1.FormFactor = "Symmetric"
			Part1.Size = Vector3.new(1,1,13)
			Part1.BottomSurface = "Smooth"
			Part1.TopSurface = "Smooth"
			local Mesh = Instance.new("SpecialMesh")
			Mesh.Parent = Part1
			Mesh.MeshId = "http://www.roblox.com/asset/?id=2251534"
			Mesh.MeshType = "FileMesh"
			Mesh.TextureId = "http://www.roblox.com/asset/?id=2564491"
			local Part2 = Instance.new("Part")
			Part2.Parent = Part1
			Part2.Transparency = 1
			Part2.Name = "Visual"
			Part2.CanCollide = false
			Part2.FormFactor = "Symmetric"
			Part2.Size = Vector3.new(1,1,1)
			Part2.BottomSurface = "Smooth"
			Part2.TopSurface = "Smooth"
			local Weld = Instance.new("Weld")
			Weld.Parent = Part1
			Weld.Part0 = Part1
			Weld.Part1 = Part2
			Weld.C0 = CFrame.new(0,0,5)*CFrame.Angles(math.rad(90),0,0)
			local OV = Instance.new("ObjectValue")
			OV.Parent = Part1
			OV.Name = "Tracker"
			OV.Value = Tracer
			local BV = Instance.new("BodyVelocity")
			BV.Parent = Part1
			BV.maxForce = Vector3.new(math.huge,math.huge,math.huge)
			local Script = MissileM:clone()
			Script.Parent = Part1
			local Fire = Instance.new("Fire")
			Fire.Parent = Part2
			Fire.Enabled = false
			Fire.Heat = 25
			Fire.Size = 30
			local Smoke = Instance.new("Smoke")
			Smoke.Parent = Part2
			Smoke.Color = Color3.new(40/51,40/51,40/51)
			Smoke.Enabled = false
			Smoke.Opacity = 1
			Smoke.RiseVelocity = 25
			Smoke.Size = 25
			local PlaneTag = Instance.new("ObjectValue")
			PlaneTag.Parent = Part
			PlaneTag.Name = "PlaneTag"
			PlaneTag.Value = Plane
			Part1.Touched:connect(function(Object)
				if (not Exploded) then
					if (not Object:IsDescendantOf(Character)) and Object.Name ~= "Missile" then
						Exploded = true
						local Explosion = Instance.new("Explosion")
						Explosion.Position = Part1.Position
						Explosion.BlastPressure = 50000
						Explosion.BlastRadius = 50
						ScanPlayers(Part1.Position,50)
						Explosion.Parent = game.Workspace
						Part1:Destroy()
					end
				end
			end)
			Part1.Parent = game.Workspace
			Part1.CFrame = (Gun.CFrame * CFrame.Angles(math.rad(90),0,0)) + Gun.CFrame.lookVector * 15
			coroutine.resume(coroutine.create(function()
				wait(0.3)
				Script.Disabled = false
				Fire.Enabled = true
				Smoke.Enabled = true
			end))
			coroutine.resume(coroutine.create(function()
				wait(10)
				Part1:Destroy()
			end))
		end
	end
end

function ScanPlayers(Pos,Radius) --This is a function that I created that efficiently puts a CreatorTag in the player
	coroutine.resume(coroutine.create(function()
		for i,v in pairs(game.Players:GetPlayers()) do --This gets all the players
			if v.Character and v.Character:findFirstChild("Torso") then
				local PTorso = v.Character.Torso
				if (PTorso.Position - Pos).magnitude <= Radius then --If the distance between the explosion and the player is less than the radius...
					local HitHumanoid = v.Character:findFirstChild("Humanoid")
					if HitHumanoid then
						local CreatorTag = Instance.new("ObjectValue")
						CreatorTag.Name = "creator"
						CreatorTag.Value = Player
						CreatorTag.Parent = HitHumanoid
						game:GetService("Debris"):AddItem(CreatorTag,0.1)
					end
				end
			end
		end
	end))
end

function ReloadRocket(Time) --This function reloads the rockets based on the rocket reload time
	if RocketEnabled == false then
		wait(Time)
		RocketEnabled = true
	end
end

function ReloadFlare(Time) --This function reloads the flares based on the flare reload time
	if FlareEnabled == false then
		wait(Time)
		FlareEnabled = true
	end
end

function ReloadBomb(Time) --This function reloads the bombs based on the bomb reload time
	if BombEnabled == false then
		wait(Time)
		BombEnabled = true
	end
end

function ReloadMissile(Time) --This function reloads the missile based on the missile reload time
	if MissileEnabled == false then
		wait(Time)
		MissileEnabled = true
	end
end

function onMouseMoved(mouse) --This function is activated when the mouse moves
	if Targetable2 then --If the plane can target...
		if Targeting == true then
			mouse.Icon = AimingCursor --All the cursors in this script were made by me
			Player.PlayerGui.PlaneGui.Frame.Mode.Text = "Targeting Mode"
			if (not NewTargeting.Value) then
				if mouse.Target ~= nil then --If the mouse's target exists...
					if Locked == false then
						mouse.Icon = TargetCursor
						AimGui.Enabled = true
						LockGui.Enabled = false
						AimGui.Adornee = mouse.Target
						LockGui.Adornee = nil
					elseif Locked == true then
						mouse.Icon = LockedCursor
						AimGui.Enabled = false
						LockGui.Enabled = true
						AimGui.Adornee = nil
						LockGui.Adornee = Tracer
					end
				elseif mouse.Target == nil then --If the mouse's target doesn't exist...(example: the sky)
					if Locked == false then
						mouse.Icon = AimingCursor
						AimGui.Enabled = false
						LockGui.Enabled = false
						AimGui.Adornee = nil
						LockGui.Adornee = nil
					elseif Locked == true then
						mouse.Icon = LockedCursor
						AimGui.Enabled = false
						LockGui.Enabled = true
						AimGui.Adornee = nil
						LockGui.Adornee = Tracer
					end
				end
			elseif NewTargeting.Value then
				local FoundPlayer = false
				for i,v in pairs(game.Players:GetPlayers()) do
					if v.Character then
						if v.Character:findFirstChild("Torso") then
							if v ~= Player then
								if ((v.TeamColor ~= Player.TeamColor) or v.Neutral) then
									local myHead = Character.Head
									local TorsoPos = v.Character.Torso.CFrame
									local Distance = (myHead.CFrame.p - TorsoPos.p).magnitude
									local MouseDirection = (mouse.Hit.p - myHead.CFrame.p).unit
									local Offset = (((MouseDirection * Distance) + myHead.CFrame.p) - TorsoPos.p).magnitude
									if Locked == false then
										if (Offset/Distance) < 0.1 then
											FoundPlayer = true
											if TargetPlayer ~= v then
												TargetPlayer = v
												mouse.Icon = TargetCursor
												AimGui.Enabled = true
												LockGui.Enabled = false
												AimGui.Adornee = TargetPlayer.Character.Torso
												LockGui.Adornee = nil
											end
										end
										if (not FoundPlayer) and TargetPlayer then
											TargetPlayer = nil
											mouse.Icon = AimingCursor
											AimGui.Enabled = false
											LockGui.Enabled = false
											AimGui.Adornee = nil
											LockGui.Adornee = nil
										end
									elseif Locked == true then
										mouse.Icon = LockedCursor
										AimGui.Enabled = false
										LockGui.Enabled = true
										AimGui.Adornee = nil
										LockGui.Adornee = Tracer
									end
								end
							end
						end
					end
				end
			end
		elseif Targeting == false then
			mouse.Icon = NormalCursor
			Player.PlayerGui.PlaneGui.Frame.Mode.Text = "Flying Mode"
		end
	end
end

function onTracerWeldRemoved(Child) --This function untargets the tracer after it has been hit.
	if Child.ClassName == "Weld" then
		if Child.Name == "Weld" then
			Locked = false
			Tracer.Parent = game.Lighting
		end
	end
end

function onButton1Down(mouse) --This function is activated when you press the left mouse button
	if Targetable2 then 
		if EngineOn == true then
			if Targeting == true then
				if (not NewTargeting.Value) then
					if mouse.Target ~= nil then
						if Locked == false then
							Locked = true
							local MouseTarget = mouse.Target --Lines 528-536 put the tracer into the workspace and locks onto it
							local Weld = Instance.new("Weld")
							Tracer.CFrame = mouse.Hit
							Tracer.Parent = game.Workspace
							Weld.Part1 = MouseTarget
							Weld.Part0 = Tracer
							Weld.C0 = Tracer.CFrame:inverse()
							Weld.C1 = MouseTarget.CFrame:inverse()
							Weld.Parent = Tracer
						end
					end
				elseif NewTargeting.Value then
					if TargetPlayer ~= nil then
						if Locked == false then
							Locked = true
							local Weld = Instance.new("Weld")
							Tracer.CFrame = TargetPlayer.Character.Torso.CFrame
							Tracer.Parent = game.Workspace
							Weld.Part1 = TargetPlayer.Character.Torso
							Weld.Part0 = Tracer
							Weld.Parent = Tracer
						end
					end
				end
			end
		end
	end
end

function IncreaseSpd() --This function increases the speed
	if EngineOn == true then
		if Flying == true then
			while Accelerating == true do
				Throttle = (Throttle < 1 and Throttle + 0.01 or 1)
				DesiredSpeed = MaxSpeed2 * Throttle
				wait(ThrottleInc2)
			end
		end
	end
end

function DecreaseSpd() --This function decreases the speed
	if EngineOn == true then
		if Flying == true then
			while Decelerating == true do
				Throttle = (Throttle > 0 and Throttle - 0.01 or 0)
				DesiredSpeed = MaxSpeed2 * Throttle
				wait(ThrottleInc2)
			end
		end
	end
end

function RoundNumber(Num) --This function rounds a number to the nearest whole number
	return ((Num - math.floor(Num)) >= 0.5 and math.ceil(Num) or math.floor(Num))
end

function GetGear(Parent) --This function gets all the parts in the Gear folder
	for i,v in pairs(Parent:GetChildren()) do
		if (v:IsA("BasePart")) then
			if (not v:findFirstChild("GearProp")) then
				local GearProp = Instance.new("StringValue")
				GearProp.Name = "GearProp"
				GearProp.Value = v.Transparency..","..tostring(v.CanCollide)
				GearProp.Parent = v
			end
			table.insert(LandingGear,v) --This inserts a table with the gear's properties into the LandingGear table
		end
		GetGear(v)
	end
end

function ChangeGear() --This function extends or retracts the gear
	for i,v in pairs(LandingGear) do
		local GearProp = v.GearProp
		local Comma = GearProp.Value:find(",",1,true)
		local TransVal = tonumber(GearProp.Value:sub(1,Comma - 1))
		local CollideVal = GearProp.Value:sub(Comma + 1)
		v.Transparency = (TransVal ~= 1 and (GearUp and TransVal or 1))
		v.CanCollide = (CollideVal and (GearUp and CollideVal or false))
	end
end

function SetUpGui() --This function sets up the PlaneGui
	if Player.PlayerGui:findFirstChild("PlaneGui") ~= nil then
		local Gui = Player.PlayerGui.PlaneGui.Frame
		Gui.Title.Text = PlaneName2
		local TargetStats = Gui.Parent.TargetStats
		local ControlsA,ControlsB = Gui.ControlsA,Gui.ControlsB
		local FrameA,FrameB = Gui.FrameA,Gui.FrameB
		local C1A,C1B = FrameA.C1.Key,FrameB.C1.Key
		local C2A,C2B = FrameA.C2.Key,FrameB.C2.Key
		local C3A,C3B = FrameA.C3.Key,FrameB.C3.Key
		local C4A,C4B = FrameA.C4.Key,FrameB.C4.Key
		local C5A,C5B = FrameA.C5.Key,FrameB.C5.Key
		local C6,C7 = FrameA.C6.Key,FrameA.C7.Key
		local GearText = Gui.Gear
		for i,v in pairs(LandingGear) do --This section determines whether the gear are up or down
			if v.Transparency == 1 then
				GearUp = true
			else
				GearUp = false
				break
			end
		end
		TargetStats.Visible = (NewTargeting.Value and Targetable2)
		GearText.Text = (GearUp and "Gear Up" or "Gear Down")
		C1A.Text = "Key: "..FlightControls.Engine.Value:upper()
		if FlightControls.SpeedUp.Value == "ArrowKeyUp" then
			C2A.Text = "Key: ArrowKeyUp"
		elseif FlightControls.SpeedUp.Value == "ArrowKeyDown" then
			C2A.Text = "Key: ArrowKeyDown"
		else
			C2A.Text = "Key: "..FlightControls.SpeedUp.Value:upper()
		end
		if FlightControls.SlowDown.Value == "ArrowKeyUp" then
			C3A.Text = "Key: ArrowKeyUp"
		elseif FlightControls.SlowDown.Value == "ArrowKeyDown" then
			C3A.Text = "Key: ArrowKeyDown"
		else
			C3A.Text = "Key: "..FlightControls.SlowDown.Value:upper()
		end
		C4A.Text = "Key: "..FlightControls.Gear.Value:upper()
		if Targetable2 then
			C5A.Text = "Key: "..TargetControls.Modes.Value:upper()
		else
			C5A.Parent.Visible = false
		end
		if Ejectable.Value then
			C6.Text = "Key: "..FlightControls.Eject.Value:upper()
		else
			C6.Parent.Visible = false
		end
		if CamLock.Value then
			C7.Text = "Key: "..FlightControls.LockCam.Value:upper()
		else
			C7.Parent.Visible = false
		end
		if WeaponsValue.Value == false then
			C1B.Parent.Visible = false
			C2B.Parent.Visible = false
			C3B.Parent.Visible = false
			C4B.Parent.Visible = false
			C5B.Parent.Visible = false
			FrameB.Title.Text = "No Weapons"
		elseif WeaponsValue.Value == true then
			if WeaponsValue.Missiles.Value == true then
				C1B.Text = "Key: "..WeaponControls.FireMissile.Value:upper()
			elseif WeaponsValue.Missiles.Value == false then
				C1B.Parent.Visible = false
			end
			if WeaponsValue.Rockets.Value == true then
				C2B.Text = "Key: "..WeaponControls.FireRockets.Value:upper()
			elseif WeaponsValue.Rockets.Value == false then
				C2B.Parent.Visible = false
			end
			if WeaponsValue.Guns.Value == true then
				C3B.Text = "Key: "..WeaponControls.FireGuns.Value:upper()
			elseif WeaponsValue.Guns.Value == false then
				C3B.Parent.Visible = false
			end
			if WeaponsValue.Bombs.Value == true then
				C4B.Text = "Key: "..WeaponControls.DropBombs.Value:upper()
			elseif WeaponsValue.Bombs.Value == false then
				C4B.Parent.Visible = false
			end
			if WeaponsValue.Flares.Value == true then
				C5B.Text = "Key: "..WeaponControls.DeployFlares.Value:upper()
			elseif WeaponsValue.Flares.Value == false then
				C5B.Parent.Visible = false
			end
		end
		ControlsA.MouseButton1Click:connect(function() --This function allows the Flight Controls frame to be opened or closed without an external script
			if GuiAVisible == true then
				GuiAVisible = false
				FrameA:TweenPosition(UDim2.new(0,150,0,-190),"In","Quad",1,true)
			elseif GuiAVisible == false then
				GuiAVisible = true
				FrameA:TweenPosition(UDim2.new(0,150,0,170),"Out","Quad",1,true)
			end
		end)
		ControlsB.MouseButton1Click:connect(function()
			if GuiBVisible == true then
				GuiBVisible = false
				FrameB:TweenPosition(UDim2.new(0,-150,0,-150),"In","Quad",1,true)
			elseif GuiBVisible == false then
				GuiBVisible = true
				FrameB:TweenPosition(UDim2.new(0,-150,0,170),"Out","Quad",1,true)
			end
		end)
	end
end

function UpdateTargetStats(Target,Gui) --This function updates the stats about the Target
	if Target then
		local myHead = Character.Head
		local TorsoPos = Target.Character.Torso.CFrame
		local Distance = (myHead.CFrame.p - TorsoPos.p).magnitude
		local TargetSpeed = (Target.Character.Torso.Velocity).magnitude
		local TargetAlt = Target.Character.Torso.Position.Y
		Gui.LockName.Text = "Target: "..Target.Name
		Gui.Dist.Text = "Distance: "..math.floor(Distance * 10)/10
		Gui.Speed.Text = "Speed: "..math.floor(TargetSpeed * 10)/10
		Gui.Altitude.Text = "Altitude: "..math.floor(TargetAlt * 10)/10
	elseif (not Target) then
		Gui.LockName.Text = "Target: None"
		Gui.Dist.Text = "Distance: N/A"
		Gui.Speed.Text = "Speed: N/A"
		Gui.Altitude.Text = "Altitude: N/A"
	end
end

function GetRoll(CF) --This function gets the rotation of the Engine. Credit to DevAdrian for this
	local CFRight = CF * CFrame.Angles(0,math.rad(90),0)
	local CFNoRollRight = CFrame.new(CF.p,CF.p + CF.lookVector) * CFrame.Angles(0,math.rad(90),0)
	local CFDiff = CFRight:toObjectSpace(CFNoRollRight)
	return (-math.atan2(CFDiff.lookVector.Y, CFDiff.lookVector.Z) % (math.pi * 2) + math.pi)
end

function UpdateCamera() --This function uses the RunService to update the camera. It happens very fast so it is smooth
	if Flying then
		if (not LockedCam) then
			Camera.CameraType = CameraType2
		elseif LockedCam then
			local EngineCF = Engine.CFrame
			local PlaneSize = Plane:GetModelSize().magnitude/2
			local Origin = EngineCF.p + (EngineCF.lookVector * (PlaneSize - 1))
			local Target = EngineCF.p + (EngineCF.lookVector * PlaneSize)
			Camera.CameraType = Enum.CameraType.Scriptable
			Camera.CoordinateFrame = CFrame.new(Origin,Target)
			Camera:SetRoll(GetRoll(Character.Head.CFrame))
		end
	else
		Camera.CameraType = Enum.CameraType.Custom
	end
end

function UpdateGui(Taxiing,Stalling) --This function updates the gui.
	if Player.PlayerGui:findFirstChild("PlaneGui") ~= nil then
		local Gui = Player.PlayerGui.PlaneGui.Frame
		local TargetStats = Player.PlayerGui.PlaneGui.TargetStats
		if NewTargeting.Value and Targetable2 then UpdateTargetStats(TargetPlayer,TargetStats) end
		Gui.PullUp.Visible = (EngineOn and (not Taxiing) and (AltRestrict.Value) and (Engine.Position.Y < (MinAltitude2 + 20)))
		Gui.Taxi.Visible = (EngineOn and Taxiing)
		Gui.Stall.Visible = (not Taxiing and Stalling)
		Gui.Altitude.Text = "Altitude: "..RoundNumber(Engine.Position.Y)
		Gui.Speed.Text = "Speed: "..RoundNumber(TrueAirSpeed)
		Gui.Throttle.Bar.Tray.Size = UDim2.new(Throttle,0,1,0)
		Gui.Throttle.Percent.Text = math.abs(math.floor(Throttle * 100)).."%"
		local StallLinePos = (StallSpeed2/math.floor(TrueAirSpeed + 0.5)) * (StallSpeed2/MaxSpeed2)
		local StallLinePosFix = (StallLinePos > 1 and 1 or StallLinePos < 0 and 0 or StallLinePos)
		Gui.Throttle.Bar.StallLine.Position = UDim2.new(StallLinePosFix,0,0,0)
		Gui.Throttle.Bar.Tray.BackgroundColor3 = (Throttle <= StallLinePosFix and Color3.new(1,0,0) or Color3.new(0,2/3,0))
	end
end

function CalculateSpeed() --This function calculates the current speed
	while Flying == true do
		if EngineOn == true then
			CurrentSpeed = (CurrentSpeed < DesiredSpeed and CurrentSpeed + 2 or CurrentSpeed - 2) --A simple ternary operation that calculates the currentspeed
		end
		wait(0.5 - (Acceleration2/2000))
	end
end

function GetLowestPoint() --This function gets the lowest point of the plane
	if (#LandingGear == 0) then
		LowestPoint = (Engine.Position.Y + 5 + (Engine.Size.Y/2))
		return
	end
	for i,v in pairs(LandingGear) do
		local Set0 = (Engine.Position.Y - (v.CFrame * CFrame.new((v.Size.X/2),0,0)).Y)
		local Set1 = (Engine.Position.Y - (v.CFrame * CFrame.new(-(v.Size.X/2),0,0)).Y)
		local Set2 = (Engine.Position.Y - (v.CFrame * CFrame.new(0,(v.Size.Y/2),0)).Y)
		local Set3 = (Engine.Position.Y - (v.CFrame * CFrame.new(0,-(v.Size.Y/2),0)).Y)
		local Set4 = (Engine.Position.Y - (v.CFrame * CFrame.new(0,0,(v.Size.Z/2))).Y)
		local Set5 = (Engine.Position.Y - (v.CFrame * CFrame.new(0,0,-(v.Size.Z/2))).Y)
		local Max = (math.max(Set0,Set1,Set2,Set3,Set4,Set5)+5)
		LowestPoint = (Max > LowestPoint and Max or LowestPoint)
	end
end

function GetBankAngle() --This function calculates the Bank Angle
	local VSX,X = mouse2.ViewSizeX,mouse2.X
	local Ratio = (((VSX/2) - X)/(VSX/2))
	Ratio = (Ratio < -1 and -1 or Ratio > 1 and 1 or Ratio)
	return math.rad(Ratio * MaxBank2)
end

function Taxi() --This function determines whether the plane is taxiing or not
	local Ray = Ray.new(Engine.Position,Vector3.new(0,-LowestPoint,0))
	return (TrueAirSpeed <= StallSpeed2 and game.Workspace:FindPartOnRay(Ray,Plane))
end

function Stall() --This function determines whether the plane is stalling or not
	return ((AltRestrict.Value and Engine.Position.Y > MaxAltitude2) or TrueAirSpeed < StallSpeed2)
end

function FlyMain(M) --This is the main flying function
	while Flying == true do
		local BankAngle = GetBankAngle() --This uses the "GetBankAngle" function to calculate the Bank Angle
		local Taxi,Stall = Taxi(),Stall()
		if EngineOn == true then
			Engine.Thrust.velocity = Engine.CFrame.lookVector * CurrentSpeed
			if Taxi then
				if (CurrentSpeed < 2) then
					Thrust.maxForce = Vector3.new(0,0,0)
					Direction.maxTorque = Vector3.new(0,0,0)
				else
					Thrust.maxForce = Vector3.new(math.huge,0,math.huge)
					Direction.maxTorque = Vector3.new(0,math.huge,0)
					Direction.cframe = CFrame.new(Engine.Position,M.Hit.p)
				end
			elseif Stall then
				Thrust.maxForce = Vector3.new(0,0,0)
				Direction.maxTorque = Vector3.new(math.huge,math.huge,math.huge)
				Direction.cframe = (M.Hit*CFrame.Angles(0,0,BankAngle))
			else
				Thrust.maxForce = Vector3.new(math.huge,math.huge,math.huge)
				Direction.maxTorque = Vector3.new(math.huge,math.huge,math.huge)
				Direction.cframe = (M.Hit*CFrame.Angles(0,0,BankAngle))
			end
			if ((AltRestrict.Value) and (Engine.Position.Y < MinAltitude2)) then --If there are altitude restrictions and you are below it...
				AutoCrash.Value = true
			end
		elseif EngineOn == false then
			Thrust.maxForce = Vector3.new(0,0,0)
			Thrust.velocity = Vector3.new(0,0,0)
			Direction.maxTorque = Vector3.new(0,0,0)
		end
		TrueAirSpeed = Engine.Velocity.magnitude
		UpdateGui(Taxi,Stall) --This activates the "UpdateGui" function
		wait()
	end
end

function onKeyDown(Key) --This function is activated whenever a key is pressed
	Key:lower()
	if (Key == FlightControls.Engine.Value) then --If you press the engine key...
		if EngineOn == false then
			EngineOn = true
			DesiredSpeed = 0
			CurrentSpeed = 0
			Throttle = 0
			if Player.PlayerGui:findFirstChild("PlaneGui") ~= nil then
				local Gui = Player.PlayerGui.PlaneGui.Frame
				Gui.Engine.Visible = false
			end
			CalculateSpeed()
		elseif EngineOn == true then
			EngineOn = false
			DesiredSpeed = 0
			CurrentSpeed = 0
			Throttle = 0
			if Player.PlayerGui:findFirstChild("PlaneGui") ~= nil then
				local Gui = Player.PlayerGui.PlaneGui.Frame
				Gui.Engine.Visible = true
			end
		end
	end
	if (Key == FlightControls.Gear.Value) then --If you press the change gear key...
		if Player.PlayerGui:findFirstChild("PlaneGui") then
			local Gui = Player.PlayerGui.PlaneGui.Frame
			local Taxiing = Taxi()
			if (#LandingGear ~= 0) then
				if (not Taxiing) then
					ChangeGear()
					if GearUp == false then
						GearUp = true
						Gui.Gear.Text = "Gear Up"
					elseif GearUp == true then
						GearUp = false
						Gui.Gear.Text = "Gear Down"
					end
				end
			end
		end
	end
	if SUAK == true and Key:byte() == SpeedUp2 or SUAK == false and (Key == SpeedUp2) then --If you press the speed up key...
		Accelerating = true
		IncreaseSpd()
	end
	if SDAK == true and Key:byte() == SlowDown2 or SDAK == false and (Key == SlowDown2) then --If you press the slow down key...
		Decelerating = true
		DecreaseSpd()
	end
	if (Key == TargetControls.Modes.Value) then --If you press the change modes key...
		if Targetable2 == true then
			if EngineOn == true then
				if Targeting == false then
					Targeting = true
				elseif Targeting == true then
					Targeting = false
					Locked = false
					Tracer.Parent = game.Lighting
					AimGui.Enabled = false
					LockGui.Enabled = false
					if Tracer:findFirstChild("Weld") ~= nil then
						Tracer.Weld:remove()
					end
				end
			end
		end
	end
	if (Key == FlightControls.Eject.Value:lower()) then
		if EngineOn then
			local Taxiing = Taxi()
			if (not Taxiing) then
				if Ejectable.Value then
					if (not Plane.Ejected.Value) then
						Plane.Ejected.Value = true
						local Seat = MainParts.Seat
						local EjectClone = Tool.Ejector:clone()
						EjectClone.Parent = Player.PlayerGui
						EjectClone.Disabled = false
						local Fire = Instance.new("Fire")
						Fire.Parent = Engine
						Fire.Heat = 25
						Fire.Size = 30
						local Smoke = Instance.new("Smoke")
						Smoke.Parent = Engine
						Smoke.Color = Color3.new(1/3,1/3,1/3)
						Smoke.Opacity = 0.7
						Smoke.RiseVelocity = 10
						Smoke.Size = 10
						Seat:BreakJoints()
					end
				end
			end
		end
	end
	if (Key == FlightControls.LockCam.Value) then
		LockedCam = (not LockedCam)
	end
	if (Key == WeaponControls.FireGuns.Value) then --If you press the fire guns key...
		if WeaponsValue.Value == true then --If there are weapons...
			if WeaponsValue.Guns.Value == true then --If there are guns...
				if EngineOn == true then
					local Taxiing = Taxi()
					if (not Taxiing) then --This prevents you from firing the gun while your on the ground
						FiringGun = true
						FireMachineGun(Weapons) --This activates the "FireMachineGun" function
					end
				end
			end
		end
	end
	if (Key == WeaponControls.FireRockets.Value) then --If you press the fire rockets key...
		if WeaponsValue.Value == true then
			if WeaponsValue.Rockets.Value == true then
				local Taxiing = Taxi()
				if (not Taxiing) then
					if RocketEnabled == true then
						RocketEnabled = false
						FireRockets(Weapons)
						ReloadRocket(RocketTime2)
					end
				end
			end
		end
	end
	if (Key == WeaponControls.DeployFlares.Value) then --If you press the deploy flares key...
		if WeaponsValue.Value == true then
			if WeaponsValue.Flares.Value == true then
				if EngineOn == true then
					local Taxiing = Taxi()
					if (not Taxiing) then
						if FlareEnabled == true then --This makes the plane deploy flares 5 times every 0.2 seconds before you have to reload
							FlareEnabled = false
							for i = 1,5 do
								DeployFlares(Weapons)
								wait(0.2)
							end
							ReloadFlare(FlareTime2)
						end
					end
				end
			end
		end
	end
	if (Key == WeaponControls.DropBombs.Value) then --If you press the drop bombs key...
		if WeaponsValue.Value == true then
			if WeaponsValue.Bombs.Value == true then
				if EngineOn == true then
					local Taxiing = Taxi()
					if (not Taxiing) then
						if BombEnabled == true then
							BombEnabled = false
							local BombSpawns = {}
							for i,v in pairs(Weapons:GetChildren()) do
								if v:IsA("BasePart") then
									if v.Name == "BombSpawn" then
										table.insert(BombSpawns,v)
									end
								end
							end
							local CurrentSpawn = BombSpawns[math.random(1,#BombSpawns)] --This line selects a random bomb spawn
							if Locked == true then
								DropGuidedBomb(CurrentSpawn)
								ReloadBomb((BombTime2 * 2))
							elseif Locked == false then
								for i = 1,5 do
									DropBomb(Weapons)
									wait(0.3)
								end
								ReloadBomb(BombTime2)
							end
						end
					end
				end
			end
		end
	end
	if (Key == WeaponControls.FireMissile.Value) then --If you press the fire missile key...
		if WeaponsValue.Value == true then
			if WeaponsValue.Missiles.Value == true then
				if EngineOn == true then
					local Taxiing = Taxi()
					if (not Taxiing) then
						if MissileEnabled == true then
							MissileEnabled = false
							local MissileSpawns = {}
							for i,v in pairs(Weapons:GetChildren()) do
								if v:IsA("BasePart") then
									if v.Name == "MissileSpawn" then
										table.insert(MissileSpawns,v)
									end
								end
							end
							local CurrentSpawn = MissileSpawns[math.random(1,#MissileSpawns)] --This line selects a random missile spawn
							if Locked == true then
								FireGuidedMissile(CurrentSpawn)
								ReloadMissile((MissileTime2 * 2))
							elseif Locked == false then
								FireMissile(CurrentSpawn)
								ReloadMissile(MissileTime2)
							end
						end
					end
				end
			end
		end
	end
	if (Key == TargetControls.UnTarget.Value) then --If you press the untarget key...
		if Targetable2 then
			if Locked == true then
				Locked = false
				if Tracer:findFirstChild("Weld") ~= nil then
					Tracer.Weld:remove()
					Tracer.Parent = game.Lighting
				end
			end
		end
	end
end

function onKeyUp(Key) --This function is activated when you let go of a key
	Key:lower()
	if SUAK == true and Key:byte() == SpeedUp2 or SUAK == false and (Key == SpeedUp2) then --If you let go of the speed up key...
		Accelerating = false
	end
	if SDAK == true and Key:byte() == SlowDown2 or SDAK == false and (Key == SlowDown2) then --If you let go of the slow down key...
		Decelerating = false
	end
	if (Key == WeaponControls.FireGuns.Value) then --If you let go of the fire guns key...
		FiringGun = false
	end
end

function onSelected(mouse) --This function is activated when you select the Plane tool
	mouse2 = mouse
	FixVars() --This activates the "FixVars" function
	GetGear(Gear) --This activates the "GetGear" function
	GetLowestPoint() --This activates the "GetLowestPoint" function
	ToolSelect.Value = true
	GuiClone = GUI:clone() --This line and the next one clones the plane gui and puts it into the player
	GuiClone.Parent = Player.PlayerGui
	SetUpGui() --This activates the "SetUpGui" function
	Camera.CameraType = CameraType2 --This makes your cameratype the customize cameratype
	if Targetable2 then --If the plane can target, then it will create the objects required for targeting
		Tracer = Instance.new("Part",game.Lighting)
		Tracer.Transparency = 1
		Tracer.Name = "Tracer"
		Tracer.Anchored = false
		Tracer.CanCollide = false
		Tracer.FormFactor = "Symmetric"
		Tracer.Size = Vector3.new(1,1,1)
		Tracer.BottomSurface,Tracer.TopSurface = "Smooth","Smooth"
		Tracer.ChildRemoved:connect(onTracerWeldRemoved)
		AimGui = Instance.new("BillboardGui",Player.PlayerGui)
		AimGui.AlwaysOnTop = NewTargeting.Value
		AimGui.Enabled = false
		AimGui.Size = UDim2.new(0,50,0,50)
		local Label = Instance.new("ImageLabel",AimGui)
		Label.BackgroundTransparency = 1
		Label.Image = "http://www.roblox.com/asset/?id=107388694"
		Label.Size = UDim2.new(1,0,1,0)
		LockGui = Instance.new("BillboardGui",Player.PlayerGui)
		LockGui.AlwaysOnTop = NewTargeting.Value
		LockGui.Enabled = false
		LockGui.Size = UDim2.new(0,50,0,50)
		local Label = Instance.new("ImageLabel",LockGui)
		Label.BackgroundTransparency = 1
		Label.Image = "http://www.roblox.com/asset/?id=107388656"
		Label.Size = UDim2.new(1,0,1,0)
	end
	mouse.Icon = NormalCursor
	FTab[1] = mouse.Move:connect(function() onMouseMoved(mouse) end) --Lines 1025-1029 activate the given functions
	FTab[2] = mouse.Idle:connect(function() onMouseMoved(mouse) end)
	FTab[3] = mouse.Button1Down:connect(function() onButton1Down(mouse) end)
	FTab[4] = mouse.KeyDown:connect(onKeyDown)
	FTab[5] = mouse.KeyUp:connect(onKeyUp)
	FTab[6] = RunService.RenderStepped:connect(UpdateCamera)
	Flying = true
	FlyMain(mouse) --This activates the "FlyMain" function
end

function onDeselected(mouse) --This function is activated when you deselect the Plane tool
	LockedCam = false
	for i,v in pairs(FTab) do --This disconnects all the connections. It prevents bugs
		if v then
			v:disconnect()
		end
	end
	Camera.CameraType = Enum.CameraType.Custom --This makes the CameraType "Custom"
	Camera.CameraSubject = Character.Humanoid
	if Targetable2 then --If the plane can target, then the objects required for targeting will be removed
		Tracer:Destroy()
		AimGui:remove()
		LockGui:remove()
	end
	if (not Taxi()) and EngineOn then --If you're not Taxiing and your engine is on...
		if (not Deselect0.Value) and (not Plane.Ejected.Value) then --If you deselected the tool and didn't eject...
			onDeselectFlying()
		end
	end
	CurrentSpeed = 0 --Lines 1041-1054 resets the plane, the plane gui, and the plane tool
	DesiredSpeed = 0
	TrueAirSpeed = 0
	Flying = false
	EngineOn = false
	Updating = false
	Locked = false
	Targeting = false
	TargetPlayer = nil
	ToolSelect.Value = false
	GuiAVisible = true
	GuiBVisible = true
	GuiClone:remove()
	Engine.Thrust.velocity = Vector3.new(0,0,0)
	Engine.Thrust.maxForce = Vector3.new(0,0,0)
	Engine.Direction.maxTorque = Vector3.new(0,0,0)
end

function onDeselectFlying() --This function blows up the plane
	if (not Deselect0.Value) then
		local Explosion = Instance.new("Explosion")
		Explosion.Parent = game.Workspace
		Explosion.Position = Engine.Position
		Explosion.BlastRadius = Plane:GetModelSize().magnitude
		Explosion.BlastPressure = 100000
		Character.Humanoid.Health = 0
		Engine.Thrust:remove()
		Engine.Direction:remove()
		coroutine.resume(coroutine.create(function()
			wait(5)
			Plane:Destroy()
		end))
	end
end

function onDeselectForced() --This function is activated when you get out of the plane without deselecting the tool first
	if Deselect0.Value == true then
		onDeselected()
		mouse2.Icon = "rbxasset://textures\\ArrowCursor.png" --This makes the mouse icon the normal icon
	end
end

script.Parent.Selected:connect(onSelected) --The next 3 lines activate the given functions
script.Parent.Deselected:connect(onDeselected)
Deselect0.Changed:connect(onDeselectForced)

--TurboFusion--