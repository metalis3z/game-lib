-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 25
    -- upvalues: Ragdoll (copy), BetterDebris (copy), Utility (copy), RunService (copy)
    Ragdoll.PlayClient(p4, ...);
    local u5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local u6 = script.Model:Clone();
    u6.PrimaryPart = u6.Primary;
    u6.Parent = u5;
    u6:ScaleTo(u6:GetScale() * (1 + 1 * math.random()));
    table.insert(p4._destroy_these, u6);
    BetterDebris:AddItem(u6, 10);

    local function get_position() -- Line: 37
        -- upvalues: u5 (copy)
        return u5.Position - Vector3.new(0, 1.5, 0);
    end;

    local u7 = math.random() * 3.141592653589793 * 2;
    Utility:RenderstepForLoop(0, 100, 4, function(p8) -- Line: 43
        -- upvalues: u5 (copy), u7 (copy), u6 (copy)
        local v9 = u5.Position - Vector3.new(0, 1.5, 0);
        local math_cos_ret = math.cos(u7);
        local math_sin_ret = math.sin(u7);
        local v10 = v9 + Vector3.new(math_cos_ret, 0, math_sin_ret) * 128 + Vector3.new(0, 128, 0);
        local v11 = (v10 - v9).Magnitude * (1 - p8 / 100);
        u6:PivotTo(CFrame.new(v9, v10) * CFrame.new(0, 0, -v11 / 2));
    end);
    Utility:PlayParticles(u6);
    p4:CreateSound("rbxassetid://110743147230828", 1.5, 1 + 0.1 * math.random(), nil, true, 5);
    local v12 = tick();

    while tick() < v12 + 2 do
        u6:PivotTo(CFrame.new(u5.Position - Vector3.new(0, 1.5, 0)));
        RunService.RenderStepped:Wait();
    end;

    u6.PrimaryPart.Anchored = false;
end;

function u1._Init(p13) -- Line: 72
end;

return u1;