-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
require(ReplicatedStorage.Modules.SeasonLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local SeasonController = require(Players.LocalPlayer.PlayerScripts.Controllers.SeasonController);
local ShopController = require(Players.LocalPlayer.PlayerScripts.Controllers.ShopController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local UDim2_new_ret = UDim2.new(0.125, 0, 0.875, 0);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 19
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Shop = p2;
    v3.Frame = v3.Shop.Container:WaitForChild("Tabs");
    v3.CloseButton = v3.Frame:WaitForChild("Close");
    v3.RankedButton = v3.Frame:WaitForChild("Ranked");
    v3.CurrencyButton = v3.Frame:WaitForChild("Currency");
    v3.CurrencyIcon = v3.CurrencyButton:WaitForChild("Icon");
    v3.CurrencyEventIcon = v3.CurrencyButton:WaitForChild("EventIcon");
    v3.WeaponsButton = v3.Frame:WaitForChild("Weapons");
    v3.GiftingButton = v3.Frame:WaitForChild("Gifting");
    v3.RewardsButton = v3.Frame:WaitForChild("Rewards");
    v3.MoreButton = v3.Frame:WaitForChild("More");
    v3.LessButton = v3.Frame:WaitForChild("Less");
    v3._buttons = {};
    v3._more_buttons_visible = false;
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 47
    p4:_CloseMoreTabs();
end;

function u1.Close(p5) -- Line: 51
    p5:_CloseMoreTabs();
end;

function u1.Setup(p6) -- Line: 55
    p6:_CloseMoreTabs();
end;

function u1._OpenMoreTabs(p7) -- Line: 63
    -- upvalues: UDim2_new_ret (copy)
    p7._more_buttons_visible = true;

    for _, v in pairs(p7._buttons) do
        v.Visible = false;
    end;

    p7.MoreButton.Visible = false;
    p7.LessButton.Visible = true;

    for _, v in pairs({
        p7.RankedButton,
        p7.WeaponsButton,
        p7.GiftingButton,
        p7.RewardsButton
    }) do
        v.Size = UDim2.new(UDim2_new_ret.X.Scale * 0.5, 0, UDim2_new_ret.Y.Scale * 0.5, 0);
        v:TweenSize(UDim2_new_ret, "Out", "Quint", 0.25, true);
        v.Visible = true;
    end;

    p7:_UpdateVisibility();
end;

function u1._CloseMoreTabs(p8) -- Line: 82
    -- upvalues: UDim2_new_ret (copy)
    p8._more_buttons_visible = false;

    for _, v in pairs(p8._buttons) do
        v.Size = UDim2.new(UDim2_new_ret.X.Scale * 0.5, 0, UDim2_new_ret.Y.Scale * 0.5, 0);
        v:TweenSize(UDim2_new_ret, "Out", "Quint", 0.25, true);
        v.Visible = true;
    end;

    p8.MoreButton.Visible = true;
    p8.LessButton.Visible = false;
    p8.WeaponsButton.Visible = false;
    p8.GiftingButton.Visible = false;
    p8.RewardsButton.Visible = false;
    p8.RankedButton.Visible = false;
    p8:_UpdateVisibility();
end;

function u1._UpdateEvent(p9) -- Line: 101
    -- upvalues: EventLibrary (copy), PlayerDataController (copy)
    local v10 = EventLibrary.IS_ACTIVE and PlayerDataController:GetStatistic("StatisticDuelsPlayed") >= EventLibrary.NUM_GAMES_NEEDED_TO_PARTICIPATE;
    p9.CurrencyEventIcon.Visible = v10;
    p9.CurrencyEventIcon.Image = EventLibrary.EVENT_DETAILS.CURRENCY_IMAGE;
    p9.CurrencyIcon.Position = v10 and UDim2.new(0.4, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.5, 0);
end;

function u1._UpdateVisibility(p11) -- Line: 109
    -- upvalues: SeasonController (copy), PlayerDataController (copy)
    local RankedButton = p11.RankedButton;
    local v12 = p11._more_buttons_visible and (SeasonController:IsRankedUnlocked() or PlayerDataController:Get("Glory") > 0);
    RankedButton.Visible = v12;
    local WeaponsButton = p11.WeaponsButton;
    local v13 = p11._more_buttons_visible and (p11.LocalFighter and not p11.LocalFighter:Get("IsInShootingRange")) and not p11.LocalFighter:Get("IsInDuel");
    WeaponsButton.Visible = v13;
end;

function u1._Update(p14) -- Line: 114
    -- upvalues: PlayerDataController (copy), ShopController (copy), ReplicatedStorage (copy)
    for _, v in pairs(p14.Shop.PAGE_NAMES) do
        local v15 = v == p14.Shop.CurrentPage;
        local v16 = p14.Frame:WaitForChild(v);
        local Background = v16:WaitForChild("Background");
        local Title = v16:WaitForChild("Title");
        local UIStroke = Title:WaitForChild("UIStroke");
        Title.TextColor3 = v15 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
        UIStroke.Color = v15 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
        UIStroke.Transparency = v15 and 0 or 0.75;
        Background.ImageColor3 = v15 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
        Background.ImageTransparency = v15 and 0 or 0.25;
        Background:WaitForChild("UIGradient").Enabled = not v15;
    end;

    if p14.Shop.CurrentPage == "Daily" and PlayerDataController:Get("LastDailyShopSeen") ~= ShopController.DailyShopDay then
        ReplicatedStorage.Remotes.Misc.ViewedDailyShop:FireServer();
    end;
end;

function u1._HookLocalFighter(u17) -- Line: 135
    -- upvalues: FighterController (copy)
    u17.LocalFighter = FighterController:WaitForLocalFighter();
    u17.LocalFighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 138
        -- upvalues: u17 (copy)
        u17:_UpdateVisibility();
    end);
    u17.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 142
        -- upvalues: u17 (copy)
        u17:_UpdateVisibility();
    end);
    u17:_UpdateVisibility();
