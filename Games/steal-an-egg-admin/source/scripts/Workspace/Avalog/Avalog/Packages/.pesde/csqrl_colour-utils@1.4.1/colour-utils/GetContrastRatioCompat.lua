-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GetContrastRatio = require(script.Parent.APCA.GetContrastRatio)
local v1 = false

local function getContrastRatioCompat(v2, v3) -- line 4 | captures: v1, GetContrastRatio
    local v4 = GetContrastRatio(v2, v3)
    local v5 = math.abs(v4)
    if not v1 then
        v1 = true
        warn("ColorUtils.GetContrastRatio is providing a compatibility layer for APCA.GetContrastRatio. To continue using the old behavior, use WCAG.GetContrastRatio instead.")
    end
    return v5 / 100 * 21
end

return getContrastRatioCompat
