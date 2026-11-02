-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local EmoteController = require(Players.LocalPlayer.PlayerScripts.Controllers.EmoteController);
local OutOfBoundsParts = require(Players.LocalPlayer.PlayerScripts.Modules.GameComponents.OutOfBoundsParts);
local EliminatedEffect = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.EliminatedEffect);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local AudioVisualizers = require(script:WaitForChild("AudioVisualizers"));
local DamageIndicators = require(script:WaitForChild("DamageIndicators"));
local EliminationSlots = require(script:WaitForChild("EliminationSlots"));
local EquippedDisplays = require(script:WaitForChild("EquippedDisplays"));
local WarningEffect = require(script:WaitForChild("WarningEffect"));
local BottomCenter = require(script:WaitForChild("BottomCenter"));
local SmokeScreen = require(script:WaitForChild("SmokeScreen"));
local BottomRight = require(script:WaitForChild("BottomRight"));
local BottomLeft = require(script:WaitForChild("BottomLeft"));
local SpeedLines = require(script:WaitForChild("SpeedLines"));
local Spectators = require(script:WaitForChild("Spectators"));
local Keybinds = require(script:WaitForChild("Keybinds"));
local Flashed = require(script:WaitForChild("Flashed"));
local Frozen = require(script:WaitForChild("Frozen"));
local Splats = require(script:WaitForChild("Splats"));
local Health = require(script:WaitForChild("Health"));
local Hotbar = require(script:WaitForChild("Hotbar"));
local Other = require(script:WaitForChild("Other"));
local ESP = require(script:WaitForChild("ESP"));
local FighterInterface = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("FighterInterface");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 40
    -- upvalues: u1 (copy), Signal (copy), FighterInterface (copy), AudioVisualizers (copy), DamageIndicators (copy), EliminationSlots (copy), EquippedDisplays (copy), WarningEffect (copy), BottomCenter (copy), BottomRight (copy), SmokeScreen (copy), BottomLeft (copy), Spectators (copy), SpeedLines (copy), Flashed (copy), Frozen (copy), Splats (copy), Health (copy), Hotbar (copy), Keybinds (copy), Other (copy), ESP (copy)
    local v3 = setmetatable({}, u1);
    v3.ActiveChanged = Signal.new();
    v3.HotbarClicked = Signal.new();
    v3.ClientFighter = p2;
    v3.Frame = FighterInterface:Clone();
    v3.AudioVisualizers = AudioVisualizers.new(v3);
    v3.DamageIndicators = DamageIndicators.new(v3);
    v3.EliminationSlots = EliminationSlots.new(v3);
    v3.EquippedDisplays = EquippedDisplays.new(v3);
    v3.WarningEffect = WarningEffect.new(v3);
    v3.BottomCenter = BottomCenter.new(v3);
    v3.BottomRight = BottomRight.new(v3);
    v3.SmokeScreen = SmokeScreen.new(v3);
    v3.BottomLeft = BottomLeft.new(v3);
    v3.Spectators = Spectators.new(v3);
    v3.SpeedLines = SpeedLines.new(v3);
    v3.Flashed = Flashed.new(v3);
    v3.Frozen = Frozen.new(v3);
    v3.Splats = Splats.new(v3);
    v3.Health = Health.new(v3);
    v3.Hotbar = Hotbar.new(v3);
    v3.Keybinds = Keybinds.new(v3);
    v3.Other = Other.new(v3);
    v3.ESP = ESP.new(v3);
    v3._destroyed = false;
    v3._connections = {};
    v3._original_sizings = {};
    v3:_Init();

    return v3;
end;

function u1.RefillAmmoEffect(p4, ...) -- Line: 81
    return p4.Other:RefillAmmoEffect(...);
end;

function u1.HealEffect(p5, ...) -- Line: 85
    return p5.Health:HealEffect(...);
end;

function u1.HurtEffect(p6, ...) -- Line: 89
    return p6.Health:HurtEffect(...);
end;

function u1.DamageIndicator(p7, ...) -- Line: 93
    return p7.DamageIndicators:Create(...);
end;

function u1.ClearDamageIndicators(p8, ...) -- Line: 97
    return p8.DamageIndicators:Clear(...);
end;

