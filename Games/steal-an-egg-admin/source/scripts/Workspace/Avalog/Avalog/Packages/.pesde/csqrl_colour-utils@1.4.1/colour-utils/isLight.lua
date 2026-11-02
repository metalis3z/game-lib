-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local isLight = require(script.Parent.Util.Assert).prepTypeOf("isLight")
local isDark = require(script.Parent.isDark)
return function(v1) -- line 13 | captures: isLight, isDark
    isLight("color", "Color3", v1)
    return not isDark(v1)
end
