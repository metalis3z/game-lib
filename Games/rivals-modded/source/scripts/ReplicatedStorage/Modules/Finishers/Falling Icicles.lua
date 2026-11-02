-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
require(ReplicatedStorage.Modules.BetterDebris);
require(ReplicatedStorage.Modules.Utility);
local TweenInfo_new_ret = TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 15
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 27
    -- upvalues: Ragdoll (copy), RunService (copy), TweenService (copy), TweenInfo_new_ret (copy)
    Ragdoll.PlayClient(p4, ...);
    local u5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local u6 = script.Model:Clone();
    u6.Parent = workspace;
    table.insert(p4._destroy_these, u6);
    local v7 = RunService.RenderStepped:Connect(function() -- Line: 37
        -- upvalues: u6 (copy), u5 (copy), CFrame_Angles_ret (copy)
        u6:PivotTo(CFrame.new(u5.Position) * CFrame_Angles_ret);
    end);
    table.insert(p4._connections, v7);
    local success, result = pcall(u6.AnimationController.LoadAnimation, u6.AnimationController, u6.Animation);

    if success then
        result:Play(0);
        result:AdjustSpeed(2);
        p4:_InternalThread(task.defer, function() -- Line: 49
            -- upvalues: u6 (copy), TweenService (ref), TweenInfo_new_ret (ref)
            local v8 = {};

            for i = 1, 16 do
                table.insert(v8, u6["Icicles" .. i]);
                local _ = i;
            end;

            local v9 = {};

            for _, v in pairs(v8) do
                v9[v] = v.Size;
                v.Size = Vector3.new(0, 0, 0);
            end;

            for _, v in pairs(v8) do
                TweenService:Create(v, TweenInfo_new_ret, {
                    Size = v9[v]
                }):Play();
                wait(0.05);
            end;
        end);
        p4:CreateSound("rbxassetid://93583856628897", 1, 1.5 + 0.2 * math.random(), nil, true, 5);
        wait(0.55);

        for i = 1, 6 do
            p4:CreateSound("rbxassetid://99261833097954", 0.8 + 0.2 * math.random(), 1 + 0.2 * math.random(), nil, true, 10);
            wait(0.05 + 0.1 * math.random());
            local _ = i;
        end;

        if result.IsPlaying then
            result.Stopped:Wait();
        end;
    end;

    u6:Destroy();
    v7:Disconnect();
end;

function u1._Init(p10) -- Line: 91
end;

return u1;