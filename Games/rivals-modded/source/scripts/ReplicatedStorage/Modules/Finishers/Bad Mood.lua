-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Color3_fromRGB_ret = Color3.fromRGB(221, 221, 221);
local Color3_fromRGB_ret2 = Color3.fromRGB(27, 42, 53);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 15
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(u4, ...) -- Line: 27
    -- upvalues: Ragdoll (copy), RunService (copy), Utility (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    Ragdoll.PlayClient(u4, ...);
    local u5 = script.Model:Clone();
    u5.Parent = workspace;
    table.insert(u4._destroy_these, u5);
    local u6 = u4._is_humanoid and u4._subject.RootPart or u4._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local v7 = RunService.Heartbeat:Connect(function() -- Line: 37
        -- upvalues: u5 (copy), u6 (copy), CFrame_Angles_ret (copy)
        u5:PivotTo(CFrame.new(u6.Position) * CFrame_Angles_ret);
    end);
    table.insert(u4._connections, v7);
    local success, result = pcall(u5.AnimationController.LoadAnimation, u5.AnimationController, u5.Animation);

    if success then
        result:Play(0);
        wait(1.375);
        u5.Cloud.vfx.water1.Enabled = true;
        u5.Cloud.vfx2.water2.Enabled = true;
        u5.Cloud.ground.ring1.Enabled = true;
        u5.Cloud.ground.splash1.Enabled = true;
        u4:_InternalThread(task.spawn, Utility.RenderstepForLoop, Utility, 0, 100, 2, function(p8) -- Line: 55
            -- upvalues: u5 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref)
            u5.Cloud.Color = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, 1 - (1 - p8 / 100) ^ 2);
        end);
        u4:_InternalThread(task.defer, function() -- Line: 61
            -- upvalues: Utility (ref), u5 (copy), u4 (copy)
            wait(0.5);
            Utility:PlayParticles(u5.Cloud.Thunder);
            u4:CreateSound("rbxassetid://79197041664081", 1.5, 0.75 + 0.25 * math.random(), nil, true, 5);
            wait(1);
            Utility:PlayParticles(u5.Cloud.Thunder);
            u4:CreateSound("rbxassetid://79197041664081", 1.5, 0.75 + 0.25 * math.random(), nil, true, 5);
            wait(0.3);
            Utility:PlayParticles(u5.Cloud.Thunder);
            u4:CreateSound("rbxassetid://79197041664081", 1.5, 0.75 + 0.25 * math.random(), nil, true, 5);
        end);
        u4:CreateSound("rbxassetid://114760171297145", 2, 1, nil, true, 5);
        wait(2.75);
        u5.Cloud.vfx.water1.Enabled = false;
        u5.Cloud.vfx2.water2.Enabled = false;
        u5.Cloud.ground.ring1.Enabled = false;
        u5.Cloud.ground.splash1.Enabled = false;
        u4:_InternalThread(task.spawn, Utility.RenderstepForLoop, Utility, 0, 100, 2, function(p9) -- Line: 87
            -- upvalues: u5 (copy), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret (ref)
            u5.Cloud.Color = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret, (p9 / 100) ^ 2);
        end);
        wait(1);
    end;

    u5:Destroy();
end;

function u1._Init(p10) -- Line: 103
end;

return u1;