-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent:WaitForChild("Modules"));
local Cache = require(Modules.Services:WaitForChild("Cache"));
local GetBatchItemDetails = require(Modules.Utilities:WaitForChild("GetBatchItemDetails"));
local v1 = {};

local function snapshotFromCache(p2) -- Line: 30
    -- upvalues: Cache (copy)
    local v3 = Cache.Get("ItemData", p2);

    return v3 and (typeof(v3.Price) == "number" and v3.Price > 0) and {
        price = v3.Price
    } or nil;
end;

function v1.BuildSnapshot(p4, p5) -- Line: 42
    -- upvalues: snapshotFromCache (copy), GetBatchItemDetails (copy)
    if p4 == nil then
        return nil;
    end;

    local v6 = tostring(p4);
    local v7 = snapshotFromCache(v6);

    if v7 then
        return v7;
    end;

    if pcall(GetBatchItemDetails, {
        [v6] = {
            ItemType = p5 == "Bundle" and "Bundle" or "Asset"
        }
    }) then
        return snapshotFromCache(v6);
    end;

    return nil;
end;

function v1.OnBulkResults(p8, p9) -- Line: 59
    -- upvalues: Cache (copy), GetBatchItemDetails (copy), snapshotFromCache (copy), ReplicatedStorage (copy)
    if typeof(p8) ~= "table" then
        return;
    end;

    local Items = p8.Items;

    if typeof(Items) ~= "table" then
        return;
    end;

    local v10 = {};

    for _, v in Items do
        if v.status == Enum.MarketplaceItemPurchaseStatus.Success then
            local v11 = tostring(v.id);

            if not Cache.Get("ItemData", v11) then
                v10[v11] = {
                    ItemType = v.type == Enum.MarketplaceProductType.AvatarBundle and "Bundle" or "Asset"
                };
            end;
        end;
    end;

    if next(v10) then
        pcall(GetBatchItemDetails, v10);
    end;

    local v12 = {};

    for _, v in Items do
        if v.status == Enum.MarketplaceItemPurchaseStatus.Success then
            local v13 = tostring(v.id);
            local v14 = snapshotFromCache(v13);

            if v14 then
                v12[v13] = v14;
            end;
        end;
    end;

    local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5);

    if Remotes then
        Remotes = Remotes:FindFirstChild("BulkPurchaseDone");
    end;

    if Remotes then
        Remotes:FireServer(typeof(p8.RobuxSpent) == "number" and (p8.RobuxSpent or 0) or 0, v12, p9);
    end;
end;

return v1;