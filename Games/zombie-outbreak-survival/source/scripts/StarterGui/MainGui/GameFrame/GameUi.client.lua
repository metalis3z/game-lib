local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Find MainGUI
local mainGui = playerGui:FindFirstChild("MainGUI")
if not mainGui then
    mainGui = script.Parent.Parent
end

-- Find GameFrame and MainFrame
local gameFrame = mainGui:FindFirstChild("GameFrame")
local mainFrame = gameFrame and gameFrame:FindFirstChild("MainFrame")

-- Find Status and Wave labels
local statusLabel = mainFrame and mainFrame:FindFirstChild("Status")
local waveLabel = mainFrame and mainFrame:FindFirstChild("Wave")

-- Get ReplicatedStorage.Values
local valuesFolder = ReplicatedStorage:FindFirstChild("Values")
local roundMsg = valuesFolder and valuesFolder:FindFirstChild("roundMsg")
local zombiesAlive = valuesFolder and valuesFolder:FindFirstChild("zombiesAlive")

-- Function to update Status label
local function updateStatus()
    if statusLabel and roundMsg then
        statusLabel.Text = tostring(roundMsg.Value)
    elseif statusLabel then
        statusLabel.Text = ""
    end
end

-- Function to update Wave label
local function updateWave()
    if waveLabel and zombiesAlive then
        waveLabel.Text = "Zombies Left: " .. tostring(zombiesAlive.Value)
    elseif waveLabel then
        waveLabel.Text = ""
    end
end

-- Initial update
updateStatus()
updateWave()

-- Listen for changes
if roundMsg then
    roundMsg.Changed:Connect(updateStatus)
end
if zombiesAlive then
    zombiesAlive.Changed:Connect(updateWave)
end

-- Listen for values being added later
if valuesFolder then
    valuesFolder.ChildAdded:Connect(function(child)
        if child.Name == "roundMsg" then
            roundMsg = child
            updateStatus()
            roundMsg.Changed:Connect(updateStatus)
        elseif child.Name == "zombiesAlive" then
            zombiesAlive = child
            updateWave()
            zombiesAlive.Changed:Connect(updateWave)
        end
    end)
end

-- Listen for UI being added later
if mainFrame then
    mainFrame.ChildAdded:Connect(function(child)
        if child.Name == "Status" then
            statusLabel = child
            updateStatus()
        elseif child.Name == "Wave" then
            waveLabel = child
            updateWave()
        end
    end)
end

