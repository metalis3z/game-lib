-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 26
    -- upvalues: RunService (copy)
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    v5.Anchored = true;
    wait(2.55);
    local v6 = p4:_GetObjects(true);
    local v7 = p4:_GetGroundPosition(v5.Position, v6);
    local CFrame2 = v5.CFrame;
    local v8 = CFrame.new(v7 + Vector3.new(0, -16, 0)) * CFrame2.Rotation;
    local v9 = tick();

    while tick() < v9 + 0.25 do
        local v10 = (tick() - v9) / 0.25;
        v5.CFrame = CFrame2:Lerp(v8, math.clamp(v10, 0, 1) ^ 2);
        RunService.Heartbeat:Wait();
    end;

    wait(0.25);
    v5.Anchored = false;
    p4:_Ragdoll();
    p4:_AnchorModel();
    wait(0.5);
end;

function u1.PlayClient(u11) -- Line: 58
    -- upvalues: RunService (copy)
    if u11._is_humanoid then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://82538222745985";
        local success, result = pcall(u11._subject.LoadAnimation, u11._subject, Animation);

        if success then
            result:Play(0);
        end;
    end;

    local v12 = script.Hole:Clone();
    v12.Parent = workspace;
    table.insert(u11._destroy_these, v12);
    local v13 = u11:_GetObjects(true);
    table.insert(v13, v12);
    u11:CreateSound("rbxassetid://93213527475361", 1, 1, nil, true, 5);
    u11:_InternalThread(task.defer, function() -- Line: 80
        -- upvalues: u11 (copy)
        wait(2.4499999999999997);
        u11:CreateSound("rbxassetid://128064423147007", 1, 0.875, nil, true, 5);
        wait(0.6);
        u11:CreateSound("rbxassetid://128064423147007", 0.375, 1.5, nil, true, 5);
    end);
    local Position = (u11._is_humanoid and u11._subject.RootPart or u11._subject).Position;
    local v14 = tick();

    while tick() < v14 + 2.55 + 0.25 + 0.5 do
        local v15;

        if tick() < v14 + 2.55 + 0.25 then
            local v16 = (tick() - v14) / 2.55;
            v15 = math.clamp(v16, 0, 1);
        else
            local v17 = (tick() - v14 - 2.55 - 0.25) / 0.5;
            v15 = math.clamp(v17, 0, 1);
        end;

        local v18;

        if tick() < v14 + 2.55 + 0.25 then
            v18 = v15 < 0.5 and v15 ^ 5 * 16 or 1 - (v15 * -2 + 2) ^ 5 / 2;
        else
            v18 = 1 - v15 ^ 5;
        end;

        v12.Size = (Vector3.new(0, 0, 0)):Lerp(Vector3.new(0.5, 12, 12), v18);
        v12.CFrame = CFrame.new(u11:_GetGroundPosition(Position, v13)) * CFrame.Angles(0, 0, 1.5707963267948966);
        RunService.RenderStepped:Wait();
    end;

    v12:Destroy();
end;

function u1._Init(p19) -- Line: 108
end;

return u1;