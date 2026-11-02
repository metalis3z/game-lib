-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 25
    -- upvalues: Ragdoll (copy), Utility (copy)
    Ragdoll.PlayServer(p4, ...);
    wait(0.5);
    Utility:Knockback(p4._is_humanoid and p4._subject.RootPart or p4._subject, (p4:_GetKnockbackDirection() + Vector3.new(0, 0.25, 0)).Unit * 75);
end;

function u1.PlayClient(p5, ...) -- Line: 36
    -- upvalues: Ragdoll (copy), RunService (copy)
    Ragdoll.PlayClient(p5, ...);
    local u6 = p5._is_humanoid and p5._subject.RootPart or p5._subject;
    local u7 = p5:_GetGroundPosition(u6.Position, p5:_GetObjects(true));
    local u8 = p5:CreateSound("rbxassetid://137714378265704", 1, 1, u6, true);

    if u8 then
        u8.Looped = true;
    end;

    local u9 = script.Model:Clone();
    u9.Parent = p5._subject;
    table.insert(p5._destroy_these, u9);
    local u10 = {};

    for _, descendant in pairs(u9:GetDescendants()) do
        if descendant:IsA("BasePart") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
            table.insert(u10, descendant);
        end;
    end;

    local u11 = nil;
    local u12 = p5:_GetKnockbackDirection();
    local u13 = tick();
    local v16 = RunService.RenderStepped:Connect(function() -- Line: 64
        -- upvalues: u13 (copy), u11 (ref), u6 (copy), u9 (copy), u7 (copy), u12 (copy), u10 (copy), u8 (copy)
        local v14 = (tick() - u13) / 1.5;
        local math_clamp_ret = math.clamp(v14, 0, 1);
        local v15 = (1 - math.sin(3.141592653589793 * math_clamp_ret)) ^ 10;

        if not u11 or math_clamp_ret < 0.4 then
            u11 = u6.Position;
        end;

        u9:PivotTo(CFrame.new(u11.X, u7.Y, u11.Z) * CFrame.new(Vector3.new(0, 0, 0), -u12).Rotation * CFrame.new(0, 0, math_clamp_ret * 64 + -32) * CFrame.Angles(0, -1.5707963267948966, 0));

        for _, v in pairs(u10) do
            v.LocalTransparencyModifier = v15;
        end;

        if u8 then
            u8.Volume = 1 - v15;
        end;
    end);
    table.insert(p5._connections, v16);
    wait(0.75);
    p5:CreateSound("rbxassetid://108806529299457", 1, 1.25 + 0.25 * math.random(), u6, true);
    wait(0.75);
    v16:Disconnect();
    u9:Destroy();
end;

function u1._GetKnockbackDirection(p17) -- Line: 99
    return (Random.new(p17._serial and p17._serial.Seed or p17._seed):NextUnitVector() * Vector3.new(1, 0, 1)).Unit;
end;

function u1._Init(p18) -- Line: 103
end;

return u1;