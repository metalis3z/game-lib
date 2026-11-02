-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
require(Players.LocalPlayer.PlayerScripts.Controllers.MonetizationController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 12
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.DailyShopRefreshed = Signal.new();
    v2.DailyShop = {};
    v2.DailyShopDay = nil;
    v2._fetched_daily_shop = false;
    v2._refresh_time = 0;
    v2:_Init();

    return v2;
end;

function u1.GetDailyShopRefreshTimeRemaining(p3) -- Line: 32
    local v4 = p3._refresh_time - tick();
    local math_ceil_ret = math.ceil(v4);

    return math.max(0, math_ceil_ret);
end;

function u1.GetDailyShop(p5) -- Line: 36
    if not p5._fetched_daily_shop then
        task.defer(p5._FetchDailyShop, p5);
    end;

    return p5.DailyShop;
end;

function u1.GetShopEntry(p6, p7) -- Line: 44
    -- upvalues: ShopLibrary (copy)
    if ShopLibrary.Entries[p7] then
        return ShopLibrary.Entries[p7];
    end;

    for _, v in pairs(p6:GetDailyShop()) do
        if v.EntryName == p7 then
            return v;
        end;
    end;
end;

function u1.UpdateDailyShop(p8, p9) -- Line: 56
    p8.DailyShop = p9 or {};
    p8.DailyShopRefreshed:Fire();
end;

function u1.UpdateDailyShopCountdown(p10, p11) -- Line: 61
    p10._refresh_time = tick() + (p11 or 0);
end;

function u1.PurchaseShopEntry(p12, p13, p14, p15) -- Line: 65
    -- upvalues: ReplicatedStorage (copy)
    local ShopEntry = p12:GetShopEntry(p13);
    assert(ShopEntry ~= nil);

    if p14 then
        ReplicatedStorage.Remotes.Data.BuyShopEntry:FireServer(ShopEntry.EntryName, p14, 1, p12:_GetIntendedDailyShopDay());

        return;
    end;

    if p15 and ShopEntry.ProductIDTriple then
        ReplicatedStorage.Remotes.Data.BuyShopEntryRobux:FireServer(ShopEntry.EntryName, true, p12:_GetIntendedDailyShopDay());

        return;
    end;

    if ShopEntry.ProductID then
        ReplicatedStorage.Remotes.Data.BuyShopEntryRobux:FireServer(ShopEntry.EntryName, false, p12:_GetIntendedDailyShopDay());
    end;
end;

function u1.BuyDailyShopRefresh(p16) -- Line: 79
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Data.RefreshDailyShop:FireServer(p16:_GetIntendedDailyShopDay());
end;

function u1._GetIntendedDailyShopDay(p17) -- Line: 87
    -- upvalues: PlayerDataController (copy)
    if p17.DailyShopDay then
        return p17.DailyShopDay + PlayerDataController:Get("DailyShopSeedShift");
    end;

    warn("self.DailyShopDay is nil");
    task.spawn(p17._FetchDailyShop, p17);

    return -1;
end;

function u1._UpdateDailyShop(p18, p19) -- Line: 97
    local v20 = p19 or {};
    p18.DailyShopDay = v20.Day;
    p18:UpdateDailyShopCountdown(v20.TimeRemaining);
    p18:UpdateDailyShop(v20.Data);
end;

function u1._FetchDailyShop(p21) -- Line: 105
    -- upvalues: ReplicatedStorage (copy)
    if p21._fetched_daily_shop then
        return;
    end;

    p21._fetched_daily_shop = true;
    local v22, v23;

    repeat
        v22, v23 = pcall(ReplicatedStorage.Remotes.Data.RequestDailyShop.InvokeServer, ReplicatedStorage.Remotes.Data.RequestDailyShop);
    until v22;

    p21:_UpdateDailyShop(v23);
end;

function u1._Init(u24) -- Line: 122
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Data.UpdateDailyShop.OnClientEvent:Connect(function(...) -- Line: 123
        -- upvalues: u24 (copy)
        u24:_UpdateDailyShop(...);
    end);
end;

return u1._new();