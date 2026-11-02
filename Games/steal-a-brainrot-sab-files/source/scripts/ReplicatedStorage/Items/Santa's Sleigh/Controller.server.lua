local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local Net = require(ReplicatedStorage.Packages.Net)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local ToolAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("SantasSleigh")
local SitAnimationAsset = ToolAssets:WaitForChild("SitAnimation")
local PresentAsset = ToolAssets:WaitForChild("Present")
local ExplosionVFXAsset = ToolAssets:WaitForChild("ExplosionVFX")

local PresentDropSound = Handle:WaitForChild("PresentDropSound")
local PresentExplosionSound = Handle:WaitForChild("PresentExplosionSound")
local PresentStunnedSound = Handle:WaitForChild("PresentStunnedSound")
local SleighEquipSound = Handle:WaitForChild("SleighEquipSound")
local SleighIdleMagicSound = Handle:WaitForChild("SleighIdleMagicSound")
local SleighIdleSound = Handle:WaitForChild("SleighIdleSound")
local SleighUnequipSound = Handle:WaitForChild("SleighUnequipSound")

SleighIdleMagicSound.Looped = true
SleighIdleSound.Looped = true

local Player = nil
local Character = nil
local Humanoid = nil
local RootPart = nil

local Flying = false
local ToolEquipped = false
local SitTrack = nil
local SoundLoopThread = nil

local FlightSpin, FlightPower, FlightHold
local SleighWeld = nil
local SavedGripWeld = nil
local SavedGripPart0 = nil
local OriginalHandleSize = nil
local OriginalRocketPositions = {}

local HANDLE_SIZE_NORMAL = Vector3.new(4.095, 2.55, 3.697)
local HANDLE_SIZE_FLYING = Vector3.new(9.095, 5.55, 8.697)

local PRESENT_COOLDOWN = 2
local BASE_SPEED = 34
local MAX_SPEED_RATIO = 1.5
local EXPLOSION_RADIUS = 30
local RAGDOLL_DURATION = 5

local function CleanUpBodyMovers()
	for _, v in pairs({ FlightSpin, FlightPower, FlightHold }) do
		if v and v.Parent then
			v:Destroy()
		end
	end
	FlightSpin = nil
	FlightPower = nil
	FlightHold = nil
end

local function StopFlightSounds()
	if SoundLoopThread then
		task.cancel(SoundLoopThread)
		SoundLoopThread = nil
	end
	SleighIdleMagicSound:Stop()
	SleighIdleMagicSound.PlaybackSpeed = 1
	SleighIdleSound:Stop()
	SleighIdleSound.PlaybackSpeed = 1
end

local function StartSoundLoop()
	if SoundLoopThread then
		task.cancel(SoundLoopThread)
		SoundLoopThread = nil
	end
	SoundLoopThread = task.spawn(function()
		while Flying and ToolEquipped do
			if RootPart and RootPart.Parent then
				local vel = RootPart.AssemblyLinearVelocity
				local horizontalSpeed = Vector3.new(vel.X, 0, vel.Z).Magnitude
				local speedRatio = math.clamp(1 + (horizontalSpeed / BASE_SPEED) * (MAX_SPEED_RATIO - 1), 1, MAX_SPEED_RATIO)

				if not SleighIdleMagicSound.IsPlaying then
					SleighIdleMagicSound:Play()
				end
				SleighIdleMagicSound.PlaybackSpeed = speedRatio

				if horizontalSpeed > 8 then
					if not SleighIdleSound.IsPlaying then
						SleighIdleSound:Play()
					end
					SleighIdleSound.PlaybackSpeed = speedRatio
				else
					if SleighIdleSound.IsPlaying then
						SleighIdleSound:Stop()
						SleighIdleSound.PlaybackSpeed = 1
					end
				end

				if SitTrack then
					SitTrack:AdjustSpeed(speedRatio)
				end
			end
			task.wait(0.1)
		end
	end)
end

local function ClearSleigh()
	if SleighWeld and SleighWeld.Parent then
		SleighWeld:Destroy()
	end
	SleighWeld = nil

	if SavedGripWeld and SavedGripWeld.Parent then
		SavedGripWeld.Part0 = SavedGripPart0
	end
	SavedGripWeld = nil
	SavedGripPart0 = nil

	if OriginalHandleSize then
		Handle.Size = OriginalHandleSize
		OriginalHandleSize = nil
	end

	for attachName, origPos in pairs(OriginalRocketPositions) do
		local attach = Handle:FindFirstChild(attachName)
		if attach then
			attach.Position = origPos
		end
	end
	OriginalRocketPositions = {}

	for _, attachName in pairs({ "RocketLeft", "RocketRight" }) do
		local attach = Handle:FindFirstChild(attachName)
		if attach then
			local flame = attach:FindFirstChild("Flame1")
			if flame and flame:IsA("ParticleEmitter") then
			end
		end
	end
end

