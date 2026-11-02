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
    local v5 = p4._is_humanoid and p4._subject.Parent:FindFirstChild("Head");

    if not v5 then
        return;
    end;

    for _, v in pairs(p4:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(248, 248, 248);
            v.Material = Enum.Material.SmoothPlastic;
            v.MaterialVariant = "";

            if v:IsA("MeshPart") then
                v.TextureID = "";
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or (v:IsA("Texture") or (v:IsA("Decal") or (v:IsA("Clothing") or v:IsA("ShirtGraphic")))))) then
            v:Destroy();
        end;
    end;

    local v6 = script.Model:Clone();
    v6.PrimaryPart = v6.Primary;
    v6:PivotTo(v5.CFrame);
    v6.Parent = v5;
    table.insert(p4._destroy_these, v6);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v5;
    WeldConstraint.Part1 = v6.Primary;
    WeldConstraint.Parent = v6;
    local v7 = script.Particles.Attachment:Clone();
    v7.Parent = v5;
    table.insert(p4._destroy_these, v7);
    Utility:PlayParticles(v7);
    p4:CreateSound("rbxassetid://103150011493508", 1.5, 1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p8) -- Line: 68
end;

return u1;