-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 16
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(u4, ...) -- Line: 28
    -- upvalues: Ragdoll (copy), RunService (copy)
    Ragdoll.PlayClient(u4, ...);
    local u5 = u4._is_humanoid and u4._subject.RootPart or u4._subject;
    u4:CreateSound("rbxassetid://125154957015218", 0.5, 0.975 + 0.05 * math.random(), nil, true, 20);

    local function spawn_tumbleweed(p6) -- Line: 35
        -- upvalues: u4 (copy), u5 (copy), RunService (ref)
        local v7 = script.Tumbleweed:Clone();
        v7.PrimaryPart = v7.Primary;
        v7.Parent = workspace;
        table.insert(u4._destroy_these, v7);
        local v8 = p6 + Vector3.new(0, 1, 0) * v7.PrimaryPart.Size.Y / 2;
        local RightVector = CFrame.new(v8 * Vector3.new(1, 0, 1), u5.Position * Vector3.new(1, 0, 1)).RightVector;
        local v9 = math.random() - 0.5;
        local v10 = RightVector * math.sign(v9);
        local v11 = v8 - v10 * 20 / 2;
        local v12 = v8 + v10 * 20 / 2;
        local CFrame_identity = CFrame.identity;
        local v13 = Random.new():NextUnitVector() * 0.08726646259971647 * 60;
        local v14 = tick();
        local v15 = tick() + 3;

        while not u4._destroyed and tick() < v15 do
            local v16 = (tick() - v14) / 3;
            local math_clamp_ret = math.clamp(v16, 0, 1);
            local math_sin_ret = math.sin(12.566370614359172 * math_clamp_ret);
            local math_abs_ret = math.abs(math_sin_ret);
            local v17 = v11:Lerp(v12, math_clamp_ret) + Vector3.new(0, 1, 0) * math_abs_ret * 3;
            local v18 = math.sin(3.141592653589793 * (math_clamp_ret - 0.5)) ^ 10;
            local math_abs_ret2 = math.abs(v18);
            v7:PivotTo(CFrame.new(v17) * CFrame_identity);

            for _, child in pairs(v7:GetChildren()) do
                if child:IsA("BasePart") then
                    child.LocalTransparencyModifier = math_abs_ret2;
                end;
            end;

            local v19 = RunService.RenderStepped:Wait();
            CFrame_identity = CFrame_identity * CFrame.Angles(v13.X * v19, v13.Y * v19, v13.Z * v19);
        end;

        v7:Destroy();
    end;

    for i = 1, 15 do
        local v20 = math.random() * 3.141592653589793 * 2;
        local v21 = u4:_GetGroundPosition(u5.Position);
        local math_cos_ret = math.cos(v20);
        local math_sin_ret = math.sin(v20);
        local v22 = v21 + Vector3.new(math_cos_ret, 0, math_sin_ret) * (0.25 + 3 * math.random());
        u4:_InternalThread(task.spawn, spawn_tumbleweed, v22);
        wait(0.25);
        local _ = i;
    end;

    wait(3);
end;

function u1._Init(p23) -- Line: 88
end;

return u1;