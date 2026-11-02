-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Parent = script.Parent
require(ReplicatedStorage.Shared.Globals.Constants)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local v1 = 0
Parent.Activated:Connect(function() -- line 11 | captures: v1, LocalPlayer, Parent, Remotes, ToolGameplayGuard
    if ToolGameplayGuard.AllowsLocalUse(Parent) then
        local v2 = tick()
        if not (v2 - v1 < 1) and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
            v1 = v2
            local Character = LocalPlayer.Character
            local PrimaryPart = Character.PrimaryPart
            local LookVector = PrimaryPart.CFrame.LookVector
            local v3 = PrimaryPart.Position + LookVector * 4
            local v4 = RaycastParams.new()
            v4.FilterType = Enum.RaycastFilterType.Exclude
            v4.FilterDescendantsInstances = { Character }
            if not workspace:Raycast(PrimaryPart.Position, LookVector * 4, v4) then
                local X = v3.X
                local v5 = v3.Y + 5
                local Z = v3.Z
                local v6 = Vector3.new(X, v5, Z)
                local v7 = workspace:Raycast(v6, Vector3.new(0, -100, 0), v4)
                local v8 = if v7 then v7.Position else v3
                local GearName = Parent:GetAttribute("GearName")
                if typeof(GearName) ~= "string" then
                    GearName = Parent.Name
                end
                Remotes.TrapPlacement.AskPlace:FireServer(GearName, v8)
            end
        end
    end
end)
