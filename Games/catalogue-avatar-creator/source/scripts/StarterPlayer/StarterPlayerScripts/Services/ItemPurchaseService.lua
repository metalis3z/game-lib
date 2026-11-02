-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local Modules = require(script.Parent.Parent.Modules);
local LocalPlayer = Players.LocalPlayer;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;
local LoadingController = require(Modules.Controllers.LoadingController);
local Cache = require(Modules.Services.Cache);
local ItemOwnershipService = require(Modules.Services.ItemOwnershipService);
local PriceDisplay = require(Modules.Services.PriceDisplay);
local RobloxPlusController = require(Modules.Controllers.RobloxPlusController);
local SpentTrackerClient = Modules.Services:FindFirstChild("SpentTrackerClient");
local u1;

if SpentTrackerClient then
    local success, result = pcall(require, SpentTrackerClient);
    u1 = success and result and result or nil;
else
    u1 = nil;
end;

local function buildSnapshotSafe(p2, p3) -- Line: 32
    -- upvalues: u1 (ref)
    if not u1 then
        return nil;
    end;

    local success, result = pcall(u1.BuildSnapshot, p2, p3);

    return success and result and result or nil;
end;

local u4 = {};

local function bucketSavings(p5) -- Line: 49
    return p5 < 50 and "low" or (p5 < 200 and "mid" or (p5 < 500 and "high" or "whale"));
end;

function u4.MaybeUpsell(p6, p7, p8) -- Line: 58
    -- upvalues: RobloxPlusController (copy), PriceDisplay (copy), Events (copy)
    if not RobloxPlusController.FeatureFlags.upsellModal then
        return;
    end;

    if typeof(p7) ~= "number" or p7 <= 0 then
        return;
    end;

    local success, result = pcall(PriceDisplay.ShouldShowUpsell, {
        savings = p7,
        baseTotal = p6,
        isBulk = p8
    });

    if not success then
        warn("[ItemPurchaseService] ShouldShowUpsell errored:", result);

        return;
    end;

    if not result then
        return;
    end;

    local v9 = {
        variant = RobloxPlusController.Config.ActiveUpsellFrequency,
        bucket = p7 < 50 and "low" or (p7 < 200 and "mid" or (p7 < 500 and "high" or "whale")),
        bulk = p8 and "bulk" or "single",
        savings = p7,
        baseTotal = p6,
        isBulk = p8
    };
    PriceDisplay.NotifyUpsellShown(v9);
    local v10 = Events.PromptGetRobloxPlus:Invoke({
        BaseTotal = p6,
        Savings = p7
    });

    if typeof(v10) ~= "table" then
        return;
    end;

    if v10.Yes then
        PriceDisplay.NotifyUpsellAccepted(v9);
        RobloxPlusController.TriggerSubscribe();

        return;
    end;

    if v10.DismissedViaClose then
        PriceDisplay.NotifyUpsellDismissed(v9);

        return;
    end;

    PriceDisplay.NotifyUpsellDeclined(v9);
end;

local function maybeUpsellSingle(p11) -- Line: 95
    -- upvalues: RobloxPlusController (copy), u4 (copy)
    if not p11 then
        return;
    end;

    local Price = p11.Price;

    if typeof(Price) ~= "number" or Price <= 0 then
        return;
    end;

    local v12 = RobloxPlusController.HypotheticalEffectivePrice(Price, 10);

    if typeof(v12) ~= "number" then
        return;
    end;

    u4.MaybeUpsell(Price, Price - v12, false);
end;

local function maybeUpsellBulk(p13) -- Line: 104
    -- upvalues: Cache (copy), RobloxPlusController (copy), u4 (copy)
    if not p13 or #p13 == 0 then
        return;
    end;

    local v14 = 0;
    local v15 = 0;

    for _, v in p13 do
        local v16 = Cache.Get("ItemData", (tostring(v.Id)));

        if v16 and (typeof(v16.Price) == "number" and v16.Price > 0) then
            v14 = v14 + v16.Price;
            local v17 = RobloxPlusController.HypotheticalEffectivePrice(v16.Price, 10);

            if typeof(v17) == "number" then
                v15 = v15 + (v16.Price - v17);
            end;
        end;
    end;

    u4.MaybeUpsell(v14, v15, true);
end;

local u18 = {
    Success = true,
    AlreadyOwned = true,
    NotForSale = true,
    QuantityLimitExceeded = true,
    NotAvailableForPurchaser = true,
    SoldOut = true,
    InsufficientMembership = true,
    PlaceInvalid = true,
    PurchaserIsSeller = true
};

