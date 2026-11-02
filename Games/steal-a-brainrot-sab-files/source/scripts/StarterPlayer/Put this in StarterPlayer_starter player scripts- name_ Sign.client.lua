--[[
	SignClient - Client-side integration for the SignService.
	
	This script handles:
	  - Authorization check (determines if sign UI should be shown)
	  - Adding "Sign" ProximityPrompts to brainrots on the player's plot
	  - Displaying the sign GUI with Super Sign and Normal Sign options
	  - Communicating with SignService via RemoteEvents
	
	Security Note:
	  - The client-side auth check is ONLY for UI visibility
	  - All real authorization is enforced server-side in SignService
	  - Exploiters cannot bypass the server-side checks
--]]

-- ============== SERVICES ==============
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- ============== PLAYER REFERENCE ==============
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============== WAIT FOR SIGN SERVICE REMOTES ==============
local SignServiceFolder = ReplicatedStorage:WaitForChild("SignService", 30)
if not SignServiceFolder then
	return -- SignService not found, exiting silently
end

local SignRequest = SignServiceFolder:WaitForChild("SignRequest", 10)
local CheckAuth = SignServiceFolder:WaitForChild("CheckAuth", 10)
local SignResult = SignServiceFolder:WaitForChild("SignResult", 10)

-- ============== AUTHORIZATION CHECK ==============
-- Ask the server if this player is authorized to sign
-- If not, this script does nothing (no UI, no prompts)
local isAuthorized = false
pcall(function()
	isAuthorized = CheckAuth:InvokeServer()
end)

if not isAuthorized then
	return -- Not authorized - exit silently, no sign features for this player
end

-- ============== CONFIGURATION ==============
local CONFIG = {
	-- ProximityPrompt settings for the sign interaction
	PromptActionText = "Sign",
	PromptObjectText = "Brainrot",
	PromptMaxDistance = 10,
	PromptHoldDuration = 0.5,
	PromptKeyboardKey = Enum.KeyCode.G,
	PromptGamepadKey = Enum.KeyCode.ButtonX,
	-- Vertical offset to avoid overlapping existing prompts (Grab, Sell, etc.)
	PromptUIOffset = Vector2.new(0, -144),

	-- GUI animation settings
	GuiFadeTime = 0.2,
	ResultDisplayTime = 2.0,
}

-- ============== STATE ==============
local selectedPodiumIndex = nil
local signPrompts = {} -- Maps podium index -> ProximityPrompt
local plotModel = nil  -- Reference to the player's plot model

