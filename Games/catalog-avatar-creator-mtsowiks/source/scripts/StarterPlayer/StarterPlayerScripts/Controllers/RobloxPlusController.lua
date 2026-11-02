-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = { "chipSuffix", "chipSuffixSaved", "strikethrough", "strikeAndPercent", "arrow", "minimalist", "saved", "savedParen", "plusPct", "plusSave", "plusBadge" };
local u2 = { "none", "always", "onceDismissed", "onceDismissedPersistent", "cooldown60", "cooldown300", "firstOnly", "highSavings100", "highSavings500" };
local u3 = {
    none = 10,
    always = 20,
    onceDismissedPersistent = 25,
    cooldown60 = 20,
    highSavings100 = 15,
    firstOnly = 10
};
local u4 = { "on", "off", "tier", "variant", "itemvariant", "totalvariant", "color", "upsell", "status" };
local u5 = { "priceVariants", "upsellButtons", "upsellModal", "upsellBanner" };
local u13 = {
    ActiveItemVariant = "chipSuffix",
    ActiveTotalVariant = "chipSuffix",
    DiscountColor = "#00D886",
    ActiveUpsellFrequency = "always",
    DismissTTLSeconds = 172800,
    HighSavingsThreshold = 100,
    ActiveUpsellFrequency = (function(p6) -- Line: 58, Name: assignUpsellVariant
        -- upvalues: u3 (copy)
        local v7 = {};
        local v8 = 0;

        for i, v in pairs(u3) do
            table.insert(v7, {
                name = i,
                weight = v
            });
            v8 = v8 + v;
        end;

        table.sort(v7, function(p9, p10) -- Line: 66
            return p9.name < p10.name;
        end);
        local v11 = p6 % v8;
        local v12 = 0;

        for _, v in v7 do
            v12 = v12 + v.weight;

            if v11 < v12 then
                return v.name;
            end;
        end;

        return v7[#v7].name;
    end)(LocalPlayer.UserId)
};
local u14 = 0;
local BindableEvent = Instance.new("BindableEvent");
local BindableEvent2 = Instance.new("BindableEvent");
local BindableEvent3 = Instance.new("BindableEvent");
local u16 = {
    UpsellDismissed = false,
    DiscountPercent = 0,
    SubscribedAt = nil,
    IsSubscribed = LocalPlayer.HasRobloxSubscription,
    Subscribed = BindableEvent.Event,
    DiscountChanged = BindableEvent2.Event,
    ConfigChanged = BindableEvent3.Event,
    Config = u13,

    GetPersistedDismissedAt = function() -- Line: 106, Name: GetPersistedDismissedAt
        -- upvalues: u14 (ref)
        return u14;
    end,

    _setPersistedDismissedAt = function(p15) -- Line: 109, Name: _setPersistedDismissedAt
        -- upvalues: u14 (ref)
        u14 = p15;
    end,

    FeatureFlags = {
        priceVariants = false,
        upsellButtons = false,
        upsellModal = false,
        upsellBanner = false
    }
};
local u17 = false;

local function fireUpsellAssignedIfNeeded() -- Line: 126
    -- upvalues: u17 (ref), u16 (copy), u13 (copy)
    if u17 then
        return;
    end;

    if not u16.FeatureFlags.upsellModal then
        return;
    end;

    u17 = true;
    task.spawn(function() -- Line: 130
        -- upvalues: u13 (ref)
        local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 30);

        if not Remotes then
            return;
        end;

        local AnalyticsEvent = Remotes:WaitForChild("AnalyticsEvent", 30);

        if not AnalyticsEvent then
            return;
        end;

        pcall(AnalyticsEvent.FireServer, AnalyticsEvent, "UpsellAssigned", {
            variant = u13.ActiveUpsellFrequency
        });
    end);
end;

local u18 = nil;
local u19 = nil;
local u20 = nil;

