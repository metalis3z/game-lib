-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Throwable = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Throwable);
local u1 = setmetatable({}, Throwable);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Throwable (copy), u1 (copy)
    local v2 = Throwable.new(...);
    local v3 = setmetatable(v2, u1);
    v3._detonate_cooldown = 0;
    v3._detonate_animation_cooldown = 0;
    v3:_Init();

    return v3;
end;

function u1.CanQuickAttack(p4) -- Line: 25
    -- upvalues: Throwable (copy)
    return Throwable.CanQuickAttack(p4) or p4:Get("NumSatchels") > 0;
end;

function u1.StartShooting(p5, p6) -- Line: 29
    -- upvalues: Throwable (copy)
    if p6 or ((p5:Get("Ammo") or (1 / 0)) > 0 or p5:Get("NumSatchels") <= 0) then
        return Throwable.StartShooting(p5, p6);
    end;

    return p5:StartAiming(p6);
end;

function u1.StartAiming(p7, p8) -- Line: 37
    if not p8 and p7:IsEquipping() then
        return false;
    end;

    if p8 or tick() > p7._detonate_animation_cooldown then
        p7._detonate_animation_cooldown = tick() + 0.25;
        p7.ViewModel:PlayAnimation("Detonate");
    end;

    if not (p8 or p7:Get("NumSatchels") > 0 and tick() >= p7._detonate_cooldown) then
        return false;
    end;

    p7._detonate_cooldown = tick() + 0.25;

    return true, "StartAiming";
end;

function u1.FinishAiming(p9, p10) -- Line: 56
    return false;
end;

function u1.ReplicateFromServer(p11, p12, ...) -- Line: 60
    -- upvalues: Utility (copy), Throwable (copy)
    if p12 ~= "SatchelAttached" then
        Throwable.ReplicateFromServer(p11, p12, ...);

        return;
    end;

    if not p11:IsRendered() then
        return;
    end;

    Utility:CreateSound("rbxassetid://128061013194700", 0.1, 1, ..., true, 5);
end;

function u1._Init(p13) -- Line: 78
end;

return u1;