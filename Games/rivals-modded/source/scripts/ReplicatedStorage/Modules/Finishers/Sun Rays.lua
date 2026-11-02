-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
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
    -- upvalues: Ragdoll (copy), RunService (copy)
    Ragdoll.PlayClient(p4, ...);
    local u5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local u6 = script.Model:Clone();
    u6.Parent = u5;
    table.insert(p4._destroy_these, u6);
    local u7 = {
        u6.heavenRays.dots1,
        u6.heavenRays.Enabled.rays1,
        u6.heavenRays.Enabled.rays2,
        u6.heavenRays.Enabled.rays3
    };
    local u8 = tick();
    table.insert(p4._connections, RunService.RenderStepped:Connect(function() -- Line: 33
        -- upvalues: u6 (copy), u5 (copy), u7 (copy), u8 (copy)
        u6:PivotTo(CFrame.new(u5.Position));

        for _, v in pairs(u7) do
            local v9 = (tick() - u8) / 2;
            v.LocalTransparencyModifier = 1 - math.clamp(v9, 0, 1) ^ 3;
        end;
    end));
    p4:CreateSound("rbxassetid://122372195490308", 1.25, 0.95 + 0.1 * math.random(), u5, true, 10);
end;

function u1._Init(p10) -- Line: 50
end;

return u1;