-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolCooldown = require(ReplicatedStorage.Shared.Util.ToolCooldown)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = {}
local LocalPlayer = Players.LocalPlayer

local function accepted(v2, v3) -- line 13
    return v3:IsA("Tool") and table.find(v2.accepts, (v3:GetAttribute("GearName"))) ~= nil
end

local function loosen(v4) -- line 20
    local grip = v4.grip
    if grip then
        grip:Clean()
    end
end

local function stow(v5) -- line 26
    local grip = v5.grip
    if grip then
        grip:Clean()
    end
    v5.grip = nil
    local onUnequipped = v5.hooks.onUnequipped
    if onUnequipped then
        onUnequipped()
    end
    v5.held = nil
end

local function wield(v6, v7) -- line 38 | captures: ToolCooldown, ToolGameplayGuard, Trove, LocalPlayer
    local grip = v6.grip
    if grip then
        grip:Clean()
    end
    v6.grip = Trove.new()
    v6.held = v7
    ToolCooldown.PrimeTool(v7)
    local onEquipped = v6.hooks.onEquipped
    if onEquipped then
        onEquipped(v7)
    end
    local grip_2 = v6.grip
    if not grip_2 then
        return
    end
    if v6.hooks.onActivated then
        grip_2:Add(v7.Activated:Connect(function() -- line 53 | captures: v6, v7, ToolGameplayGuard
            local onActivated = v6.hooks.onActivated
            if onActivated and ToolGameplayGuard.AllowsLocalUse(v7) then
                onActivated(v7)
            end
        end))
    end
    grip_2:Add(LocalPlayer.CharacterRemoving:Connect(function() -- line 60 | captures: v6
        local grip = v6.grip
        if grip then
            grip:Clean()
        end
    end))
end

local function onGearChange(v8, v9, v10) -- line 68
    if v9:IsA("Tool") and table.find(v8.accepts, (v9:GetAttribute("GearName"))) ~= nil then
        v10(v8, v9)
    end
end

function v1.GearNameOf(v11) -- line 77
    if v11 then
        return (v11:GetAttribute("GearName"))
    end
    return nil
end

function v1.Follow(v12, v13) -- line 83 | captures: wield
    v13.ChildAdded:Connect(function(v14) -- line 85 | captures: v12, wield
        if v14:IsA("Tool") and table.find(v12.accepts, (v14:GetAttribute("GearName"))) ~= nil then
            wield(v12, v14)
        end
    end)
    v13.ChildRemoved:Connect(function(v15) -- line 95 | captures: v12
        if not (v15:IsA("Tool") and table.find(v12.accepts, (v15:GetAttribute("GearName"))) ~= nil) then
            return
        end
        local grip = v12.grip
        if grip then
            grip:Clean()
        end
        v12.grip = nil
        local onUnequipped = v12.hooks.onUnequipped
        if onUnequipped then
            onUnequipped()
        end
        v12.held = nil
    end)
    local Tool = v13:FindFirstChildWhichIsA("Tool")
    if not Tool then
        return
    end
    local Tool_2 = Tool:IsA("Tool")
    if Tool_2 then
        local accepts = v12.accepts
        Tool_2 = table.find(accepts, (Tool:GetAttribute("GearName"))) ~= nil
    end
    if Tool_2 then
        wield(v12, Tool)
    end
end

function v1.Shut(v16) -- line 126
    v16.spawns:Clean()
    local grip = v16.grip
    if grip then
        grip:Clean()
    end
end

return v1