-- ============== GUI CREATION ==============
--- Builds the sign prompt GUI programmatically
--- @return ScreenGui The constructed sign GUI
local function createSignGui()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "SignGui"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.IgnoreGuiInset = true
	screenGui.Enabled = false

	-- Semi-transparent background overlay (click to close)
	local background = Instance.new("Frame")
	background.Name = "Background"
	background.Size = UDim2.new(1, 0, 1, 0)
	background.BackgroundColor3 = Color3.new(0, 0, 0)
	background.BackgroundTransparency = 0.5
	background.BorderSizePixel = 0
	background.Parent = screenGui

	-- Invisible button over the background for click-to-close
	local bgButton = Instance.new("TextButton")
	bgButton.Name = "BackgroundButton"
	bgButton.Size = UDim2.new(1, 0, 1, 0)
	bgButton.BackgroundTransparency = 1
	bgButton.Text = ""
	bgButton.Parent = background

	-- Main container frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.new(0, 320, 0, 220)
	mainFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
	mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui

	local mainCorner = Instance.new("UICorner")
	mainCorner.CornerRadius = UDim.new(0, 14)
	mainCorner.Parent = mainFrame

	local mainStroke = Instance.new("UIStroke")
	mainStroke.Color = Color3.fromRGB(80, 80, 120)
	mainStroke.Thickness = 2
	mainStroke.Parent = mainFrame

	-- Title label
	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Size = UDim2.new(1, 0, 0, 45)
	title.Position = UDim2.new(0, 0, 0, 0)
	title.BackgroundTransparency = 1
	title.Text = "Sign Brainrot"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 22
	title.Font = Enum.Font.GothamBold
	title.Parent = mainFrame

	-- Decorative line under the title
	local divider = Instance.new("Frame")
	divider.Name = "Divider"
	divider.Size = UDim2.new(0.8, 0, 0, 1)
	divider.Position = UDim2.new(0.1, 0, 0, 45)
	divider.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
	divider.BorderSizePixel = 0
	divider.Parent = mainFrame

	-- Super Sign button (gold/premium style)
	local superSignBtn = Instance.new("TextButton")
	superSignBtn.Name = "SuperSignButton"
	superSignBtn.Size = UDim2.new(0.85, 0, 0, 50)
	superSignBtn.Position = UDim2.new(0.075, 0, 0, 58)
	superSignBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
	superSignBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	superSignBtn.Text = "Super Sign"
	superSignBtn.TextSize = 18
	superSignBtn.Font = Enum.Font.GothamBold
	superSignBtn.BorderSizePixel = 0
	superSignBtn.AutoButtonColor = true
	superSignBtn.Parent = mainFrame

	local superCorner = Instance.new("UICorner")
	superCorner.CornerRadius = UDim.new(0, 10)
	superCorner.Parent = superSignBtn

	-- Super sign subtitle
	local superSubLabel = Instance.new("TextLabel")
	superSubLabel.Name = "SuperSubLabel"
	superSubLabel.Size = UDim2.new(0.85, 0, 0, 16)
	superSubLabel.Position = UDim2.new(0.075, 0, 0, 108)
	superSubLabel.BackgroundTransparency = 1
	superSubLabel.Text = "Applies Super Nova Sign trait (10x multiplier)"
	superSubLabel.TextColor3 = Color3.fromRGB(200, 170, 100)
	superSubLabel.TextSize = 11
	superSubLabel.Font = Enum.Font.Gotham
	superSubLabel.Parent = mainFrame

	-- Normal Sign button (blue/standard style)
	local normalSignBtn = Instance.new("TextButton")
	normalSignBtn.Name = "NormalSignButton"
	normalSignBtn.Size = UDim2.new(0.85, 0, 0, 50)
	normalSignBtn.Position = UDim2.new(0.075, 0, 0, 128)
	normalSignBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 220)
	normalSignBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	normalSignBtn.Text = "Normal Sign"
	normalSignBtn.TextSize = 18
	normalSignBtn.Font = Enum.Font.GothamBold
	normalSignBtn.BorderSizePixel = 0
	normalSignBtn.AutoButtonColor = true
	normalSignBtn.Parent = mainFrame

	local normalCorner = Instance.new("UICorner")
	normalCorner.CornerRadius = UDim.new(0, 10)
	normalCorner.Parent = normalSignBtn

	-- Normal sign subtitle
	local normalSubLabel = Instance.new("TextLabel")
	normalSubLabel.Name = "NormalSubLabel"
	normalSubLabel.Size = UDim2.new(0.85, 0, 0, 16)
	normalSubLabel.Position = UDim2.new(0.075, 0, 0, 178)
	normalSubLabel.BackgroundTransparency = 1
	normalSubLabel.Text = "Applies Nova Sign trait (5x multiplier)"
	normalSubLabel.TextColor3 = Color3.fromRGB(100, 170, 220)
	normalSubLabel.TextSize = 11
	normalSubLabel.Font = Enum.Font.Gotham
	normalSubLabel.Parent = mainFrame

	-- Status label (shows success/error messages)
	local statusLabel = Instance.new("TextLabel")
	statusLabel.Name = "StatusLabel"
	statusLabel.Size = UDim2.new(1, 0, 0, 24)
	statusLabel.Position = UDim2.new(0, 0, 1, -24)
	statusLabel.BackgroundTransparency = 1
	statusLabel.Text = ""
	statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	statusLabel.TextSize = 12
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.TextWrapped = true
	statusLabel.Parent = mainFrame

	return screenGui
