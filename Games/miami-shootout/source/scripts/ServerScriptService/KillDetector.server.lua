
-- // Services

-- Default services
local replicatedStorage = game:GetService("ReplicatedStorage")

-- // Variables

-- Comms variables
local killEvent = replicatedStorage:WaitForChild("KillNotification")

-- NPC variables
local figure = script.Parent
local humanoid = figure:WaitForChild("Humanoid")

-- // Events
humanoid.Died:Connect(function()

    local creator = humanoid:FindFirstChild("creator")

    if creator then
        local killer = creator.Value

        if killer then
            killEvent:FireClient(killer, figure)
        end
    end

end)