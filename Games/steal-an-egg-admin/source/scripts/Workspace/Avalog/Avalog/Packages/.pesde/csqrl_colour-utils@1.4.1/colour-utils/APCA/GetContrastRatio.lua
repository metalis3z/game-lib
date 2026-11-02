-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Parent.Util.Assert)
local Const = require(script.Parent.Const)
local GetContrastRatioAPCA = Assert.prepTypeOf("GetContrastRatioAPCA")
local abs = math.abs

local function ComputePower(v1) -- line 26 | captures: Const
    return v1 ^ Const.SRGB_TRC
end

local function ComputeY(v2) -- line 30 | captures: Const
    return v2.R ^ Const.SRGB_TRC * Const.RED_COEF + v2.G ^ Const.SRGB_TRC * Const.GREEN_COEF + v2.B ^ Const.SRGB_TRC * Const.BLUE_COEF
end

local function SoftClampBlack(v3) -- line 36 | captures: Const, abs
    if Const.BLK_THRS < v3 then
        return v3
    end
    local v4 = v3 - Const.BLK_THRS
    return v3 + abs(v4) ^ Const.BLK_CLMP
end

local function GetContrastRatio(v5, v6) -- line 48 | captures: Const, GetContrastRatioAPCA, abs
    GetContrastRatioAPCA("foreground", "Color3", v5)
    GetContrastRatioAPCA("background", "Color3", v6)
    local v7 = v5.R ^ Const.SRGB_TRC * Const.RED_COEF + v5.G ^ Const.SRGB_TRC * Const.GREEN_COEF + v5.B ^ Const.SRGB_TRC * Const.BLUE_COEF
    if not (Const.BLK_THRS < v7) then
        local v8 = v7 - Const.BLK_THRS
        v7 += abs(v8) ^ Const.BLK_CLMP
    end
    local v9 = v6.R ^ Const.SRGB_TRC * Const.RED_COEF + v6.G ^ Const.SRGB_TRC * Const.GREEN_COEF + v6.B ^ Const.SRGB_TRC * Const.BLUE_COEF
    if not (Const.BLK_THRS < v9) then
        local v10 = v9 - Const.BLK_THRS
        v9 += abs(v10) ^ Const.BLK_CLMP
    end
    local v11 = v9 - v7
    if abs(v11) < Const.MIN_DELTA_Y then
        return 0
    end
    local v12
    if v7 < v9 then
        local v13 = (v9 ^ Const.NORM_BG_EXP - v7 ^ Const.NORM_FG_EXP) * Const.SCALE_BOW
        if v13 < Const.LOW_CLIP then
            v12 = 0
        elseif v13 < Const.LOW_BOW_THRS then
            v12 = v13 - v13 * Const.LOW_BOW_FACT * Const.LOW_BOW_OFFS
        else
            v12 = v13 - Const.LOW_BOW_OFFS
        end
    else
        local v14 = (v9 ^ Const.REV_BG_EXP - v7 ^ Const.REV_FG_EXP) * Const.SCALE_WOB
        if -Const.LOW_CLIP < v14 then
            v12 = 0
        elseif -Const.LOW_WOB_THRS < v14 then
            v12 = v14 - v14 * Const.LOW_WOB_FACT * Const.LOW_WOB_OFFS
        else
            v12 = v14 + Const.LOW_WOB_OFFS
        end
    end
    return v12 * 100
end

return GetContrastRatio
