-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 15
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 27
    p4:_AnchorModel(0);
    wait(2);
    p4:_HideBody();
end;

function u1.PlayClient(u5) -- Line: 35
    -- upvalues: RunService (copy), Utility (copy)
    local Color3_fromHSV_ret = Color3.fromHSV(math.random(), 1, 1);
    local u6 = {};

    for _, v in pairs(u5:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3_fromHSV_ret;
            v.Material = Enum.Material.Glass;

            if v:IsA("MeshPart") then
                v.TextureID = "";
            end;

            table.insert(u6, v);
        end;
    end;

    local u7;

    if u5._is_humanoid then
        u7 = u5._subject.Parent or nil;
    else
        u7 = nil;
    end;

    local u8;

    if u7 then
        u8 = u7:GetScale();
    else
        u8 = u7;
    end;

    local u9 = tick();
    local v14 = RunService.RenderStepped:Connect(function() -- Line: 56
        -- upvalues: u9 (copy), u7 (copy), u8 (copy), u6 (copy)
        local v10 = ((tick() - u9) / 2) ^ 1.5;
        local v11 = ((1 - math.cos(15.707963267948966 * v10)) / 4 + 4 * v10) / 4.5;
        local v12 = 0.5 + 2.5 * v11;

        if u7 then
            u7:ScaleTo(u8 * v12);
        end;

        local v13 = v11 < 0.15 and 0 or (v11 ^ 4 - 0.15) / 0.75 * 0.5;

        for _, v in pairs(u6) do
            v.LocalTransparencyModifier = v13;
        end;
    end);
    table.insert(u5._connections, v14);
    u5:_InternalThread(task.defer, function() -- Line: 74
        -- upvalues: u5 (copy)
        u5:CreateSound("rbxassetid://135921915396785", 1, 1, nil, true, 5);
        wait(0.78);
        u5:CreateSound("rbxassetid://135921915396785", 1, 1, nil, true, 5);
        wait(0.8);
        u5:CreateSound("rbxassetid://135921915396785", 1, 1, nil, true, 5);
    end);
    wait(2);
    v14:Disconnect();
    local v15 = script.Particles:Clone();
    v15.Parent = workspace;
    v15.CFrame = (u5._is_humanoid and u5._subject.RootPart or u5._subject).CFrame;
    table.insert(u5._destroy_these, v15);
    Utility:PlayParticles(v15);

    for _, descendant in pairs(v15:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Color = ColorSequence.new(Color3_fromHSV_ret);
        end;
    end;

    u5:CreateSound("rbxassetid://94915446476512", 1, 1, v15, true, 5);
end;

function u1._Init(p16) -- Line: 109
end;

return u1;