function u4.PromptBulkPurchase(u19, p20) -- Line: 143
    -- upvalues: maybeUpsellBulk (copy), LoadingController (copy), ItemOwnershipService (copy), Remotes (copy), MarketplaceService (copy), LocalPlayer (copy), Events (copy), u1 (ref), u18 (copy), Cache (copy)
    maybeUpsellBulk(u19);
    local u21 = {};
    local u22 = 0;
    local u23 = 0;
    local v24 = #u19;

    if v24 == 0 then
        return;
    end;

    LoadingController.DisplayLoading(nil, "overlay");
    local BindableEvent = Instance.new("BindableEvent");
    local v25 = task.spawn(function() -- Line: 163
        -- upvalues: u19 (copy), ItemOwnershipService (ref), u22 (ref), u21 (copy), u23 (ref), BindableEvent (copy)
        for _, v in u19 do
            task.spawn(function() -- Line: 165
                -- upvalues: ItemOwnershipService (ref), v (copy), u22 (ref), u21 (ref), u23 (ref), BindableEvent (ref)
                if ItemOwnershipService.CheckItem(v) then
                    ItemOwnershipService._onPurchaseFinished:Fire(v.Id, v.Type == Enum.MarketplaceProductType.AvatarBundle and "Bundle" or "Asset", true);
                    u22 = u22 + 1;
                else
                    table.insert(u21, v);
                end;

                u23 = u23 + 1;
                BindableEvent:Fire();
            end);
        end;
    end);
    local v26 = false;

    while u22 < v24 do
        if #u21 > 0 and (#u21 < 20 and u23 < v24) then
            BindableEvent.Event:Wait();
        elseif #u21 == 0 then
            if v24 <= u23 then
                break;
            end;

            BindableEvent.Event:Wait();
        else
            local v27 = {};

            for _ = 1, math.min(#u21, 20) do
                table.insert(v27, table.remove(u21, 1));
            end;

            if not v26 then
                LoadingController.RemoveLoading();
                v26 = true;
            end;

            Remotes.PromptBulkPurchase:FireServer(v27);
            local v28, v29, v30 = MarketplaceService.PromptBulkPurchaseFinished:Wait();

            while v28 ~= LocalPlayer do
                v28, v29, v30 = MarketplaceService.PromptBulkPurchaseFinished:Wait();
            end;

            if v29 == Enum.MarketplaceBulkPurchasePromptStatus.Aborted then
                task.cancel(v25);
                Events.Notify:Fire("❌ Cancelled purchases.", 5);
                break;
            end;

            if u1 then
                pcall(u1.OnBulkResults, v30, p20);
            end;

            if v30 and v30.Items then
                for _, v in v30.Items do
                    local Name = v.status.Name;

                    if u18[Name] then
                        u22 = u22 + 1;

                        if Name == "Success" or Name == "AlreadyOwned" then
                            local v31 = v.type == Enum.MarketplaceProductType.AvatarBundle and "Bundle" or "Asset";
                            local v32 = v31 .. "_" .. tostring(v.id);
                            Cache.Set("OwnershipCache", v32, true, 900);
                            ItemOwnershipService._onPurchaseFinished:Fire(v.id, v31, true);
                        end;
                    else
                        table.insert(u21, 1, {
                            Type = v.type,
                            Id = v.id
                        });
                    end;
                end;
            end;

            if v29 == Enum.MarketplaceBulkPurchasePromptStatus.Error then
                task.cancel(v25);

                for _, v in v27 do
                    table.insert(u21, 1, v);
                end;

                break;
            end;
        end;
    end;

    if not v26 then
        LoadingController.RemoveLoading();
    end;

    BindableEvent:Destroy();
end;

function u4.PromptItemPurchase(u33, p34) -- Line: 277
    -- upvalues: RobloxPlusController (copy), u4 (copy), Remotes (copy), u1 (ref), Cache (copy)
    if u33 then
        local Price = u33.Price;

        if typeof(Price) == "number" and Price > 0 then
            local v35 = RobloxPlusController.HypotheticalEffectivePrice(Price, 10);

            if typeof(v35) == "number" then
                u4.MaybeUpsell(Price, Price - v35, false);
            end;
        end;
    end;

    if u33.ItemType == "Bundle" then
        local PurchaseItem = Remotes.PurchaseItem;
        local Id = u33.Id;
        local Id2 = u33.Id;
        local v36;

        if u1 then
            local success, result = pcall(u1.BuildSnapshot, Id2, "Bundle");
            v36 = success and result and result or nil;
        else
            v36 = nil;
        end;

        PurchaseItem:FireServer("Bundle", Id, v36, p34);

        return;
    end;

    if u33.Price and (typeof(u33.Price) == "number" or typeof(u33.Price) == "string" and u33.Price ~= "Offsale") or (u33.Price == nil or u33.AssetType and u33.AssetType == "MoodAnimation") then
        local PurchaseItem = Remotes.PurchaseItem;
        local Id = u33.Id;
        local Id2 = u33.Id;
        local v37;

        if u1 then
            local success, result = pcall(u1.BuildSnapshot, Id2, "Asset");
            v37 = success and result and result or nil;
        else
            v37 = nil;
        end;

        PurchaseItem:FireServer("Asset", Id, v37, p34);

        return;
    end;

    local v38 = Cache.GetOrFetchWithTimeout("AssetBundlePrices", tostring(u33.Id), 1800, function() -- Line: 291
        -- upvalues: Remotes (ref), u33 (copy)
        local success, result = pcall(function() -- Line: 292
            -- upvalues: Remotes (ref), u33 (ref)
            return Remotes.GetAssetBundlePrice:InvokeServer(u33.Id);
        end);

        return success and result and result or nil;
    end, 8);

    if v38 then
        local PurchaseItem = Remotes.PurchaseItem;
        local v39;

        if u1 then
            local success, result = pcall(u1.BuildSnapshot, v38, "Bundle");
            v39 = success and result and result or nil;
        else
            v39 = nil;
        end;

        PurchaseItem:FireServer("Bundle", v38, v39, p34);

        return;
    end;

    local PurchaseItem = Remotes.PurchaseItem;
    local Id = u33.Id;
    local Id2 = u33.Id;
    local v40;

    if u1 then
        local success, result = pcall(u1.BuildSnapshot, Id2, "Asset");
        v40 = success and result and result or nil;
    else
        v40 = nil;
    end;

    PurchaseItem:FireServer("Asset", Id, v40, p34);
end;

return u4;