function u1.SplatEffect(p9, ...) -- Line: 101
    return p9.Splats:Create(...);
end;

function u1.EliminationEffect(p10, ...) -- Line: 105
    return p10.EliminationSlots:Create(...);
end;

function u1.HotbarRollEffect(p11, ...) -- Line: 109
    return p11.Hotbar:RollEffect(...);
end;

function u1.IsActive(p12) -- Line: 113
    return p12.Frame.Visible;
end;

function u1.CreateSound(p13, ...) -- Line: 117
    -- upvalues: Utility (copy)
    if p13:IsActive() then
        return Utility:CreateSound(...);
    end;
end;

function u1.Update(p14, p15, p16) -- Line: 125
    if not p16.IsSpectating then
        p14.SmokeScreen:Hide();
        p14:_SetFrameVisible(false);

        return;
    end;

    p14.AudioVisualizers:Update(p15, p16);
    p14.DamageIndicators:Update(p15, p16);
    p14.EquippedDisplays:Update(p15, p16);
    p14.SmokeScreen:Update(p15, p16);
    p14.SpeedLines:Update(p15, p16);
    p14.Hotbar:Update(p15, p16);
    p14.ESP:Update(p15, p16);
    p14:_SetFrameVisible(true);
end;

function u1.Destroy(p17) -- Line: 142
    p17._destroyed = true;

    for _, v in pairs(p17._connections) do
        v:Disconnect();
    end;

    p17._connections = {};
    p17.ActiveChanged:Destroy();
    p17.HotbarClicked:Destroy();
    p17.AudioVisualizers:Destroy();
    p17.DamageIndicators:Destroy();
    p17.EliminationSlots:Destroy();
    p17.EquippedDisplays:Destroy();
    p17.WarningEffect:Destroy();
    p17.BottomCenter:Destroy();
    p17.SmokeScreen:Destroy();
    p17.BottomRight:Destroy();
    p17.BottomLeft:Destroy();
    p17.SpeedLines:Destroy();
    p17.Spectators:Destroy();
    p17.Keybinds:Destroy();
    p17.Flashed:Destroy();
    p17.Frozen:Destroy();
    p17.Splats:Destroy();
    p17.Health:Destroy();
    p17.Hotbar:Destroy();
    p17.Other:Destroy();
    p17.ESP:Destroy();
    p17.Frame:Destroy();
end;

function u1._UpdateSizing(p18) -- Line: 181
    -- upvalues: UILibrary (copy)
    local v19 = UILibrary.MainGui.AbsoluteSize.X / p18.Frame.AbsoluteSize.X;
    local v20 = UILibrary.MainGui.AbsoluteSize.Y / p18.Frame.AbsoluteSize.Y;

    for _, v in pairs({ "ESP", "DamageVignette", "FrozenVignette", "HealVignette", "WarningVignette", "SpeedLinesThick", "SpeedLinesThin", "RefillAmmoVignette" }) do
        local v21 = p18.Frame[v];
        p18._original_sizings[v21] = p18._original_sizings[v21] or {
            Position = v21.Position,
            Size = v21.Size
        };
        v21.Size = UDim2.new(p18._original_sizings[v21].Size.X.Scale * v19, p18._original_sizings[v21].Size.X.Offset * v19, p18._original_sizings[v21].Size.Y.Scale * v20, p18._original_sizings[v21].Size.Y.Offset * v20);
        v21.Position = UDim2.new(0.5 + (p18._original_sizings[v21].Position.X.Scale - 0.5) * v19, 0, 0.5 + (p18._original_sizings[v21].Position.Y.Scale - 0.5) * v20, 0);
    end;
end;

function u1._UpdateVisibility(p22) -- Line: 209
    -- upvalues: Pages (copy), EliminatedEffect (copy)
    local v23 = not Pages.PageSystem.CurrentPage;
    local v24 = EliminatedEffect:IsVisible();
    local v25;

    if v23 then
        v25 = not v24;
    else
        v25 = v23;
    end;

    p22.EliminationSlots:SetVisible(v25);
    local v26;

    if v23 then
        if #p22.ClientFighter.Items > 0 then
            v26 = not v24;
        else
            v26 = false;
        end;
    else
        v26 = v23;
    end;

    p22.BottomCenter:SetVisible(v26);
    local v27;

    if v23 then
        if #p22.ClientFighter.Items > 0 then
            v27 = not v24;
        else
            v27 = false;
        end;
    else
        v27 = v23;
    end;

    p22.BottomRight:SetVisible(v27);

    if v23 then
        v23 = #p22.ClientFighter.Items > 0;
    end;

    p22.BottomLeft:SetVisible(v23);
