-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local CurrencyLibrary = require(ReplicatedStorage.Modules.CurrencyLibrary);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers.MonetizationController);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local Spotlight = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Spotlight);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local Bundles = Players.LocalPlayer.PlayerScripts.UserInterface.Bundles;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 26
    -- upvalues: u1 (copy), Signal (copy), MonetizationLibrary (copy), Bundles (copy)
    local v3 = setmetatable({}, u1);
    v3.Tapped = Signal.new();
    v3.AvailabilityChanged = Signal.new();
    v3.OwnedChanged = Signal.new();
    v3.Name = p2;
    v3.Info = MonetizationLibrary.Bundles[v3.Name];
    v3.Frame = Bundles[p2]:Clone();
    v3._connections = {};
    v3._is_currency_bundle = v3.Info.Type == "Currency";
    v3._is_gamepass_bundle = v3.Info.Type == "Gamepass";
    v3._is_purchaseable_callback = nil;
    v3._is_spotlighting_inputs_enabled = true;
    v3._is_always_spotlighted = false;
    v3._superstarterbundle_loop_hash = 0;
    v3._is_owned = false;
    v3._is_robux_button_hidden = false;
    v3:_Init();

    return v3;
end;

function u1.IsAvailableToPurchase(p4) -- Line: 56
    -- upvalues: PlayerDataController (copy)
    if p4._is_gamepass_bundle then
        return not PlayerDataController:Get("GamepassBundlesClaimed")[p4.Info.GamepassName];
    end;

    if p4.Name == "superstarter_bundle" then
        return p4:_IsSuperStarterBundleAvailable();
    end;

    if p4.Name == "contrabandseason_bundle" then
        return not p4:_IsContrabandSeasonBundleOwned();
    end;

    return p4.Name ~= "primeseason_bundle" and true or not p4:_IsPrimeSeasonBundleOwned();
end;

function u1.IsAlreadyOwned(p5) -- Line: 70
    return p5._is_owned;
end;

function u1.GetAssetIDForRobuxText(p6) -- Line: 74
    -- upvalues: MonetizationLibrary (copy)
    return p6._is_gamepass_bundle and MonetizationLibrary.Gamepasses[p6.Info.GamepassName].GamepassID or p6.Info.ProductID;
end;

function u1.GetInfoTypeForRobuxText(p7) -- Line: 78
    return p7._is_gamepass_bundle and Enum.InfoType.GamePass or Enum.InfoType.Product;
end;

function u1.SetParent(p8, p9) -- Line: 82
    p8.Frame.Parent = p9;
end;

function u1.SetIsOwned(p10, p11) -- Line: 86
    p10._is_owned = p11;
    p10.OwnedChanged:Fire();
    p10:_UpdateOwned();
end;

function u1.SetAlwaysSpotlighted(p12, p13) -- Line: 92
    p12._is_always_spotlighted = p13;
    p12:_SetSpotlightStatus(false);
end;

function u1.SetSpotlightingInputsEnabled(p14, p15) -- Line: 97
    p14._is_spotlighting_inputs_enabled = p15;
    p14:_SetSpotlightStatus(false);
end;

function u1.HideRobuxButton(p16) -- Line: 102
    p16._is_robux_button_hidden = true;
    p16:_UpdateOwned();
end;

function u1.StartLoops(u17) -- Line: 107
    if u17._update_superstarterbundle then
        task.spawn(function() -- Line: 109
            -- upvalues: u17 (copy)
            local v18 = u17;
            v18._superstarterbundle_loop_hash = v18._superstarterbundle_loop_hash + 1;

            while u17._superstarterbundle_loop_hash == u17._superstarterbundle_loop_hash do
                u17._update_superstarterbundle();
                wait(1);
            end;
        end);
    end;
end;

function u1.StopLoops(p19) -- Line: 121
    p19._superstarterbundle_loop_hash = p19._superstarterbundle_loop_hash + 1;
end;

