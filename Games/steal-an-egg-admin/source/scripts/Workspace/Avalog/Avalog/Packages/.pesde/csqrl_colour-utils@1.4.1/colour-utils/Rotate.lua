-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Util.Assert)
local ClampColor = require(script.Parent.Util.ClampColor)
local Rotate = Assert.prepTypeOf("Rotate")
local clamp = math.clamp
return function(v1, v2) -- line 15 | captures: ClampColor, Rotate, clamp
    Rotate("color", "Color3", v1)
    Rotate("angle", "number", v2)
    local v3, v4, v5 = v1:ToHSV()
    local v6 = (v3 + v2 / 360) % 1
    local v7 = clamp(v6, 0, 1)
    local v8 = Color3.fromHSV(v7, v4, v5)
    return ClampColor(v8)
end
