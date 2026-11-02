-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Areas = require(ReplicatedStorage.Data.Areas)
local v1 = {}
for v2 in pairs(Areas.Directory) do
    table.insert(v1, v2)
end
table.sort(v1, function(v3, v4) -- line 12 | captures: Areas
    local RarityNumber = Areas.Directory[v3].Rarity.RarityNumber
    local RarityNumber_2 = Areas.Directory[v4].Rarity.RarityNumber
    if RarityNumber == RarityNumber_2 then
        return v3 < v4
    end
    return RarityNumber < RarityNumber_2
end)
return function(v5) -- line 23 | captures: v1
    v5:RegisterType("guardArea", v5.Cmdr.Util.MakeEnumType("GuardArea", v1))
end
