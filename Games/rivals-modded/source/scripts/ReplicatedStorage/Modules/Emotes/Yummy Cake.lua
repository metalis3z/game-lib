-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.Utility);
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(2.15, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 24
    -- upvalues: Emote (copy)
    Emote.PlayClient(p4, ...);
    p4:_SetupProp(script.CakeProp);
    p4:_PlayAnimation("rbxassetid://100896527733090");
    wait(1.2);
    p4:CreateSound("rbxassetid://18128895977", 1.25, 1, nil, true, 5);
    p4:CreateSound("rbxassetid://99386279085681", 1.25, 1, nil, true, 5);
end;

function u1._Init(p5) -- Line: 38
end;

return u1;