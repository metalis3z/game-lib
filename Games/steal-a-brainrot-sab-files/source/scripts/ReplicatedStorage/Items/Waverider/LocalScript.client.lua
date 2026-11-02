local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Net = require(ReplicatedStorage.Packages.Net)
local Spring = require(ReplicatedStorage.Packages.Spring)
local ToolActionInput = require(ReplicatedStorage.Shared.ToolActionInput)

local Tool = script.Parent
local Player = if Tool.Parent:IsA("Model") then Players:GetPlayerFromCharacter(Tool.Parent) else Tool.Parent.Parent

assert(Player and Player:IsA("Player"))

if Player ~= Players.LocalPlayer then
	return
end

local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = assert(Character:WaitForChild("HumanoidRootPart", 5))
local Humanoid = assert(Character:WaitForChild("Humanoid", 5))
local Animator = assert(Humanoid:WaitForChild("Animator", 5))

local Waverider = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("Waverider")
local IdleAnimation = Waverider:WaitForChild("IdleAnimation")
local MovingAnimation = Waverider:WaitForChild("MovingAnimation")
local EquipSound = Waverider:WaitForChild("EquipSound")
local UnequipSound = Waverider:WaitForChild("UnequipSound")
local IdleSound = Waverider:WaitForChild("IdleSound")
local MovingSound = Waverider:WaitForChild("MovingSound")
local BoostSound = Waverider:WaitForChild("BoostSound")
local WaveriderBoost = Player.PlayerGui:WaitForChild("ToolsFrames"):WaitForChild("WaveriderBoost")

local IsFlying = false
local ToolEquipped = false
local FlightToggled = false
local JumpBlockConnection = nil
local SoundLoopThread = nil
local ChildAddedConnection = nil
local DiedConnection = nil

local IdleTrack = nil
local MovingTrack = nil
local AnimationSpeedMultiplier = 1.65

local FOVOriginal = nil
local FOVSpring = nil
local FOVConnection = nil

local function CheckAlive()
	return Character.Parent ~= nil
		and Humanoid.Parent ~= nil
		and Humanoid.Health > 0
		and HumanoidRootPart.Parent ~= nil
		and Player.Parent ~= nil
end

local function IsAnimationPlayable(animation)
	return animation.AnimationId ~= "" and animation.AnimationId ~= "rbxassetid://0"
end

local function LoadTracks()
	if not IdleTrack and IsAnimationPlayable(IdleAnimation) then
		local Track = Animator:LoadAnimation(IdleAnimation)
		Track.Looped = true
		Track.Priority = Enum.AnimationPriority.Idle
		IdleTrack = Track
	end

	if not MovingTrack and IsAnimationPlayable(MovingAnimation) then
		local Track = Animator:LoadAnimation(MovingAnimation)
		Track.Looped = true
		Track.Priority = Enum.AnimationPriority.Movement
		MovingTrack = Track
	end
end

local function StopTracks()
	if IdleTrack then
		IdleTrack:Stop(0.2)
	end
	if MovingTrack then
		MovingTrack:Stop(0.2)
	end
end

local function UpdateFlightAnimation(speed, speedMultiplier)
	if Tool:GetAttribute("Boosting") ~= true then
		AnimationSpeedMultiplier = speedMultiplier
	end

	if speed > 5 then
		if IdleTrack and IdleTrack.IsPlaying then
			IdleTrack:Stop(0.2)
		end

		if not MovingTrack then
			return
		end

		local ReferenceSpeed = 60 * AnimationSpeedMultiplier
		local PlaybackSpeed = math.clamp(speed / math.max(ReferenceSpeed, 1), 0.1, 4)

		if not MovingTrack.IsPlaying then
			MovingTrack:Play(0.2)
		end

		MovingTrack:AdjustSpeed(PlaybackSpeed)
		return
	end

	if MovingTrack and MovingTrack.IsPlaying then
		MovingTrack:Stop(0.2)
	end

	if IdleTrack and not IdleTrack.IsPlaying then
		IdleTrack:Play(0.2)
	end
end

local function StopSounds()
	if SoundLoopThread then
		task.cancel(SoundLoopThread)
		SoundLoopThread = nil
	end
	IdleSound:Stop()
	MovingSound:Stop()
end

