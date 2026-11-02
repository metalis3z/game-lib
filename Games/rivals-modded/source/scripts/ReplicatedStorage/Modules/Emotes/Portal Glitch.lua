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

function u1.PlayClient(u4, ...) -- Line: 25
    -- upvalues: Emote (copy)
    Emote.PlayClient(u4, ...);
    u4:_SetupProp(script.PortalProp);
    u4:_PlayAnimation("rbxassetid://114622720984788", "rbxassetid://100757699753241", 1.15);
    u4:_InternalThread(task.spawn, function() -- Line: 30
        -- upvalues: u4 (copy)
        wait(0.9);
        u4:CreateSound("rbxassetid://81610952487049", 0.375, 1 + 0.1 * math.random(), nil, true, 5);
        u4:CreateSound("rbxassetid://7127702569", 0.25, 1 + 0.25 * math.random(), nil, true, 5);
        wait(0.266);

        for i = 1, (1 / 0) do
            u4:CreateSound("rbxassetid://81610952487049", 0.25, 1 + 0.1 * math.random(), nil, true, 5);
            u4:CreateSound("rbxassetid://7127702569", 0.5 / ((i - 1) * 0.25 + 1), 1 + 0.25 * math.random(), nil, true, 5);
            wait(0.26666666666666666);
            local _ = i;
        end;
    end);
end;

function u1._Init(p5) -- Line: 51
end;

return u1;