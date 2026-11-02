-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local EnsureScale = require(ReplicatedStorage.Shared.Utils.Layout).EnsureScale
local Save = require(ReplicatedStorage.Shared.Save)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local LocalPlayer = Players.LocalPlayer
local v1 = GUI.ActivePets()
local PetsButton = Hud.Find("PetsButton")
local EquipBest = v1.Frame.EquipBest
local v2

if PetsButton == nil then
else
    v2 = PetsButton:FindFirstChild("Badge")
end
local Badge = EquipBest:FindFirstChild("Badge")
local v3, v4
local ScreenGui = v1:IsA("ScreenGui")
assert(ScreenGui, "PlayerGui.ActivePets must be a ScreenGui")
local GuiButton = EquipBest:IsA("GuiButton")
assert(GuiButton, "ActivePets.Frame.EquipBest must be a GuiButton")
local v5 = {}

local function stopBadgePulse(v6, v7) -- line 33 | captures: EnsureScale
    if v7 ~= nil then
        v7:Cancel()
        v7:Destroy()
    end
    if v6 ~= nil then
        EnsureScale(v6).Scale = 1
        v6.Visible = false
    end
    return nil
end

local function startBadgePulse(v8, v9) -- line 46 | captures: EnsureScale, Tween
    if v8 == nil then
        return nil
    end
    v8.Visible = true
    if v9 == nil then
        local v10 = EnsureScale(v8)
        v10.Scale = 0.8
        local v11 = { Scale = 1.2 }
        local v12 = {
            0.7,
            Enum.EasingStyle.Elastic,
            Enum.EasingDirection.Out,
            -1,
            true
        }
        return (Tween(v10, v11, v12))
    end
    return v9
end

local function refresh() -- line 66 | captures: v2, v3, v4, EnsureScale, Save, LocalPlayer, Badge, startBadgePulse
    local v13 = Save.Get(LocalPlayer)
    local PetPenCapacityGuidance
    if v13 == nil then
    else
        PetPenCapacityGuidance = v13.PetPenCapacityGuidance
    end
    local v14 = if PetPenCapacityGuidance == nil then false else PetPenCapacityGuidance.Triggered and not PetPenCapacityGuidance.PetsTabAcknowledged
    local v15 = if PetPenCapacityGuidance == nil then false else PetPenCapacityGuidance.Triggered and not PetPenCapacityGuidance.EquipBestAcknowledged
    if v14 then
        v3 = startBadgePulse(v2, v3)
    else
        local v16 = v2
        local v17 = v3
        if v17 ~= nil then
            v17:Cancel()
            v17:Destroy()
        end
        if v16 ~= nil then
            EnsureScale(v16).Scale = 1
            v16.Visible = false
        end
        v3 = nil
    end
    if v15 then
        v4 = startBadgePulse(Badge, v4)
    else
        local v18 = v4
        if v18 ~= nil then
            v18:Cancel()
            v18:Destroy()
        end
        if Badge ~= nil then
            EnsureScale(Badge).Scale = 1
            Badge.Visible = false
        end
        v4 = nil
    end
end

function v5.AcknowledgePetsBadge() -- line 127 | captures: v2, v3, AssetRoster, EnsureScale, TryCall, refresh
    local v19, v20
    if v2 == nil then
        v20 = true
    elseif v2.Visible then
        v19 = v2
        local v21 = v3
        if v21 ~= nil then
            v21:Cancel()
            v21:Destroy()
        end
        v20 = false
    else
        v20 = true
    end
    if v20 then
        return
    end
    if v19 ~= nil then
        EnsureScale(v19).Scale = 1
        v19.Visible = false
    end
    v3 = nil
    task.spawn(function() -- line 147 | captures: AssetRoster, TryCall, refresh
        local v22, v23 = TryCall(AssetRoster.AckPetsBadge)
        if v22 then
            if v23 ~= true then
                refresh()
            end
        else
            refresh()
        end
    end)
end

function v5.AcknowledgeEquipBestBadge() -- line 157 | captures: v4, AssetRoster, EnsureScale, TryCall, Badge, refresh
    local Badge_2, v24
    if Badge == nil then
        v24 = true
    elseif Badge.Visible then
        Badge_2 = Badge
        local v25 = v4
        if v25 ~= nil then
            v25:Cancel()
            v25:Destroy()
        end
        v24 = false
    else
        v24 = true
    end
    if v24 then
        return
    end
    if Badge_2 ~= nil then
        EnsureScale(Badge_2).Scale = 1
        Badge_2.Visible = false
    end
    v4 = nil
    task.spawn(function() -- line 177 | captures: AssetRoster, TryCall, refresh
        local v26, v27 = TryCall(AssetRoster.AckEquipBestBadge)
        if v26 then
            if v27 ~= true then
                refresh()
            end
        else
            refresh()
        end
    end)
end

function v5.Initialize() -- line 187 | captures: Save, refresh
    Save.FieldSignal("PetPenCapacityGuidance"):Connect(refresh)
    task.spawn(refresh)
end

return v5
