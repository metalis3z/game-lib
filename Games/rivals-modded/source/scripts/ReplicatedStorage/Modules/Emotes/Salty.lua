-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(2.6, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 23
    -- upvalues: Emote (copy)
    Emote.PlayClient(p4, ...);
    p4:_PlayAnimation("rbxassetid://72081093559633");
    local u5 = {};

    for _, child in pairs(script.Particles:GetChildren()) do
        local v6 = child:Clone();
        local v7 = p4._humanoid.Parent and p4._humanoid.Parent:FindFirstChild("LeftHand");
        v6.Parent = v7;
        table.insert(u5, v6);
        table.insert(p4._destroy_these, v6);
    end;

    local function enable(p8) -- Line: 36
        -- upvalues: u5 (copy)
        for _, v in pairs(u5) do
            v.Enabled = p8;
        end;
    end;

    for _, v in pairs(u5) do
        v.Enabled = false;
    end;

    wait(0.5);
    p4:CreateSound("rbxassetid://82749828642126", 1, 1, nil, true, 5);
    wait(0.2);

    for _, v in pairs(u5) do
        v.Enabled = true;
    end;

    wait(0.6);

    for _, v in pairs(u5) do
        v.Enabled = false;
    end;
end;

function u1._Init(p9) -- Line: 55
end;

return u1;