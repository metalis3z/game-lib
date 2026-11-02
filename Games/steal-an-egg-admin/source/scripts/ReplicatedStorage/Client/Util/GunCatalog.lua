-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gears = require(ReplicatedStorage.Data.Gears)
local v1 = {}
for v2, v3 in pairs(Gears.Directory) do
    if v3.ToolController == "Gun" then
        v1[#v1 + 1] = v3._id
    end
end
table.freeze(v1)
local v4 = {}

function v4.ListGearNames() -- line 16 | captures: v1
    return table.clone(v1)
end

return v4
