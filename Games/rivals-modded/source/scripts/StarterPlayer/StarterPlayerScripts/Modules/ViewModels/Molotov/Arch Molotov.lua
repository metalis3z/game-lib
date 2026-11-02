-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ViewModelParticlesLogic = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModelParticlesLogic);
local Molotov = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Molotov);
local u1 = setmetatable({}, Molotov);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Molotov (copy), u1 (copy), ViewModelParticlesLogic (copy)
    local v2 = Molotov.new(...);
    local v3 = setmetatable(v2, u1);
    v3._particles_logic = ViewModelParticlesLogic.new(v3);
    v3:_Init();

    return v3;
end;

function u1.ExplosionEffect(p4, p5, p6) -- Line: 25
    -- upvalues: Molotov (copy), Utility (copy)
    Molotov.ExplosionEffect(p4, p5, p6);
    Utility:CreateSound("rbxassetid://72790275842437", 0.5, 1 + 0.25 * math.random(), p5, true, 10);
end;

function u1.Unequip(p7, ...) -- Line: 30
    -- upvalues: Molotov (copy)
    p7._particles_logic:CancelEffect();
    Molotov.Unequip(p7, ...);
end;

function u1.Destroy(p8) -- Line: 35
    -- upvalues: Molotov (copy)
    p8._particles_logic:Destroy();
    Molotov.Destroy(p8);
end;

function u1._Init(u9) -- Line: 44
    u9.Equipped:Connect(function(p10) -- Line: 45
        -- upvalues: u9 (copy)
        u9._particles_logic:PlayEffect(0, p10 and 0 or 0.55);
    end);
    u9.AnimationPlayed:Connect(function(p11) -- Line: 49
        -- upvalues: u9 (copy)
        if p11 == "ThrowFinish" then
            u9._particles_logic:PlayEffect(0.65, 0.5);

            return;
        end;

        if p11 == "LobFinish" then
            u9._particles_logic:PlayEffect(0.65, 0.5);
        end;
    end);
end;

return u1;