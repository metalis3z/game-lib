-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Util.Assert)
local ClampColor = require(script.Parent.Util.ClampColor)
local Invert = Assert.prepTypeOf("Invert")
return function(v1) -- line 12 | captures: ClampColor, Invert
    Invert("color", "Color3", v1)
    local v2 = Color3.new(1 - v1.R, 1 - v1.G, 1 - v1.B)
    return ClampColor(v2)
end
