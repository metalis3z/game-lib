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
    p4:_AnchorModel(0);
end;

function u1.PlayClient(p5, ...) -- Line: 28
    -- upvalues: RunService (copy), Utility (copy)
    if not p5._is_humanoid then
        return;
    end;

    p5:CreateSound("rbxassetid://140285154660882", 1.25, 1, p5._subject.RootPart.Position, true, 5);
    local Parent = p5._subject.Parent;
    local v6 = Random.new():NextUnitVector();
    local Pivot = Parent:GetPivot();
    local Scale = Parent:GetScale();
    local v7 = tick();

    while tick() < v7 + 0.5 do
        local v8 = 1 - (1 - (1 - (v7 + 0.5 - tick()) / 0.5)) ^ 2;
        local v9 = v6 * -v8 * 3.141592653589793 * 2 * 3;
        Parent:ScaleTo(Scale * (1 - v8));
        Parent:PivotTo(Pivot * CFrame.Angles(v9.X, v9.Y, v9.Z));
        RunService.RenderStepped:Wait();
    end;

    local v10 = script.Particles.Attachment:Clone();
    v10.Parent = p5._subject.RootPart;
    table.insert(p5._destroy_these, v10);
    Utility:PlayParticles(v10);
    wait(0.25);
    p5:CreateSound("rbxassetid://73926817558125", 1, 1, p5._subject.RootPart.Position, true, 5);
    wait(1);
end;

function u1._Init(p11) -- Line: 68
end;

return u1;