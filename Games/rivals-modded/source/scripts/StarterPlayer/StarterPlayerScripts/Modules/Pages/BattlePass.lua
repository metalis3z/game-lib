-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local SeasonController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SeasonController"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local BundleSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BundleSlot"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local BattlePassFooterSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BattlePassFooterSlot");
local BattlePassRewardSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BattlePassRewardSlot");
local BattlePassTrackSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BattlePassTrackSlot");
local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 36
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy), BundleSlot (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("TopRight"):WaitForChild("Close");
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.BackgroundFrame = v3.PageFrame:WaitForChild("Background");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.RewardsFrame = v3.Container:WaitForChild("Rewards");
    v3.TracksFrame = v3.RewardsFrame:WaitForChild("Tracks");
    v3.FooterFrame = v3.TracksFrame:WaitForChild("Footer");
    v3.FooterBackground = v3.FooterFrame:WaitForChild("Background");
    v3.FooterSlotsFrame = v3.FooterFrame:WaitForChild("Slots");
    v3.FooterSlotsLayout = v3.FooterSlotsFrame:WaitForChild("Layout");
    v3.HeaderFrame = v3.TracksFrame:WaitForChild("Header");
    v3.HeaderContainer = v3.HeaderFrame:WaitForChild("Container");
    v3.HeaderLevelText = v3.HeaderContainer:WaitForChild("Value");
    v3.HeaderXPFrame = v3.HeaderContainer:WaitForChild("XP");
    v3.HeaderXPBarFrame = v3.HeaderXPFrame:WaitForChild("Bar");
    v3.HeaderNextLevelText = v3.HeaderXPBarFrame:WaitForChild("NextLevel");
    v3.HeaderXPBarContainer = v3.HeaderXPBarFrame:WaitForChild("Container");
    v3.HeaderBubbleFrame = v3.HeaderContainer:WaitForChild("Bubble");
    v3.HeaderBubbleArrow = v3.HeaderBubbleFrame:WaitForChild("Arrow");
    v3.HeaderBubbleTitle = v3.HeaderBubbleFrame:WaitForChild("Title");
    v3.HeaderBubbleBackground = v3.HeaderBubbleFrame:WaitForChild("Background");
    v3.NextButton = v3.HeaderContainer:WaitForChild("Next");
    v3.NextBackground = v3.NextButton:WaitForChild("Background");
    v3.NextIcon = v3.NextButton:WaitForChild("Icon");
    v3.PreviousButton = v3.HeaderContainer:WaitForChild("Previous");
    v3.PreviousBackground = v3.PreviousButton:WaitForChild("Background");
    v3.PreviousIcon = v3.PreviousButton:WaitForChild("Icon");
    v3.PreviewFrame = v3.Container:WaitForChild("Preview");
    v3.PreviewContainer = v3.PreviewFrame:WaitForChild("Container");
    v3.PreviewRewardContainer = v3.PreviewContainer:WaitForChild("RewardContainer");
    v3.PreviewDetailsFrame = v3.PreviewFrame:WaitForChild("Details");
    v3.PreviewDetailsClaimed = v3.PreviewDetailsFrame:WaitForChild("Claimed");
    v3.PreviewDetailsTitle = v3.PreviewDetailsFrame:WaitForChild("Title");
    v3.PreviewDetailsDescription = v3.PreviewDetailsFrame:WaitForChild("Description");
    v3.PreviewUnlockFrame = v3.PreviewFrame:WaitForChild("Unlock");
    v3.PreviewUnlockContainer = v3.PreviewUnlockFrame:WaitForChild("Container");
    v3.PreviewUnlockDetailsFrame = v3.PreviewUnlockContainer:WaitForChild("Details");
    v3.PreviewUnlockTiersText = v3.PreviewUnlockDetailsFrame:WaitForChild("Tiers");
    v3.PreviewUnlockTitleText = v3.PreviewUnlockDetailsFrame:WaitForChild("Title");
    v3.PreviewUnlockButtonFrame = v3.PreviewUnlockContainer:WaitForChild("Buy");
    v3.PreviewUnlockButton = v3.PreviewUnlockButtonFrame:WaitForChild("Button");
    v3.PreviewUnlockButtonTitle = v3.PreviewUnlockButton:WaitForChild("Title");
    v3.PreviewUnlockViewContentsFrame = v3.PreviewUnlockContainer:WaitForChild("ViewContents");
    v3.PreviewUnlockViewContentsButton = v3.PreviewUnlockViewContentsFrame:WaitForChild("Button");
    v3.PreviewUnlockClaimFrame = v3.PreviewUnlockContainer:WaitForChild("Claim");
    v3.PreviewUnlockClaimButton = v3.PreviewUnlockClaimFrame:WaitForChild("Button");
    v3.BundlesFrame = v3.Container:WaitForChild("Bundles");
    v3.PrimeSeasonBundleFrame = v3.BundlesFrame:WaitForChild("primeseason_bundle");
    v3.ContrabandSeasonBundleFrame = v3.BundlesFrame:WaitForChild("contrabandseason_bundle");
    v3.EndingSoonFrame = v3.Container:WaitForChild("EndingSoon");
    v3.EndingSoonTitle = v3.EndingSoonFrame:WaitForChild("Title");
    v3.HidePartyDisplay = true;
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3.PrimeSeasonBundleSlot = BundleSlot.new("primeseason_bundle");
    v3.ContrabandSeasonBundleSlot = BundleSlot.new("contrabandseason_bundle");
    v3._open_animation_disabled = true;
    v3._current_page = 1;
    v3._footer_slots = {};
    v3._track_slots = {};
    v3._xp_slots = {};
    v3._reward_slots = {};
    v3._preview_data = nil;
    v3._scroll_delta = 0;
    v3._refreshed_input_tags = false;
    v3._completed_all_tasks_thread = nil;
    v3:_Init();

    return v3;
end;

function u1.InspectBundle(p4, p5) -- Line: 118
    p4.PromptSystem:Open("InspectBundle", p5);
end;

function u1.UnlockNow(p6) -- Line: 122
    -- upvalues: MonetizationController (copy)
    if not p6._preview_data then
        return;
    end;

    local v7 = p6:_GetUnlockNowProductInfo(p6._preview_data.Tier, p6._preview_data.PassTrackNum);

    if v7 then
        MonetizationController:PromptProductPurchase(v7.ProductID);
    end;
end;

function u1.Preview(p8, p9, p10) -- Line: 134
    -- upvalues: SeasonLibrary (copy), WeaponStatusHandler (copy), TweenService (copy), TweenInfo_new_ret (copy), ItemLibrary (copy), PlayerDataController (copy), RewardSlot (copy), Utility (copy), CosmeticLibrary (copy), MonetizationController (copy)
    local v11 = SeasonLibrary.CurrentSeason.BattlePassRewards[p9] and SeasonLibrary.CurrentSeason.BattlePassRewards[p9][p10];

    if p8._preview_data and p8._preview_data.RewardSlot then
        p8._preview_data.RewardSlot:Destroy();
        p8._preview_data.RewardSlot = nil;
    end;

    p8._preview_data = nil;
    p8.PreviewDetailsTitle.Text = "";
    p8.PreviewDetailsDescription.Text = "";
    WeaponStatusHandler:ClearStatusElements(p8.PreviewDetailsTitle);
    WeaponStatusHandler:ClearStatusElements(p8.PreviewDetailsDescription);
    WeaponStatusHandler:ClearStatusElements(p8.PreviewUnlockTiersText);
    TweenService:Create(p8.BackgroundFrame, TweenInfo_new_ret, {
        BackgroundColor3 = (ItemLibrary.StatusByPassTrackNum[p10] or ItemLibrary.Statuses.Standard).Color
    }):Play();
    TweenService:Create(p8.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        CanvasPosition = Vector2.zero
    }):Play();

    if not (v11 and (p9 and p10)) then
        p8.PreviewFrame.Visible = false;
        p8.PreviewFrame.Size = UDim2.new(1, 0, 0, 0);

        return;
    end;

    task.defer(p8._SetPage, p8, (math.ceil(p9 / 7)));
    p8._preview_data = {
        RewardSlot = nil,
        RewardData = v11,
        Tier = p9,
        PassTrackNum = p10
    };
    local v12 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v12 then
        v12 = v12.BattlePass;
    end;

    local v13 = v12 and (v12.MaxPassTrackNum or 0) or 0;
    local v14;

    if p9 <= (v12 and (v12.PassLevel or 0) or 0) then
        v14 = p10 <= v13;
    else
        v14 = false;
    end;

    local v15 = v12 and v12.RewardsClaimed[tostring(p9)] and v12.RewardsClaimed[tostring(p9)][tostring(p10)];
    local v16 = p8:_GetUnlockNowProductInfo(p9, p10);
    local v17 = RewardSlot.new(v11);
    v17:ZoomOutViewportFrame();
    v17:UseHighResolutionImage();
    v17:HideBackground();
    v17:HideWeaponVisual();
    v17:SetNameText("");
    v17:SetInteractable(false);
    v17.Frame.Parent = p8.PreviewRewardContainer;
    p8._preview_data.RewardSlot = v17;
    p8.PreviewDetailsClaimed.Visible = v15;
    p8.PreviewDetailsTitle.Text = v17:GetRewardBubbleTitle();
    p8.PreviewDetailsDescription.Text = v17:GetRewardBubbleDescription();

    if ItemLibrary.Items[v11.Name] then
        local Status = ItemLibrary.Items[v11.Name].Status;
        WeaponStatusHandler:ApplyItemStatusToText(p8.PreviewDetailsTitle, Status);
        WeaponStatusHandler:ApplyItemStatusToText(p8.PreviewDetailsDescription, Status);
    elseif ItemLibrary.Items[v11.Weapon] then
        WeaponStatusHandler:ApplyItemStatusToText(p8.PreviewDetailsDescription, ItemLibrary.Items[v11.Weapon] and ItemLibrary.Items[v11.Weapon].Status);
    end;

    if v14 then
        v14 = not v15;
    end;

    p8.PreviewUnlockClaimFrame.Visible = v14;
    local v18;

    if v16 then
        v18 = not v15;
    else
        v18 = v16;
    end;

    p8.PreviewUnlockButtonFrame.Visible = v18;
    local PreviewUnlockTiersText = p8.PreviewUnlockTiersText;
    local v19;

    if v16 and v16.BattlePassLevelIncrement then
        v19 = string.format("+%s Level%s", Utility:PrettyNumber(v16.BattlePassLevelIncrement), v16.BattlePassLevelIncrement == 1 and "" or "s");
    else
        v19 = not (v16 and (v16.BattlePassMaxPassTrackNum and v16.UnlockNowDisplayName)) and "" or v16.UnlockNowDisplayName;
    end;

    PreviewUnlockTiersText.Text = v19;
    p8.PreviewUnlockTitleText.Visible = p8.PreviewUnlockTiersText.Text ~= "";
    p8.PreviewUnlockViewContentsFrame.Visible = CosmeticLibrary.Rewards[v11.Name] and CosmeticLibrary.Rewards[v11.Name].Type == "Lootbox";

    if v16 then
        MonetizationController:SetRobuxText(p8.PreviewUnlockButtonTitle, v16.ProductID, Enum.InfoType.Product);

        if v16.BattlePassMaxPassTrackNum and v16.UnlockNowWeaponStatusUIEffect then
            WeaponStatusHandler:ApplyItemStatusToText(p8.PreviewUnlockTiersText, v16.UnlockNowWeaponStatusUIEffect);
        end;
    end;

    local v20 = v15 and 0.2 or 0;
    p8.PreviewDetailsTitle.Position = UDim2.new(0.5 + v20, 0, 0.775, 0);
    p8.PreviewDetailsDescription.Position = UDim2.new(0.5 + v20, 0, 0.9, 0);
    v17.Frame.Position = UDim2.new(0.5, 0, 0.75, 0);
    p8.PreviewDetailsTitle:TweenPosition(UDim2.new(0.15 + v20, 0, 0.775, 0), "Out", "Quint", 0.5, true);
    p8.PreviewDetailsDescription:TweenPosition(UDim2.new(0.15 + v20, 0, 0.9, 0), "Out", "Quint", 0.625, true);
    v17.Frame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.375, true);
    p8.PreviewFrame.Visible = true;
    p8.PreviewFrame:TweenSize(UDim2.new(1, 0, 0.3, 0), "Out", "Quint", 0.25, true);
