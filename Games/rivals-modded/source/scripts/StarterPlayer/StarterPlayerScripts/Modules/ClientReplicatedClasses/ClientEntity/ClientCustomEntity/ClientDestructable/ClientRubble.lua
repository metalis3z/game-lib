-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientDestructable = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientCustomEntity.ClientDestructable);
local u1 = setmetatable({}, ClientDestructable);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: ClientDestructable (copy), u1 (copy)
    local v2 = ClientDestructable.new(...);
    local v3 = setmetatable(v2, u1);
    v3.PlayRubbleEffectOnDeath = true;
    v3:_Init();

    return v3;
end;

function u1._Init(p4) -- Line: 28
end;

return u1;