local function updateBannerVisibility() -- Line: 148
    -- upvalues: u19 (ref), u16 (copy)
    if not u19 then
        return;
    end;

    u19.Enabled = not u16.IsSubscribed and u16.FeatureFlags.upsellBanner and not u16.UpsellDismissed;
end;

local function cancelBoundaryTask() -- Line: 156
    -- upvalues: u18 (ref)
    if u18 then
        pcall(task.cancel, u18);
        u18 = nil;
    end;
end;

local function setDiscount(p21, p22) -- Line: 163
    -- upvalues: u16 (copy), BindableEvent2 (copy)
    local DiscountPercent = u16.DiscountPercent;
    u16.DiscountPercent = p21;
    u16.SubscribedAt = p22;

    if DiscountPercent ~= p21 then
        BindableEvent2:Fire(p21, DiscountPercent);
    end;
end;

local function computeDiscountForStartTime(p23) -- Line: 172
    return p23 and (os.time() - p23 > 5184000 and 20 or 10) or 10;
end;

local function scheduleTierBoundary() -- Line: 178
    -- upvalues: u18 (ref), u16 (copy), BindableEvent2 (copy)
    if u18 then
        pcall(task.cancel, u18);
        u18 = nil;
    end;

    local SubscribedAt = u16.SubscribedAt;

    if not SubscribedAt then
        return;
    end;

    if u16.DiscountPercent >= 20 then
        return;
    end;

    local v24 = SubscribedAt + 5184000 - os.time();

    if v24 > 0 then
        u18 = task.delay(v24, function() -- Line: 188
            -- upvalues: u16 (ref), BindableEvent2 (ref), u18 (ref)
            if u16.IsSubscribed and u16.DiscountPercent == 10 then
                local SubscribedAt2 = u16.SubscribedAt;
                local DiscountPercent = u16.DiscountPercent;
                u16.DiscountPercent = 20;
                u16.SubscribedAt = SubscribedAt2;

                if DiscountPercent ~= 20 then
                    BindableEvent2:Fire(20, DiscountPercent);
                end;
            end;

            u18 = nil;
        end);

        return;
    end;

    local DiscountPercent = u16.DiscountPercent;
    u16.DiscountPercent = 20;
    u16.SubscribedAt = SubscribedAt;

    if DiscountPercent ~= 20 then
        BindableEvent2:Fire(20, DiscountPercent);
    end;
end;

local function queryStartTimeAsync() -- Line: 196
    -- upvalues: MarketplaceService (copy), LocalPlayer (copy)
    local success, result = pcall(function() -- Line: 199
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
        return MarketplaceService:GetRobloxSubscriptionDetailsAsync(LocalPlayer);
    end);

    if success and (result and (result.IsSubscribed and (result.StartTime and result.StartTime.UnixTimestamp))) then
        return result.StartTime.UnixTimestamp;
    end;

    return nil;
end;

local function applySubscribedState(p25, p26) -- Line: 208
    -- upvalues: u16 (copy), BindableEvent (copy), BindableEvent2 (copy), scheduleTierBoundary (copy), u19 (ref), u20 (ref)
    local IsSubscribed = u16.IsSubscribed;
    u16.IsSubscribed = true;

    if not IsSubscribed then
        BindableEvent:Fire();
    end;

    local v27 = p25 and (os.time() - p25 > 5184000 and 20 or 10) or 10;
    local v28 = p25 or os.time();
    local DiscountPercent = u16.DiscountPercent;
    u16.DiscountPercent = v27;
    u16.SubscribedAt = v28;

    if DiscountPercent ~= v27 then
        BindableEvent2:Fire(v27, DiscountPercent);
    end;

    scheduleTierBoundary();

    if u19 then
        u19.Enabled = not u16.IsSubscribed and u16.FeatureFlags.upsellBanner and not u16.UpsellDismissed;
    end;

    if p26 and u20 then
        u20:Fire("🎉 Enjoy <b>" .. v27 .. "%</b> off all purchases!");
    end;
end;

