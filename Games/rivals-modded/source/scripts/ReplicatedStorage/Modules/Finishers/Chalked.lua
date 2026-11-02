-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 24
    -- upvalues: Ragdoll (copy), RunService (copy)
    Ragdoll.PlayClient(p4, ...);
    wait(0.25);
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local v6 = script.Chalk:Clone();
    v6.CFrame = CFrame.new(v5.Position) * CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0) + Vector3.new(0, 2, 0);
    v6.BodyGyro.CFrame = v6.CFrame;
    v6.Top.LocalTransparencyModifier = 1;
    v6.Bottom.LocalTransparencyModifier = 1;
    v6.Parent = workspace;
    table.insert(p4._destroy_these, v6);

    for _, v in pairs(p4:_GetObjects(true)) do
        if v:IsA("BasePart") then
            local NoCollisionConstraint = Instance.new("NoCollisionConstraint");
            NoCollisionConstraint.Part0 = v6;
            NoCollisionConstraint.Part1 = v;
            NoCollisionConstraint.Parent = v6;
        end;
    end;

    wait(0.25);
    local v7 = tick();

    while tick() < v7 + 0.5 do
        local v8 = (tick() - v7) / 0.5;
        local math_clamp_ret = math.clamp(v8, 0, 1);
        local v9 = 1 - (1 - math_clamp_ret) ^ 5;

        for _, v in pairs(p4:_GetObjects(true)) do
            if v:IsA("BasePart") or (v:IsA("Decal") or (v:IsA("Texture") or (v:IsA("Beam") or (v:IsA("ParticleEmitter") or v:IsA("Trail"))))) then
                v.LocalTransparencyModifier = v9;
            end;
        end;

        v6.Top.LocalTransparencyModifier = 1 - math_clamp_ret ^ 5;
        v6.Bottom.LocalTransparencyModifier = 1 - math_clamp_ret ^ 5;
        RunService.RenderStepped:Wait();
    end;

    wait(15);
end;

function u1._Init(p10) -- Line: 74
end;

return u1;