end;

function u1.Open(u21, ...) -- Line: 230
    -- upvalues: Page (copy), PlayerDataController (copy), UserInputService (copy), SeasonLibrary (copy)
    Page.Open(u21, ...);
    local _open_connections = u21._open_connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("Seasons");
    table.insert(_open_connections, DataChangedSignal:Connect(function() -- Line: 233
        -- upvalues: u21 (copy)
        u21:_Update();

        if u21._preview_data then
            u21:Preview(u21._preview_data.Tier, u21._preview_data.PassTrackNum);
        end;
    end));
    table.insert(u21._open_connections, UserInputService.InputBegan:Connect(function(p22, p23) -- Line: 241
        -- upvalues: u21 (copy)
        if p23 then
            return;
        end;

        if p22.KeyCode == Enum.KeyCode.ButtonL1 then
            u21:_SetPage(u21._current_page - 1);

            return;
        end;

        if p22.KeyCode == Enum.KeyCode.ButtonR1 then
            u21:_SetPage(u21._current_page + 1);
        end;
    end));
    table.insert(u21._open_connections, UserInputService.InputChanged:Connect(function(p24, p25) -- Line: 253
    end));
    table.insert(u21._open_threads, task.spawn(function() -- Line: 268
        -- upvalues: u21 (copy)
        while true do
            u21:_UpdateEndingSoon();
            wait(1);
        end;
    end));

    if not u21._refreshed_input_tags then
        u21._refreshed_input_tags = true;

        for _, v in pairs({ u21.NextButton, u21.PreviousButton }) do
            local Inputs = v:WaitForChild("Inputs");
            Inputs.Parent = nil;
            Inputs.Parent = v;
        end;
    end;

    u21.PrimeSeasonBundleSlot.Frame.Position = UDim2.new(0.5, 0, 4, 0);
    u21.ContrabandSeasonBundleSlot.Frame.Position = UDim2.new(0.5, 0, 4, 0);
    u21.PrimeSeasonBundleSlot.Frame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 1, true);
    u21.ContrabandSeasonBundleSlot.Frame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 1.5, true);
    local v26 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v26 then
        v26 = v26.BattlePass;
    end;

    local math_ceil_ret = math.ceil((v26 and v26.PassLevel or 0) / 7);
    u21:Preview(nil);
    u21:_SetPage(math_ceil_ret);
    u21:_Update();
