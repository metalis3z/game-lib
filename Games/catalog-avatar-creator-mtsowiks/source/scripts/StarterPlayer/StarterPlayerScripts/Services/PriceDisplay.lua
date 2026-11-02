-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Parent = script.Parent.Parent;
local Controllers = Parent:WaitForChild("Controllers");
local Utilities = Parent:WaitForChild("Utilities");
local Events = Parent:WaitForChild("Events");
local RobloxPlusController = require(Controllers:WaitForChild("RobloxPlusController"));
local Readable = require(Utilities:WaitForChild("Readable"));
local CatalogUtilities = require(ReplicatedStorage:WaitForChild("CatalogUtilities"));
local ItemVariants = require(script:WaitForChild("ItemVariants"));
local TotalVariants = require(script:WaitForChild("TotalVariants"));
local Theme = require(script:WaitForChild("Theme"));
local UpsellFrequency = require(script:WaitForChild("UpsellFrequency"));

local function bucketSavings(p1) -- Line: 38
    return p1 < 50 and "low" or (p1 < 200 and "mid" or (p1 < 500 and "high" or "whale"));
end;

local u2 = nil;
task.spawn(function() -- Line: 47
    -- upvalues: ReplicatedStorage (copy), u2 (ref)
    local Remotes = ReplicatedStorage:WaitForChild("Remotes", 30);

    if not Remotes then
        return;
    end;

    u2 = Remotes:WaitForChild("AnalyticsEvent", 30);
end);

local function fireUpsellEvent(p3, p4) -- Line: 53
    -- upvalues: u2 (ref)
    if not u2 then
        return;
    end;

    pcall(u2.FireServer, u2, p3, p4);
end;

local u5 = {};
local BindableEvent = Instance.new("BindableEvent");
u5.OnChanged = BindableEvent.Event;
local u6 = false;

local function fireChanged() -- Line: 65
    -- upvalues: u6 (ref), BindableEvent (copy)
    if u6 then
        return;
    end;

    u6 = true;
    task.defer(function() -- Line: 68
        -- upvalues: u6 (ref), BindableEvent (ref)
        u6 = false;
        BindableEvent:Fire();
    end);
end;

RobloxPlusController.DiscountChanged:Connect(fireChanged);
RobloxPlusController.ConfigChanged:Connect(fireChanged);
local ThemeChanged = Events:FindFirstChild("ThemeChanged");

if ThemeChanged then
    ThemeChanged.Event:Connect(fireChanged);
end;

local function variantCtx(p7, p8, p9, p10, p11) -- Line: 82
    -- upvalues: CatalogUtilities (copy), RobloxPlusController (copy)
    return {
        base = p7,
        eff = p8,
        pct = p9,
        prefix = p10,
        format = p11 or CatalogUtilities.FormatNumber,
        color = RobloxPlusController.Config.DiscountColor
    };
end;

function u5.GetEffectivePrice(p12) -- Line: 95
    -- upvalues: RobloxPlusController (copy)
    return RobloxPlusController.GetEffectivePrice(p12);
end;

function u5.GetHypotheticalEffectivePrice(p13, p14) -- Line: 100
    -- upvalues: RobloxPlusController (copy)
    return RobloxPlusController.HypotheticalEffectivePrice(p13, p14);
end;

function u5.ItemPriceText(p15) -- Line: 108
    -- upvalues: RobloxPlusController (copy), Readable (copy), CatalogUtilities (copy), ItemVariants (copy)
    if typeof(p15) ~= "number" then
        return "";
    end;

    if not RobloxPlusController.FeatureFlags.priceVariants then
        return string.format(Readable.price, CatalogUtilities.FormatNumber(p15));
    end;

    local v16 = RobloxPlusController.GetEffectivePrice(p15);

    if typeof(v16) == "number" and p15 > v16 then
        return (ItemVariants[RobloxPlusController.Config.ActiveItemVariant or "chipSuffix"] or ItemVariants.chipSuffix)({
            prefix = nil,
            base = p15,
            eff = v16,
            pct = RobloxPlusController.DiscountPercent,
            format = CatalogUtilities.FormatNumber,
            color = RobloxPlusController.Config.DiscountColor
        });
    end;

    return string.format(Readable.price, CatalogUtilities.FormatNumber(p15));
end;

function u5.ApplyItemPriceText(p17, p18, p19) -- Line: 127
    -- upvalues: u5 (copy)
    if not p17 then
        return;
    end;

    p17.RichText = true;
    local v20 = u5.ItemPriceText(p18);

    if p19 and p19 ~= "" then
        v20 = v20 .. p19;
    end;

    p17.Text = v20;
end;

