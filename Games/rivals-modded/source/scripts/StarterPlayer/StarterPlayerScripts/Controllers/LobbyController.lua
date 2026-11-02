-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ExperienceNotificationService = game:GetService("ExperienceNotificationService");
local AvatarEditorService = game:GetService("AvatarEditorService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local TestLibrary = require(ReplicatedStorage.Modules.TestLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ShootingRangeController = require(Players.LocalPlayer.PlayerScripts.Controllers.ShootingRangeController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers.DuelController);
local TestAttribute = TestLibrary:GetTestAttribute("StudioSkipOnboarding");
local LobbyElements = Players.LocalPlayer.PlayerScripts.Modules.LobbyElements;
local u1 = { "StarterBundleBoards", "LeaderboardDisplays", "EliminationsDisplays", "DuelsDisplays", "DuelsGarageDoor", "LikeBoards", "LooseWeaponDisplays", "Miscellaneous", "DuelsSign", "RotatingBundleDisplay", "WeaponReleaseSchedule", "ToyTrainPaths", "Teleporters", "DailyShopSkinHolograms", "LobbyPortals", "LobbyAnimations", "UpdateCountdowns", "TopPlayerRewards", "ProximityPageOpeners", "BillboardVideoAdBoards", "OnlyAppearWhens" };
local u2 = {};
u2.__index = u2;

function u2._new() -- Line: 33
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3.LocalFighter = nil;
    v3.Elements = {};
    v3._renderstep_connection = nil;
    v3._textures_deleted = false;
    v3._attempted_to_favorite = false;
    v3:_Init();

    return v3;
end;

function u2.ToDuels(p4) -- Line: 52
    -- upvalues: FighterController (copy), ShootingRangeController (copy), CollectionService (copy)
    if FighterController.LocalFighter and FighterController.LocalFighter:Get("IsInShootingRange") then
        ShootingRangeController:Leave(true);

        return;
    end;

    if FighterController.LocalFighter and (not FighterController.LocalFighter:Get("IsInDuel") and FighterController.LocalFighter:IsAlive()) then
        FighterController.LocalFighter.Entity.Model:PivotTo(CollectionService:GetTagged("LobbyDuels")[1].CFrame);
    end;
end;

function u2._RemoveSuperStarterBundleHolograms(p5) -- Line: 64
    -- upvalues: ServerOsTime (copy), PlayerDataController (copy), MonetizationLibrary (copy), CollectionService (copy)
    local v6;

    if ServerOsTime:Get() < PlayerDataController:Get("SuperStarterBundleStartTime") + MonetizationLibrary.SUPER_STARTER_BUNDLE_OFFER_DURATION then
        v6 = not PlayerDataController:Get("SuperStarterBundlePurchased");
    else
        v6 = false;
    end;

    if v6 then
        return;
    end;

    for _, v in pairs(CollectionService:GetTagged("LobbySuperStarterBundleHologram")) do
        task.defer(v.Destroy, v);
    end;
end;

function u2._RemoveGiftHolograms(p7) -- Line: 77
    -- upvalues: PlayerDataController (copy), CollectionService (copy)
    if not PlayerDataController:Get("ClaimedGroupReward") then
        return;
    end;

    for _, v in pairs(CollectionService:GetTagged("LobbyFreeRewardsHologram")) do
        task.defer(v.Destroy, v);
    end;
end;

function u2._PromptStuff(p8) -- Line: 87
    -- upvalues: TestAttribute (copy), DuelController (copy), Players (copy), PlayerDataController (copy), AvatarEditorService (copy), CONSTANTS (copy), ExperienceNotificationService (copy), ReplicatedStorage (copy)
    if TestAttribute then
        return;
    end;

    wait(1);

    if DuelController:GetDuel(Players.LocalPlayer) then
        return;
    end;

    local Statistic = PlayerDataController:GetStatistic("StatisticDuelsPlayed");
    local Statistic2 = PlayerDataController:GetStatistic("StatisticDuelsWon");

    if p8._attempted_to_favorite or Statistic ~= 5 and Statistic2 ~= 1 then
        if not (PlayerDataController:Get("PromptedNotificationPrompt") or Statistic < 8 and Statistic2 ~= 2) then
            local success, result = pcall(ExperienceNotificationService.CanPromptOptInAsync, ExperienceNotificationService);

            if not success then
                warn("Failed to check if user can prompt notifications:", result);

                return;
            end;

            if result then
                ReplicatedStorage.Remotes.Data.PromptedNotificationPrompt:FireServer();
                ExperienceNotificationService:PromptOptIn();
            end;
        end;

        return;
    end;

    p8._attempted_to_favorite = true;
    AvatarEditorService:PromptSetFavorite(CONSTANTS.HUB_PLACE_ID, Enum.AvatarItemType.Asset, true);
end;

function u2._UpdateEnabled(u9) -- Line: 116
    -- upvalues: RunService (copy)
    if u9._renderstep_connection then
        u9._renderstep_connection:Disconnect();
        u9._renderstep_connection = nil;
    end;

    local v10 = u9.LocalFighter and not u9.LocalFighter:Get("IsInDuel") and not u9.LocalFighter:Get("IsInShootingRange");

    for _, v in pairs(u9.Elements) do
        v:SetEnabled(v10);
    end;

    if v10 then
        u9._renderstep_connection = RunService.RenderStepped:Connect(function(p11) -- Line: 129
            -- upvalues: u9 (copy)
            for _, v in pairs(u9.Elements) do
                v:Update(p11);
            end;
        end);
    end;

    if v10 then
        task.defer(u9._PromptStuff, u9);
    end;
end;

function u2._UpdateShadows(p12) -- Line: 141
    -- upvalues: Lighting (copy), PlayerDataController (copy), CollectionService (copy), Utility (copy)
    Lighting.GlobalShadows = not PlayerDataController:GetSetting("Shadows Disabled");

    if p12._shadows_deleted or not PlayerDataController:GetSetting("Shadows Disabled") then
        return;
    end;

    p12._shadows_deleted = true;

    for _, v in pairs(CollectionService:GetTagged("LobbyFolder")) do
        Utility:DisableShadows(v);
    end;
end;

function u2._UpdateTextures(p13) -- Line: 155
    -- upvalues: PlayerDataController (copy), CollectionService (copy), Utility (copy)
    if p13._textures_deleted or not PlayerDataController:GetSetting("Textures Disabled") then
        return;
    end;

    p13._textures_deleted = true;

    for _, v in pairs(CollectionService:GetTagged("LobbyFolder")) do
        Utility:DisableTextures(v);
    end;
end;

function u2._Setup(u14) -- Line: 167
    -- upvalues: FighterController (copy), u1 (copy), LobbyElements (copy)
    u14.LocalFighter = FighterController:WaitForLocalFighter();
    u14.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 170
        -- upvalues: u14 (copy)
        u14:_UpdateEnabled();
    end);
    u14.LocalFighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 174
        -- upvalues: u14 (copy)
        u14:_UpdateEnabled();
    end);

    for _, v in pairs(u1) do
        task.defer(function() -- Line: 179
            -- upvalues: u14 (copy), LobbyElements (ref), v (copy)
            table.insert(u14.Elements, require(LobbyElements[v]));
        end);
    end;

    task.defer(u14._UpdateEnabled, u14);
