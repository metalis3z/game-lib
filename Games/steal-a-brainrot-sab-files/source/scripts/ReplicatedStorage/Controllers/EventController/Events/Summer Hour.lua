local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Shared.EventTypes)

local SummerHour = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local Spring = require(ReplicatedStorage.Packages.Spring)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local EventName = script.Name

local ProjectileEvent = Net:RemoteEvent("EventService/SummerHour/Projectile")
local BurstEvent = Net:RemoteEvent("EventService/SummerHour/Burst")

local trove = Trove.new()

local scaleSpring = Spring.new(11.203)
scaleSpring.Speed = 10
scaleSpring.Damper = 0.4

local rotationXSpring = Spring.new(0)
rotationXSpring.Speed = 3
rotationXSpring.Damper = 0.4

local rotationYSpring = Spring.new(0)
rotationYSpring.Speed = 3
rotationYSpring.Damper = 0.4

local rotationZSpring = Spring.new(0)
rotationZSpring.Speed = 3
rotationZSpring.Damper = 0.4

local targetRotX = 0.25
local targetRotY = 0
local targetRotZ = 0
local isAiming = false
local sunTrait = nil
local homePosition = nil
local idleAnimTrack = nil
local isRunning = false

local function shootProjectile(targetAnimal)
	local animalPos = ClientEventUtils.getAnimalPosition(targetAnimal, {
		top = true
	})

	if sunTrait and homePosition and animalPos ~= Vector3.new(0, 0, 0) then
		scaleSpring:Impulse(130)

		task.spawn(function()
			VFX.emit(sunTrait.RootPart.Bone.Burst)
			SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Summer Hour"].Shoot, sunTrait:GetPivot().Position, false)
		end)

		local projectile = sunTrait:Clone()
		projectile.Parent = workspace

		local animator = projectile:FindFirstChildWhichIsA("Animator", true)
		local animation = script:FindFirstChild("IdleAnimation")

		if animator and animation and animation:IsA("Animation") then
			local animTrack = animator:LoadAnimation(animation)
			animTrack.Looped = true
			animTrack:Play()
		end

		local startCFrame = sunTrait:GetPivot()
		local startPos = startCFrame.Position
		local rotation = startCFrame.Rotation
		local startTime = workspace:GetServerTimeNow()
		local travelTime = (animalPos - startPos).Magnitude / 90
		local targetPos = animalPos
		local connection

		connection = RunService.PostSimulation:Connect(function()
			local newAnimalPos = ClientEventUtils.getAnimalPosition(targetAnimal, {
				top = true
			})

			if newAnimalPos ~= Vector3.new(0, 0, 0) then
				targetPos = newAnimalPos
			end

			local elapsed = workspace:GetServerTimeNow() - startTime
			local alpha = TweenService:GetValue(travelTime == 0 and 1 or math.clamp(elapsed / travelTime, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			local currentPos = startPos:Lerp(targetPos, alpha)

			projectile:PivotTo(CFrame.new(currentPos) * rotation * CFrame.Angles(0, 0, alpha * 3.141592653589793 * 8))
			projectile:ScaleTo((math.lerp(14.203, 1, alpha)))

			if alpha >= 1 then
				connection:Disconnect()
				projectile:Destroy()
			end
		end)

		task.delay(10, function()
			if connection.Connected then
				connection:Disconnect()
			end

			if projectile.Parent then
				projectile:Destroy()
			end
		end)
	end
end

function SummerHour.OnStart(_)
	local eventData = EventController:GetActiveEventData(EventName)
	assert(eventData)

	EffectController:Run("SummerHourEvent", "GrassRecolor")
	trove:Add(function()
		EffectController:Stop("SummerHourEvent", "GrassRecolor")
	end)

	EffectController:Run("SummerHourEvent", "WallRecolor")
	trove:Add(function()
		EffectController:Stop("SummerHourEvent", "WallRecolor")
	end)

	EffectController:Run("SummerHourEvent", "WallBottomRecolor")
	trove:Add(function()
		EffectController:Stop("SummerHourEvent", "WallBottomRecolor")
	end)

	EffectController:Activate("Blink")
	trove:Add(function()
		EffectController:Activate("Blink")
	end)

	local eventFolder = workspace.Events:FindFirstChild(EventName)
	if eventFolder then
		eventFolder = eventFolder:FindFirstChild("SunTrait")
	end

	sunTrait = eventFolder

	if sunTrait then
		homePosition = sunTrait:GetAttribute("Home") or sunTrait:GetPivot()
		isRunning = true

		local animator = sunTrait:FindFirstChildWhichIsA("Animator", true)
		local animation = script:FindFirstChild("IdleAnimation")

		if animator and animation and animation:IsA("Animation") then
			local animTrack = animator:LoadAnimation(animation)
			animTrack.Looped = true
			animTrack:Play()
			idleAnimTrack = animTrack
		end

		targetRotX = 0.25
		targetRotY = 0
		targetRotZ = 0

		trove:Add(RunService.PostSimulation:Connect(function()
			if isRunning and sunTrait and homePosition then
				local currentTime = os.clock()

				rotationXSpring.Target = targetRotX
				rotationYSpring.Target = targetRotY
				rotationZSpring.Target = targetRotZ

				sunTrait:ScaleTo(scaleSpring.Position)

				local model = sunTrait
				local targetCFrame = homePosition * CFrame.Angles(rotationXSpring.Position, rotationYSpring.Position, rotationZSpring.Position)
				local hoverOffset = math.sin(currentTime * 1.75) * 7

				model:PivotTo(targetCFrame + Vector3.new(0, hoverOffset, 0))
			end
		end))

		trove:Add(task.spawn(function()
			while isRunning do
				if not isAiming then
					targetRotY = 0
					targetRotZ = 0
				end

				local nextRotationTime = os.clock() + math.random(20, 50) / 10
				local shouldRotateRight

				if math.random() < 0.5 then
					shouldRotateRight = true
				else
					shouldRotateRight = false
				end

				while isRunning and os.clock() < nextRotationTime do
					if not isAiming then
						targetRotX = shouldRotateRight and 0.5 or 0
						shouldRotateRight = not shouldRotateRight
					end

					task.wait(math.random(80, 160) / 100)
				end

				task.wait(0.1)
			end
		end))

		trove:Add(function()
			isRunning = false
			isAiming = false

			if idleAnimTrack then
				idleAnimTrack:Stop(0)
				idleAnimTrack:Destroy()
				idleAnimTrack = nil
			end

			if sunTrait then
				sunTrait:ScaleTo(1)
			end

			sunTrait = nil
			homePosition = nil
		end)
	end
end

function SummerHour.OnStop(_)
	trove:Destroy()
end

function SummerHour.OnLoad(_)
	ProjectileEvent.OnClientEvent:Connect(function(targetAnimal, _, _, aimDelay, _)
		if isRunning and sunTrait then
			isAiming = true

			local animalPos = ClientEventUtils.getAnimalPosition(targetAnimal, {
				top = true
			})

			local angleX, angleY, angleZ

			if homePosition then
				local lookAtRotation = CFrame.lookAt(homePosition.Position, animalPos).Rotation
				angleX, angleY, angleZ = (homePosition.Rotation:Inverse() * lookAtRotation):ToEulerAnglesXYZ()
			else
				angleX = 0
				angleY = 0
				angleZ = 0
			end

			targetRotX = angleX
			targetRotY = angleY
			targetRotZ = angleZ

			task.wait(aimDelay or 0.7)

			if isRunning and sunTrait then
				shootProjectile(targetAnimal)

				task.delay(0.5, function()
					targetRotX = 0.25
					targetRotY = 0
					targetRotZ = 0
					isAiming = false
				end)
			else
				isAiming = false
			end
		end
	end)

	BurstEvent.OnClientEvent:Connect(function(animals)
		local burstEffect = script:FindFirstChild("Burst")

		if burstEffect then
			ClientEventUtils.playBurst(burstEffect, animals, { ReplicatedStorage.Sounds.Events["Summer Hour"].Burst })
		end
	end)
end

return SummerHour