function u1.PurchaseRequest(p20) -- Line: 125
    -- upvalues: MonetizationController (copy), MonetizationLibrary (copy)
    if not p20:IsAvailableToPurchase() then
        return;
    end;

    if p20._is_gamepass_bundle then
        MonetizationController:PromptGamePassPurchase(MonetizationLibrary.Gamepasses[p20.Info.GamepassName].GamepassID);

        return;
    end;

    MonetizationController:PromptProductPurchase(p20.Info.ProductID);
end;

function u1.Destroy(p21) -- Line: 137
    for _, v in pairs(p21._connections) do
        v:Disconnect();
    end;

    p21:StopLoops();
    p21.Tapped:Destroy();
    p21.AvailabilityChanged:Destroy();
    p21.OwnedChanged:Destroy();
    p21.Frame:Destroy();
end;

function u1._UpdateOwned(p22) -- Line: 155
    p22.Frame.Container.Button.Visible = not p22._is_robux_button_hidden and not p22._is_owned;

    if p22.Frame.Container:FindFirstChild("Claimed") then
        p22.Frame.Container.Claimed.Visible = not p22._is_robux_button_hidden and p22._is_owned;
    end;
end;

function u1._GetSuperStarterBundleTimeRemaining(p23) -- Line: 163
    -- upvalues: MonetizationLibrary (copy), ServerOsTime (copy), PlayerDataController (copy)
    local v24 = MonetizationLibrary.SUPER_STARTER_BUNDLE_OFFER_DURATION - (ServerOsTime:GetRounded() - PlayerDataController:Get("SuperStarterBundleStartTime"));

    return math.max(0, v24);
end;

function u1._IsSuperStarterBundleOwned(p25) -- Line: 167
    -- upvalues: PlayerDataController (copy)
    return PlayerDataController:Get("SuperStarterBundlePurchased");
end;

function u1._IsSuperStarterBundleAvailable(p26) -- Line: 171
    local v27;

    if p26:_GetSuperStarterBundleTimeRemaining() > 0 then
        v27 = not p26:_IsSuperStarterBundleOwned();
    else
        v27 = false;
    end;

    return v27;
end;

function u1._IsPrimeSeasonBundleOwned(p28) -- Line: 175
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy)
    local v29 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v29 then
        v29 = v29.BattlePass;
    end;

    return (v29 and v29.MaxPassTrackNum or 0) >= 2;
end;

function u1._IsContrabandSeasonBundleOwned(p30) -- Line: 183
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy)
    local v31 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v31 then
        v31 = v31.BattlePass;
    end;

    if v31 then
        v31 = v31.SeasonPassBundleOwned;
    end;

    return v31;
end;

function u1._SetSpotlightStatus(p32, p33) -- Line: 190
    -- upvalues: Spotlight (copy)
    if p32._is_spotlighting_inputs_enabled and p33 then
        Spotlight:ChangeSubject(p32.Frame.Container.Background);
    else
        Spotlight:ChangeSubject(nil, p32.Frame.Container.Background);
    end;

    if p33 or p32._is_always_spotlighted then
        p32.Frame.Container.Icon.ImageColor3 = Color3.fromRGB(32, 32, 32);
        p32.Frame.Container.Icon.ImageTransparency = 0.75;
        p32.Frame.Container.Rewards.Visible = true;
        p32.Frame.Container.Button.BubbleContainer.Visible = false;

        return;
    end;

    p32.Frame.Container.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255);
    p32.Frame.Container.Icon.ImageTransparency = 0.25;
    p32.Frame.Container.Rewards.Visible = false;
    p32.Frame.Container.Button.BubbleContainer.Visible = true;
end;

