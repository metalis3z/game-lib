-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 21
    -- upvalues: Ragdoll (copy), Utility (copy)
    Ragdoll.PlayClient(p4, ...);

    for _, v in pairs(p4:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(255, 232, 128);
            v.Material = Enum.Material.Glass;
            v.MaterialVariant = "";
            v.Reflectance = 0.4;

            if v:IsA("MeshPart") then
                v.TextureID = "";
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or (v:IsA("Texture") or (v:IsA("Decal") or (v:IsA("Clothing") or v:IsA("ShirtGraphic")))))) then
            v:Destroy();
        end;
    end;

    local function scale(p5, p6) -- Line: 39
        -- upvalues: Utility (ref)
        if p5:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(p5, p6);
        end;
    end;

    local v7 = {};

    for _, child in pairs(script.Particles:GetChildren()) do
        local v8 = child:Clone();
        v8.Parent = p4._is_humanoid and p4._subject.RootPart or p4._subject;
        table.insert(p4._destroy_these, v8);
        table.insert(v7, v8);

        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, 0.5);
        end;

        for _, descendant in pairs(v8:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                Utility:ScaleParticleEmitter(descendant, 0.5);
            end;
        end;
    end;

    Utility:PlayParticles(v7);
    p4:CreateSound("rbxassetid://18179281854", 2, 0.9 + 0.2 * math.random(), nil, true, 10);
end;

function u1._Init(p9) -- Line: 68
end;

return u1;