local function applyUnsubscribedState() -- Line: 222
    -- upvalues: u16 (copy), u18 (ref), BindableEvent2 (copy), u19 (ref)
    u16.IsSubscribed = false;

    if u18 then
        pcall(task.cancel, u18);
        u18 = nil;
    end;

    local DiscountPercent = u16.DiscountPercent;
    u16.DiscountPercent = 0;
    u16.SubscribedAt = nil;

    if DiscountPercent ~= 0 then
        BindableEvent2:Fire(0, DiscountPercent);
    end;

    if not u19 then
        return;
    end;

    u19.Enabled = not u16.IsSubscribed and u16.FeatureFlags.upsellBanner and not u16.UpsellDismissed;
end;

function u16.IsEligible(p29) -- Line: 229
    local v30;

    if typeof(p29) == "number" and p29 > 0 then
        v30 = p29 <= 1000000;
    else
        v30 = false;
    end;

    return v30;
end;

function u16.GetEffectivePrice(p31) -- Line: 233
    -- upvalues: u16 (copy)
    if not u16.IsSubscribed then
        return p31;
    end;

    if not u16.IsEligible(p31) then
        return p31;
    end;

    local DiscountPercent = u16.DiscountPercent;

    if DiscountPercent <= 0 then
        return p31;
    end;

    return math.floor(p31 * (100 - DiscountPercent) / 100);
end;

function u16.GetDiscountAmount(p32) -- Line: 241
    -- upvalues: u16 (copy)
    if not u16.IsEligible(p32) then
        return 0;
    end;

    local v33 = u16.GetEffectivePrice(p32);

    return typeof(v33) ~= "number" and 0 or p32 - v33;
end;

function u16.HypotheticalEffectivePrice(p34, p35) -- Line: 250
    -- upvalues: u16 (copy)
    if u16.IsEligible(p34) then
        return math.floor(p34 * (100 - (p35 or 10)) / 100);
    end;

    return p34;
end;

function u16.TriggerSubscribe() -- Line: 259
    -- upvalues: u16 (copy), MarketplaceService (copy), LocalPlayer (copy)
    if u16.IsSubscribed then
        return;
    end;

    local success, result = pcall(function() -- Line: 265
        -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
        MarketplaceService:PromptRobloxSubscriptionPurchase(LocalPlayer);
    end);

    if not success then
        warn("[RobloxPlusController] PromptRobloxSubscriptionPurchase failed: " .. tostring(result));
    end;
end;

function u16.MockSubscribe(p36) -- Line: 277
    -- upvalues: applySubscribedState (copy)
    local v37;

    if p36 then
        v37 = os.time() - 5184000 - 1;
    else
        v37 = os.time();
    end;

    applySubscribedState(v37, true);
end;

function u16.MockUnsubscribe() -- Line: 282
    -- upvalues: u16 (copy), u18 (ref), BindableEvent2 (copy), u19 (ref)
    u16.IsSubscribed = false;

    if u18 then
        pcall(task.cancel, u18);
        u18 = nil;
    end;

    local DiscountPercent = u16.DiscountPercent;
    u16.DiscountPercent = 0;
    u16.SubscribedAt = nil;

    if DiscountPercent ~= 0 then
        BindableEvent2:Fire(0, DiscountPercent);
    end;

    if not u19 then
        return;
    end;

    u19.Enabled = not u16.IsSubscribed and u16.FeatureFlags.upsellBanner and not u16.UpsellDismissed;
end;

function u16.SetDiscountPercent(p38) -- Line: 286
    -- upvalues: u16 (copy), BindableEvent2 (copy), scheduleTierBoundary (copy)
    if not u16.IsSubscribed then
        u16.MockSubscribe(p38 >= 20);

        return;
    end;

    local v39;

    if p38 >= 20 then
        v39 = os.time() - 5184000 - 1;
    else
        v39 = os.time();
    end;

    local DiscountPercent = u16.DiscountPercent;
    u16.DiscountPercent = p38;
    u16.SubscribedAt = v39;

    if DiscountPercent ~= p38 then
        BindableEvent2:Fire(p38, DiscountPercent);
    end;

    scheduleTierBoundary();
