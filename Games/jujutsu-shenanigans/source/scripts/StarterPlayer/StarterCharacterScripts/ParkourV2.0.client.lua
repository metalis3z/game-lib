local MovementController = {}

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game.ReplicatedStorage
local Camera = workspace.CurrentCamera

local ANIMATIONS = {
	Vault = {"120026521517367", "137874882425083", "109179697888838", "16052080684"},
	Dive = {"82247311910885", "137222292658694"},
	Slide = {"71800815125337"},
	Climb = {"83591314337866"},
	BounceR = {"112266165543829"},
	BounceL = {"110224552976327"}
}

local DIRECTION_VECTORS = {
	Back = Vector3.new(0, 0, 1),
	Left = Vector3.new(-1, 0, 0),
	Right = Vector3.new(1, 0, 0)
}

local FootstepSounds = {
	[Enum.Material.Plastic] = "rbxassetid://5761648082",
	[Enum.Material.Metal] = "rbxassetid://5639245164",
	[Enum.Material.Wood] = "rbxassetid://5632735811",
	[Enum.Material.Grass] = "rbxassetid://5639244517"
}

local cameraShakePresets = {
	LightHit = {frequency = 10, amplitude = 0.5},
	HeavyHit = {frequency = 15, amplitude = 1.2}
}

local function CreateCameraShaker()
	local shaker = {
		CurrentShaker = {
			Shake = function(self, preset, duration)
				local params = cameraShakePresets[preset]
				if params then
					local startTime = tick()
					local connection
					connection = RunService.RenderStepped:Connect(function()
						local elapsed = tick() - startTime
						if elapsed > (duration or 0.5) then
							connection:Disconnect()
							return
						end

						local offset = Vector3.new(
							math.sin(elapsed * params.frequency) * params.amplitude,
							math.cos(elapsed * params.frequency * 0.8) * params.amplitude,
							0
						)
						Camera.CFrame = Camera.CFrame * CFrame.new(offset * 0.1)
					end)
				end
			end
		}
	}
	return shaker
end

function MovementController:Dash(player, character)
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if rootPart and humanoid and not self.IsDashing then
		self.IsDashing = true

		local lookVector = Camera.CFrame.LookVector
		lookVector = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
		local dashDirection = lookVector * 200

		humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)

		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Velocity = dashDirection
		bodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		bodyVelocity.Parent = rootPart

		Debris:AddItem(bodyVelocity, 0.3)

		-- Play dash animation
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. ANIMATIONS.Dive[1]
		local animTrack = humanoid:LoadAnimation(anim)
		animTrack:Play()

		self.CameraShaker.CurrentShaker:Shake("LightHit", 0.3)

		-- Face direction during dash
		local connection
		connection = RunService.RenderStepped:Connect(function()
			rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + lookVector)
		end)

		task.delay(0.3, function()
			connection:Disconnect()
			self.IsDashing = false
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
		end)
	end
end

function MovementController:Vault(character, rootPart, humanoid, hit)
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://" .. ANIMATIONS.Vault[1]
	local animTrack = humanoid:LoadAnimation(anim)
	animTrack:Play()

	local vaultHeight = hit.Position.Y + 2.5
	local vaultCFrame = CFrame.new(rootPart.Position + Vector3.new(0, 3, 0) + rootPart.CFrame.LookVector * 4)

	local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad)
	local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = vaultCFrame})
	tween:Play()

	tween.Completed:Connect(function()
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	end)
end

function MovementController:PlayFootstepSound(character)
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end

	local ray = Ray.new(rootPart.Position, Vector3.new(0, -3, 0))
	local hit, _, _, material = workspace:FindPartOnRay(ray, character)

	if hit and FootstepSounds[material] then
		local sound = Instance.new("Sound")
		sound.SoundId = FootstepSounds[material]
		sound.Volume = 0.4
		sound.Parent = rootPart
		sound:Play()
		Debris:AddItem(sound, 2)
	end
end

function MovementController:Parkour(character, rootPart, humanoid)
	local state = humanoid:GetState()
	local lookVector = rootPart.CFrame.LookVector

	if state == Enum.HumanoidStateType.Running then
		local frontCheck = workspace:Raycast(rootPart.Position, lookVector * 5, {workspace.Map, character})
		if frontCheck and (frontCheck.Instance.CanCollide or frontCheck.Instance:IsA("BasePart")) then
			local obstacleHeight = frontCheck.Position.Y - rootPart.Position.Y
			if obstacleHeight < 3 and obstacleHeight > 0.5 then
				self:Vault(character, rootPart, humanoid, frontCheck)
			end
		end
	end
end

function MovementController:KnitStart()
	self.CameraShaker = CreateCameraShaker()
	self.IsDashing = false
	self.LastFootstep = 0

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed then
			if input.KeyCode == Enum.KeyCode.Q then
				local character = LocalPlayer.Character
				if character then
					self:Dash(LocalPlayer, character)
				end
			elseif input.KeyCode == Enum.KeyCode.LeftShift then
				local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					humanoid:SetAttribute("Sprint", true)
				end
			end
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftShift then
			local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid:SetAttribute("Sprint", false)
			end
		end
	end)

	RunService.Stepped:Connect(function()
		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local rootPart = character:FindFirstChild("HumanoidRootPart")

			if humanoid and rootPart then
				humanoid.WalkSpeed = humanoid:GetAttribute("Sprint") and 24 or 16

				if humanoid:GetState() == Enum.HumanoidStateType.Running then
					self:Parkour(character, rootPart, humanoid)
				end

				-- Footstep sounds
				if humanoid.MoveDirection.Magnitude > 0 and tick() - self.LastFootstep > 0.35 then
					self:PlayFootstepSound(character)
					self.LastFootstep = tick()
				end
			end
		end
	end)
end

return MovementController