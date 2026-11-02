-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local TaskLibrary = require(ReplicatedStorage.Modules.TaskLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ShopController"));
local CosmeticViewportFrame = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("CosmeticViewportFrame"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local EmoteViewportFrame = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("EmoteViewportFrame"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local LobbyButtonSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LobbyButtonSlot");
local u1 = {
    { "Backpack", "Backpack", "See your extra loot", "rbxassetid://18185474596" },
    { "Career", "Career", "Check out your collection & statistics", nil },
    { "Equipment", "Weapons", "View your weapons, career, emotes, & more", nil, "UIOpenPage1" },
    { "Tasks", "Tasks", "Complete tasks to earn keys", "rbxassetid://17653923757", "UIOpenPage2" },
    { "Shop", "Shop", "Unlock weapons, redeem codes, & more", "rbxassetid://17619445340", "UIOpenPage3" },
    { "BattlePass", "Pass", "Free weapons, skins, keys, & more", "rbxassetid://81577092220450", "UIOpenPage4" },
    { "Settings", "Settings", "Change crosshair & hotkeys", "rbxassetid://17619445191" },
    -- Added: opens the admin panel (StarterPlayerScripts.AdminPanel, PlayerGui.AdminPanel.Toggle).
    { "Admin", "Admin", "Unlock anything & give crates", "rbxassetid://127904742940104" },
    { "Rewards", "Codes", "Earn free rewards & redeem codes", "rbxassetid://84811629597038" },
    { "Recover", "Recover", "Recover your win streak", "rbxassetid://112615701583145" },
    { "EventOverview", "Event", "Here for a limited time only!", nil },
    { "EquipmentExit", "Leave", nil, "rbxassetid://17619444538", "UICancelAction" },
    { "Emotes", "Emotes", "Preview & equip your emotes", "rbxassetid://111957823189761", "UIOpenPage1" },
    { "Maps", "Maps", "View map details & map contracts", "rbxassetid://112880011932436", "UIOpenPage2" },
    { "DuelHistory", "History", "Check out your most recent duels", "rbxassetid://18678814606", "UIOpenPage3" },
    { "Collection", "Collection", "Quickly view your game progress", "rbxassetid://18186174849", "UIOpenPage4" },
    { "Contracts", "Contracts", "Earn free keys & cosmetics", "rbxassetid://17619445009" },
    { "Skins", "Skin", "Change how this weapon looks", nil, "UIOpenPage1" },
    { "Wraps", "Wrap", "Apply a wrap to this weapon", nil, "UIOpenPage2" },
    { "Charms", "Charm", "Equip a gun buddy", nil, "UIOpenPage3" },
    { "Finishers", "Finisher", "Play an effect on elimination", nil, "UIOpenPage4" }
};
local u2 = {};
u2.__index = u2;

function u2._new() -- Line: 59
    -- upvalues: u2 (copy), UILibrary (copy)
    local v3 = setmetatable({}, u2);
    v3.IsOpen = false;
    v3.Frame = UILibrary:GetTo("MainFrame", "Lobby", "Buttons");
    v3._visibility_effect_hash = 0;
    v3._hover_effect_hash = 0;
    v3._buttons = {};
    v3._button_callbacks = {};
    v3._unhover_functions = {};
    v3._wraps_cosmetic_viewport_frame = nil;
    v3._charms_cosmetic_viewport_frame = nil;
    v3._emotes_emote_viewport_frame = nil;
    v3:_Init();

    return v3;
end;

function u2._Unhover(p4) -- Line: 89
    for _, v in pairs(p4._unhover_functions) do
        v();
    end;
end;

function u2._UpdateVisibility(p5) -- Line: 95
    -- upvalues: Pages (copy), Equipment (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), GuiService (copy)
    local v6 = not (Pages.PageSystem.CurrentPage or (Equipment:IsUnlocking() or Queue:IsVisible() or (Teleporting.Enabled or MobileInputs.EditorEnabled))) and not GuiService.MenuIsOpen;
    p5.IsOpen = v6;
    p5.Frame.Container:TweenPosition(p5.IsOpen and UDim2.new(0.5, 0, 0.9625, -20) or UDim2.new(0.5, 0, 1.3, 20), "Out", "Quint", 0.25, true);
    p5:_Unhover();
end;

function u2._PlayButtonVisibilityEffect(u7) -- Line: 101
    -- upvalues: GuiService (copy)
    u7._visibility_effect_hash = u7._visibility_effect_hash + 1;
    local _visibility_effect_hash = u7._visibility_effect_hash;
    local v8 = {};

    for _, v in pairs(u7._buttons) do
        if v.Visible then
            table.insert(v8, v);
        end;
    end;

    table.sort(v8, function(p9, p10) -- Line: 113
        return p9.LayoutOrder < p10.LayoutOrder;
    end);

    for i, v in pairs(v8) do
        if GuiService.ReducedMotionEnabled then
            v.Size = UDim2.new(1, 0, 1, 0);
            v:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", 0, true);
        else
            v.Size = UDim2.new(0, 0, 0, 0);
            v:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Linear", 0, true);
            task.delay(0.1 * (i - 1), function() -- Line: 127
                -- upvalues: _visibility_effect_hash (copy), u7 (copy), v (copy)
                if _visibility_effect_hash ~= u7._visibility_effect_hash then
                    return;
                end;

                v:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Back", 0.25, true);
            end);
        end;
    end;
end;

function u2._UpdateButtonInformation(p11) -- Line: 137
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy), Equipment (copy), CONSTANTS (copy), ItemLibrary (copy), CosmeticLibrary (copy), CosmeticViewportFrame (copy), EmoteViewportFrame (copy)
    if p11._wraps_cosmetic_viewport_frame then
        p11._wraps_cosmetic_viewport_frame:Destroy();
        p11._wraps_cosmetic_viewport_frame = nil;
    end;

    if p11._charms_cosmetic_viewport_frame then
        p11._charms_cosmetic_viewport_frame:Destroy();
        p11._charms_cosmetic_viewport_frame = nil;
    end;

    if p11._emotes_emote_viewport_frame then
        p11._emotes_emote_viewport_frame:Destroy();
        p11._emotes_emote_viewport_frame = nil;
    end;

    local v12 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v12 then
        v12 = v12.BattlePass;
    end;

    p11._buttons.BattlePass.Button.Container.Icon.Image = SeasonLibrary.PASS_TRACK_IMAGES[math.clamp(v12 and v12.MaxPassTrackNum or 0, 1, #SeasonLibrary.PASS_TRACK_IMAGES)];
    local WeaponData = PlayerDataController:GetWeaponData(Equipment:GetSelectedWeapon());
    local v13 = CONSTANTS.COSMETIC_IMAGES[WeaponData and WeaponData.Skin and (WeaponData.Skin.Name or "NONE_COSMETIC") or "NONE_COSMETIC"];
    p11._buttons.Skins.Button.Container.Icon.Image = v13 or (WeaponData and (ItemLibrary:GetViewModelImageFromWeaponData(WeaponData) or "") or "");
    p11._buttons.Skins.Button.Container.Icon.ImageTransparency = v13 and 0.875 or 0;
    p11._buttons.Skins.Button.Container.Icon.Size = v13 and UDim2.new(0.4, 0, 0.4, 0) or UDim2.new(1.875, 0, 1.875, 0);
    local v14 = CONSTANTS.COSMETIC_IMAGES[WeaponData and WeaponData.Finisher and (WeaponData.Finisher.Name or "NONE_COSMETIC") or "NONE_COSMETIC"];
    p11._buttons.Finishers.Button.Container.Icon.Image = v14 or CosmeticLibrary.Cosmetics[WeaponData.Finisher.Name].Image;
    p11._buttons.Finishers.Button.Container.Icon.ImageTransparency = v14 and 0.875 or 0;
    p11._buttons.Finishers.Button.Container.Icon.Size = v14 and UDim2.new(0.4, 0, 0.4, 0) or UDim2.new(0.75, 0, 0.75, 0);
    p11._buttons.Finishers.Button.Container.Icon.UICorner.CornerRadius = v14 and UDim.new(0, 0) or UDim.new(1, 0);
    local v15 = WeaponData and WeaponData.Wrap and (WeaponData.Wrap.Name or "NONE_COSMETIC") or "NONE_COSMETIC";
    local v16 = CONSTANTS.COSMETIC_IMAGES[v15];
    p11._buttons.Wraps.Button.Container.Icon.Image = v16 or "";
    p11._buttons.Wraps.Button.Container.Icon.ImageTransparency = v16 and 0.875 or 0;
    p11._buttons.Wraps.Button.Container.Icon.Size = v16 and UDim2.new(0.4, 0, 0.4, 0) or UDim2.new(0.75, 0, 0.75, 0);

    if v15 ~= "NONE_COSMETIC" and v15 ~= "RANDOM_COSMETIC" then
        p11._wraps_cosmetic_viewport_frame = CosmeticViewportFrame.new(v15);
        p11._wraps_cosmetic_viewport_frame.Frame.Parent = p11._buttons.Wraps.Button.Container;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = p11._wraps_cosmetic_viewport_frame.Frame;
    end;

    local v17 = WeaponData and (WeaponData.Charm and WeaponData.Charm.Name) or "NONE_COSMETIC";
    local v18 = CONSTANTS.COSMETIC_IMAGES[v17];
    p11._buttons.Charms.Button.Container.Icon.Image = v18 or "";
    p11._buttons.Charms.Button.Container.Icon.ImageTransparency = v18 and 0.875 or 0;
    p11._buttons.Charms.Button.Container.Icon.Size = v18 and UDim2.new(0.4, 0, 0.4, 0) or UDim2.new(0.75, 0, 0.75, 0);

    if v17 ~= "NONE_COSMETIC" and v17 ~= "RANDOM_COSMETIC" then
        p11._charms_cosmetic_viewport_frame = CosmeticViewportFrame.new(v17);
        p11._charms_cosmetic_viewport_frame.Frame.Parent = p11._buttons.Charms.Button.Container;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = p11._charms_cosmetic_viewport_frame.Frame;
    end;

    local v19 = PlayerDataController:Get("EquippedEmotes");
    local v20 = not next(v19) and "NONE_COSMETIC" or nil;
    local v21 = CONSTANTS.COSMETIC_IMAGES[v20];
    p11._buttons.Emotes.Button.Container.Icon.Image = v21 or "";
    p11._buttons.Emotes.Button.Container.Icon.ImageTransparency = v21 and 0.875 or 0;
    p11._buttons.Emotes.Button.Container.Icon.Size = v21 and UDim2.new(0.4, 0, 0.4, 0) or UDim2.new(0.75, 0, 0.75, 0);

    if not v20 then
        local v22 = {};

        for _, v in pairs(v19) do
            table.insert(v22, v.Name);
        end;

        local v23 = v22[math.random(#v22)];
        p11._emotes_emote_viewport_frame = EmoteViewportFrame.new(v23);
        p11._emotes_emote_viewport_frame:HideShadow();
        p11._emotes_emote_viewport_frame:SetParent(p11._buttons.Emotes.Button.Container);
    end;
end;

function u2._UpdateButtonVisibility(p24) -- Line: 231
    -- upvalues: Equipment (copy), PlayerDataController (copy), SeasonLibrary (copy), EventLibrary (copy), ItemLibrary (copy)
    local IsOpen = Equipment.IsOpen;
    local v25 = Equipment:IsOpenEffectDone();
    local v26;

    if IsOpen then
        v26 = Equipment:IsCareerPageOpen();
    else
        v26 = IsOpen;
    end;

    local v27;

    if IsOpen then
        v27 = Equipment:GetSelectedWeapon();
    else
        v27 = IsOpen;
    end;

    local v28 = PlayerDataController:GetWeaponData(v27) ~= nil;
    local v29 = not Equipment:IsCustomizing();
    local Statistic = PlayerDataController:GetStatistic("StatisticDuelsPlayed");
    PlayerDataController:GetStatistic("StatisticDuelsWon");
    local Backpack = p24._buttons.Backpack;
    local v30 = not IsOpen and #PlayerDataController:Get("UnclaimedRewards") > 0;
    Backpack.Visible = v30;
    p24._buttons.Career.Visible = false;
    p24._buttons.Equipment.Visible = not IsOpen;
    p24._buttons.Tasks.Visible = not IsOpen;
    -- The original waits for 3 duels; this place opens the shop from the start.
    p24._buttons.Shop.Visible = not IsOpen;
    local v31 = not IsOpen;

    if v31 then
        if Statistic >= 10 then
            v31 = SeasonLibrary.CurrentSeason.BattlePassActive;
        else
            v31 = false;
        end;
    end;

    p24._buttons.BattlePass.Visible = v31;
    local v32 = not IsOpen;

    if v32 then
        if Statistic >= 5 then
            v32 = Statistic < 15;
        else
            v32 = false;
        end;
    end;

    p24._buttons.Rewards.Visible = v32;
    local Recover = p24._buttons.Recover;
    local v33 = not IsOpen and #PlayerDataController:Get("StoredStreaks") > 0;
    Recover.Visible = v33;
    p24._buttons.EventOverview.Visible = not IsOpen and EventLibrary.IS_ACTIVE and EventLibrary.NUM_GAMES_NEEDED_TO_PARTICIPATE <= Statistic;
    local v34;

    if IsOpen then
        if v25 then
            v34 = v29;
        else
            v34 = v25;
        end;
    else
        v34 = IsOpen;
    end;

    p24._buttons.EquipmentExit.Visible = v34;
    p24._buttons.Contracts.Visible = false;
    local v35;

    if IsOpen then
        if v25 then
            if v28 then
                v35 = v29;
            else
                v35 = v28;
            end;
        else
            v35 = v25;
        end;
    else
        v35 = IsOpen;
    end;

    p24._buttons.Skins.Visible = v35;
    local v36;

    if IsOpen then
        if v25 then
            if v28 then
                v36 = v29;
            else
                v36 = v28;
            end;
        else
            v36 = v25;
        end;
    else
        v36 = IsOpen;
    end;

    p24._buttons.Wraps.Visible = v36;
    local v37;

    if IsOpen then
        if v25 then
            if v28 then
                v37 = v29;
            else
                v37 = v28;
            end;
        else
            v37 = v25;
        end;
    else
        v37 = IsOpen;
    end;

    p24._buttons.Charms.Visible = v37;
    p24._buttons.Finishers.Visible = IsOpen and (v25 and (v28 and (v29 and ItemLibrary.Items[v27]))) and ItemLibrary.Items[v27].CanEliminate;

    if IsOpen then
        if v25 then
            if not v26 then
                v29 = v26;
            end;
        else
            v29 = v25;
        end;
    else
        v29 = IsOpen;
    end;

    p24._buttons.Emotes.Visible = v29;
    p24._buttons.Maps.Visible = false;
    p24._buttons.DuelHistory.Visible = false;
    p24._buttons.Collection.Visible = false;
    p24._buttons.Settings.Visible = not IsOpen and not p24._buttons.Recover.Visible;
    p24._buttons.Admin.Visible = not IsOpen;
    p24:_UpdateButtonInformation();
    p24:_PlayButtonVisibilityEffect();
    p24:_Unhover();
end;

function u2._CreateButton(p38, p39, u40, p41, u42, p43, p44) -- Line: 276
    -- upvalues: LobbyButtonSlot (copy), Players (copy), PlayerDataController (copy), TaskLibrary (copy), Pages (copy), SeasonLibrary (copy), Equipment (copy), CosmeticLibrary (copy), ButtonEffect (copy)
    local u45 = LobbyButtonSlot:Clone();
    u45.Button.Container.Title.Text = p41;
    u45.Button.Container.Icon.Image = p43 or "";
    u45.Button.Container.Bubble.Title.Text = u42 or "";
    u45.Button.Inputs.Gamepad.Keybind:SetAttribute("InputName", p44);
    u45.LayoutOrder = p39;
    local u46 = 0;

    local function open() -- Line: 286
        -- upvalues: u45 (copy), u46 (ref), Players (ref), u42 (copy)
        if u45.Button.Container.NotificationBubble.Visible then
            return;
        end;

        u46 = u46 + 1;
        local u47 = u46;
        local v48 = u45:IsDescendantOf(Players);

        if v48 then
            u45.Button.Container:TweenPosition(UDim2.new(0.5, 0, 0.375, 0), "Out", "Quint", 0.25, true);
        else
            u45.Button.Container.Position = UDim2.new(0.5, 0, 0.375, 0);
        end;

        if u42 then
            u45.Button.Container.Bubble.Visible = true;
            u45.Button.Container.Bubble.Position = UDim2.new(0.5, 0, 0, 0);

            if v48 then
                u45.Button.Container.Bubble.Size = UDim2.new(0, 0, 0.125, 0);
                u45.Button.Container.Bubble:TweenSize(UDim2.new(5, 0, 0.25, 0), "Out", "Quint", 0.25, true);
            else
                u45.Button.Container.Bubble.Size = UDim2.new(5, 0, 0.25, 0);
            end;

            task.spawn(function() -- Line: 312
                -- upvalues: u47 (copy), u46 (ref), u45 (ref), Players (ref)
                wait(1);

                while u47 == u46 do
                    if u45:IsDescendantOf(Players) then
                        u45.Button.Container.Bubble:TweenPosition(UDim2.new(0.5, 0, -0.125, 0), "Out", "Sine", 0.5, true);
                    end;

                    wait(0.5);

                    if u47 ~= u46 then
                        return;
                    end;

                    if u45:IsDescendantOf(Players) then
                        u45.Button.Container.Bubble:TweenPosition(UDim2.new(0.5, 0, 0, 0), "In", "Sine", 0.5, true);
                    end;

                    wait(0.5);
                end;
            end);
        end;
    end;

    u45.Button.MouseEnter:Connect(open);

    if u40 == "Tasks" and PlayerDataController:Get("BeginnerTasksCompleted") < TaskLibrary.NUM_BEGINNER_TASKS then
        open();
    end;

    if u40 == "Shop" then
        u45.Button.Container.NotificationBubble.Title.Text = "Claim your FREE reward now!";
        local u49 = false;
        u45.Button.MouseButton1Click:Connect(function() -- Line: 352
            -- upvalues: u49 (ref)
            u49 = true;
        end);

        local function notification_bubble() -- Line: 356
            -- upvalues: u45 (copy), u49 (ref), Pages (ref), PlayerDataController (ref)
            local NotificationBubble = u45.Button.Container.NotificationBubble;
            local v50 = not (u49 or (Pages.PageSystem.CurrentPage or PlayerDataController:Get("ClaimedLoginRewardToday"))) and PlayerDataController:GetStatistic("StatisticDuelsPlayed") > 3;
            NotificationBubble.Visible = v50;
        end;

        PlayerDataController:GetDataChangedSignal("ClaimedLoginRewardToday"):Connect(notification_bubble);
        PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(notification_bubble);
        Pages.PageSystem.PageOpened:Connect(notification_bubble);
        Pages.PageSystem.PageClosed:Connect(notification_bubble);
        local NotificationBubble = u45.Button.Container.NotificationBubble;
        local v51 = not (u49 or (Pages.PageSystem.CurrentPage or PlayerDataController:Get("ClaimedLoginRewardToday"))) and PlayerDataController:GetStatistic("StatisticDuelsPlayed") > 3;
        NotificationBubble.Visible = v51;
    elseif u40 == "Backpack" then
        local u52 = #(PlayerDataController:Get("UnclaimedRewards") or {});
        local u53 = 0;
        PlayerDataController:GetDataChangedSignal("UnclaimedRewards"):Connect(function() -- Line: 369
            -- upvalues: PlayerDataController (ref), u53 (ref), u52 (ref), u45 (copy)
            local v54 = #(PlayerDataController:Get("UnclaimedRewards") or {});
            u53 = u53 + math.max(0, v54 - u52);
            u52 = v54;
            u45.Button.Container.Notification.Visible = u53 > 0;
            u45.Button.Container.Notification.Title.Text = u53;
        end);
        Pages.PageSystem.PageOpened:Connect(function() -- Line: 379
            -- upvalues: Pages (ref), u53 (ref), u45 (copy)
            if Pages.PageSystem.CurrentPage.Name == "Backpack" then
                u53 = 0;
                u45.Button.Container.Notification.Visible = false;
            end;
        end);
    elseif u40 == "Tasks" then
        local function update() -- Line: 386
            -- upvalues: PlayerDataController (ref), u45 (copy)
            local v55 = #PlayerDataController:Get("Tasks") - PlayerDataController:GetNumTasksCompleted();
            u45.Button.Container.Notification.Visible = v55 > 0;
            u45.Button.Container.Notification.Title.Text = v55;
        end;

        PlayerDataController:GetDataChangedSignal("BonusTasks"):Connect(update);
        PlayerDataController:GetDataChangedSignal("Tasks"):Connect(update);
        local v56 = #PlayerDataController:Get("Tasks") - PlayerDataController:GetNumTasksCompleted();
        u45.Button.Container.Notification.Visible = v56 > 0;
        u45.Button.Container.Notification.Title.Text = v56;
    elseif u40 == "BattlePass" then
        local function v65() -- Line: 397
            -- upvalues: PlayerDataController (ref), SeasonLibrary (ref), u45 (copy)
            local v57 = 0;
            local v58 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

            if v58 then
                v58 = v58.BattlePass;
            end;

            local v59 = v58 and (v58.PassLevel or 0) or 0;
            local v60 = v58 and (v58.MaxPassTrackNum or 0) or 0;

            for i = 1, v59 do
                local v61 = i;

                for i2 = 1, v60 do
                    local v62;

                    if SeasonLibrary.CurrentSeason.BattlePassRewards[v61] and SeasonLibrary.CurrentSeason.BattlePassRewards[v61][i2] then
                        local v63;

                        if v61 <= v59 then
                            v63 = i2 <= v60;
                        else
                            v63 = false;
                        end;

                        local v64 = v58 and v58.RewardsClaimed[tostring(v61)] and v58.RewardsClaimed[tostring(v61)][tostring(i2)];

                        if v63 and not v64 then
                            v57 = v57 + 1;
                            v62 = i2;
                        else
                            v62 = i2;
                        end;
                    else
                        v62 = i2;
                    end;
                end;
            end;

            u45.Button.Container.Notification.Visible = v57 > 0;
            u45.Button.Container.Notification.Title.Text = v57;
        end;

        PlayerDataController:GetDataChangedSignal("Seasons"):Connect(v65);
        v65();
    elseif u40 == "Equipment" or (u40 == "Skins" or (u40 == "Wraps" or (u40 == "Charms" or (u40 == "Finishers" or u40 == "Emotes")))) then
        local function update_cosmetic_notifications() -- Line: 427
            -- upvalues: PlayerDataController (ref), Equipment (ref), u40 (copy), CosmeticLibrary (ref), u45 (copy)
            local v66 = PlayerDataController:Get("CosmeticNotifications");
            local UnlockedWeapons = PlayerDataController:GetUnlockedWeapons(true);
            local SelectedWeapon = Equipment:GetSelectedWeapon();
            local v67;

            if u40 == "Equipment" then
                v67 = CosmeticLibrary:CountNotifications(v66, nil, UnlockedWeapons);
            else
                v67 = CosmeticLibrary:CountNotificationsByCosmeticType(v66, string.sub(u40, 1, #u40 - 1), SelectedWeapon, UnlockedWeapons);
            end;

            u45.Button.Container.Notification.Visible = v67 > 0;
            u45.Button.Container.Notification.Title.Text = v67;
        end;

        PlayerDataController:GetDataChangedSignal("CosmeticNotifications"):Connect(update_cosmetic_notifications);
        PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(update_cosmetic_notifications);
        Equipment.SelectedWeaponChanged:Connect(update_cosmetic_notifications);
        update_cosmetic_notifications();
    end;

    if u40 == "Equipment" then
        local function v71() -- Line: 447
            -- upvalues: Pages (ref), u45 (copy), PlayerDataController (ref)
            if Pages.PageSystem.CurrentPage then
                u45.Button.Container.NotificationBubble.Visible = false;

                return;
            end;

            local v68 = PlayerDataController:Get("UnlockTokens");
            local v69;

            if v68 then
                if v68 > 0 then
                    v69 = not PlayerDataController:OwnsAllWeapons("Standard", true, true);
                else
                    v69 = false;
                end;
            else
                v69 = v68;
            end;

            local v70 = 0;

            for i in pairs(PlayerDataController:Get("FreeWeaponUnlockCheck")) do
                if not PlayerDataController:GetWeaponData(i) then
                    v70 = v70 + 1;

                    if v70 >= 2 then
                        break;
                    end;
                end;
            end;

            u45.Button.Container.NotificationBubble.Visible = v70 > 0 and true or v69;
            u45.Button.Container.NotificationBubble.Title.Text = v70 > 1 and "Unlock your new weapons now!" or (v70 == 1 and "Unlock your new weapon now!" or (v69 and ("You have " .. v68 .. " free weapon unlock" .. (v68 == 1 and "" or "s") .. "!" or "") or ""));
        end;

        PlayerDataController:GetDataChangedSignal("FreeWeaponUnlockCheck"):Connect(v71);
        PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(v71);
        PlayerDataController:GetDataChangedSignal("UnlockTokens"):Connect(v71);
        Pages.PageSystem.PageOpened:Connect(v71);
        Pages.PageSystem.PageClosed:Connect(v71);
        v71();
    end;

    p38._unhover_functions[u40] = function() -- Line: 482
        -- upvalues: u46 (ref), u45 (copy)
        u46 = u46 + 1;
        u45.Button.Container:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true);
        u45.Button.Container.Bubble.Visible = false;
    end;

    u45.Button.MouseLeave:Connect(p38._unhover_functions[u40]);
    u45.Visible = false;
    u45.Parent = p38.Frame.Container.List;
    p38._buttons[u40] = u45;
    ButtonEffect:Add(u45.Button);

    local function update_background() -- Line: 495
        -- upvalues: u45 (copy)
        u45.Button.Container.Bubble.Background.Size = UDim2.new(0, u45.Button.Container.Bubble.Title.TextBounds.X + u45.Button.Container.Bubble.Background.AbsoluteSize.Y, 1, 0);
    end;

    u45.Button.Container.Bubble.Title:GetPropertyChangedSignal("TextBounds"):Connect(update_background);
    u45.Button.Container.Bubble.Background:GetPropertyChangedSignal("AbsoluteSize"):Connect(update_background);
    u45.Button.Container.Bubble.Background.Size = UDim2.new(0, u45.Button.Container.Bubble.Title.TextBounds.X + u45.Button.Container.Bubble.Background.AbsoluteSize.Y, 1, 0);
end;

function u2._OnButtonClicked(p72, p73, p74) -- Line: 504
    p72._buttons[p73].Button.MouseButton1Click:Connect(p74);
    p72._button_callbacks[p73] = p74;
end;

function u2._Setup(p75) -- Line: 509
    -- upvalues: u1 (copy), Pages (copy), Equipment (copy), CONSTANTS (copy), Players (copy), ItemLibrary (copy), EventLibrary (copy)
    for i, v in pairs(u1) do
        p75:_CreateButton(i, table.unpack(v));
    end;

    p75:_OnButtonClicked("Career", function() -- Line: 514
        -- upvalues: Pages (ref), Equipment (ref)
        Pages.PageSystem:CloseCurrentPage();
        Equipment:Open();
        Equipment:OpenCareerPage(true);
    end);
    p75:_OnButtonClicked("Equipment", function() -- Line: 520
        -- upvalues: Pages (ref), Equipment (ref), CONSTANTS (ref)
        Pages.PageSystem:CloseCurrentPage();
        Equipment:Open();

        if Equipment:IsCareerPageOpen() then
            Equipment:SelectWeapon(CONSTANTS.DEFAULT_WEAPONS[1]);
        end;
    end);
    p75:_OnButtonClicked("EquipmentExit", function() -- Line: 529
        -- upvalues: Equipment (ref)
        Equipment:CloseRequest();
    end);
    p75:_OnButtonClicked("Tasks", function() -- Line: 533
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("Tasks");
    end);
    p75:_OnButtonClicked("Settings", function() -- Line: 537
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("Settings");
    end);
    p75:_OnButtonClicked("Admin", function()
        -- upvalues: Players (ref)
        local gui = Players.LocalPlayer.PlayerGui:FindFirstChild("AdminPanel");
        local toggle = gui and gui:FindFirstChild("Toggle");

        if toggle then
            toggle:Fire();
        end;
    end);
    p75:_OnButtonClicked("Charms", function() -- Line: 541
        -- upvalues: Equipment (ref)
        Equipment:StartCustomizing("Charm");
    end);
    p75:_OnButtonClicked("Finishers", function() -- Line: 545
        -- upvalues: Equipment (ref)
        Equipment:StartCustomizing("Finisher");
    end);
    p75:_OnButtonClicked("Wraps", function() -- Line: 549
        -- upvalues: Equipment (ref)
        Equipment:StartCustomizing("Wrap");
    end);
    p75:_OnButtonClicked("Skins", function() -- Line: 553
        -- upvalues: Equipment (ref)
        Equipment:StartCustomizing("Skin");
    end);
    p75:_OnButtonClicked("Contracts", function() -- Line: 557
        -- upvalues: Pages (ref), Equipment (ref)
        Pages.PageSystem:OpenPage("Contracts");
        Pages.PageSystem:WaitForPage("Contracts"):SetWeapon(Equipment:GetSelectedWeapon());
    end);
    p75:_OnButtonClicked("Shop", function() -- Line: 562
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("Shop");
        Pages.PageSystem:WaitForPage("Shop"):SetPage("Home");
    end);
    p75:_OnButtonClicked("Rewards", function() -- Line: 567
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("Rewards");
    end);
    p75:_OnButtonClicked("Backpack", function() -- Line: 571
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("Backpack");
    end);
    p75:_OnButtonClicked("Collection", function() -- Line: 575
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("Collection");
    end);
    p75:_OnButtonClicked("Recover", function() -- Line: 579
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("StreakRecovery");
    end);
    p75:_OnButtonClicked("EventOverview", function() -- Line: 583
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("EventOverview");
    end);
    p75:_OnButtonClicked("DuelHistory", function() -- Line: 587
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("DuelHistory");
    end);
    p75:_OnButtonClicked("Maps", function() -- Line: 591
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("Maps");
    end);
    p75:_OnButtonClicked("Emotes", function() -- Line: 595
        -- upvalues: Equipment (ref)
        Equipment:StartCustomizing("Emote");
    end);
    p75:_OnButtonClicked("BattlePass", function() -- Line: 599
        -- upvalues: Pages (ref)
        Pages.PageSystem:OpenPage("BattlePass");
    end);
    p75._buttons.Career.Button.Container.Icon.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, Players.LocalPlayer.UserId);
    p75._buttons.Equipment.Button.Container.Icon.Image = ItemLibrary.ViewModels["Assault Rifle"].Image;
    p75._buttons.Equipment.Button.Container.Icon.Size = UDim2.new(1.875, 0, 1.875, 0);
    p75._buttons.EventOverview.Button.Container.Icon.Image = EventLibrary.EVENT_DETAILS.OVERVIEW_BUTTON_IMAGE;
    p75._buttons.EventOverview.Button.Container.Icon.Size = UDim2.new(1, 0, 1, 0);
    p75._buttons.BattlePass.Button.Container.Icon.Position = UDim2.new(0.55, 0, 0.5, 0);
    p75._buttons.BattlePass.Button.Container.Icon.Size = UDim2.new(0.875, 0, 0.875, 0);
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = p75._buttons.Career.Button.Container.Icon;
    UICorner:Clone().Parent = p75._buttons.Finishers.Button.Container.Icon;
end;

function u2._Init(u76) -- Line: 617
    -- upvalues: Equipment (copy), Pages (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), PlayerDataController (copy), GuiService (copy), UserInputService (copy), u1 (copy), InputLibrary (copy)
    u76.Frame.Container.List.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 618
        -- upvalues: u76 (copy)
        u76.Frame.Container.Background.Visible = u76.Frame.Container.List.Layout.AbsoluteContentSize.X > 0;
        u76.Frame.Container.Background.Size = UDim2.new(0.5, u76.Frame.Container.List.Layout.AbsoluteContentSize.X, 0.5, 0);
    end);
    Equipment.Opened:Connect(function() -- Line: 623
        -- upvalues: u76 (copy)
        u76:_UpdateButtonVisibility();
    end);
    Equipment.SelectedWeaponChanged:Connect(function() -- Line: 627
        -- upvalues: u76 (copy)
        u76:_UpdateButtonVisibility();
    end);
    Equipment.CareerPageOpened:Connect(function() -- Line: 631
        -- upvalues: u76 (copy)
        u76:_UpdateButtonVisibility();
    end);
    Equipment.CustomizingChanged:Connect(function() -- Line: 635
        -- upvalues: u76 (copy)
        u76:_UpdateButtonVisibility();
    end);
    Equipment.FinishedOpenEffect:Connect(function() -- Line: 639
        -- upvalues: u76 (copy)
        u76:_UpdateButtonVisibility();
    end);
    Equipment.UnlockingChanged:Connect(function() -- Line: 643
        -- upvalues: u76 (copy)
        u76:_UpdateVisibility();
    end);
    Pages.PageSystem.PageOpened:Connect(function() -- Line: 647
        -- upvalues: u76 (copy)
        u76:_UpdateVisibility();
    end);
    Pages.PageSystem.PageClosed:Connect(function() -- Line: 651
        -- upvalues: u76 (copy)
        u76:_UpdateVisibility();
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 655
        -- upvalues: u76 (copy)
        u76:_UpdateVisibility();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 659
        -- upvalues: u76 (copy)
        u76:_UpdateVisibility();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 663
        -- upvalues: u76 (copy)
        u76:_UpdateVisibility();
    end);
    PlayerDataController:GetDataChangedSignal("Seasons"):Connect(function() -- Line: 667
        -- upvalues: u76 (copy)
        u76:_UpdateButtonInformation();
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 671
        -- upvalues: u76 (copy)
        u76:_UpdateButtonInformation();
        u76:_UpdateButtonVisibility();
    end);
    PlayerDataController:GetDataChangedSignal("UnclaimedRewards"):Connect(function() -- Line: 676
        -- upvalues: u76 (copy)
        u76:_UpdateButtonVisibility();
    end);
    PlayerDataController:GetDataChangedSignal("StoredStreaks"):Connect(function() -- Line: 680
        -- upvalues: u76 (copy)
        u76:_UpdateButtonVisibility();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 684
        -- upvalues: u76 (copy)
        u76:_UpdateButtonVisibility();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsWon"):Connect(function() -- Line: 688
        -- upvalues: u76 (copy)
        u76:_UpdateButtonVisibility();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 692
        -- upvalues: u76 (copy)
        u76:_UpdateVisibility();
    end);
    UserInputService.InputBegan:Connect(function(p77, p78) -- Line: 696
        -- upvalues: u76 (copy), u1 (ref), InputLibrary (ref)
        if p78 or not (u76.IsOpen and u76.Frame.Visible) then
            return;
        end;

        for _, v in pairs(u1) do
            local v79 = v[1];
            local v80 = v[5];

            if v80 and (u76._buttons[v79].Visible and InputLibrary:InputIs(p77, v80)) then
                u76._button_callbacks[v79]();

                return;
            end;
        end;
    end);
    u76:_Setup();
    u76:_UpdateButtonVisibility();
    u76:_UpdateVisibility();
end;

return u2._new();