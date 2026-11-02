-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
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
    -- upvalues: Ragdoll (copy), BetterDebris (copy)
    Ragdoll.PlayServer(p4, ...);
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000);
    BodyVelocity.Velocity = (CFrame.new(Vector3.new(0, 0, 0), Vector3.new(0, 1, 0)) * CFrame.Angles(0, 0, math.random() * 3.141592653589793 * 2) * CFrame.Angles(0, 0.7853981633974483 * (math.random() - 0.5), 0)).LookVector * 100;
    BodyVelocity.Parent = v5;
    BetterDebris:AddItem(BodyVelocity, 0.25);
end;

function u1.PlayClient(p6, ...) -- Line: 37
    -- upvalues: Ragdoll (copy), RunService (copy)
    Ragdoll.PlayClient(p6, ...);
    local v7 = p6._is_humanoid and p6._subject.RootPart or p6._subject;
    local u8 = p6._is_humanoid and p6._subject.Parent.Head or p6._subject;
    local u9 = script.Particles:Clone();
    u9.CollisionGroup = "IgnorePlayers";
    u9.CFrame = CFrame.new(v7.Position) * CFrame.Angles(-1.5707963267948966, 0, 0) - Vector3.new(0, 3, 0);
    u9.Parent = workspace;
    table.insert(p6._destroy_these, u9);
    local u10 = nil;
    local u11 = 0;
    local u12 = tick();
    local v16 = RunService.RenderStepped:Connect(function(p13) -- Line: 53
        -- upvalues: u11 (ref), u9 (copy), u10 (ref), u12 (copy), u8 (copy)
        u11 = u11 + p13;
        u9.Finish.Puddle.Size = NumberSequence.new(u11 * 5 + 1);

        if not u10 then
            u9.Start.WorldCFrame = u8.CFrame;

            return;
        end;

        local v14 = tick() - u12 - 0.5;
        local v15 = u10.Position + (u9.Finish.WorldPosition - u10.Position).Unit * math.clamp(v14 * 64, 0, (u9.Finish.WorldPosition - u10.Position).Magnitude);
        u9.Start.WorldCFrame = CFrame.new(v15) * u10.Rotation;
    end);
    table.insert(p6._connections, v16);
    p6:CreateSound("rbxassetid://93843878451088", 1.5, 1, nil, true, 5);
    p6:CreateSound("rbxassetid://108905869931161", 2, 1, nil, true, 5);
    wait(0.5);
    u10 = u8.CFrame;
    wait((u10.Position - u9.Finish.WorldPosition).Magnitude / 64);
    v16:Disconnect();

    for _, descendant in pairs(u9:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = descendant.Name == "Puddle";
        end;
    end;

    wait(2);
    u9.Finish.Puddle.Enabled = false;
    wait(3);
end;

function u1._Init(p17) -- Line: 98
end;

return u1;