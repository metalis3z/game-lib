-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AdService = game:GetService("AdService");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers.MonetizationController);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local MatchmakingCountdown = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.MatchmakingCountdown);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local BillboardVideoAdsGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BillboardVideoAdsGui");
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 23
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3._spin_these = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 37
    -- upvalues: Players (copy)
    local v6 = {};

    for i in pairs(p4._spin_these) do
        if i:IsDescendantOf(workspace) or i:IsDescendantOf(Players.LocalPlayer.PlayerGui) then
            i.Rotation = i.Rotation + 15 * p5;
        else
            v6[i] = true;
        end;
    end;

    for i in pairs(v6) do
        p4._spin_these[i] = nil;
    end;
end;

function u1._BoardAdded(p7, p8) -- Line: 58
    -- upvalues: BillboardVideoAdsGui (copy), PlayerDataController (copy), MonetizationLibrary (copy), FighterController (copy), MatchmakingCountdown (copy), AdService (copy), RewardSlot (copy), Pages (copy), ReplicatedStorage (copy), ButtonEffect (copy), CosmeticLibrary (copy), ComplianceController (copy), MonetizationController (copy), Players (copy)
    local u9 = BillboardVideoAdsGui:Clone();
    p7._spin_these[u9.MainFrame.Background.CanvasGroup.Keys.ImageLabel] = true;
    p7._spin_these[u9.MainFrame.Background.CanvasGroup.Wraps.ImageLabel] = true;
    local u10 = 0;
    local u11 = nil;
    local u12 = false;

    local function update_visuals() -- Line: 70
        -- upvalues: PlayerDataController (ref), MonetizationLibrary (ref), u9 (copy)
        local v13 = PlayerDataController:Get("BillboardVideoAdProgress");
        local NumVideoAdsForBillboardReward = MonetizationLibrary:GetNumVideoAdsForBillboardReward(PlayerDataController:Get("BillboardVideoAdClaimedToday"));
        u9.MainFrame.Play.Title.Text = string.format("%s<font size=\"8\"> /%s</font>", v13, NumVideoAdsForBillboardReward);
    end;

    PlayerDataController:GetDataChangedSignal("BillboardVideoAdClaimedToday"):Connect(update_visuals);
    PlayerDataController:GetDataChangedSignal("BillboardVideoAdProgress"):Connect(update_visuals);
    local v14 = PlayerDataController:Get("BillboardVideoAdProgress");
    local NumVideoAdsForBillboardReward = MonetizationLibrary:GetNumVideoAdsForBillboardReward(PlayerDataController:Get("BillboardVideoAdClaimedToday"));
    u9.MainFrame.Play.Title.Text = string.format("%s<font size=\"8\"> /%s</font>", v14, NumVideoAdsForBillboardReward);

    local function can_fetch_ads() -- Line: 81
        -- upvalues: FighterController (ref), MatchmakingCountdown (ref), PlayerDataController (ref), MonetizationLibrary (ref)
        local v15 = FighterController.LocalFighter and not FighterController.LocalFighter:Get("IsInDuel") and not (FighterController.LocalFighter:Get("IsInShootingRange") or MatchmakingCountdown:IsVisible()) and PlayerDataController:Get("BillboardVideoAdClaimedToday") < MonetizationLibrary.MAX_BILLBOARD_VIDEO_ADS_PER_DAY;

        return v15;
    end;

    local function update() -- Line: 89
        -- upvalues: u10 (ref), u11 (ref), u9 (copy), can_fetch_ads (copy), u12 (ref), AdService (ref), PlayerDataController (ref), RewardSlot (ref), MonetizationLibrary (ref)
        u10 = u10 + 1;
        local v16 = u10;

        if u11 then
            u11:Destroy();
            u11 = nil;
        end;

        u9.MainFrame.Visible = false;
        u9.KeyBundle.Visible = true;

        if not can_fetch_ads() then
            return;
        end;

        if not u12 then
            local success, result = pcall(AdService.GetAdAvailabilityNowAsync, AdService, Enum.AdFormat.RewardedVideo);
            wait(0.5);

            if v16 ~= u10 then
                return;
            end;

            if success then
                success = result.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable;
            end;

            u12 = success;
        end;

        local v17 = PlayerDataController:Get("BillboardVideoAdClaimedToday") == 0;
        u9.MainFrame.Visible = u12;
        u9.KeyBundle.Visible = not u12;
        u9.MainFrame.Background.CanvasGroup.Keys.Visible = v17;
        u9.MainFrame.Background.CanvasGroup.Wraps.Visible = not v17;

        if u12 then
            local v18;

            if v17 then
                v18 = MonetizationLibrary.BILLBOARD_KEYS_REWARD_DATA;
            else
                v18 = MonetizationLibrary.BILLBOARD_WRAPS_REWARD_DATA;
            end;

            u11 = RewardSlot.new(v18);
            u11:ZoomOutViewportFrame();
            u11:UseHighResolutionImage();
            u11:HideBackground();
            u11:HideWeaponVisual();
            u11:SetInteractable(false);
            u11:SetParent(u9.MainFrame.Reward);
        end;
    end;

    MatchmakingCountdown.VisibilityChanged:Connect(update);
    task.spawn(function() -- Line: 142, Name: hook_local_fighter
        -- upvalues: FighterController (ref), update (copy)
        local v19 = FighterController:WaitForLocalFighter();
        v19:GetDataChangedSignal("IsInDuel"):Connect(update);
        v19:GetDataChangedSignal("IsInShootingRange"):Connect(update);
        update();
    end);
    PlayerDataController:GetDataChangedSignal("BillboardVideoAdClaimedToday"):Connect(function() -- Line: 152
        -- upvalues: update (copy), u11 (ref)
        wait(1);
        update();
        wait(1);

        if not u11 then
            update();
        end;
    end);
    task.spawn(function() -- Line: 164
        -- upvalues: update (copy)
        update();
        wait(2);

        while true do
            update();
            wait(15);
        end;
    end);
    u9.MainFrame.Button.MouseButton1Click:Connect(function() -- Line: 175
        -- upvalues: Pages (ref), ReplicatedStorage (ref), AdService (ref), u12 (ref), update (copy)
        if Pages.PageSystem.CurrentPage then
            return;
        end;

        task.spawn(function() -- Line: 180
            -- upvalues: ReplicatedStorage (ref), AdService (ref)
            if not ReplicatedStorage.Remotes.Misc.PlayVideoAdBillboard:InvokeServer() then
                pcall(AdService.GetAdAvailabilityNowAsync, AdService, Enum.AdFormat.RewardedVideo);
                ReplicatedStorage.Remotes.Misc.PlayVideoAdBillboard:InvokeServer();
            end;
        end);
        u12 = false;
        task.delay(2, function() -- Line: 191
            -- upvalues: u12 (ref), update (ref)
            u12 = false;
            update();
        end);
    end);
    ButtonEffect:Add(u9.MainFrame.Button, true);
    local keybundle_2 = MonetizationLibrary.Bundles.keybundle_2;
    local KeyBundle = u9.KeyBundle;
    KeyBundle.Title.Text = keybundle_2.DisplayName;

    for i, v in pairs(keybundle_2.Rewards) do
        local v20 = CosmeticLibrary.Rewards[v.Name];

        if not (v20 and (v20.Type == "Lootbox" and ComplianceController:ArePaidRandomItemsRestricted())) then
            local v21 = RewardSlot.new(v);
            v21.Frame.LayoutOrder = i;
            v21:SetParent(KeyBundle.Rewards);
            v21:OnClick(function() -- Line: 218
                -- upvalues: Pages (ref)
                if Pages.PageSystem.CurrentPage then
                    return;
                end;

                Pages.PageSystem:OpenPage("Shop");
                Pages.PageSystem:WaitForPage("Shop"):SetPage("Currency");
                Pages.PageSystem:WaitForPage("Shop"):InspectBundle("keybundle_2");
            end);
        end;
    end;

    KeyBundle.Button.MouseButton1Click:Connect(function() -- Line: 229
        -- upvalues: Pages (ref), MonetizationController (ref), keybundle_2 (copy)
        if Pages.PageSystem.CurrentPage then
            return;
        end;

        MonetizationController:PromptProductPurchase(keybundle_2.ProductID);
    end);
    MonetizationController:SetRobuxText(KeyBundle.Button.Title, keybundle_2.ProductID, Enum.InfoType.Product);
    ButtonEffect:Add(KeyBundle.Button);
    u9.Adornee = p8;
    u9.Parent = Players.LocalPlayer.PlayerGui;
end;

function u1._Init(u22) -- Line: 245
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbyBillboardVideoAds"):Connect(function(p23) -- Line: 246
        -- upvalues: u22 (copy)
        u22:_BoardAdded(p23);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyBillboardVideoAds")) do
        task.defer(u22._BoardAdded, u22, v);
    end;
end;

return u1._new();