end;

function u1._SetFrameVisible(p28, p29) -- Line: 219
    if p28.Frame.Visible == p29 then
        return;
    end;

    p28.Frame.Visible = p29;
    p28.ActiveChanged:Fire();
end;

function u1._EntityRemoved(p30) -- Line: 228
    p30.Frozen:Refresh();
end;

function u1._EntityAdded(u31) -- Line: 232
    u31.EliminationSlots:Clear();
    u31.DamageIndicators:Clear();
    u31.SmokeScreen:Clear();

    if not u31.ClientFighter.Entity then
        u31.Health:Refresh();
        u31.Frozen:Refresh();

        return;
    end;

    table.insert(u31._connections, u31.ClientFighter.Entity.HealthChanged:Connect(function() -- Line: 243
        -- upvalues: u31 (copy)
        u31.Health:Refresh();
    end));
    local _connections = u31._connections;
    local DataChangedSignal = u31.ClientFighter.Entity:GetDataChangedSignal("IsFrozen");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 247
        -- upvalues: u31 (copy)
        u31.Frozen:Refresh();
    end));
    table.insert(u31._connections, u31.ClientFighter.Entity.Died:Connect(function() -- Line: 251
        -- upvalues: u31 (copy)
        u31.Frozen:Refresh();
        u31.Keybinds:Refresh();
    end));
    u31.Health:Refresh();
    u31.Frozen:Refresh();
    u31.Keybinds:Refresh();
end;

function u1._Setup(p32) -- Line: 261
    -- upvalues: UILibrary (copy)
    p32:_SetFrameVisible(false);
    p32.Frame.Name = p32.ClientFighter.Player.Name;
    p32.Frame.Parent = UILibrary:GetTo("MainFrame", "FighterInterfaces");
end;

