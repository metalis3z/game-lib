-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GetPerceivedBrightness = require(script.Parent.Util.Assert).prepTypeOf("GetPerceivedBrightness")
return function(v1) -- line 12 | captures: GetPerceivedBrightness
    GetPerceivedBrightness("color", "Color3", v1)
    local v2 = v1.R * 255
    local v3 = v1.G * 255
    local v4 = v1.B * 255
    return (v2 * 299 + v3 * 587 + v4 * 114) / 1000 / 255
end
