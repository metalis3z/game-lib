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

local soundFolder = Workspace:WaitForChild("Sounds")
local levelUpSound = soundFolder:WaitForChild("LevelUp") :: Sound

local gui = playerGui:WaitForChild("GUI")
local hud = gui:WaitForChild("HUD")
local bottom = hud:WaitForChild("Bottom")
local barFrame = bottom:WaitForChild("Bar")
local progressFrame = barFrame:WaitForChild("Progress")

local framesFolder = gui:WaitForChild("Frames")
local levelUpFrame = framesFolder:WaitForChild("LevelUp")
local newLevelLabel = levelUpFrame:WaitForChild("NewLevel") :: TextLabel
local newSpeedLabel = levelUpFrame:WaitForChild("NewSpeed") :: TextLabel

local levelLabel = barFrame:WaitForChild("Level") :: TextLabel
local reqLabel = barFrame:WaitForChild("Requirement") :: TextLabel
local totalSpeedLabel = barFrame:WaitForChild("TotalSpeed") :: TextLabel
local rebirthBoostLabel = barFrame:WaitForChild("RebirthBoost") :: TextLabel

-- Must match PlayerController exactly
local STUDS_REQUIRED = 8
local BASE_XP_COST = 8
local COST_MULTIPLIER = 1.25
local BASE_WALKSPEED = 8
local SPEED_PER_LEVEL = 2.26
local REBIRTH_PERCENT_PER_STEP = 50

local TWEEN_INFO_LEVEL = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local originalLevelUpPos = levelUpFrame.Position
local hiddenLevelUpPos = UDim2.new(1.5, 0, originalLevelUpPos.Y.Scale, originalLevelUpPos.Y.Offset)

levelUpFrame.Position = hiddenLevelUpPos
levelUpFrame.Visible = false

local accumulatedDistance = 0
local lastPosition: Vector3? = nil
local levelUpTimer: thread? = nil
local lastSpeedValue: number? = nil
local lastWinValue: number? = nil
local statsConnected = false

-- Popup throttle: only show speed popup every X seconds and only if gain is large enough
local POPUP_COOLDOWN = 1.5
local POPUP_MIN_GAIN = 5
local lastPopupTime = 0

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

	local speedVal = leaderstats:FindFirstChild("Speed")
	local levelVal = leaderstats:FindFirstChild("Level")
	local rebirthsVal = leaderstats:FindFirstChild("Rebirths")
	if not speedVal or not levelVal or not rebirthsVal then return end

	local currentSpeed = speedVal.Value
	local currentLevel = levelVal.Value
	local currentRebirths = rebirthsVal.Value

	if lastSpeedValue ~= nil then
		local gain = currentSpeed - lastSpeedValue
		local now = tick()
		if gain >= POPUP_MIN_GAIN and (now - lastPopupTime) >= POPUP_COOLDOWN then
			lastPopupTime = now
			EffectsSystem.ShowSpeedPopUp(gain)
		end
	end
	lastSpeedValue = currentSpeed

	local xpForCurrentLevel = getExperienceForLevel(currentLevel)
	local xpForNextLevel = getExperienceForLevel(currentLevel + 1)
	local xpNeededThisLevel = xpForNextLevel - xpForCurrentLevel
	local currentProgressXP = math.clamp(currentSpeed - xpForCurrentLevel, 0, xpNeededThisLevel)

	levelLabel.Text = "Level " .. NumberFormatter.Format(currentLevel)
	reqLabel.Text = NumberFormatter.Format(math.floor(currentProgressXP)) .. "/" .. NumberFormatter.Format(xpNeededThisLevel)
	totalSpeedLabel.Text = "Total Speed: " .. NumberFormatter.Format(currentSpeed)
	rebirthBoostLabel.Text = "Rebirth: +" .. NumberFormatter.Format(currentRebirths * REBIRTH_PERCENT_PER_STEP) .. "%"

	local percent = math.clamp(currentProgressXP / xpNeededThisLevel, 0, 1)
	TweenService:Create(progressFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
		Size = UDim2.new(percent, 0, 1, 0)
	}):Play()
end

local function updateWins()
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end
	local winsVal = leaderstats:FindFirstChild("Wins")
	if not winsVal then return end

	local currentWins = winsVal.Value
	if lastWinValue ~= nil then
		local gain = currentWins - lastWinValue
		if gain > 0 then EffectsSystem.ShowWinPopUp(gain) end
	end
	lastWinValue = currentWins
end

local function showLevelUp(oldLevel: number, newLevel: number)
	local oldSpeed = BASE_WALKSPEED + (oldLevel - 1) * SPEED_PER_LEVEL
	local newSpeed = BASE_WALKSPEED + (newLevel - 1) * SPEED_PER_LEVEL

	newLevelLabel.Text = "Level " .. NumberFormatter.Format(oldLevel) .. " > Level " .. NumberFormatter.Format(newLevel)
	newSpeedLabel.Text = "Speed " .. NumberFormatter.Format(oldSpeed) .. " > Speed " .. NumberFormatter.Format(newSpeed)

	if levelUpSound then levelUpSound:Play() end

	levelUpFrame.Visible = true
	TweenService:Create(levelUpFrame, TWEEN_INFO_LEVEL, {Position = originalLevelUpPos}):Play()

	if levelUpTimer then task.cancel(levelUpTimer) end
	levelUpTimer = task.delay(5, function()
		local tweenOut = TweenService:Create(levelUpFrame, TWEEN_INFO_LEVEL, {Position = hiddenLevelUpPos})
		tweenOut:Play()
		tweenOut.Completed:Wait()
		levelUpFrame.Visible = false
		levelUpTimer = nil
	end)
end

player.CharacterAdded:Connect(function()
	accumulatedDistance = 0
	lastPosition = nil
	task.wait(0.2)
	updateUI()
end)

RunService.Heartbeat:Connect(function()
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
		local distance = (
			Vector3.new(currentPosition.X, 0, currentPosition.Z)
			- Vector3.new(lastPosition.X, 0, lastPosition.Z)
		).Magnitude
		if distance > 0 and distance < 5 then
			accumulatedDistance += distance
		end
		if accumulatedDistance >= STUDS_REQUIRED then
			accumulatedDistance -= STUDS_REQUIRED
			addSpeedEvent:FireServer()
		end
	end
	lastPosition = currentPosition
end)

local function connectStats()
	if statsConnected then return end
	local leaderstats = player:WaitForChild("leaderstats", 10)
	if not leaderstats then return end

	statsConnected = true
	local speed = leaderstats:WaitForChild("Speed")
	local level = leaderstats:WaitForChild("Level")
	local wins = leaderstats:WaitForChild("Wins")
	local rebirths = leaderstats:WaitForChild("Rebirths")

	lastSpeedValue = speed.Value
	lastWinValue = wins.Value

	speed.Changed:Connect(updateUI)
	level.Changed:Connect(updateUI)
	rebirths.Changed:Connect(updateUI)
	wins.Changed:Connect(updateWins)

	updateUI()
end

connectStats()
levelUpEvent.OnClientEvent:Connect(showLevelUp)