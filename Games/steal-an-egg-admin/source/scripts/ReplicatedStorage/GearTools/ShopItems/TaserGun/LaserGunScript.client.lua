-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local LocalPlayer = Players.LocalPlayer
local Parent = script.Parent
local LaserGunRemote = Parent.LaserGunRemote
local v1 = LocalPlayer:GetMouse()

local function getRootPart(v2) -- line 13
    local PrimaryPart = v2.PrimaryPart
    if PrimaryPart then
        return PrimaryPart
    end
    local HumanoidRootPart = v2:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

Parent.Activated:Connect(function() -- line 27 | captures: ToolGameplayGuard, LocalPlayer, Parent, LaserGunRemote, v1
    if ToolGameplayGuard.AllowsLocalUse(Parent) then
        local Character = LocalPlayer.Character
        if Character then
            local PrimaryPart = Character.PrimaryPart
            if not PrimaryPart then
                PrimaryPart = Character:FindFirstChild("HumanoidRootPart")
                if not (PrimaryPart and PrimaryPart:IsA("BasePart")) then
                    PrimaryPart = nil
                end
            end
            if PrimaryPart then
                local v3 = v1.Hit.Position - PrimaryPart.Position
                local Magnitude = v3.Magnitude
                if Magnitude ~= 0 and Magnitude == Magnitude then
                    LaserGunRemote:FireServer({ direction = v3.Unit })
                end
            end
        end
    end
end)
