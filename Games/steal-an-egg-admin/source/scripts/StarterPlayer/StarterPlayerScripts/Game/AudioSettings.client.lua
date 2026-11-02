-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local SettingsCmds = require(ReplicatedStorage.Shared.SettingsCmds)
local VolumePrefs = require(ReplicatedStorage.Client.VolumePrefs)
local Default = SoundService:WaitForChild("Default")
local DefaultReverb = SoundService:WaitForChild("DefaultReverb")
local Music = SoundService:WaitForChild("Music")
local Volume = Default.Volume
local Volume_2 = DefaultReverb.Volume
local Volume_3 = Music.Volume

local function applySfx() -- line 17 | captures: SettingsCmds, VolumePrefs, Default, DefaultReverb, Volume, Volume_2
    local v1
    if SettingsCmds.Allows("SFX") then
        v1 = VolumePrefs.Get("SFX")
    else
        v1 = 0
    end
    Default.Volume = Volume * v1
    DefaultReverb.Volume = Volume_2 * v1
end

local function applyMusic() -- line 27 | captures: SettingsCmds, VolumePrefs, Music, Volume_3
    local v2
    if SettingsCmds.Allows("Music") then
        v2 = VolumePrefs.Get("Music")
    else
        v2 = 0
    end
    Music.Volume = Volume_3 * v2
end

local function applyAll() -- line 36 | captures: SettingsCmds, VolumePrefs, Default, DefaultReverb, Music, Volume, Volume_2, Volume_3
    local v3
    if SettingsCmds.Allows("SFX") then
        v3 = VolumePrefs.Get("SFX")
    else
        v3 = 0
    end
    Default.Volume = Volume * v3
    DefaultReverb.Volume = Volume_2 * v3
    local v4
    if SettingsCmds.Allows("Music") then
        v4 = VolumePrefs.Get("Music")
    else
        v4 = 0
    end
    Music.Volume = Volume_3 * v4
end

SettingsCmds.Changed:Connect(function(v5) -- line 52 | captures: SettingsCmds, VolumePrefs, Default, DefaultReverb, Music, Volume, Volume_2, Volume_3
    if v5 == "SFX" then
        local v6
        if SettingsCmds.Allows("SFX") then
            v6 = VolumePrefs.Get("SFX")
        else
            v6 = 0
        end
        Default.Volume = Volume * v6
        DefaultReverb.Volume = Volume_2 * v6
    elseif v5 == "Music" then
        local v7
        if SettingsCmds.Allows("Music") then
            v7 = VolumePrefs.Get("Music")
        else
            v7 = 0
        end
        Music.Volume = Volume_3 * v7
    end
end)
VolumePrefs.Changed:Connect(function(v8) -- line 74 | captures: SettingsCmds, VolumePrefs, Default, DefaultReverb, Music, Volume, Volume_2, Volume_3
    if v8 == "SFX" then
        local v9
        if SettingsCmds.Allows("SFX") then
            v9 = VolumePrefs.Get("SFX")
        else
            v9 = 0
        end
        Default.Volume = Volume * v9
        DefaultReverb.Volume = Volume_2 * v9
    elseif v8 == "Music" then
        local v10
        if SettingsCmds.Allows("Music") then
            v10 = VolumePrefs.Get("Music")
        else
            v10 = 0
        end
        Music.Volume = Volume_3 * v10
    end
end)
local v11

if SettingsCmds.Allows("SFX") then
    v11 = VolumePrefs.Get("SFX")
else
    v11 = 0
end
Default.Volume = Volume * v11
DefaultReverb.Volume = Volume_2 * v11

local v12

if SettingsCmds.Allows("Music") then
    v12 = VolumePrefs.Get("Music")
else
    v12 = 0
end
Music.Volume = Volume_3 * v12
