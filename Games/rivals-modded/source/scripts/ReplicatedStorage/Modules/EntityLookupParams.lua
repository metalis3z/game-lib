-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 4
    -- upvalues: u1 (copy)
    local v5 = setmetatable({}, u1);
    v5.TeamID = p2;
    v5.TeamkillEnabled = p3;
    v5.GrabSmallHitboxes = p4;
    v5.SourceEntity = nil;
    v5.CanHurtSelf = nil;
    v5:_Init();

    return v5;
end;

function u1.IsValidTarget(p6, p7) -- Line: 22
    if p7 and (p6.CanHurtSelf or p7 ~= p6.SourceEntity) and p7:IsAlive() then
        return (p6.TeamkillEnabled or not (p6.TeamID and (p7 ~= p6.SourceEntity and p7:Get("TeamID") == p6.TeamID))) and true or false;
    end;

    return false;
end;

function u1._Init(p8) -- Line: 38
end;

return u1;