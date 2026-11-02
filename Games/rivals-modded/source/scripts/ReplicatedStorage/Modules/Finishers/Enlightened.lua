-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(u4) -- Line: 26
    u4:_AnchorModel(0);
    u4:_InternalThread(task.delay, 2, function() -- Line: 29
        -- upvalues: u4 (copy)
        u4:_AnchorModel(0, false);
        u4:_AnchorModel();
        u4:_BreakJoints();

        for _, v in pairs(u4:_GetObjects()) do
            if v:IsA("Clothing") then
                v:Destroy();
            end;

            if v:IsA("BasePart") then
                local v5 = v;

                for _, child in pairs(v:GetChildren()) do
                    if child:IsA("Texture") or child:IsA("Decal") then
                        child:Destroy();
                    end;
                end;

                v5.Material = Enum.Material.Neon;
                local BodyForce = Instance.new("BodyForce");
                BodyForce.Force = Vector3.new(0, 1, 0) * workspace.Gravity * v5:GetMass() * (1.25 + 0.5 * math.random());
                BodyForce.Parent = v5;
                local v6 = math.random() - 0.5;
                local v7 = math.random() - 0.5;
                v5.Velocity = Vector3.new(v6, 0, v7).Unit * 80 * math.random();
                local v8 = math.random() - 0.5;
                local v9 = math.random() - 0.5;
                local v10 = math.random() - 0.5;
                v5.RotVelocity = Vector3.new(v8, v9, v10) * 180 * math.random();
                v5.CFrame = v5.CFrame * CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2);
            end;
        end;
    end);
end;

function u1.PlayClient(u11, ...) -- Line: 62
    -- upvalues: RunService (copy), Color3_fromRGB_ret (copy), Utility (copy)
    local u12 = u11._is_humanoid and u11._subject.Parent or u11._subject;
    local v13 = u11._is_humanoid and u11._subject.Parent.Head or u11._subject;
    local v14 = u11._is_humanoid and u11._subject.RootPart or u11._subject;
    local Pivot = u12:GetPivot();
    local u15 = tick();
    local u16 = {};
    local u17 = {};
    table.insert(u11._connections, RunService.RenderStepped:Connect(function(p18) -- Line: 72
        -- upvalues: u15 (copy), u12 (copy), Pivot (copy), u11 (copy), u17 (copy), Color3_fromRGB_ret (ref), u16 (copy)
        if tick() >= u15 + 2 then
            return;
        end;

        local v19 = (tick() - u15) / 2;
        local math_clamp_ret = math.clamp(v19, 0, 1);
        local v20 = math.random() - 0.5;
        local v21 = math.random() - 0.5;
        local v22 = math.random() - 0.5;
        u12:PivotTo(Pivot + Vector3.new(v20, v21, v22) * 3 * math_clamp_ret ^ 3);

        for _, v in pairs(u11:_GetObjects(true)) do
            if v:IsA("BasePart") then
                u17[v] = u17[v] or v.Color;
                v.Color = u17[v]:Lerp(Color3_fromRGB_ret, math_clamp_ret);
            end;
        end;

        for _, v in pairs(u16) do
            local v23 = (tick() - u15 - v.AppearDelay) / 0.5;
            local math_clamp_ret2 = math.clamp(v23, 0, 1);

            for _, descendant in pairs(v.Object:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.LocalTransparencyModifier = 1 - math_clamp_ret2;
                end;
            end;
        end;
    end));

    local function add_effect(p24) -- Line: 99
        -- upvalues: u16 (copy)
        local v25 = {
            AppearDelay = 1.5 * math.random(),
            Object = p24
        };
        table.insert(u16, v25);
    end;

    for _, child in pairs(script.Head:GetChildren()) do
        local v26 = child:Clone();
        v26.Parent = v13;
        table.insert(u11._destroy_these, v26);
        local v27 = {
            AppearDelay = 1.5 * math.random(),
            Object = v26
        };
        table.insert(u16, v27);
    end;

    for _, v in pairs(u11:_GetObjects(true)) do
        if v:IsA("BasePart") and (v.Name ~= "Head" and v.Transparency <= 0.5) then
            local v28 = v;

            for i = 1, math.random(2, 6) do
                local Vector3_FromNormalId_ret = Vector3.FromNormalId(Enum.NormalId:GetEnumItems()[math.random(#Enum.NormalId:GetEnumItems())]);
                local v29 = v28.Size * Vector3_FromNormalId_ret / 2;
                local v30 = v28.Size * (Vector3.new(1, 1, 1) - Vector3_FromNormalId_ret * Vector3_FromNormalId_ret) * math.sign(Vector3_FromNormalId_ret.Magnitude);
                local v31 = math.random() - 0.5;
                local v32 = math.random() - 0.5;
                local v33 = math.random() - 0.5;
                local v34 = v29 + v30 * Vector3.new(v31, v32, v33);
                local v35 = script.Beam.Finish:Clone();
                v35.Parent = v28;
                table.insert(u11._destroy_these, v35);
                local v36 = script.Beam.Start:Clone();
                v36.Position = v34;
                v36.Beam1.Attachment1 = v35;
                v36.Beam2.Attachment1 = v35;
                v36.Beam3.Attachment1 = v35;
                v36.Parent = v28;
                table.insert(u11._destroy_these, v36);
                local v37 = {
                    AppearDelay = 1.5 * math.random(),
                    Object = v36
                };
                table.insert(u16, v37);
                v35.Position = v36.Position + Vector3_FromNormalId_ret * (0.5 + 1.5 * math.random());
                local _ = i;
            end;
        end;
    end;

    u11:CreateSound("rbxassetid://104941307595770", 1, 1, nil, true, 5);
    u11:CreateSound("rbxassetid://137299793298455", 1, 1, nil, true, 5);
    wait(2);

    for _, v in pairs(u16) do
        v.Object:Destroy();
    end;

    local v38 = script.Explosion:Clone();
    v38.CFrame = Pivot;
    v38.Parent = v14;
    table.insert(u11._destroy_these, v38);
    Utility:PlayParticles(v38);
    u11:CreateSound("rbxassetid://79678979817013", 1.5, 1, nil, true, 5);
end;

function u1._Init(p39) -- Line: 161
end;

return u1;