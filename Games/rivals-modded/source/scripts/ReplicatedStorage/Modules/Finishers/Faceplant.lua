-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 23
    -- upvalues: BetterDebris (copy)
    local RootPart = p4._subject.RootPart;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
    BodyVelocity.MaxForce = Vector3.new(10000, 0, 10000);
    BodyVelocity.Parent = RootPart;
    table.insert(p4._destroy_these, BodyVelocity);
    BetterDebris:AddItem(BodyVelocity, 1.05);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.CFrame = CFrame.new(Vector3.new(0, 0, 0), RootPart.CFrame.LookVector * Vector3.new(1, 0, 1));
    BodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000);
    BodyGyro.Parent = RootPart;
    table.insert(p4._destroy_these, BodyGyro);
    BetterDebris:AddItem(BodyGyro, 1.05);
    wait(1.05);
    p4:_Ragdoll();
    p4:_AnchorModel();
end;

function u1.PlayClient(p5) -- Line: 46
    if not p5._is_humanoid then
        return;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://85156698673400";
    local success, result = pcall(p5._subject.LoadAnimation, p5._subject, Animation);

    if success then
        result:Play(0);
    end;
end;

function u1._Init(p6) -- Line: 65
end;

return u1;