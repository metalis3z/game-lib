-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Areas = require(ReplicatedStorage.Data.Areas)
local t = require(ReplicatedStorage.Packages.t)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local OnHeartbeat = require(ReplicatedStorage.Shared.Utils.FrameStepper).OnHeartbeat
local Lightings = require(ReplicatedStorage.Data.Lightings)
local LightingsController = require(ReplicatedStorage.Client.LightingsController)
local Player = require(ReplicatedStorage.Shared.Player)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraBloomPolicy = require(ReplicatedStorage.Client.Modules.SakuraBloomPolicy)
local Save = require(ReplicatedStorage.Shared.Save)
local v1 = {}

v1["Cherry Blossom"] = true
v1[Sakura.AreaDisplay.AreaId] = true

local LocalPlayer = Players.LocalPlayer
local __OBJECTS = Workspace:WaitForChild("__OBJECTS")
local Folder = __OBJECTS:IsA("Folder")
assert(Folder, "Workspace.__OBJECTS must be a Folder")
local Areas_2 = __OBJECTS.Areas
local Folder_2 = Areas_2:IsA("Folder")
assert(Folder_2, "Workspace.__OBJECTS.Areas must be a Folder")
local SeparationLine = Areas_2.SeparationLine
local BasePart = SeparationLine:IsA("BasePart")
assert(BasePart, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")
local GuardAreas = Areas_2.GuardAreas
local Folder_3 = GuardAreas:IsA("Folder")
assert(Folder_3, "Workspace.__OBJECTS.Areas.GuardAreas must be a Folder")
local Build = __OBJECTS:WaitForChild("Build")
local CherryBlossom = Areas_2:WaitForChild("CherryBlossom")
local Folder_4 = CherryBlossom:IsA("Folder")
assert(Folder_4, "Workspace.__OBJECTS.Areas.CherryBlossom must be a Folder")
local v2 = {}
local v3 = {}
local AreaId, RarityNumber, v4

local function rebuildAreaEntries(v5) -- line 44 | captures: Areas, GuardAreaGeometry, Sakura, GuardAreas, CherryBlossom, v3
    table.clear(v3)
    for v6, v7 in ipairs(GuardAreaGeometry.ReadAreaBounds(GuardAreas)) do
        v3[#v3 + 1] = {
            AreaId = v7.AreaId,
            Bounds = v7.Bounds,
            Config = Areas.Directory[v7.AreaId]
        }
    end
    local Bounds = CherryBlossom:FindFirstChild("Bounds")
    if Bounds and Bounds:IsA("BasePart") then
        v3[#v3 + 1] = {
            AreaId = Sakura.AreaDisplay.AreaId,
            Bounds = Bounds,
            Config = Sakura.AreaDisplay
        }
    end
    table.sort(v3, function(v8, v9) -- line 53
        local RarityNumber = v8.Config.Rarity.RarityNumber
        local RarityNumber_2 = v9.Config.Rarity.RarityNumber
        if RarityNumber == RarityNumber_2 then
            return v8.AreaId < v9.AreaId
        end
        return RarityNumber < RarityNumber_2
    end)
end

local function isEntryAvailable(v10) -- line 65 | captures: v1, Build
    if v10.Bounds.Parent and v10.Bounds.Parent:GetAttribute("ZoneHidden") == true then
        return false
    end
    if v1[v10.AreaId] then
        return Build:FindFirstChild("CherryBlossomZone") ~= nil
    end
    return true
end

local function resolveCurrentArea(v11) -- line 86 | captures: t, GuardAreaGeometry, v3, isEntryAvailable
    t.strict(t.Vector3)(v11)
    for v12, v13 in ipairs(v3) do
        if isEntryAvailable(v13) and GuardAreaGeometry.IsWithinFootprint(v13.Bounds, v11) then
            return v13
        end
    end
    return nil
end

local function isBloomUnlocked() -- line 101 | captures: SakuraBloomPolicy, Save
    local v14 = Save.IsLocalDataLoaded()
    local v15
    if v14 then
        v15 = Save.Get()
    end
    return SakuraBloomPolicy.HasBloomUnlocked(v14, v15)
end

local function updateZoneLighting(v16, v17) -- line 111 | captures: v4, Workspace, Lightings, LightingsController, SakuraBloomPolicy, Save, v1
    local v18
    if v17 and v1[v17] then
        if Workspace:GetAttribute("Event_GreatBloom") then
            local v19 = Save.IsLocalDataLoaded()
            local v20
            if v19 then
                v20 = Save.Get()
            end
            if SakuraBloomPolicy.HasBloomUnlocked(v19, v20) then
                v18 = v16
            end
        end
    else
        v18 = v16
    end
    local v21 = if v18 then v18.Lighting else nil
    if v21 ~= v4 then
        v4 = v21
        if v21 == nil then
            LightingsController:ClearModifier("ZoneLighting", 2)
        else
            local v22 = Lightings.Directory[v21]
            LightingsController:SetModifier("ZoneLighting", function() -- line 145 | captures: v22
                return v22
            end, 25, 2)
        end
    end
end

local function step(v23) -- line 149 | captures: AreaId, RarityNumber, v4, Players, GuardAreaGeometry, LightingsController, Player, LocalPlayer, SeparationLine, resolveCurrentArea, updateZoneLighting
    local v24 = Player.Optional.HumanoidRootPart(LocalPlayer)
    if v24 == nil then
        AreaId = nil
        local v25
        if v25 ~= v4 then
            v4 = v25
            LightingsController:ClearModifier("ZoneLighting", 2)
        end
    else
        local BasePart = v24:IsA("BasePart")
        local v26 = ("%* must be a BasePart"):format((v24:GetFullName()))
        assert(BasePart, v26)
        if GuardAreaGeometry.IsPastLine(SeparationLine, v24.Position) then
            local v27 = resolveCurrentArea(v24.Position)
            if v27 == nil then
                AreaId = nil
                local v28
                if v28 ~= v4 then
                    v4 = v28
                    LightingsController:ClearModifier("ZoneLighting", 2)
                end
            else
                Players.LocalPlayer:SetAttribute("AreaId", v27.AreaId)
                updateZoneLighting(v27.Config, v27.AreaId)
                if v27.AreaId ~= AreaId then
                    AreaId = v27.AreaId
                    local RarityNumber_2 = v27.Config.Rarity.RarityNumber
                    local RarityNumber_3 = RarityNumber
                    RarityNumber = RarityNumber_2
                    if RarityNumber_3 == nil or not (RarityNumber_2 <= RarityNumber_3) then
                        v23(v27.Config)
                    end
                end
            end
        else
            AreaId = nil
            RarityNumber = nil
            local v29
            if v29 ~= v4 then
                v4 = v29
                LightingsController:ClearModifier("ZoneLighting", 2)
            end
        end
    end
end

function v2.Start(v30) -- line 188 | captures: t, OnHeartbeat, GuardAreas, rebuildAreaEntries, step
    t.strict(t.callback)(v30)
    rebuildAreaEntries(nil)
    GuardAreas.ChildAdded:Connect(rebuildAreaEntries)
    GuardAreas.ChildRemoved:Connect(rebuildAreaEntries)
    local v31 = 0
    OnHeartbeat(function(v32) -- line 195 | captures: v31, v30, step
        v31 += v32
        if not (v31 < 0.1) then
            v31 = 0
            step(v30)
        end
        return nil
    end)
end

return v2
