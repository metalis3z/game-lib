-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.Utility);
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(7.4, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 24
    -- upvalues: Emote (copy)
    Emote.PlayClient(p4, ...);
    p4:_SetupProp(script.AwardProp);
    p4:_PlayAnimation("rbxassetid://84334527267845");
    p4:CreateSound("rbxassetid://82968610908198", 1, 0.95 + 0.1 * math.random(), nil, true, 10);
end;

function u1._Init(p5) -- Line: 35
end;

return u1;