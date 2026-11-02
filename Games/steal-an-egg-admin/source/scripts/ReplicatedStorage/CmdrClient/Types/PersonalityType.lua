-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = {}
for v2 in pairs(require(ReplicatedStorage.Data.Assets).Personalities.Personalities) do
    table.insert(v1, v2)
end
table.sort(v1)
return function(v3) -- line 12 | captures: v1
    v3:RegisterType("personality", v3.Cmdr.Util.MakeEnumType("Personality", v1))
end
