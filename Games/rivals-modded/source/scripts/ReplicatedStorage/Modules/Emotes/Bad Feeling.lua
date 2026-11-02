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
    p4:_PlayAnimation("rbxassetid://113081315310439", "rbxassetid://105533660677821", 1.3);
    local v5 = script.Part.Attachment:Clone();
    v5.Name = "BadFeeling";
    v5.Parent = p4._humanoid.Parent:FindFirstChild("Head");
    table.insert(p4._destroy_these, v5);
    p4:CreateSound("rbxassetid://104971481474038", 0.75, 1, nil, true).Looped = true;
end;

function u1._Init(p6) -- Line: 41
end;

return u1;