function u5.TotalPriceText(p21, p22, p23, p24) -- Line: 141
    -- upvalues: CatalogUtilities (copy), RobloxPlusController (copy), TotalVariants (copy)
    local v25 = p24 or CatalogUtilities.FormatNumber;
    local v26 = p23 or "";
    local v27 = typeof(p21) ~= "number" and 0 or p21;

    if typeof(p22) ~= "number" then
        p22 = v27;
    end;

    if not RobloxPlusController.FeatureFlags.priceVariants then
        return v26 .. v25(v27);
    end;

    if v27 <= p22 then
        return v26 .. v25(v27);
    end;

    return (TotalVariants[RobloxPlusController.Config.ActiveTotalVariant or "chipSuffix"] or TotalVariants.chipSuffix)({
        base = v27,
        eff = p22,
        pct = RobloxPlusController.DiscountPercent,
        prefix = v26,
        format = v25 or CatalogUtilities.FormatNumber,
        color = RobloxPlusController.Config.DiscountColor
    });
end;

function u5.SumItemFrames(p28, p29) -- Line: 168
    -- upvalues: RobloxPlusController (copy)
    local v30 = {};
    local v31 = 0;
    local v32 = 0;
    local v33 = 0;
    local v34 = 0;

    for _, child in p28:GetChildren() do
        local v35, v36 = p29(child);

        if typeof(v35) == "number" then
            local v37, v38;

            if v36 then
                local v39 = tostring(v36);

                if not v30[v39] then
                    v30[v39] = true;
                    v37 = RobloxPlusController.GetEffectivePrice(v35);

                    if typeof(v37) ~= "number" then
                        v37 = v35;
                    end;

                    v38 = RobloxPlusController.HypotheticalEffectivePrice(v35, 10);

                    if typeof(v38) ~= "number" then
                        v38 = v35;
                    end;

                    v33 = v33 + v35;
                    v34 = v34 + v37;
                    v31 = v31 + (v35 - v38);
                    v32 = v32 + 1;
                end;
            else
                v37 = RobloxPlusController.GetEffectivePrice(v35);

                if typeof(v37) ~= "number" then
                    v37 = v35;
                end;

                v38 = RobloxPlusController.HypotheticalEffectivePrice(v35, 10);

                if typeof(v38) ~= "number" then
                    v38 = v35;
                end;

                v33 = v33 + v35;
                v34 = v34 + v37;
                v31 = v31 + (v35 - v38);
                v32 = v32 + 1;
            end;
        end;
    end;

    return v33, v34, v32, v31;
end;

function u5.UpdateUpsellButton(p40, p41, p42, p43) -- Line: 214
    -- upvalues: RobloxPlusController (copy), Theme (copy), CatalogUtilities (copy)
    if not p40 then
        return;
    end;

    if not RobloxPlusController.FeatureFlags.upsellButtons then
        p40.Visible = false;

        return;
    end;

    local v44 = typeof(p41) ~= "number" and 0 or p41;
    local v45 = typeof(p42) ~= "number" and 0 or p42;
    local v46 = typeof(p43) ~= "number" and 0 or p43;

    if RobloxPlusController.IsSubscribed then
        v46 = v44 - v45;
    end;

    if typeof(v46) ~= "number" or v46 <= 0 then
        p40.Visible = false;

        return;
    end;

    p40.Visible = true;
    local label = p40:FindFirstChild("label");

    if not label then
        return;
    end;

    label.RichText = true;
    label.Text = string.format("%s <font color=\"%s\">%s<b>%s</b></font> with <b>Roblox Plus</b>", RobloxPlusController.IsSubscribed and "Saving" or "Save", RobloxPlusController.Config.DiscountColor, Theme.RobuxIcon, CatalogUtilities.FormatNumber(v46));
end;

local u47 = {
    dismissed = false,
    lastShown = 0,
    count = 0,
    lastAccepted = nil
};

function u5.ShouldShowUpsell(p48) -- Line: 253
    -- upvalues: RobloxPlusController (copy), UpsellFrequency (copy), u47 (copy)
    if RobloxPlusController.IsSubscribed then
        return false;
    end;

    local v49 = p48 or {};

    if typeof(v49.savings) ~= "number" or v49.savings <= 0 then
        return false;
    end;

    local success, result = pcall(UpsellFrequency[RobloxPlusController.Config.ActiveUpsellFrequency or "always"] or UpsellFrequency.always, u47, v49);

    if success then
        success = result == true;
    end;

    return success;
end;

local function analyticsPayload(p50) -- Line: 264
    -- upvalues: RobloxPlusController (copy)
    if not p50 then
        return nil;
    end;

    local v51 = {
        variant = p50.variant or RobloxPlusController.Config.ActiveUpsellFrequency
    };
    local bucket = p50.bucket;

    if not bucket then
        if typeof(p50.savings) == "number" then
            local savings = p50.savings;
            bucket = savings < 50 and "low" or (savings < 200 and "mid" or (savings < 500 and "high" or "whale")) or nil;
        else
            bucket = nil;
        end;
    end;

    v51.bucket = bucket;
    v51.bulk = p50.bulk or (p50.isBulk and "bulk" or "single");

    return v51;
