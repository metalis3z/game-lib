-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local isDark = require(script.Parent.Util.Assert).prepTypeOf("isDark")
local GetLuminance = require(script.Parent.GetLuminance)
return function(v1) -- line 13 | captures: isDark, GetLuminance
    isDark("color", "Color3", v1)
    return GetLuminance(v1) < 0.5
end