end;

function u1.Close(p27, ...) -- Line: 300
    -- upvalues: Page (copy)
    p27:_Clear();
    Page.Close(p27, ...);
end;

function u1._UpdateEndingSoon(p28) -- Line: 309
    -- upvalues: SeasonController (copy)
    p28.EndingSoonFrame.Visible = SeasonController:GetTimeRemaining() ~= nil;
    p28.EndingSoonTitle.Text = (SeasonController:GetCountdownText() or "") .. " — Complete the Season Pass and collect your rewards before they\'re gone forever!";
end;

function u1._UpdateVisuals(p29) -- Line: 314
    local v30 = p29.HeaderXPBarContainer.AbsolutePosition.X + p29.HeaderXPBarContainer.AbsoluteSize.X - p29.HeaderBubbleFrame.AbsolutePosition.X;
    local math_abs_ret = math.abs(v30);
    local v31 = math.min(math_abs_ret, p29.HeaderBubbleFrame.AbsoluteSize.X / 2 - p29.HeaderBubbleArrow.AbsoluteSize.X - 8) * math.sign(v30);
    p29.HeaderBubbleArrow.Position = UDim2.new(0, v31, 1, -2);
    p29.HeaderBubbleBackground.Size = UDim2.new(0.05, p29.HeaderBubbleTitle.TextBounds.X, 1, 0);
    p29.List.CanvasSize = UDim2.new(0, 0, 0, p29.Layout.AbsoluteContentSize.Y);
    p29.FooterBackground.Size = UDim2.new(0, (p29.FooterSlotsLayout.AbsoluteContentSize.X + p29.FooterSlotsLayout.Padding.Scale * p29.FooterSlotsFrame.AbsoluteSize.X) * 1.00878, 1, 0);
