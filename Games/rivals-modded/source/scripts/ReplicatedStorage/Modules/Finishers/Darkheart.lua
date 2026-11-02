-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(u4) -- Line: 21
    u4:_AnchorModel(0);
    u4:_InternalThread(task.delay, 0.25, function() -- Line: 24
        -- upvalues: u4 (copy)
        u4:_AnchorModel(0, false);
        u4:_AnchorModel();
        u4:_BreakJoints();

        if u4._is_humanoid then
            u4._subject.Parent:BreakJoints();
        end;

        for _, v in pairs(u4:_GetObjects()) do
            if v:IsA("BasePart") then
                local BodyVelocity = Instance.new("BodyVelocity");
                local v5 = math.random() - 0.5;
                local v6 = math.random() - 0.5;
                BodyVelocity.Velocity = Vector3.new(v5, 0, v6).Unit * 40;
                BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
                BodyVelocity.Parent = v;
                table.insert(u4._destroy_these, BodyVelocity);
                v.CFrame = v.CFrame * CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2);
            end;
        end;
    end);
end;

function u1.PlayClient(p7) -- Line: 49
    -- upvalues: Utility (copy)
    for _, v in pairs(p7:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(0, 0, 0);
            v.Material = Enum.Material.Glass;
            v.MaterialVariant = "";

            if v:IsA("MeshPart") then
                v.TextureID = "";
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            v.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0));
        elseif v:IsA("Texture") or v:IsA("Decal") then
            v.Color3 = Color3.fromRGB(0, 0, 0);
        elseif v:IsA("Clothing") or v:IsA("ShirtGraphic") then
            v:Destroy();
        end;
    end;

    for _, v in pairs(p7:_GetObjects()) do
        if v:IsA("BasePart") and v.Transparency <= 0 then
            local v8 = v;

            for _, child in pairs(script.Particles:GetChildren()) do
                local v9 = child:Clone();
                v9.Parent = v8;
                table.insert(p7._destroy_these, v9);
            end;
        end;
    end;

    p7:CreateSound("rbxassetid://133729942047865", 1, 1 + 0.2 * math.random(), p7._is_humanoid and p7._subject.RootPart.Position or p7._subject.Position, true, 5);
    wait(0.25);
    local v10 = {};

    for _, child in pairs(script.ExplodeParticles:GetChildren()) do
        local v11 = child:Clone();
        v11.Parent = p7._is_humanoid and p7._subject.RootPart or p7._subject;
        table.insert(p7._destroy_these, v11);
        table.insert(v10, v11);

        for _, descendant in pairs(v11:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                Utility:ScaleParticleEmitter(descendant, 3);
            end;
        end;
    end;

    Utility:PlayParticles(v10);
    p7:CreateSound("rbxassetid://90611785538933", 1, 0.8 + 0.2 * math.random(), p7._is_humanoid and p7._subject.RootPart.Position or p7._subject.Position, true, 10);
end;

function u1._Init(p12) -- Line: 110
end;

return u1;