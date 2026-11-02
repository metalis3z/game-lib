-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GetContrastingColor = require(script.Parent.Parent.Util.Assert).prepTypeOf("GetContrastingColor")
local Darken = require(script.Parent.Parent.Darken)
local GetContrastRatio = require(script.Parent.GetContrastRatio)
local Lighten = require(script.Parent.Parent.Lighten)
local isDark = require(script.Parent.Parent.isDark)
return function(v1, v2, v3) -- line 20 | captures: GetContrastingColor, Darken, GetContrastRatio, Lighten, isDark
    GetContrastingColor("foreground", "Color3", v1)
    GetContrastingColor("background", "Color3", v2)
    local v4 = if type(v3) == "number" then v3 else 4.5
    local v5 = GetContrastRatio(v1, v2)
    if v4 <= v5 then
        return v1
    end
    if isDark(v2) then
        return Lighten(v1, (v4 - v5) / v4)
    end
    return Darken(v1, (v4 - v5) / v4)
end
