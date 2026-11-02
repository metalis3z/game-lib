-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local EggState = require(ReplicatedStorage.Client.EggState)
local GUI = require(ReplicatedStorage.Client.GUI)
local Log = require(ReplicatedStorage.Packages.Log)
local Timer = require(ReplicatedStorage.Packages.Timer)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Packages.Trove)
local PlayerRequest = AreaEggs.DropReasons.PlayerRequest
local v1 = Log.new()
local LocalPlayer = Players.LocalPlayer
local v2 = GUI.DropHeldEgg()
local v3 = Trove.new()
local v4 = false

v2.Enabled = false
ButtonFX(v2.Button, nil, function() -- line 23 | captures: v4, EggState, ToolGameplayGuard, PlayerRequest, v1, LocalPlayer, v2
    if ToolGameplayGuard.IsLocalInsideArena() then
        local v5, v6 = EggState.DropFieldEgg(PlayerRequest)
        if not v5 and v6 ~= nil then
            v1:AtDebug():Log((("Drop held area egg denied for %*: %*"):format(LocalPlayer.UserId, v6)))
        end
    else
        local v7 = v4 and ToolGameplayGuard.IsLocalInsideArena()
        v2.Enabled = v7
    end
end)
v3:Add(Timer.Simple(0.1, function() -- line 38 | captures: v4, ToolGameplayGuard, v2
    local v8 = v4 and ToolGameplayGuard.IsLocalInsideArena()
    v2.Enabled = v8
end, true))
v3:Add(EggState.CarryChanged:Connect(function(v9) -- line 45 | captures: v4, ToolGameplayGuard, v2
    v4 = v9.IsCarrying
    local v10 = v4 and ToolGameplayGuard.IsLocalInsideArena()
    v2.Enabled = v10
end))
v3:AttachToInstance(script)
