-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Util.Assert)
local ClampColor = require(script.Parent.Util.ClampColor)
local Transparency = require(script.Parent.Blend.Transparency)
local sub = string.sub
local gsub = string.gsub
local format = string.format
local rep = string.rep
local split = string.split
local v1 = Color3.new()

local function FromHex(v2) -- line 30 | captures: Assert, ClampColor, sub, gsub, format, rep, split
    Assert.typeOf("FromHex", "hex", "string", v2)
    local v3 = gsub(v2, "[^A-Fa-f0-9]", "")
    if #v3 == 3 then
        local v4 = split(v3, "")
        v3 = ""
        for v5, v6 in ipairs(v4) do
            v3 ..= rep(v6, 2)
        end
    elseif #v3 < 6 then
        v3 = format("%s%s", v3, rep(v3, 6 - #v3))
    end
    local v7 = sub(v3, 1, 2)
    local v8 = tonumber(v7, 16)
    local v9 = sub(v3, 3, 4)
    local v10 = tonumber(v9, 16)
    local v11 = sub(v3, 5, 6)
    local v12 = tonumber(v11, 16)
    return ClampColor(Color3.fromRGB(v8, v10, v12))
end

local function FromHexRGBA(v13, v14) -- line 76 | captures: Assert, Transparency, sub, gsub, v1, FromHex
    Assert.typeOf("FromHexRGBA", "hex", "string", v13)
    local v15 = gsub(v13, "[^A-Fa-f0-9]", "")
    if #v15 < 8 then
        return FromHex(v15)
    end
    local v16 = sub(v15, -2)
    local v17 = 1 - tonumber(v16, 16) / 255
    local v18 = FromHex((sub(v15, 1, -3)))
    return Transparency(v18, v14 or v1, v17)
end

return {
    fromHex = FromHex,
    fromHexRGBA = FromHexRGBA,
    toHex = function(v19) -- ToHex | line 105 | captures: Assert, format
        Assert.typeOf("ToHex", "color", "Color3", v19)
        local v20 = v19.R * 255
        local v21 = v19.G * 255
        local v22 = v19.B * 255
        return (format("%.2x%.2x%.2x", v20, v21, v22))
    end
}
