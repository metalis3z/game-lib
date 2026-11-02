-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(6.2, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 23
    -- upvalues: Emote (copy)
    Emote.PlayClient(p4, ...);
    p4:_PlayAnimation("rbxassetid://137924113002985");
    local v5 = p4:_SetupMultipleProps(script.ItsTimeProp);
    wait(1.9);
    p4:CreateSound("rbxassetid://85464929329408", 1, 0.8 + 0.1 * math.random(), nil, true, 5);
    wait(0.65);
    p4:CreateSound("rbxassetid://85464929329408", 1, 0.9 + 0.1 * math.random(), nil, true, 5);
    wait(0.55);
    p4:CreateSound("rbxassetid://85464929329408", 1, 1 + 0.1 * math.random(), nil, true, 5);
    wait(0.35);
    p4:CreateSound("rbxassetid://135970869546121", 1.25, 1 + 0.1 * math.random(), nil, true, 5);
    wait(0.55);

    for _, v in pairs(v5) do
        v.LocalTransparencyModifier = 1;
    end;
end;

function u1._Init(p6) -- Line: 55
end;

return u1;