-- ResetHandler v2 - Force unragdoll avant reset
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ResetRemote = ReplicatedStorage:FindFirstChild("PlayerReset") or Instance.new("RemoteEvent")
ResetRemote.Name = "PlayerReset"
ResetRemote.Parent = ReplicatedStorage

local RagdollService = require(game:GetService("ServerScriptService").Services.RagdollService)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

ResetRemote.OnServerEvent:Connect(function(player)
    if not player.Character then return end
    
    -- Cooldown anti-spam reset (2s)
    if player:GetAttribute("ResetCooldown") then return end
    player:SetAttribute("ResetCooldown", true)
    task.delay(2, function() player:SetAttribute("ResetCooldown", nil) end)
    
    player:SetAttribute("IsResetting", true)
    
    local char = player.Character
    if char then
        -- 1. Force unragdoll si bloqué
        pcall(Ragdoll.Unragdoll, Ragdoll, char)
        pcall(RagdollService.Unragdoll, RagdollService, char)
        
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            -- 2. Reset PlatformStand et Sit
            hum.PlatformStand = false
            hum.Sit = false
            task.wait(0.05)
            -- 3. Tuer le humanoid
            hum.Health = 0
        end
    end
    
    -- Retirer le flag après respawn
    local conn
    conn = player.CharacterAdded:Connect(function()
        task.wait(0.1)
        player:SetAttribute("IsResetting", nil)
        if conn then conn:Disconnect() end
    end)
    task.delay(5, function()
        player:SetAttribute("IsResetting", nil)
    end)
end)
