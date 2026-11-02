--!strict
-- LOCATION: StarterPlayerScripts/SpeedSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local EffectsSystem = require(ReplicatedStorage.Modules.EffectsSystem)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local eventsFolder = ReplicatedStorage:WaitForChild("Events")

local addSpeedEvent = eventsFolder:WaitForChild("AddSpeed") :: RemoteEvent
local levelUpEvent = eventsFolder:WaitForChild("LevelUp") :: RemoteEvent

-- Sound Reference
local soundFolder = Workspace:WaitForChild("Sounds")
local levelUpSound = soundFolder:WaitForChild("LevelUp") :: Sound

-- UI References
local gui = playerGui:WaitForChild("GUI")
local hud = gui:WaitForChild("HUD")
local bottom = hud:WaitForChild("Bottom")
local barFrame = bottom:WaitForChild("Bar")
local progressFrame = barFrame:WaitForChild("Progress")

-- Level Up Frame References
local framesFolder = gui:WaitForChild("Frames")
local levelUpFrame = framesFolder:WaitForChild("LevelUp")
local newLevelLabel = levelUpFrame:WaitForChild("NewLevel") :: TextLabel
local newSpeedLabel = levelUpFrame:WaitForChild("NewSpeed") :: TextLabel

-- Text Labels (Bar)
local levelLabel = barFrame:WaitForChild("Level") :: TextLabel
local reqLabel = barFrame:WaitForChild("Requirement") :: TextLabel
local totalSpeedLabel = barFrame:WaitForChild("TotalSpeed") :: TextLabel
local rebirthBoostLabel = barFrame:WaitForChild("RebirthBoost") :: TextLabel

-- Configuration (keep in sync with PlayerController)
local STUDS_REQUIRED = 8
local BASE_XP_COST = 8        -- Updated to match PlayerController
local COST_MULTIPLIER = 1.25  -- Updated to match PlayerController
local BASE_WALKSPEED = 8
local SPEED_PER_LEVEL = 2.8   -- Updated to match PlayerController
local REBIRTH_PERCENT_PER_STEP = 50

local TWEEN_INFO_LEVEL = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local originalLevelUpPos = levelUpFrame.Position
local hiddenLevelUpPos = UDim2.new(1.5, 0, originalLevelUpPos.Y.Scale, originalLevelUpPos.Y.Offset)

levelUpFrame.Position = hiddenLevelUpPos
levelUpFrame.Visible = false

local accummulatedDistance = 0
local lastPosition: Vector3? = nil
local levelUpTimer: thread? = nil
local lastSpeedValue: number? = nil
local lastWinValue: number? = nil

local function getExperienceForLevel(level: number): number
	if level == 1 then return 0 end
	local total = 0
	for i = 1, level - 1 do
		total += math.floor(BASE_XP_COST * (COST_MULTIPLIER ^ (i - 1)))
	end
	return total
end

local function updateUI()
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end

	local currentSpeed = leaderstats:FindFirstChild("Speed").Value
	local currentLevel = leaderstats:FindFirstChild("Level").Value
	local currentRebirths = leaderstats:FindFirstChild("Rebirths").Value

	if lastSpeedValue ~= nil then
		local gain = currentSpeed - lastSpeedValue
		if gain > 0 then
			EffectsSystem.ShowSpeedPopUp(gain)
		end
	end
	lastSpeedValue = currentSpeed

	local xpForCurrentLevel = getExperienceForLevel(currentLevel)
	local xpForNextLevel = getExperienceForLevel(currentLevel + 1)

	local xpNeededThisLevel = xpForNextLevel - xpForCurrentLevel
	local currentProgressXP = currentSpeed - xpForCurrentLevel

	if currentProgressXP < 0 then currentProgressXP = 0 end
	if currentProgressXP > xpNeededThisLevel then currentProgressXP = xpNeededThisLevel end

	levelLabel.Text = "Level " .. NumberFormatter.Format(currentLevel)
	reqLabel.Text = NumberFormatter.Format(math.floor(currentProgressXP)) .. "/" .. NumberFormatter.Format(xpNeededThisLevel)
	totalSpeedLabel.Text = "Total Speed: " .. NumberFormatter.Format(currentSpeed)

	local boostPercent = currentRebirths * REBIRTH_PERCENT_PER_STEP
	rebirthBoostLabel.Text = "Rebirth: +" .. NumberFormatter.Format(boostPercent) .. "%"

	local percent = currentProgressXP / xpNeededThisLevel
	percent = math.clamp(percent, 0, 1)

	local targetSize = UDim2.new(percent, 0, 1, 0)
	TweenService:Create(progressFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = targetSize}):Play()