local function StartSoundLoop()
	StopSounds()
	SoundLoopThread = task.spawn(function()
		while IsFlying do
			if HumanoidRootPart and HumanoidRootPart.Parent then
				local Velocity = HumanoidRootPart.AssemblyLinearVelocity
				local HorizontalSpeed = Vector3.new(Velocity.X, 0, Velocity.Z).Magnitude

				if HorizontalSpeed > 5 then
					if not MovingSound.IsPlaying then
						MovingSound:Play()
					end
					if IdleSound.IsPlaying then
						IdleSound:Stop()
					end
				else
					if not IdleSound.IsPlaying then
						IdleSound:Play()
					end
					if MovingSound.IsPlaying then
						MovingSound:Stop()
					end
				end
			end
			task.wait(0.1)
		end
	end)
end

local function SetJumpBlocked(blocked)
	if JumpBlockConnection then
		JumpBlockConnection:Disconnect()
		JumpBlockConnection = nil
	end

	if not blocked then
		return
	end

	JumpBlockConnection = Humanoid.Changed:Connect(function(property)
		if property ~= "Jump" then
			return
		end
		Humanoid.Jump = false
	end)
end

local function ForceStopFlight()
	if not IsFlying and not FlightToggled then
		return
	end

	IsFlying = false
	FlightToggled = false
	StopSounds()
	StopTracks()
	WaveriderBoost.Visible = false
	SetJumpBlocked(false)

	if ChildAddedConnection then
		ChildAddedConnection:Disconnect()
		ChildAddedConnection = nil
	end

	Net:RemoteEvent("Tools/Waverider/Deactivate"):FireServer()
end

local function OnFlightHoldAdded(child)
	if IsFlying then
		return
	end
	if child.Name ~= "FlightHold" then
		return
	end

	local FlightSpin = HumanoidRootPart:FindFirstChild("FlightSpin")
	local FlightPower = HumanoidRootPart:FindFirstChild("FlightPower")
	local FlightHold = HumanoidRootPart:FindFirstChild("FlightHold")

	if not (FlightSpin and FlightPower and FlightHold) then
		return
	end

	IsFlying = true
	EquipSound:Play()
	StartSoundLoop()
	WaveriderBoost.Visible = true
	Humanoid.WalkSpeed = 0
	Humanoid.PlatformStand = true
	Humanoid.AutoRotate = false
	SetJumpBlocked(true)

	HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
	HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero

	local Camera = assert(workspace.CurrentCamera)

	while IsFlying and FlightSpin.Parent and FlightPower.Parent and FlightHold.Parent do
		if not CheckAlive() then
			break
		end

		local SpeedMultiplier = tonumber(Tool:GetAttribute("SpeedMultiplier")) or 1.65
		local CameraCFrame = Camera.CFrame
		local Forward = CameraCFrame:VectorToWorldSpace(Vector3.new(0, 0, -1))
		local Right = CameraCFrame:VectorToWorldSpace(Vector3.new(-1, 0, 0))
		local MoveDirection = CFrame.new(Vector3.zero, CameraCFrame.LookVector * Vector3.new(1, 0, 1)):VectorToObjectSpace(Humanoid.MoveDirection)

		local Velocity = Vector3.zero
		Velocity += Forward * (60 * SpeedMultiplier) * -MoveDirection.Z
		Velocity += Right * (40 * SpeedMultiplier) * -MoveDirection.X

		FlightSpin.CFrame = CFrame.new(Vector3.zero, if Velocity.Magnitude > 1 then Velocity.Unit else Forward)

		if Velocity.Magnitude < 1 then
			FlightHold.MaxForce = Vector3.new(FlightHold.P, FlightHold.P, FlightHold.P)
			FlightPower.MaxForce = Vector3.zero
			FlightHold.Position = HumanoidRootPart.Position
		else
			FlightHold.MaxForce = Vector3.zero
			FlightPower.MaxForce = Vector3.new(FlightPower.P, FlightPower.P, FlightPower.P) * 100
		end

		FlightPower.Velocity = Velocity
		UpdateFlightAnimation(Velocity.Magnitude, SpeedMultiplier)
		task.wait(1 / 60)
	end

	IsFlying = false
	StopSounds()
	WaveriderBoost.Visible = false
	StopTracks()

	if not CheckAlive() then
		FlightToggled = false
		return
	end

	UnequipSound:Play()

	HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
	HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
	Humanoid.WalkSpeed = 32
	Humanoid.PlatformStand = false
	Humanoid.AutoRotate = true
	SetJumpBlocked(false)
	Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)

	Net:RemoteEvent("Tools/Waverider/Deactivate"):FireServer()
	FlightToggled = false
end

local function HandleFlightControl()
	if not CheckAlive() then
		return
	end

	if ChildAddedConnection then
		ChildAddedConnection:Disconnect()
	end

	ChildAddedConnection = HumanoidRootPart.ChildAdded:Connect(OnFlightHoldAdded)
