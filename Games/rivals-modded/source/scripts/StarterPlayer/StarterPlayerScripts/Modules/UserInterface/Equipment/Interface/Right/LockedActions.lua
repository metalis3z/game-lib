-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AdService = game:GetService("AdService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ScavengerHuntLibrary = require(ReplicatedStorage.Modules.ScavengerHuntLibrary);
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local CurrencyLibrary = require(ReplicatedStorage.Modules.CurrencyLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 22
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Right = p2;
    v3.Frame = v3.Right.Container:WaitForChild("LockedActions");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.TryWeaponFrame = v3.Container:WaitForChild("TryWeapon");
    v3.TryWeaponButton = v3.TryWeaponFrame:WaitForChild("Button");
    v3.SpecialOfferFrame = v3.Container:WaitForChild("SpecialOffer");
    v3.SpecialOfferDescription = v3.SpecialOfferFrame:WaitForChild("Description");
    v3.SpecialOfferCountdown = v3.SpecialOfferFrame:WaitForChild("Countdown");
    v3.SpecialOfferButton = v3.SpecialOfferFrame:WaitForChild("Button");
    v3.SpecialOfferButtonLockedFrame = v3.SpecialOfferButton:WaitForChild("Locked");
    v3.SpecialOfferButtonUnlockedFrame = v3.SpecialOfferButton:WaitForChild("Unlocked");
    v3.BuyFrame = v3.Container:WaitForChild("Buy");
    v3.BuyDescription = v3.BuyFrame:WaitForChild("Description");
    v3.BuyCountdown = v3.BuyFrame:WaitForChild("Countdown");
    v3.BuyButton = v3.BuyFrame:WaitForChild("Button");
    v3.BuyButtonLockedFrame = v3.BuyButton:WaitForChild("Locked");
    v3.BuyButtonFreeFrame = v3.BuyButton:WaitForChild("Free");
    v3.BuyButtonKeysFrame = v3.BuyButton:WaitForChild("Keys");
    v3.BuyButtonKeysPrice = v3.BuyButtonKeysFrame:WaitForChild("Price");
    v3.BuyButtonKeysPriceIconOutline = v3.BuyButtonKeysPrice:WaitForChild("Icon");
    v3.BuyButtonKeysPriceIcon = v3.BuyButtonKeysPriceIconOutline:WaitForChild("ImageLabel");
    v3.ScavengerFrame = v3.Container:WaitForChild("Scavenger");
    v3.ScavengerTitle = v3.ScavengerFrame:WaitForChild("Title");
    v3.ScavengerProgress = v3.ScavengerFrame:WaitForChild("Progress");
    v3.ScavengerIcon = v3.ScavengerFrame:WaitForChild("Icon");
    v3.ScavengerButton = v3.ScavengerFrame:WaitForChild("Button");
    v3.FreeTrialFrame = v3.Container:WaitForChild("FreeTrial");
    v3.FreeTrialReadyFrame = v3.FreeTrialFrame:WaitForChild("Ready");
    v3.FreeTrialNotReadyFrame = v3.FreeTrialFrame:WaitForChild("NotReady");
    v3.FreeTrialWaitingFrame = v3.FreeTrialNotReadyFrame:WaitForChild("Waiting");
    v3.FreeTrialWaitingDotsFrame = v3.FreeTrialWaitingFrame:WaitForChild("Dots");
    v3.FreeTrialUnavailable = v3.FreeTrialNotReadyFrame:WaitForChild("Unavailable");
    v3.FreeTrialButton = v3.FreeTrialNotReadyFrame:WaitForChild("Button");
    v3.FreeTrialButtonTitle = v3.FreeTrialButton:WaitForChild("Title");
    v3.FreeTrialButtonIcon = v3.FreeTrialButtonTitle:WaitForChild("Icon");
    v3._update_information_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.OnStateChanged(p4) -- Line: 73
    p4:_UpdateInformation();
end;

function u1._InteractSpecialOffer(p5) -- Line: 81
    -- upvalues: SeasonLibrary (copy), MonetizationLibrary (copy), Pages (copy)
    local SelectedWeapon = p5.Right.Interface.Equipment:GetSelectedWeapon();
    local RewardSeasonPassPosition, v6 = SeasonLibrary:GetRewardSeasonPassPosition(SelectedWeapon);
    local u7 = p5.SpecialOfferDescription.Text == "Early access!" and "standardweapons_bundle" or MonetizationLibrary:GetBundleContainingReward(SelectedWeapon);

    if RewardSeasonPassPosition and v6 then
        Pages.PageSystem:OpenPage("BattlePass", true);
        Pages.PageSystem:WaitForPage("BattlePass"):Preview(RewardSeasonPassPosition, v6);

        return;
    end;

    if u7 ~= "contrabandseason_bundle" and u7 ~= "primeseason_bundle" then
        if u7 then
            Pages.PageSystem:OpenPage("Shop", true);
            Pages.PageSystem:WaitForPage("Shop"):SetPage("Bundles");
            task.delay(0.1, function() -- Line: 96
                -- upvalues: Pages (ref), u7 (copy)
                Pages.PageSystem:WaitForPage("Shop"):InspectBundle(u7);
            end);
        end;

        return;
    end;

    Pages.PageSystem:OpenPage("BattlePass", true);
    Pages.PageSystem:WaitForPage("BattlePass"):InspectBundle(u7);
end;

function u1._UpdateInformation(u8) -- Line: 102
    -- upvalues: PlayerDataController (copy), ShopLibrary (copy), MonetizationLibrary (copy), SeasonLibrary (copy), CONSTANTS (copy), ScavengerHuntLibrary (copy), ServerOsTime (copy), Utility (copy), AdService (copy)
    u8._update_information_hash = u8._update_information_hash + 1;
    local _update_information_hash = u8._update_information_hash;
    local SelectedWeapon = u8.Right.Interface.Equipment:GetSelectedWeapon();
    local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);
    local v9;

    if SelectedWeapon then
        v9 = not WeaponData;
    else
        v9 = SelectedWeapon;
    end;

    u8.Frame.Visible = v9;

    if not v9 then
        u8.FreeTrialWaitingDotsFrame:RemoveTag("UILoadingDots");

        return;
    end;

    local WeaponKeyPriceInfo, _, v10, _ = ShopLibrary:GetWeaponKeyPriceInfo(SelectedWeapon, PlayerDataController:Get("UnlockTokens"), PlayerDataController:Get("FreeWeaponUnlockCheck"));
    local BundleContainingReward = MonetizationLibrary:GetBundleContainingReward(SelectedWeapon);
    local RewardSeasonPassPosition, _ = SeasonLibrary:GetRewardSeasonPassPosition(SelectedWeapon);
    local TimeUntilWeaponRelease = ShopLibrary:GetTimeUntilWeaponRelease(SelectedWeapon);
    local v11 = not v10 and TimeUntilWeaponRelease > 0;
    local v12;

    if v11 then
        v12 = TimeUntilWeaponRelease <= CONSTANTS.WEAPON_REVEAL_TIME_OFFSET;
    else
        v12 = v11;
    end;

    local v13;

    if v12 then
        v13 = TimeUntilWeaponRelease <= CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET;
    else
        v13 = v12;
    end;

    local v14 = ScavengerHuntLibrary.InfoByWeapon[SelectedWeapon];
    local NumVideoAdsForFreeWeaponTrial = MonetizationLibrary:GetNumVideoAdsForFreeWeaponTrial(SelectedWeapon);
    local u15 = (PlayerDataController:Get("FreeWeaponTrialsRemaining")[SelectedWeapon] or 0) > 0;
    local u16;

    if u15 then
        u16 = u15;
    elseif NumVideoAdsForFreeWeaponTrial then
        u16 = PlayerDataController:Get("NumFreeWeaponTrialsFromVideoAdsToday") < MonetizationLibrary.MAX_FREE_WEAPON_TRIALS_PER_DAY;
    else
        u16 = NumVideoAdsForFreeWeaponTrial;
    end;

    local v17 = BundleContainingReward ~= "superstarter_bundle" and true or ServerOsTime:GetRounded() - PlayerDataController:Get("SuperStarterBundleStartTime") < MonetizationLibrary.SUPER_STARTER_BUNDLE_OFFER_DURATION;
    u8.BuyFrame.Visible = v13 or WeaponKeyPriceInfo < (1 / 0);
    u8.BuyButtonLockedFrame.Visible = v11;
    u8.BuyButtonFreeFrame.Visible = not v11 and WeaponKeyPriceInfo <= 0;
    u8.BuyButtonKeysFrame.Visible = not v11 and WeaponKeyPriceInfo > 0;
    u8.BuyButtonKeysPrice.Text = v11 and "" or Utility:PrettyNumber(WeaponKeyPriceInfo);
    local BuyDescription = u8.BuyDescription;
    local v18;

    if v11 then
        v18 = UDim2.new(0.175, 0, 0.35, 0);
    else
        v18 = UDim2.new(0.175, 0, 0.5, 0);
    end;

    BuyDescription.Position = v18;
    u8.BuyDescription.Text = v11 and "Coming soon!" or "Unlock now!";
    u8.BuyCountdown.Text = not v11 and "" or "in " .. Utility:TimeFormat2(TimeUntilWeaponRelease, 2);
    u8.SpecialOfferFrame.Visible = not v10 and (BundleContainingReward and v17 and v17 or (v12 or RewardSeasonPassPosition));
    local v19;

    if v12 then
        v19 = not v13;
    else
        v19 = v12;
    end;

    u8.SpecialOfferButtonLockedFrame.Visible = v19;
    u8.SpecialOfferButtonUnlockedFrame.Visible = not v12 or v13;
    local SpecialOfferDescription = u8.SpecialOfferDescription;
    local v20;

    if v12 and not v13 then
        v20 = UDim2.new(0.175, 0, 0.35, 0);
    else
        v20 = UDim2.new(0.175, 0, 0.5, 0);
    end;

    SpecialOfferDescription.Position = v20;
    u8.SpecialOfferDescription.Text = v12 and "Early access!" or "Special offer!";
    u8.SpecialOfferCountdown.Text = (not v12 or v13) and "" or "in " .. Utility:TimeFormat2(TimeUntilWeaponRelease - CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET, 2);
    local TryWeaponFrame = u8.TryWeaponFrame;
    local v21 = not (v10 or v11) and table.find(ShopLibrary.OwnableWeapons, SelectedWeapon);
    TryWeaponFrame.Visible = v21;
    u8.ScavengerFrame.Visible = v14 ~= nil;
    u8.ScavengerTitle.Text = not v14 and "" or (v14.NumObjects == 1 and v14.ObjectsName or v14.ObjectsNamePlural);
    u8.ScavengerProgress.Text = not v14 and "" or string.format("%s / %s", #(PlayerDataController:Get("ScavengerHunts")[v14.Name] or {}), v14.NumObjects);
    u8.ScavengerIcon.Image = not v14 and "" or v14.ObjectsImage;
    u8.FreeTrialFrame.Visible = u16;
    u8.FreeTrialReadyFrame.Visible = u15;
    u8.FreeTrialNotReadyFrame.Visible = not u15;
    u8.FreeTrialButtonTitle.Text = string.format("%s <font size=\"8\">/ %s</font>", PlayerDataController:Get("FreeWeaponTrialsProgressFromVideoAds")[SelectedWeapon] or 0, NumVideoAdsForFreeWeaponTrial or -1);
    u8.FreeTrialButton.Visible = false;
    u8.FreeTrialUnavailable.Visible = false;
    u8.FreeTrialWaitingFrame.Visible = true;
    u8.FreeTrialWaitingDotsFrame:AddTag("UILoadingDots");
    task.spawn(function() -- Line: 164
        -- upvalues: u16 (copy), u15 (copy), AdService (ref), _update_information_hash (copy), u8 (copy)
        if not u16 or u15 then
            return;
        end;

        local success, result = pcall(AdService.GetAdAvailabilityNowAsync, AdService, Enum.AdFormat.RewardedVideo);
        wait(1);

        if _update_information_hash ~= u8._update_information_hash then
            return;
        end;

        if success then
            success = result.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable;
        end;

        u8.FreeTrialButton.Visible = success;
        u8.FreeTrialUnavailable.Visible = not success;
        u8.FreeTrialWaitingFrame.Visible = false;
        u8.FreeTrialWaitingDotsFrame:RemoveTag("UILoadingDots");
    end);
end;

function u1._Update(p22) -- Line: 186
    p22.Frame.Size = UDim2.new(1, 0, 0, p22.Layout.AbsoluteContentSize.Y);
    p22.BuyButtonKeysPrice.Position = UDim2.new(0.5, -p22.BuyButtonKeysPriceIconOutline.AbsoluteSize.X / 2, 0.5, 0);
    p22.BuyButtonKeysPriceIconOutline.Position = UDim2.new(0.5, p22.BuyButtonKeysPrice.TextBounds.X / 2, 0.5, 0);
    p22.FreeTrialButtonIcon.Position = UDim2.new(0.5, -p22.FreeTrialButtonTitle.TextBounds.X / 2, 0.5, 0);
end;

function u1._Setup(p23) -- Line: 193
    -- upvalues: CurrencyLibrary (copy)
    p23.BuyButtonKeysPriceIconOutline.Image = CurrencyLibrary.Info.WeaponKeys.ImageFlatOutline;
    p23.BuyButtonKeysPriceIcon.Image = CurrencyLibrary.Info.WeaponKeys.ImageFlat;
end;

function u1._Init(u24) -- Line: 198
    -- upvalues: ReplicatedStorage (copy), PlayerDataController (copy), ButtonEffect (copy)
    u24.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 199
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    u24.BuyButtonKeysPrice:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 203
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    u24.BuyButtonKeysPriceIconOutline:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 207
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    u24.BuyButton.MouseButton1Click:Connect(function() -- Line: 211
        -- upvalues: u24 (copy)
        u24.Right.Interface.Equipment:UnlockWeapon();
    end);
    u24.TryWeaponButton.MouseButton1Click:Connect(function() -- Line: 215
        -- upvalues: u24 (copy)
        u24.Right.Interface.Equipment:TryWeapon();
    end);
    u24.SpecialOfferButton.MouseButton1Click:Connect(function() -- Line: 219
        -- upvalues: u24 (copy)
        u24:_InteractSpecialOffer();
    end);
    u24.FreeTrialButton.MouseButton1Click:Connect(function() -- Line: 223
        -- upvalues: u24 (copy), ReplicatedStorage (ref)
        local SelectedWeapon = u24.Right.Interface.Equipment:GetSelectedWeapon();
        ReplicatedStorage.Remotes.Misc.PlayVideoAdWeaponTrial:FireServer(SelectedWeapon);
    end);
    u24.FreeTrialUnavailable.MouseButton1Click:Connect(function() -- Line: 228
        -- upvalues: u24 (copy)
        u24:_UpdateInformation();
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 232
        -- upvalues: u24 (copy)
        u24:_UpdateInformation();
    end);
    PlayerDataController:GetDataChangedSignal("UnlockTokens"):Connect(function() -- Line: 236
        -- upvalues: u24 (copy)
        u24:_UpdateInformation();
    end);
    PlayerDataController:GetDataChangedSignal("FreeWeaponUnlockCheck"):Connect(function() -- Line: 240
        -- upvalues: u24 (copy)
        u24:_UpdateInformation();
    end);
    PlayerDataController:GetDataChangedSignal("ScavengerHunts"):Connect(function() -- Line: 244
        -- upvalues: u24 (copy)
        u24:_UpdateInformation();
    end);
    PlayerDataController:GetDataChangedSignal("FreeWeaponTrialsRemaining"):Connect(function() -- Line: 248
        -- upvalues: u24 (copy)
        u24:_UpdateInformation();
    end);
    PlayerDataController:GetDataChangedSignal("FreeWeaponTrialsProgressFromVideoAds"):Connect(function() -- Line: 252
        -- upvalues: u24 (copy)
        u24:_UpdateInformation();
    end);
    PlayerDataController:GetDataChangedSignal("NumFreeWeaponTrialsFromVideoAdsToday"):Connect(function() -- Line: 256
        -- upvalues: u24 (copy)
        u24:_UpdateInformation();
    end);
    u24:_Setup();
    u24:_Update();
    ButtonEffect:Add(u24.BuyButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u24.TryWeaponButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u24.SpecialOfferButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u24.FreeTrialButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u24.FreeTrialUnavailable, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u24.ScavengerButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
end;

return u1;