end;

function u16.SetItemVariant(p40) -- Line: 296
    -- upvalues: u13 (copy), BindableEvent3 (copy)
    u13.ActiveItemVariant = p40;
    BindableEvent3:Fire();
end;

function u16.SetTotalVariant(p41) -- Line: 301
    -- upvalues: u13 (copy), BindableEvent3 (copy)
    u13.ActiveTotalVariant = p41;
    BindableEvent3:Fire();
end;

function u16.SetDiscountColor(p42) -- Line: 306
    -- upvalues: u13 (copy), BindableEvent3 (copy)
    u13.DiscountColor = p42;
    BindableEvent3:Fire();
end;

function u16.GetStatusLines() -- Line: 311
    -- upvalues: u16 (copy), u13 (copy), u14 (ref), u5 (copy)
    local v43 = {};
    table.insert(v43, "=== Roblox Plus State ===");
    local v44 = "IsSubscribed: " .. tostring(u16.IsSubscribed);
    table.insert(v43, v44);
    table.insert(v43, "DiscountPercent: " .. u16.DiscountPercent .. "%");

    if u16.SubscribedAt then
        local v45 = os.time() - u16.SubscribedAt;
        table.insert(v43, "SubscribedAt: " .. u16.SubscribedAt .. " (" .. v45 .. "s ago)");
    else
        table.insert(v43, "SubscribedAt: nil");
    end;

    table.insert(v43, "ActiveItemVariant: " .. u13.ActiveItemVariant);
    table.insert(v43, "ActiveTotalVariant: " .. u13.ActiveTotalVariant);
    table.insert(v43, "ActiveUpsellFrequency: " .. u13.ActiveUpsellFrequency);
    table.insert(v43, "DiscountColor: " .. u13.DiscountColor);

    if u14 > 0 then
        local v46 = workspace:GetServerTimeNow() - u14;
        table.insert(v43, string.format("PersistedDismissedAt: %d (%ds ago, TTL %ds remaining)", u14, v46, u13.DismissTTLSeconds - v46));
    else
        table.insert(v43, "PersistedDismissedAt: 0 (never dismissed or not yet loaded)");
    end;

    table.insert(v43, "--- FeatureFlags ---");

    for _, v in ipairs(u5) do
        local v47 = "  " .. v .. ": " .. tostring(u16.FeatureFlags[v]);
        table.insert(v43, v47);
    end;

    return v43;
end;

function u16.SetUpsellFrequency(p48) -- Line: 340
    -- upvalues: u13 (copy), BindableEvent3 (copy)
    u13.ActiveUpsellFrequency = p48;
    BindableEvent3:Fire();
end;

function u16.SetFeatureFlag(p49, p50) -- Line: 348
    -- upvalues: u16 (copy), BindableEvent3 (copy), u19 (ref)
    if u16.FeatureFlags[p49] == nil then
        return false;
    end;

    u16.FeatureFlags[p49] = p50 == true;
    BindableEvent3:Fire();

    if u19 then
        u19.Enabled = not u16.IsSubscribed and u16.FeatureFlags.upsellBanner and not u16.UpsellDismissed;
    end;

    return true;
end;

