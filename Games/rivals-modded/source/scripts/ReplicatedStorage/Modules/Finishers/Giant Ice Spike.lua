-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
require(ReplicatedStorage.Modules.Utility);
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
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
    -- upvalues: Ragdoll (copy), BetterDebris (copy)
    Ragdoll.PlayServer(p4, ...);
    local v5 = p4._is_humanoid and (p4._subject.Parent:FindFirstChild("UpperTorso") or p4._subject.RootPart) or p4._subject;
    local v6 = p4._eliminator and p4._eliminator.Character and p4._eliminator.Character:FindFirstChild("HumanoidRootPart");

    if not v6 then
        return;
    end;

    for _, v in pairs(p4:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.CustomPhysicalProperties = PhysicalProperties.new(v.CurrentPhysicalProperties.Density, 2, 0, 100, 100);
        end;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000);
    BodyVelocity.Velocity = CFrame.new(v6.Position, v5.Position).LookVector * 300;
    BodyVelocity.Parent = v5;
    BetterDebris:AddItem(BodyVelocity, 5);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.CFrame = CFrame.new(v5.Position, v6.Position);
    BodyGyro.Parent = v5;
    BetterDebris:AddItem(BodyGyro, 5);
end;

function u1.PlayClient(p7, ...) -- Line: 55
    -- upvalues: Ragdoll (copy), BetterDebris (copy), TweenInfo_new_ret (copy), TweenService (copy)
    Ragdoll.PlayClient(p7, ...);
    local v8 = p7._is_humanoid and (p7._subject.Parent:FindFirstChild("UpperTorso") or p7._subject.RootPart) or p7._subject;
    local v9 = script.Icicle:Clone();
    v9.CFrame = v8.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0);
    v9.WeldConstraint.Part0 = v8;
    v9.Parent = v8;
    table.insert(p7._destroy_these, v9);
    BetterDebris:AddItem(v9.WeldConstraint, 5 + TweenInfo_new_ret.Time / 2);
    p7:CreateSound("rbxassetid://73317248668904", 1, 1 + 0.1 * math.random(), nil, true, 5);
    p7:CreateSound("rbxassetid://115260318005653", 1.5, 1 + 0.1 * math.random(), nil, true, 5);
    wait(5);
    TweenService:Create(v9, TweenInfo_new_ret, {
        Size = Vector3.new(0, 0, 0)
    }):Play();
    wait(TweenInfo_new_ret.Time);
end;

function u1._Init(p10) -- Line: 81
end;

return u1;