end;

function u5.NotifyUpsellShown(p52) -- Line: 275
    -- upvalues: u47 (copy), analyticsPayload (copy), u2 (ref)
    u47.lastShown = os.time();
    local v53 = u47;
    v53.count = v53.count + 1;
    local v54 = analyticsPayload(p52);

    if not u2 then
        return;
    end;

    pcall(u2.FireServer, u2, "UpsellShown", v54);
end;

function u5.NotifyUpsellAccepted(p55) -- Line: 282
    -- upvalues: analyticsPayload (copy), u47 (copy), u2 (ref)
    local v56 = analyticsPayload(p55);
    local v57 = {
        acceptedAt = os.time()
    };
    local v58;

    if v56 then
        v58 = v56.variant or nil;
    else
        v58 = nil;
    end;

    v57.variant = v58;
    local v59;

    if v56 then
        v59 = v56.bucket or nil;
    else
        v59 = nil;
    end;

    v57.bucket = v59;
    local v60;

    if v56 then
        v60 = v56.bulk or nil;
    else
        v60 = nil;
    end;

    v57.bulk = v60;
    u47.lastAccepted = v57;

    if not u2 then
        return;
    end;

    pcall(u2.FireServer, u2, "UpsellAccepted", v56);
end;

function u5.NotifyUpsellDeclined(p61) -- Line: 294
    -- upvalues: analyticsPayload (copy), u2 (ref)
    local v62 = analyticsPayload(p61);

    if not u2 then
        return;
    end;

    pcall(u2.FireServer, u2, "UpsellDeclined", v62);
end;

function u5.NotifyUpsellDismissed(p63) -- Line: 302
    -- upvalues: u47 (copy), RobloxPlusController (copy), analyticsPayload (copy), u2 (ref)
    u47.dismissed = true;

    if RobloxPlusController._setPersistedDismissedAt then
        RobloxPlusController._setPersistedDismissedAt(workspace:GetServerTimeNow());
    end;

    local v64 = analyticsPayload(p63);

    if not u2 then
        return;
    end;

    pcall(u2.FireServer, u2, "UpsellDismissed", v64);
end;

RobloxPlusController.Subscribed:Connect(function() -- Line: 313
    -- upvalues: u47 (copy), u2 (ref)
    local lastAccepted = u47.lastAccepted;

    if not lastAccepted then
        return;
    end;

    if os.time() - lastAccepted.acceptedAt > 1800 then
        u47.lastAccepted = nil;

        return;
    end;

    local v65 = {
        variant = lastAccepted.variant,
        bucket = lastAccepted.bucket,
        bulk = lastAccepted.bulk
    };

    if u2 then
        pcall(u2.FireServer, u2, "UpsellConverted", v65);
    end;

    u47.lastAccepted = nil;
end);

function u5.WireUpsellButton(p66) -- Line: 331
    -- upvalues: RobloxPlusController (copy)
    if not (p66 and p66.Activated) then
        return nil;
    end;

    p66.Visible = false;

    return p66.Activated:Connect(RobloxPlusController.TriggerSubscribe);
end;

function u5.RegisterItemLabel(u67, u68, u69) -- Line: 342
    -- upvalues: u5 (copy)
    if not u67 then
        return function() -- Line: 343
        end;
    end;

    local u70 = nil;
    local u71 = nil;

    local function cleanup() -- Line: 346
        -- upvalues: u70 (ref), u71 (ref)
        if u70 then
            u70:Disconnect();
            u70 = nil;
        end;

        if u71 then
            u71:Disconnect();
            u71 = nil;
        end;
    end;

    local function render() -- Line: 350
        -- upvalues: u67 (copy), u68 (copy), u69 (copy), u5 (ref)
        if not (u67 and u67.Parent) then
            return;
        end;

        local v72 = u68();

        if typeof(v72) == "number" then
            local v73;

            if u69 then
                v73 = u69();
            else
                v73 = nil;
            end;

            u5.ApplyItemPriceText(u67, v72, v73);
        end;
    end;

    if u67 and u67.Parent then
        local v74 = u68();

        if typeof(v74) == "number" then
            local v75;

            if u69 then
                v75 = u69();
            else
                v75 = nil;
            end;

            u5.ApplyItemPriceText(u67, v74, v75);
        end;
    end;

    u70 = u5.OnChanged:Connect(render);
    u71 = u67.Destroying:Connect(cleanup);

    return cleanup;
end;

return u5;