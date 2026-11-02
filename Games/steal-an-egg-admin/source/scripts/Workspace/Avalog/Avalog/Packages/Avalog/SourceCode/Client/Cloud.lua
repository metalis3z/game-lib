-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local Parent = script.Parent.Parent.Parent
local client = require(Parent.SourceCode.Shared.Zap.client)
local States = require(Parent.SourceCode.Client.UI.States)
local Fusion = require(Parent.Parent.Fusion)
require(Parent.SourceCode.Shared.Types)
local v1 = {}

v1[Enum.MarketplaceProductType.AvatarAsset] = "Asset"
v1[Enum.MarketplaceProductType.AvatarBundle] = "Bundle"

local function IsItemEquipped(v2, v3) -- line 20 | captures: States, Fusion
    if v3 == "Asset" then
        local v4 = Fusion.peek(States.Avatar.EquippedAssetIds)
        return table.find(v4, (tonumber(v2))) ~= nil
    end
    if v3 == "Bundle" then
        local v5 = Fusion.peek(States.Avatar.EquippedBundleIds)
        return table.find(v5, (tonumber(v2))) ~= nil
    end
end

local v6 = {}

function v6.Start(v7) -- line 34 | captures: MarketplaceService, Players, client, States, Fusion, v1, IsItemEquipped
    MarketplaceService.PromptPurchaseFinished:Connect(function(v8, v9, v10) -- line 36 | captures: Players, client, States, Fusion
        if v10 and v8 == Players.LocalPlayer then
            local v11 = Fusion.peek(States.Avatar.EquippedAssetIds)
            if table.find(v11, (tonumber(v9))) ~= nil then
                client.RecordPurchase.Fire({
                    itemType = "Asset",
                    itemId = tostring(v9)
                })
            end
        end
    end)
    MarketplaceService.PromptBulkPurchaseFinished:Connect(function(v12, v13, v14) -- line 54 | captures: Players, client, v1, IsItemEquipped
        if v12 == Players.LocalPlayer and v13 == Enum.MarketplaceBulkPurchasePromptStatus.Completed then
            for v15, v16 in v14.Items do
                if v16.status == Enum.MarketplaceItemPurchaseStatus.Success then
                    local v17 = v1[v16.type]
                    if v17 ~= nil and IsItemEquipped(v16.id, v17) then
                        client.RecordPurchase.Fire({
                            itemId = v16.id,
                            itemType = v17
                        })
                    end
                end
            end
        end
    end)
end

function v6.Destroy(v18) -- line 77
end

return v6