end;

function u1._UpdateListVisibility(p32) -- Line: 324
    p32.List.Visible = not p32.PromptSystem.CurrentPrompt;
end;

function u1._GetUnlockNowProductInfo(p33, p34, p35) -- Line: 328
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy), MonetizationLibrary (copy)
    local v36 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v36 then
        v36 = v36.BattlePass;
    end;

    if (v36 and (v36.MaxPassTrackNum or 0) or 0) < p35 then
        return MonetizationLibrary.Bundles.primeseason_bundle;
    end;

    local v37 = p34 - (v36 and v36.PassLevel or 0);

    if v37 > 0 then
        for _, v in pairs(MonetizationLibrary.BATTLE_PASS_LEVELS) do
            local v38 = MonetizationLibrary.Products[v];

            if v37 <= v38.BattlePassLevelIncrement then
                return v38;
            end;
        end;

        return nil;
    end;
end;

function u1._GetMaxPage(p39) -- Line: 353
    -- upvalues: SeasonLibrary (copy)
    return math.ceil(SeasonLibrary.CurrentSeason.NumBattlePassTiers / 7);
end;

function u1._SetPage(p40, p41) -- Line: 357
    local _current_page = p40._current_page;
    local v42 = p40:_GetMaxPage();
    p40._current_page = math.clamp(p41, 1, v42);

    if _current_page == p40._current_page then
        return;
    end;

    local math_sign_ret = math.sign(p40._current_page - _current_page);

    if math_sign_ret == 0 then
        math_sign_ret = nil;
    end;

    p40:_Update(math_sign_ret);
