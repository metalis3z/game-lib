-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GamepadService = game:GetService("GamepadService");
local RunService = game:GetService("RunService");
local StarterGui = game:GetService("StarterGui");
game:GetService("Lighting");
local Players = game:GetService("Players");
local LootLibrary = require(ReplicatedStorage.Modules.LootLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ShootingRangeController = require(Players.LocalPlayer.PlayerScripts.Controllers.ShootingRangeController);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers.MonetizationController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.MobileInputs);
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Teleporting);
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Queue);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local EquipmentState = require(script:WaitForChild("EquipmentState"));
local FloatingModel = require(script:WaitForChild("FloatingModel"));
local SpinControls = require(script:WaitForChild("SpinControls"));
local Interface = require(script:WaitForChild("Interface"));
local Camera = require(script:WaitForChild("Camera"));
local Scene = require(script:WaitForChild("Scene"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 32
    -- upvalues: u1 (copy), Signal (copy), UILibrary (copy), EquipmentState (copy), Camera (copy), Scene (copy), FloatingModel (copy), SpinControls (copy), Interface (copy)
    local v2 = setmetatable({}, u1);
    v2.Opened = Signal.new();
    v2.SelectedWeaponChanged = Signal.new();
    v2.CareerPageOpened = Signal.new();
    v2.CustomizingChanged = Signal.new();
    v2.CustomizingStateChanged = Signal.new();
    v2.CosmeticSearchChanged = Signal.new();
    v2.UnlockingChanged = Signal.new();
    v2.FinishedOpenEffect = Signal.new();
    v2.CharmAttachmentVisibleChanged = Signal.new();
    v2.Frame = UILibrary:GetTo("MainFrame", "Equipment");
    v2.IsOpen = false;
    v2.EquipmentState = EquipmentState.new(v2);
    v2.Camera = Camera.new(v2);
    v2.Scene = Scene.new(v2);
    v2.FloatingModel = FloatingModel.new(v2);
    v2.SpinControls = SpinControls.new(v2);
    v2.Interface = Interface.new(v2);
    v2._is_trying_weapon = false;
    v2._from_shop = false;
    v2._was_chat_active = true;
    v2._open_hash = 0;
    v2._on_state_changed_queued = false;
    v2._on_customizing_state_changed_queued = false;
    v2:_Init();

    return v2;
end;

function u1.IsCareerPageOpen(p3) -- Line: 70
    return p3.EquipmentState.IsCareerPageOpen;
end;

function u1.IsOpenEffectDone(p4, ...) -- Line: 74
    return p4.Camera:IsOpenEffectDone(...);
end;

function u1.IsUnlocking(p5) -- Line: 78
    return p5.Scene.UnlockModel.IsUnlocking;
end;

function u1.IsCustomizing(p6) -- Line: 82
    return p6.EquipmentState.CustomizingType ~= nil;
end;

function u1.GetStateID(p7, p8) -- Line: 86
    -- upvalues: PlayerDataController (copy)
    p7:IsCustomizing();
    local v9 = p7:IsCareerPageOpen();
    local SelectedWeapon = p7:GetSelectedWeapon();
    local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);

    return v9 and "FAKE_CAREER_STATE" or (not SelectedWeapon and "nil" or SelectedWeapon .. (p8 and (tostring(WeaponData ~= nil) or "") or ""));
end;

function u1.GetSelectedWeapon(p10) -- Line: 97
    return p10.EquipmentState.SelectedWeapon;
end;

function u1.GetSelectedCosmetic(p11) -- Line: 101
    return p11.EquipmentState.SelectedCosmetic;
end;

function u1.GetCosmeticSearchQuery(p12) -- Line: 105
    return p12.EquipmentState.CosmeticSearchQuery;
end;

function u1.GetCustomizingType(p13) -- Line: 109
    return p13.EquipmentState.CustomizingType;
end;

function u1.SetCosmeticSearchQuery(p14, ...) -- Line: 113
    return p14.EquipmentState:SetCosmeticSearchQuery(...);
end;

function u1.SelectCosmetic(p15, ...) -- Line: 117
    return p15.EquipmentState:SelectCosmetic(...);
end;

function u1.SelectWeapon(p16, ...) -- Line: 121
    return p16.EquipmentState:SelectWeapon(...);
end;

function u1.OpenCareerPage(p17, ...) -- Line: 125
    return p17.EquipmentState:OpenCareerPage(...);
end;

function u1.StartCustomizing(p18, ...) -- Line: 129
    return p18.EquipmentState:StartCustomizing(...);
end;

function u1.FavoriteWeapon(p19) -- Line: 133
    -- upvalues: ReplicatedStorage (copy)
    local SelectedWeapon = p19:GetSelectedWeapon();

    if not SelectedWeapon then
        return;
    end;

    ReplicatedStorage.Remotes.Data.FavoriteWeapon:FireServer(SelectedWeapon);
end;

function u1.LevelUpWeapon(p20) -- Line: 143
    -- upvalues: PlayerDataController (copy), LootLibrary (copy), Pages (copy), MonetizationController (copy), Utility (copy), ReplicatedStorage (copy)
    local SelectedWeapon = p20:GetSelectedWeapon();
    local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);

    if not WeaponData then
        return;
    end;

    local CostToLevelUp = LootLibrary:GetCostToLevelUp(WeaponData.Level, WeaponData.XP);

    if PlayerDataController:Get("WeaponKeys") >= CostToLevelUp then
        Utility:CreateSound("rbxassetid://18242015218", 1, 1, script, true, 6);
        ReplicatedStorage.Remotes.Data.LevelUpWeapon:FireServer(SelectedWeapon);

        return;
    end;

    Pages.PageSystem:OpenPage("Shop", true);
    Pages.PageSystem:WaitForPage("Shop"):SetPage("Currency");
    MonetizationController:PromptCurrencyBundlePurchase(CostToLevelUp, "WeaponKeys");
