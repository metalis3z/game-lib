-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local ClientHumanoidEntity = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientFighterCharacter = p2;
    v3._last_is_alive_check = nil;
    v3._last_is_grounded_check = nil;
    v3._is_grounded_time = nil;
    v3:_Init();

    return v3;
end;

function u1.IsAliveCached(p4) -- Line: 28
    -- upvalues: ClientHumanoidEntity (copy)
    local _ = p4._last_is_alive_check == nil;
    local v5 = p4.ClientFighterCharacter.Head and ClientHumanoidEntity.IsAlive(p4.ClientFighterCharacter);
    p4._last_is_alive_check = v5;

    return v5;
end;

function u1.IsGroundedCached(p6) -- Line: 40
    if p6._last_is_grounded_check ~= nil then
        return p6._last_is_grounded_check;
    end;

    if not p6.ClientFighterCharacter:IsAlive() then
        p6._last_is_grounded_check = false;

        return false;
    end;

    local v7 = not p6.ClientFighterCharacter:IsHumanoidStateAirborne();
    p6._last_is_grounded_check = v7;

    return v7;
end;

function u1.Update(p8, p9, p10) -- Line: 67
    p8._last_is_alive_check = nil;
    p8._last_is_grounded_check = nil;
end;

function u1.Destroy(p11) -- Line: 72
end;

function u1._UpdateHumanoidStates(p12) -- Line: 80
    if not p12.ClientFighterCharacter.Humanoid then
        return;
    end;

    local v13 = p12.ClientFighterCharacter:Get("IsFrozen") and true or false;
    p12.ClientFighterCharacter.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
    p12.ClientFighterCharacter.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    p12.ClientFighterCharacter.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, v13);
    p12.ClientFighterCharacter.Humanoid.PlatformStand = v13;
end;

function u1._Init(u14) -- Line: 93
    u14.ClientFighterCharacter:GetDataChangedSignal("IsFrozen"):Connect(function() -- Line: 94
        -- upvalues: u14 (copy)
        u14:_UpdateHumanoidStates();
    end);
    u14:_UpdateHumanoidStates();
end;

return u1;