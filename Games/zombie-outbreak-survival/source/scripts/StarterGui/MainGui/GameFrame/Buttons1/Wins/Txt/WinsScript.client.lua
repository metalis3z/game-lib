local Players = game:GetService("Players")
local player = Players.LocalPlayer
local winsText = script.Parent

-- Try to find Wins value in leaderstats or ReplicatedStorage
local function getWinsValue()
    -- Check leaderstats first
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local wins = leaderstats:FindFirstChild("Wins")
        if wins then
            return wins
        end
    end
    -- Fallback: check ReplicatedStorage.Values
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = ReplicatedStorage:FindFirstChild("Values")
    if valuesFolder then
        local wins = valuesFolder:FindFirstChild("Wins")
        if wins then
            return wins
        end
    end
    return nil
end

local winsValue = getWinsValue()

local function updateWins()
    if winsValue then
		winsText.Text = "" .. tostring(winsValue.Value)
    else
		winsText.Text = ""
    end
end

updateWins()

if winsValue then
    winsValue.Changed:Connect(updateWins)
end

-- Listen for leaderstats or Wins being added later
player.ChildAdded:Connect(function(child)
    if child.Name == "leaderstats" then
        local wins = child:FindFirstChild("Wins")
        if wins then
            winsValue = wins
            updateWins()
            winsValue.Changed:Connect(updateWins)
        else
            child.ChildAdded:Connect(function(grandchild)
                if grandchild.Name == "Wins" then
                    winsValue = grandchild
                    updateWins()
                    winsValue.Changed:Connect(updateWins)
                end
            end)
        end
    end
end)

if winsValue == nil then
    -- Listen for Wins being added to ReplicatedStorage.Values
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = ReplicatedStorage:FindFirstChild("Values")
    if valuesFolder then
        valuesFolder.ChildAdded:Connect(function(child)
            if child.Name == "Wins" then
                winsValue = child
                updateWins()
                winsValue.Changed:Connect(updateWins)
            end
        end)
    end
end

