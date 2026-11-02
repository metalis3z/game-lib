-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Darken = require(script.Parent.Darken)
local GetLuminance = require(script.Parent.GetLuminance)
local Lighten = require(script.Parent.Lighten)
return function(v1, v2, v3) -- line 14 | captures: Darken, GetLuminance, Lighten
    local v4 = if type(v3) ~= "number" or not v3 then 0.5 else v3
    return v4 < GetLuminance(v1) and Darken(v1, v2) or Lighten(v1, v2)
end