function u1._SetupStandardWeaponsBundle(p34) -- Line: 212
    -- upvalues: MonetizationLibrary (copy), ShopLibrary (copy), RewardSlot (copy), ControlsController (copy)
    for i, v in pairs(MonetizationLibrary:GetStandardWeaponBundleWeapons()) do
        local v35 = not ShopLibrary:IsWeaponReleased(v);
        local v36 = RewardSlot.new({
            Name = v
        });
        v36.Frame.LayoutOrder = -#ShopLibrary.OwnableWeaponsAlphabetized + i + (v35 and -999999999 or 0);
        v36:SetInteractable(ControlsController.CurrentControls ~= "Touch");
        v36:SetParent(p34.Frame.Container.Rewards);

        if v35 then
            v36:SetNameText("???");
            v36:LockedImage();
        end;
    end;
end;

function u1._SetupCurrencyVisuals(u37) -- Line: 228
    -- upvalues: Utility (copy), EventLibrary (copy), CurrencyLibrary (copy)
    u37.Frame.Container.Value.Text = "+ " .. Utility:PrettyNumber(u37.Info.Rewards[1].Quantity);
    u37.Frame.Container.Rewards:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 231, Name: update
        -- upvalues: u37 (copy)
        u37.Frame.Container.Value.Visible = not u37.Frame.Container.Rewards.Visible;
    end);
    u37.Frame.Container.Value.Visible = not u37.Frame.Container.Rewards.Visible;

    if string.sub(u37.Name, 14) == "eventcurrency_" then
        local string_sub_ret = string.sub(15);
        local v38 = tonumber(string_sub_ret);
        u37.Frame.Container.Icon.Image = EventLibrary.EVENT_DETAILS.BUNDLE_BACKGROUND_IMAGES[v38] or EventLibrary.EVENT_DETAILS.BUNDLE_BACKGROUND_IMAGES[1];
        u37.Frame.Container.Background.ImageColor3 = CurrencyLibrary.Info.EventCurrency.Color;
    end;
end;

function u1._SetupGamepassVisuals(u39) -- Line: 248
    -- upvalues: PlayerDataController (copy)
    local function update() -- Line: 249
        -- upvalues: u39 (copy), PlayerDataController (ref)
        u39:SetIsOwned(PlayerDataController:Get("GamepassBundlesClaimed")[u39.Info.GamepassName]);
        u39.AvailabilityChanged:Fire();
    end;

    local _connections = u39._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("GamepassBundlesClaimed");
    table.insert(_connections, DataChangedSignal:Connect(update));
    u39:SetIsOwned(PlayerDataController:Get("GamepassBundlesClaimed")[u39.Info.GamepassName]);
    u39.AvailabilityChanged:Fire();
end;

function u1._SetupContrabandSeasonBundle(u40) -- Line: 258
    -- upvalues: PlayerDataController (copy)
    local _connections = u40._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("Seasons");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 259, Name: update
        -- upvalues: u40 (copy)
        u40:SetIsOwned(u40:_IsContrabandSeasonBundleOwned());
        u40.AvailabilityChanged:Fire();
    end));
    u40:SetIsOwned(u40:_IsContrabandSeasonBundleOwned());
    u40.AvailabilityChanged:Fire();
end;

function u1._SetupPrimeSeasonBundle(u41) -- Line: 268
    -- upvalues: PlayerDataController (copy)
    local _connections = u41._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("Seasons");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 269, Name: update
        -- upvalues: u41 (copy)
        u41:SetIsOwned(u41:_IsPrimeSeasonBundleOwned());
        u41.AvailabilityChanged:Fire();
    end));
    u41:SetIsOwned(u41:_IsPrimeSeasonBundleOwned());
    u41.AvailabilityChanged:Fire();
end;

