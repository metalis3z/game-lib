-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Globals.Constants)
local Gears = require(ReplicatedStorage.Data.Gears)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local v1 = {}

v1[Enum.UserInputType.MouseButton1] = true
v1[Enum.UserInputType.Touch] = true

local LocalPlayer = Players.LocalPlayer

local function isBatTool(v2) -- line 18 | captures: t, Gears
    local GearName = v2:GetAttribute("GearName")
    t.strict(t.optional(t.string))(GearName)
    if GearName == nil then
        return false
    end
    return Gears.GearNameExists(GearName) and Gears.Directory[GearName].BatControllerData ~= nil
end

local function trySendActivation() -- line 31 | captures: Remotes, ToolGameplayGuard, LocalPlayer, isBatTool
    if LocalPlayer then
        local Character = LocalPlayer.Character
        if Character then
            local Tool = Character:FindFirstChildWhichIsA("Tool")
            if Tool and ToolGameplayGuard.AllowsLocalUse(Tool) and not isBatTool(Tool) then
                Remotes.ToolTrigger.Trigger:FireServer(Tool)
            end
        end
    end
end

UserInputService.InputBegan:Connect(function(v3) -- line 46 | captures: v1, trySendActivation
    if v1[v3.UserInputType] then
        trySendActivation()
    end
end)
