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

function u1.PlayServer(p4) -- Line: 21
    p4:_AnchorModel(10);

    for _, v in pairs(p4:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.CustomPhysicalProperties = PhysicalProperties.new(v.CurrentPhysicalProperties.Density, 0, 0, 100, 100);
            v.Velocity = Random.new():NextUnitVector() * 10;
            v.RotVelocity = Random.new():NextUnitVector() * 25;
        end;
    end;
end;

function u1.PlayClient(p5) -- Line: 33
    -- upvalues: Utility (copy)
    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(110, 241, 243);
            v.Material = Enum.Material.Glass;
            v.MaterialVariant = "";
            v.Reflectance = 0.4;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            v:Destroy();
        end;
    end;

    local v6 = p5._is_humanoid and p5._subject.RootPart or p5._subject;
    local v7 = script.Particles.Appear:Clone();
    v7.Parent = v6;
    table.insert(p5._destroy_these, v7);
    Utility:PlayParticles(v7);
    p5:CreateSound("rbxassetid://93583856628897", 1.5, 1.5 + 0.2 * math.random(), nil, true, 5);
end;

function u1._Init(p8) -- Line: 59
end;

return u1;