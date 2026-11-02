-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
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

function u1.PlayServer(p4) -- Line: 24
    (p4._is_humanoid and p4._subject.RootPart or p4._subject).Anchored = true;
end;

function u1.PlayClient(p5) -- Line: 30
    -- upvalues: Utility (copy), RunService (copy)
    if p5._is_humanoid then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://134648473605383";
        local success, result = pcall(p5._subject.LoadAnimation, p5._subject, Animation);

        if success then
            result:Play(0);
        end;
    end;

    local v6 = p5._is_humanoid and p5._subject.RootPart or p5._subject;
    local v7 = script.Explosion.Attachment:Clone();
    v7.Parent = v6;
    Utility:PlayParticles(v7);
    script.Idle.Attachment:Clone().Parent = p5._is_humanoid and p5._subject.Parent.UpperTorso or p5._subject;
    p5:CreateSound("rbxassetid://86210336908274", 1, 1, nil, true, 5);
    p5:CreateSound("rbxassetid://112056531317514", 1, 1, nil, true, 5);
    wait(1);
    local v8 = {};

    for _, v in pairs(p5:_GetObjects(true)) do
        if v:IsA("BasePart") or (v:IsA("Decal") or (v:IsA("Texture") or (v:IsA("Beam") or (v:IsA("ParticleEmitter") or v:IsA("Trail"))))) then
            v8[v] = true;
        end;
    end;

    local v9 = tick();

    while tick() < v9 + 0.3333333333333333 do
        local v10 = (tick() - v9) / 0.3333333333333333;
        local v11 = 1 - (1 - math.clamp(v10, 0, 1)) ^ 3;

        for i in pairs(v8) do
            i.LocalTransparencyModifier = v11;
        end;

        RunService.RenderStepped:Wait();
    end;

    p5:_HideBody();
end;

function u1._Init(p12) -- Line: 84
end;

return u1;