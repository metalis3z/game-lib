-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Gun = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun);
local u1 = setmetatable({}, Gun);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Gun (copy), u1 (copy)
    local v2 = Gun.new(...);
    local v3 = setmetatable(v2, u1);
    v3.ToggleAimEnabled = nil;
    v3:_Init();

    return v3;
end;

function u1.StartAiming(p4) -- Line: 22
    return false;
end;

function u1.FinishAiming(p5) -- Line: 26
    return false;
end;

function u1.ReplicateFromServer(p6, p7, ...) -- Line: 30
    -- upvalues: Gun (copy)
    if p7 == "TransformProjectile" then
        if not p6:IsRendered() then
            return;
        end;

        local v8 = ...;
        p6.ViewModel:TransformProjectile(v8, p6._projectile_part_to_model[v8]);

        return;
    end;

    if p7 ~= "MiniExplosionEffect" then
        Gun.ReplicateFromServer(p6, p7, ...);

        return;
    end;

    if not p6:IsRendered() then
        return;
    end;

    local v9 = ...;
    v9:Destroy();
    p6.ViewModel:PlayCastParticles(v9.Position, 2);
end;

function u1._Init(p10) -- Line: 57
end;

return u1;