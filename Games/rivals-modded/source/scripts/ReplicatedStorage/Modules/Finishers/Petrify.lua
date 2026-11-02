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

function u1.PlayClient(p5) -- Line: 25
    -- upvalues: Utility (copy)
    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(163, 162, 165);
            v.Material = Enum.Material.Slate;
            v.MaterialVariant = "";

            if v:IsA("MeshPart") then
                v.TextureID = "";
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or (v:IsA("Texture") or (v:IsA("Decal") or (v:IsA("Clothing") or v:IsA("ShirtGraphic")))))) then
            v:Destroy();
        end;
    end;

    local v6 = {};

    for _, child in pairs(script.Particles:GetChildren()) do
        local v7 = child:Clone();
        v7.Parent = p5._is_humanoid and p5._subject.RootPart or p5._subject;
        table.insert(p5._destroy_these, v7);
        table.insert(v6, v7);
    end;

    Utility:PlayParticles(v6);
    p5:CreateSound("rbxassetid://113140086283098", 1.25, 0.9 + 0.2 * math.random(), nil, true, 10);
    p5:CreateSound("rbxassetid://120323428371971", 1, 0.9 + 0.2 * math.random(), nil, true, 10);
end;

function u1._Init(p8) -- Line: 58
end;

return u1;