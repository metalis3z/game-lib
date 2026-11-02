-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
require(ReplicatedStorage.Modules.CurrencyLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local LootLibrary = require(ReplicatedStorage.Modules.LootLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers.MonetizationController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local BigShopSlot = require(Players.LocalPlayer.PlayerScripts.Modules.BaseShopSlot.BigShopSlot);
local ShopController = require(Players.LocalPlayer.PlayerScripts.Controllers.ShopController);
local ShopSlot = require(Players.LocalPlayer.PlayerScripts.Modules.BaseShopSlot.ShopSlot);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local LoginRewards = require(script:WaitForChild("LoginRewards"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 20
    -- upvalues: u1 (copy), LoginRewards (copy)
    local v3 = setmetatable({}, u1);
    v3.Pages = p2;
    v3.Frame = v3.Pages.Frame:WaitForChild("Daily");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.CountdownFrame = v3.Container:WaitForChild("Countdown");
    v3.CountdownTimer = v3.CountdownFrame:WaitForChild("Timer");
    v3.CountdownRefreshButton = v3.CountdownFrame:WaitForChild("Refresh");
    v3.CountdownRefreshPrice = v3.CountdownRefreshButton:WaitForChild("Price");
    v3.CountdownRefreshPriceIcon = v3.CountdownRefreshPrice:WaitForChild("Icon");
    v3.SkinsFrame = v3.Container:WaitForChild("Skins");
    v3.SkinsContainer = v3.SkinsFrame:WaitForChild("Container");
    v3.SkinsLayout = v3.SkinsContainer:WaitForChild("Layout");
    v3.FinishersFrame = v3.Container:WaitForChild("Finishers");
    v3.FinishersContainer = v3.FinishersFrame:WaitForChild("Container");
    v3.FinishersHeaderIcon = v3.FinishersContainer:WaitForChild("Header"):WaitForChild("Icon");
    v3.FinishersSlotsFrame = v3.FinishersContainer:WaitForChild("Slots");
    v3.FinishersSlotsLayout = v3.FinishersSlotsFrame:WaitForChild("Layout");
    v3.WrapsFrame = v3.Container:WaitForChild("Wraps");
    v3.WrapsContainer = v3.WrapsFrame:WaitForChild("Container");
    v3.WrapsHeaderIcon = v3.WrapsContainer:WaitForChild("Header"):WaitForChild("Icon");
    v3.WrapsSlotsFrame = v3.WrapsContainer:WaitForChild("Slots");
    v3.WrapsSlotsLayout = v3.WrapsSlotsFrame:WaitForChild("Layout");
    v3.CharmsFrame = v3.Container:WaitForChild("Charms");
    v3.CharmsContainer = v3.CharmsFrame:WaitForChild("Container");
    v3.CharmsHeaderIcon = v3.CharmsContainer:WaitForChild("Header"):WaitForChild("Icon");
    v3.CharmsSlotsFrame = v3.CharmsContainer:WaitForChild("Slots");
    v3.CharmsSlotsLayout = v3.CharmsSlotsFrame:WaitForChild("Layout");
    v3.LoginRewards = LoginRewards.new(v3);
    v3._is_open_hash = 0;
    v3._shop_slots = {};
    v3:_Init();

    return v3;
end;

function u1.Generate(p4) -- Line: 65
    -- upvalues: PlayerDataController (copy), EventLibrary (copy), ShopController (copy), CosmeticLibrary (copy), BigShopSlot (copy), ShopSlot (copy)
    for _, v in pairs(p4._shop_slots) do
        v:Destroy();
    end;

    p4._shop_slots = {};

    if not p4.Pages.Shop:IsOpen() then
        return;
    end;

    local v5 = PlayerDataController:GetStatistic("StatisticDuelsPlayed") >= EventLibrary.NUM_GAMES_NEEDED_TO_PARTICIPATE;
    PlayerDataController:Get("CosmeticInventory");

    for i, v in pairs(ShopController:GetDailyShop()) do
        if not v.Prices.EventCurrency or v5 then
            local v6 = CosmeticLibrary.Cosmetics[v.Rewards[1].Name];
            local v7 = v6.Type == "Finisher" and p4.FinishersSlotsFrame or v6.Type == "Wrap" and p4.WrapsSlotsFrame or (v6.Type == "Charm" and p4.CharmsSlotsFrame or p4.SkinsContainer);
            local v8;

            if v6.Type == "Skin" or v6.Type == "Emote" then
                v8 = BigShopSlot;
            else
                v8 = ShopSlot;
            end;

            local v9 = p4.Pages.Shop:CreateShopSlot(v8, nil, v.EntryName);
            v9.Frame.LayoutOrder = i;
            v9.Frame.ZIndex = i;
            v9.Frame.Parent = v7;
            table.insert(p4._shop_slots, v9);

            if v6.Type == "Emote" and v6.EmoteDescription then
                v9:SetDescription(v6.EmoteDescription);
            end;
        end;
    end;
end;

function u1.Open(p10) -- Line: 105
    p10._is_open_hash = p10._is_open_hash + 1;
    task.spawn(p10._CountdownLoop, p10);
    p10:Generate();
    p10:_UpdateFrame();
    p10:_UpdateSizes();
    p10.LoginRewards:Open();
end;

function u1.Close(p11) -- Line: 114
    p11._is_open_hash = p11._is_open_hash + 1;
    p11:Generate();
    p11.LoginRewards:Close();
end;

function u1.Setup(p12) -- Line: 120
    p12:Generate();
    p12.LoginRewards:Setup();
end;

function u1._CountdownLoop(p13) -- Line: 129
    -- upvalues: Utility (copy), ShopController (copy)
    p13._is_open_hash = p13._is_open_hash + 1;

    while p13._is_open_hash == p13._is_open_hash do
        p13.CountdownTimer.Text = "<font transparency=\"0.5\" size=\"9\">shop will refresh in</font> " .. Utility:TimeFormat2(ShopController:GetDailyShopRefreshTimeRemaining());
        wait(1);
    end;
end;

function u1._UpdateRefreshText(p14) -- Line: 139
    -- upvalues: LootLibrary (copy), PlayerDataController (copy)
    p14.CountdownRefreshPrice.Text = LootLibrary:GetCostToRefreshDailyShop(PlayerDataController:Get("DailyShopRefreshesToday"));
end;

function u1._UpdateSizes(p15) -- Line: 143
    p15.SkinsFrame.Size = UDim2.new(1, 0, 0, p15.SkinsLayout.AbsoluteContentSize.Y + p15.SkinsFrame.AbsoluteSize.X * 440 / 1173 * 0.05);
    p15.FinishersFrame.Size = UDim2.new(1, 0, 0, p15.FinishersSlotsLayout.AbsoluteContentSize.Y + p15.FinishersSlotsFrame.AbsolutePosition.Y - p15.FinishersContainer.AbsolutePosition.Y + 0.05 * p15.FinishersContainer.AbsoluteSize.Y);
    p15.WrapsFrame.Size = UDim2.new(1, 0, 0, p15.WrapsSlotsLayout.AbsoluteContentSize.Y + p15.WrapsSlotsFrame.AbsolutePosition.Y - p15.WrapsContainer.AbsolutePosition.Y + 0.05 * p15.WrapsContainer.AbsoluteSize.Y);
    p15.CharmsFrame.Size = UDim2.new(1, 0, 0, p15.CharmsSlotsLayout.AbsoluteContentSize.Y + p15.CharmsSlotsFrame.AbsolutePosition.Y - p15.CharmsContainer.AbsolutePosition.Y + 0.05 * p15.CharmsContainer.AbsoluteSize.Y);
end;

function u1._UpdateFrame(p16) -- Line: 150
    p16.Frame.Size = UDim2.new(1, 0, 0, p16.Layout.AbsoluteContentSize.Y);
end;

function u1._Setup(p17) -- Line: 154
    -- upvalues: CosmeticLibrary (copy)
    p17.FinishersHeaderIcon = CosmeticLibrary.Types.Finisher.Image;
    p17.WrapsHeaderIcon = CosmeticLibrary.Types.Wrap.Image;
    p17.CharmsHeaderIcon = CosmeticLibrary.Types.Charm.Image;
end;

function u1._Init(u18) -- Line: 160
    -- upvalues: LootLibrary (copy), PlayerDataController (copy), MonetizationController (copy), ShopController (copy), Utility (copy), ButtonEffect (copy)
    u18.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 161
        -- upvalues: u18 (copy)
        u18:_UpdateFrame();
    end);
    u18.SkinsFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 165
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.SkinsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 169
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.FinishersSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 173
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.FinishersSlotsFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 177
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.FinishersContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 181
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.FinishersContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 185
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.WrapsSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 189
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.WrapsSlotsFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 193
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.WrapsContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 197
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.WrapsContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 201
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.CharmsSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 205
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.CharmsSlotsFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 209
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.CharmsContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 213
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.CharmsContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 217
        -- upvalues: u18 (copy)
        u18:_UpdateSizes();
    end);
    u18.CountdownRefreshPriceIcon:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 221
        -- upvalues: u18 (copy)
        u18.CountdownRefreshPrice.Position = UDim2.new(0.5, -u18.CountdownRefreshPriceIcon.AbsoluteSize.X / 2, 0.5, 0);
        u18.CountdownRefreshPriceIcon.Position = UDim2.new(0.5, u18.CountdownRefreshPrice.TextBounds.X / 2, 0.5, 0);
    end);
    u18.CountdownRefreshButton.MouseButton1Click:Connect(function() -- Line: 226
        -- upvalues: LootLibrary (ref), PlayerDataController (ref), u18 (copy), MonetizationController (ref), ShopController (ref), Utility (ref)
        local CostToRefreshDailyShop = LootLibrary:GetCostToRefreshDailyShop(PlayerDataController:Get("DailyShopRefreshesToday"));

        if PlayerDataController:Get("WeaponKeys") < CostToRefreshDailyShop then
            u18.Pages.Shop:SetPage("Currency");
            MonetizationController:PromptCurrencyBundlePurchase(CostToRefreshDailyShop, "WeaponKeys");

            return;
        end;

        ShopController:BuyDailyShopRefresh();
        Utility:CreateSound("rbxassetid://18100002432", 1.25, 1, script, true, 5);
    end);
    PlayerDataController:GetDataChangedSignal("DailyShopRefreshesToday"):Connect(function() -- Line: 239
        -- upvalues: u18 (copy)
        u18:_UpdateRefreshText();
    end);
    PlayerDataController:GetDataChangedSignal("CosmeticInventory"):Connect(function() -- Line: 243
        -- upvalues: u18 (copy)
        u18:Generate();
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 247
        -- upvalues: u18 (copy)
        u18:Generate();
    end);
    ShopController.DailyShopRefreshed:Connect(function() -- Line: 251
        -- upvalues: u18 (copy)
        u18:Generate();
    end);
    u18:_Setup();
    u18:_UpdateFrame();
    u18:_UpdateSizes();
    u18:_UpdateRefreshText();
    ButtonEffect:Add(u18.CountdownRefreshButton);
end;

return u1;