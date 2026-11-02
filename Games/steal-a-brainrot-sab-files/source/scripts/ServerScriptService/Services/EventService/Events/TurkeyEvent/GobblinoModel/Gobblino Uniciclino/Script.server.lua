--!strict
local model = script.Parent
local damagePart = model:WaitForChild("Damage")
local billboardGui = damagePart:WaitForChild("HealthBar")
local progressFrame = billboardGui:WaitForChild("Progress")
local fillFrame = progressFrame:WaitForChild("Fill")
local label = progressFrame:WaitForChild("Label")

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local AnimalService = require(ServerScriptService.Services.AnimalService)

local MAX_HEALTH = 10
local currentHealth = MAX_HEALTH
local DAMAGE_PER_HIT = 1
local isDestroyed = false

local MOVE_SPEED = 300
local RUN_SPEED = 525
local MOVE_RANGE = 190
local CHANGE_DIRECTION_TIME = 15

local isPanicking = false
local PANIC_HEALTH_THRESHOLD = MAX_HEALTH * 0.25

local spawnPosition = model:GetPivot().Position
local FIXED_Y_POSITION = spawnPosition.Y
local currentDirection = Vector3.new(math.random(-100, 100) / 100, 0, math.random(-100, 100) / 100).Unit
local lastDirectionChange = tick()

local animator = nil
local walkTrack = nil
local runTrack = nil
local hitTrack = nil
local humanoidOrController = nil

for _, descendant in ipairs(model:GetDescendants()) do
	if descendant:IsA("BasePart") then
		descendant.CanCollide = false
		descendant.CanTouch = false
		descendant.CanQuery = false
		descendant.Anchored = true
		descendant.Massless = true
	end
end

for _, descendant in ipairs(model:GetDescendants()) do
	if descendant:IsA("Humanoid") then
		humanoidOrController = descendant
		animator = descendant:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = descendant
		end
		break
	elseif descendant:IsA("AnimationController") then
		humanoidOrController = descendant
		animator = descendant:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = descendant
		end
		break
	end
end

if not humanoidOrController then
	humanoidOrController = Instance.new("AnimationController")
	humanoidOrController.Parent = model
	animator = Instance.new("Animator")
	animator.Parent = humanoidOrController
end

local walkAnimation = model:FindFirstChild("Walk", true)
if walkAnimation and walkAnimation:IsA("Animation") and animator then
	local success, err = pcall(function()
		walkTrack = animator:LoadAnimation(walkAnimation)
		if walkTrack then
			walkTrack.Looped = true
			walkTrack:Play()
		end
	end)
	if not success then
	end
end

local runAnimation = model:FindFirstChild("Run", true)
if runAnimation and runAnimation:IsA("Animation") and animator then
	local success, err = pcall(function()
		runTrack = animator:LoadAnimation(runAnimation)
		if runTrack then
			runTrack.Looped = true
		end
	end)
	if not success then
	end
end

local hitAnimation = model:FindFirstChild("Hit", true)
if hitAnimation and hitAnimation:IsA("Animation") and animator then
	local success, err = pcall(function()
		hitTrack = animator:LoadAnimation(hitAnimation)
		if hitTrack then
			hitTrack.Looped = false
		end
	end)
	if not success then
	end
end

local function enterPanicMode()
	if isPanicking then return end
	isPanicking = true

	if walkTrack and walkTrack.IsPlaying then
		walkTrack:Stop()
	end

	if runTrack then
		runTrack:Play()
	end
end

local function formatNumber(num)
	if num >= 1000000 then
		return string.format("%.1fM", num / 1000000)
	elseif num >= 1000 then
		return string.format("%.1fk", num / 1000)
	end
	return tostring(math.floor(num))
end

local function updateHealthBar()
	if isDestroyed then return end

	local healthPercent = math.clamp(currentHealth / MAX_HEALTH, 0, 1)

	fillFrame.Size = UDim2.new(healthPercent, 0, 1, 0)

	label.Text = string.format("%s/%s", formatNumber(currentHealth), formatNumber(MAX_HEALTH))

	if healthPercent > 0.5 then
		fillFrame.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
	elseif healthPercent > 0.25 then
		fillFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 85)
	else
		fillFrame.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
	end
end

