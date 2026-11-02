-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local AvatarEditorService = game:GetService("AvatarEditorService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Parent = script.Parent.Parent;
local Modules = require(Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local Cache = require(script.Parent:WaitForChild("Cache"));
local ItemOwnershipService = require(script.Parent:WaitForChild("ItemOwnershipService"));
local ItemButton = require(Parent:WaitForChild("Elements"):WaitForChild("ItemButton"));
local CatalogUtilities = require(ReplicatedStorage:WaitForChild("CatalogUtilities"));
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local u1 = {
    Head = 1,
    DynamicHead = 1,
    RightLeg = 2,
    Torso = 3,
    LeftLeg = 4,
    LeftArm = 5,
    RightArm = 6
};

local function sortForBundleResolution(p2) -- Line: 34
    -- upvalues: u1 (copy)
    local v3 = {};

    for _, v in p2 do
        table.insert(v3, v);
    end;

    table.sort(v3, function(p4, p5) -- Line: 39
        -- upvalues: u1 (ref)
        return (u1[p4.AssetType] or 100) < (u1[p5.AssetType] or 100);
    end);

    return v3;
end;

local v6 = {};

local function addOwnedLabel(p7) -- Line: 48
    -- upvalues: ItemButton (copy), ThemeController (copy)
    if p7:GetAttribute("hasOwnedLabel") then
        return;
    end;

    p7:SetAttribute("hasOwnedLabel", true);
    local v8 = ItemButton.AddLabel(p7, "Owned", -1);
    v8.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(254, 254, 255));
    v8.value.TextColor3 = ThemeController.GetColor(Color3.fromRGB(18, 18, 21));
end;

local function applyBundlePrice(p9, u10, p11, p12) -- Line: 59
    -- upvalues: Cache (copy), AvatarEditorService (copy), ItemButton (copy), ItemOwnershipService (copy), addOwnedLabel (copy)
    local v13 = p11:FindFirstChild((tostring(p9)));

    if v13 and u10 then
        local v14 = Cache.GetOrFetchWithTimeout("ItemDetails", tostring(u10), 1800, function() -- Line: 62
            -- upvalues: AvatarEditorService (ref), u10 (copy)
            local success, result = pcall(function() -- Line: 63
                -- upvalues: AvatarEditorService (ref), u10 (ref)
                return AvatarEditorService:GetItemDetails(u10, Enum.AvatarItemType.Bundle);
            end);

            return success and result and result or nil;
        end, 8);

        if v14 then
            local v15 = (v14.IsOffSale == true or v14.PriceStatus == "Off Sale") and true or v14.PriceStatus == "Offsale";
            local v16;

            if typeof(v14.LowestResalePrice) == "number" then
                v16 = v14.LowestResalePrice > 0;
            else
                v16 = false;
            end;

            local v17 = nil;

            if v15 and not v16 then
                v17 = nil;
            elseif v16 then
                v17 = v14.LowestResalePrice;
            elseif typeof(v14.LowestPrice) == "number" and v14.LowestPrice > 0 then
                v17 = v14.LowestPrice;
            elseif typeof(v14.Price) == "number" then
                v17 = v14.Price;
            end;

            local v18 = (typeof(v17) ~= "number" or v17 <= 0) and (v17 == 0 and "Free" or "OffSale") or v17;
            v13:SetAttribute("truePrice", v17 or 0);
            v13:SetAttribute("bundleId", u10);
            v13:SetAttribute("isOffSale", v18 == "OffSale");
            v13:SetAttribute("priceSuffix", " (Bundle)");
            ItemButton.SetPriceLabel(v13, v18);

            if ItemOwnershipService.CheckItem({
                ItemType = "Bundle",
                Id = tostring(u10)
            }) then
                addOwnedLabel(v13);
            end;
        end;

        if p12 then
            p12();
        end;
    elseif v13 then
        ItemButton.SetPriceLabel(v13, "OffSale");
        v13:SetAttribute("isOffSale", true);

        if p12 then
            p12();
        end;
    end;
end;

local function collectBundleCandidates(p19) -- Line: 147
    -- upvalues: sortForBundleResolution (copy), CatalogUtilities (copy), Cache (copy)
    local v20 = {};
    local v21 = {};
    local v22 = {};

    for _, v in sortForBundleResolution(p19) do
        local v23 = tonumber(v.Id);
        local Price = v.Price;

        if typeof(Price) == "string" and (Price ~= "Free" and (v.AssetType ~= "MoodAnimation" and (v.AssetType ~= "HeadShape" and not CatalogUtilities.DefaultRobloxClothingIds[v23]))) then
            table.insert(v20, v23);
            local v24 = Cache.Get("AssetBundlePrices", (tostring(v23)));

            if v24 then
                v21[tostring(v23)] = v24;
            else
                table.insert(v22, v23);
            end;
        end;
    end;

    return v20, v22, v21;
end;

local function fetchBundleIdsChunk(u25, u26) -- Line: 177
    -- upvalues: Remotes (copy), Cache (copy)
    local u27 = false;
    task.spawn(function() -- Line: 179
        -- upvalues: Remotes (ref), u25 (copy), u26 (copy), Cache (ref), u27 (ref)
        local v28, v29, v30 = pcall(function() -- Line: 180
            -- upvalues: Remotes (ref), u25 (ref)
            return Remotes.GetAssetBundlePriceBatch:InvokeServer(u25);
        end);

        if v28 and (v29 == true and typeof(v30) == "table") then
            for i, v in v30 do
                if typeof(v) == "table" and typeof(v.bundleId) == "number" then
                    u26[i] = v.bundleId;
                    Cache.Set("AssetBundlePrices", i, v.bundleId, 1800);

                    if typeof(v.siblings) == "table" then
                        for _, v2 in v.siblings do
                            Cache.Set("AssetBundlePrices", tostring(v2), v.bundleId, 1800);
                        end;
                    end;
                end;
            end;
        end;

        u27 = true;
    end);
    local v31 = 0;

    while not u27 and v31 < 15 do
        task.wait(0.1);
        v31 = v31 + 0.1;
    end;
end;

local function fetchBundleIdsBatch(p32) -- Line: 207
    -- upvalues: fetchBundleIdsChunk (copy)
    local v33 = {};

    if #p32 == 0 then
        return v33;
    end;

    for i = 1, #p32, 60 do
        fetchBundleIdsChunk(table.move(p32, i, math.min(i + 60 - 1, #p32), 1, {}), v33);
    end;

    return v33;
end;

local function prefetchBundleDetails(p34) -- Line: 224
    -- upvalues: Cache (copy), AvatarEditorService (copy)
    local v35 = {};
    local u36 = {};

    for _, v in p34 do
        if not v35[v] then
            v35[v] = true;

            if Cache.Get("ItemDetails", (tostring(v))) == nil then
                table.insert(u36, v);
            end;
        end;
    end;

    if #u36 == 0 then
        return;
    end;

    local success, result = pcall(function() -- Line: 237
        -- upvalues: AvatarEditorService (ref), u36 (copy)
        return AvatarEditorService:GetBatchItemDetailsAsync(u36, Enum.AvatarItemType.Bundle);
    end);

    if success and result then
        for _, v in result do
            Cache.Set("ItemDetails", tostring(v.Id), v, 1800);
        end;
    end;
end;

function v6.Resolve(u37, u38, p39) -- Line: 262
    -- upvalues: ItemOwnershipService (copy), addOwnedLabel (copy), collectBundleCandidates (copy), fetchBundleIdsBatch (copy), prefetchBundleDetails (copy), applyBundlePrice (copy)
    local v40 = p39 or {};
    local onUpdate = v40.onUpdate;
    local onComplete = v40.onComplete;
    local v41 = v40.threads or {};
    table.insert(v41, task.spawn(function() -- Line: 269
        -- upvalues: ItemOwnershipService (ref), u38 (copy), u37 (copy), addOwnedLabel (ref)
        ItemOwnershipService.CheckBatch(u38, function(p42, p43) -- Line: 270
            -- upvalues: u37 (ref), addOwnedLabel (ref)
            local v44 = p43 and u37:FindFirstChild((tostring(p42.Id)));

            if v44 then
                addOwnedLabel(v44);
            end;
        end);
    end));
    table.insert(v41, task.spawn(function() -- Line: 282
        -- upvalues: collectBundleCandidates (ref), u38 (copy), fetchBundleIdsBatch (ref), prefetchBundleDetails (ref), applyBundlePrice (ref), u37 (copy), onUpdate (copy), onComplete (copy)
        local v45, v46, v47 = collectBundleCandidates(u38);

        for i, v in fetchBundleIdsBatch(v46) do
            v47[i] = v;
        end;

        prefetchBundleDetails(v47);

        for _, v in v45 do
            applyBundlePrice(v, v47[tostring(v)], u37, onUpdate);
        end;

        if onComplete then
            onComplete();
        end;
    end));

    return v41;
end;

function v6.ResolveBundleIds(p48) -- Line: 310
    -- upvalues: collectBundleCandidates (copy), fetchBundleIdsBatch (copy)
    local _, v49, v50 = collectBundleCandidates(p48);

    for i, v in fetchBundleIdsBatch(v49) do
        v50[i] = v;
    end;

    return v50;
end;

return v6;