local function AttachSleigh()
	if not Character or not Humanoid or not RootPart then
		return
	end
	ClearSleigh()

	CollectionService:AddTag(Character, "anticheatskip")

	OriginalHandleSize = Handle.Size

	local grip = Handle:FindFirstChildOfClass("Motor6D")
	if grip then
		SavedGripWeld = grip
		SavedGripPart0 = grip.Part0
		grip.Part0 = nil
	end

	for _, attachName in pairs({ "RocketLeft", "RocketRight" }) do
		local attach = Handle:FindFirstChild(attachName)
		if attach then
			OriginalRocketPositions[attachName] = attach.Position
		end
	end

	local scaleX = HANDLE_SIZE_FLYING.X / OriginalHandleSize.X
	local scaleY = HANDLE_SIZE_FLYING.Y / OriginalHandleSize.Y
	local scaleZ = HANDLE_SIZE_FLYING.Z / OriginalHandleSize.Z

	Handle.Size = HANDLE_SIZE_FLYING
	Handle.Massless = true
	Handle.CanCollide = false
	Handle.CanTouch = false
	Handle.CanQuery = false

	for _, attachName in pairs({ "RocketLeft", "RocketRight" }) do
		local attach = Handle:FindFirstChild(attachName)
		if attach then
			local orig = OriginalRocketPositions[attachName]
			if orig then
				attach.Position = Vector3.new(orig.X * scaleX, orig.Y * scaleY, orig.Z * scaleZ)
			end
			local flame = attach:FindFirstChild("Flame1")
			if flame and flame:IsA("ParticleEmitter") then
				flame.Lifetime = NumberRange.new(0.75)
				flame.Enabled = true
			end
		end
	end

	local seatAttach = Handle:FindFirstChild("Seat")

	local weld = Instance.new("Weld")
	weld.Name = "SleighRootWeld"
	weld.Part0 = RootPart
	weld.Part1 = Handle
	weld.C0 = CFrame.new()
	weld.C1 = seatAttach and seatAttach.CFrame or CFrame.new()
	weld.Parent = Handle
	SleighWeld = weld
end

local function RagdollCharacter(plr, char, duration)
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then
		return
	end

	hum.PlatformStand = true
	Ragdoll.Ragdoll(char)
	plr:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow() + duration)

	local healthConn
	healthConn = hum.HealthChanged:Connect(function()
		if hum.Health <= 0 then
			hum.Health = 100
		end
	end)

	task.delay(duration, function()
		if healthConn then
			healthConn:Disconnect()
		end
		if not char or not char.Parent then
			return
		end
		Ragdoll.Unragdoll(char)
		hum.PlatformStand = false
		hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		plr:SetAttribute("RagdollEndTime", nil)
	end)
end

local function Activated()
	if not Tool.Enabled or not Character or not Humanoid then
		return
	end
	Tool.Enabled = false
	Flying = not Flying

	if Flying then
		SleighEquipSound:Play()
		AttachSleigh()

		Tool:SetAttribute("WingsFlying", true)
		CleanUpBodyMovers()

		FlightSpin = Instance.new("BodyGyro")
		FlightSpin.Name = "FlightSpin"
		FlightSpin.P = 10000
		FlightSpin.MaxTorque = Vector3.new(1, 1, 1) * 1000000
		FlightSpin.CFrame = RootPart.CFrame

		FlightPower = Instance.new("BodyVelocity")
		FlightPower.Name = "FlightPower"
		FlightPower.Velocity = Vector3.new(0, 0, 0)
		FlightPower.MaxForce = Vector3.new(1, 1, 1) * 1000000
		FlightPower.P = 1000

		FlightHold = Instance.new("BodyPosition")
		FlightHold.Name = "FlightHold"
		FlightHold.P = 100000
		FlightHold.MaxForce = Vector3.new(0, 0, 0)
		FlightHold.Position = RootPart.Position

		FlightSpin.Parent = RootPart
		FlightPower.Parent = RootPart
		FlightHold.Parent = RootPart

		local animator = Humanoid:FindFirstChildOfClass("Animator")
		if animator and SitAnimationAsset then
			SitTrack = animator:LoadAnimation(SitAnimationAsset)
			SitTrack.Priority = Enum.AnimationPriority.Action4
			SitTrack:Play(0.2)
		end

		SleighIdleMagicSound.PlaybackSpeed = 1
		SleighIdleMagicSound:Play()
		StartSoundLoop()
	else
		ClearSleigh()
		CleanUpBodyMovers()
		StopFlightSounds()
		SleighUnequipSound:Play()

		Tool:SetAttribute("WingsFlying", false)

		if SitTrack then
			SitTrack:Stop(0.2)
			SitTrack:Destroy()
			SitTrack = nil
		end

		if Humanoid then
			Humanoid.WalkSpeed = 34
			Humanoid.PlatformStand = false
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end

		if RootPart then
			RootPart.Velocity = Vector3.zero
			RootPart.RotVelocity = Vector3.zero
		end
	end

	task.wait(0.25)
	Tool.Enabled = true
end

local function Equipped()
	Character = Tool.Parent
	Player = Players:GetPlayerFromCharacter(Character)
	Humanoid = Character:FindFirstChild("Humanoid")
	RootPart = Character:FindFirstChild("HumanoidRootPart")

	ToolEquipped = true
	Tool.Enabled = true

	if Humanoid then
		Humanoid.WalkSpeed = 34
	end

	Tool:SetAttribute("WingsFlying", false)
	ClearSleigh()
