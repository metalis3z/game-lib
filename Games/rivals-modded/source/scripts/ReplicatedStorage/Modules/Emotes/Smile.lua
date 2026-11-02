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
    p4:_PlayAnimation("rbxassetid://98020061651338", "rbxassetid://99622591614050", 1.3);
    p4:CreateSound("rbxassetid://110965772629921", 1, 1, nil, true);
    wait(1.3);
    p4:CreateSound("rbxassetid://100664444144490", 1, 1, nil, true).Looped = true;
end;

function u1._Init(p5) -- Line: 38
end;

return u1;