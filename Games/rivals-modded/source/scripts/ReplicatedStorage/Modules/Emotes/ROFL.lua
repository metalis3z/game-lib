-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(5.25, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 23
    -- upvalues: Emote (copy)
    Emote.PlayClient(p4, ...);
    p4:_PlayAnimation("rbxassetid://73786487009083");
    p4:CreateSound("rbxassetid://122605533507524", 1, 1 + 0.1 * math.random(), nil, true, 5);
    wait(0.5);
    p4:CreateSound("rbxassetid://126514820442685", 0.75, 1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p5) -- Line: 36
end;

return u1;