end;

function u1.UnlockWeapon(p21) -- Line: 164
    -- upvalues: ShopLibrary (copy), PlayerDataController (copy), Pages (copy), MonetizationController (copy), ReplicatedStorage (copy)
    local SelectedWeapon = p21:GetSelectedWeapon();
    local WeaponKeyPriceInfo, v22, v23, _ = ShopLibrary:GetWeaponKeyPriceInfo(SelectedWeapon, PlayerDataController:Get("UnlockTokens"), PlayerDataController:Get("FreeWeaponUnlockCheck"));

    if not (v23 or ShopLibrary:IsWeaponReleased(SelectedWeapon)) then
        return;
    end;

    if PlayerDataController:Get("WeaponKeys") >= WeaponKeyPriceInfo or v22 then
        p21.Scene.UnlockModel:PlayAnimation();
        ReplicatedStorage.Remotes.Data.UnlockWeapon:FireServer(SelectedWeapon);

        return;
    end;

    Pages.PageSystem:OpenPage("Shop", true);
    Pages.PageSystem:WaitForPage("Shop"):SetPage("Currency");
    MonetizationController:PromptCurrencyBundlePurchase(WeaponKeyPriceInfo, "WeaponKeys");
end;

function u1.TryWeapon(p24) -- Line: 183
    -- upvalues: ShootingRangeController (copy)
    local SelectedWeapon = p24:GetSelectedWeapon();

    if not SelectedWeapon then
        return;
    end;

    p24._is_trying_weapon = true;
    p24._from_shop = false;
    p24:Close(nil, true);
    ShootingRangeController:Enter(SelectedWeapon);
end;

