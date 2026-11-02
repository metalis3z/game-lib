-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
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
    -- upvalues: Ragdoll (copy)
    Ragdoll.PlayServer(p4, ...);
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    v5.CFrame = CFrame.new(p4:_GetGroundPosition(v5.Position, p4:_GetObjects(true))) * v5.CFrame.Rotation + Vector3.new(0, 2, 0);
end;

function u1.PlayClient(u6, ...) -- Line: 31
    -- upvalues: Ragdoll (copy), Utility (copy), Spring (copy), RunService (copy)
    Ragdoll.PlayClient(u6, ...);
    local u7 = u6._is_humanoid and u6._subject.RootPart or u6._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local u8 = script.Model:Clone();
    u8.Parent = u6._subject;
    table.insert(u6._destroy_these, u8);
    local v9 = script.Particles:Clone();
    v9.CFrame = CFrame.new(u7.Position);
    v9.Parent = u7;
    table.insert(u6._destroy_these, v9);
    Utility:PlayParticles(v9);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v9;
    WeldConstraint.Part1 = u7;
    WeldConstraint.Parent = v9;
    local u10 = u6:_GetObjects(true);
    local u11 = Spring.new(u7.Position, 1, 2);
    table.insert(u6._connections, RunService.RenderStepped:Connect(function() -- Line: 55
        -- upvalues: u11 (copy), u6 (copy), u7 (copy), u10 (copy), u8 (copy), CFrame_Angles_ret (copy)
        u11.Target = u6:_GetGroundPosition(u7.Position, u10);
        u8:PivotTo(CFrame.new(u11.Value.X, u11.Target.Y, u11.Value.Z) * CFrame_Angles_ret);
    end));
    u6:CreateSound("rbxassetid://17812496122", 1, 1.1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p12) -- Line: 67
end;

return u1;