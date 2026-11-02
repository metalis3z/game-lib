-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Collections = require(ReplicatedStorage.Shared.Utils.Collections)
local DeepCopy = require(ReplicatedStorage.Shared.Utils.DeepCopy)
local FrameStepper = require(ReplicatedStorage.Shared.Utils.FrameStepper)
local Interpolation = require(ReplicatedStorage.Shared.Utils.Interpolation)
local LightingsCore = require(ReplicatedStorage.Client.LightingsCore)
local Lightings = require(ReplicatedStorage.Data.Lightings)
local t = require(ReplicatedStorage.Packages.t)
local Linear = Enum.EasingStyle.Linear
local Out = Enum.EasingDirection.Out
local v1 = { DefaultLightings = Lightings.Directory.Default }

v1.baseLook = v1.DefaultLightings
v1.baseRank = 0
v1.appliedLook = v1.DefaultLightings
v1.modifiers = {}
v1.tweenHandle = nil

local function pushLive(v2) -- line 24 | captures: Lighting, Workspace, DeepCopy, LightingsCore
    local v3 = DeepCopy(v2)
    v3.Clouds = nil
    LightingsCore.Commit(Lighting, v3)
    local Clouds = Workspace.Terrain.Clouds
    local Clouds_2 = v2.Clouds
    Clouds.Enabled = Clouds_2 ~= nil
    if Clouds_2 then
        LightingsCore.CommitClouds(Clouds, Clouds_2)
    end
end

local function byPlacing(v4, v5) -- line 36
    if v4.Rank == v5.Rank then
        return v4.Label < v5.Label
    end
    return v4.Rank < v5.Rank
end

local function resolveLook(v6) -- line 45 | captures: byPlacing
    local v7 = {
        {
            Label = "__base",
            Rank = v6.baseRank
        }
    }
    for v8, v9 in pairs(v6.modifiers) do
        local v10 = {
            Label = v8,
            Rank = v9.Rank,
            Adjust = v9.Adjust
        }
        table.insert(v7, v10)
    end
    table.sort(v7, byPlacing)
    local v11 = v6.DefaultLightings
    for v12, v13 in v7 do
        local Adjust = v13.Adjust
        if Adjust then
            v11 = Adjust(v11)
        else
            v11 = v6.baseLook
        end
    end
    return v11
end

local function driveToResolved(v14, v15) -- line 68 | captures: Lighting, Workspace, Collections, DeepCopy, FrameStepper, Interpolation, LightingsCore, Linear, Out, resolveLook
    if not Workspace:GetAttribute("Event_AdminAbuse") then
        local v16 = resolveLook(v14)
        if not Collections.MatchesFast(v14.appliedLook, v16) then
            local v17 = v15 or 1.33
            local v18 = LightingsCore.Capture(Lighting)
            v18.Clouds = LightingsCore.CaptureClouds(Workspace.Terrain.Clouds)
            local tweenHandle = v14.tweenHandle
            if tweenHandle then
                tweenHandle:Cancel()
                v14.tweenHandle = nil
            end
            v14.appliedLook = v16
            if v17 > 0 then
                local v19
                v19 = FrameStepper.OnRender(function(v20, v21) -- line 89 | captures: v16, v18, Lighting, Workspace, DeepCopy, Interpolation, LightingsCore, Linear, Out
                    local v22 = Interpolation.Ease(v21, Linear, Out)
                    local v23 = LightingsCore.Blend(v18, v16, v22)
                    local v24 = DeepCopy(v23)
                    v24.Clouds = nil
                    LightingsCore.Commit(Lighting, v24)
                    local Clouds = Workspace.Terrain.Clouds
                    local Clouds_2 = v23.Clouds
                    Clouds.Enabled = Clouds_2 ~= nil
                    if Clouds_2 then
                        LightingsCore.CommitClouds(Clouds, Clouds_2)
                    end
                    return false
                end, v17, true):OnComplete(function() -- line 104 | captures: v19, v14, v16, Lighting, Workspace, DeepCopy, LightingsCore
                    if v14.tweenHandle ~= v19 then
                        return
                    end
                    local v25 = DeepCopy(v16)
                    v25.Clouds = nil
                    LightingsCore.Commit(Lighting, v25)
                    local Clouds = Workspace.Terrain.Clouds
                    local Clouds_2 = v16.Clouds
                    Clouds.Enabled = Clouds_2 ~= nil
                    if Clouds_2 then
                        LightingsCore.CommitClouds(Clouds, Clouds_2)
                    end
                end)
                v14.tweenHandle = v19
            else
                local v26 = DeepCopy(v16)
                v26.Clouds = nil
                LightingsCore.Commit(Lighting, v26)
                local Clouds = Workspace.Terrain.Clouds
                local Clouds_2 = v16.Clouds
                Clouds.Enabled = Clouds_2 ~= nil
                if Clouds_2 then
                    LightingsCore.CommitClouds(Clouds, Clouds_2)
                end
            end
        end
    end
end

function v1.SetModifier(v27, v28, v29, v30, v31) -- line 133 | captures: t, driveToResolved
    t.strict(t.string)(v28)
    t.strict(t.optional(t.number))(v30)
    t.strict(t.optional(t.number))(v31)
    v27.modifiers[v28] = {
        Rank = v30 or 0,
        Adjust = v29
    }
    driveToResolved(v27, v31)
end

function v1.ClearModifier(v32, v33, v34) -- line 143 | captures: t, driveToResolved
    t.strict(t.string)(v33)
    t.strict(t.optional(t.number))(v34)
    if v32.modifiers[v33] ~= nil then
        v32.modifiers[v33] = nil
        driveToResolved(v32, v34)
    end
end

function v1.SetLighting(v35, v36, v37, v38) -- line 153 | captures: t, driveToResolved
    t.strict(t.table)(v36)
    t.strict(t.optional(t.number))(v37)
    t.strict(t.optional(t.number))(v38)
    v35.baseLook = v36
    v35.baseRank = v38 or 0
    driveToResolved(v35, v37)
end

return v1
