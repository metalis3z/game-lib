-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.PurchaseStarted = Signal.new();
    v2.PurchaseFinished = Signal.new();
    v2._fetch_robux_price_hashes = {};
    v2:_Init();

    return v2;
end;

function u1.PromptBulkPurchase(p3, p4) -- Line: 30
    -- upvalues: ReplicatedStorage (copy)
    local v5 = typeof(p4) == "table";
    local v6 = "Argument 1 invalid, expected a table, got " .. tostring(p4);
    assert(v5, v6);
    ReplicatedStorage.Remotes.Misc.PromptBulkPurchase:FireServer(p4);
    p3:_StartPrompt();
end;

function u1.PromptPurchase(p7, p8) -- Line: 37
    -- upvalues: MarketplaceService (copy), Players (copy)
    local v9 = typeof(p8) == "number";
    local v10 = "Argument 1 invalid, expected a number, got " .. tostring(p8);
    assert(v9, v10);
    MarketplaceService:PromptPurchase(Players.LocalPlayer, p8);
    p7:_StartPrompt();
end;

-- Robux products and gamepasses are free in this place: the server grants them straight away
-- (Remotes.Misc.FreePurchase) and answers with FinishPurchasePrompt.
function u1.PromptProductPurchase(p11, p12) -- Line: 45
    -- upvalues: ReplicatedStorage (copy)
    local v13 = typeof(p12) == "number";
    local v14 = "Argument 1 invalid, expected a number, got " .. tostring(p12);
    assert(v13, v14);
    p11:_StartPrompt();
    ReplicatedStorage.Remotes.Misc.FreePurchase:FireServer("Product", p12);
end;

function u1.PromptGamePassPurchase(p15, p16) -- Line: 53
    -- upvalues: PlayerDataController (copy), MonetizationLibrary (copy), MarketplaceService (copy), Players (copy)
    local v17 = typeof(p16) == "number";
    local v18 = "Argument 1 invalid, expected a number, got " .. tostring(p16);
    assert(v17, v18);

    if PlayerDataController:HasGamepass(MonetizationLibrary:GetGamepassName(p16)) then
        return;
    end;

    p15:_StartPrompt();
    ReplicatedStorage.Remotes.Misc.FreePurchase:FireServer("Gamepass", p16);
end;

function u1.PromptSubscriptionPurchase(p19, p20) -- Line: 65
    -- upvalues: MarketplaceService (copy), Players (copy)
    local v21 = typeof(p20) == "string";
    local v22 = "Argument 1 invalid, expected a string, got " .. tostring(p20);
    assert(v21, v22);
    MarketplaceService:PromptSubscriptionPurchase(Players.LocalPlayer, p20);
    p19:_StartPrompt();
end;

function u1.PromptCurrencyBundlePurchase(p23, p24, p25) -- Line: 72
    -- upvalues: PlayerDataController (copy), MonetizationLibrary (copy)
    local v26 = p24 - PlayerDataController:Get(p25);

    if v26 <= 0 then
        return;
    end;

    local v27 = p25 == "WeaponKeys" and MonetizationLibrary.NUM_KEY_BUNDLES or (p25 == "EventCurrency" and MonetizationLibrary.NUM_EVENT_CURRENCY_BUNDLES or nil);
    local v28 = p25 == "WeaponKeys" and "keybundle_" or (p25 == "EventCurrency" and "eventcurrencybundle_" or nil);

    if not (v27 and v28) then
        return;
    end;

    for i = 1, v27 do
        local v29 = MonetizationLibrary.Bundles[v28 .. i];

        if v26 <= v29.Rewards[1].Quantity then
            p23:PromptProductPurchase(v29.ProductID);

            return true;
        end;

        local _ = i;
    end;
end;

function u1.FetchRobuxPrice(p30, p31, p32) -- Line: 96
    -- upvalues: MarketplaceService (copy)
    local success, success = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, p31, p32 or Enum.InfoType.Product);

    if not success then
        warn("Failed to fetch robux price:", success);
    end;

    if success then
        if success then
            success = success.PriceInRobux;
        end;
    end;

    return success;
end;

function u1.SetRobuxText(u33, u34, ...) -- Line: 106
    u33._fetch_robux_price_hashes[u34] = (u33._fetch_robux_price_hashes[u34] or 0) + 1;
    local u35 = u33._fetch_robux_price_hashes[u34];
    task.spawn(function(...) -- Line: 110
        -- upvalues: u34 (copy), u33 (copy), u35 (copy)
        u34.Text = "• • •";
        u34.Text = u33:_GetRobuxText(u35, u34, ...) or u34.Text;
    end, ...);
end;

function u1.SetRobuxTextWithFormat(u36, u37, u38, ...) -- Line: 116
    u36._fetch_robux_price_hashes[u38] = (u36._fetch_robux_price_hashes[u38] or 0) + 1;
    local u39 = u36._fetch_robux_price_hashes[u38];
    task.spawn(function(...) -- Line: 120
        -- upvalues: u38 (copy), u36 (copy), u39 (copy), u37 (copy)
        u38.Text = "• • •";
        local v40 = u36:_GetRobuxText(u39, u38, ...);

        if not v40 then
            return;
        end;

        u38.Text = string.format(u37, v40);
    end, ...);
end;

function u1.VerifyUGC(p41, p42) -- Line: 133
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Data.VerifyUGC:FireServer(p42);
end;

function u1._GetRobuxText(p43, p44, p45, ...) -- Line: 141
    -- upvalues: Utility (copy)
    if p44 == p43._fetch_robux_price_hashes[p45] then
        return "FREE";
    end;

    local v46 = { ... };
    local v47 = 0;

    for i = 1, #v46, 2 do
        local v48 = p43:FetchRobuxPrice(v46[i], v46[i + 1]);

        if p44 ~= p43._fetch_robux_price_hashes[p45] or not v48 then
            return;
        end;

        v47 = v47 + v48;
        local _ = i;
    end;

    return utf8.char(57346) .. " " .. Utility:PrettyNumber(v47);
end;

function u1._StartPrompt(p49) -- Line: 160
    p49.PurchaseStarted:Fire();
end;

function u1._FinishPrompt(p50, p51) -- Line: 164
    p50.PurchaseFinished:Fire(p51);
end;

function u1._Init(u52) -- Line: 168
    -- upvalues: MarketplaceService (copy), MonetizationLibrary (copy), ReplicatedStorage (copy)
    MarketplaceService.PromptBulkPurchaseFinished:Connect(function(p53, p54, p55) -- Line: 169
        -- upvalues: u52 (copy), MonetizationLibrary (ref)
        local v56 = false;

        for _, v in pairs(p55.Items) do
            if v.status == Enum.MarketplaceItemPurchaseStatus.Success then
                v56 = true;
                break;
            end;
        end;

        u52:_FinishPrompt(v56);

        if v56 then
            local v57 = {};

            for _, v in pairs(p55.Items) do
                local v58 = MonetizationLibrary.UGCAssetIDToName[tostring(v.id)];

                if v58 then
                    table.insert(v57, v58);
                end;
            end;

            if #v57 > 0 then
                u52:VerifyUGC(v57);
            end;
        end;
    end);
    ReplicatedStorage.Remotes.Misc.StartPurchasePrompt.OnClientEvent:Connect(function() -- Line: 198
        -- upvalues: u52 (copy)
        u52:_StartPrompt();
    end);
    ReplicatedStorage.Remotes.Misc.FinishPurchasePrompt.OnClientEvent:Connect(function(p59) -- Line: 202
        -- upvalues: u52 (copy)
        u52:_FinishPrompt(p59);
    end);
end;

return u1._new();