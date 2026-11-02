-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.Utility);
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(nil, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 26
    -- upvalues: Emote (copy)
    Emote.PlayClient(p4, ...);
    p4:_SetupProp(script.SurfProp);
    p4:_PlayAnimation("rbxassetid://126498832296593", "rbxassetid://88575062377123", 4);
    p4:CreateSound("rbxassetid://108806529299457", 1, 1 + 0.05 * math.random(), nil, true);
    p4:CreateSound("rbxassetid://137714378265704", 1, 1, nil, true).Looped = true;
end;

function u1._Init(p5) -- Line: 38
end;

return u1;