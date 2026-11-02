-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Globals.Constants)
local v1 = require(ReplicatedStorage.Packages.Log).new()
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolSetup = require(ReplicatedStorage.Client.Util.ToolSetup)
local Magnet = require(ReplicatedStorage.Data.Gears).Directory.Magnet
local COOLDOWN = Magnet.COOLDOWN
local LocalPlayer = Players.LocalPlayer
local v2

local function cleanupTargetVFX() -- line 16 | captures: v2
    if v2 and v2.Parent then
        v2:Destroy()
    end
    v2 = nil
end

local function playTargetVFX() -- line 22 | captures: v2, v1, Magnet, LocalPlayer
    if v2 and v2.Parent then
        v2:Destroy()
    end
    v2 = nil
    local Character = LocalPlayer.Character
    if Character then
        local v3 = Character.PrimaryPart or Character:FindFirstChild("HumanoidRootPart")
        if v3 and v3:IsA("BasePart") then
            local MAGNET_EFFECT_PATH = Magnet.MAGNET_EFFECT_PATH
            if MAGNET_EFFECT_PATH then
                local BasePart = MAGNET_EFFECT_PATH:IsA("BasePart")
                assert(BasePart, "[Magnet] MagnetEffect template must be a Part")
                local v4 = MAGNET_EFFECT_PATH:Clone()
                v4.Name = "MagnetTargetVFX"
                v4.Parent = v3
                v2 = v4
            else
                v1:AtWarning():Log("[Magnet] Could not find MagnetEffect template")
            end
        else
            v1:AtWarning():Log("[Magnet] Could not find local character root part")
        end
    else
        v1:AtWarning():Log("[Magnet] Local character not found")
    end
end

local function stopTargetVFX() -- line 52 | captures: v2
    if v2 and v2.Parent then
        v2:Destroy()
    end
    v2 = nil
end

local Attach = ToolSetup.Attach
local DisplayName = Magnet.DisplayName
local v5 = {}

function v5.onActivated(v6) -- line 59 | captures: Remotes
    Remotes.MagnetGadget.AskTug:FireServer()
end

function v5.onUnequipped() -- line 62 | captures: v2
    if v2 and v2.Parent then
        v2:Destroy()
    end
    v2 = nil
end

local v7 = Attach(DisplayName, v5)
Remotes.MagnetGadget.EmitBeam.OnClientEvent:Connect(function(v8, v9) -- line 69 | captures: ToolSetup, COOLDOWN, LocalPlayer, v7
    if v8 == LocalPlayer.Character then
        ToolSetup.ApplyCooldown(v7, COOLDOWN)
    end
end)
Remotes.MagnetGadget.EmitTargetFx.OnClientEvent:Connect(function() -- line 74 | captures: playTargetVFX
    playTargetVFX()
end)
Remotes.MagnetGadget.HaltTargetFx.OnClientEvent:Connect(function() -- line 77 | captures: v2
    if v2 and v2.Parent then
        v2:Destroy()
    end
    v2 = nil
end)