function u1._SetupSuperStarterBundle(u42) -- Line: 278
    -- upvalues: Utility (copy), PlayerDataController (copy)
    function u42._update_superstarterbundle() -- Line: 279
        -- upvalues: u42 (copy), Utility (ref)
        local v43 = u42:_GetSuperStarterBundleTimeRemaining();
        u42.Frame.Container.Countdown.Title.Text = v43 <= 0 and "This offer is no longer available" or "Offer ends in " .. Utility:TimeFormat2(v43);
        u42:SetIsOwned(u42:_IsSuperStarterBundleOwned());
        u42.AvailabilityChanged:Fire();
    end;

    local _connections = u42._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("SuperStarterBundlePurchased");
    table.insert(_connections, DataChangedSignal:Connect(u42._update_superstarterbundle));
    u42._update_superstarterbundle();

    local function v44() -- Line: 291
        -- upvalues: u42 (copy)
        u42.Frame.Container.Countdown.Background.Size = UDim2.new(1.125, u42.Frame.Container.Countdown.Title.TextBounds.X, 1, 0);
        u42.Frame.Container.Countdown.Title.Icon.Position = UDim2.new(1, -u42.Frame.Container.Countdown.Title.TextBounds.X, 0.5, 0);
    end;

    u42.Frame.Container.Countdown.Title:GetPropertyChangedSignal("TextBounds"):Connect(v44);
    v44();
    u42:SetAlwaysSpotlighted(true);
end;

function u1._SetupRewards(p45) -- Line: 302
    -- upvalues: CosmeticLibrary (copy), ComplianceController (copy), RewardSlot (copy), ControlsController (copy)
    for i, v in pairs(p45.Info.Rewards) do
        local v46 = CosmeticLibrary.Rewards[v.Name];

        if not (v46 and (v46.Type == "Lootbox" and ComplianceController:ArePaidRandomItemsRestricted())) then
            local v47 = RewardSlot.new(v);
            v47.Frame.LayoutOrder = i;
            v47:SetInteractable(ControlsController.CurrentControls ~= "Touch");
            v47:SetParent(p45.Frame.Container.Rewards);
        end;
    end;
end;

function u1._Setup(p48) -- Line: 317
    -- upvalues: MonetizationController (copy)
    p48.Frame.Container.Title.Text = p48.Info.DisplayName;
    p48.Frame.Container.Button.BubbleContainer.Bubble.Title.RichText = true;
    p48.Frame.Container.Button.BubbleContainer.Bubble.Title.Text = p48.Info.BubbleText or "";
    p48.Frame.Container.Button.BubbleContainer.Bubble.Visible = p48.Frame.Container.Button.BubbleContainer.Bubble.Title.Text ~= "";
    MonetizationController:SetRobuxText(p48.Frame.Container.Button.Title, p48:GetAssetIDForRobuxText(), p48:GetInfoTypeForRobuxText());
    p48:_SetupRewards();
    p48:_SetSpotlightStatus(false);

    if p48._is_currency_bundle then
        p48:_SetupCurrencyVisuals();
    end;

    if p48._is_gamepass_bundle then
        p48:_SetupGamepassVisuals();
    end;

    if p48.Name == "standardweapons_bundle" then
        p48:_SetupStandardWeaponsBundle();

        return;
    end;

    if p48.Name == "contrabandseason_bundle" then
        p48:_SetupContrabandSeasonBundle();

        return;
    end;

    if p48.Name == "primeseason_bundle" then
        p48:_SetupPrimeSeasonBundle();

        return;
    end;

    if p48.Name == "superstarter_bundle" then
        p48:_SetupSuperStarterBundle();
    end;
end;

function u1._Init(u49) -- Line: 347
    -- upvalues: ButtonEffect (copy)
    u49.Frame.Container.MouseButton1Click:Connect(function() -- Line: 348
        -- upvalues: u49 (copy)
        u49.Tapped:Fire();
    end);
    u49.Frame.Container.MouseEnter:Connect(function() -- Line: 352
        -- upvalues: u49 (copy)
        u49:_SetSpotlightStatus(true);
    end);
    u49.Frame.Container.MouseLeave:Connect(function() -- Line: 356
        -- upvalues: u49 (copy)
        u49:_SetSpotlightStatus(false);
    end);
    u49:_Setup();
    u49:_UpdateOwned();
    ButtonEffect:Add(u49.Frame.Container, nil, {
        HoverRatio = 1.025,
        ReleaseRatio = 1.025
    });
end;

return u1;