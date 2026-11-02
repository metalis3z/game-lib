-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GetLuminance = require(script.Parent.Util.Assert).prepTypeOf("GetLuminance")

local function transformValue(v1) -- line 5
    return v1 <= 0.03928 and v1 / 12.92 or ((v1 + 0.055) / 1.055) ^ 2.4
end

return function(v2) -- line 16 | captures: GetLuminance
    GetLuminance("color", "Color3", v2)
    local R = v2.R
    local v3 = R <= 0.03928 and R / 12.92 or ((R + 0.055) / 1.055) ^ 2.4
    local G = v2.G
    local v4 = G <= 0.03928 and G / 12.92 or ((G + 0.055) / 1.055) ^ 2.4
    local B = v2.B
    local v5 = B <= 0.03928 and B / 12.92 or ((B + 0.055) / 1.055) ^ 2.4
    return v3 * 0.2126 + v4 * 0.7152 + v5 * 0.0722
end
