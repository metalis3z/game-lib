-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local v2 = {
    Label = "Sound Effects",
    Blurb = "Toggle sound effects on or off.",
    Fallback = true
}
local v3 = {}

v3[true] = true
v3[false] = false
v2.Projection = v3
v1.SFX = v2

local v4 = {
    Label = "Music",
    Blurb = "Toggle music playback on or off.",
    Fallback = true
}
local v5 = {}

v5[true] = true
v5[false] = false
v4.Projection = v5
v1.Music = v4

local v6 = {
    Label = "AFK Mode",
    Blurb = "Stay in the lobby and skip Murder Mystery rounds.",
    Fallback = false
}
local v7 = {}

v7[true] = true
v7[false] = false
v6.Projection = v7
v1.AFK = v6

local v8 = {
    Label = "Hide Other Pets",
    Blurb = "Hide other players pets.",
    Fallback = false
}
local v9 = {}

v9[true] = true
v9[false] = false
v8.Projection = v9
v1.HideOtherPets = v8

local v10 = {
    Label = "Hide Your Pets",
    Blurb = "Hide your own pets on your plot.",
    Fallback = false
}
local v11 = {}

v11[true] = true
v11[false] = false
v10.Projection = v11
v1.HideSelfPets = v10

local v12 = {
    Label = "Disable Videos",
    Blurb = "Disable treadmill video.",
    Fallback = false
}
local v13 = {}

v13[true] = true
v13[false] = false
v12.Projection = v13
v1.DisableVideos = v12
return v1
