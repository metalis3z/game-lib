-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local LobbyController = require(Players.LocalPlayer.PlayerScripts.Controllers.LobbyController);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = { "starter_bundle", "medkit_bundle", "exogun_bundle", "heavyduty_bundle", "classic_bundle", "standardweapons_bundle", "energy_bundle", "rpg_bundle" };
local PhysicalBundles = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("PhysicalBundles");
local u2 = setmetatable({}, LobbyElement);
u2.__index = u2;

function u2._new(...) -- Line: 17
    -- upvalues: LobbyElement (copy), u2 (copy)
    local v3 = LobbyElement.new(...);
    local v4 = setmetatable(v3, u2);
    v4._bundles_pool = {};
    v4._current_index = 1;
    v4._bundle_display_model = nil;
    v4._bundle_display_pivot = nil;
    v4:_Init();

    return v4;
end;

function u2.SetIndex(p5, p6) -- Line: 34
    -- upvalues: CollectionService (copy), PhysicalBundles (copy)
    p5._current_index = #p5._bundles_pool == 0 and 1 or (p6 - 1) % #p5._bundles_pool + 1;
    p5._bundle_display_pivot = p5._bundle_display_pivot or (CollectionService:GetTagged("LobbyBundleDisplay")[1] and CollectionService:GetTagged("LobbyBundleDisplay")[1].CFrame or nil);

    if p5._bundle_display_model then
        p5._bundle_display_model:Destroy();
        p5._bundle_display_model = nil;
    end;

    local v7 = p5._bundles_pool[p5._current_index] or "keybundle_3";
    p5._bundle_display_model = PhysicalBundles:WaitForChild(v7):Clone();
    p5._bundle_display_model.PrimaryPart = p5._bundle_display_model.Prompt;
    local Prompt = p5._bundle_display_model.Prompt;
    Prompt.CFrame = Prompt.CFrame + Vector3.new(0, 2, 0);

    for _, descendant in pairs(p5._bundle_display_model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Massless = true;
        end;
    end;

    p5._bundle_display_model.Parent = workspace;

    for _, descendant in pairs(p5._bundle_display_model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Anchored = true;
        end;
    end;

    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.ActionText = "View";
    ProximityPrompt.ClickablePrompt = true;
    ProximityPrompt.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton;
    ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonX;
    ProximityPrompt.HoldDuration = 0;
    ProximityPrompt.MaxActivationDistance = 16;
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.Q;
    ProximityPrompt.ObjectText = "Special Offer";
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
    ProximityPrompt:AddTag("LobbyOpenPagePrompt");
    ProximityPrompt:SetAttribute("PageName", "Shop");
    ProximityPrompt:SetAttribute("ShopViewBundleName", v7);
    ProximityPrompt.Parent = p5._bundle_display_model.Prompt;
end;

function u2.Update(p8, p9) -- Line: 89
    if not p8._bundle_display_model then
        return;
    end;

    local v10 = tick() * 0.25;
    local v11 = math.sin(v10) ^ 30 * 1;
    local v12 = tick() * 0.1 % 6.283185307179586;
    local v13 = CFrame.new(0, v11, 0) * CFrame.Angles(0, v12, 0);
    p8._bundle_display_model:PivotTo((p8._bundle_display_pivot or CFrame.identity) * v13);
end;

function u2._UpdatePool(p14) -- Line: 105
    -- upvalues: PlayerDataController (copy), MonetizationLibrary (copy)
    for i in pairs(PlayerDataController:Get("GamepassBundlesClaimed")) do
        local v15 = MonetizationLibrary.Gamepasses[i];

        if v15 and v15.BundleName then
            local table_find_ret = table.find(p14._bundles_pool, v15.BundleName);

            if table_find_ret then
                table.remove(p14._bundles_pool, table_find_ret);
            end;
        end;
    end;

    p14:SetIndex(1);
end;

function u2._Setup(p16) -- Line: 123
    -- upvalues: u1 (copy)
    for _, v in pairs(u1) do
        local _bundles_pool = p16._bundles_pool;
        local math_random_ret = math.random(1, #p16._bundles_pool + 1);
        table.insert(_bundles_pool, math_random_ret, v);
    end;
end;

function u2._Init(u17) -- Line: 129
    -- upvalues: LobbyController (copy), PlayerDataController (copy)
    LobbyController.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 130
        -- upvalues: LobbyController (ref), u17 (copy)
        if not LobbyController.LocalFighter:Get("IsInDuel") then
            u17:SetIndex(u17._current_index + 1);
        end;
    end);
    PlayerDataController:GetDataChangedSignal("GamepassBundlesClaimed"):Connect(function() -- Line: 136
        -- upvalues: u17 (copy)
        u17:_UpdatePool();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 140
        -- upvalues: u17 (copy)
        u17:_UpdatePool();
    end);
    u17:_Setup();
    u17:_UpdatePool();
    u17:SetIndex(1);
end;

return u2._new();