-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoundFigures = require(ReplicatedStorage.UserGenerated.Math.RoundFigures)
local Commas = require(ReplicatedStorage.UserGenerated.Strings.Commas)
return function(v1, v2, v3, v4) -- line 9 | captures: RoundFigures, Commas
    return Commas(RoundFigures(v1, v2, v3, v4))
end
