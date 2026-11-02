-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Types.GuardTutorial)
local v1 = table.freeze({ "StealEgg", "HeadToPen", "EquipEgg", "PlaceEgg", "HatchEgg", "PlacePet", "ExpandPen", "TreadmillIntro" })
local v2 = {}
for v3, v4 in ipairs(v1) do
    v2[v4] = v3
end
table.freeze(v2)
local v5 = {}

function v5.GetOrderedStepIds() -- line 24 | captures: v1
    return v1
end

function v5.GetFirstStepId() -- line 27 | captures: v1
    return v1[1]
end

function v5.GetIndex(v6) -- line 30 | captures: v2
    return v2[v6]
end

function v5.GetNextStepId(v7) -- line 34 | captures: v1, v5
    local v8 = v5.GetIndex(v7)
    if v8 == nil then
        return nil
    end
    return v1[v8 + 1]
end

return v5
