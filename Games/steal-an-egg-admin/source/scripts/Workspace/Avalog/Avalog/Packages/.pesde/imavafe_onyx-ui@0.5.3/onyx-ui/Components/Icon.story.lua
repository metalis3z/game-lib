-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Fusion = require(script.Parent.Parent.Parent.Fusion)
local scoped = Fusion.scoped
local v1 = { Icon = require(script.Parent.Icon) }
local v2 = {}

function v2.story(v3) -- line 12 | captures: Fusion, v1
    Fusion.innerScope(v3.scope, Fusion, v1):Icon({
        Image = "rbxassetid://11560341132",
        Parent = v3.target
    })
end

v2.fusion = Fusion
return v2
