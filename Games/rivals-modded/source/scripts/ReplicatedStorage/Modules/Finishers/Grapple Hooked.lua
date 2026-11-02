-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 24
    -- upvalues: RunService (copy)
    p4:_Ragdoll();
    p4:_AnchorModel(0, false);
    p4:_AnchorModel(6.2);
    local u5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = u5;
    table.insert(p4._destroy_these, Attachment);
    local u6 = script.Model:Clone();
    u6.Parent = workspace;
    table.insert(p4._destroy_these, u6);
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local v7 = RunService.Heartbeat:Connect(function() -- Line: 41
        -- upvalues: u6 (copy), u5 (copy), CFrame_Angles_ret (copy)
        u6:PivotTo(CFrame.new(u5.Position) * CFrame_Angles_ret - Vector3.new(0, 1.5, 0));
    end);
    table.insert(p4._connections, v7);
    local success, result = pcall(u6.AnimationController.LoadAnimation, u6.AnimationController, u6.Animation);

    if success then
        result:Play(0);
        p4:CreateSound("rbxassetid://92178332551602", 1, 1 + 0.1 * math.random(), nil, true, 5);
        wait(1.95);
        p4:CreateSound("rbxassetid://8971407217", 1, 1 + 0.1 * math.random(), nil, true, 5);
        v7:Disconnect();
        Attachment.WorldCFrame = u6.Hook.Attachment.WorldCFrame;
        local AlignPosition = Instance.new("AlignPosition");
        AlignPosition.RigidityEnabled = true;
        AlignPosition.Attachment1 = u6.Hook.Attachment;
        AlignPosition.Attachment0 = Attachment;
        AlignPosition.Parent = u6;
        table.insert(p4._destroy_these, AlignPosition);
        wait(0.75);
        p4:CreateSound("rbxassetid://105623111691289", 1, 1 + 0.1 * math.random(), nil, true, 5);
        wait(0.5);
        AlignPosition:Destroy();
        Attachment:Destroy();
        p4:_AnchorModel();
    end;

    v7:Disconnect();
    u6:Destroy();
end;

function u1._Init(p8) -- Line: 87
end;

return u1;