end

local function StopFOVEffect()
	if FOVConnection then
		FOVConnection:Disconnect()
		FOVConnection = nil
	end

	local Camera = workspace.CurrentCamera
	if Camera and FOVOriginal then
		Camera.FieldOfView = FOVOriginal
	end

	FOVOriginal = nil
	FOVSpring = nil
end

local function StartFOVEffect()
	if FOVConnection then
		return
	end

	local Camera = workspace.CurrentCamera
	if not Camera then
		return
	end

	FOVOriginal = Camera.FieldOfView

	local NewSpring = Spring.new(Camera.FieldOfView)
	NewSpring.Speed = 12
	NewSpring.Damper = 0.65
	FOVSpring = NewSpring

	FOVConnection = RunService.RenderStepped:Connect(function()
		local CurrentCamera = workspace.CurrentCamera
		if not (CurrentCamera and FOVOriginal and FOVSpring) then
			return
		end

		local TargetFOV = FOVOriginal

		if IsFlying and Humanoid.MoveDirection.Magnitude > 0.1 then
			local SpeedRatio = (tonumber(Tool:GetAttribute("SpeedMultiplier")) or 1.65) / 1.65
			local BoostPulse = if Tool:GetAttribute("Boosting") == true then math.sin(os.clock() * 3) * 1.5 + 15 else 0
			TargetFOV = FOVOriginal + SpeedRatio * 6 + BoostPulse
		end

		FOVSpring.Target = TargetFOV
		CurrentCamera.FieldOfView = FOVSpring.Position
	end)
end

local function Equipped()
	if not CheckAlive() then
		return
	end

	ToolEquipped = true
	LoadTracks()
	StartFOVEffect()
	task.spawn(HandleFlightControl)

	if DiedConnection then
		DiedConnection:Disconnect()
	end
	DiedConnection = Humanoid.Died:Connect(ForceStopFlight)
end

local function Unequipped()
	if not ToolEquipped then
		return
	end

	ToolEquipped = false
	IsFlying = false
	FlightToggled = false
	StopSounds()
	StopTracks()
	WaveriderBoost.Visible = false
	StopFOVEffect()
	SetJumpBlocked(false)

	if ChildAddedConnection then
		ChildAddedConnection:Disconnect()
		ChildAddedConnection = nil
	end

	if DiedConnection then
		DiedConnection:Disconnect()
		DiedConnection = nil
	end
end

Tool.Equipped:Connect(Equipped)
Tool.Unequipped:Connect(Unequipped)

local UnbindBoostInput = ToolActionInput.bind(WaveriderBoost, WaveriderBoost.Activate, function()
	local Cooldown = tonumber(Tool:GetAttribute("CooldownTime") or 0) or 0
	if Cooldown > 0 then
		return
	end

	if Tool:GetAttribute("Boosting") ~= true then
		BoostSound:Play()
	end

	Net:RemoteEvent("Tools/Waverider/Boost"):FireServer()
end)

Tool.Activated:Connect(function()
	if not ToolEquipped then
		return
	end

	if not CheckAlive() then
		return
	end

	if FlightToggled then
		FlightToggled = false
		IsFlying = false
		Net:RemoteEvent("Tools/Waverider/Deactivate"):FireServer()
	else
		FlightToggled = true
		Net:RemoteEvent("Tools/Waverider/Activate"):FireServer()
	end
end)

Tool.Destroying:Connect(function()
	UnbindBoostInput()
	StopSounds()
	StopFOVEffect()
	if DiedConnection then
		DiedConnection:Disconnect()
		DiedConnection = nil
	end
end)

local function UpdateCooldown()
	local Cooldown = tonumber(Tool:GetAttribute("CooldownTime") or 0) or 0
	local Activate = WaveriderBoost.Activate

	if Cooldown > 0 then
		Activate.ImageColor3 = Color3.fromRGB(128, 128, 128)
		Activate.Icon.ImageColor3 = Color3.fromRGB(128, 128, 128)
		Activate.Txt.TextColor3 = Color3.fromRGB(128, 128, 128)
		Activate.Cooldown.Text = string.format("%0.1f", Cooldown)
		Activate.Cooldown.Visible = true
	else
		Activate.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Activate.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Activate.Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
		Activate.Cooldown.Visible = false
	end
end

Tool:GetAttributeChangedSignal("CooldownTime"):Connect(UpdateCooldown)
UpdateCooldown()