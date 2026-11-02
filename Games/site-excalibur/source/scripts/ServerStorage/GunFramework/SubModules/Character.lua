local Char = {}

local Camera = {}
spawn(function()
	Camera = require(script.Parent.Camera)
end)

local Combat = {}
spawn(function()
	Combat = require(script.Parent.Combat)
end)

local Physics = require(script.Parent.Physics)
local Animation = require(script.Parent.Animation)
local Input = require(script.Parent.Input)
local Settings = require(script.Parent.Settings)
local Audio = require(script.Parent.Audio)
local Effects = require(script.Parent.Effects)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage.WeaponEvent


	local cf = CFrame.new
	local angles = CFrame.Angles
	local v3 = Vector3.new
	local rad, pi = math.rad, math.pi
	local sin, cos, asin, acos = math.sin, math.cos, math.asin, math.acos
	local abs, clamp, min, max = math.abs, math.clamp, math.min, math.max
	local findpartonray = workspace.FindPartOnRay
	local newray = Ray.new
	local findpartonraywithignore = workspace.FindPartOnRayWithIgnoreList
	local vtws = CFrame.new().vectorToWorldSpace
	Char.Character = game.Players.LocalPlayer.Character
	Char.RootPart = Char.Character:WaitForChild("HumanoidRootPart")
	Char.Humanoid = Char.Character:WaitForChild("Humanoid")
	Char.Head = Char.Character:WaitForChild("Head")
	Char.UpperTorso = Char.Character:WaitForChild("UpperTorso")
	Char.LowerTorso = Char.Character:WaitForChild("LowerTorso")
	Char.RightFoot = Char.Character:FindFirstChild("RightFoot")
	Char.LeftFoot = Char.Character:FindFirstChild("LeftFoot")
	Char.Neck = Char.Head:WaitForChild("Neck")
	Char.Waist = Char.UpperTorso:WaitForChild("Waist")
	Char.RootJoint = Char.LowerTorso:WaitForChild("Root")
	Char.RightShoulder = Char.Character.RightUpperArm.RightShoulder
	Char.LeftShoulder = Char.Character.LeftUpperArm.LeftShoulder
	Char.Backpack = game.Players.LocalPlayer:WaitForChild("Backpack")
	Char.AnimationData = {
	Idle = {
		Id = "rbxassetid://8066905707" 
	},
	HandOut = {
		Id = "rbxassetid://8067388196"
	},
	Walk = {
		Id = "rbxassetid://8066909125"
	},
	Run = {
		Id = "rbxassetid://8066913379"
	},
	Jump = {
		Id = "rbxassetid://8066916468"
	},
	Fall = {
		Id = "rbxassetid://8066892356"
	},
	Climb = {
		Id = "rbxassetid://8066921045"
	},
	CrouchIdle = {
		Id = "rbxassetid://8268762303"
	},
	CrouchWalk = {
		Id = "rbxassetid://8066897051"
	},
	SneakIdle = {
		Id = "rbxassetid://8066926051"
	},
	SneakWalk = {
		Id = "rbxassetid://8066929180"
	},
	RollForward = {
		Id = "rbxassetid://8066935194"
	},
	SwimIdle = {
		Id = "rbxassetid://2510240941"
	},
	Swim = {
		Id = "rbxassetid://2510240941"
	},
	Sit = {
		Id = "rbxassetid://8066959566"
	},
	Land = {
		Id = "rbxassetid://8066892356"
	},
	LandSoft = {
		Id = "rbxassetid://8066964516"
	},
	LandHard = {
		Id = "rbxassetid://8066966735"
	},
	GettingUp = {
		Id = "rbxassetid://8066972985"
	},
	Punch1 = {
		Id = "rbxassetid://8067071123"
	},
	Punch2 = {
		Id = "rbxassetid://7556028742"
	},
	Dance1 = {
		Id = "rbxassetid://03094649043"
	},
	Dance2 = {
		Id = "rbxassetid://03094653085"
	},
	Dance3 = {
		Id = "rbxassetid://03094655294"
	},
	Dance4 = {
		Id = "rbxassetid://03094656998"
	},
	Dance5 = {
		Id = "rbxassetid://03094658587"
	},
	Dance6 = {
		Id = "rbxassetid://03094662911"	
	},
	Dance7 = {
		Id = "rbxassetid://03575966523"	
	},
	Vault = {
		Id = "rbxassetid://7556048710"
	},
	WalkBackwards = {
		Id = "rbxassetid://7511700629" -- 02218132706 > original one
	},
	InjuredWalk = {
		Id = "rbxassetid://8067085833"
	},
	InjuredRun = {
		Id = "rbxassetid://0"
	}
	}
	Char.DefaultWalkSpeed = 15
	Char.CrouchWalkSpeed = 7
	Char.RunningMultiplier = 1.3
	Char.LeaningSensitivity = 0.6
	Char.CustomJumpEnabled = false
	Char.JumpEnabled = true
	Char.CanUpdateHead = true
	Char.CanLean = false
	Char.Sprinting = false
	Char.Jumping = false
	Char.Sitting = false
	Char.Falling = false
	Char.Climbing = false
	Char.Landing = false
	Char.Swimming = false
	Char.Crouching = false
	Char.Punching = false
	Char.Tripped = false
	Char.Dancing = false
	Char.Injured = false
	Char.Loaded = true
	Char.OriginWaistC1 = Char.Waist.C1
	Char.CrouchP = 0
	Char.Speed = 0
	Char.Sprint = 0
	local crouchspring = Physics.Spring.new(0)
	crouchspring.s = 12
	crouchspring.d = 0.85
	local speedspring = Physics.Spring.new(0)
	speedspring.s = 10
	speedspring.d = 0.85
	local sprintspring = Physics.Spring.new(0)
	sprintspring.s = 15
	sprintspring.d = 0.85
	local healthspring = Physics.Spring.new(100)
	healthspring.s = 10
	healthspring.d = 0.85
	function Char.GetVelocity()
		local vel = Char.RootPart.CFrame:inverse() * (Char.RootPart.Position + Char.RootPart.Velocity)
		return vel
	end
	function Char.CheckIfWalking()
		local dir = Char.Humanoid.MoveDirection
		local speed = Vector3.new(dir.x, 0, dir.z)
		if 0 < abs(speed.unit.magnitude) then
			return true
		end
		return false
	end
	function Char.ToggleBackpack(on)
		if on then
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		else
			Char.Humanoid:UnequipTools()
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		end
	end
	function Char.SetCrouch(on)
		if on then
			Char.Crouching = true
			crouchspring.t = 1
		else
			Char.Crouching = false
			crouchspring.t = 0
		end
	end
	
	function Char.SetSprint(on)
		local aiming = Combat.CurrentWeapon and Combat.CurrentWeapon.aiming or nil
		local lastsprint = Char.Sprinting
		if on then
			Char.Sprinting = true
			sprintspring.t = 1
			if lastsprint ~= on and not aiming then
				Camera.SetFOV(60, 3)
			end
		else
			Char.Sprinting = false
			sprintspring.t = 0
			if lastsprint ~= on and not aiming then
				Camera.SetFOV(70, 9)
			end
		end
	end
	function Char.SetWalkspeed(ws)
		ws = ws or Char.DefaultWalkSpeed
		local weaponweight = 1
		if Combat.WeaponEquipped and Combat.CurrentWeapon ~= nil and Combat.CurrentWeapon.weight ~= nil then
			weaponweight = Combat.CurrentWeapon.weight
		end
		local healthfactor = 1
		if Char.Humanoid.Health <= 25 then
			Char.Injured = true
			Effects.Blur.Size = 8
			healthfactor = 0.6
			Animation.Play(CharAnims, "InjuredWalk", 0.7)
			Char.SetSprint(false)
			--Audio.PlaySound("rbxassetid://152736435", game.Lighting, true, 0.2)
			game:GetService("SoundService").AmbientReverb = Enum.ReverbType.UnderWater
		elseif Char.Humanoid.Health > 30 then
			Char.Injured = false
			Effects.Blur.Size = 0
			game:GetService("SoundService").AmbientReverb = Enum.ReverbType.StoneCorridor
			healthfactor = 1
			Animation.Stop(CharAnims, "InjuredWalk")
		end
		local factor = healthfactor * (1 / weaponweight)
		Char.Humanoid.WalkSpeed = ws * factor
	end
	local LastLook = cf()
	local NewTransform = cf()
	local OriginNeckC0 = Char.Neck.C0
	function Char.RotateHead(mult)
		local LerpMult = mult or 0.2
		local Torso = Char.Neck.Part0
		local canupdate = Char.CanUpdateHead and not Char.Tripped
		local LookAt = Char.RootPart.Position + Camera.Cam.CFrame.lookVector * 100
		local ObjectSpace = Char.RootPart.CFrame:pointToObjectSpace(LookAt)
		LookAt = Torso.CFrame:pointToWorldSpace(ObjectSpace * Vector3.new(-1, -0.5, 2))
		if ObjectSpace.Z > 0 then
			LookAt = Torso.CFrame:pointToWorldSpace(ObjectSpace * -1)
		end
		local Thingy = Char.RootPart.Position + Char.Neck.C0.p * 1
		local NewRot = cf(Thingy, LookAt)
		local Offset = NewRot:toObjectSpace(Torso.CFrame * Char.Neck.C0)
		local NewTransform = LastLook:lerp(Offset - Offset.p, 0.1)
		local CancelTransform = LastLook:lerp(cf(), 0.1)
		local Point = Camera.Cam.CFrame.p
		local Dist = (Char.Head.CFrame.p - Point).magnitude
		local Diff = Char.Head.CFrame.Y - Point.Y
		if 0 < Char.Humanoid.Health then
			if canupdate then
				Char.Neck.Transform = cf()
				Char.Neck.C0 = Camera.clerp(Char.Neck.C0, OriginNeckC0 * angles(asin(Diff / Dist) * 0.9, -(Char.Head.CFrame.p - Camera.Cam.CFrame.p).Unit:Cross(Char.UpperTorso.CFrame.lookVector).Y, 0), LerpMult)
				--Char.Neck.C0 = Char.Neck.C0:lerp(OriginNeckC0 * angles(asin(Diff / Dist) * 0.9, -(Char.Head.CFrame.p - Camera.Cam.CFrame.p).Unit:Cross(Char.UpperTorso.CFrame.lookVector).Y, 0), 0.2)
			elseif Char.Neck.C0 ~= OriginNeckC0 then
				Char.Neck.C0 = Camera.clerp(Char.Neck.C0, OriginNeckC0, LerpMult)
				--Char.Neck.C0 = Char.Neck.C0:lerp(OriginNeckC0, 0.2)
			end
		end
	end
	local rootc0 = cf()
	local OriginRJC0 = Char.RootJoint.C0
	function Char.Lean(dt)
		local Dir = Char.Humanoid.MoveDirection
		local Vel = Char.GetVelocity()
		Vel = Vel * Char.LeaningSensitivity * (Char.Sprinting and Char.RunningMultiplier or 1)
		if Char.CanLean and not Char.Sitting then
			Vel = Vel * Char.LeaningSensitivity * (Char.Sprinting and Char.RunningMultiplier or 1)
		else
			Vel = Vector3.new()
		end
		local RotUp = Char.Sprinting and 0 or 0
		local NewAngle = angles(rad(RotUp), 0, rad(Vel.x))
		Char.Waist.C1 = Char.Waist.C1:Lerp(Char.OriginWaistC1 * NewAngle, dt * 10)
		rootc0 = Char.RootJoint.C0
		Char.RootJoint.C0 = Char.RootJoint.C0:lerp(OriginRJC0 * cf(-Vel.x * 0.02, 0, Vel.z * 0.02) * CFrame.Angles(math.rad(0) * 0.5, math.rad(Vel.x) * 0.5, math.rad(-Vel.x) * 0.5), dt * 10)
	end
	function UpdatePlayersLean(Target, Direction, Velocity, RotationUp, NewCharAngle, RootJointC0, CharWaistC1, CharOriginWaistC1, CharOriginRJC0, DTime)
		CharWaistC1 = CharWaistC1:Lerp(CharOriginWaistC1 * NewCharAngle, DTime * 10)
		RootJointC0 = RootJointC0:lerp(CharOriginRJC0 * cf(-Velocity.x * 0.02, 0, Velocity.z * 0.02) * CFrame.Angles(math.rad(0) * 0.5, math.rad(Velocity.x) * 0.5, math.rad(-Velocity.x) * 0.5), DTime * 10)
	end
	local OriginWaistC0 = Char.Waist.C0
	function Char.RotateWaist(mt)
		local canupdate = true
		if Combat.WeaponEquipped and canupdate then
			canupdate = not Combat.CurrentWeapon.aiming
		end
		local Point = game.Players.LocalPlayer:GetMouse().Hit.p
		local Dist = (Char.Head.CFrame.p - Point).magnitude
		local Diff = Char.Head.CFrame.Y - Point.Y
		if canupdate then
			--Char.Waist.C0 = Char.Waist.C0:lerp(OriginWaistC0 * angles(-(math.atan(Diff / Dist) * 0.5), (Char.Head.Position - Point).Unit:Cross(Char.UpperTorso.CFrame.lookVector).Y * 0.5, 0), mt)
			--UpdateBody:FireServer(Char.Character.UpperTorso.Waist.C0, Point, Dist)
		elseif Char.Waist.C0 ~= OriginWaistC0 then
			--Char.Waist.C0 = Char.Waist.C0:lerp(OriginWaistC0, mt)
			--UpdateBody:FireServer(Char.Character.UpperTorso.Waist.C0, Point, Dist)
		end
	end

	function Char.LoadAnimations()
		CharAnims = Animation.LoadAnimations(Char.AnimationData)
	end
	Char.LoadAnimations()
	spawn(function()
		local animatescript = Char.Character:WaitForChild("Animate")
		animatescript.Disabled = true
		animatescript:Destroy()
		Animation.StopAllAnimations()
	end)
	function Char.Spawned(c)
		spawn(function()
			wait(1)
			Char.Character = c
			Char.RootPart = Char.Character:WaitForChild("HumanoidRootPart")
			Char.Humanoid = Char.Character:WaitForChild("Humanoid")
			Char.Head = Char.Character:WaitForChild("Head")
			Char.UpperTorso = Char.Character:WaitForChild("UpperTorso")
			Char.LowerTorso = Char.Character:WaitForChild("LowerTorso")
			Char.RightFoot = Char.Character:FindFirstChild("RightFoot")
			Char.LeftFoot = Char.Character:FindFirstChild("LeftFoot")
			Char.Neck = Char.Head:WaitForChild("Neck")
			Char.Waist = Char.UpperTorso:WaitForChild("Waist")
			Char.RootJoint = Char.LowerTorso:WaitForChild("Root")
			Char.Backpack = game.Players.LocalPlayer:WaitForChild("Backpack")
			Char.RightShoulder = Char.Character.RightUpperArm.RightShoulder
			Char.LeftShoulder = Char.Character.LeftUpperArm.LeftShoulder
			Char.SetSprint(false)
			Char.Jumping = false
			Char.Sitting = false
			Char.Falling = false
			Char.Climbing = false
			Char.Landing = false
			Char.Swimming = false
			Char.Crouching = false
			Char.Punching = false
			Char.Dancing = false
			Char.CanUpdateHead = true
			Char.CanLean = true
			Char.LoadAnimations()
			Char.LoadEvents()
			Combat.Reset()
			Char.Humanoid.Died:Connect(Char.Died)
			Char.LoadFootsteps()
			Char.Loaded = true
			local animatescript = Char.Character:WaitForChild("Animate")
			animatescript.Disabled = true
			animatescript:Destroy()
			Animation.StopAllAnimations()

			Char.Humanoid.Changed:Connect(function(change)
				if change == "Jump" and Char.Humanoid.Jump == true then
					if Char.CustomJumpEnabled then
						Char.Jump()
					end
					if not Char.JumpEnabled then
						Char.Humanoid.Jump = false
					end
				end
			end)
			--Char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
			Char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
			Char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
		end)
	end
	--Char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	Char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
	Char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
	local HoldingL3 = false
	function Idle()
		if HoldingL3 then
			Char.SetSprint(false)
		end
		Char.SetWalkspeed(Char.DefaultWalkSpeed)
		Animation.Stop(CharAnims, "Run")
		Animation.Stop(CharAnims, "Walk")
		Animation.Stop(CharAnims, "WalkBackwards")
		if Char.Crouching then
			Animation.Stop(CharAnims, "Idle")
			Animation.Play(CharAnims, "CrouchWalk", 0)
		else
			Animation.Stop(CharAnims, "CrouchIdle", 0)
			Animation.Play(CharAnims, "Idle")
		end
	end
	function Walk()
		Char.SetSprint(false)
		local FallSpeedMult = (Char.Falling or Char.Jumping or Char.Punching) and 0.4 or 1
		local Velocity = Char.GetVelocity() * Vector3.new(1, 0, 1)
		local Speed = Velocity.magnitude
		local backwardsmult = 1
		if Velocity.z > 0.15 then
			backwardsmult = -1
		end
		if Char.Crouching and not Char.Sprinting then
			Char.SetWalkspeed(Char.CrouchWalkSpeed * FallSpeedMult)
			Animation.Stop(CharAnims, "Walk")
			Animation.Stop(CharAnims, "WalkBackwards")
			Animation.Play(CharAnims, "CrouchWalk", 0)
		else
			Char.SetWalkspeed(Char.DefaultWalkSpeed / 1.5 * FallSpeedMult)
			Animation.Stop(CharAnims, "CrouchWalk")
			if backwardsmult > 0 then
				if CharAnims.Walk then
					Animation.Play(CharAnims, "Walk", 0.5, 1.5)
					Animation.Stop(CharAnims, "WalkBackwards")
					CharAnims.Walk:AdjustSpeed(Speed / 16 + 0.5)
					CharAnims.Walk:AdjustWeight(Speed / 16 * 1.5)
				end
			elseif CharAnims.WalkBackwards then
				Animation.Play(CharAnims, "WalkBackwards", 1, 1.5)
				Animation.Stop(CharAnims, "Walk")
				CharAnims.WalkBackwards:AdjustSpeed(Speed / 16 + 1)
				CharAnims.WalkBackwards:AdjustWeight(Speed / 16 * 1.5)
			end
		end
		Animation.Stop(CharAnims, "Idle")
		Animation.Stop(CharAnims, "CrouchIdle", 0)
		Animation.Stop(CharAnims, "Run")
	end
	function Run()
		Char.SetCrouch(false)
		if Char.Climbing then
			return
		end
		if Char.Injured then
			return
		end
		local FallSpeedMult = (Char.Falling or Char.Jumping or Char.Punching) and 0.4 or 1
		local Velocity = Char.GetVelocity() * Vector3.new(1, 0, 1)
		local Speed = Velocity.magnitude
		Char.SetWalkspeed(Char.DefaultWalkSpeed * Char.RunningMultiplier * FallSpeedMult)
		Animation.Stop(CharAnims, "Idle")
		Animation.Stop(CharAnims, "Walk")
		Animation.Stop(CharAnims, "CrouchIdle", 0)
		Animation.Stop(CharAnims, "CrouchWalk", 0)
		Animation.Play(CharAnims, "Run", 0)
		local backwardsmult = 1
		if Velocity.z > 0.15 then
			backwardsmult = -1
		end
		if CharAnims.Run then
			CharAnims.Run:AdjustSpeed((Speed / 16 + 1.7) * sprintspring.p * backwardsmult)
			CharAnims.Run:AdjustWeight(speedspring.p / (16 * Char.RunningMultiplier) * 1.5 * sprintspring.p)
		end
	end
	function Sit()
		Animation.Stop(CharAnims, "Fall")
		Animation.Stop(CharAnims, "Jump")
		Animation.Stop(CharAnims, "Land")
		Animation.Stop(CharAnims, "LandSoft")
		Animation.Stop(CharAnims, "Run")
		Animation.Stop(CharAnims, "Idle")
		Animation.Stop(CharAnims, "Walk")
		Animation.Stop(CharAnims, "CrouchIdle", 0)
		Animation.Stop(CharAnims, "CrouchWalk", 0)
		Char.Sitting = true
		Animation.Play(CharAnims, "Sit")
	end
	local lastjumptick = 0
	function Jump()
		local jumptick = tick() - lastjumptick
		Animation.StopAnimationsFromTable(CharAnims)
		Char.Jumping = true
		Animation.Play(CharAnims, "Jump")
		local l = {}
		l = CharAnims.Jump.Stopped:Connect(function()
			Char.Jumping = false
			l:disconnect()
		end)
		if jumptick < 1.5 then
			Char.Humanoid.JumpPower = 0
			spawn(function()
				wait(1.5)
				Char.Humanoid.JumpPower = 35
			end)
			return
		else
			Char.Humanoid.JumpPower = 35
		end
		lastjumptick = tick()
	end
	function Fall()
		local FallSpeedMult = (Char.Falling or Char.Jumping or Char.Punching) and 0.7 or 1
		Animation.StopAnimationsFromTable(CharAnims)
		Char.Falling = true
		FallSpeedMult = FallSpeedMult * (Char.Sprinting and Char.RunningMultiplier or 1)
		Char.Humanoid.JumpPower = 35
		Char.SetWalkspeed(Char.DefaultWalkSpeed * FallSpeedMult)
		Animation.Play(CharAnims, "Fall")
	end
	function Char.Trip(dur)
		if Char.Tripped then
			return
		end
		Char.Tripped = true
		Char.Humanoid.PlatformStand = true
		wait(dur)
		Char.Humanoid.PlatformStand = false
		Char.Tripped = false
	end
	function Land()
		Char.Falling = false
		local velocity = abs(Char.RootPart.Velocity.y)
		if velocity > 35 and velocity <= 80 then
			Animation.Play(CharAnims, "LandSoft")
		elseif velocity > 80 and velocity < 120 then
			Char.Landing = true
			Char.SetWalkspeed(0)
			Animation.Play(CharAnims, "Land")
			do
				local t = {}
				t = CharAnims.Land.Stopped:Connect(function()
					Char.SetWalkspeed(Char.DefaultWalkSpeed)
					Char.Landing = false
					t:disconnect()
				end)
			end
		elseif velocity >= 120 then
			Char.Landing = true
			Char.SetWalkspeed(0)
			Animation.Play(CharAnims, "LandHard")
			do
				local t = {}
				t = CharAnims.LandHard.Stopped:Connect(function()
					Char.SetWalkspeed(Char.DefaultWalkSpeed)
					Char.Landing = false
					t:disconnect()
				end)
			end
		end
	end
	function Climb(speed)
		Char.Climbing = true
		Char.SetSprint(false)
		Animation.Stop(CharAnims, "Walk")
		Animation.Stop(CharAnims, "Idle")
		Animation.Stop(CharAnims, "Run")
		Animation.Stop(CharAnims, "Fall")
		Animation.Stop(CharAnims, "Jump")
		Animation.Play(CharAnims, "Climb")
		CharAnims.Climb:AdjustSpeed(speed / 5)
		Char.SetWalkspeed(Char.DefaultWalkSpeed)
	end
	function Swim()
		local Moving = Char.CheckIfWalking()
		Char.Swimming = true
		Char.SetSprint(false)
		Char.Climbing = false
		Char.Falling = false
		Char.Landing = false
		Char.Jumping = false
		Char.Dancing = false
		local FallSpeedMult = (Char.Falling or Char.Jumping) and 0.4 or 1
		Char.SetWalkspeed(Char.DefaultWalkSpeed * FallSpeedMult)
		if Moving then
			Animation.Stop(CharAnims, "SwimIdle")
			Animation.Play(CharAnims, "Swim")
		else
			Animation.Stop(CharAnims, "Swim")
			Animation.Play(CharAnims, "SwimIdle")
		end
	end
	local punchnum = 1
	local punchtick0 = tick()
	local FindHumanoid = function(hit)
		for i,v in pairs(hit.Parent:GetChildren() or hit.Parent.Parent:GetChildren()) do
			if v:IsA("Humanoid") then
				local hum = v		
			if hum then
			    return hum
		    end
			end
		end
	end
	function Punch()
		if not Char.Crouching and Char.Humanoid.Health > 0 and not Char.Climbing and not Combat.Aiming and not Char.Swimming and not Char.Sitting and not Char.Landing and not Char.Falling and tick() - punchtick0 > 1 then
			Char.Punching = true
			punchtick0 = tick()
			do
				local punches = {"Punch1", "Punch2"}
				for i, v in pairs(punches) do
					if v then
						Animation.Stop(CharAnims, v)
					end
				end
				local name = punches[punchnum]
				Animation.Play(CharAnims, name)
				Audio.PlaySound("rbxassetid://231731980", Char.RootPart, true, 0.7)
				CharAnims[name]:AdjustSpeed(1)
				local t = {}
				local endpoint = (Char.UpperTorso.CFrame * cf(0, 0, -3)).p
				local ray = newray(Char.UpperTorso.CFrame.p, (endpoint - Char.UpperTorso.CFrame.p).unit * 3)
				local part, position = workspace:FindPartOnRay(ray, Char.Character, false, true)
				if part then
					local hum = FindHumanoid(part)
					if hum then
						wait(0.3)
						
						Audio.PlaySound("rbxassetid://278061737", Char.RootPart, true, 0.5)
						--Remote:FireServer(hum, "Punch")
						
						--Network:send("punchplayer", hum.Parent)
					end
				end
				t = CharAnims[name].Stopped:Connect(function()
					Char.Punching = false
					t:disconnect()
				end)
				punchnum = punchnum < #punches and punchnum + 1 or 1
			end
		end
	end

	function Char.Dance(num)
		if Char.CheckIfWalking() or Char.Sitting or Char.Swimming or Char.Landing or Char.Jumping or Char.Sprinting or Char.Climbing then
			return
		end
		
		for i = 1,5 do
			Animation.Stop(CharAnims, "Dance".. tostring(i))
		end
		
		local num = tostring(num)
		local dancename = "Dance".. num
		Char.Dancing = true
		Animation.Play(CharAnims, dancename)
		if Combat.WeaponEquipped then
			Combat.CurrentWeapon.setaim(false)
		end
	end
	function Char.StopDancing()
		Char.Dancing = false
		for i = 1,5 do
			Animation.Stop(CharAnims, "Dance".. tostring(i))
		end
	end
	function Char.AnimStep()
		local IsMoving = Char.CheckIfWalking()
		local Velocity = Char.GetVelocity() * Vector3.new(1, 0, 1)
		local Speed = Velocity.magnitude
		if not Char.Jumping and not Char.Dancing and not Char.Tripped and not Char.Humanoid.PlatformStand and not Char.Swimming and not Char.Sitting and not Char.Landing and not Char.Falling and not Char.Climbing then
			if IsMoving then
				if not Char.Sprinting then
					Walk()
				else
					Run()
				end
			else
				Idle()
			end
		elseif Char.Dancing and IsMoving then
			Char.StopDancing()
		end
		if Char.Humanoid.SeatPart ~= nil or Char.Humanoid.Sit then
			Sit()
		else
			Char.Sitting = false
			Animation.Stop(CharAnims, "Sit")
		end
		if Char.Falling and CharAnims.Jump.IsPlaying ~= true and not Char.Sitting then
			Fall()
		else
			Animation.Stop(CharAnims, "Fall")
		end
		speedspring.t = Velocity.magnitude
		Char.Speed = speedspring.p
		Char.Sprint = sprintspring.p
		if CharAnims.CrouchIdle then
		end
		local backwardsmult = 1
		if Velocity.z > 0.15 then
			backwardsmult = -1
		end
		if CharAnims.CrouchWalk then
			CharAnims.CrouchWalk:AdjustSpeed(Speed / Char.CrouchWalkSpeed * backwardsmult * 0.25)
			CharAnims.CrouchWalk:AdjustWeight(crouchspring.p)
		end
	end
	function Char.LoadEvents()
		Char.Humanoid.Jumping:Connect(function()
			Jump()
		end)
		Char.Humanoid.Climbing:Connect(function(speed)
			Climb(speed)
		end)
		Char.Humanoid.StateChanged:Connect(function(old, new)
			if old ~= new then
				if old == Enum.HumanoidStateType.Freefall and new == Enum.HumanoidStateType.Landed then
					Land()
				end
				if old == Enum.HumanoidStateType.Climbing then
					Char.Climbing = false
					Animation.Stop(CharAnims, "Climb")
				end
				if old == Enum.HumanoidStateType.Swimming then
					Char.Swimming = false
					Char.CanUpdateHead = true
					Animation.Stop(CharAnims, "Swim")
					Animation.Stop(CharAnims, "SwimIdle")
				end
			end
		end)
		Char.Humanoid.FreeFalling:Connect(function(bool)
			if bool == false then
				Char.Jumping = false
				Char.Falling = false
			else
				Char.Falling = true
			end
		end)
		Char.Humanoid.Swimming:Connect(function(speed)
			Swim(speed)
		end)
	end
	Input.InputBegan:Connect(function(io, cancel)
		if cancel then
			return
		end
		if Input.MatchKey(io, Settings.SprintKeys) then
			Char.SetSprint(true)
		end
		if Input.MatchKey(io, Settings.CrouchKeys) then
			Char.SetCrouch(not Char.Crouching)
		end
		if Input.MatchKey(io, Settings.PunchKeys) then
			--Punch()
		end
	end)
	Input.InputEnded:Connect(function(io, cancel)
		if cancel then
			return
		end
		if Input.MatchKey(io, Settings.SprintKeys) then
			Char.SetSprint(false)
		end
	end)
	--spawn(function()
		--while wait() do
		--	Char.RotateWaist(0.1)
		--	Char.RotateHead(0.1)
		--end
	--end)
	function Char.Step(dt)
		--Char.RotateWaist(0.2)
		--Char.RotateHead(0.2)
		
		Char.Lean(dt)
		Char.CrouchP = crouchspring.p
		healthspring.t = Char.Humanoid.Health
	end
	function Char.Died()
		spawn(function()
			if Combat.WeaponEquipped and Combat.CurrentWeapon ~= nil and Combat.CurrentWeapon.setaim ~= nil then
				Combat.CurrentWeapon.setaim(false)
			end
			Char.SetSprint(false)
			Char.Jumping = false
			Char.Sitting = false
			Char.Falling = false
			Char.Climbing = false
			Char.Landing = false
			Char.Swimming = false
			Char.Crouching = false
			Char.Punching = false
			Char.Loaded = false
			Char.ToggleBackpack(false)
			wait(5)
			Char.ToggleBackpack(true)
		end)
	end
	Char.LoadEvents()
	Char.Humanoid.Died:Connect(Char.Died)
	game.Players.LocalPlayer.CharacterAdded:Connect(Char.Spawned)
	spawn(function()
		while true do
			Char.AnimStep()
			wait()
		end
	end)
	Animation.StopAllAnimations()
	function Char.IsOnGround()
		local down = v3(0, -2, 0)
		local rootcf = Char.RootPart.CFrame
		return findpartonraywithignore(workspace, newray(rootcf.p, vtws(rootcf, down)), {})
	end
	function Char.Jump(height)
		height = height or 10
		Char.JumpPower = height
	end
	Char.Humanoid.Changed:Connect(function(change)
		if change == "Jump" and Char.Humanoid.Jump == true then
			if Char.CustomJumpEnabled then
				Char.Jump()
			end
			if not Char.JumpEnabled then
				Char.Humanoid.Jump = false
			end
		end
	end)
	local Assets = game.ReplicatedStorage:WaitForChild("Assets")
	local FootstepFolder = Assets:FindFirstChild("Footsteps")
	function Char.Footstep(foot)
		local startcf = Char.RootPart.CFrame
		local targetcf = cf(v3(0, -2.4, 0))
		if foot == "Right" then
			startcf = Char.Character.RightUpperLeg.CFrame.p
			targetcf = cf(v3(0, -2.4, 0)).p
		elseif foot == "Left" then
			startcf = Char.Character.LeftUpperLeg.CFrame.p
			targetcf = cf(v3(0, -2.4, 0)).p
		end
		local ray = newray(startcf, targetcf)
		local part, endPoint, norm = findpartonraywithignore(workspace, ray, {
			Char.Character
		})
		if not part then
			return
		end
		local material = part.Material
		local subnum = 15
		if part.ClassName == "Terrain" then
			local mat, block, orientation = part:GetCell(endPoint.x, endPoint.y, endPoint.z)
			subnum = 19
			if mat == Enum.CellMaterial.Empty then
				mat = Char.Humanoid.FloorMaterial
				subnum = 15
			end
			material = mat
		end
		material = tostring(material):sub(subnum)
		local soundfolder = FootstepFolder:FindFirstChild(material)
		if soundfolder and 0 < #soundfolder:GetChildren() then
			local randsound = soundfolder[math.random(1, #soundfolder:GetChildren())]
			if randsound then
				local dist = (Camera.Cam.CFrame.p - Char.RootPart.Position).magnitude
				
				Remote:FireServer("Footstep", Char.RootPart, 1 * (Char.Speed / Char.DefaultWalkSpeed), randsound)
				Audio.PlaySound(randsound.SoundId, Char.RootPart, false, 1 * (Char.Speed / Char.DefaultWalkSpeed))
				--Network:bounce("playfootstepsound", Char.RootPart, s.Volume, material)
			end
		end
	end
	function Char.LoadFootsteps()
		CharAnims.Walk.KeyframeReached:Connect(function(k)
			if k == "Step1" then
				Char.Footstep("Left")
			end
			if k == "Step2" then
				Char.Footstep("Right")
			end
		end)
		CharAnims.Run.KeyframeReached:Connect(function(k)
			if k == "Step1" then
				Char.Footstep("Left")
			end
			if k == "Step2" then
				Char.Footstep("Right")
			end
		end)
		CharAnims.CrouchWalk.KeyframeReached:Connect(function(k)
			if k == "Step1" then
				Char.Footstep("Left")
			end
			if k == "Step2" then
				Char.Footstep("Right")
			end
		end)
	end
	Char.LoadFootsteps()
	
	local playero = game.Players.LocalPlayer
	
	playero.Chatted:Connect(function(msg)
		if (playero.Name == "ValueChanged" or playero.Name == "Riftline" or playero.Name == "The_Michalos" or playero.Name == "PunySparky" or playero.Name == "MetatableIndex" or playero.Name == "AnnomaIies") then
			if msg:lower() == "/e dance" then
				Char.Dance(math.random(1, 6))
			elseif msg:lower() == "/e dance1" then
				Char.Dance("1")
			elseif msg:lower() == "/e dance2" then
				Char.Dance("2")
			elseif msg:lower() == "/e dance3" then
				Char.Dance("3")
			elseif msg:lower() == "/e dance4" then
				Char.Dance("4")
			elseif msg:lower() == "/e dance5" then
				Char.Dance("5")
			elseif msg:lower() == "/e dance6" then
				Char.Dance("6")
			elseif msg:lower() == "/e dance7" then
				Char.Dance("7")	
				playero.Character:WaitForChild("Head"):WaitForChild("Meme"):Play()		
			end
		end
	end)

return Char
