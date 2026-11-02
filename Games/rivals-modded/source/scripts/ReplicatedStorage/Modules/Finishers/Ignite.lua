-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 20
    -- upvalues: Ragdoll (copy)
    Ragdoll.PlayClient(p4, ...);

    for _, v in pairs(p4:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(0, 0, 0);
            v.Material = Enum.Material.SmoothPlastic;
            v.MaterialVariant = "Scorched";

            if v:IsA("MeshPart") then
                v.TextureID = "";
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or (v:IsA("Texture") or (v:IsA("Decal") or (v:IsA("Clothing") or v:IsA("ShirtGraphic")))))) then
            v:Destroy();
        end;
    end;

    for _, v in pairs(p4:_GetObjects()) do
        if v:IsA("BasePart") then
            local v5 = v;

            for _, child in pairs(script.Particles:GetChildren()) do
                local v6 = child:Clone();
                v6.Parent = v5;
                table.insert(p4._destroy_these, v6);
            end;
        end;
    end;

    p4:CreateSound("rbxassetid://130652232992636", 1, 1 + 0.1 * math.random(), nil, true, 5);
    p4:CreateSound("rbxassetid://99039883606432", 1, 1, nil, true);
end;

function u1._Init(p7) -- Line: 59
end;

return u1;