function u1.Open(u25, p26, p27) -- Line: 197
    -- upvalues: CameraController (copy), RunService (copy), StarterGui (copy), GamepadService (copy)
    if not p27 and (CameraController:GetPublicState() or u25.IsOpen) then
        return;
    end;

    u25._open_hash = u25._open_hash + 1;
    u25:Close(true);
    u25._renderstep_connection = RunService.RenderStepped:Connect(function(p28) -- Line: 208
        -- upvalues: u25 (copy)
        u25:_Update(p28);
    end);
    u25._from_shop = p26;
    -- GetCore throws until the chat CoreScript registers ChatActive (never, in Studio, when the
    -- chat fails to load); that used to abort Open halfway, with the RenderStepped already bound.
    local chatOk, chatActive = pcall(StarterGui.GetCore, StarterGui, "ChatActive");
    u25._was_chat_active = chatOk and chatActive or false;
    GamepadService:EnableGamepadCursor(u25.Frame);
    pcall(StarterGui.SetCore, StarterGui, "ChatActive", false);
    u25.IsOpen = true;
    u25.Opened:Fire();
end;

function u1.Close(p29, p30, p31) -- Line: 222
    -- upvalues: GamepadService (copy), StarterGui (copy), Pages (copy)
    if not (p29.IsOpen or p30) then
        return;
    end;

    p29._open_hash = p29._open_hash + 1;

    if p31 then
        local _open_hash = p29._open_hash;
        p29.Camera:CloseEffect();

        if _open_hash ~= p29._open_hash then
            return;
        end;
    end;

    if p29._renderstep_connection then
        p29._renderstep_connection:Disconnect();
        p29._renderstep_connection = nil;
    end;

    GamepadService:DisableGamepadCursor();
    pcall(StarterGui.SetCore, StarterGui, "ChatActive", p29._was_chat_active);
    p29.IsOpen = false;
    p29.Opened:Fire();

    if p29._from_shop then
        p29._from_shop = false;
        Pages.PageSystem:OpenPage("Shop", true);
    end;
end;

function u1.CloseRequest(p32) -- Line: 259
    if p32:IsCustomizing() then
        p32:StartCustomizing(nil);

        return;
    end;

    if p32:IsOpenEffectDone() then
        p32:Close(nil, true);
    end;
end;

function u1._OnCustomizingStateChanged(u33, ...) -- Line: 271
    if u33._on_customizing_state_changed_queued then
        return;
    end;

    u33._on_customizing_state_changed_queued = true;
    task.defer(function(...) -- Line: 278
        -- upvalues: u33 (copy)
        u33._on_customizing_state_changed_queued = false;
        u33.Interface:OnCustomizingStateChanged(...);
        u33.FloatingModel:OnCustomizingStateChanged(...);
        u33.Scene:OnCustomizingStateChanged(...);
    end, ...);
end;

function u1._OnStateChanged(u34, ...) -- Line: 286
    if u34._on_state_changed_queued then
        return;
    end;

    u34._on_state_changed_queued = true;
    task.defer(function(...) -- Line: 293
        -- upvalues: u34 (copy)
        u34._on_state_changed_queued = false;
        u34.Scene:OnStateChanged(...);
        u34.Camera:OnStateChanged(...);
        u34.SpinControls:OnStateChanged(...);
        u34.FloatingModel:OnStateChanged(...);
        u34.Interface:OnStateChanged(...);
    end, ...);
end;

function u1._OnOpen(p35, ...) -- Line: 303
    p35.EquipmentState:OnOpen(...);
    p35.Camera:OnOpen(...);
    p35.Scene:OnOpen(...);
    p35.SpinControls:OnOpen(...);
    p35.FloatingModel:OnOpen(...);
    p35.Interface:OnOpen(...);
end;

function u1._Update(p36, ...) -- Line: 312
    p36.Camera:Update(...);
    p36.SpinControls:Update(...);
    p36.FloatingModel:Update(...);
    p36.Interface:Update(...);
end;

function u1._UpdateVisibility(p37) -- Line: 319
    -- upvalues: PlayerDataController (copy)
    local Frame = p37.Frame;
    local v38 = p37.IsOpen and not PlayerDataController:GetSetting("Hide HUD");
    Frame.Visible = v38;
end;

function u1._CheckInterruption(p39) -- Line: 323
    -- upvalues: Queue (copy), Teleporting (copy), MobileInputs (copy)
    if Queue:IsVisible() or (Teleporting.Enabled or MobileInputs.EditorEnabled) then
        p39:Close();
    end;