end;

function u1._Clear(p43) -- Line: 372
    for _, v in pairs(p43._reward_slots) do
        v:Destroy();
    end;

    for _, v in pairs(p43._track_slots) do
        v:Destroy();
    end;

    for _, v in pairs(p43._footer_slots) do
        v:Destroy();
    end;

    for _, v in pairs(p43._xp_slots) do
        v:Destroy();
    end;

    p43._reward_slots = {};
    p43._track_slots = {};
    p43._footer_slots = {};
    p43._xp_slots = {};

    if p43._completed_all_tasks_thread then
        task.cancel(p43._completed_all_tasks_thread);
        p43._completed_all_tasks_thread = nil;
    end;
end;

function u1._Update(u44, p45) -- Line: 404
    -- upvalues: SeasonLibrary (copy), BattlePassTrackSlot (copy), ItemLibrary (copy), PlayerDataController (copy), BattlePassFooterSlot (copy), BattlePassRewardSlot (copy), RewardSlot (copy), CosmeticLibrary (copy), Utility (copy)
    u44:_Clear();

    for i = 1, SeasonLibrary.CurrentSeason.NumBattlePassTracks do
        local v46 = BattlePassTrackSlot:Clone();
        v46.Side.Background.ImageColor3 = ItemLibrary.StatusByPassTrackNum[i].PassColor;
        v46.Side["Icon" .. i].Visible = true;
        v46.LayoutOrder = i;
        v46.Parent = u44.TracksFrame;
        u44._track_slots[i] = v46;
        local _ = i;
    end;

    local v47 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v47 then
        v47 = v47.BattlePass;
    end;

    local v48 = v47 and (v47.PassLevel or 0) or 0;
    local v49 = v47 and (v47.MaxPassTrackNum or 0) or 0;
    u44.HeaderLevelText.Text = v48;
    u44.HeaderNextLevelText.Text = "Level " .. v48 + 1;
    local v50 = false;

    for i = 1, 7 do
        local u51 = (u44._current_page - 1) * 7 + i;
        local v52;

        if SeasonLibrary.CurrentSeason.NumBattlePassTiers < u51 then
            v52 = i;
        else
            local v53 = u51 <= v48;
            local v54 = BattlePassFooterSlot:Clone();
            v54.Tier.Text = u51;
            v54.LayoutOrder = i;
            v54.Bar.BackgroundColor3 = v53 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 255, 255);
            v54.Bar.BackgroundTransparency = v53 and 0 or 0.75;
            v54.Parent = u44.FooterSlotsFrame;
            table.insert(u44._footer_slots, v54);
            v52 = i;

            for i2 = 1, SeasonLibrary.CurrentSeason.NumBattlePassTracks do
                local v55 = SeasonLibrary.CurrentSeason.BattlePassRewards[u51] and SeasonLibrary.CurrentSeason.BattlePassRewards[u51][i2];
                local v56 = ItemLibrary.StatusByPassTrackNum[i2];
                local v57 = v47 and v47.RewardsClaimed[tostring(u51)] and v47.RewardsClaimed[tostring(u51)][tostring(i2)];
                local v58;

                if v57 then
                    v58 = v57;
                elseif v53 then
                    v58 = i2 <= v49;
                else
                    v58 = v53;
                end;

                local v59 = BattlePassRewardSlot:Clone();
                v59.Container.Claimed.Visible = v58;
                v59.Container.Unclaimed.Visible = not v58;
                v59.Container.Unclaimed.Status.ImageColor3 = v56.PassColor;
                v59.Container.Unclaimed.Background.ImageColor3 = v56.DarkPassColor;
                v59.Container.Claimed.Status.ImageColor3 = v56.DarkPassColor;
                v59.Container.Claimed.Claimed.Visible = v57 and v55;
                v59.Container.Claimed.Background.ImageColor3 = v56.DarkPassColor;
                v59.Container.Claimed.Container.GroupTransparency = v57 and 0.75 or 0;
                local v60;

                if v55 then
                    v60 = not v57;
                else
                    v60 = v55;
                end;

                v59.Container.Claimed.ClaimNowBubble.Visible = v60;
                v59.LayoutOrder = v52;
                v59.Parent = u44._track_slots[i2];

                if v55 then
                    local v61 = RewardSlot.new(v55);
                    v61.Frame.Parent = v58 and v59.Container.Claimed.Container or v59.Container.Unclaimed.Container;
                    table.insert(u44._reward_slots, v61);
                    v61:OnClick(function() -- Line: 466
                        -- upvalues: u44 (copy), u51 (copy), i2 (copy)
                        u44:Preview(u51, i2);
                    end);

                    if (v55.Quantity or 1) == 1 and not (CosmeticLibrary.Cosmetics[v55.Name] or (ItemLibrary.Items[v55.Name] or CosmeticLibrary.Rewards[v55.Name] and CosmeticLibrary.Rewards[v55.Name].Type == "Currency")) then
                        v61:SetNameText("");
                    end;
                end;

                if p45 then
                    local v62 = (v52 + i2 - 1) / 7;

                    if p45 < 0 then
                        v62 = 1 - v62;
                    end;

                    v59.Container.Position = UDim2.new(0.5 + 0.5 * p45, 0, 0.5, 0);
                    v59.Container:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", v62 * 0.5 + 0.25, true);
                end;

                local v63;

                if v50 or (i2 ~= 1 or not v55) then
                    v63 = i2;
                else
                    v63 = i2;
                    v50 = true;
                end;
            end;
        end;
    end;

    local v64 = v47 and (v47.NumPassTasksCompleted or 0) or 0;
    local u65 = v47 and v47.PassTaskProgress and (v47.PassTaskProgress.RoundsWon or 0) or 0;
    local u66 = v47 and (v47.PassTaskProgress and v47.PassTaskProgress.Playtime) or 0;
    local u67 = SeasonLibrary:GetCurrentSeasonWeek() * SeasonLibrary.CurrentSeason.BattlePassTasksPerWeek <= v64;
    local math_max_ret = math.max(u65 / SeasonLibrary.CurrentSeason.BattlePassTaskRequirements.RoundsWon, u66 / SeasonLibrary.CurrentSeason.BattlePassTaskRequirements.Playtime);
    u44.HeaderXPBarContainer.Size = UDim2.new(math.clamp(math_max_ret, 0, 1), 0, 1, 0);

    local function update_bubble_title() -- Line: 507
        -- upvalues: u67 (copy), u44 (copy), Utility (ref), SeasonLibrary (ref), u66 (copy), u65 (copy)
        if not u67 then
            local string_format_ret = string.format("%.1f", u66 / 60);
            u44.HeaderBubbleTitle.Text = string.format("Win (<font transparency=\"0\" weight=\"800\">%s</font> / %s) rounds in duels or play for (<font transparency=\"0\" weight=\"800\">%s</font> / %s) minutes to level up", u65, SeasonLibrary.CurrentSeason.BattlePassTaskRequirements.RoundsWon, string_format_ret == "0.0" and "0" or string_format_ret, string.format("%.0f", SeasonLibrary.CurrentSeason.BattlePassTaskRequirements.Playtime / 60));

            return;
        end;

        local HeaderBubbleTitle = u44.HeaderBubbleTitle;
        local string_format = string.format;
        local TimeUntilNextSeasonWeek = SeasonLibrary:GetTimeUntilNextSeasonWeek();
        HeaderBubbleTitle.Text = string_format("All done! You can level up again in <font transparency=\"0\" weight=\"800\">%s</font>", Utility:TimeFormat2((math.ceil(TimeUntilNextSeasonWeek))));
    end;

    update_bubble_title();

    if u67 then
        u44._completed_all_tasks_thread = task.spawn(function() -- Line: 526
            -- upvalues: update_bubble_title (copy)
            while true do
                wait(1);
                update_bubble_title();
            end;
        end);
    end;

    local v68 = u44._current_page < u44:_GetMaxPage();
    local v69 = u44._current_page > 1;
    u44.NextBackground.BackgroundTransparency = v68 and 0 or 0.75;
    u44.NextIcon.ImageTransparency = v68 and 0 or 0.75;
    u44.PreviousBackground.BackgroundTransparency = v69 and 0 or 0.75;
    u44.PreviousIcon.ImageTransparency = v69 and 0 or 0.75;
