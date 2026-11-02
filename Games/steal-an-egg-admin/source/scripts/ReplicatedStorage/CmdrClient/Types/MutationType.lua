-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local v1 = {}
for v2 in pairs(Mutations.Ids()) do
    table.insert(v1, v2)
end
table.sort(v1)
return function(v3) -- line 13 | captures: v1
    local v4 = v3.Cmdr.Util.MakeEnumType("Mutation", v1)
    v3:RegisterType("mutation", v4)
    v3:RegisterType("mutations", v3.Cmdr.Util.MakeListableType(v4))
end
