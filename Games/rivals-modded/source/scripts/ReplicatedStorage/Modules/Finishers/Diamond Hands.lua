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
    p4:_AnchorModel(0);
end;

function u1.PlayClient(p5, ...) -- Line: 25
    -- upvalues: Utility (copy)
    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(205, 208, 255);
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

    p5:CreateSound("rbxassetid://94496162153937", 2, 1 + 0.2 * math.random(), nil, true, 5);
    p5:CreateSound("rbxassetid://126265374362193", 2, 1 + 0.2 * math.random(), nil, true, 5);
    p5:CreateSound("rbxassetid://104909327141208", 1, 1 + 0.2 * math.random(), nil, true, 5);
    local v6 = script.Particles.Enabled:Clone();
    v6.Parent = p5._is_humanoid and p5._subject.RootPart or p5._subject;
    table.insert(p5._destroy_these, v6);
    local v7 = {};

    for _, child in pairs(script.Particles.Emit:GetChildren()) do
        local v8 = child:Clone();
        v8.Parent = p5._is_humanoid and p5._subject.RootPart or p5._subject;
        table.insert(p5._destroy_these, v8);
        table.insert(v7, v8);
    end;

    Utility:PlayParticles(v7);
end;

function u1._Init(p9) -- Line: 65
end;

return u1;