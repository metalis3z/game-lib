-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local AreaEggResetCycle = require(ReplicatedStorage.Data.AreaEggResetCycle)
local Audio = require(ReplicatedStorage.Shared.Audio)
local LightingsController = require(ReplicatedStorage.Client.LightingsController)
require(ReplicatedStorage.Data.Lightings)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local DayTransitionSoundId = AreaEggResetCycle.DayTransitionSoundId
local v1

local function transformToNight(v2) -- line 17 | captures: AreaEggResetCycle
    local v3 = table.clone(v2)
    local NightLighting = AreaEggResetCycle.NightLighting
    v3.Ambient = NightLighting.Ambient
    v3.Brightness = NightLighting.Brightness
    v3.ClockTime = NightLighting.ClockTime
    v3.ColorShift_Bottom = NightLighting.ColorShift_Bottom
    v3.ColorShift_Top = NightLighting.ColorShift_Top
    v3.OutdoorAmbient = NightLighting.OutdoorAmbient
    return v3
end

local function resolvePhase(v4) -- line 28 | captures: Workspace, AreaEggCycle, AreaEggResetCycle
    if Workspace:GetAttribute("Event_AdminAbuse") ~= true then
        if AreaEggCycle.IsNightPhase(v4) then
            return "Night"
        end
        if AreaEggCycle.IsWithinNightTransition(v4, AreaEggResetCycle.NightLightingTransitionSeconds, AreaEggResetCycle.NightLightingStartDelaySeconds) then
            return "NightTransition"
        end
    end
    return "Day"
end

local function setPhase(v5, v6, v7) -- line 40 | captures: v1, SoundService, AreaEggCycle, AreaEggResetCycle, Audio, LightingsController, MusicDirector, DayTransitionSoundId, transformToNight
    if v1 == v5 then
        return
    end
    local v8 = v1
    v1 = v5
    if v5 == "NightTransition" then
        local v9 = AreaEggCycle.NightStartTime(v7) + AreaEggResetCycle.NightLightingStartDelaySeconds - v7
        local v10 = math.max(v9, 0)
        LightingsController:SetModifier("AreaEggResetNight", transformToNight, AreaEggResetCycle.LightingModifierPriority, v10)
        MusicDirector.SetResetNight(false)
    elseif v5 == "Night" then
        if v8 ~= "NightTransition" then
            local v11 = AreaEggCycle.NightStartTime(v7) + AreaEggResetCycle.NightLightingStartDelaySeconds
            local LightingModifierPriority = AreaEggResetCycle.LightingModifierPriority
            local v12 = v11 - v7
            LightingsController:SetModifier("AreaEggResetNight", transformToNight, LightingModifierPriority, (math.max(v12, 0)))
        end
        MusicDirector.SetResetNight(true, true)
    else
        local v13 = if v6 or v8 == nil then 0 else AreaEggResetCycle.DayLightingTransitionSeconds
        LightingsController:ClearModifier("AreaEggResetNight", v13)
        MusicDirector.SetResetNight(false)
        if not v6 and DayTransitionSoundId ~= nil then
            Audio.Play(DayTransitionSoundId, SoundService)
        end
    end
end

if DayTransitionSoundId ~= nil then
    task.spawn(require(ReplicatedStorage.Shared.Utils.Warmup).WarmSounds, DayTransitionSoundId)
end
Workspace:GetAttributeChangedSignal("Event_AdminAbuse"):Connect(function() -- line 80 | captures: Workspace, AreaEggCycle, AreaEggResetCycle, setPhase
    local v14 = Workspace:GetServerTimeNow()
    local v15
    if Workspace:GetAttribute("Event_AdminAbuse") == true then
        v15 = "Day"
    elseif AreaEggCycle.IsNightPhase(v14) then
        v15 = "Night"
    elseif AreaEggCycle.IsWithinNightTransition(v14, AreaEggResetCycle.NightLightingTransitionSeconds, AreaEggResetCycle.NightLightingStartDelaySeconds) then
        v15 = "NightTransition"
    else
        v15 = "Day"
    end
    setPhase(v15, false, v14)
end)
local v16 = true
while true do
    local v17 = Workspace:GetServerTimeNow()
    local v18
    if Workspace:GetAttribute("Event_AdminAbuse") == true then
        v18 = "Day"
    elseif AreaEggCycle.IsNightPhase(v17) then
        v18 = "Night"
    elseif AreaEggCycle.IsWithinNightTransition(v17, AreaEggResetCycle.NightLightingTransitionSeconds, AreaEggResetCycle.NightLightingStartDelaySeconds) then
        v18 = "NightTransition"
    else
        v18 = "Day"
    end
    setPhase(v18, v16, v17)
    local v19
    if v18 == "Night" then
        v19 = AreaEggCycle.NextResetTime(v17)
    elseif v18 == "NightTransition" then
        v19 = AreaEggCycle.NightStartTime(v17)
    else
        v19 = AreaEggCycle.NightTransitionStartTime(v17, AreaEggResetCycle.NightLightingTransitionSeconds, AreaEggResetCycle.NightLightingStartDelaySeconds)
    end
    local v20 = v19 - Workspace:GetServerTimeNow()
    local wait = task.wait
    local SchedulePollSeconds = AreaEggCycle.SchedulePollSeconds
    wait((math.clamp(v20, 0.05, SchedulePollSeconds)))
    v16 = false
end
