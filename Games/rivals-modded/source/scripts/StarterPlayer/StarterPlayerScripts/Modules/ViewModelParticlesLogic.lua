-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 10
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4.ClientViewModel = p2;
    v4._tag = p3 or "ArchParticles";
    v4._effect_hash = 0;
    v4._particles = {};
    v4:_Init();

    return v4;
end;

function u1.SetVisible(p5, p6) -- Line: 28
    -- upvalues: Utility (copy)
    for _, v in pairs(p5._particles) do
        v.Enabled = p6;

        if v:IsA("ParticleEmitter") and not p6 then
            v:Clear();
        end;
    end;

    if p6 then
        Utility:PlayParticles(p5._particles);
    end;
end;

function u1.PlayEffect(p7, p8, p9) -- Line: 42
    p7:CancelEffect();
    local _effect_hash = p7._effect_hash;

    if p8 > 0 then
        wait(p8);

        if p7._effect_hash ~= _effect_hash then
            return;
        end;
    end;

    p7:SetVisible(false);

    if p9 > 0 then
        wait(p9);

        if p7._effect_hash ~= _effect_hash then
            return;
        end;
    end;

    p7:SetVisible(true);
end;

function u1.CancelEffect(p10) -- Line: 67
    p10._effect_hash = p10._effect_hash + 1;
end;

function u1.Destroy(p11) -- Line: 71
    p11:CancelEffect();
end;

function u1._Setup(p12) -- Line: 80
    for _, descendant in pairs(p12.ClientViewModel.ItemModel:GetDescendants()) do
        if descendant:HasTag(p12._tag) and descendant.Enabled then
            table.insert(p12._particles, descendant);
        end;
    end;
end;

function u1._Init(p13) -- Line: 88
    p13:_Setup();
end;

return u1;