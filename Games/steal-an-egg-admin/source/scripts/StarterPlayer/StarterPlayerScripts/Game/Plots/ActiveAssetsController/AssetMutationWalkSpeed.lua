-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local v1 = require(ReplicatedStorage.Shared.Modules.Mutations).Ids()
local v2 = {}

local function hasMutation(v3, v4) -- line 10
    if v3.BaseMutation == v4 then
        return true
    end
    return table.find(v3.Mutations, v4) ~= nil
end

function v2.GetMultiplier(v5) -- line 14 | captures: AssetItem, v1
    local v6 = AssetItem.AssetItemData(v5)
    assert(v6, "Invalid asset item data")
    local Rainbow = v1.Rainbow
    if v5.BaseMutation == Rainbow or table.find(v5.Mutations, Rainbow) ~= nil then
        return 2
    end
    local Golden = v1.Golden
    if v5.BaseMutation == Golden or table.find(v5.Mutations, Golden) ~= nil then
        return 0.5
    end
    local Silver = v1.Silver
    if v5.BaseMutation == Silver or table.find(v5.Mutations, Silver) ~= nil then
        return 0.7
    end
    return 1
end

return v2
