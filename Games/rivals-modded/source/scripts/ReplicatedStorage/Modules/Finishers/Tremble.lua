-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 22
    p4:_AnchorModel(0);
end;

function u1.PlayClient(p5, ...) -- Line: 26
    -- upvalues: RunService (copy)
    local u6 = {};

    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") then
            u6[v] = v.CFrame;
        end;
    end;

    table.insert(p5._connections, RunService.RenderStepped:Connect(function(p7) -- Line: 35
        -- upvalues: u6 (copy)
        for i, v in pairs(u6) do
            local v8 = math.random() - 0.5;
            local v9 = math.random() - 0.5;
            local v10 = math.random() - 0.5;
            i.CFrame = v + Vector3.new(v8, v9, v10) * 0.2;
        end;
    end));
    p5:CreateSound("rbxassetid://82637145735352", 1, 1 + 0.1 * math.random(), nil, true);
end;

function u1._Init(p11) -- Line: 48
end;

return u1;