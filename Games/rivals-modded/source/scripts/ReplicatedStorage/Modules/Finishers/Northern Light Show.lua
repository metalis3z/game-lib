-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4) -- Line: 22
    -- upvalues: Ragdoll (copy), RunService (copy), Utility (copy)
    Ragdoll.PlayClient(p4);
    local u5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local CFrame_Angles_ret = CFrame.Angles(0, 6.283185307179586 * math.random(), 0);
    local u6 = script.Aurora:Clone();
    u6.PrimaryPart = u6.Primary;
    u6.Parent = p4._subject;
    table.insert(p4._destroy_these, u6);
    local v7 = RunService.RenderStepped:Connect(function() -- Line: 33
        -- upvalues: u6 (copy), u5 (copy), CFrame_Angles_ret (copy)
        u6:PivotTo(CFrame.new(u5.Position) * CFrame_Angles_ret);
    end);
    table.insert(p4._connections, v7);
    p4:CreateSound("rbxassetid://81606650181214", 1, 1.25 + 0.125 * math.random(), nil, true, 5);
    local Children = u6.Beams:GetChildren();
    Utility:RenderstepForLoop(0, 100, 1, function(p8) -- Line: 43
        -- upvalues: Children (copy)
        for _, v in pairs(Children) do
            v.LocalTransparencyModifier = 1 - p8 / 100;
        end;
    end);
    wait(3);
    Utility:RenderstepForLoop(0, 100, 1, function(p9) -- Line: 51
        -- upvalues: Children (copy)
        for _, v in pairs(Children) do
            v.LocalTransparencyModifier = p9 / 100;
        end;
    end);
    v7:Disconnect();
end;

function u1._Init(p10) -- Line: 64
end;

return u1;