end

-- ============== INSTANTIATE GUI ==============
local signGui = createSignGui()
signGui.Parent = playerGui

-- ============== GUI REFERENCES ==============
local mainFrame = signGui:WaitForChild("MainFrame")
local superSignBtn = mainFrame:WaitForChild("SuperSignButton")
local normalSignBtn = mainFrame:WaitForChild("NormalSignButton")
local bgButton = signGui:WaitForChild("Background"):WaitForChild("BackgroundButton")
local statusLabel = mainFrame:WaitForChild("StatusLabel")

-- ============== GUI LOGIC ==============

--- Close the sign GUI and reset state
local function closeGui()
	signGui.Enabled = false
	selectedPodiumIndex = nil
	statusLabel.Text = ""
end

--- Open the sign GUI for a specific podium
--- @param podiumIndex number The podium the player wants to sign
local function openGui(podiumIndex)
	selectedPodiumIndex = podiumIndex
	statusLabel.Text = ""
	signGui.Enabled = true
end

-- Click background to close
bgButton.MouseButton1Click:Connect(closeGui)

-- Super Sign button handler
superSignBtn.MouseButton1Click:Connect(function()
	if not selectedPodiumIndex then return end
	superSignBtn.Active = false
	normalSignBtn.Active = false
	statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	statusLabel.Text = "Applying Super Sign..."
	SignRequest:FireServer(selectedPodiumIndex, "SuperSign")
end)

-- Normal Sign button handler
normalSignBtn.MouseButton1Click:Connect(function()
	if not selectedPodiumIndex then return end
	superSignBtn.Active = false
	normalSignBtn.Active = false
	statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	statusLabel.Text = "Applying Normal Sign..."
	SignRequest:FireServer(selectedPodiumIndex, "NormalSign")
end)

-- Handle sign results from the server
SignResult.OnClientEvent:Connect(function(success, message)
	if success then
		statusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
	else
		statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
	end
	statusLabel.Text = message

	-- Re-enable buttons
	superSignBtn.Active = true
	normalSignBtn.Active = true

	-- Auto-close on success after a brief delay
	if success then
		task.delay(CONFIG.ResultDisplayTime, function()
			if signGui.Enabled then
				closeGui()
			end
		end)
	end
end)

-- ============== PROXIMITY PROMPT MANAGEMENT ==============

--- Create a "Sign" ProximityPrompt on a podium
--- @param podium Instance The podium model to add the prompt to
local function addSignPrompt(podium)
	local podiumIndex = tonumber(podium.Name)
	if not podiumIndex then return end

	-- Don't add duplicate prompts
	if signPrompts[podiumIndex] then return end

	-- Find the attachment point for the prompt
	local base = podium:FindFirstChild("Base")
	if not base then return end

	local spawn = base:FindFirstChild("Spawn")
	if not spawn then return end

	local promptAttachment = spawn:FindFirstChild("PromptAttachment")
	if not promptAttachment then return end

	-- Create the sign ProximityPrompt
	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "SignPrompt"
	prompt.ActionText = CONFIG.PromptActionText
	prompt.ObjectText = CONFIG.PromptObjectText
	prompt.MaxActivationDistance = CONFIG.PromptMaxDistance
	prompt.HoldDuration = CONFIG.PromptHoldDuration
	prompt.RequiresLineOfSight = true
	prompt.KeyboardKeyCode = CONFIG.PromptKeyboardKey
	prompt.GamepadKeyCode = CONFIG.PromptGamepadKey
	prompt.UIOffset = CONFIG.PromptUIOffset
	prompt.Parent = promptAttachment

	signPrompts[podiumIndex] = prompt

	-- When the player triggers this prompt, open the sign GUI
	prompt.Triggered:Connect(function(triggeringPlayer)
		if triggeringPlayer ~= player then return end
		openGui(podiumIndex)
	end)
end

