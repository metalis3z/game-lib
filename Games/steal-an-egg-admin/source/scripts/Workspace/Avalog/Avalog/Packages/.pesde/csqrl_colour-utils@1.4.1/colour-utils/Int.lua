-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Util.Assert)
local ClampColor = require(script.Parent.Util.ClampColor)
local floor = math.floor
local rshift = bit32.rshift
local lshift = bit32.lshift
local band = bit32.band

return {
    fromInt = function(v1) -- FromInt | line 16 | captures: Assert, ClampColor, floor, rshift, band
        Assert.typeOf("FromInt", "int", "number", v1)
        local v2 = floor(v1)
        local v3 = rshift(v2, 16)
        local v4 = band(v3, 255)
        local v5 = rshift(v2, 8)
        local v6 = band(v5, 255)
        local v7 = band(v2, 255)
        return ClampColor(Color3.fromRGB(v4, v6, v7))
    end,
    toInt = function(v8) -- ToInt | line 34 | captures: Assert, floor, lshift
        Assert.typeOf("ToInt", "color", "Color3", v8)
        local v9 = v8.R * 255
        local v10 = floor(v9)
        local v11 = lshift(v10, 8)
        local v12 = v8.G * 255
        local v13 = v11 + floor(v12)
        local v14 = lshift(v13, 8)
        local v15 = v8.B * 255
        return v14 + floor(v15)
    end
}
