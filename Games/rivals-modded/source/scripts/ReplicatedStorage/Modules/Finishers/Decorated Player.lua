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
            v.Color = Color3.fromRGB(124, 92, 70);
            v.Material = Enum.Material.Wood;
            v.MaterialVariant = "Wood01a";

            if v:IsA("MeshPart") then
                v.TextureID = "";
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or (v:IsA("Texture") or (v:IsA("Decal") or (v:IsA("Clothing") or v:IsA("ShirtGraphic")))))) then
            v:Destroy();
        end;
    end;

    for _, v in pairs({ "Head", "HumanoidRootPart" }) do
        local v5 = p4._is_humanoid and p4._subject.Parent:FindFirstChild(v);

        if v5 then
            local v6 = script[v]:Clone();
            v6.PrimaryPart = v6.Primary;
            v6:PivotTo(v5.CFrame);
            v6.Parent = v5;
            table.insert(p4._destroy_these, v6);
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = v5;
            WeldConstraint.Part1 = v6.Primary;
            WeldConstraint.Parent = v6;
        end;
    end;

    local v7 = {};

    for _, child in pairs(script.Particles:GetChildren()) do
        local v8 = child:Clone();
        v8.Parent = p4._is_humanoid and p4._subject.RootPart or p4._subject;
        table.insert(p4._destroy_these, v8);
        table.insert(v7, v8);
    end;

    Utility:PlayParticles(v7);
    p4:CreateSound("rbxassetid://96385683410648", 1.5, 1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p9) -- Line: 76
end;

return u1;