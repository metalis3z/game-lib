-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(nil, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 25
    -- upvalues: Emote (copy)
    Emote.PlayClient(p4, ...);
    p4:_PlayAnimation("rbxassetid://93712852727557", "rbxassetid://97084758451290", 3.6);
    local v5 = p4:_SetupMultipleProps(script.SparklersProp);
    wait(1.1);

    for _, descendant in pairs(v5.stick1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            descendant.Enabled = true;
        end;
    end;

    p4:CreateSound("rbxassetid://15573552175", 3, 1 + 0.1 * math.random(), nil, true, 5);
    p4:CreateSound("rbxassetid://75644699023746", 1, 1, nil, true).Looped = true;
    wait(1.65);

    for _, descendant in pairs(v5.stick2:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            descendant.Enabled = true;
        end;
    end;

    p4:CreateSound("rbxassetid://15573552175", 3, 1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p6) -- Line: 57
end;

return u1;