local function fuzzyMatch(p51, p52) -- Line: 357
    if not p51 or p51 == "" then
        return nil, "no input";
    end;

    local v53 = string.lower(p51);
    local v54 = {};

    for _, v in ipairs(p52) do
        local v55 = string.lower(v);

        if string.sub(v55, 1, #v53) == v53 then
            table.insert(v54, v);
        end;
    end;

    if #v54 == 1 then
        return v54[1], nil;
    end;

    if #v54 == 0 then
        return nil, "no match";
    end;

    return nil, "ambiguous: " .. table.concat(v54, ", ");
end;

function u16.HandleDevAction(p56, p57, p58) -- Line: 372
    -- upvalues: fuzzyMatch (copy), u4 (copy), u16 (copy), u1 (copy), u2 (copy)
    local v59, v60 = fuzzyMatch(not p56 and "" or string.lower(p56), u4);

    if not v59 then
        return {
            ok = false,
            lines = { "Unknown action \'" .. tostring(p56) .. "\'" .. (not v60 and "" or " (" .. v60 .. ")") .. ".", "Try: " .. table.concat(u4, ", ") }
        };
    end;

    if v59 == "on" then
        if u16.IsSubscribed then
            return {
                ok = true,
                lines = { "Already subscribed at tier " .. u16.DiscountPercent .. "%." }
            };
        end;

        u16.MockSubscribe(false);

        return {
            ok = true,
            lines = { "Subscribed at tier " .. u16.DiscountPercent .. "%." }
        };
    end;

    if v59 == "off" then
        if not u16.IsSubscribed then
            return {
                ok = true,
                lines = { "Not subscribed." }
            };
        end;

        u16.MockUnsubscribe();

        return {
            ok = true,
            lines = { "Unsubscribed." }
        };
    end;

    if v59 == "tier" then
        local v61 = tonumber(p57);

        if v61 ~= 10 and v61 ~= 20 then
            return {
                ok = false,
                lines = { "Invalid tier \'" .. tostring(p57) .. "\'. Use 10 or 20." }
            };
        end;

        u16.SetDiscountPercent(v61);

        return {
            ok = true,
            lines = { "Tier set to " .. v61 .. "%." }
        };
    end;

    if v59 == "variant" or (v59 == "itemvariant" or v59 == "totalvariant") then
        if not p57 or p57 == "" then
            return {
                ok = false,
                lines = { "Missing variant name. Try: " .. table.concat(u1, ", ") }
            };
        end;

        local v62, v63 = fuzzyMatch(p57, u1);

        if not v62 then
            return {
                ok = false,
                lines = { "Unknown variant \'" .. tostring(p57) .. "\'" .. (not v63 and "" or " (" .. v63 .. ")") .. ".", "Try: " .. table.concat(u1, ", ") }
            };
        end;

        if v59 == "variant" then
            u16.SetItemVariant(v62);
            u16.SetTotalVariant(v62);

            return {
                ok = true,
                lines = { "Item+Total variant set to \'" .. v62 .. "\'." }
            };
        end;

        if v59 == "itemvariant" then
            u16.SetItemVariant(v62);

            return {
                ok = true,
                lines = { "Item variant set to \'" .. v62 .. "\'." }
            };
        end;

        u16.SetTotalVariant(v62);

        return {
            ok = true,
            lines = { "Total variant set to \'" .. v62 .. "\'." }
        };
    end;

    if v59 == "color" then
        if not (p57 and string.match(p57, "^#%x%x%x%x%x%x$")) then
            return {
                ok = false,
                lines = { "Invalid color \'" .. tostring(p57) .. "\'. Use format #RRGGBB (e.g. #00D886)." }
            };
        end;

        u16.SetDiscountColor(p57);

        return {
            ok = true,
            lines = { "Discount color set to " .. p57 .. "." }
        };
    end;

    if v59 ~= "upsell" then
        return v59 == "status" and {
            ok = true,
            lines = u16.GetStatusLines()
        } or {
            ok = false,
            lines = { "Dispatch fell through for action \'" .. v59 .. "\'." }
        };
    end;

    if not p57 or p57 == "" then
        return {
            ok = false,
            lines = { "Missing upsell frequency. Try: " .. table.concat(u2, ", ") }
        };
    end;

    local v64, v65 = fuzzyMatch(p57, u2);

    if not v64 then
        return {
            ok = false,
            lines = { "Unknown upsell frequency \'" .. tostring(p57) .. "\'" .. (not v65 and "" or " (" .. v65 .. ")") .. ".", "Try: " .. table.concat(u2, ", ") }
        };
    end;

    u16.SetUpsellFrequency(v64);

    return {
        ok = true,
        lines = { "Upsell frequency set to \'" .. v64 .. "\'." }
    };
end;

task.spawn(function() -- Line: 465
    -- upvalues: u16 (copy)
    local DevPlusAction = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DevPlusAction", 30);

    if DevPlusAction then
        DevPlusAction.OnClientInvoke = u16.HandleDevAction;

        return;
    end;

    warn("[RobloxPlusController] DevPlusAction remote not found; /plus command disabled");
end);
task.spawn(function() -- Line: 480
    -- upvalues: u14 (ref)
    local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 30);

    if not Remotes then
        return;
    end;

    local GetStatistics = Remotes:WaitForChild("GetStatistics", 30);

    if not GetStatistics then
        return;
    end;

    local success, result = pcall(function() -- Line: 486
        -- upvalues: GetStatistics (copy)
        return GetStatistics:InvokeServer();
    end);

    if success and (typeof(result) == "table" and typeof(result.RobloxPlusUpsellDismissedAt) == "number") then
        u14 = result.RobloxPlusUpsellDismissedAt;
    end;
end);
task.spawn(function() -- Line: 496
    -- upvalues: u16 (copy), BindableEvent3 (copy), u19 (ref), u17 (ref), u13 (copy)
    local ConfigsController = require(script.Parent:WaitForChild("ConfigsController"));

    local function syncFlags() -- Line: 498
        -- upvalues: u16 (ref), ConfigsController (copy), BindableEvent3 (ref), u19 (ref), u17 (ref), u13 (ref)
        local FeatureFlags = u16.FeatureFlags;
        local v66 = {
            priceVariants = ConfigsController.GetValue("plus_price_variants_enabled", false) == true,
            upsellButtons = ConfigsController.GetValue("plus_upsell_buttons_enabled", false) == true,
            upsellModal = ConfigsController.GetValue("plus_upsell_modal_enabled", false) == true,
            upsellBanner = ConfigsController.GetValue("plus_upsell_banner_enabled", false) == true
        };

        if FeatureFlags.priceVariants ~= v66.priceVariants or (FeatureFlags.upsellButtons ~= v66.upsellButtons or (FeatureFlags.upsellModal ~= v66.upsellModal or FeatureFlags.upsellBanner ~= v66.upsellBanner)) then
            u16.FeatureFlags = v66;
            BindableEvent3:Fire();

            if u19 then
                u19.Enabled = not u16.IsSubscribed and u16.FeatureFlags.upsellBanner and not u16.UpsellDismissed;
            end;
        end;

        if u17 then
            return;
        end;

        if not u16.FeatureFlags.upsellModal then
            return;
        end;

        u17 = true;
        task.spawn(function() -- Line: 130
            -- upvalues: u13 (ref)
            local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 30);

            if not Remotes then
                return;
            end;

            local AnalyticsEvent = Remotes:WaitForChild("AnalyticsEvent", 30);

            if not AnalyticsEvent then
                return;
            end;

            pcall(AnalyticsEvent.FireServer, AnalyticsEvent, "UpsellAssigned", {
                variant = u13.ActiveUpsellFrequency
            });
        end);
    end;

    ConfigsController.OnUpdated:Connect(syncFlags);
    syncFlags();
