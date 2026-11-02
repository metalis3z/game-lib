-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.CONSTANTS);
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
    -- upvalues: Utility (copy)
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = v5;
    local AngularVelocity = Instance.new("AngularVelocity");
    AngularVelocity.MaxTorque = 10000;
    AngularVelocity.AngularVelocity = Random.new():NextUnitVector() * 5;
    AngularVelocity.Attachment0 = Attachment;
    AngularVelocity.Parent = v5;
    table.insert(p4._destroy_these, AngularVelocity);
    local v6 = script.Guide:Clone();
    local BodyForce = v6.BodyForce;
    local v7 = workspace.Gravity * v6:GetMass() * 0.875;
    BodyForce.Force = Vector3.new(0, v7, 0);
    v6.CFrame = v5.CFrame;
    v6.CollisionGroup = v5.CollisionGroup;

    for _, v in pairs(p4:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Massless = true;
            local NoCollisionConstraint = Instance.new("NoCollisionConstraint");
            NoCollisionConstraint.Part0 = v6;
            NoCollisionConstraint.Part1 = v;
            NoCollisionConstraint.Parent = v6;
        end;
    end;

    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = v5;
    local AlignPosition = Instance.new("AlignPosition");
    AlignPosition.Attachment0 = Attachment2;
    AlignPosition.Attachment1 = v6.Attachment;
    AlignPosition.MaxForce = 1000000;
    AlignPosition.MaxVelocity = 32;
    AlignPosition.Parent = v6;
    v6.Parent = workspace;
    table.insert(p4._destroy_these, v6);
    Utility:Knockback(v6, Random.new():NextUnitVector() * Vector3.new(1, 0, 1) * 10 + Vector3.new(0, 15, 0));
    p4:_Ragdoll();
end;

function u1.PlayClient(p8) -- Line: 69
    p8:CreateSound("rbxassetid://115089214845604", 1, 1 + 0.1 * math.random(), nil, true, 10);
end;

function u1._Init(p9) -- Line: 77
end;

return u1;