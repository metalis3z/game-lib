local Players = game:GetService("Players")
local player = Players.LocalPlayer
local moneyText = script.Parent

-- Try to find Money value in leaderstats or ReplicatedStorage
local function getMoneyValue()
    -- Check leaderstats first
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local money = leaderstats:FindFirstChild("Money")
        if money then
            return money
        end
    end
    -- Fallback: check ReplicatedStorage.Values
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = ReplicatedStorage:FindFirstChild("Values")
    if valuesFolder then
        local money = valuesFolder:FindFirstChild("Money")
        if money then
            return money
        end
    end
    return nil
end

local moneyValue = getMoneyValue()

local function updateMoney()
    if moneyValue then
		moneyText.Text = "" .. tostring(moneyValue.Value)
    else
		moneyText.Text = ""
    end
end

updateMoney()

if moneyValue then
    moneyValue.Changed:Connect(updateMoney)
end

-- Listen for leaderstats or Money being added later
player.ChildAdded:Connect(function(child)
    if child.Name == "leaderstats" then
        local money = child:FindFirstChild("Money")
        if money then
            moneyValue = money
            updateMoney()
            moneyValue.Changed:Connect(updateMoney)
        else
            child.ChildAdded:Connect(function(grandchild)
                if grandchild.Name == "Money" then
                    moneyValue = grandchild
                    updateMoney()
                    moneyValue.Changed:Connect(updateMoney)
                end
            end)
        end
    end
end)

if moneyValue == nil then
    -- Listen for Money being added to ReplicatedStorage.Values
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = ReplicatedStorage:FindFirstChild("Values")
    if valuesFolder then
        valuesFolder.ChildAdded:Connect(function(child)
            if child.Name == "Money" then
                moneyValue = child
                updateMoney()
                moneyValue.Changed:Connect(updateMoney)
            end
        end)
    end
end

