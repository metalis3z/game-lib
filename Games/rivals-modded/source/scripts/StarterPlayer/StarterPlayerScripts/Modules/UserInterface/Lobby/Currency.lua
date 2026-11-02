-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local CurrencyLibrary = require(ReplicatedStorage.Modules.CurrencyLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
require(ReplicatedStorage.Modules.ItemLibrary);
local TaskLibrary = require(ReplicatedStorage.Modules.TaskLibrary);
local TestLibrary = require(ReplicatedStorage.Modules.TestLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local Matchmaking = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Lobby:WaitForChild("Matchmaking"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local TestAttribute = TestLibrary:GetTestAttribute("StudioSkipOnboarding");
local CurrencySlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CurrencySlot");
local u1 = {
    EventCurrency = true,
    SkinTickets = true
};
local u2 = {
    Shop = true,
    EventOverview = true,
    StreakRecovery = true
};
local u3 = {};
u3.__index = u3;

function u3._new() -- Line: 31
    -- upvalues: u3 (copy), UILibrary (copy)
    local v4 = setmetatable({}, u3);
    v4.Frame = UILibrary:GetTo("MainFrame", "Lobby", "Currency");
    v4.Container = v4.Frame:WaitForChild("Container");
    v4._is_open = false;
    v4._is_shrinked = false;
    v4._currency_slots = {};
    v4._setup_update_slots_logic = false;
    v4._scrolled_up_hooked = {};
    v4._scrolled_up = {};
    v4._keys_bubble = nil;
    v4._keys_bubble_hash = 0;
    v4:_Init();

    return v4;
end;

function u3._UpdateOnboardingBubble(u5) -- Line: 61
    -- upvalues: TestAttribute (copy), PlayerDataController (copy), TaskLibrary (copy), Players (copy)
    if not u5._keys_bubble or TestAttribute then
        return;
    end;

    local v6 = PlayerDataController:Get("BeginnerTasksCompleted") >= TaskLibrary.NUM_BEGINNER_TASKS;
    local _keys_bubble = u5._keys_bubble;
    local v7 = u5._is_open and not (u5._is_shrinked or v6) and PlayerDataController:GetStatistic("StatisticDuelsPlayed") >= 2;
    _keys_bubble.Visible = v7;
    u5._keys_bubble_hash = u5._keys_bubble_hash + 1;
    local _keys_bubble_hash = u5._keys_bubble_hash;

    if not u5._keys_bubble.Visible then
        return;
    end;

    task.spawn(function() -- Line: 78
        -- upvalues: _keys_bubble_hash (copy), u5 (copy), Players (ref)
        while _keys_bubble_hash == u5._keys_bubble_hash do
            if u5._keys_bubble:IsDescendantOf(Players) then
                u5._keys_bubble:TweenPosition(UDim2.new(0.5, 0, 1, 0), "Out", "Sine", 0.5, true);
            end;

            wait(0.5);

            if _keys_bubble_hash ~= u5._keys_bubble_hash then
                return;
            end;

            if u5._keys_bubble:IsDescendantOf(Players) then
                u5._keys_bubble:TweenPosition(UDim2.new(0.5, 0, 0.875, 0), "In", "Sine", 0.5, true);
            end;

            wait(0.5);
        end;
    end);
end;

function u3._IsScrolledUp(p8) -- Line: 103
    for _, v in pairs(p8._scrolled_up) do
        if v then
            return true;
        end;
    end;
end;

function u3._UpdateVisibility(p9) -- Line: 111
    -- upvalues: Pages (copy), u2 (copy), Matchmaking (copy), Equipment (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), GuiService (copy), Players (copy)
    local v10 = ((not Pages.PageSystem.CurrentPage or Pages.PageSystem.CurrentPage.Name == "StreakRecovery") and true or false or u2[Pages.PageSystem.CurrentPage.Name]) and (not (Matchmaking:IsOpened() or Equipment:IsUnlocking()) and (not Equipment:IsCustomizing() and (not Equipment.IsOpen or Equipment:IsOpenEffectDone())) and not (Queue:IsVisible() or Teleporting.Enabled or (MobileInputs.EditorEnabled or GuiService.MenuIsOpen))) and not p9:_IsScrolledUp();
    p9._is_open = v10;
    p9._is_shrinked = false;

    if p9.Container:IsDescendantOf(Players) then
        p9.Container:TweenPosition(p9._is_open and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0.5, 0, -0.15, -30), "Out", "Quint", 0.25, true);
        p9.Container:TweenSize(p9._is_shrinked and UDim2.new(0.0375, 20, 0.0375, 20) or UDim2.new(0.075, 40, 0.075, 40), "Out", "Quint", 0.25, true);
    end;

    p9:_UpdateOnboardingBubble();
end;

function u3._UpdateSlots(p11) -- Line: 126
    -- upvalues: Pages (copy), CurrencyLibrary (copy), PlayerDataController (copy), u1 (copy), Utility (copy)
    local Page = Pages.PageSystem:GetPage("Shop");
    local v12;

    if Page then
        v12 = Page:IsOpen();
    else
        v12 = Page;
    end;

    local v13;

    if v12 then
        v13 = Page.CurrentPage == "Ranked";
    else
        v13 = v12;
    end;

    local Page2 = Pages.PageSystem:GetPage("EventOverview");

    if Page2 then
        Page2 = Page2:IsOpen();
    end;

    for i, v in pairs(p11._currency_slots) do
        local v14 = CurrencyLibrary.Info[i];
        local v15 = PlayerDataController:Get(v14.DataName) or 0;
        local v16;

        if v14.OnlyDisplayAboveZeroBalance and v15 <= 0 then
            v16 = false;
        elseif i == "Glory" and v13 then
            if v12 then
                v16 = v12;
            elseif i == "WeaponKeys" then
                v16 = true;
            elseif Page2 then
                v16 = u1[i];
            else
                v16 = Page2;
            end;
        elseif i == "Glory" then
            v16 = false;
        else
            v16 = not v13;

            if v16 then
                if v12 then
                    v16 = v12;
                elseif i == "WeaponKeys" then
                    v16 = true;
                elseif Page2 then
                    v16 = u1[i];
                else
                    v16 = Page2;
                end;
            end;
        end;

        v.Visible = v16;
        v.Title.Text = Utility:PrettyNumber(v15);
    end;
end;

function u3._SetupUpdateSlotsLogic(u17) -- Line: 146
    -- upvalues: Pages (copy)
    if u17._setup_update_slots_logic then
        return;
    end;

    u17._setup_update_slots_logic = true;
    task.spawn(function() -- Line: 153
        -- upvalues: Pages (ref), u17 (copy)
        Pages.PageSystem:WaitForPage("EventOverview").OpenChanged:Connect(function() -- Line: 156
            -- upvalues: u17 (ref)
            u17:_UpdateSlots();
        end);
        u17:_UpdateSlots();
    end);
    task.spawn(function() -- Line: 163
        -- upvalues: Pages (ref), u17 (copy)
        local v18 = Pages.PageSystem:WaitForPage("Shop");
        v18.OpenChanged:Connect(function() -- Line: 166
            -- upvalues: u17 (ref)
            u17:_UpdateSlots();
        end);
        v18.CurrentPageChanged:Connect(function() -- Line: 170
            -- upvalues: u17 (ref)
            u17:_UpdateSlots();
        end);
        u17:_UpdateSlots();
    end);
end;

function u3._SetupScrollUpLogic(u19, u20) -- Line: 178
    -- upvalues: Pages (copy)
    if u19._scrolled_up_hooked[u20] then
        return;
    end;

    u19._scrolled_up_hooked[u20] = true;
    local u21 = Pages.PageSystem:WaitForPage(u20);
    u21.OpenChanged:Connect(function() -- Line: 187
        -- upvalues: u21 (copy), u19 (copy), u20 (copy)
        if not u21:IsOpen() then
            u19._scrolled_up[u20] = false;
        end;
    end);
    u21.List:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 193
        -- upvalues: u21 (copy), u19 (copy), u20 (copy)
        if not (u21:IsOpen() and (u21.List.CanvasPosition.Y <= 10 or not u19._scrolled_up[u20]) and (u21.List.CanvasPosition.Y > 10 or u19._scrolled_up[u20])) then
            return;
        end;

        u19._scrolled_up[u20] = u21.List.CanvasPosition.Y > 10;
        u19:_UpdateVisibility();
    end);
    u19:_UpdateVisibility();
end;

function u3._Setup(u22) -- Line: 206
    -- upvalues: CurrencyLibrary (copy), EventLibrary (copy), CurrencySlot (copy), PlayerDataController (copy), Pages (copy), ButtonEffect (copy)
    for i, v in pairs(CurrencyLibrary.Order) do
        local v23 = CurrencyLibrary.Info[v];

        if not (v23.IsHidden or v == "EventCurrency" and not EventLibrary.IS_ACTIVE) then
            local v24 = CurrencySlot:Clone();
            v24.LayoutOrder = i;
            v24.Icon.Icon.Image = v23.Image;
            v24.Buy.Visible = v23.CanBePurchasedWithRobux;
            v24.Parent = u22.Container;
            u22._currency_slots[v] = v24;
            PlayerDataController:GetDataChangedSignal(v23.DataName):Connect(function() -- Line: 221
                -- upvalues: u22 (copy)
                u22:_UpdateSlots();
            end);
            v24.Buy.MouseButton1Click:Connect(function() -- Line: 225
                -- upvalues: Pages (ref)
                Pages.PageSystem:OpenPage("Shop", true);
                Pages.PageSystem:WaitForPage("Shop"):SetPage("Currency");
            end);
            ButtonEffect:Add(v24.Buy);

            if v == "WeaponKeys" then
                u22._keys_bubble = v24.Icon.Bubble;
                v24.Icon.MouseButton1Click:Connect(function() -- Line: 235
                    -- upvalues: Pages (ref)
                    Pages.PageSystem:OpenPage("Tasks", true);
                end);
                ButtonEffect:Add(v24.Icon);
            end;
        end;
    end;
end;

function u3._Init(u25) -- Line: 244
    -- upvalues: Equipment (copy), Pages (copy), u2 (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), Matchmaking (copy), PlayerDataController (copy), GuiService (copy)
    Equipment.UnlockingChanged:Connect(function() -- Line: 245
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Equipment.Opened:Connect(function() -- Line: 249
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Equipment.SelectedWeaponChanged:Connect(function() -- Line: 253
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Equipment.CustomizingChanged:Connect(function() -- Line: 257
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Equipment.FinishedOpenEffect:Connect(function() -- Line: 261
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Pages.PageSystem.PageOpened:Connect(function(p26) -- Line: 265
        -- upvalues: u2 (ref), u25 (copy)
        if u2[p26.Name] then
            task.spawn(u25._SetupScrollUpLogic, u25, p26.Name);
            task.spawn(u25._SetupUpdateSlotsLogic, u25);
        end;

        u25:_UpdateVisibility();
    end);
    Pages.PageSystem.PageClosed:Connect(function() -- Line: 274
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 278
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 282
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 286
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Matchmaking.OpenedChanged:Connect(function() -- Line: 290
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    PlayerDataController:GetDataChangedSignal("BeginnerTasksCompleted"):Connect(function() -- Line: 294
        -- upvalues: u25 (copy)
        u25:_UpdateOnboardingBubble();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 298
        -- upvalues: u25 (copy)
        u25:_UpdateOnboardingBubble();
        u25:_UpdateSlots();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 303
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    u25:_Setup();
    u25:_UpdateSlots();
    u25:_UpdateVisibility();
    u25:_UpdateOnboardingBubble();
end;

return u3._new();