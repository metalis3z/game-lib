-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.Utility);
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(4.75, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 24
    -- upvalues: Emote (copy)
    Emote.PlayClient(p4, ...);
    local v5 = p4:_SetupMultipleProps(script.ShovelProp);
    p4:_PlayAnimation("rbxassetid://113838171758638");
    local v6 = script.Objects:GetChildren()[Random.new(p4._serial and p4._serial.Seed or p4._seed):NextInteger(1, #script.Objects:GetChildren())]:Clone();
    v6:PivotTo(v5.Item.CFrame * CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2));
    v6.Parent = v5.Item;

    for _, child in pairs(v6:GetChildren()) do
        child.CanCollide = false;
        child.CanTouch = false;
        child.CanQuery = false;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = child;
        WeldConstraint.Part1 = v5.Item;
        WeldConstraint.Parent = child;
        child.Anchored = false;
    end;

    p4:CreateSound("rbxassetid://109469242170265", 0.5, 1, nil, true, 10);
    wait(0.55);
    p4:CreateSound("rbxassetid://121837464389656", 1, 1, nil, true, 10);
    wait(0.35);
    p4:CreateSound("rbxassetid://83701499105576", 1, 1, nil, true, 10);
    wait(0.6);
    p4:CreateSound("rbxassetid://83701499105576", 0.9, 1.1, nil, true, 10);
    wait(0.6);
    p4:CreateSound("rbxassetid://83701499105576", 0.8, 1.2, nil, true, 10);
end;

function u1._Init(p7) -- Line: 61
end;

return u1;