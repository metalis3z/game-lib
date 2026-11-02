local Players = game:GetService("Players")
local player = Players.LocalPlayer
local levelsText = script.Parent

-- Try to find Level value in leaderstats or ReplicatedStorage
local function getLevelValue()
    -- Check leaderstats first
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local level = leaderstats:FindFirstChild("Levels")
        if level then
            return level
        end
    end
    -- Fallback: check ReplicatedStorage.Values
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = ReplicatedStorage:FindFirstChild("Values")
    if valuesFolder then
        local level = valuesFolder:FindFirstChild("Levels")
        if level then
            return level
        end
    end
    return nil
end

local levelValue = getLevelValue()

local function updateLevel()
    if levelValue then
		levelsText.Text = "" .. tostring(levelValue.Value)
    else
		levelsText.Text = ""
    end
end

updateLevel()

if levelValue then
    levelValue.Changed:Connect(updateLevel)
end

-- Listen for leaderstats or Level being added later
player.ChildAdded:Connect(function(child)
    if child.Name == "leaderstats" then
        local level = child:FindFirstChild("Level")
        if level then
            levelValue = level
            updateLevel()
            levelValue.Changed:Connect(updateLevel)
        else
            child.ChildAdded:Connect(function(grandchild)
                if grandchild.Name == "Level" then
                    levelValue = grandchild
                    updateLevel()
                    levelValue.Changed:Connect(updateLevel)
                end
            end)
        end
    end
end)

if levelValue == nil then
    -- Listen for Level being added to ReplicatedStorage.Values
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = ReplicatedStorage:FindFirstChild("Values")
    if valuesFolder then
        valuesFolder.ChildAdded:Connect(function(child)
            if child.Name == "Level" then
                levelValue = child
                updateLevel()
                levelValue.Changed:Connect(updateLevel)
            end
        end)
    end
end