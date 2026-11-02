-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 22
    p4:_BreakJoints();
    p4:_AnchorModel();

    for _, v in pairs(p4:_GetObjects()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            local v5 = math.random() - 0.5;
            local math_random_ret = math.random();
            local v6 = math.random() - 0.5;
            v.AssemblyLinearVelocity = Vector3.new(v5, math_random_ret, v6) * 128;
            local v7 = math.random() - 0.5;
            local math_random_ret2 = math.random();
            local v8 = math.random() - 0.5;
            v.AssemblyAngularVelocity = Vector3.new(v7, math_random_ret2, v8) * 32;
        end;
    end;
end;

function u1.PlayClient(p9) -- Line: 34
    -- upvalues: BetterDebris (copy), Utility (copy)
    p9:CreateSound("rbxassetid://119382605046173", 1, 1 + 0.1 * math.random(), nil, true, 5);
    local v10 = script.Explosion:Clone();
    v10.CFrame = (p9._is_humanoid and p9._subject.RootPart or p9._subject).CFrame;
    v10.Parent = p9._subject;
    table.insert(p9._destroy_these, v10);
    BetterDebris:AddItem(v10, 5);
    Utility:PlayParticles(v10);
end;

function u1._Init(p11) -- Line: 49
end;

return u1;