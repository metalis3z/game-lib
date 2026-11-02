-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
require(ReplicatedStorage.Modules.BetterDebris);
require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(u4, ...) -- Line: 23
    -- upvalues: Ragdoll (copy), RunService (copy)
    Ragdoll.PlayClient(u4, ...);
    local u5 = u4._is_humanoid and u4._subject.RootPart or u4._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local u6 = script.Model:Clone();
    u6.Parent = workspace;
    table.insert(u4._destroy_these, u6);
    local v7 = RunService.RenderStepped:Connect(function() -- Line: 33
        -- upvalues: u6 (copy), u5 (copy), CFrame_Angles_ret (copy)
        u6:PivotTo(CFrame.new(u5.Position) * CFrame_Angles_ret);
    end);
    table.insert(u4._connections, v7);
    local success, result = pcall(u6.AnimationController.LoadAnimation, u6.AnimationController, u6.Animation);

    if success then
        result:Play(0);
        u4:_InternalThread(task.spawn, function() -- Line: 44
            -- upvalues: u4 (copy), u5 (copy)
            u4:CreateSound("rbxassetid://110123816156526", 1.25, 0.95 + 0.1 * math.random(), u5, true, 10);
            u4:CreateSound("rbxassetid://138871941931946", 1, 0.95 + 0.1 * math.random(), nil, true, 5);
        end);

        if result.IsPlaying then
            result.Stopped:Wait();
        end;
    end;

    u6:Destroy();
    v7:Disconnect();
end;

function u1._Init(p8) -- Line: 62
end;

return u1;