-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Util.Assert)
local Saturate = require(script.Parent.Saturate)
local Saturate_2 = Assert.prepTypeOf("Saturate")
return function(v1, v2) -- line 14 | captures: Saturate, Saturate_2
    Saturate_2("color", "Color3", v1)
    Saturate_2("coefficient", "number", v2)
    return Saturate(v1, -v2)
end
