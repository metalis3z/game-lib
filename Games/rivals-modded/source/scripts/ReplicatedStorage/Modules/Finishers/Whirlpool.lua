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
    -- upvalues: Ragdoll (copy), RunService (copy)
    Ragdoll.PlayServer(p4, ...);
    p4:_AnchorModel(0, false);
    local u5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local Position = u5.Position;
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.MaxForce = Vector3.new(0, 100000, 0);
    BodyPosition.Position = Position;
    BodyPosition.Parent = u5;
    table.insert(p4._destroy_these, BodyPosition);
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = u5;
    table.insert(p4._destroy_these, Attachment);
    local VectorForce = Instance.new("VectorForce");
    VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World;
    VectorForce.Attachment0 = Attachment;
    VectorForce.Parent = u5;
    table.insert(p4._destroy_these, VectorForce);
    table.insert(p4._connections, RunService.Heartbeat:Connect(function() -- Line: 46
        -- upvalues: u5 (copy), Position (copy), VectorForce (copy)
        local CFrame_new_ret = CFrame.new(u5.Position * Vector3.new(1, 0, 1), Position * Vector3.new(1, 0, 1));

        if CFrame_new_ret ~= CFrame_new_ret then
            CFrame_new_ret = CFrame.new(Vector3.new(0, 0, 0), (Random.new():NextUnitVector() * Vector3.new(1, 0, 1)).Unit);
        end;

        local v6 = (CFrame_new_ret.RightVector * 0.15 + CFrame_new_ret.LookVector) * 5000;
        VectorForce.Force = v6.Unit * math.min(v6.Magnitude, 5000);
    end));
end;

function u1.PlayClient(u7, ...) -- Line: 55
    -- upvalues: Ragdoll (copy), Spring (copy), RunService (copy), Utility (copy)
    Ragdoll.PlayClient(u7, ...);
    local v8 = u7._is_humanoid and u7._subject.RootPart or u7._subject;
    local Position = v8.Position;
    local u9 = script.Model:Clone();
    u9.Parent = u7._subject;
    table.insert(u7._destroy_these, u9);
    local u10 = u7:_GetObjects(true);
    local u11 = Spring.new(v8.Position, 1, 2);
    table.insert(u7._connections, RunService.RenderStepped:Connect(function() -- Line: 68
        -- upvalues: u11 (copy), u7 (copy), Position (copy), u10 (copy), u9 (copy)
        u11.Target = u7:_GetGroundPosition(Position, u10);
        u9:PivotTo(CFrame.new(u11.Value.X, u11.Target.Y, u11.Value.Z));
    end));
    u7:CreateSound("rbxassetid://115011821762260", 1.25, 1 + 0.1 * math.random(), nil, true, 5);
    u7:CreateSound("rbxassetid://138046245903208", 0.375, 1 + 0.1 * math.random(), nil, true, 5);
    wait(2);
    Utility:RenderstepForLoop(0, 100, 0.5, function(p12) -- Line: 78
        -- upvalues: u7 (copy)
        local v13 = 1 - (1 - p12 / 100) ^ 3;

        for _, v in pairs(u7:_GetObjects(true)) do
            if v:IsA("BasePart") then
                v.LocalTransparencyModifier = v13;
            end;
        end;
    end);
end;

function u1._Init(p14) -- Line: 93
end;

return u1;