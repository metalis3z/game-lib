-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Darken = require(script.Parent.Util.Assert).prepTypeOf("Darken")
local ClampColor = require(script.Parent.Util.ClampColor)
return function(v1, v2) -- line 14 | captures: Darken, ClampColor
    Darken("color", "Color3", v1)
    Darken("coefficient", "number", v2)
    return ClampColor(v1:Lerp(Color3.new(), v2))
end