end);
LocalPlayer:GetPropertyChangedSignal("HasRobloxSubscription"):Connect(function() -- Line: 522
    -- upvalues: LocalPlayer (copy), applySubscribedState (copy), MarketplaceService (copy), u16 (copy), u18 (ref), BindableEvent2 (copy), u19 (ref)
    if LocalPlayer.HasRobloxSubscription then
        task.spawn(function() -- Line: 525
            -- upvalues: applySubscribedState (ref), MarketplaceService (ref), LocalPlayer (ref)
            local success, result = pcall(function() -- Line: 199
                -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
                return MarketplaceService:GetRobloxSubscriptionDetailsAsync(LocalPlayer);
            end);
            local v67;

            if success and (result and (result.IsSubscribed and (result.StartTime and result.StartTime.UnixTimestamp))) then
                v67 = result.StartTime.UnixTimestamp;
            else
                v67 = nil;
            end;

            applySubscribedState(v67, true);
        end);

        return;
    end;

    u16.IsSubscribed = false;

    if u18 then
        pcall(task.cancel, u18);
        u18 = nil;
    end;

    local DiscountPercent = u16.DiscountPercent;
    u16.DiscountPercent = 0;
    u16.SubscribedAt = nil;

    if DiscountPercent ~= 0 then
        BindableEvent2:Fire(0, DiscountPercent);
    end;

    if not u19 then
        return;
    end;

    u19.Enabled = not u16.IsSubscribed and u16.FeatureFlags.upsellBanner and not u16.UpsellDismissed;
end);
task.spawn(function() -- Line: 534
    -- upvalues: LocalPlayer (copy), u19 (ref), u20 (ref), u16 (copy), TweenService (copy), MarketplaceService (copy), BindableEvent (copy), BindableEvent2 (copy), scheduleTierBoundary (copy)
    local RobloxPlusUpsell = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RobloxPlusUpsell");
    local container = RobloxPlusUpsell:WaitForChild("container");
    local button = container:WaitForChild("upsell"):WaitForChild("button");
    local close = container:WaitForChild("close");
    local Events = script.Parent.Parent:WaitForChild("Events");
    local u68 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    u19 = RobloxPlusUpsell;
    u20 = Events.Notify;
    button.Activated:Connect(function() -- Line: 559
        -- upvalues: u16 (ref)
        u16.TriggerSubscribe();
    end);
    close.Activated:Connect(function() -- Line: 563
        -- upvalues: u16 (ref), u19 (ref)
        u16.UpsellDismissed = true;

        if not u19 then
            return;
        end;

        u19.Enabled = not u16.IsSubscribed and u16.FeatureFlags.upsellBanner and not u16.UpsellDismissed;
    end);
    close.MouseEnter:Connect(function() -- Line: 568
        -- upvalues: TweenService (ref), close (copy), u68 (copy)
        TweenService:Create(close, u68, {
            ImageTransparency = 0
        }):Play();
    end);
    close.MouseLeave:Connect(function() -- Line: 572
        -- upvalues: TweenService (ref), close (copy), u68 (copy)
        TweenService:Create(close, u68, {
            ImageTransparency = 0.3
        }):Play();
    end);

    if u16.IsSubscribed and u16.DiscountPercent == 0 then
        local success, result = pcall(function() -- Line: 199
            -- upvalues: MarketplaceService (ref), LocalPlayer (ref)
            return MarketplaceService:GetRobloxSubscriptionDetailsAsync(LocalPlayer);
        end);
        local v69;

        if success and (result and (result.IsSubscribed and (result.StartTime and result.StartTime.UnixTimestamp))) then
            v69 = result.StartTime.UnixTimestamp;
        else
            v69 = nil;
        end;

        local IsSubscribed = u16.IsSubscribed;
        u16.IsSubscribed = true;

        if not IsSubscribed then
            BindableEvent:Fire();
        end;

        local v70 = v69 and (os.time() - v69 > 5184000 and 20 or 10) or 10;
        local v71 = v69 or os.time();
        local DiscountPercent = u16.DiscountPercent;
        u16.DiscountPercent = v70;
        u16.SubscribedAt = v71;

        if DiscountPercent ~= v70 then
            BindableEvent2:Fire(v70, DiscountPercent);
        end;

        scheduleTierBoundary();

        if u19 then
            u19.Enabled = not u16.IsSubscribed and u16.FeatureFlags.upsellBanner and not u16.UpsellDismissed;
        end;
    end;

    if not u19 then
        return;
    end;

    u19.Enabled = not u16.IsSubscribed and u16.FeatureFlags.upsellBanner and not u16.UpsellDismissed;
end);

return u16;