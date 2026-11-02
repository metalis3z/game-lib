-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local LootLibrary = require(ReplicatedStorage.Modules.LootLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local StoredStreakSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("StoredStreakSlot");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 19
    -- upvalues: Page (copy), u1 (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3._slots = {};
    v3._countdown_thread = nil;
    v3:_Init();

    return v3;
end;

function u1.Open(p4, ...) -- Line: 39
    -- upvalues: Page (copy)
    Page.Open(p4, ...);
    p4:_Generate();
    p4:_StartCountdownLoop();
end;

function u1.Close(p5, ...) -- Line: 45
    -- upvalues: Page (copy)
    Page.Close(p5, ...);
    p5:_StartCountdownLoop();
end;

function u1._StartCountdownLoop(u6) -- Line: 54
    if u6._countdown_thread then
        task.cancel(u6._countdown_thread);
        u6._countdown_thread = nil;
    end;

    if not u6:IsOpen() then
        return;
    end;

    u6._countdown_thread = task.spawn(function() -- Line: 64
        -- upvalues: u6 (copy)
        while true do
            u6:_UpdateCountdown();
            wait(1);
        end;
    end);
end;

function u1._UpdateCountdown(p7) -- Line: 72
    -- upvalues: ServerOsTime (copy), Utility (copy)
    for _, v in pairs(p7._slots) do
        local v8;

        if v.StoredStreak.ExpirationTime then
            v8 = v.StoredStreak.ExpirationTime - ServerOsTime:GetRounded();
        else
            v8 = nil;
        end;

        v.Slot.Countdown.Icon.Visible = v8 ~= nil;
        v.Slot.Countdown.Text = not v8 and "Oh no, you lost your win streak!" or (v8 <= 0 and "Expired" or Utility:TimeFormat2(v8));
        local Countdown = v.Slot.Countdown;
        local v9;

        if v8 and v8 <= 0 then
            v9 = Color3.fromRGB(255, 50, 50);
        else
            v9 = Color3.fromRGB(255, 255, 255);
        end;

        Countdown.TextColor3 = v9;
        v.Slot.Countdown.Icon.ImageColor3 = v.Slot.Countdown.TextColor3;
    end;
end;

function u1._Generate(u10) -- Line: 83
    -- upvalues: PlayerDataController (copy), StoredStreakSlot (copy), Utility (copy), LootLibrary (copy), ButtonEffect (copy), ServerOsTime (copy), Pages (copy), MonetizationController (copy), ReplicatedStorage (copy)
    for _, v in pairs(u10._slots) do
        v.Slot:Destroy();
    end;

    u10._slots = {};

    if not u10:IsOpen() then
        return;
    end;

    for i, v in pairs(PlayerDataController:Get("StoredStreaks")) do
        local v11 = StoredStreakSlot:Clone();
        v11.Streak.Value.Text = Utility:PrettyNumber(v.Value);
        v11.Button.Price.Text = LootLibrary:GetRecoverStreakCost(v.ConsecutiveRecoveries);
        v11.LayoutOrder = i;
        v11.Parent = u10.Container;
        table.insert(u10._slots, {
            Slot = v11,
            StoredStreak = v
        });
        ButtonEffect:Add(v11.Button);
        local Title = v11.Title;
        local u12 = 0;
        v11.Button.MouseButton1Click:Connect(function() -- Line: 106
            -- upvalues: ServerOsTime (ref), v (copy), Utility (ref), LootLibrary (ref), PlayerDataController (ref), Pages (ref), MonetizationController (ref), u10 (copy), Title (copy), u12 (ref), ReplicatedStorage (ref), i (copy)
            if ServerOsTime:Get() > (v.ExpirationTime or (1 / 0)) then
                Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

                return;
            end;

            local RecoverStreakCost = LootLibrary:GetRecoverStreakCost(v.ConsecutiveRecoveries);

            if PlayerDataController:Get("WeaponKeys") < RecoverStreakCost then
                Pages.PageSystem:OpenPage("Shop");
                Pages.PageSystem:WaitForPage("Shop"):SetPage("Currency");
                MonetizationController:PromptCurrencyBundlePurchase(RecoverStreakCost, "WeaponKeys");
                u10:CloseRequest();

                return;
            end;

            if Title.Text == "Are you sure?" then
                Utility:CreateSound("rbxassetid://18228252652", 1, 1, script, true, 5);
                ReplicatedStorage.Remotes.Data.RecoverStreak:FireServer(i);
                u10:CloseRequest();

                return;
            end;

            Title.Text = "Are you sure?";
            u12 = u12 + 1;
            wait(3);

            if u12 == u12 then
                Title.Text = "Recover now";
            end;
        end);
        local Countdown = v11.Countdown;
        local Icon = v11.Countdown.Icon;
        local Price = v11.Button.Price;
        local Icon2 = Price.Icon;

        local function update() -- Line: 151
            -- upvalues: Price (copy), Icon2 (copy), Countdown (copy), Icon (copy)
            Price.Position = UDim2.new(0.5, -Icon2.AbsoluteSize.X / 2, 0.5, 0);
            Icon2.Position = UDim2.new(0.5, Price.TextBounds.X / 2, 0.5, 0);
            Countdown.Position = UDim2.new(0.5, not Icon.Visible and 0 or Icon.AbsoluteSize.X / 2, 0.1, 0);
            Icon.Position = UDim2.new(0.5, -Countdown.TextBounds.X / 2, 0.5, 0);
        end;

        Price:GetPropertyChangedSignal("TextBounds"):Connect(update);
        Icon2:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
        Countdown:GetPropertyChangedSignal("TextBounds"):Connect(update);
        Icon:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
        Icon:GetPropertyChangedSignal("Visible"):Connect(update);
        update();
    end;

    u10.CloseButton.Position = #u10._slots > 1 and UDim2.new(0.95, 16, 0.0375) or UDim2.new(0.95, 16, 0.2575, 0);
    u10.List.Position = #u10._slots > 1 and UDim2.new(0.5, 9, 0, 0) or UDim2.new(0.5, 9, 0.22, 0);
    u10:_StartCountdownLoop();
end;

function u1._Init(u13) -- Line: 171
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy)
    u13.CloseButton.MouseButton1Click:Connect(function() -- Line: 172
        -- upvalues: u13 (copy)
        u13:CloseRequest();
    end);
    u13.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 176
        -- upvalues: u13 (copy)
        u13.List.CanvasSize = UDim2.new(0, 0, 0, u13.Layout.AbsoluteContentSize.Y);
    end);
    PlayerDataController:GetDataChangedSignal("StoredStreaks"):Connect(function() -- Line: 180
        -- upvalues: u13 (copy)
        u13:_Generate();
    end);
    u13:_Generate();
    ButtonEffect:Add(u13.CloseButton);
end;

return u1._new();