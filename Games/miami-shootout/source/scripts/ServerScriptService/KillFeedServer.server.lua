
-- // Services

-- Default services
local replicatedStorage = game:GetService("ReplicatedStorage")
local playersService = game:GetService("Players")

-- // Variables

-- Comms variables
local killEvent = replicatedStorage:WaitForChild("KillNotification")

-- // Events
playersService.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        
        local humanoid = character:WaitForChild("Humanoid")
        
        humanoid.Died:Connect(function()
            
            local creator = humanoid:FindFirstChild("creator")
            
            if creator then
                local killer = creator.Value
                
                if killer then
                    killEvent:FireClient(killer, player)
                end
            end
            
        end)
        
    end)
end)