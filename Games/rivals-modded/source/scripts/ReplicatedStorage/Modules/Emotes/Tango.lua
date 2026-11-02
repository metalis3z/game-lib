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
    p4:_PlayAnimation("rbxassetid://88145538779312", "rbxassetid://96300514550662", 1.2);
    p4:CreateSound("rbxassetid://139966463950646", 1, 1, nil, true).Looped = true;
    local v5 = p4._humanoid and p4._humanoid.Parent and p4._humanoid.Parent:FindFirstChild("Head");
    local v6 = script.Rose:Clone();
    v6:PivotTo(v5.CFrame);
    v6.Parent = v5;
    table.insert(p4._destroy_these, v6);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v5;
    WeldConstraint.Part1 = v6.Primary;
    WeldConstraint.Parent = v6;
end;

function u1._Init(p7) -- Line: 46
end;

return u1;