end;

function u1._Setup(p70) -- Line: 543
    p70.PrimeSeasonBundleSlot:SetParent(p70.PrimeSeasonBundleFrame);
    p70.ContrabandSeasonBundleSlot:SetParent(p70.ContrabandSeasonBundleFrame);
end;

function u1._Init(u71) -- Line: 548
    -- upvalues: ReplicatedStorage (copy), ControlsController (copy), ButtonEffect (copy)
    u71.CloseButton.MouseButton1Click:Connect(function() -- Line: 549
        -- upvalues: u71 (copy)
        u71:CloseRequest();
    end);
    u71.PromptSystem.PromptAdded:Connect(function() -- Line: 553
        -- upvalues: u71 (copy)
        u71:_UpdateListVisibility();
    end);
    u71.PromptSystem.PromptRemoved:Connect(function() -- Line: 557
        -- upvalues: u71 (copy)
        u71:_UpdateListVisibility();
    end);
    u71.NextButton.MouseButton1Click:Connect(function() -- Line: 561
        -- upvalues: u71 (copy)
        u71:_SetPage(u71._current_page + 1);
    end);
    u71.PreviousButton.MouseButton1Click:Connect(function() -- Line: 565
        -- upvalues: u71 (copy)
        u71:_SetPage(u71._current_page - 1);
    end);
    u71.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 569
        -- upvalues: u71 (copy)
        u71:_UpdateVisuals();
    end);
    u71.FooterSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 573
        -- upvalues: u71 (copy)
        u71:_UpdateVisuals();
    end);
    u71.HeaderBubbleTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 577
        -- upvalues: u71 (copy)
        u71:_UpdateVisuals();
    end);
    u71.HeaderXPBarContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 581
        -- upvalues: u71 (copy)
        u71:_UpdateVisuals();
    end);
    u71.HeaderXPBarContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 585
        -- upvalues: u71 (copy)
        u71:_UpdateVisuals();
    end);
    u71.HeaderBubbleFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 589
        -- upvalues: u71 (copy)
        u71:_UpdateVisuals();
    end);
    u71.HeaderBubbleFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 593
        -- upvalues: u71 (copy)
        u71:_UpdateVisuals();
    end);
    u71.HeaderBubbleArrow:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 597
        -- upvalues: u71 (copy)
        u71:_UpdateVisuals();
    end);
    u71.PreviewUnlockClaimButton.MouseButton1Click:Connect(function() -- Line: 601
        -- upvalues: ReplicatedStorage (ref), u71 (copy)
        ReplicatedStorage.Remotes.Data.ClaimBattlePassReward:FireServer(u71._preview_data.Tier, u71._preview_data.PassTrackNum);
    end);
    u71.PreviewUnlockButton.MouseButton1Click:Connect(function() -- Line: 605
        -- upvalues: u71 (copy)
        u71:UnlockNow();
    end);
    u71.PreviewUnlockViewContentsButton.MouseButton1Click:Connect(function() -- Line: 609
        -- upvalues: u71 (copy)
        u71.PromptSystem:Open("InspectLootbox", u71._preview_data.RewardData.Name, u71._preview_data.RewardData.Weapon);
    end);
    u71.PrimeSeasonBundleSlot.Tapped:Connect(function() -- Line: 613
        -- upvalues: ControlsController (ref), u71 (copy)
        if ControlsController.CurrentControls == "Touch" then
            u71:InspectBundle(u71.PrimeSeasonBundleSlot.Name);

            return;
        end;

        u71.PrimeSeasonBundleSlot:PurchaseRequest();
    end);
    u71.ContrabandSeasonBundleSlot.Tapped:Connect(function() -- Line: 622
        -- upvalues: ControlsController (ref), u71 (copy)
        if ControlsController.CurrentControls == "Touch" then
            u71:InspectBundle(u71.ContrabandSeasonBundleSlot.Name);

            return;
        end;

        u71.ContrabandSeasonBundleSlot:PurchaseRequest();
    end);
    u71:_Setup();
    u71:_UpdateVisuals();
    ButtonEffect:Add(u71.CloseButton);
    ButtonEffect:Add(u71.NextButton);
    ButtonEffect:Add(u71.PreviousButton);
    ButtonEffect:Add(u71.PreviewUnlockButton);
    ButtonEffect:Add(u71.PreviewUnlockClaimButton);
    ButtonEffect:Add(u71.PreviewUnlockViewContentsButton);
end;

return u1._new();