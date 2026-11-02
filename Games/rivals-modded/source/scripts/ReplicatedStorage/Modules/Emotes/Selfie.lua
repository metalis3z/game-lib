-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(3.9, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 24
    -- upvalues: Emote (copy), Utility (copy)
    Emote.PlayClient(p4, ...);
    local v5 = p4:_SetupProp(script.PhoneProp);
    p4:_PlayAnimation("rbxassetid://87719925359671");
    wait(0.4);
    Utility:PlayParticles(v5);
    p4:CreateSound("rbxassetid://96932112018810", 1, 1, nil, true, 5);
    wait(0.65);
    Utility:PlayParticles(v5);
    p4:CreateSound("rbxassetid://96932112018810", 1, 1, nil, true, 5);
    wait(0.15);
    Utility:PlayParticles(v5);
    p4:CreateSound("rbxassetid://96932112018810", 1, 1, nil, true, 5);
end;

function u1._Init(p6) -- Line: 44
end;

return u1;