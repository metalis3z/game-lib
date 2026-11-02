-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 22
    -- upvalues: Ragdoll (copy), BetterDebris (copy)
    Ragdoll.PlayServer(p4, ...);
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local BodyAngularVelocity = Instance.new("BodyAngularVelocity");
    BodyAngularVelocity.MaxTorque = Vector3.new(100000, 100000, 100000);
    BodyAngularVelocity.AngularVelocity = Random.new():NextUnitVector() * 10;
    BodyAngularVelocity.Parent = v5;
    BetterDebris:AddItem(BodyAngularVelocity, 3);

    for _, v in pairs(p4:_GetObjects()) do
        if v:IsA("BasePart") then
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * (v == v5 and 10000 or 500);
            BodyVelocity.Velocity = Vector3.new(0, 2, 0);
            BodyVelocity.Parent = v;
            BetterDebris:AddItem(BodyVelocity, 3);
        end;
    end;
end;

function u1.PlayClient(u6, ...) -- Line: 44
    -- upvalues: Ragdoll (copy), Utility (copy)
    Ragdoll.PlayClient(u6, ...);
    u6:CreateSound("rbxassetid://115639979533179", 1, 1 + 0.1 * math.random(), nil, true, 5);
    u6:CreateSound("rbxassetid://70584026980041", 1.5, 1 + 0.1 * math.random(), nil, true, 5);

    for _, v in pairs(u6:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(11, 91, 43);
            v.Material = Enum.Material.SmoothPlastic;
            v.MaterialVariant = "";

            if v:IsA("MeshPart") then
                v.TextureID = "";
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or (v:IsA("Texture") or (v:IsA("Decal") or (v:IsA("Clothing") or v:IsA("ShirtGraphic")))))) then
            v:Destroy();
        end;
    end;

    local v7 = script.Particles.Attachment:Clone();
    v7.Parent = u6._is_humanoid and u6._subject.RootPart or u6._subject;
    table.insert(u6._destroy_these, v7);
    Utility:PlayParticles(v7);
    Utility:RenderstepForLoop(0, 100, 0.5, function(p8) -- Line: 70
        -- upvalues: u6 (copy)
        local v9 = 1 - (1 - p8 / 100) ^ 3;

        for _, v in pairs(u6:_GetObjects(true)) do
            if v:IsA("BasePart") then
                v.LocalTransparencyModifier = v9;
            end;
        end;
    end);
end;

function u1._Init(p10) -- Line: 85
end;

return u1;