end;

function u1._HookLocalFighter(u40) -- Line: 329
    -- upvalues: FighterController (copy)
    local u41 = FighterController:WaitForLocalFighter();
    u41:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 332
        -- upvalues: u41 (copy), u40 (copy)
        if u41:Get("IsInShootingRange") then
            u40:Close();

            return;
        end;

        if u40._is_trying_weapon and not u41:Get("IsInShootingRange") then
            u40._is_trying_weapon = false;
            u40:Open(nil, true);
        end;
    end);
    u41:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 341
        -- upvalues: u41 (copy), u40 (copy)
        if u41:Get("IsInDuel") then
            u40:Close();
        end;
    end);
end;

function u1._Init(u42) -- Line: 348
    -- upvalues: Queue (copy), Teleporting (copy), MobileInputs (copy), PlayerDataController (copy)
    u42.Opened:Connect(function(...) -- Line: 349
        -- upvalues: u42 (copy)
        u42:_UpdateVisibility();
        u42:_OnOpen(...);
    end);
    u42.SelectedWeaponChanged:Connect(function(...) -- Line: 354
        -- upvalues: u42 (copy)
        u42:_OnStateChanged(...);
    end);
    u42.CareerPageOpened:Connect(function(...) -- Line: 358
        -- upvalues: u42 (copy)
        u42:_OnStateChanged(...);
    end);
    u42.CustomizingChanged:Connect(function(...) -- Line: 362
        -- upvalues: u42 (copy)
        u42:_OnStateChanged(...);
        u42:_OnCustomizingStateChanged();
    end);
    u42.CustomizingStateChanged:Connect(function(...) -- Line: 367
        -- upvalues: u42 (copy)
        u42:_OnCustomizingStateChanged(...);
    end);
    u42.EquipmentState.SelectedWeaponChanged:Connect(function(...) -- Line: 371
        -- upvalues: u42 (copy)
        u42.SelectedWeaponChanged:Fire(...);
    end);
    u42.EquipmentState.CareerPageOpened:Connect(function(...) -- Line: 375
        -- upvalues: u42 (copy)
        u42.CareerPageOpened:Fire(...);
    end);
    u42.EquipmentState.CustomizingChanged:Connect(function(...) -- Line: 379
        -- upvalues: u42 (copy)
        u42.CustomizingChanged:Fire(...);
    end);
    u42.EquipmentState.CustomizingStateChanged:Connect(function(...) -- Line: 383
        -- upvalues: u42 (copy)
        u42.CustomizingStateChanged:Fire(...);
    end);
    u42.EquipmentState.CosmeticSearchChanged:Connect(function(...) -- Line: 387
        -- upvalues: u42 (copy)
        u42.CosmeticSearchChanged:Fire(...);
    end);
    u42.Scene.UnlockModel.UnlockingChanged:Connect(function(...) -- Line: 391
        -- upvalues: u42 (copy)
        u42.UnlockingChanged:Fire(...);
    end);
    u42.Camera.FinishedOpenEffect:Connect(function(...) -- Line: 395
        -- upvalues: u42 (copy)
        u42.FinishedOpenEffect:Fire(...);
    end);
    u42.FloatingModel.CharmAttachmentVisibleChanged:Connect(function(...) -- Line: 399
        -- upvalues: u42 (copy)
        u42.CharmAttachmentVisibleChanged:Fire(...);
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 403
        -- upvalues: u42 (copy)
        u42:_CheckInterruption();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 407
        -- upvalues: u42 (copy)
        u42:_CheckInterruption();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 411
        -- upvalues: u42 (copy)
        u42:_CheckInterruption();
    end);
    PlayerDataController:GetSettingChangedSignal("Hide HUD"):Connect(function() -- Line: 415
        -- upvalues: u42 (copy)
        u42:_UpdateVisibility();
    end);
    u42:Close();
    u42:_UpdateVisibility();
    task.spawn(u42._HookLocalFighter, u42);
end;

return u1._new();