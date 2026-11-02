-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local v1 = {}
for v2 in pairs(Assets.Directory) do
    table.insert(v1, v2)
end
table.sort(v1)
return function(v3) -- line 13 | captures: v1
    v3:RegisterType("assetName", v3.Cmdr.Util.MakeEnumType("AssetName", v1))
end
