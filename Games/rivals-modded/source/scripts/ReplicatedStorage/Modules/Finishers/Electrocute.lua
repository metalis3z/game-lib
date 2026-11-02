-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4, ...) -- Line: 24
    if p4._is_humanoid then
        p4._subject.RootPart.Anchored = true;
    end;

    wait(1.7999999999999998);

    if p4._is_humanoid then
        p4._subject.RootPart.Anchored = false;
    end;

    p4:_Ragdoll();
    p4:_AnchorModel();
end;

function u1.PlayClient(p5, ...) -- Line: 39
    -- upvalues: Utility (copy)
    local u6 = {};

    for _, v in pairs(p5:_GetObjects()) do
        if v:IsA("BasePart") and v.Transparency <= 0 then
            local v7 = script[v.Name == "Head" and "Head" or "Limb"]:Clone();
            v7.Size = v.Size;
            v7.CFrame = v.CFrame;
            v7.Parent = v;
            table.insert(u6, v7);
            table.insert(p5._destroy_these, v7);
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = v;
            WeldConstraint.Part1 = v7;
            WeldConstraint.Parent = v7;

            if v.Name == "Head" then
                local v8 = script.Face:Clone();
                v8.CFrame = v.CFrame;
                v8.Parent = v;
                table.insert(u6, v8.Decal);
                table.insert(p5._destroy_these, v8);
                local WeldConstraint2 = Instance.new("WeldConstraint");
                WeldConstraint2.Part0 = v;
                WeldConstraint2.Part1 = v8;
                WeldConstraint2.Parent = v8;
            end;
        end;
    end;

    local v9 = p5._is_humanoid and p5._subject.Parent:FindFirstChild("face", true);

    if v9 then
        v9:Destroy();
    end;

    local u10 = {};
    local v11 = {};

    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            u10[v] = v.Transparency;

            if v:IsA("BasePart") then
                local v12 = script.Particles.Enabled:Clone();
                v12.Parent = v;
                table.insert(p5._destroy_these, v12);
                table.insert(v11, v12);

                for _, child in pairs(v12:GetChildren()) do
                    Utility:ScaleParticleEmitter(child, 0.5);
                end;

                local v13 = script.Particles.Smoke:Clone();
                v13.Parent = v;
                table.insert(p5._destroy_these, v13);
            end;
        end;
    end;

    p5:CreateSound("rbxassetid://79646963478511", 0.75, 1, nil, true, 5);

    local function show_shock(p14) -- Line: 105
        -- upvalues: u10 (copy), u6 (copy)
        for i, v in pairs(u10) do
            i.Transparency = p14 and 1 or v;
        end;

        for _, v in pairs(u6) do
            v.Transparency = p14 and 0 or 1;
        end;
    end;

    for i = 1, 15 do
        local _ = i;

        for i2, _ in pairs(u10) do
            i2.Transparency = 1;
        end;

        for _, v in pairs(u6) do
            v.Transparency = 0;
        end;

        wait(0.08);

        for i2, v in pairs(u10) do
            i2.Transparency = v;
        end;

        for _, v in pairs(u6) do
            v.Transparency = 1;
        end;

        wait(0.04);
    end;

    for _, v in pairs(v11) do
        v:Destroy();
    end;

    for _, v in pairs(u6) do
        v:Destroy();
    end;

    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(30, 30, 30);
            v.Material = Enum.Material.Grass;
            v.Reflectance = 0;
            v.MaterialVariant = "";

            if v:IsA("MeshPart") then
                v.TextureID = "";
            end;
        elseif v:IsA("Beam") or (v:IsA("Trail") or (v:IsA("Texture") or (v:IsA("Decal") or (v:IsA("Clothing") or v:IsA("ShirtGraphic"))))) then
            v:Destroy();
        end;
    end;
end;

function u1._Init(p15) -- Line: 153
end;

return u1;