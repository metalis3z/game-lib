-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(game.ReplicatedStorage.UserGenerated.Randoms.Base)
local Xorshift128 = require(game.ReplicatedStorage.UserGenerated.Randoms.Xorshift128)
local freeze = table.freeze
local v1 = { DefaultXorshift128 = Xorshift128.R }

function v1.Xorshift128(v2) -- line 10 | captures: Xorshift128
    return Xorshift128.new(v2)
end

function v1.UniqueXorshift128(v3) -- line 13 | captures: Xorshift128
    return Xorshift128.Unique(v3)
end

return freeze(v1)
