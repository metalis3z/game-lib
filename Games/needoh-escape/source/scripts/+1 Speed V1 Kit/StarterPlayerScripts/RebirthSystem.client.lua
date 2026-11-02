--!strict
-- LOCATION: StarterPlayerScripts/RebirthSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
local NotificationManager = require(ReplicatedStorage.Modules.NotificationManager)
local Fireworks = require(ReplicatedStorage.Modules.Fireworks)
local MonetizationSystem = require(ReplicatedStorage.Modules.MonetizationSystem)
local ProductConfigurations = require(ReplicatedStorage.Modules.ProductConfigurations)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local gui = playerGui:WaitForChild("GUI")

local eventsFolder = ReplicatedStorage:WaitForChild("Events")
local requestRebirthFunc = eventsFolder:WaitForChild("RequestRebirth") :: RemoteFunction
local rebirthSuccessEvent = eventsFolder:WaitForChild("RebirthSuccess") :: RemoteEvent
-- FIX: RemoteFunction to get the correct required level from server (uses new scaling)
local getRebirthRequiredLevelFunc = eventsFolder:WaitForChild("GetRebirthRequiredLevel") :: RemoteFunction

local frames = gui:WaitForChild("Frames")
local rebirthFrame = frames:WaitForChild("Rebirth")

-- FIX: Close button
local closeButton = rebirthFrame:FindFirstChild("CloseButton") :: ImageButton

local statsFrame = rebirthFrame:WaitForChild("Stats")
local beforeFrame = statsFrame:WaitForChild("Before")
local beforeLevelLabel = beforeFrame:WaitForChild("Level"):WaitForChild("Text") :: TextLabel
local beforeSpeedLabel = beforeFrame:WaitForChild("Speed"):WaitForChild("Text") :: TextLabel
local afterFrame = statsFrame:WaitForChild("After")
local afterLevelLabel = afterFrame:WaitForChild("Level"):WaitForChild("Text") :: TextLabel
local afterSpeedLabel = afterFrame:WaitForChild("Speed"):WaitForChild("Text") :: TextLabel

local barFrame = rebirthFrame:WaitForChild("Bar")
local progressFrame = barFrame:WaitForChild("Progress")
local progressLabel = barFrame:WaitForChild("Level") :: TextLabel

local rebirthButton = rebirthFrame:WaitForChild("RebirthButton") :: ImageButton
local rebirthButtonText = rebirthButton:WaitForChild("Text") :: TextLabel
local skipButton = rebirthFrame:WaitForChild("SkipButton") :: ImageButton

local hud = gui:WaitForChild("HUD")
local hudLeft = hud:WaitForChild("Left")
local hudRebirthButton = hudLeft:WaitForChild("Rebirth")
local hudNotification = hudRebirthButton:WaitForChild("Notification")

local REBIRTH_MULT_ADD = 0.8
local statsConnected = false

local function formatMult(val: number): string
	return "x" .. string.format("%.2f", val)
end

-- FIX: Use the server-side scaling function via RemoteFunction
local function getRequiredLevel(rebirths: number): number
	local ok, result = pcall(function()
		return getRebirthRequiredLevelFunc:InvokeServer()
	end)
	if ok and type(result) == "number" then
		return result
	end
	-- Fallback: flat formula
	return (rebirths + 1) * 5
end

local function updateRebirthUI()
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end

	local rebirthsVal = leaderstats:FindFirstChild("Rebirths")
	local levelVal = leaderstats:FindFirstChild("Level")
	if not rebirthsVal or not levelVal then return end

	local currentRebirths = rebirthsVal.Value
	local currentLevel = levelVal.Value

	-- FIX: Pull required level from server using the new scaling logic
	local reqLevel = getRequiredLevel(currentRebirths)
	-- For "After" preview, get the requirement for the rebirth after next
	local nextReqLevel = 0
	local ok2, res2 = pcall(function()
		-- Temporarily we compute client-side for preview only
		-- Easy zone: rebirths+1 <= 10 → flat *5; else exponential
		local nextRebirth = currentRebirths + 2
		if nextRebirth <= 10 then
			return nextRebirth * 5
		else
			local stepsAbove = nextRebirth - 10
			return math.floor(50 * (1.35 ^ stepsAbove))
		end
	end)
	if ok2 then nextReqLevel = res2 end

	local currentMult = 1 + (currentRebirths * REBIRTH_MULT_ADD)
	local nextMult = 1 + ((currentRebirths + 1) * REBIRTH_MULT_ADD)

	beforeLevelLabel.Text = "Level " .. NumberFormatter.Format(reqLevel)
	beforeSpeedLabel.Text = formatMult(currentMult)
	afterLevelLabel.Text = "Level " .. NumberFormatter.Format(nextReqLevel)
	afterSpeedLabel.Text = formatMult(nextMult)

	local displayLevel = math.min(currentLevel, reqLevel)
	progressLabel.Text = NumberFormatter.Format(displayLevel) .. "/" .. NumberFormatter.Format(reqLevel)

	local progress = math.clamp(currentLevel / reqLevel, 0, 1)
	TweenService:Create(progressFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
		Size = UDim2.new(progress, 0, 1, 0)
	}):Play()

	if currentLevel >= reqLevel then
		rebirthButton.AutoButtonColor = true
		rebirthButtonText.Text = "Rebirth"
		hudNotification.Visible = true
	else
		rebirthButton.AutoButtonColor = false
		rebirthButtonText.Text = "No Levels"
		hudNotification.Visible = false
	end
end

local function onRebirthSuccess()
	NotificationManager.show("Rebirth Successful!", "Success")
	local character = player.Character
	if character then
		local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
		if rootPart then Fireworks.PlayFireworks(rootPart) end
	end
end

-- FIX: Close button
if closeButton then
	closeButton.MouseButton1Click:Connect(function()
		rebirthFrame.Visible = false
	end)
end

local isRebirthing = false

rebirthButton.MouseButton1Click:Connect(function()
	if isRebirthing then return end
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end
	local currentLevel = leaderstats.Level.Value
	local currentRebirths = leaderstats.Rebirths.Value
	local reqLevel = getRequiredLevel(currentRebirths)
	if currentLevel < reqLevel then
		NotificationManager.show("You need Level " .. NumberFormatter.Format(reqLevel) .. " to Rebirth!", "Error")
		return
	end
	isRebirthing = true
	local success = requestRebirthFunc:InvokeServer()
	if not success then
		NotificationManager.show("Rebirth Failed. Please try again.", "Error")
	end
	isRebirthing = false
end)

skipButton.MouseButton1Click:Connect(function()
	MonetizationSystem.PromptProduct(ProductConfigurations.SkipRebirthId)
end)

rebirthFrame:GetPropertyChangedSignal("Visible"):Connect(function()
	if rebirthFrame.Visible then updateRebirthUI() end
end)

local function connectStats()
	if statsConnected then return end
	local leaderstats = player:WaitForChild("leaderstats", 10)
	if not leaderstats then return end
	statsConnected = true

	leaderstats:WaitForChild("Level").Changed:Connect(updateRebirthUI)
	leaderstats:WaitForChild("Rebirths").Changed:Connect(updateRebirthUI)
	updateRebirthUI()
end

connectStats()
rebirthSuccessEvent.OnClientEvent:Connect(onRebirthSuccess)