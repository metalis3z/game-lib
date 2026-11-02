local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local remotes = ReplicatedStorage:WaitForChild("Remotes")
local levelUpEvent = remotes:WaitForChild("LevelUpEvent")

-- UI Components
local levelUpGui = script.Parent
local levelUpFrame = levelUpGui:WaitForChild("LevelUpFrame")
local levelDisplay = levelUpFrame:WaitForChild("LevelDisplay")
local levelSound = levelUpFrame:WaitForChild("LevelSound")

-- Initialize UI - make sure it's properly hidden at start
levelUpFrame.Visible = false

-- Function to get player level with proper waiting
local function getPlayerLevel()
	-- Wait for leaderstats to exist
	local leaderstats = player:WaitForChild("leaderstats", 10)
	if leaderstats then
		-- Wait for Levels to exist
		local levels = leaderstats:WaitForChild("Levels", 5)
		if levels then
			return levels.Value
		end
	end
	return 1
end

-- Function to show level up notification
local function showLevelUpNotification()
	
	-- Get current level
	local currentLevel = getPlayerLevel()
	print("Current level: " .. currentLevel)
	
	-- Update text with current level
	levelDisplay.Text = "LEVEL UP!\nLevel " .. currentLevel
	
	-- Make sure frame is visible and has proper transparency
	levelUpFrame.Visible = true
	levelDisplay.TextTransparency = 0
	
	-- Play sound
	if levelSound then
		levelSound:Play()
		print("Sound played")
	else
		print("Sound not found")
	end
	
	-- Wait 5 seconds
	task.wait(5)
	
	-- Hide frame
	levelUpFrame.Visible = false
end

-- Connect to level up event
levelUpEvent.OnClientEvent:Connect(function()
	showLevelUpNotification()
end)