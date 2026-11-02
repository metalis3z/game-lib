-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent
local OnyxNight = require(script.OnyxNight)
local NewTheme = require(script.NewTheme)
require(script.ThemeSpec)
local Fusion = require(Parent.Parent.Fusion)
local scoped = Fusion.scoped
local Contextual = Fusion.Contextual
local v1 = {}

function v1.NewTheme(v2, v3) -- line 42 | captures: NewTheme
    return NewTheme(v2, v3)
end

v1.Theme = Contextual(OnyxNight)
return v1
