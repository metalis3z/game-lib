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
    p4:_PlayAnimation("rbxassetid://115000869501227", "rbxassetid://83376670167687", 4.15);
    p4:CreateSound("rbxassetid://80133530921906", 1.5, 1, nil, true);
    wait(15.54);
    p4:CreateSound("rbxassetid://98970356172671", 1.5, 1, nil, true).Looped = true;
end;

function u1._Init(p5) -- Line: 38
end;

return u1;