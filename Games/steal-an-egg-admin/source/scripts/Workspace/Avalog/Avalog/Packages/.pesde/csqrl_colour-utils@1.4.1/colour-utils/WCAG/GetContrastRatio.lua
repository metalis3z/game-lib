-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GetContrastRatio = require(script.Parent.Parent.Util.Assert).prepTypeOf("GetContrastRatio")
local GetLuminance = require(script.Parent.Parent.GetLuminance)
local max = math.max
local min = math.min
return function(v1, v2) -- line 17 | captures: GetContrastRatio, GetLuminance, max, min
    GetContrastRatio("foreground", "Color3", v1)
    GetContrastRatio("background", "Color3", v2)
    local v3 = GetLuminance(v1)
    local v4 = GetLuminance(v2)
    return (max(v3, v4) + 0.05) / (min(v3, v4) + 0.05)
end