end;

function u1._Setup(u18) -- Line: 149
    -- upvalues: ButtonEffect (copy), PlayerDataController (copy)
    for _, v in pairs(u18.Shop.PAGE_NAMES) do
        local u19 = u18.Frame:WaitForChild(v);
        u18._buttons[v] = u19;
        u19.MouseButton1Click:Connect(function() -- Line: 154
            -- upvalues: u18 (copy), v (copy)
            u18.Shop:SetPage(v);
        end);
        ButtonEffect:Add(u19);

        if v == "Daily" then
            local function update() -- Line: 161
                -- upvalues: u19 (copy), u18 (copy), v (copy), PlayerDataController (ref)
                local NotificationBubble = u19.NotificationBubble;
                local v20;

                if u18.Shop.CurrentPage == v then
                    v20 = false;
                else
                    v20 = not PlayerDataController:Get("ClaimedLoginRewardToday");
                end;

                NotificationBubble.Visible = v20;
            end;

            PlayerDataController:GetDataChangedSignal("ClaimedLoginRewardToday"):Connect(update);
            u18.Shop.CurrentPageChanged:Connect(update);
            local NotificationBubble = u19.NotificationBubble;
            local v21;

            if u18.Shop.CurrentPage == v then
                v21 = false;
            else
                v21 = not PlayerDataController:Get("ClaimedLoginRewardToday");
            end;

            NotificationBubble.Visible = v21;
        end;
    end;
end;

function u1._Init(u22) -- Line: 172
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy)
    u22.CloseButton.MouseButton1Click:Connect(function() -- Line: 173
        -- upvalues: u22 (copy)
        u22.Shop:CloseRequest();
    end);
    u22.Shop.CurrentPageChanged:Connect(function() -- Line: 177
        -- upvalues: u22 (copy)
        u22:_Update();
    end);
    u22.MoreButton.MouseButton1Click:Connect(function() -- Line: 181
        -- upvalues: u22 (copy)
        u22:_OpenMoreTabs();
    end);
    u22.LessButton.MouseButton1Click:Connect(function() -- Line: 185
        -- upvalues: u22 (copy)
        u22:_CloseMoreTabs();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 189
        -- upvalues: u22 (copy)
        u22:_UpdateEvent();
    end);
    PlayerDataController:GetDataChangedSignal("Glory"):Connect(function() -- Line: 193
        -- upvalues: u22 (copy)
        u22:_UpdateVisibility();
    end);
    u22:_Setup();
    u22:_UpdateEvent();
    u22:_UpdateVisibility();
    task.defer(u22._HookLocalFighter, u22);
    ButtonEffect:Add(u22.CloseButton);
    ButtonEffect:Add(u22.MoreButton);
    ButtonEffect:Add(u22.LessButton);
end;

return u1;