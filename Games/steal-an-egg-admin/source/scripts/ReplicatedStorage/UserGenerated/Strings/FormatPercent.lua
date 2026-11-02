-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatFigures = require(ReplicatedStorage.UserGenerated.Strings.FormatFigures)
return function(v1) -- line 8 | captures: FormatFigures
    return FormatFigures(v1 * 100, 4, 5) .. "%"
end
