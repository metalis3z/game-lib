-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
require(ReplicatedStorage.Modules.ShopLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local Spotlight = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Spotlight);
local VideoAdRewards = require(Players.LocalPlayer.PlayerScripts.Modules.VideoAdRewards);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local u1 = { "lootbox_Skin Case", "lootbox_Skin Case 2", "lootbox_Skin Case 3", "lootbox_Wrap Box", "lootbox_Wrap Box 2", "lootbox_Wrap Box 3", "lootbox_Charm Capsule", "lootbox_Finisher Pack", "lootbox_Finisher Pack 2", "loose_arena", "loose_randomwrap", "loose_universalwrap" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 27
    -- upvalues: u2 (copy), VideoAdRewards (copy)
    local v4 = setmetatable({}, u2);
    v4.Pages = p3;
    v4.Frame = v4.Pages.Frame:WaitForChild("Home");
    v4.Container = v4.Frame:WaitForChild("Container");
    v4.EventFrame = v4.Container:WaitForChild("Event");
    v4.OtherFrame = v4.Container:WaitForChild("Other");
    v4.LooseFrame = v4.OtherFrame:WaitForChild("Loose");
    v4.CarouselFrame = v4.OtherFrame:WaitForChild("Carousel");
    v4.CarouselContainer = v4.CarouselFrame:WaitForChild("Container");
    v4.VideoAdRewardsFrame = v4.CarouselContainer:WaitForChild("VideoAdRewards");
    v4.CarouselButtons = v4.CarouselFrame:WaitForChild("Buttons");
    v4.CarouselButtonsContainer = v4.CarouselButtons:WaitForChild("Container");
    v4.CarouselButtonsLayout = v4.CarouselButtonsContainer:WaitForChild("Layout");
    v4.CarouselButtonsBackground = v4.CarouselButtons:WaitForChild("Background");
    v4.VideoAdRewardsButton = v4.CarouselButtonsContainer:WaitForChild("VideoAdRewards");
    v4.RedirectFrame = v4.OtherFrame:WaitForChild("Redirect");
    v4.RedirectDailyButton = v4.RedirectFrame:WaitForChild("Daily"):WaitForChild("Container");
    v4.RedirectWeaponsButton = v4.RedirectFrame:WaitForChild("Weapons"):WaitForChild("Container");
    v4.RedirectKeysButton = v4.RedirectFrame:WaitForChild("Keys"):WaitForChild("Container");
    v4.BattlePassFrame = v4.OtherFrame:WaitForChild("BattlePass");
    v4.BattlePassContainer = v4.BattlePassFrame:WaitForChild("Container");
    v4.BattlePassBackground = v4.BattlePassContainer:WaitForChild("Background");
    v4.BattlePassNotHoveringFrame = v4.BattlePassContainer:WaitForChild("NotHovering");
    v4.BattlePassNotHoveringIcon = v4.BattlePassNotHoveringFrame:WaitForChild("Icon");
    v4.BattlePassIsHoveringFrame = v4.BattlePassContainer:WaitForChild("IsHovering");
    v4.BattlePassIsHoveringIcon = v4.BattlePassIsHoveringFrame:WaitForChild("Icon");
    v4.BattlePassRewardsFrame = v4.BattlePassIsHoveringFrame:WaitForChild("Rewards");
    v4.VideoAdRewards = VideoAdRewards.new();
    v4._is_open_hash = 0;
    v4._current_carousel_index = 0;
    v4._last_carousel_index_change_time = 0;
    v4._shop_slots = {};
    v4._carousel_buttons = {};
    v4._pause_carousel_until = 0;
    v4._season_pass_reward_slots = {};
    v4:_Init();

    return v4;
end;

function u2.GetVisualIndex(p5) -- Line: 76
    local v6 = 0;

    for i = 1, p5._current_carousel_index do
        local v7;

        if p5._carousel_buttons[i].Visible then
            v6 = v6 + 1;
            v7 = i;
        else
            v7 = i;
        end;
    end;

    return v6;
end;

function u2.SetCarouselIndexByName(p8, p9) -- Line: 88
    for i, v in pairs(p8._carousel_buttons) do
        if v.Name == p9 then
            p8:SetCarouselIndex(i);

            return;
        end;
    end;
end;

function u2.SetCarouselIndex(p10, p11) -- Line: 97
    -- upvalues: Players (copy)
    p10._current_carousel_index = (p11 - 1) % #p10._carousel_buttons + 1;
    local UDim2_new_ret = UDim2.new(0.5 - 0.975 * (p10:GetVisualIndex() - 1), 0, -0.025, 0);

    if p10.CarouselContainer:IsDescendantOf(Players) then
        p10.CarouselContainer:TweenPosition(UDim2_new_ret, "Out", "Quint", 0.75, true);
    else
        p10.CarouselContainer.Position = UDim2_new_ret;
    end;

    for i, v in pairs(p10._carousel_buttons) do
        local v12 = i == p10._current_carousel_index;
        v.ImageLabel.Size = v12 and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.3, 0, 0.3, 0);
        v.ImageLabel.ImageTransparency = v12 and 0 or 0.75;
    end;

    p10.VideoAdRewards:WeakUpdate();