--- Remove a sign ProximityPrompt from a podium
--- @param podiumIndex number The podium index to remove the prompt from
local function removeSignPrompt(podiumIndex)
	local prompt = signPrompts[podiumIndex]
	if prompt then
		prompt:Destroy()
		signPrompts[podiumIndex] = nil
	end
end

--- Set up sign prompts on all podiums in a plot model
--- @param targetPlotModel Instance The plot model containing AnimalPodiums
local function setupPromptsOnPlot(targetPlotModel)
	local animalPodiums = targetPlotModel:FindFirstChild("AnimalPodiums")
	if not animalPodiums then return end

	-- Add prompts to existing podiums
	for _, podium in animalPodiums:GetChildren() do
		if podium:IsA("Model") or podium:IsA("Folder") then
			addSignPrompt(podium)
		end
	end

	-- Watch for new podiums being added (e.g., when plot tier upgrades)
	animalPodiums.ChildAdded:Connect(function(podium)
		task.wait(1) -- Wait for podium to fully load
		if podium:IsA("Model") or podium:IsA("Folder") then
			addSignPrompt(podium)
		end
	end)

	-- Clean up prompts when podiums are removed
	animalPodiums.ChildRemoved:Connect(function(podium)
		local podiumIndex = tonumber(podium.Name)
		if podiumIndex then
			removeSignPrompt(podiumIndex)
		end
	end)
end

-- ============== PLOT DISCOVERY ==============
-- Find the player's plot using the same pattern as PlotController:
-- observe instances tagged "Plot" and check ownership via Synchronizer channel

local Observers = require(ReplicatedStorage:WaitForChild("Packages", 5):WaitForChild("Observers", 5))
local Synchronizer = require(ReplicatedStorage:WaitForChild("Packages", 5):WaitForChild("Synchronizer", 5))

--- Check if a plot model belongs to the local player
--- @param plotInstance Instance The plot model to check
--- @return boolean True if the local player owns this plot
local function isMyPlot(plotInstance)
	-- Try to get the UID from the plot (used by PlotClient)
	-- The PlotClient stores its UID as an attribute or we can find it
	-- via the Synchronizer channel

	-- Method 1: Check if the PlotController already identified this as our plot
	local success, plotController = pcall(function()
		return require(ReplicatedStorage.Controllers.PlotController)
	end)

	if success and plotController then
		local myPlot = plotController.GetMyPlot()
		if myPlot and myPlot.PlotModel == plotInstance then
			return true
		end
	end

	return false
end

-- Use the Observers package to watch for Plot-tagged instances
-- This is the same pattern used by PlotController
Observers.observeTag("Plot", function(plotInstance)
	local trove = require(ReplicatedStorage:WaitForChild("Packages", 5):WaitForChild("Trove", 5)).new()

	trove:Add(task.spawn(function()
		-- Wait for the plot to be fully loaded
		while not plotInstance:GetAttribute("Loaded") and plotInstance:IsDescendantOf(workspace) do
			task.wait()
		end

		if not plotInstance:IsDescendantOf(workspace) then return end

		-- Check if this plot belongs to the local player
		if isMyPlot(plotInstance) then
			plotModel = plotInstance
			setupPromptsOnPlot(plotModel)
		end
	end))

	return trove:WrapClean()
end)

-- ============== FALLBACK PLOT DISCOVERY ==============
-- If the observer-based approach doesn't find the plot quickly,
-- fall back to polling PlotController.GetMyPlot()
task.spawn(function()
	task.wait(5) -- Give the observer system time to find the plot first

	if plotModel then return end -- Already found via observer

	-- Fallback: poll PlotController.GetMyPlot()
	local maxAttempts = 30
	for attempt = 1, maxAttempts do
		local success, plotController = pcall(function()
			return require(ReplicatedStorage.Controllers.PlotController)
		end)

		if success and plotController then
			local myPlot = plotController.GetMyPlot()
			if myPlot and myPlot.PlotModel then
				plotModel = myPlot.PlotModel
				setupPromptsOnPlot(plotModel)
				return
			end
		end

		task.wait(2)
	end
end)