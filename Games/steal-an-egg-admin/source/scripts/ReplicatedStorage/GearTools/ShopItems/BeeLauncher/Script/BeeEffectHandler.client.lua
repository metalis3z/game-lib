-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local function zoomCameraCloser() -- line 10
    local CurrentCamera = workspace.CurrentCamera
    if not CurrentCamera then
        return
    end
    local FieldOfView = CurrentCamera.FieldOfView
    CurrentCamera.FieldOfView = FieldOfView / 2.4
    spawn(function() -- line 17 | captures: CurrentCamera, FieldOfView
        wait(5)
        if CurrentCamera then
            CurrentCamera.FieldOfView = FieldOfView
        end
    end)
end

local Lighting = game:GetService("Lighting")
local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

ColorCorrectionEffect.Name = "BeeEffect"
ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 0)
ColorCorrectionEffect.Saturation = 0.5
ColorCorrectionEffect.Parent = Lighting
game:GetService("Debris"):AddItem(ColorCorrectionEffect, 5)
local v1 = ReplicatedStorage.Assets.ToolEffects.BeeToolEffect:Clone()
local Character = LocalPlayer.Character
local v2 = Character and Character:FindFirstChild("Head")

if v2 then
    v1.CFrame = v2.CFrame
    local WeldConstraint = Instance.new("WeldConstraint")
    WeldConstraint.Parent = v1
    WeldConstraint.Part0 = v2
    WeldConstraint.Part1 = v1
    v1.Parent = v2
    game:GetService("Debris"):AddItem(v1, 5)
end
local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
local v3 = require(PlayerScripts:WaitForChild("PlayerModule")):GetControls()
local moveFunction = v3.moveFunction

function v3.moveFunction(v4, v5, v6) -- line 57 | captures: moveFunction
    return moveFunction(v4, -v5, v6)
end

spawn(function() -- line 60 | captures: v3, moveFunction
    wait(5)
    v3.moveFunction = moveFunction
end)
local CurrentCamera = workspace.CurrentCamera

if not CurrentCamera then
    return
end
local FieldOfView = CurrentCamera.FieldOfView

CurrentCamera.FieldOfView = FieldOfView / 2.4
spawn(function() -- line 71 | captures: CurrentCamera, FieldOfView
    wait(5)
    if CurrentCamera then
        CurrentCamera.FieldOfView = FieldOfView
    end
end)
