-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local DeprecateWarnOnce = require(script.Util.DeprecateWarnOnce)
local GetContrastRatioCompat = require(script.GetContrastRatioCompat)
local WCAG = require(script.WCAG)
local v1 = {
    Darken = require(script.Darken),
    Desaturate = require(script.Desaturate),
    Emphasize = require(script.Emphasize),
    GetLuminance = require(script.GetLuminance),
    GetPerceivedBrightness = require(script.GetPerceivedBrightness),
    Invert = require(script.Invert),
    isDark = require(script.isDark),
    isLight = require(script.isLight),
    Lighten = require(script.Lighten),
    Rotate = require(script.Rotate),
    Saturate = require(script.Saturate),
    APCA = require(script.APCA),
    Blend = require(script.Blend),
    Blind = require(script.Blind),
    Hex = require(script.Hex),
    HSL = require(script.HSL),
    Int = require(script.Int),
    LAB = require(script.LAB),
    LCH = require(script.LCH),
    Palette = require(script.Palette),
    WCAG = WCAG
}

v1.Emphasise = DeprecateWarnOnce(v1.Emphasize)("ColorUtils.Emphasise", "ColorUtils.Emphasize")
v1.GetContrastingColor = DeprecateWarnOnce(WCAG.GetContrastingColor)("ColorUtils.GetContrastingColor", "WCAG.GetContrastingColor")
v1.GetContrastingColour = DeprecateWarnOnce(v1.GetContrastingColor)("ColorUtils.GetContrastingColour", "WCAG.GetContrastingColor")
v1.GetContrastRatio = DeprecateWarnOnce(GetContrastRatioCompat)("ColorUtils.GetContrastRatio", "WCAG.GetContrastRatio")
return v1