end;

function u2._Init(u15) -- Line: 187
    -- upvalues: PlayerDataController (copy), CollectionService (copy), DuelController (copy)
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 188
        -- upvalues: u15 (copy)
        u15:_PromptStuff();
    end);
    PlayerDataController:GetSettingChangedSignal("Textures Disabled"):Connect(function() -- Line: 192
        -- upvalues: u15 (copy)
        u15:_UpdateTextures();
    end);
    PlayerDataController:GetSettingChangedSignal("Shadows Disabled"):Connect(function() -- Line: 196
        -- upvalues: u15 (copy)
        u15:_UpdateShadows();
    end);
    PlayerDataController:GetDataChangedSignal("SuperStarterBundlePurchased"):Connect(function() -- Line: 200
        -- upvalues: u15 (copy)
        u15:_RemoveSuperStarterBundleHolograms();
    end);
    PlayerDataController:GetDataChangedSignal("ClaimedGroupReward"):Connect(function() -- Line: 204
        -- upvalues: u15 (copy)
        u15:_RemoveGiftHolograms();
    end);
    CollectionService:GetInstanceAddedSignal("LobbyFreeRewardsHologram"):Connect(function() -- Line: 208
        -- upvalues: u15 (copy)
        u15:_RemoveGiftHolograms();
    end);
    DuelController.LocalPlayerLeftDuel:Connect(function() -- Line: 212
        -- upvalues: u15 (copy)
        u15:_PromptStuff();
    end);
    u15:_UpdateTextures();
    task.spawn(u15._Setup, u15);
    task.defer(u15._UpdateShadows, u15);
    task.defer(u15._RemoveGiftHolograms, u15);
    task.defer(u15._RemoveSuperStarterBundleHolograms, u15);
end;

return u2._new();