-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ViewModelParticlesLogic = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModelParticlesLogic);
local Katana = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Katana);
local u1 = setmetatable({}, Katana);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: Katana (copy), u1 (copy), ViewModelParticlesLogic (copy)
    local v2 = Katana.new(...);
    local v3 = setmetatable(v2, u1);
    v3._particles_logic = ViewModelParticlesLogic.new(v3);
    v3:_Init();

    return v3;
end;

function u1.PlayDeflectHitSounds(p4) -- Line: 23
    p4:CreateSound("rbxassetid://14776414133", 1.25, 1.5 + 0.5 * math.random(), true, 5);
    p4:CreateSound("rbxassetid://14776437962", 1, 0.9 + 0.2 * math.random(), true, 5);
    p4:CreateSound("rbxassetid://82797934287631", 1, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1.Unequip(p5, ...) -- Line: 29
    -- upvalues: Katana (copy)
    p5._particles_logic:CancelEffect();
    Katana.Unequip(p5, ...);
end;

function u1.Destroy(p6) -- Line: 34
    -- upvalues: Katana (copy)
    p6._particles_logic:Destroy();
    Katana.Destroy(p6);
end;

function u1._Init(u7) -- Line: 43
    u7.Equipped:Connect(function(p8) -- Line: 44
        -- upvalues: u7 (copy)
        u7._particles_logic:PlayEffect(0, p8 and 0 or 0.5);
    end);
end;

return u1;