end;

function u2.PauseCarousel(p13, p14) -- Line: 118
    p13._pause_carousel_until = tick() + p14;
end;

function u2.Open(p15) -- Line: 122
    p15._is_open_hash = p15._is_open_hash + 1;
    p15:_UpdateShopSlots();
    p15:_ScrollToDefault();
    task.spawn(p15._CarouselLoop, p15);
    task.spawn(p15._SeasonPassLoop, p15);
    p15.VideoAdRewards:Update();
end;

function u2.Close(p16) -- Line: 131
    p16:_UpdateShopSlots();
    p16._is_open_hash = p16._is_open_hash + 1;
end;

function u2.Setup(p17) -- Line: 136
    -- upvalues: MonetizationLibrary (copy)
    local v18 = MonetizationLibrary.VIDEO_AD_REWARDS_ENABLED and #MonetizationLibrary.VideoAdRewards > 0;
    p17.VideoAdRewardsFrame.Visible = v18;
    p17.VideoAdRewardsButton.Visible = v18;
    task.defer(p17.VideoAdRewards.Update, p17.VideoAdRewards);
    p17:_SetupCarouselSlot("VideoAdRewards");

    for _, v in pairs(p17.Pages.Shop.BUNDLE_NAMES) do
        p17:_SetupCarouselSlot(v, true);
    end;

    p17:SetCarouselIndex(1);
    p17:_ScrollToDefault();
end;

