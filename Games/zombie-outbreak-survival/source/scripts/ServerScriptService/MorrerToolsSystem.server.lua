local Players = game:GetService("Players")

-- Helper: Move all equipped tools to Inventory (Backpack)
local function moveEquippedToInventory(player)
    if player.Character and player:FindFirstChild("Backpack") then
        local character = player.Character
        local inventory = player:FindFirstChild("Backpack")
        local charChildren = character:GetChildren()
        for i = 1, #charChildren do
            local v = charChildren[i]
            if v:IsA("Tool") then
                v.Parent = inventory
            end
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        local humanoid = char:FindFirstChildWhichIsA("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                moveEquippedToInventory(player)
                -- Optionally: trigger inventory save if needed
            end)
        end
    end)
end)

