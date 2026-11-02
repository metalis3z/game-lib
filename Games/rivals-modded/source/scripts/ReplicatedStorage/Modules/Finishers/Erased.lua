-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4) -- Line: 24
    -- upvalues: RunService (copy)
    local u5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    local u6 = script.Model:Clone();
    u6.Parent = workspace;
    table.insert(p4._destroy_these, u6);
    local v7 = RunService.RenderStepped:Connect(function() -- Line: 32
        -- upvalues: u6 (copy), u5 (copy), CFrame_Angles_ret (copy)
        u6:PivotTo(CFrame.new(u5.Position) * CFrame_Angles_ret * CFrame.Angles(1.5707963267948966, 0, 0));
    end);
    table.insert(p4._connections, v7);
    local success, result = pcall(u6.AnimationController.LoadAnimation, u6.AnimationController, u6.Animation);

    if success then
        result:Play(0);
        wait(0.65);
        p4:CreateSound("rbxassetid://121251326830312", 1.25, 1, nil, true, 5);
        wait(0.1);
        local v8 = {};

        for _, v in pairs(p4:_GetObjects(true)) do
            if v:IsA("BasePart") or (v:IsA("Decal") or (v:IsA("Texture") or (v:IsA("Beam") or (v:IsA("ParticleEmitter") or v:IsA("Trail"))))) then
                v8[v] = true;
            end;
        end;

        local v9 = tick();

        while tick() < v9 + 0.75 do
            local v10 = (tick() - v9) / 0.75;
            local math_clamp_ret = math.clamp(v10, 0, 1);

            for i in pairs(v8) do
                i.LocalTransparencyModifier = math_clamp_ret;
            end;

            RunService.RenderStepped:Wait();
        end;

        for i in pairs(v8) do
            i.LocalTransparencyModifier = 1;
        end;

        if result.IsPlaying then
            result.Stopped:Wait();
        end;
    end;

    u6:Destroy();
    v7:Disconnect();
end;

function u1._Init(p11) -- Line: 86
end;

return u1;