function u1._Init(u33) -- Line: 267
    -- upvalues: CameraController (copy), ControlsController (copy), EmoteController (copy), Pages (copy), EliminatedEffect (copy), PlayerDataController (copy), OutOfBoundsParts (copy)
    u33.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 268
        -- upvalues: u33 (copy)
        u33:_UpdateSizing();
    end);
    u33.Hotbar.Clicked:Connect(function(...) -- Line: 272
        -- upvalues: u33 (copy)
        u33.HotbarClicked:Fire(...);
    end);
    table.insert(u33._connections, u33.ClientFighter.EntityAdded:Connect(function() -- Line: 276
        -- upvalues: u33 (copy)
        u33:_EntityAdded();
    end));
    table.insert(u33._connections, u33.ClientFighter.EntityRemoved:Connect(function() -- Line: 280
        -- upvalues: u33 (copy)
        u33:_EntityRemoved();
    end));
    table.insert(u33._connections, u33.ClientFighter.EquippedItemChanged:Connect(function() -- Line: 284
        -- upvalues: u33 (copy)
        u33.Keybinds:Refresh();
        u33.Hotbar:UpdateVisuals();
        u33.Hotbar:EquipEffect(u33.ClientFighter.EquippedItem);
        u33.EquippedDisplays:UpdateVisibility();
        u33.EquippedDisplays:UpdateVisuals();
    end));
    table.insert(u33._connections, u33.ClientFighter.ItemAdded:Connect(function(p34) -- Line: 292
        -- upvalues: u33 (copy)
        u33.Keybinds:Refresh();
        u33.Hotbar:ItemAdded(p34);
        u33.EquippedDisplays:ItemAdded(p34);
        u33:_UpdateVisibility();
    end));
    table.insert(u33._connections, u33.ClientFighter.ItemRemoved:Connect(function(p35) -- Line: 299
        -- upvalues: u33 (copy)
        u33.Keybinds:Refresh();
        u33.Hotbar:ItemRemoved(p35);
        u33.EquippedDisplays:ItemRemoved(p35);
        u33:_UpdateVisibility();
    end));
    local _connections = u33._connections;
    local DataChangedSignal = u33.ClientFighter:GetDataChangedSignal("NumSpectators");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 306
        -- upvalues: u33 (copy)
        u33.Spectators:Refresh();
    end));
    local _connections2 = u33._connections;
    local DataChangedSignal2 = u33.ClientFighter:GetDataChangedSignal("IsInDuel");
    table.insert(_connections2, DataChangedSignal2:Connect(function() -- Line: 310
        -- upvalues: u33 (copy)
        u33.Keybinds:Refresh();
    end));
    local _connections3 = u33._connections;
    local DataChangedSignal3 = u33.ClientFighter:GetDataChangedSignal("QuickAttackOverrides");
    table.insert(_connections3, DataChangedSignal3:Connect(function() -- Line: 314
        -- upvalues: u33 (copy)
        u33.Keybinds:Refresh();
    end));
    local _connections4 = u33._connections;
    local DataChangedSignal4 = u33.ClientFighter:GetDataChangedSignal("CheaterMode");
    table.insert(_connections4, DataChangedSignal4:Connect(function() -- Line: 318
        -- upvalues: u33 (copy)
        u33.ESP:Refresh();
    end));
    local _connections5 = u33._connections;
    local DataChangedSignal5 = u33.ClientFighter:GetDataChangedSignal("IsAprilFools");
    table.insert(_connections5, DataChangedSignal5:Connect(function() -- Line: 322
        -- upvalues: u33 (copy)
        u33.Health:Refresh();
    end));
    local _connections6 = u33._connections;
    local DataChangedSignal6 = u33.ClientFighter:GetDataChangedSignal("InfiniteAmmo");
    table.insert(_connections6, DataChangedSignal6:Connect(function() -- Line: 326
        -- upvalues: u33 (copy)
        u33.Hotbar:UpdateAmmo();
        u33.EquippedDisplays:UpdateAmmo();
    end));
    local _connections7 = u33._connections;
    local DataChangedSignal7 = u33.ClientFighter:GetDataChangedSignal("InfiniteAmmoReserve");
    table.insert(_connections7, DataChangedSignal7:Connect(function() -- Line: 331
        -- upvalues: u33 (copy)
        u33.Hotbar:UpdateAmmo();
        u33.EquippedDisplays:UpdateAmmo();
    end));
    local _connections8 = u33._connections;
    local DataChangedSignal8 = u33.ClientFighter:GetDataChangedSignal("EquippedItemID");
    table.insert(_connections8, DataChangedSignal8:Connect(function() -- Line: 336
        -- upvalues: u33 (copy)
        u33.Hotbar:UpdateLayouts();
    end));
    local _connections9 = u33._connections;
    local DataChangedSignal9 = u33.ClientFighter:GetDataChangedSignal("IsInShootingRange");
    table.insert(_connections9, DataChangedSignal9:Connect(function() -- Line: 340
        -- upvalues: u33 (copy)
        u33.Keybinds:Refresh();
    end));
    table.insert(u33._connections, CameraController.StateChanged:Connect(function() -- Line: 344
        -- upvalues: u33 (copy)
        u33.Keybinds:Refresh();
    end));
    table.insert(u33._connections, ControlsController.ControlsChanged:Connect(function() -- Line: 348
        -- upvalues: u33 (copy)
        u33.Keybinds:Refresh();
        u33.Spectators:Refresh();
        u33.Hotbar:UpdateVisibility();
    end));
    table.insert(u33._connections, EmoteController.CanEmoteChanged:Connect(function() -- Line: 354
        -- upvalues: u33 (copy)
        u33.Keybinds:Refresh();
    end));
    table.insert(u33._connections, Pages.PageSystem.PageOpened:Connect(function() -- Line: 358
        -- upvalues: u33 (copy)
        u33:_UpdateVisibility();
    end));
    table.insert(u33._connections, Pages.PageSystem.PageClosed:Connect(function() -- Line: 362
        -- upvalues: u33 (copy)
        u33:_UpdateVisibility();
    end));
    table.insert(u33._connections, EliminatedEffect.VisibilityChanged:Connect(function() -- Line: 366
        -- upvalues: u33 (copy)
        u33:_UpdateVisibility();
    end));
    local _connections10 = u33._connections;
    local SettingChangedSignal = PlayerDataController:GetSettingChangedSignal("Spectators Display");
    table.insert(_connections10, SettingChangedSignal:Connect(function() -- Line: 370
        -- upvalues: u33 (copy)
        u33.Spectators:UpdateParent();
    end));
    local _connections11 = u33._connections;
    local SettingChangedSignal2 = PlayerDataController:GetSettingChangedSignal("Padded HUD");
    table.insert(_connections11, SettingChangedSignal2:Connect(function() -- Line: 374
        -- upvalues: u33 (copy)
        u33.Spectators:Refresh();
    end));
    local _connections12 = u33._connections;
    local SettingChangedSignal3 = PlayerDataController:GetSettingChangedSignal("Health Bar Display");
    table.insert(_connections12, SettingChangedSignal3:Connect(function() -- Line: 378
        -- upvalues: u33 (copy)
        u33.Health:UpdateParent();
    end));
    local _connections13 = u33._connections;
    local SettingChangedSignal4 = PlayerDataController:GetSettingChangedSignal("Keybinds Interface");
    table.insert(_connections13, SettingChangedSignal4:Connect(function() -- Line: 382
        -- upvalues: u33 (copy)
        u33.Keybinds:Refresh();
    end));
    local _connections14 = u33._connections;
    local SettingChangedSignal5 = PlayerDataController:GetSettingChangedSignal("Equipped Weapon Display");
    table.insert(_connections14, SettingChangedSignal5:Connect(function() -- Line: 386
        -- upvalues: u33 (copy)
        u33.Hotbar:UpdateAmmo();
        u33.Hotbar:UpdateVisibility();
        u33.EquippedDisplays:UpdateAmmo();
        u33.EquippedDisplays:UpdateVisibility();
        u33.EquippedDisplays:UpdateParents();
    end));
    local _connections15 = u33._connections;
    local SettingChangedSignal6 = PlayerDataController:GetSettingChangedSignal("Hotbar Slot Ammo");
    table.insert(_connections15, SettingChangedSignal6:Connect(function() -- Line: 394
        -- upvalues: u33 (copy)
        u33.Hotbar:UpdateAmmo();
        u33.EquippedDisplays:UpdateAmmo();
    end));
    local _connections16 = u33._connections;
    local SettingChangedSignal7 = PlayerDataController:GetSettingChangedSignal("Equipped Weapon Icon");
    table.insert(_connections16, SettingChangedSignal7:Connect(function() -- Line: 399
        -- upvalues: u33 (copy)
        u33.EquippedDisplays:UpdateParents();
    end));
    local _connections17 = u33._connections;
    local SettingChangedSignal8 = PlayerDataController:GetSettingChangedSignal("Equipped Weapon Ammo");
    table.insert(_connections17, SettingChangedSignal8:Connect(function() -- Line: 403
        -- upvalues: u33 (copy)
        u33.EquippedDisplays:UpdateParents();
    end));
    local _connections18 = u33._connections;
    local SettingChangedSignal9 = PlayerDataController:GetSettingChangedSignal("Hotbar Display");
    table.insert(_connections18, SettingChangedSignal9:Connect(function() -- Line: 407
        -- upvalues: u33 (copy)
        u33.Hotbar:UpdateParent();
        u33.Hotbar:UpdateVisibility();
        u33.EquippedDisplays:UpdateParents();
    end));

    if u33.ClientFighter.IsLocalPlayer then
        table.insert(u33._connections, OutOfBoundsParts.Warning:Connect(function(p36) -- Line: 414
            -- upvalues: u33 (copy)
            u33.WarningEffect:SetEnabled(true, p36);
        end));
        table.insert(u33._connections, OutOfBoundsParts.SteppedOut:Connect(function() -- Line: 418
            -- upvalues: u33 (copy)
            u33.WarningEffect:SetEnabled(false);
        end));
    end;

    u33:_Setup();
    u33:_UpdateSizing();
    u33:_UpdateVisibility();
    u33.ESP:Refresh();
    u33.Keybinds:Refresh();
    u33.Spectators:Refresh();
    u33.EliminationSlots:Refresh();
    task.defer(u33._EntityAdded, u33);
end;

return u1;