-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Spring = require(ReplicatedStorage.Modules.Spring);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(u4, ...) -- Line: 22
    -- upvalues: Ragdoll (copy), Spring (copy), RunService (copy)
    Ragdoll.PlayClient(u4, ...);
    local u5 = u4._is_humanoid and u4._subject.RootPart or u4._subject;
    local u6 = script.Model:Clone();
    u6.Parent = u4._subject;
    table.insert(u4._destroy_these, u6);
    local u7 = u4:_GetObjects(true);
    local u8 = Spring.new(u5.Position, 1, 2);
    local u9 = {};
    local u10 = tick();
    table.insert(u4._connections, RunService.RenderStepped:Connect(function() -- Line: 36
        -- upvalues: u8 (copy), u4 (copy), u5 (copy), u7 (copy), u6 (copy), u10 (copy), u9 (copy)
        u8.Target = u4:_GetGroundPosition(u5.Position, u7) + Vector3.new(0, 0.01, 0);
        u6:PivotTo(CFrame.new(u8.Value.X, u8.Target.Y, u8.Value.Z));
        local v11 = (tick() - u10) / 4;
        local math_clamp_ret = math.clamp(v11, 0, 1);
        local math_clamp_ret2 = math.clamp(math_clamp_ret * 2, 0, 1);
        local math_clamp_ret3 = math.clamp(math_clamp_ret * 2 - 1, 0, 1);

        for _, v in pairs(u4:_GetObjects(true)) do
            if v:IsA("BasePart") then
                u9[v] = u9[v] or v.Color;
                v.Material = Enum.Material.Glass;
                v.MaterialVariant = "";
                v.Color = u9[v]:Lerp(Color3.fromRGB(143, 76, 42), math_clamp_ret2):Lerp(Color3.fromRGB(61, 32, 18), math_clamp_ret3);
            end;
        end;
    end));
    u4:CreateSound("rbxassetid://120630457366669", 1, 1 + 0.1 * math.random(), nil, true, 10);
    u4:CreateSound("rbxassetid://126523239993274", 0.75, 1 + 0.1 * math.random(), nil, true, 10);
end;

function u1._Init(p12) -- Line: 62
end;

return u1;