-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4) -- Line: 24
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;

    for _, v in pairs(p4:_GetObjects(true)) do
        if v:IsA("BasePart") and v ~= v5 then
            v:Destroy();
        end;
    end;

    v5.Size = Vector3.new(0, 0, 0);

    for i = 1, math.random(5, 10) do
        local v6 = Random.new():NextUnitVector() * Vector3.new(1, 0, 1);
        local v7 = 0.5 + 0.5 * math.random();
        local v8 = v6 + Vector3.new(0, v7, 0);
        local v9 = script.Bone:Clone();
        v9.CFrame = v5.CFrame;
        v9.Size = v9.Size * (0.875 + 0.25 * math.random());
        v9.Velocity = v8 * (15 + 15 * math.random());
        v9.RotVelocity = Random.new():NextUnitVector() * (5 + 10 * math.random());
        v9.Parent = v5;
        table.insert(p4._destroy_these, v9);
        local _ = i;
    end;

    local v10 = script.BonePile:Clone();
    v10.Size = Vector3.new(0, 0, 0);
    v10.CFrame = v5.CFrame;
    v10.Velocity = Random.new():NextUnitVector() * (5 + 10 * math.random());
    v10.CollisionGroup = "IgnorePlayers";
    v10.Parent = v5;
    table.insert(p4._destroy_these, v10);
    TweenService:Create(v10, TweenInfo_new_ret, {
        Size = script.BonePile.Size
    }):Play();
    p4:CreateSound("rbxassetid://71015990947254", 1.25, 0.95 + 0.1 * math.random(), v10, true, 10);
    wait(3);
    TweenService:Create(v10, TweenInfo_new_ret2, {
        Size = Vector3.new(0, 0, 0)
    }):Play();
    wait(1);
end;

function u1._Init(p11) -- Line: 70
end;

return u1;