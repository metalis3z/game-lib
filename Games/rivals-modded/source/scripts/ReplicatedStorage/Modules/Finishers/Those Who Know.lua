-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
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
    -- upvalues: RunService (copy)
    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") then
            local v6, _, v7 = v.Color:ToHSV();
            v.Color = Color3.fromHSV(v6, 0, v7 * 0.5);
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            v:Destroy();
        end;
    end;

    local u8 = p5._is_humanoid and p5._subject.Parent or p5._subject;
    local v9 = p5._is_humanoid and p5._subject.RootPart or p5._subject;
    local u10 = script.Skull:Clone();
    u10.Parent = v9;
    table.insert(p5._destroy_these, u10);
    p5:CreateSound("rbxassetid://117434088219830", 0.75, 1 + 0.1 * math.random(), nil, true, 5);
    local Pivot = u8:GetPivot();
    table.insert(p5._connections, RunService.RenderStepped:Connect(function(p11) -- Line: 46
        -- upvalues: Pivot (copy), u8 (copy), u10 (copy)
        local v12 = math.random() - 0.5;
        local v13 = math.random() - 0.5;
        local v14 = math.random() - 0.5;
        local v15 = Pivot + Vector3.new(v12, v13, v14) * 0.1;
        u8:PivotTo(v15);
        u10.CFrame = v15 + CFrame.new(workspace.CurrentCamera.CFrame.Position, v15.Position).LookVector * -math.min(3, (workspace.CurrentCamera.CFrame.Position - v15.Position).Magnitude * 0.5);
    end));
end;

function u1._Init(p16) -- Line: 58
end;

return u1;