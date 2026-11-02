-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.CosmeticLibrary);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
require(ReplicatedStorage.Modules.Utility);
local u1 = { { "RightUpperArm", "RightLowerArm", "RightHand" }, { "LeftUpperArm", "LeftLowerArm", "LeftHand" }, { "RightUpperLeg", "RightLowerLeg", "RightFoot" }, { "LeftUpperLeg", "LeftLowerLeg", "LeftFoot" }, { "UpperTorso", "LowerTorso", "Head" } };
local u2 = setmetatable({}, Ragdoll);
u2.__index = u2;

function u2.new(...) -- Line: 18
    -- upvalues: Ragdoll (copy), u2 (copy)
    local v3 = Ragdoll.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayServer(p5, ...) -- Line: 30
    -- upvalues: Ragdoll (copy), u1 (copy)
    Ragdoll.PlayServer(p5, ...);
    wait(#u1 * 0.2 + 1);
    p5:_HideBody();
end;

function u2.PlayClient(p6, ...) -- Line: 38
    -- upvalues: Ragdoll (copy), u1 (copy)
    Ragdoll.PlayClient(p6, ...);

    for _, v in pairs(p6:_GetObjects(true)) do
        if v:IsA("BasePart") then
            if v.Transparency < 0.99 then
                v.Color = Color3.fromRGB(106, 73, 50);
                v.Material = Enum.Material.Slate;

                if v.Name == "Head" then
                    script.Head:Clone().Parent = v;
                elseif v.Name == "UpperTorso" then
                    script.UpperTorso:Clone().Parent = v;
                elseif v.Name ~= "LowerTorso" then
                    local v7 = v;

                    for _, child in pairs(script.Textures:GetChildren()) do
                        child:Clone().Parent = v7;
                    end;
                end;
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or (v:IsA("Decal") or (v:IsA("Clothing") or v:IsA("Texture"))))) then
            v:Destroy();
        end;
    end;

    if not p6._is_humanoid then
        return;
    end;

    local v8 = {};

    for i in pairs(u1) do
        table.insert(v8, i);
    end;

    wait(1);

    for i = 1, #v8 do
        local table_remove_ret = table.remove(v8, math.random(#v8));
        local _ = i;

        for _, v in pairs(u1[table_remove_ret]) do
            p6._subject.Parent[v]:Destroy();
        end;

        p6:CreateSound("rbxassetid://18128896162", 1, 1 + 0.1 * math.random(), nil, true, 5);
        wait(0.2);
    end;

    p6:CreateSound("rbxassetid://18128949754", 1, 1 + 0.1 * math.random(), nil, true, 10);
end;

function u2._Init(p9) -- Line: 95
end;

return u2;