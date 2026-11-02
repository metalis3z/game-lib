local Players = game:GetService("Players")
local player = Players.LocalPlayer
local killsText = script.Parent

-- Try to find Kills value in leaderstats or ReplicatedStorage
local function getKillsValue()
    -- Check leaderstats first
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local kills = leaderstats:FindFirstChild("Kills")
        if kills then
            return kills
        end
    end
    -- Fallback: check ReplicatedStorage.Values
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = ReplicatedStorage:FindFirstChild("Values")
    if valuesFolder then
        local kills = valuesFolder:FindFirstChild("Kills")
        if kills then
            return kills
        end
    end
    return nil
end

local killsValue = getKillsValue()

local function updateKills()
    if killsValue then
		killsText.Text = "" .. tostring(killsValue.Value)
    else
		killsText.Text = ""
    end
end

updateKills()

if killsValue then
    killsValue.Changed:Connect(updateKills)
end

-- Listen for leaderstats or Kills being added later
player.ChildAdded:Connect(function(child)
    if child.Name == "leaderstats" then
        local kills = child:FindFirstChild("Kills")
        if kills then
            killsValue = kills
            updateKills()
            killsValue.Changed:Connect(updateKills)
        else
            child.ChildAdded:Connect(function(grandchild)
                if grandchild.Name == "Kills" then
                    killsValue = grandchild
                    updateKills()
                    killsValue.Changed:Connect(updateKills)
                end
            end)
        end
    end
end)

if killsValue == nil then
    -- Listen for Kills being added to ReplicatedStorage.Values
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = ReplicatedStorage:FindFirstChild("Values")
    if valuesFolder then
        valuesFolder.ChildAdded:Connect(function(child)
            if child.Name == "Kills" then
                killsValue = child
                updateKills()
                killsValue.Changed:Connect(updateKills)
            end
        end)
    end
end

