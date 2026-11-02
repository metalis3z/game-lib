-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local AvatarEditorService = game:GetService("AvatarEditorService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Modules);
local Cache = require(Modules.Services.Cache);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local u1 = {};
local BodyAdjustment = require(ReplicatedStorage:WaitForChild("SortingSchema")).BodyAdjustment;

if BodyAdjustment and (BodyAdjustment.Subcategories and (BodyAdjustment.Subcategories.HeadShapes and BodyAdjustment.Subcategories.HeadShapes.Shapes)) then
    for _, v in BodyAdjustment.Subcategories.HeadShapes.Shapes do
        u1[tostring(v.AssetId)] = v;
    end;
end;

return function(p2) -- Line: 20
    -- upvalues: u1 (copy), CatalogUtilities (copy), AvatarEditorService (copy), Cache (copy)
    local u3 = {};
    local v4 = {};
    local v5 = {};

    for i, v in p2 do
        local v6 = tostring(i);
        local v7 = u1[v6];

        if v7 and (v.AssetType == "HeadShape" or v.ItemType == "HeadShape") then
            u3[v6] = CatalogUtilities.GetItemData({
                ItemType = "Asset",
                AssetType = "HeadShape",
                CreatorName = "Roblox",
                CreatorHasVerifiedBadge = true,
                PriceStatus = "Offsale",
                IsOffSale = true,
                Id = v7.AssetId,
                Name = v7.Name
            });
            p2[i] = nil;
        end;
    end;

    local function processBatch(u8, u9)
        local lastError = "no result";

        for attempt = 1, 4 do
            local success, result = pcall(function()
                return AvatarEditorService:GetBatchItemDetailsAsync(u8, u9);
            end);

            if success and typeof(result) == "table" then
                for _, v in result do
                    local v11 = CatalogUtilities.GetItemData(v);
                    Cache.Set("ItemData", tostring(v.Id), v11, 1200);
                    Cache.Set("ItemDetails", tostring(v.Id), v, 3600);
                    u3[tostring(v.Id)] = v11;
                end;

                return true;
            end;

            lastError = result;

            if attempt < 4 then
                task.wait(0.5 * 2 ^ (attempt - 1));
            end;
        end;

        warn("[GetBatchItemDetails] Giving up after 4 attempts: " .. tostring(lastError));
        return false;
    end;

    for i, v in p2 do
        local v12 = tostring(i);
        local v13 = Cache.Get("ItemData", v12);

        if v13 then
            u3[v12] = v13;
        elseif Cache.Get("ItemDetails", v12) then
            local v14 = Cache.Get("ItemDetails", v12);
            local v15 = CatalogUtilities.GetItemData(v14);
            Cache.Set("ItemData", tostring(v14.Id), v15, 1200);
            u3[tostring(v14.Id)] = v15;
        elseif v.ItemType == "Bundle" then
            local v16 = tonumber(i);
            table.insert(v5, v16);

            if #v5 >= 100 then
                processBatch(v5, Enum.AvatarItemType.Bundle);
                v5 = {};
            end;
        else
            local v17 = tonumber(i);
            table.insert(v4, v17);

            if #v4 >= 100 then
                processBatch(v4, Enum.AvatarItemType.Asset);
                v4 = {};
            end;
        end;
    end;

    if #v4 > 0 then
        processBatch(v4, Enum.AvatarItemType.Asset);
    end;

    if #v5 > 0 then
        processBatch(v5, Enum.AvatarItemType.Bundle);
    end;

    for i, v in p2 do
        local v18 = u3[tostring(i)];

        if v18 then
            v18.IsSelected = v.IsSelected;
            v18.Index = v.Index;
        end;
    end;

    return u3;
end;