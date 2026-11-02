-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local Spring = require(ReplicatedStorage.Modules.Spring);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local Crosshair = require(Players.LocalPlayer.PlayerScripts.Modules.Crosshair);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy), Crosshair (copy), Spring (copy)
    local v3 = setmetatable({}, u1);
    v3.Mouse = p2;
    v3.Crosshair = Crosshair.new();
    v3._crouch_spring = Spring.new(0, 0.875, 20);
    v3._speed_spring = Spring.new(0, 0.875, 20);
    v3._jump_spring = Spring.new(0, 0.875, 20);
    v3._hitmarker_spring = Spring.new(1, 1, 20);
    v3._hitmarker_rotation = 0;
    v3._last_damage_dealt_time = 0;
    v3:_Init();

    return v3;
end;

function u1.Refresh(p4) -- Line: 35
    -- upvalues: SettingsLibrary (copy), PlayerDataController (copy)
    if p4.Mouse.ItemInterface.ClientItem.ClientFighter.IsLocalPlayer then
        p4.Crosshair:SetAppearance(SettingsLibrary:GenerateCrosshairAppearance(PlayerDataController));
        p4.Mouse:Refresh();

        return;
    end;

    local v5 = p4.Mouse.ItemInterface.ClientItem.ClientFighter:Get("CompressedCrosshairAppearance");

    if v5 then
        p4.Crosshair:SetAppearance(SettingsLibrary:DecodeCrosshairAppearance(v5));
        p4.Mouse:Refresh();
    end;
end;

function u1.DamageEffect(p6, p7, p8) -- Line: 50
    if p7[utf8.char(0)] == 0 then
        return;
    end;

    local v9 = math.random() - 0.5;
    p6._hitmarker_rotation = math.sign(v9) * 15;
    p6._hitmarker_spring.Value = 0;
    p6._last_damage_dealt_time = tick();
    p6.Crosshair:SetHitmarkerColor(p7[utf8.char(1)]);
    p6.Mouse.ItemInterface.ClientItem.ViewModel:PlayHitmarkerSound(p7[utf8.char(1)], p8);
end;

function u1.Update(p10, p11, p12, p13) -- Line: 63
    -- upvalues: CONSTANTS (copy)
    if p10.Crosshair.Info.DotEnabled or p10.Crosshair.Info.BarsEnabled then
        local CurrentAimValue = p10.Mouse.ItemInterface.ClientItem.ViewModel.CurrentAimValue;
        local CurrentRecoilValue = p10.Mouse.ItemInterface.ClientItem.ViewModel.CurrentRecoilValue;
        local CurrentInspectValue = p10.Mouse.ItemInterface.ClientItem.ViewModel.CurrentInspectValue;
        local v14 = p10.Mouse.ItemInterface.ClientItem.Info.ShootAccuracy or 1;
        local v15 = p10.Mouse.ItemInterface.ClientItem.ViewModel:IsAimingAnimationEnabled();
        p10._speed_spring.Target = p12.MoveSpeed > 4 and (p12.MoveSpeed or 0) or 0;
        p10._jump_spring.Target = p12.IsGrounded and 0 or 1;
        p10._crouch_spring.Target = p12.IsCrouching and 0.25 or 1;

        for _, v in pairs({ p10._speed_spring, p10._jump_spring, p10._crouch_spring }) do
            v.Value = v.Target > v.Value and v.Target or v.Value;
        end;

        local Value = p10._crouch_spring.Value;
        local v16 = p10._speed_spring.Value * 0.75;
        local Value2 = p10._jump_spring.Value;
        local v17 = not p10.Mouse.Scope:IsActive() and p10.Crosshair:ShowWhileAiming() and 1 or 1 - CurrentAimValue;
        local v18 = (p10.Crosshair:GetAppearanceSpacing() + 8 * (v16 / CONSTANTS.BASE_WALKSPEED) ^ 2 + 32 * Value2 + 100 * CurrentRecoilValue.Magnitude / v14) * Value / v14;
        local v19 = p12.IsFirstPerson and (p10.Mouse.ItemInterface.ClientItem.Name ~= "Minigun" and v15) and (1 - v17 or 0) or 0;
        local v20 = v19 + (1 - v19) * (p10.Crosshair:ShowWhileInspecting() and 0 or CurrentInspectValue);
        p10.Crosshair:SetSpacing(v18, v17);
        p10.Crosshair:SetTransparency(v20);
    end;

    local Value = p10._hitmarker_spring.Value;
    local v21 = 16 + -8 * Value;
    local UDim2_new_ret = UDim2.new(0, v21, 0, v21);
    local v22 = (tick() - p10._last_damage_dealt_time) / 2;
    local v23 = math.min(1, v22) ^ 10;
    p10.Crosshair:SetHitmarkerVisuals(32 + -26 * Value, UDim2_new_ret, v23, (1 - Value) * p10._hitmarker_rotation);
end;

function u1.Destroy(p24) -- Line: 105
    p24.Crosshair:Destroy();
end;

function u1._Setup(p25) -- Line: 113
    p25.Crosshair:SetType(p25.Mouse.ItemInterface.ClientItem.Info.CrosshairType);
    p25.Crosshair:SetParent(p25.Mouse.Frame);
end;

function u1._Init(p26) -- Line: 118
    p26:_Setup();
end;

return u1;