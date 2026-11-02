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
            if v.Name ~= "Head" and v.Transparency < 0.99 then
                local v5 = math.random() < 0.5;
                v.Color = v5 and Color3.fromRGB(247, 42, 55) or Color3.fromRGB(14, 150, 57);
                v.Material = Enum.Material.SmoothPlastic;
                v.MaterialVariant = v5 and "WrappingPearlescent" or "WrappingPaper";
                local v6 = v;

                for _, child in pairs(script.Textures:GetChildren()) do
                    child:Clone().Parent = v6;
                end;
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            v:Destroy();
        end;
    end;

    p4:CreateSound("rbxassetid://74885181688460", 1.5, 1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p7) -- Line: 50
end;

return u1;