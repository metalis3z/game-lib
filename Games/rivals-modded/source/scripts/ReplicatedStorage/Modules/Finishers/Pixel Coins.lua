-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 20
    p4:_AnchorModel(0);
end;

function u1.PlayClient(p5) -- Line: 24
    local Position = (p5._is_humanoid and p5._subject.RootPart or p5._subject).Position;
    local v6 = p5._is_humanoid and p5._subject.Parent or p5._subject;
    local Parent = v6.Parent;
    p5:CreateSound("rbxassetid://111721022295307", 1.25, 0.95 + 0.1 * math.random(), Position, true, 10);

    for i = 1, 6 do
        v6.Parent = Parent;
        wait(0.07);
        v6.Parent = nil;
        wait(0.07);
        local _ = i;
    end;

    p5:CreateSound("rbxassetid://122871435090543", 1.5, 0.9 + 0.2 * math.random(), Position, true, 10);
    p5:CreateSound("rbxassetid://11188024605", 1, 0.9 + 0.2 * math.random(), Position, true, 10);
    local v7 = script.Model:Clone();
    v7:PivotTo(CFrame.new(Position) * CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0));
    v7.Parent = workspace;
    table.insert(p5._destroy_these, v7);
    local success, result = pcall(v7.AnimationController.LoadAnimation, v7.AnimationController, v7.Animation);

    if success then
        result:Play(0);

        if result.IsPlaying then
            result.Stopped:Wait();
        end;
    end;

    v7:Destroy();
end;

function u1._Init(p8) -- Line: 66
end;

return u1;