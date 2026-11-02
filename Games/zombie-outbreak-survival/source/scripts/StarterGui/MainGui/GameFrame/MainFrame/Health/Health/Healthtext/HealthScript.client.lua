local Players = game:GetService("Players")
local player = Players.LocalPlayer
local healthText = script.Parent

-- Function to update health display
local function updateHealth(humanoid)
    if humanoid.Health <= 0 then
        healthText.Text = "You Died"
    else
        local current = math.floor(humanoid.Health)
        local max = math.floor(humanoid.MaxHealth)
        healthText.Text = tostring(current) .. "/" .. tostring(max) .. "%"
    end
end

-- Connect to humanoid health changes
local function connectHumanoid(humanoid)
    updateHealth(humanoid)
    humanoid.HealthChanged:Connect(function()
        updateHealth(humanoid)
    end)
end

-- Listen for character spawn
local function onCharacter(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        connectHumanoid(humanoid)
    else
        character.ChildAdded:Connect(function(child)
            if child:IsA("Humanoid") then
                connectHumanoid(child)
            end
        end)
    end
end

-- Initial connect
if player.Character then
    onCharacter(player.Character)
end

player.CharacterAdded:Connect(onCharacter)

