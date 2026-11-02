-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local LightingsCore = require(ReplicatedStorage.Client.LightingsCore)
local Interface = require(script.Types.Interface)
local v1 = {}
local v2 = {}

v1.Directory = v2
v1.Types = Interface
v2.Default = LightingsCore.Capture(Lighting)
v2.Default.Clouds = LightingsCore.CaptureClouds(Workspace.Terrain.Clouds)
v2.DragonEvent = LightingsCore.Resolve(script.Assets.DragonEvent, v2.Default)
v2.CherryBlossom = LightingsCore.Resolve(script.Assets.SakuraLighting, v2.Default)
v2.MonsterEvent = LightingsCore.Resolve(script.Assets.MonsterEvent, v2.Default)

if Constants.IS_STUDIO then
    for v3, v4 in pairs(v2) do
        local v5, v6 = Interface.LightingConfig(v4)
        local v7 = ("Invalid lighting config \"%*\": %*"):format(v3, v6)
        assert(v5, v7)
    end
end
table.freeze(v2)
return v1