function u2._UpdateSeasonPassVisuals(p19) -- Line: 156
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy), ItemLibrary (copy)
    local v20 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v20 then
        v20 = v20.BattlePass;
    end;

    local v21 = v20 and v20.MaxPassTrackNum or 0;
    local v22 = SeasonLibrary.PASS_TRACK_IMAGES[math.clamp(v21, 1, #SeasonLibrary.PASS_TRACK_IMAGES)];
    p19.BattlePassIsHoveringIcon.Image = v22;
    p19.BattlePassNotHoveringIcon.Image = v22;
    p19.BattlePassBackground.ImageColor3 = ItemLibrary.StatusByPassTrackNum[v21].PassColor;
end;

function u2._SeasonPassLoop(u23) -- Line: 167
    -- upvalues: RewardSlot (copy), BetterDebris (copy), SeasonLibrary (copy)
    for _, v in pairs(u23._season_pass_reward_slots) do
        v:Destroy();
    end;

    u23._season_pass_reward_slots = {};

    local function create_slot(p24, p25, p26) -- Line: 178
        -- upvalues: RewardSlot (ref), u23 (copy), BetterDebris (ref)
        local v27 = (p25 - -1.5) / 0.5;
        local u28 = RewardSlot.new(p24);
        u28:SetInteractable(false);
        u28:SetNameText("");
        u28:SetParent(u23.BattlePassRewardsFrame);
        table.insert(u23._season_pass_reward_slots, u28);
        BetterDebris:AddItem(u28, v27);
        u28.Frame.Position = UDim2.new(p25, 0, p26, 0);
        u28.Frame:TweenPosition(UDim2.new(-1.5, 0, p26, 0), "InOut", "Linear", v27, true);
        task.delay(v27, function() -- Line: 191
            -- upvalues: u23 (ref), u28 (copy)
            local table_find_ret = table.find(u23._season_pass_reward_slots, u28);

            if table_find_ret then
                table.remove(u23._season_pass_reward_slots, table_find_ret);
            end;
        end);
    end;

    local _is_open_hash = u23._is_open_hash;
    local v29 = 0;

    while true do
        for i = 1, SeasonLibrary.CurrentSeason.NumBattlePassTiers do
            local v30 = i;

            for i2 = 1, SeasonLibrary.CurrentSeason.NumBattlePassTracks do
                local v31 = SeasonLibrary.CurrentSeason.BattlePassRewards[v30][i2];
                local v32;

                if v31 then
                    create_slot(v31, math.min(7, v29) * 1 + 0.5, i2 - 1 + 0.5);
                    v32 = i2;
                else
                    v32 = i2;
                end;
            end;

            v29 = v29 + 1;

            if v29 > 7 then
                wait(2);
            end;

            if _is_open_hash ~= u23._is_open_hash then
                return;
            end;
        end;
    end;
end;

function u2._UpdateCarouselButtonsBackground(p33) -- Line: 231
    p33.CarouselButtonsBackground.Size = UDim2.new(0, p33.CarouselButtonsLayout.AbsoluteContentSize.X, 1, 0);
end;

function u2._SetupCarouselSlot(u34, u35, p36) -- Line: 235
    -- upvalues: ButtonEffect (copy), MonetizationLibrary (copy)
    local u37 = u34.CarouselButtonsContainer:WaitForChild(u35);
    u37.MouseButton1Click:Connect(function() -- Line: 238
        -- upvalues: u34 (copy), u37 (copy)
        u34._last_carousel_index_change_time = tick();
        u34:SetCarouselIndex(table.find(u34._carousel_buttons, u37));
    end);
    ButtonEffect:Add(u37);
    table.insert(u34._carousel_buttons, u37);

    if p36 then
        local v38 = MonetizationLibrary.Bundles[u35];
        local u39 = u34.CarouselContainer:WaitForChild(u35);
        local Container = u39:WaitForChild("Container");
        Container.MouseButton1Click:Connect(function() -- Line: 251
            -- upvalues: u34 (copy), u35 (copy), u39 (copy)
            u34.Pages.Shop:InspectBundle(u35, u39);
        end);
        Container.Button.Bubble.Title.RichText = true;
        Container.Button.Bubble.Title.Text = v38.BubbleText or "";
        Container.Button.Bubble.Visible = Container.Button.Bubble.Title.Text ~= "";
        ButtonEffect:Add(Container, nil, {
            HoverRatio = 1.01,
            ReleaseRatio = 1.01
        });
    end;

    table.sort(u34._carousel_buttons, function(p40, p41) -- Line: 262
        return p40.LayoutOrder < p41.LayoutOrder;
    end);
end;

function u2._ScrollToDefault(p42) -- Line: 267
    p42:SetCarouselIndexByName("VideoAdRewards");
end;

function u2._CarouselLoop(p43) -- Line: 275
end;

function u2._UpdateShopSlots(p44) -- Line: 305
    -- upvalues: u1 (copy), EventLibrary (copy)
    for _, v in pairs(p44._shop_slots) do
        v:Destroy();
    end;

    p44._shop_slots = {};

    if not p44.Pages.Shop:IsOpen() then
        return;
    end;

    for i, v in pairs({ u1, EventLibrary.IS_ACTIVE and EventLibrary.SHOP_ENTRIES_OVERVIEW or nil }) do
        local v45 = i;

        for _, v2 in pairs(v) do
            local v46;

            if v45 == 2 then
                v46 = p44.EventFrame;
            else
                v46 = p44.LooseFrame;
            end;

            local v47 = p44.Pages.Shop:CreateShopSlot(nil, v46:WaitForChild(v2), v2);

            if v47 then
                table.insert(p44._shop_slots, v47);
            end;
        end;
    end;
end;

function u2._Setup(p48) -- Line: 328
    -- upvalues: EventLibrary (copy)
    p48.VideoAdRewards.Frame.Parent = p48.VideoAdRewardsFrame;
    p48.EventFrame.Visible = EventLibrary.IS_ACTIVE and EventLibrary.SHOP_ENTRIES_OVERVIEW and #EventLibrary.SHOP_ENTRIES_OVERVIEW > 0;

    for i, v in pairs(EventLibrary.IS_ACTIVE and (EventLibrary.SHOP_ENTRIES_OVERVIEW and EventLibrary.SHOP_ENTRIES_OVERVIEW) or {}) do
        local Frame = Instance.new("Frame");
        Frame.BackgroundTransparency = 1;
        Frame.Size = UDim2.new(1, 0, 1, 0);
        Frame.LayoutOrder = i;
        Frame.ZIndex = -i;
        Frame.Name = v;
        Frame.Parent = p48.EventFrame;
    end;
end;

function u2._Init(u49) -- Line: 343
    -- upvalues: Spotlight (copy), PlayerDataController (copy), ButtonEffect (copy)
    u49.CarouselButtonsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 344
        -- upvalues: u49 (copy)
        u49:_UpdateCarouselButtonsBackground();
    end);
    u49.RedirectDailyButton.MouseButton1Click:Connect(function() -- Line: 348
        -- upvalues: u49 (copy)
        u49.Pages.Shop:SetPage("Daily");
    end);
    u49.RedirectWeaponsButton.MouseButton1Click:Connect(function() -- Line: 352
        -- upvalues: u49 (copy)
        u49.Pages.Shop:SetPage("Weapons");
    end);
    u49.RedirectKeysButton.MouseButton1Click:Connect(function() -- Line: 356
        -- upvalues: u49 (copy)
        u49.Pages.Shop:SetPage("Currency");
    end);
    u49.BattlePassContainer.MouseButton1Click:Connect(function() -- Line: 360
        -- upvalues: u49 (copy)
        u49.Pages.Shop:SetPage("BattlePass");
    end);
    u49.VideoAdRewards.PlayedAd:Connect(function() -- Line: 364
        -- upvalues: u49 (copy)
        u49:PauseCarousel(25);
    end);
    u49.BattlePassContainer.MouseEnter:Connect(function() -- Line: 368
        -- upvalues: u49 (copy), Spotlight (ref)
        u49.BattlePassIsHoveringFrame.Visible = true;
        u49.BattlePassNotHoveringFrame.Visible = false;
        Spotlight:ChangeSubject(u49.BattlePassContainer);
    end);
    u49.BattlePassContainer.MouseLeave:Connect(function() -- Line: 374
        -- upvalues: u49 (copy), Spotlight (ref)
        u49.BattlePassIsHoveringFrame.Visible = false;
        u49.BattlePassNotHoveringFrame.Visible = true;
        Spotlight:ChangeSubject(nil, u49.BattlePassContainer);
    end);
    PlayerDataController:GetDataChangedSignal("CosmeticInventory"):Connect(function() -- Line: 380
        -- upvalues: u49 (copy)
        u49:_UpdateShopSlots();
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 384
        -- upvalues: u49 (copy)
        u49:_UpdateShopSlots();
    end);
    PlayerDataController:GetDataChangedSignal("Seasons"):Connect(function() -- Line: 388
        -- upvalues: u49 (copy)
        u49:_UpdateSeasonPassVisuals();
    end);
    u49:_Setup();
    u49:_UpdateSeasonPassVisuals();
    u49:_UpdateCarouselButtonsBackground();
    ButtonEffect:Add(u49.RedirectKeysButton);
    ButtonEffect:Add(u49.RedirectDailyButton);
    ButtonEffect:Add(u49.RedirectWeaponsButton);
    ButtonEffect:Add(u49.BattlePassContainer, nil, {
        HoverRatio = 1.01,
        ReleaseRatio = 1.01
    });
end;

return u2;