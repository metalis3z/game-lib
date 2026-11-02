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
    p4:_SetupProp(script.BroomProp);
    p4:_PlayAnimation("rbxassetid://111768394484614", "rbxassetid://92649987724159", 4.35);
    p4:CreateSound("rbxassetid://11169686206", 0.75, 1, nil, true, 10);
end;

function u1._Init(p5) -- Line: 37
end;

return u1;