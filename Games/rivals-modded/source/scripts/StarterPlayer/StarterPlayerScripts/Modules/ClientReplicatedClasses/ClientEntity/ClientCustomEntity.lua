-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientEntity = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity);
local u1 = setmetatable({}, ClientEntity);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: ClientEntity (copy), u1 (copy)
    local v2 = ClientEntity.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetHealth(p4) -- Line: 20
    return p4.Model:GetAttribute("Health");
end;

function u1.GetMaxHealth(p5) -- Line: 24
    return p5.Model:GetAttribute("MaxHealth");
end;

function u1._Init(u6) -- Line: 32
    u6.Model:GetAttributeChangedSignal("MaxHealth"):Connect(function() -- Line: 33
        -- upvalues: u6 (copy)
        u6.HealthChanged:Fire();
    end);
    u6.Model:GetAttributeChangedSignal("Health"):Connect(function() -- Line: 37
        -- upvalues: u6 (copy)
        u6.HealthChanged:Fire();
    end);
end;

return u1;