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
    p4:_SetupProp(script.HorseProp);
    p4:_PlayAnimation("rbxassetid://90957073891780", "rbxassetid://131785768380910", 4.45);
    p4:CreateSound("rbxassetid://119722200205656", 1, 1, nil, true);
    p4:CreateSound("rbxassetid://100899302728675", 0.5, 1, nil, true).Looped = true;
end;

function u1._Init(p5) -- Line: 37
end;

return u1;