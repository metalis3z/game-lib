-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 23
    -- upvalues: Ragdoll (copy), BetterDebris (copy)
    Ragdoll.PlayServer(p4, ...);
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local BodyAngularVelocity = Instance.new("BodyAngularVelocity");
    BodyAngularVelocity.MaxTorque = Vector3.new(100000, 100000, 100000);
    BodyAngularVelocity.AngularVelocity = Random.new():NextUnitVector() * 10;
    BodyAngularVelocity.Parent = v5;
    BetterDebris:AddItem(BodyAngularVelocity, 3);
    local v6 = nil;

    for _, v in pairs(p4:_GetObjects()) do
        if v:IsA("BasePart") then
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * (v == v5 and 10000 or 500);
            BodyVelocity.Velocity = Vector3.new(0, 2, 0);
            BodyVelocity.Parent = v;
            BetterDebris:AddItem(BodyVelocity, 3);

            if v == v5 then
                v6 = BodyVelocity;
            end;
        end;
    end;

    wait(0.25);

    if v6 then
        v6.Velocity = v6.Velocity * 150;
    end;
end;

function u1.PlayClient(u7, ...) -- Line: 57
    -- upvalues: Ragdoll (copy), Utility (copy)
    Ragdoll.PlayClient(u7, ...);
    local v8 = u7._is_humanoid and u7._subject.RootPart or u7._subject;
    local u9 = script.Particles:Clone();
    u9.CFrame = CFrame.new(v8.Position) * CFrame.Angles(0, 0, 1.5707963267948966) - Vector3.new(0, 2, 0);
    u9.Parent = v8;
    table.insert(u7._destroy_these, u9);
    u7:CreateSound("rbxassetid://116502031018076", 1.5, 0.95 + 0.1 * math.random(), u9, true, 10);
    u7:_InternalThread(task.delay, 0.1, u7.CreateSound, u7, "rbxassetid://76502718325596", 1.5, 0.95 + 0.1 * math.random(), u9, true, 10);
    local u10 = {};
    Utility:RenderstepForLoop(0, 100, 4, function(p11) -- Line: 72
        -- upvalues: u9 (copy), u10 (copy)
        local v12 = 1 - (p11 / 100) ^ 3;

        for _, descendant in pairs(u9:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                u10[descendant] = u10[descendant] or descendant.Width1;
                descendant.Width1 = u10[descendant] * v12;
            elseif descendant:IsA("Light") then
                u10[descendant] = u10[descendant] or descendant.Brightness;
                descendant.Brightness = u10[descendant] * v12;
            end;
        end;
    end);

    for _, descendant in pairs(u9:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    Utility:RenderstepForLoop(0, 100, 4, function(p13) -- Line: 92
        -- upvalues: u7 (copy)
        local v14 = 1 - (1 - p13 / 100) ^ 3;

        for _, v in pairs(u7:_GetObjects(true)) do
            if v:IsA("BasePart") then
                v.LocalTransparencyModifier = v14;
            end;
        end;
    end);

    for _, v in pairs(u7:_GetObjects(true)) do
        if v:IsA("BasePart") and v ~= v8 then
            v:Destroy();
        end;
    end;

    u9:Destroy();
end;

function u1._Init(p15) -- Line: 115
end;

return u1;