end

local function Unequipped()
	Flying = false
	ToolEquipped = false

	StopFlightSounds()
	SleighUnequipSound:Play()

	ClearSleigh()
	CleanUpBodyMovers()

	if Humanoid then
		Humanoid.WalkSpeed = 34
		Humanoid.PlatformStand = false
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end

	if RootPart then
		RootPart.Velocity = Vector3.zero
		RootPart.RotVelocity = Vector3.zero
	end

	Tool:SetAttribute("WingsFlying", false)

	if SitTrack then
		SitTrack:Stop()
		SitTrack:Destroy()
		SitTrack = nil
	end
end

Net:RemoteEvent("Tools/SantasSleigh/DropPresent").OnServerEvent:Connect(function(plr)
	if plr ~= Player or not ToolEquipped or not Flying then
		return
	end

	local cd = tonumber(Tool:GetAttribute("CooldownTime") or 0) or 0
	if cd > 0 then
		return
	end

	local char = plr.Character
	if not char then
		return
	end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then
		return
	end

	task.spawn(function()
		local remaining = PRESENT_COOLDOWN
		while remaining > 0 do
			Tool:SetAttribute("CooldownTime", remaining)
			task.wait(0.1)
			remaining = remaining - 0.1
		end
		Tool:SetAttribute("CooldownTime", 0)
	end)

	local presentClone = PresentAsset:Clone()
	local presentMain = presentClone:IsA("BasePart") and presentClone
		or presentClone:FindFirstChild("Main")
		or presentClone:FindFirstChildWhichIsA("BasePart")

	if not presentMain then
		presentClone:Destroy()
		return
	end

	presentMain.CFrame = CFrame.new(root.Position)
	presentMain.CanCollide = false
	presentClone.Parent = workspace

	PresentDropSound:Play()

	local bv = Instance.new("BodyVelocity")
	bv.Velocity = Vector3.new(0, -40, 0)
	bv.MaxForce = Vector3.new(0, math.huge, 0)
	bv.P = 1000
	bv.Parent = presentMain

	task.spawn(function()
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = { char, presentClone }
		params.FilterType = Enum.RaycastFilterType.Exclude

		local elapsed = 0

		while true do
			task.wait(0.05)
			elapsed += 0.05

			if not presentClone or not presentClone.Parent then
				break
			end

			if elapsed >= 20 then
				if bv and bv.Parent then
					bv:Destroy()
				end
				if presentClone and presentClone.Parent then
					presentClone:Destroy()
				end
				break
			end

			local pos = presentMain.Position
			local result = workspace:Raycast(pos, Vector3.new(0, -3, 0), params)

			if result then
				if bv and bv.Parent then
					bv:Destroy()
				end

				local landPos = result.Position

				PresentExplosionSound:Play()

				local vfxPart = Instance.new("Part")
				vfxPart.Anchored = true
				vfxPart.CanCollide = false
				vfxPart.CanTouch = false
				vfxPart.CanQuery = false
				vfxPart.Transparency = 1
				vfxPart.Size = Vector3.new(1, 1, 1)
				vfxPart.CFrame = CFrame.new(landPos)
				vfxPart.Parent = workspace

				local vfxClone = ExplosionVFXAsset:Clone()
				vfxClone.Position = Vector3.new(0, 0, 0)
				vfxClone.Parent = vfxPart

				for _, emitter in ipairs(vfxClone:GetDescendants()) do
					if emitter:IsA("ParticleEmitter") then
						emitter.Enabled = true
						emitter:Emit(emitter.Rate)
					end
				end

				presentClone:Destroy()

				for _, otherPlayer in ipairs(Players:GetPlayers()) do
					if otherPlayer == plr then
						continue
					end
					local otherChar = otherPlayer.Character
					if not otherChar then
						continue
					end
					local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
					if not otherRoot then
						continue
					end
					local otherHum = otherChar:FindFirstChildOfClass("Humanoid")
					if (otherRoot.Position - landPos).Magnitude <= EXPLOSION_RADIUS then
						if otherHum then
							otherHum.Health = math.max(1, otherHum.Health)
						end
						PresentStunnedSound:Play()
						task.spawn(RagdollCharacter, otherPlayer, otherChar, RAGDOLL_DURATION)
					end
				end

				task.delay(0.8, function()
					if not vfxPart or not vfxPart.Parent then return end
					for _, emitter in ipairs(vfxClone:GetDescendants()) do
						if emitter:IsA("ParticleEmitter") then
							emitter.Enabled = false
						end
					end
					task.wait(0.7)
					if vfxPart and vfxPart.Parent then
						vfxPart:Destroy()
					end
				end)
				break
			end
		end

		if presentClone and presentClone.Parent then
			presentClone:Destroy()
		end
	end)
end)

Tool.Activated:Connect(Activated)
Tool.Equipped:Connect(Equipped)
Tool.Unequipped:Connect(Unequipped)