end

local function updateWins()
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end

	local currentWins = leaderstats:FindFirstChild("Wins").Value

	if lastWinValue ~= nil then
		local gain = currentWins - lastWinValue
		if gain > 0 then
			EffectsSystem.ShowWinPopUp(gain)
		end
	end
	lastWinValue = currentWins
end

local function showLevelUp(oldLevel: number, newLevel: number)
	local oldSpeed = BASE_WALKSPEED + (oldLevel - 1) * SPEED_PER_LEVEL
	local newSpeed = BASE_WALKSPEED + (newLevel - 1) * SPEED_PER_LEVEL

	newLevelLabel.Text = "Level " .. NumberFormatter.Format(oldLevel) .. " > Level " .. NumberFormatter.Format(newLevel)
	newSpeedLabel.Text = "Speed " .. NumberFormatter.Format(oldSpeed) .. " > Speed " .. NumberFormatter.Format(newSpeed)

	if levelUpSound then
		levelUpSound:Play()
	end

	levelUpFrame.Visible = true

	local tweenIn = TweenService:Create(levelUpFrame, TWEEN_INFO_LEVEL, {Position = originalLevelUpPos})
	tweenIn:Play()

	if levelUpTimer then
		task.cancel(levelUpTimer)
	end

	levelUpTimer = task.delay(5, function()
		local tweenOut = TweenService:Create(levelUpFrame, TWEEN_INFO_LEVEL, {Position = hiddenLevelUpPos})
		tweenOut:Play()
		tweenOut.Completed:Wait()

		if levelUpTimer == nil or coroutine.running() == levelUpTimer then
			levelUpFrame.Visible = false
			levelUpTimer = nil
		end
	end)
end

local function onHeartbeat(deltaTime: number)
	local character = player.Character
	if not character then lastPosition = nil; return end

	local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
	local humanoid = character:FindFirstChild("Humanoid") :: Humanoid

	if not rootPart or not humanoid or humanoid.Health <= 0 or humanoid.Sit then 
		lastPosition = nil
		return 
	end

	local currentPosition = rootPart.Position

	if lastPosition then
		local distance = (Vector3.new(currentPosition.X, 0, currentPosition.Z) - Vector3.new(lastPosition.X, 0, lastPosition.Z)).Magnitude
		if distance > 0 and distance < 5 then
			accummulatedDistance += distance
		end

		if accummulatedDistance >= STUDS_REQUIRED then
			accummulatedDistance -= STUDS_REQUIRED
			addSpeedEvent:FireServer()
		end
	end

	lastPosition = currentPosition
end

RunService.Heartbeat:Connect(onHeartbeat)

local function connectStats()
	local leaderstats = player:WaitForChild("leaderstats", 10)
	if leaderstats then
		local speed = leaderstats:WaitForChild("Speed")
		local level = leaderstats:WaitForChild("Level")
		local wins = leaderstats:WaitForChild("Wins")
		local rebirths = leaderstats:WaitForChild("Rebirths")

		if lastSpeedValue == nil then
			lastSpeedValue = speed.Value
		end

		if lastWinValue == nil then
			lastWinValue = wins.Value
		end

		speed.Changed:Connect(updateUI)
		level.Changed:Connect(updateUI)
		rebirths.Changed:Connect(updateUI)
		wins.Changed:Connect(updateWins)

		updateUI()
	end
end

connectStats()
levelUpEvent.OnClientEvent:Connect(showLevelUp)