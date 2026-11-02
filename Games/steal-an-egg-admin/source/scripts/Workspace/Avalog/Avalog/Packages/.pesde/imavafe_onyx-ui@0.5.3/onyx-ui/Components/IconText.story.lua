-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Fusion = require(script.Parent.Parent.Parent.Fusion)
local scoped = Fusion.scoped
local v1 = { IconText = require(script.Parent.IconText) }
local v2 = {}

function v2.story(v3) -- line 12 | captures: Fusion, v1
    Fusion.innerScope(v3.scope, Fusion, v1):IconText({
        Parent = v3.target,
        Content = { "Here's a shop icon: ", "rbxassetid://75029721407761", ".", " And also the Loneka logo: ", "rbxassetid://16735398592", ". Now you can easily have both text and icons!" }
    })
end

v2.fusion = Fusion
return v2
