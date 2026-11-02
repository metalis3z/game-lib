-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = { "rbxassetid://1848267914", "rbxassetid://1848267930", "rbxassetid://9038367984", "rbxassetid://9042144091", "rbxassetid://9038367978" };
local u2 = setmetatable({}, Finisher);
u2.__index = u2;

function u2.new(...) -- Line: 11
    -- upvalues: Finisher (copy), u2 (copy)
    local v3 = Finisher.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayServer(u5) -- Line: 23
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000);
    BodyVelocity.Velocity = Vector3.new(0, 4, 0);
    BodyVelocity.Parent = u5._is_humanoid and u5._subject.RootPart or u5._subject;
    table.insert(u5._destroy_these, BodyVelocity);
    local BodyAngularVelocity = Instance.new("BodyAngularVelocity");
    BodyAngularVelocity.MaxTorque = Vector3.new(10000, 10000, 10000);
    local v6 = math.random() - 0.5;
    BodyAngularVelocity.AngularVelocity = Vector3.new(0, 2, 0) * math.sign(v6);
    BodyAngularVelocity.Parent = u5._is_humanoid and u5._subject.RootPart or u5._subject;
    table.insert(u5._destroy_these, BodyAngularVelocity);
    u5:_InternalThread(task.delay, 3, function() -- Line: 36
        -- upvalues: BodyVelocity (copy), BodyAngularVelocity (copy), u5 (copy)
        BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        wait(3);
        BodyVelocity:Destroy();
        BodyAngularVelocity:Destroy();
        u5:_AnchorModel();
        u5:_Ragdoll();
    end);
end;

function u2.PlayClient(p7) -- Line: 49
    -- upvalues: Utility (copy)
    for _, v in pairs(p7:_GetObjects(true)) do
        if v:IsA("BasePart") and v.Transparency < 0.99 then
            v.Color = Color3.fromRGB(255, 255, 255);
            v.Material = Enum.Material.SmoothPlastic;
            v.MaterialVariant = "";
            v.Reflectance = 0.5;
            local v8 = v;

            for _, child in pairs(script.Texture:GetChildren()) do
                child:Clone().Parent = v8;
            end;

            if v8:IsA("MeshPart") then
                v8.TextureID = "";
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or (v:IsA("Texture") or (v:IsA("Decal") or (v:IsA("Clothing") or v:IsA("ShirtGraphic")))))) then
            v:Destroy();
        end;
    end;

    local u9 = script.Particles.Enabled:Clone();
    u9.Parent = p7._is_humanoid and p7._subject.RootPart or p7._subject;
    local v10 = script.Particles.Emit:Clone();
    v10.Parent = p7._is_humanoid and p7._subject.RootPart or p7._subject;
    Utility:PlayParticles(v10);

    if p7._is_humanoid then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://109647828518093";
        local success, result = pcall(p7._subject.LoadAnimation, p7._subject, Animation);

        if success then
            result:Play(0);
            result:AdjustSpeed(0.75);
        end;
    end;

    p7:_InternalThread(task.delay, 6, function() -- Line: 88
        -- upvalues: u9 (copy)
        for _, descendant in pairs(u9:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Light") then
                descendant.Enabled = false;
            end;
        end;
    end);
    p7:CreateSound(p7:_GetMusicID(), 1, 1, nil, true, 5);
end;

function u2._GetMusicID(p11) -- Line: 103
    -- upvalues: u1 (copy)
    return u1[Random.new(p11._serial and p11._serial.Seed or p11._seed):NextInteger(1, #u1)];
end;

function u2._Init(p12) -- Line: 107
end;

return u2;