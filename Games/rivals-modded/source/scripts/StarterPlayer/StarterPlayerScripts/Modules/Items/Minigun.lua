-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Gun = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun);
local u1 = setmetatable({}, Gun);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Gun (copy), u1 (copy)
    local v2 = Gun.new(...);
    local v3 = setmetatable(v2, u1);
    v3._charging_move_speed_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.CanQuickAttack(p4) -- Line: 24
    return false;
end;

function u1._UpdateChargingMoveSpeed(p5) -- Line: 32
    if not p5.ClientFighter.IsLocalPlayer then
        return;
    end;

    p5._charging_move_speed_hash = p5._charging_move_speed_hash + 1;

    repeat
        p5.ClientFighter.Entity:SetBoost("Speed", "MinigunCharge", 0.5, p5.IsEquipped and p5:Get("IsAiming") and (p5.Info.ChargingSpeedBoost or 0) or 0);
        wait(0.25);
    until p5._destroyed or (p5._charging_move_speed_hash ~= p5._charging_move_speed_hash or not (p5.ClientFighter:IsAlive() and p5.IsEquipped));
end;

function u1._Init(u6) -- Line: 51
    u6:GetDataChangedSignal("IsAiming"):Connect(function() -- Line: 52
        -- upvalues: u6 (copy)
        u6:_UpdateChargingMoveSpeed();
    end);
    u6.EquippedChanged:Connect(function() -- Line: 56
        -- upvalues: u6 (copy)
        u6:_UpdateChargingMoveSpeed();
    end);
end;

return u1;