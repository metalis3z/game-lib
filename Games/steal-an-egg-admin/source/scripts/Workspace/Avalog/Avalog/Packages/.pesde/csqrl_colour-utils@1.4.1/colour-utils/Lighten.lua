-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Lighten = require(script.Parent.Util.Assert).prepTypeOf("Lighten")
local ClampColor = require(script.Parent.Util.ClampColor)
return function(v1, v2) -- line 14 | captures: Lighten, ClampColor
    Lighten("color", "Color3", v1)
    Lighten("coefficient", "number", v2)
    return ClampColor(v1:Lerp(Color3.new(1, 1, 1), v2))
end
