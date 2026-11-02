-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolCooldown = require(ReplicatedStorage.Shared.Util.ToolCooldown)
local ToolSession = require(ReplicatedStorage.Client.Util.ToolSession)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.array(t.string))
local v2 = {}
local LocalPlayer = Players.LocalPlayer

function v2.Attach(v3, v4) -- line 15 | captures: ToolSession, Trove, v1, LocalPlayer
    local v5 = if type(v3) == "string" then { v3 } else v3
    v1(v5)
    local v6 = { accepts = v5 }
    v6.hooks = v4 or {}
    v6.spawns = Trove.new()
    local Character = LocalPlayer.Character
    if Character then
        ToolSession.Follow(v6, Character)
    end
    v6.spawns:Add(LocalPlayer.CharacterAdded:Connect(function(v7) -- line 34 | captures: v6, ToolSession
        ToolSession.Follow(v6, v7)
    end))
    local v8 = {}

    function v8.GetCurrentTool() -- line 38 | captures: v6
        return v6.held
    end

    function v8.GetCurrentToolGearName() -- line 41 | captures: v6, ToolSession
        return ToolSession.GearNameOf(v6.held)
    end

    function v8.IsActive() -- line 44 | captures: v6
        return v6.held ~= nil
    end

    function v8.Cleanup() -- line 48 | captures: v6, ToolSession
        ToolSession.Shut(v6)
    end

    return v8
end

function v2.ApplyCooldown(v9, v10) -- line 53 | captures: ToolCooldown
    local v11 = v9:GetCurrentTool()
    if v11 and v11.Parent then
        ToolCooldown.Begin(v11, v10)
    end
end

return v2
