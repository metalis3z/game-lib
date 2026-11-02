-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local scoped = Fusion.scoped
local v1 = { Text = require(Parent.Components.Text) }
local v2 = {}

function v2.story(v3) -- line 12 | captures: Fusion, Util, scoped, v1
    scoped(Fusion, Util, v1):Text({
        Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        Parent = v3.target
    })
end

v2.fusion = Fusion
return v2
