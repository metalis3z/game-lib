-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 15
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 27
    -- upvalues: Ragdoll (copy), Utility (copy)
    Ragdoll.PlayServer(p4, ...);
    wait(1);
    Utility:Knockback(p4._is_humanoid and p4._subject.RootPart or p4._subject, p4:_GetKnockbackDirection() * 75);
end;

function u1.PlayClient(p5, ...) -- Line: 38
    -- upvalues: Ragdoll (copy), Spring (copy), RunService (copy), Utility (copy)
    Ragdoll.PlayClient(p5, ...);
    local v6 = p5._is_humanoid and p5._subject.RootPart or p5._subject;
    local v7 = p5:_GetKnockbackDirection();
    local u8 = script.Model:Clone();
    u8.Parent = p5._subject;
    table.insert(p5._destroy_these, u8);
    local v9 = Spring.new(v6.Position + -v7 * Vector3.new(5, -5, 5) * 2, 1, 10);
    local v10 = tick();

    while tick() < v10 + 1 do
        v9.Target = v6.Position + -v7 * Vector3.new(1, -1, 1);
        u8:PivotTo(CFrame.new(v9.Value) * CFrame.new(Vector3.new(0, 0, 0), v7 * Vector3.new(1, 0, 1)));
        RunService.RenderStepped:Wait();
    end;

    p5:CreateSound("rbxassetid://120809068918800", 1.25, 1, nil, true, 5);
    p5:CreateSound("rbxassetid://92760487729234", 2.5, 1, nil, true, 5);
    u8.Before.Transparency = 1;
    u8.After.Transparency = 0;
    local u11 = u8.After.Size * 2;
    local Size = u8.After.Size;
    local CFrame2 = u8.After.CFrame;
    local math_abs_ret = math.abs(v7.Y);
    local u12 = (v7 * Vector3.new(1, 0, 1) + Vector3.new(0, math_abs_ret, 0)) * 2;
    Utility:RenderstepForLoop(0, 100, 4, function(p13) -- Line: 68
        -- upvalues: u8 (copy), u11 (copy), Size (copy), CFrame2 (copy), u12 (copy)
        local v14 = 1 - (1 - p13 / 100) ^ 3;
        u8.After.Size = u11:Lerp(Size, v14);
        u8.After.CFrame = CFrame2 + u12:Lerp(Vector3.new(0, 0, 0), v14);
    end);
    local CFrame3 = u8.After.CFrame;
    local u15 = u8.After.CFrame - Vector3.new(0, 10, 0);
    Utility:RenderstepForLoop(0, 100, 4, function(p16) -- Line: 78
        -- upvalues: u8 (copy), CFrame3 (copy), u15 (copy)
        u8.After.CFrame = CFrame3:Lerp(u15, (p16 / 100) ^ 3);
    end);
end;

function u1._GetKnockbackDirection(p17) -- Line: 89
    return (Random.new(p17._serial and p17._serial.Seed or p17._seed):NextUnitVector() * Vector3.new(1, 0, 1) + Vector3.new(0, 1, 0)).Unit;
end;

function u1._Init(p18) -- Line: 93
end;

return u1;