-- GodModeLaserBypass : passe à travers les lasers si GodMode actif
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

RunService.Heartbeat:Connect(function()
    if not Player:GetAttribute("GodMode") then return end
    local char = Player.Character
    if not char then return end

    -- Désactiver la collision avec les parties taguées "Laser"
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Chercher les lasers dans workspace
    for _, plot in ipairs(workspace:FindFirstChild("Plots") and workspace.Plots:GetChildren() or {}) do
        local laser = plot:FindFirstChild("Laser")
        if laser then
            for _, part in ipairs(laser:GetDescendants()) do
                if part:IsA("BasePart") then
                    -- NoCollisionConstraint entre HRP et laser
                    local existing = part:FindFirstChild("GodModeNC_" .. Player.UserId)
                    if not existing then
                        local nc = Instance.new("NoCollisionConstraint")
                        nc.Name = "GodModeNC_" .. Player.UserId
                        nc.Part0 = hrp
                        nc.Part1 = part
                        nc.Parent = part
                    end
                end
            end
        end
    end
end)

-- Nettoyer quand GodMode désactivé
Player:GetAttributeChangedSignal("GodMode"):Connect(function()
    if Player:GetAttribute("GodMode") then return end
    -- Supprimer tous les NoCollisionConstraints
    for _, plot in ipairs(workspace:FindFirstChild("Plots") and workspace.Plots:GetChildren() or {}) do
        local laser = plot:FindFirstChild("Laser")
        if laser then
            for _, part in ipairs(laser:GetDescendants()) do
                local nc = part:FindFirstChild("GodModeNC_" .. Player.UserId)
                if nc then nc:Destroy() end
            end
        end
    end
end)
