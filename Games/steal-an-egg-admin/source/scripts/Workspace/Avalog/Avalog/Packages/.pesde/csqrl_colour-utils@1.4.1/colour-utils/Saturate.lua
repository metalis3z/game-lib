-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Util.Assert)
local ClampColor = require(script.Parent.Util.ClampColor)
local Saturate = Assert.prepTypeOf("Saturate")
local clamp = math.clamp
return function(v1, v2) -- line 16 | captures: ClampColor, Saturate, clamp
    Saturate("color", "Color3", v1)
    Saturate("coefficient", "number", v2)
    local v3, v4, v5 = v1:ToHSV()
    local v6 = v4 + v4 * v2
    return ClampColor(Color3.fromHSV(v3, clamp(v6, 0, 1), v5))
end
