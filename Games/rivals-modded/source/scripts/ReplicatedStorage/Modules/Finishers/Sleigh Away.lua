-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 20
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    v5.Anchored = true;

    if p4._is_humanoid then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://4769412289";
        local success, result = pcall(p4._subject.LoadAnimation, p4._subject, Animation);

        if success then
            result:Play(0);
            result:AdjustSpeed(0.16666666666666666);
        end;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Parent = v5;
    table.insert(p4._destroy_these, Attachment);
    local v6 = script.Model:Clone();
    v6:PivotTo(CFrame.new(v5.Position) * CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0));
    v6.Parent = workspace;
    table.insert(p4._destroy_these, v6);
    local success, result = pcall(v6.AnimationController.LoadAnimation, v6.AnimationController, v6.Animation);

    if success then
        result:Play(0);
        p4:CreateSound("rbxassetid://70986468462566", 1.5, 1 + 0.1 * math.random(), v6.HumanoidRootPart, true, 5);
        wait(0.3);
        local v7 = {};

        for _, v in pairs(p4:_GetObjects(true)) do
            if v:IsA("BasePart") then
                v7[v] = v.CollisionGroup;
                v.CollisionGroup = "Noclip";
            end;
        end;

        v5.Anchored = false;
        p4:_Ragdoll();
        local AlignPosition = Instance.new("AlignPosition");
        AlignPosition.RigidityEnabled = true;
        AlignPosition.ApplyAtCenterOfMass = true;
        AlignPosition.Attachment1 = v6.Broomm.Attachment;
        AlignPosition.Attachment0 = Attachment;
        AlignPosition.Parent = v6;
        table.insert(p4._destroy_these, AlignPosition);
        wait(1.9);
        wait(0.75);
        AlignPosition:Destroy();
        p4:_AnchorModel();

        for i, v in pairs(v7) do
            i.CollisionGroup = v;
        end;

        if result.IsPlaying then
            result.Stopped:Wait();
        end;

        v6:Destroy();
        wait(3);
    end;
end;

function u1._Init(p8) -- Line: 102
end;

return u1;