local function takeDamage(player: Player)
	if isDestroyed then return end

	currentHealth = math.max(0, currentHealth - DAMAGE_PER_HIT)

	updateHealthBar()

	if hitTrack then
		hitTrack:Play()
	end

	if not isPanicking and currentHealth <= PANIC_HEALTH_THRESHOLD then
		enterPanicMode()
	end

	if currentHealth <= 0 then
		isDestroyed = true

		if walkTrack then
			walkTrack:Stop()
		end
		if runTrack then
			runTrack:Stop()
		end


		task.spawn(function()
			local success, err = pcall(function()
				AnimalService.spawnAnimalInBase(player, "Gobblino Uniciclino", nil, nil)
			end)

			if success then
			else
			end
		end)

		task.spawn(function()
			task.wait(0.3)

			for i = 1, 20 do
				for _, part in ipairs(model:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Transparency = math.min(1, part.Transparency + 0.05)
					elseif part:IsA("Decal") or part:IsA("Texture") then
						part.Transparency = math.min(1, part.Transparency + 0.05)
					end
				end
				task.wait(0.05)
			end

			model:Destroy()
		end)
	end
end

local lastDamageTime = {}
local DAMAGE_COOLDOWN = 0.5

local clickDetectionRange = 15

local function setupPlayerTools(player: Player)
	local function setupCharacter(character)
		local function onToolActivated(tool)
			if isDestroyed then return end

			local currentTime = tick()
			if lastDamageTime[player.UserId] and (currentTime - lastDamageTime[player.UserId]) < DAMAGE_COOLDOWN then
				return
			end

			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart then return end

			local distance = (humanoidRootPart.Position - damagePart.Position).Magnitude

			if distance <= clickDetectionRange then
				lastDamageTime[player.UserId] = currentTime
				takeDamage(player)
			end
		end

		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") then
				child.Activated:Connect(function()
					onToolActivated(child)
				end)
			end
		end

		character.ChildAdded:Connect(function(child)
			if child:IsA("Tool") then
				child.Activated:Connect(function()
					onToolActivated(child)
				end)
			end
		end)
	end

	if player.Character then
		setupCharacter(player.Character)
	end

	player.CharacterAdded:Connect(setupCharacter)
end

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayerTools(player)
end

Players.PlayerAdded:Connect(setupPlayerTools)

local function getRandomDirection()
	local angle = math.random() * math.pi * 2
	return Vector3.new(math.cos(angle), 0, math.sin(angle))
end

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.FilterDescendantsInstances = { model }

local function checkForObstacles(origin, direction, distance)
	local horizontalDirection = Vector3.new(direction.X, 0, direction.Z).Unit
	local rayOrigin = Vector3.new(origin.X, FIXED_Y_POSITION, origin.Z)
	local rayDirection = horizontalDirection * distance
	local raycastResult = workspace:Raycast(rayOrigin, rayDirection, rayParams)
	return raycastResult
end

local movementConnection
movementConnection = RunService.Heartbeat:Connect(function(deltaTime)
	if isDestroyed then
		if movementConnection then
			movementConnection:Disconnect()
		end
		return
	end

	if tick() - lastDirectionChange >= CHANGE_DIRECTION_TIME then
		currentDirection = getRandomDirection()
		lastDirectionChange = tick()
	end

	local currentPos = model:GetPivot().Position

	local activeSpeed = if isPanicking then RUN_SPEED else MOVE_SPEED
	local moveDistance = activeSpeed * deltaTime

	local offsetFromSpawn = Vector3.new(
		currentPos.X - spawnPosition.X,
		0,
		currentPos.Z - spawnPosition.Z
	)

	if offsetFromSpawn.Magnitude >= MOVE_RANGE * 0.95 then
		local toSpawn = (Vector3.new(spawnPosition.X, 0, spawnPosition.Z) - Vector3.new(currentPos.X, 0, currentPos.Z)).Unit
		local randomAngle = (math.random() - 0.5) * math.rad(45)
		local cos, sin = math.cos(randomAngle), math.sin(randomAngle)
		currentDirection = Vector3.new(
			toSpawn.X * cos - toSpawn.Z * sin,
			0,
			toSpawn.X * sin + toSpawn.Z * cos
		).Unit
		lastDirectionChange = tick()
	end

	local obstacleCheck = checkForObstacles(currentPos, currentDirection, moveDistance + 2)

	if obstacleCheck then
		local attempts = 0
		local maxAttempts = 8

		while attempts < maxAttempts do
			local newDirection = getRandomDirection()
			local newCheck = checkForObstacles(currentPos, newDirection, moveDistance + 2)

			if not newCheck then
				currentDirection = newDirection
				lastDirectionChange = tick()
				break
			end

			attempts = attempts + 1
		end

		if attempts >= maxAttempts then
			return
		end
	end

	local newPos = currentPos + (currentDirection * moveDistance)

	local newOffset = Vector3.new(
		newPos.X - spawnPosition.X,
		0,
		newPos.Z - spawnPosition.Z
	)

	if newOffset.Magnitude > MOVE_RANGE then
		local clampedOffset = newOffset.Unit * MOVE_RANGE
		newPos = Vector3.new(
			spawnPosition.X + clampedOffset.X,
			FIXED_Y_POSITION,
			spawnPosition.Z + clampedOffset.Z
		)
	end

	newPos = Vector3.new(newPos.X, FIXED_Y_POSITION, newPos.Z)

	local lookAt = newPos + currentDirection
	local targetCFrame = CFrame.new(newPos, Vector3.new(lookAt.X, newPos.Y, lookAt.Z))

	local currentCFrame = model:GetPivot()
	local smoothCFrame = currentCFrame:Lerp(targetCFrame, 0.1)

	model:PivotTo(smoothCFrame)
end)

updateHealthBar()